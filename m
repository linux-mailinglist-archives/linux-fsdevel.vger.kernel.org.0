Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2731ED14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhBRRO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:14:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhBRQfP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:35:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E67F5ACF6;
        Thu, 18 Feb 2021 16:34:33 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id edd07b5a;
        Thu, 18 Feb 2021 16:35:36 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5] vfs: fix copy_file_range regression in cross-fs copies
References: <CAOQ4uxj=ZeJ0HYtivP=pg5mSDaiQGU8Fz8qw0Egfa2Ert5Ra7A@mail.gmail.com>
        <20210218151752.26710-1-lhenriques@suse.de>
        <CAOQ4uxgO45cqKLRsXBxn04fVkqH483G3ngCtV_gZGHMQDFixig@mail.gmail.com>
Date:   Thu, 18 Feb 2021 16:35:36 +0000
In-Reply-To: <CAOQ4uxgO45cqKLRsXBxn04fVkqH483G3ngCtV_gZGHMQDFixig@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 18 Feb 2021 17:53:33 +0200")
Message-ID: <87blchibaf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Feb 18, 2021 at 5:16 PM Luis Henriques <lhenriques@suse.de> wrote:
>>
>> A regression has been reported by Nicolas Boichat, found while using the
>> copy_file_range syscall to copy a tracefs file.  Before commit
>> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
>> kernel would return -EXDEV to userspace when trying to copy a file across
>> different filesystems.  After this commit, the syscall doesn't fail anymore
>> and instead returns zero (zero bytes copied), as this file's content is
>> generated on-the-fly and thus reports a size of zero.
>>
>> This patch restores some cross-filesystem copy restrictions that existed
>> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
>> devices").  Filesystems are still allowed to fall-back to the VFS
>> generic_copy_file_range() implementation, but that has now to be done
>> explicitly.
>>
>> nfsd is also modified to fall-back into generic_copy_file_range() in case
>> vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
>>
>> Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
>> Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
>> Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
>> Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
>> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>> And v5!  Sorry.  Sure, it makes sense to go through the all the vfs_cfr()
>> checks first.
>
> You missed my other comment on v4...
>
> not checking NULL copy_file_range case.

Ah, yeah I did missed it.  I'll follow up with yet another revision.

Cheers,
-- 
Luis
