Return-Path: <linux-fsdevel+bounces-15517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C288FDC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545AB1F27635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDAD7E0F3;
	Thu, 28 Mar 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwBZUIWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B189651A1;
	Thu, 28 Mar 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624117; cv=none; b=mZq5nQqSd5emAFkG8nI7mDOc2yao8/2zOYE9r5iFTCfhgmCz+83cFDCwvbeXpbwPo+XU9oaDvDTFTeVc5YPZmHifTK3HT+gBxlaEcOtxb3LJgjYvgApzHIYP0oTkj7+PB33I4GHR8XpAS9+Dt6ebD6GNCTkG+DTs2YOYdDH0KKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624117; c=relaxed/simple;
	bh=W8rjrD7Btmne8moGwzQxQpMrc2o8aOPxid/YQsai9Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7bL+7gWuATmVTwZnNJNpdIpxwrreBVeBnRf4mvA/EyZ01Kvtpw4qcWqHvInpH0YdyFystWLXeVRw/5MpSTNd0nEDRti+ei98a9UjYNPOyi2XoR0zcNYFCjATYZhDTNCaOqQ7vj2s8WtblQPEpSEwVKuEgPjRQF32As2p/S5s/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwBZUIWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AC4C433F1;
	Thu, 28 Mar 2024 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711624117;
	bh=W8rjrD7Btmne8moGwzQxQpMrc2o8aOPxid/YQsai9Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwBZUIWX0HFIq68joUOA1btWoHTQ9PVTNAMoUQO+CZq9WHL6JbHI7eKQwZ7a0YzR4
	 60t/NUND1FP7zoM+hemJKci5oeDkFEPxT5ujao9xd23jOS2PhPiE/F6LpyyJlQ0a6p
	 axkHPPARRXmpx72Xsv19zoMocjI1uTeuOnPEbNeslwn6Die9j0UHgOjWKARNTTy3oF
	 yio/m4dCV1FtJ88kfBIHk2YLh7urVeWUAjQBIF7AkRhVa/1mk30dWaAvgnD0TkR7QW
	 JoCP9bXPpIvzUoQRYWLV53azoXTacPYkCzMUgflIVGA74SVeWSUWmEfazF2Vwa6j56
	 QowjaYb5MbPgQ==
Date: Thu, 28 Mar 2024 12:08:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>, 
	Paul Moore <paul@paul-moore.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240328-raushalten-krass-cb040068bde9@brauner>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
 <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>

On Thu, Mar 28, 2024 at 12:53:40PM +0200, Roberto Sassu wrote:
> On 3/26/2024 12:40 PM, Christian Brauner wrote:
> > > we can change the parameter of security_path_post_mknod() from
> > > dentry to inode?
> > 
> > If all current callers only operate on the inode then it seems the best
> > to only pass the inode. If there's some reason someone later needs a
> > dentry the hook can always be changed.
> 
> Ok, so the crash is likely caused by:
> 
> void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry
> *dentry)
> {
>         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> 
> I guess we can also simply check if there is an inode attached to the
> dentry, to minimize the changes. I can do both.
> 
> More technical question, do I need to do extra checks on the dentry before
> calling security_path_post_mknod()?

Why do you need the dentry? The two users I see are ima in [1] and evm in [2].
Both of them don't care about the dentry. They only care about the
inode. So why is that hook not just:

diff --git a/security/security.c b/security/security.c
index 7e118858b545..025689a7e912 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1799,11 +1799,11 @@ EXPORT_SYMBOL(security_path_mknod);
  *
  * Update inode security field after a file has been created.
  */
-void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
+void security_inode_post_mknod(struct mnt_idmap *idmap, struct inode *inode)
 {
-       if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+       if (unlikely(IS_PRIVATE(inode)))
                return;
-       call_void_hook(path_post_mknod, idmap, dentry);
+       call_void_hook(path_post_mknod, idmap, inode);
 }

 /**

And one another thing I'd like to point out is that the security hook is
called "security_path_post_mknod()" while the evm and ima hooks are
called evm_post_path_mknod() and ima_post_path_mknod() respectively. In
other words:

git grep _path_post_mknod() doesn't show the implementers of that hook
which is rather unfortunate. It would be better if the pattern were:

<specific LSM>_$some_$ordered_$words()

[1]:
static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
{
        struct inode *inode = d_backing_inode(dentry);
        struct evm_iint_cache *iint = evm_iint_inode(inode);

        if (!S_ISREG(inode->i_mode))
                return;

        if (iint)
                iint->flags |= EVM_NEW_FILE;
}

[2]:
static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
{
        struct ima_iint_cache *iint;
        struct inode *inode = dentry->d_inode;
        int must_appraise;

        if (!ima_policy_flag || !S_ISREG(inode->i_mode))
                return;

        must_appraise = ima_must_appraise(idmap, inode, MAY_ACCESS,
                                          FILE_CHECK);
        if (!must_appraise)
                return;

        /* Nothing to do if we can't allocate memory */
        iint = ima_inode_get(inode);
        if (!iint)
                return;

        /* needed for re-opening empty files */
        iint->flags |= IMA_NEW_FILE;
}



> 
> Thanks
> 
> Roberto
> 
> > For bigger changes it's also worthwhile if the object that's passed down
> > into the hook-based LSM layer is as specific as possible. If someone
> > does a change that affects lifetime rules of mounts then any hook that
> > takes a struct path argument that's unused means going through each LSM
> > that implements the hook only to find out it's not actually used.
> > Similar for dentry vs inode imho.
> 

