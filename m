Return-Path: <linux-fsdevel+bounces-3118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59667F011E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDFD1C20906
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3819478;
	Sat, 18 Nov 2023 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SvkGV/ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78BBC5
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDOXa70xfwJLAjXc22jM86hB6FxAhRm2Vpp+9Az3n3M=; b=SvkGV/kaMiGVLZYXDX5ucqFFWb
	K0yjs/a4ieZ79SkQPxk5VPfWbOblJHMNUsXwFjtb2Aymfsfg9PKbY3p/j4+L44pIf5l6bzTz+dKNb
	SLJyMluHuDXhold5Ld1neCN03Qiiea3UlKttCF4RSqPkpfireEDwaCknfHtwpa+MxOKAKaCfcg/jh
	tO6VmAvyiaY58Tyn+qfdEQzKhfRLxn2qIYFLwmBdomf8pnr/SntadGuwSSU3i2insjOpqpnOV9qRE
	ucKETL2lUHFOcNoqouxGh/jEzB7+mEOH+Gt2hR2MWFPLiHcDzbk2mCG4vdOCXPWeq1DGed5iVENDE
	c/TLRQQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r4OBS-00HVCA-0A;
	Sat, 18 Nov 2023 16:28:38 +0000
Date: Sat, 18 Nov 2023 16:28:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <cel@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
	jlayton@redhat.com, Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231118162838.GE1957730@ZenIV>
References: <170007970281.4975.12356401645395490640.stgit@bazille.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170007970281.4975.12356401645395490640.stgit@bazille.1015granger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 15, 2023 at 03:22:52PM -0500, Chuck Lever wrote:

>  static int offset_readdir(struct file *file, struct dir_context *ctx)
>  {
> +	struct dentry *cursor = file->private_data;
>  	struct dentry *dir = file->f_path.dentry;
>  
>  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> @@ -479,11 +481,19 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	offset_iterate_dir(d_inode(dir), ctx);
> +	if (ctx->pos == 2)
> +		cursor->d_flags &= ~DCACHE_EOD;
> +	else if (cursor->d_flags & DCACHE_EOD)
> +		return 0;
> +
> +	if (offset_iterate_dir(d_inode(dir), ctx))
> +		cursor->d_flags |= DCACHE_EOD;

This is simply grotesque - "it's better to keep ->private_data constant,
so we will allocate a dentry, just to store the one bit of data we need to
keep track of; oh, and let's grab a bit out of ->d_flags, while we are at it;
we will ignore the usual locking rules for ->d_flags modifications, 'cause
it's all serialized on ->f_pos_lock".

No.  If nothing else, this is harder to follow than the original.  It's
far easier to verify that these struct file instances only use ->private_data
as a flag and these accesses are serialized on ->f_pos_lock as claimed
than go through the accesses to ->d_flags, prove that the one above is
the only one that can happen to such dentries (while they are live, that
is - once they are in __dentry_kill(), there will be modifications of ->d_flags)
and that it can't happen to any other instances.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

