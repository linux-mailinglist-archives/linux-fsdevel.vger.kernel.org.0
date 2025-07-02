Return-Path: <linux-fsdevel+bounces-53595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD35CAF0B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715B57A238D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 06:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685F219A7E;
	Wed,  2 Jul 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LpA8JIrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AB1F8733;
	Wed,  2 Jul 2025 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436525; cv=none; b=R+MNe46x7uvt8vgb/4I2FnF+Orm57UBV3wWVJOE+Oos5WtwadmXfPuJM28HFkuarny+pe33s6Dh0usYKmbegcKzDDqG3MLCHQDvfC8PmP1BuPWGuMpKkpknqmUXW/EclrhL4FoEGAbCo1YzOLTEMnMpd/beCUcc6odXrg16rVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436525; c=relaxed/simple;
	bh=Av1Oiy/xN0m8B+/PemSUH/jn3tcD8byDJ6A5jomGNlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLqvA63gVG2FJH4ZcatjgT5uNUbuDr6d+eMzflmN9gmsAmhameRc3/gA6HHAHYwtFTyUZdvPYJP+PlerbuCLacv9xLGLh4imyv5PfeeYEMXDKm+uG5MYmQVFO+e8WorsiJyuPM9C3mCilaT1nhe4e3G9JcpwJQIGEy5qr3ZyHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LpA8JIrQ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751436512; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sMvhXIyNxqo7UGxmugSbsWYEXKpzsVkdC7WrW9hFCPQ=;
	b=LpA8JIrQAz9iLlpc6Ue4Ue81zK1QQMvHzesh0taj6iuek9TGd0d6OaNuGqYplntopvxdT4Jjc+0ODaeVgeYete4Jkz2F3iXSHI2K8VaqF10RVAZa3vtfHGKEtVhQjdCXuQLAwynPIqpMx4Ae50tAlw/5zWOLTK+qk/XsMDANyg0=
Received: from 30.221.128.110(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WgZlKp0_1751436511 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 14:08:32 +0800
Message-ID: <881f7b6d-c9c3-4529-9256-b812d2e5380a@linux.alibaba.com>
Date: Wed, 2 Jul 2025 14:08:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ocfs2: update d_splice_alias() return code checking
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Richard Weinberger <richard@nod.at>,
 ocfs2-devel@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <d689279f-03ed-4f9b-8fde-713b2431f303@I-love.SAKURA.ne.jp>
 <20250626033411.GU1880847@ZenIV>
 <d84dc916-2982-45dc-a9a5-a6255cbc62bd@I-love.SAKURA.ne.jp>
 <973af6b9-e4c7-4519-99af-9c82dc6ca98f@linux.alibaba.com>
 <da5be67d-2a0b-4b93-85d6-42f3b7440135@I-love.SAKURA.ne.jp>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <da5be67d-2a0b-4b93-85d6-42f3b7440135@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/6/30 18:21, Tetsuo Handa wrote:
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

Looks fine to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/namei.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 99278c8f0e24..721580dfce3a 100644
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
> @@ -154,15 +156,16 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
>  		 * NOTE: This dentry already has ->d_op set from
>  		 * ocfs2_get_parent() and ocfs2_get_dentry()
>  		 */
> -		if (!IS_ERR_OR_NULL(ret))
> +		if (ret)
>  			dentry = ret;
>  
>  		status = ocfs2_dentry_attach_lock(dentry, inode,
>  						  OCFS2_I(dir)->ip_blkno);
>  		if (status) {
>  			mlog_errno(status);
> +			if (ret)
> +				dput(ret);
>  			ret = ERR_PTR(status);
> -			goto bail_unlock;
>  		}
>  	} else
>  		ocfs2_dentry_attach_gen(dentry);


