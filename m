Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40D31EA24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhBRM6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:41568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhBRMPP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:15:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 121FCACE5;
        Thu, 18 Feb 2021 12:14:06 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id e471242a;
        Thu, 18 Feb 2021 12:15:08 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
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
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
        <20210215154317.8590-1-lhenriques@suse.de>
        <20210218074207.GA329605@infradead.org>
        <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
        <87v9apis97.fsf@suse.de>
Date:   Thu, 18 Feb 2021 12:15:08 +0000
In-Reply-To: <87v9apis97.fsf@suse.de> (Luis Henriques's message of "Thu, 18
        Feb 2021 10:29:08 +0000")
Message-ID: <87mtw1incj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> writes:

> Amir Goldstein <amir73il@gmail.com> writes:
>
>> On Thu, Feb 18, 2021 at 9:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> Looks good:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> This whole idea of cross-device copie has always been a horrible idea,
>>> and I've been arguing against it since the patches were posted.
>>
>> Ok. I'm good with this v2 as well, but need to add the fallback to
>> do_splice_direct()
>> in nfsd_copy_file_range(), because this patch breaks it.
>>
>> And the commit message of v3 is better in describing the reported issue.
>
> Except that, as I said in a previous email, v2 doesn't really fix the
> issue: all the checks need to be done earlier in generic_copy_file_checks().
>
> I'll work on getting v4, based on v2 and but moving the checks and
> implementing your review suggestions to v3 (plus this nfs change).

There's something else:

The filesystems (nfs, ceph, cifs, fuse) rely on the fallback to
generic_copy_file_range() if something's wrong.  And this "something's
wrong" is fs specific.  For example: in ceph it is possible to offload the
file copy to the OSDs even if the files are in different filesystems as
long as these filesystems are on the *same* ceph cluster.  If the copy
being done is across two different clusters, then the copy reverts to
splice.  This means that the boilerplate code being removed in v2 of this
patch needs to be restored and replace by:

	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
				     len, flags);

	if (ret == -EOPNOTSUPP || ret == -EXDEV)
		ret = do_splice_direct(src_file, &src_off, dst_file, &dst_off,
				       len > MAX_RW_COUNT ? MAX_RW_COUNT : len,
				       flags);
	return ret;

A quick look at the other filesystems code indicate similar patterns.
Since at this point we've gone through all the syscall checks already,
calling do_splice_direct() shouldn't be a huge change.  But I may be
missing something.  Again.  Which is quite likely :-)

Cheers,
-- 
Luis
