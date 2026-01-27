Return-Path: <linux-fsdevel+bounces-75667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFLBC1dLeWmXwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:33:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14B9B6C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07BC630055EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CF72DF13E;
	Tue, 27 Jan 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5FPFfyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A40284689;
	Tue, 27 Jan 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556818; cv=none; b=A4NQJiFR9QptZ86PQvDgyEKzT3JnuqsnQwmFLt30K9CVkUgSZJm8vAnzjGLzhZZclAB6Sn8dYx1Bp18HOc7peE+PM4yyiM4sqD6l+V0cVm4TPYGtc8dnyhg2fIV0S1yeuMdwScHvcFlez3gURZmxYd6vNh9u4HqBNuxhnqR3ECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556818; c=relaxed/simple;
	bh=STgkijcigGlMrJsij4S3qXbKeizuWURck/hf+kHmMX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMG5z5F1CcX6mOOcAS/ybqWba1PKUW5+L6zAhVwlRmz0Q6fNL3LvmiFL28LuLD9e3hdmvMCFvq2oECQGH9d2cbft7O+emMPJ/KwuKXdPOm92IfcMpG8Hla5ys+NbE50PhnkLx60Bs0crajEGahz+sagEczJSdz1/JQMWkNpTR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5FPFfyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20577C116C6;
	Tue, 27 Jan 2026 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769556818;
	bh=STgkijcigGlMrJsij4S3qXbKeizuWURck/hf+kHmMX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5FPFfyI66KqhE3+dDxNMiBReccL7OctdNiVrWZB9H4Y7Jhh7Q6hJKeIGbSHBqmNo
	 dxgba6l7JXeIPbBTZs8sQIaccVA9PwLDyU4D7OivyjeppoE4XIkQ/or6pr2ltSueXN
	 nnRyfY6M8dlx06lyMZgBx3xS/LDyW19s8LnC3uLseuXRJiKA5mwCZVwPVhNYBZsoHq
	 1bonx30pSqdzbNuXF6gyEO3ykriPsOQN6gRM4j8eQWxkAleVQfFx38FJmslxmqT1g1
	 qXIWhxVXRmrtugd7tdNzMYxClp+Ih4sFbNwDHbAsT9VuKsD1tyZnfZ26lSNkhQh/Pr
	 ZIarzQrdyhKJQ==
Date: Tue, 27 Jan 2026 15:33:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/31] fuse: create a per-inode flag for toggling iomap
Message-ID: <20260127233337.GH5900@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
 <CAJnrk1ZDeYytdjuCdg6-O-PGjcmwS33LOnfFT_YY9SPE=x=Qxw@mail.gmail.com>
 <20260122222233.GA5900@frogsfrogsfrogs>
 <CAJnrk1ZYp=+ho02gMAPGLsGBo3a84ScuE92xP68=1SR-ixAs+g@mail.gmail.com>
 <20260124165430.GT5966@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124165430.GT5966@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75667-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B14B9B6C7
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 08:54:30AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 23, 2026 at 10:05:32AM -0800, Joanne Koong wrote:
> > On Thu, Jan 22, 2026 at 2:22 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Wed, Jan 21, 2026 at 05:13:39PM -0800, Joanne Koong wrote:
> > > > On Tue, Oct 28, 2025 at 5:46 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > Create a per-inode flag to control whether or not this inode actually
> > > > > uses iomap.  This is required for non-regular files because iomap
> > > > > doesn't apply there; and enables fuse filesystems to provide some
> > > > > non-iomap files if desired.
> > > > >
> > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > >
> > > > The logic in this makes sense to me, left just a few comments below.
> > > >
> > > > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > >
> > > Thanks!
> > >
> > > > > ---
> > > > >  fs/fuse/fuse_i.h          |   17 ++++++++++++++++
> > > > >  include/uapi/linux/fuse.h |    3 +++
> > > > >  fs/fuse/file.c            |    1 +
> > > > >  fs/fuse/file_iomap.c      |   49 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  fs/fuse/inode.c           |   26 ++++++++++++++++++------
> > > > >  5 files changed, 90 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > index f1ef77a0be05bb..42c85c19f3b13b 100644
> > > > > --- a/fs/fuse/file.c
> > > > > +++ b/fs/fuse/file.c
> > > > > +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
> > > > > +{
> > > > > +       struct fuse_conn *conn = get_fuse_conn(inode);
> > > > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > > > +
> > > > > +       ASSERT(S_ISREG(inode->i_mode));
> > > > > +
> > > > > +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
> > > > > +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> > > > > +               fuse_inode_set_iomap(inode);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +void fuse_iomap_evict_inode(struct inode *inode)
> > > > > +{
> > > > > +       struct fuse_conn *conn = get_fuse_conn(inode);
> > > > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > > > +
> > > > > +       if (fuse_inode_has_iomap(inode))
> > > >
> > > > If I'm understanding this correctly, a fuse inode can't have
> > > > FUSE_I_IOMAP set on it if conn>iomap is not enabled, correct?
> > >
> > > Correct.
> > >
> > > > Maybe it makes sense to just return if (!conn->iomap) at the very
> > > > beginning, to make that more clear?
> > >
> > > <shrug> fuse_inode_has_iomap only checks FUSE_I_IOMAP...
> > >
> > > > > +               fuse_inode_clear_iomap(inode);
> > > > > +       if (conn->iomap && fuse_inode_is_exclusive(inode))
> > > > > +               clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
> > >
> > > ...but I wasn't going to assume that iomap is the only way that
> > > FUSE_I_EXCLUSIVE could get set.
> > >
> > > On the other hand, for non-regular files we set FUSE_I_EXCLUSIVE only if
> > > conn->iomap is nonzero *and* attr->flags contains FUSE_ATTR_IOMAP.  So
> > > this clearing code isn't quite the same as the setting code.
> > >
> > > I wonder if that means we should set FUSE_I_IOMAP for non-regular files?
> > > They don't use iomap itself, but I suppose it would be neat if "iomap
> > > directories" also meant that timestamps and whatnot worked in the same
> > > as they do for regular files.
> > >
> > 
> > That seems like a good idea to me. I think that also makes the mental
> > model (at least for me) simpler.
> 
> I tried that, and generic/476 immediately broke.  I'll get back to that
> next week, but turning it on unconditionally is not trivial
> unfortunately. :/

I've tentatively fixed this by defining a FUSE_ATTR_EXCLUSIVE flag in
the uapi so that the fuse server can tell the kernel which files are
"exclusive" files, and hence which ones should have FUSE_I_EXCLUSIVE
set.

(These are ofc files where the kernel can transmogrify ACLs into i_mode
changes and do ACL inheritance because there is no other principal that
could be writing to the ondisk metadata.)

--D

> --D
> 
> > Thanks,
> > Joanne
> 

