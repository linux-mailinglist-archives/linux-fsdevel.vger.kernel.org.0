Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0194B35A003
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhDINjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 9 Apr 2021 09:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhDINjk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BEBBB0B7;
        Fri,  9 Apr 2021 13:39:25 +0000 (UTC)
Received: from localhost (orpheus.olymp [local])
        by orpheus.olymp (OpenSMTPD) with ESMTPA id 56fed213;
        Fri, 9 Apr 2021 14:39:21 +0100 (WEST)
From:   Luis Henriques <lhenriques@suse.de>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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
Date:   Fri, 09 Apr 2021 14:39:20 +0100
In-Reply-To: <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
        (Nicolas Boichat's message of "Fri, 9 Apr 2021 13:23:23 +0800")
Message-ID: <8735vzfugn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nicolas Boichat <drinkcat@chromium.org> writes:

> On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>>
>> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote:
>> >
>> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
>> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
>> > > >
>> > > > A regression has been reported by Nicolas Boichat, found while using the
>> > > > copy_file_range syscall to copy a tracefs file.  Before commit
>> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>> > > > kernel would return -EXDEV to userspace when trying to copy a file across
>> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
>> > > > and instead returns zero (zero bytes copied), as this file's content is
>> > > > generated on-the-fly and thus reports a size of zero.
>> > > >
>> > > > This patch restores some cross-filesystem copy restrictions that existed
>> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>> > > > devices").  Filesystems are still allowed to fall-back to the VFS
>> > > > generic_copy_file_range() implementation, but that has now to be done
>> > > > explicitly.
>> > > >
>> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
>> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>> > > >
>> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
>> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
>> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
>> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
>> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> > >
>> > > I tested v8 and I believe it works for NFS.
>> >
>> > Thanks a lot for the testing.  And to everyone else for reviews,
>> > feedback,... and patience.
>>
>> Thanks so much to you!!!
>>
>> Works here, you can add my
>> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>
> What happened to this patch? It does not seem to have been picked up
> yet? Any reason why?

Hmm... good question.  I'm not actually sure who would be picking it.  Al,
maybe...?

Cheers,
-- 
Luis

>
>> >
>> > I'll now go look into the manpage and see what needs to be changed.
>> >
>> > Cheers,
>> > --
>> > Luís

