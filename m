Return-Path: <linux-fsdevel+bounces-53241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9ECAED249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 03:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C31891C6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFD17A300;
	Mon, 30 Jun 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SM/ax1Td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B22F1FE2;
	Mon, 30 Jun 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751248723; cv=none; b=YvwDGgGMvNkKqyce/xgM6SaKuxbQdPqEEWJ7IG8+alAgzj8hsi+HSAO7zpM8w9meHG6oMr7/PEl0ljCB+WqirJ8Q9z5BCYVo9MsHJu1B+NAWzybZaM5+qHdKyFPeEFaCLOtWhetjzNrHpQQdz6tAyIDXJlPbokl7B4+ka64ny/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751248723; c=relaxed/simple;
	bh=ipNudjZuaN78dETBvDLyPqgHY3Qq8KaC1c8HerEARlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=No8VQxBIcQFCtBRNyj0tGzRGqHS+eVBUrQQGcyedHLIs2YDAqnGPDnzuA3itXMfnFSZR0zBt+rGCFpCvAIPaQQ+9g4RUfLWWgnF+76nz7k6Cw4MfzmZ5iJ5UbH834QSHaTFFKptCcnZOmYgqbaUNkaemIX3GcuroI7KHwbGB5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SM/ax1Td; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751248712; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0n89m+x+tT3wRfAO0hO9F9i/jJOfi8f150a3KwM5478=;
	b=SM/ax1Td4bMkN/qLFfRuCV0PH2jtohXXdKDokYg5JgNxGnPAKJpFpAUKURebt8snuksAonb6cJs2ZoAIRx2QelY24QxvLEtzS9OqBsaWjGdzHKxfJaxYRBemG9Uc7soYxKmjSDqne9jAnrOttrZ/nduYJFh86MhLPf05Ekb4aN4=
Received: from 30.221.128.206(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wg2pBvd_1751248711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 09:58:31 +0800
Message-ID: <973af6b9-e4c7-4519-99af-9c82dc6ca98f@linux.alibaba.com>
Date: Mon, 30 Jun 2025 09:58:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: update d_splice_alias() return code checking
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Al Viro <viro@zeniv.linux.org.uk>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Richard Weinberger <richard@nod.at>,
 ocfs2-devel@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <d689279f-03ed-4f9b-8fde-713b2431f303@I-love.SAKURA.ne.jp>
 <20250626033411.GU1880847@ZenIV>
 <d84dc916-2982-45dc-a9a5-a6255cbc62bd@I-love.SAKURA.ne.jp>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <d84dc916-2982-45dc-a9a5-a6255cbc62bd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/6/27 22:19, Tetsuo Handa wrote:
> When commit d3556babd7fa ("ocfs2: fix d_splice_alias() return code
> checking") was merged into v3.18-rc3, d_splice_alias() was returning
> one of a valid dentry, NULL or an ERR_PTR.
> 
> When commit b5ae6b15bd73 ("merge d_materialise_unique() into
> d_splice_alias()") was merged into v3.19-rc1, d_splice_alias() started
> returning -ELOOP as one of ERR_PTR values.
> 
> Now, when syzkaller mounts a crafted ocfs2 filesystem image that hits
> d_splice_alias() == -ELOOP case from ocfs2_lookup(), ocfs2_lookup() fails
> to handle -ELOOP case and generic_shutdown_super() hits "VFS: Busy inodes
> after unmount" message.
> 
> Instead of calling ocfs2_dentry_attach_lock() or ocfs2_dentry_attach_gen()
> when d_splice_alias() returned an ERR_PTR value, change ocfs2_lookup() to
> bail out immediately.
> 
> Also, ocfs2_lookup() needs to call dupt() when ocfs2_dentry_attach_lock()
> returned an ERR_PTR value.
> 
> Reported-by: syzbot <syzbot+1134d3a5b062e9665a7a@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=1134d3a5b062e9665a7a
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/ocfs2/namei.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 99278c8f0e24..f75fd19974bc 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -142,6 +142,8 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
>  
>  bail_add:
>  	ret = d_splice_alias(inode, dentry);
> +	if (IS_ERR(ret))
> +		goto bail_unlock;
>  
>  	if (inode) {
>  		/*
> @@ -154,13 +156,12 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
>  		 * NOTE: This dentry already has ->d_op set from
>  		 * ocfs2_get_parent() and ocfs2_get_dentry()
>  		 */
> -		if (!IS_ERR_OR_NULL(ret))
> -			dentry = ret;
> -

I'd like change this to:
if (ret)
	dentry = ret;

Instead of using "ret ? ret : dentry" below calling ocfs2_dentry_attach_lock().

> -		status = ocfs2_dentry_attach_lock(dentry, inode,
> +		status = ocfs2_dentry_attach_lock(ret ? ret : dentry, inode,
>  						  OCFS2_I(dir)->ip_blkno);
>  		if (status) {
>  			mlog_errno(status);
> +			if (ret)
> +				dput(ret);
>  			ret = ERR_PTR(status);
>  			goto bail_unlock;

The "goto" here can be eliminated since it has no real effect.

Thanks,
Joseph

>  		}


