Return-Path: <linux-fsdevel+bounces-29043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB198973DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D3C1C25469
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AB71A2574;
	Tue, 10 Sep 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z248HaPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC121A2569
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987384; cv=none; b=VUJxRaasdorID8K6gDkP2pur+BhyqPzNBclQ+fFH/5ZGWPBFY0OXHjss4mIJjnEpxXljzgGTRoRxbMEY4tPeI9eaBHGKAe/3cN6ZV53D2VCxiAJcSgPYVQhNwlg/oWTDZxpzebtoognMPQhpuc+wK7TXlCyaUakZ1RTht+CKMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987384; c=relaxed/simple;
	bh=L09NIYlymgHIhBKX47vqkhRh0ESdEFBmGz05H+q6cf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYgI8j1rMcyVr4SAxTU13UdB7SDAYON2GXAmH0HUfvCa1kjd5C67EVXWKnEYH+SclDxGl61tegpRU+m2jHbrhyxjhtstTe6gAj06ZV+17D+Rg7eW84Tbg3L5HRgvaZ2v7tguIGnkhNFXTpha/T4aMWJfJhC/YjL7I2YGoZbMcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z248HaPP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725987381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYfNh51m9aJp0F/cwXYmbx3muB+rIcCDC9HzE+TMKqM=;
	b=Z248HaPPDQgfHPU4KWeiJygOXKgss7GTk6EJa+Dui5VxIlnOvOLq/uMu6FxjnA7yZy+8u0
	beM0Zzu7fs1LmL3cIzt0X8AeonXfi8bRSTDAjLe1/jPjEJaogcRX3UmUQiIJkmbdoaJytc
	38j1n0k/rHlawgYwAkb3+l6e2pJwdKs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-0tYePWhcOjCRg1lP2gf_0A-1; Tue,
 10 Sep 2024 12:56:20 -0400
X-MC-Unique: 0tYePWhcOjCRg1lP2gf_0A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9014F1956096;
	Tue, 10 Sep 2024 16:56:18 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D34719560AB;
	Tue, 10 Sep 2024 16:56:15 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
 trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
Date: Tue, 10 Sep 2024 12:56:13 -0400
Message-ID: <C158604C-DD07-49C9-8C7B-A9807CD71473@redhat.com>
In-Reply-To: <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
References: <20230823213352.1971009-1-aahringo@redhat.com>
 <20230823213352.1971009-2-aahringo@redhat.com>
 <B38733D3-6F54-42DF-BD5B-716F0200314F@redhat.com>
 <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10 Sep 2024, at 11:45, Jeff Layton wrote:

> On Tue, 2024-09-10 at 10:18 -0400, Benjamin Coddington wrote:
>> On 23 Aug 2023, at 17:33, Alexander Aring wrote:
>>
>>> This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
>>> on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
>>> export flag to signal that the "own ->lock" implementation supports
>>> async lock requests. The only main user is DLM that is used by GFS2 and
>>> OCFS2 filesystem. Those implement their own lock() implementation and
>>> return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
>>> ("nfs: block notification on fs with its own ->lock") the DLM
>>> implementation were never updated. This patch should prepare for DLM
>>> to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
>>> plock implementation regarding to it.
>>>
>>> Acked-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Alexander Aring <aahringo@redhat.com>
>>> ---
>>>  fs/lockd/svclock.c       |  5 ++---
>>>  fs/nfsd/nfs4state.c      | 13 ++++++++++---
>>>  include/linux/exportfs.h |  8 ++++++++
>>>  3 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
>>> index c43ccdf28ed9..6e3b230e8317 100644
>>> --- a/fs/lockd/svclock.c
>>> +++ b/fs/lockd/svclock.c
>>> @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>>>  	    struct nlm_host *host, struct nlm_lock *lock, int wait,
>>>  	    struct nlm_cookie *cookie, int reclaim)
>>>  {
>>> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>  	struct inode		*inode = nlmsvc_file_inode(file);
>>> -#endif
>>>  	struct nlm_block	*block = NULL;
>>>  	int			error;
>>>  	int			mode;
>>> @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>>>  				(long long)lock->fl.fl_end,
>>>  				wait);
>>>
>>> -	if (nlmsvc_file_file(file)->f_op->lock) {
>>> +	if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
>>> +					       nlmsvc_file_file(file)->f_op)) {
>>
>> ... but don't most filesystem use VFS' posix_lock_file(), which does the
>> right thing?  I think this patch has broken async lock callbacks for NLM for
>> all the other filesystems that just use posix_lock_file().
>>
>> Maybe I'm missing something, but why was that necessary?
>>
>
> Good catch. Yeah, I think that probably should have been an &&
> condition. IOW:
>
> 	if (nlmsvc_file_file(file)->f_op->lock &&
>             !export_op_support_safe_async_lock(inode->i_sb->s_export_op,
>

Ah Jeff, thanks for confirming - there's been a bunch of changes in there that
made me uncertain.  I can send a patch for this, I'd like to rename
export_op_support_safe_async_lock to something like fs_can_defer_lock
(suggestions) and put the test in there.

Ben


