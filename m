Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7605B3712B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 10:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhECIx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 04:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhECIx1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 04:53:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D898DB1B5;
        Mon,  3 May 2021 08:52:32 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 0af4dc88;
        Mon, 3 May 2021 08:54:02 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
References: <20210221195833.23828-1-lhenriques@suse.de>
        <20210222102456.6692-1-lhenriques@suse.de>
        <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
        <YDYpHccgM7agpdTQ@suse.de>
        <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
        <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
        <8735vzfugn.fsf@suse.de>
        <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
        <CANMq1KAOwj9dJenwF2NadQ73ytfccuPuahBJE7ak6S7XP6nCjg@mail.gmail.com>
Date:   Mon, 03 May 2021 09:54:01 +0100
In-Reply-To: <CANMq1KAOwj9dJenwF2NadQ73ytfccuPuahBJE7ak6S7XP6nCjg@mail.gmail.com>
        (Nicolas Boichat's message of "Fri, 23 Apr 2021 12:40:44 +0800")
Message-ID: <8735v4tcye.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nicolas Boichat <drinkcat@chromium.org> writes:

> On Fri, Apr 9, 2021 at 9:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Fri, Apr 9, 2021 at 4:39 PM Luis Henriques <lhenriques@suse.de> wrote:
>> >
>> > Nicolas Boichat <drinkcat@chromium.org> writes:
>> >
>> > > On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>> > >>
>> > >> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote:
>> > >> >
>> > >> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
>> > >> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
>> > >> > > >
>> > >> > > > A regression has been reported by Nicolas Boichat, found while using the
>> > >> > > > copy_file_range syscall to copy a tracefs file.  Before commit
>> > >> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>> > >> > > > kernel would return -EXDEV to userspace when trying to copy a file across
>> > >> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
>> > >> > > > and instead returns zero (zero bytes copied), as this file's content is
>> > >> > > > generated on-the-fly and thus reports a size of zero.
>> > >> > > >
>> > >> > > > This patch restores some cross-filesystem copy restrictions that existed
>> > >> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>> > >> > > > devices").  Filesystems are still allowed to fall-back to the VFS
>> > >> > > > generic_copy_file_range() implementation, but that has now to be done
>> > >> > > > explicitly.
>> > >> > > >
>> > >> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
>> > >> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>> > >> > > >
>> > >> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
>> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
>> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
>> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
>> > >> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>> > >> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> > >> > >
>> > >> > > I tested v8 and I believe it works for NFS.
>> > >> >
>> > >> > Thanks a lot for the testing.  And to everyone else for reviews,
>> > >> > feedback,... and patience.
>> > >>
>> > >> Thanks so much to you!!!
>> > >>
>> > >> Works here, you can add my
>> > >> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>> > >
>> > > What happened to this patch? It does not seem to have been picked up
>> > > yet? Any reason why?
>> >
>> > Hmm... good question.  I'm not actually sure who would be picking it.  Al,
>> > maybe...?
>> >
>>
>> Darrick,
>>
>> Would you mind taking this through your tree in case Al doesn't pick it up?
>
> Err, sorry for yet another ping... but it would be good to move
> forward with those patches ,-P

Yeah, I'm not sure what else to do, or who else to bug regarding this :-/

Cheers,
-- 
Luis
