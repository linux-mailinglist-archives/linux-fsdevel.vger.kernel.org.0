Return-Path: <linux-fsdevel+bounces-10937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40E84F4B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26DC1F24246
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2D33CC4;
	Fri,  9 Feb 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvxA785c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076822E633;
	Fri,  9 Feb 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478487; cv=none; b=q8YqVxCuiv5EghqnAX8mKoQ/hR0+Kow862xXjI73kMIhXZ/NhtHtzzDyRT2EZTS3R07XXgsvf4Y83QDKtHJ4wCsQFPvf8wVgBhbSwd6p5gX8pp7RQm53+jPALjEJsdHadHg6a6wy/1zxQzt8hy+Ar6rx92NJfZa32j0E7yRNxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478487; c=relaxed/simple;
	bh=keJoSZunvrZ+GXAJaP3/IF9X6A34iOOfDZQDf/0CIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6JnDZSdG0vENyb4U48FStfRR3B/uPQMyaNg1ttuj3HurlOHCmBkuTZTONXnMwXDj557VBNZPMdiAFBB3r2rkPFmq/ts2qianzfld8VagWgNagxdR33NtIIOiOAuZIwcah4PrhkufvY0w6fgzzBhi5gBXuINWRipj8Kp5lwMw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvxA785c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECDC433C7;
	Fri,  9 Feb 2024 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707478486;
	bh=keJoSZunvrZ+GXAJaP3/IF9X6A34iOOfDZQDf/0CIvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvxA785c9Qt6GAFTPe6EiwTpwNq478TCOeRmRpPMffrOQHjT6UHTLUCJmqkwHTe27
	 fJuVOHPocFN0/ufwUI3ugPdCM6MJZeap1i1Qw3K2talYwpNTZrKYFQ/XjYJTu4oI2t
	 v1du67njbjl5SleOUezuTGor9bRXShPKV2pQ+ZDzLl8ctXR7Bfvbrq0MxHv+VTu0Dm
	 TfGWl3eelrJgQh0XkOSGwgeuYT5FWu1FILO59d2OzxWOZB8FvwDJJP6fhEP7cUIPql
	 3M/HX2o0hUeiB55UiG+Dfc6/psrF2PPe25pDg721ySZbcG2QtDN/vjkmeaxS7IzNul
	 v+ofG73b88Zgw==
Date: Fri, 9 Feb 2024 12:34:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
Message-ID: <20240209-giert-erlenholz-b131fa85ee36@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
 <20240209-luftleer-jobangebote-6d6ab29b7191@brauner>
 <86ab971f45c2ff11dcbdeab78b4b050f07495f55.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ab971f45c2ff11dcbdeab78b4b050f07495f55.camel@huaweicloud.com>

On Fri, Feb 09, 2024 at 11:46:16AM +0100, Roberto Sassu wrote:
> On Fri, 2024-02-09 at 11:12 +0100, Christian Brauner wrote:
> > On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> > > file_post_open hook. Also, export security_file_post_open() for NFS.
> > > 
> > > Based on policy, IMA calculates the digest of the file content and
> > > extends the TPM with the digest, verifies the file's integrity based on
> > > the digest, and/or includes the file digest in the audit log.
> > > 
> > > LSMs could similarly take action depending on the file content and the
> > > access mask requested with open().
> > > 
> > > The new hook returns a value and can cause the open to be aborted.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  fs/namei.c                    |  2 ++
> > >  fs/nfsd/vfs.c                 |  6 ++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  security/security.c           | 17 +++++++++++++++++
> > >  5 files changed, 32 insertions(+)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 71c13b2990b4..fb93d3e13df6 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
> > >  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
> > >  	if (!error && !(file->f_mode & FMODE_OPENED))
> > >  		error = vfs_open(&nd->path, file);
> > > +	if (!error)
> > > +		error = security_file_post_open(file, op->acc_mode);
> > 
> > What does it do for O_CREAT? IOW, we managed to create that thing and we
> > managed to open that thing. Can security_file_post_open() and
> > ima_file_check() fail afterwards even for newly created files?
> 
> $ strace touch test-file
> ...
> openat(AT_FDCWD, "test-file", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) = -1 EPERM (Operation not permitted)

Ah, meh. I was hoping IMA just wouldn't care about this case.

