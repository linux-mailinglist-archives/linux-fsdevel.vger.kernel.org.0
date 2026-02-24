Return-Path: <linux-fsdevel+bounces-78230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNbbH49tnWk9QAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:21:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F393918476A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E511B3087685
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CB36BCED;
	Tue, 24 Feb 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d33MvPat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DB36B05C;
	Tue, 24 Feb 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924854; cv=none; b=anxpV3M16Ykh8djxUbvR7USPr80VrFiqF/3ktXc+ndKijX1ebgGeRp0IiLAiU2MaAsBn3gWhoCuPJPQTriRbfuhbq5zrXqyC/QKXffiaIy2p4hHBD744o44yBCCBDhIsM9JQH+HNcuMvvnDadSQ6KDM6adgPMeApIY1MubZW99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924854; c=relaxed/simple;
	bh=zQsck/PbdutrfjuyGfWsZrSGCznNVHiinSu2WQcwhXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUlHm2UqmPRIGoPnjlvQb0GhPbYirJt677h9/a20VDdnvOS7zWc5xGdc+osxAyGSKHU+rF6XVJU6qCQfcNawb5UUEtyy0lWs56V5kgkuoAWGTkimCmapEt6eBscPVqakFri6twkSO5IZWIdCWOlkbf3GUfzL5JlqdGZUxDWZK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d33MvPat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC04C116D0;
	Tue, 24 Feb 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771924853;
	bh=zQsck/PbdutrfjuyGfWsZrSGCznNVHiinSu2WQcwhXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d33MvPatWU9dWg+Iyd8o/6Y/ldYwKOH8cRg0Twmt0370/HtNEBoWP3z5uOe6wmFXJ
	 YM9ycD9PQCBY6f2pUjrO96/u5KF7xm8ivKI2Fh9vCGLwg5th0xGGx+/N3bPn616+er
	 dlPZiqPuHcSGvxYT6sAfWt7q6WkwtO/P0RFeZQS+YU296u3wkl+HM6Pc0aQp5zvzEE
	 X6nxMKN1zyPs4ALdzch6DfnAy/FTnYRsMnHX+NVzC9EriWNJBe5KoE1zL64sE0Qrsj
	 no9HXBs4Wj5/XGONNbVLX4l0ye+IcMDVik2w/nSZhnQyRG+ywegsYDlZMV36f9l8VM
	 i7cfOC2T30jgw==
Date: Tue, 24 Feb 2026 10:20:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 12/15] ovl: change ovl_create_real() to get a new lock
 when re-opening created file.
Message-ID: <20260224-granulat-joggen-cd082d178959@brauner>
References: <20260223011210.3853517-1-neilb@ownmail.net>
 <20260223011210.3853517-13-neilb@ownmail.net>
 <20260223132424.105125-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223132424.105125-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78230-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[brown.name,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: F393918476A
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:23:00AM -0800, Chris Mason wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > When ovl_create_real() is used to create a file on the upper filesystem
> > it needs to return the resulting dentry - positive and hashed.
> > It is usually the case the that dentry passed to the create function
> > (e.g.  vfs_create()) will be suitable but this is not guaranteed.  The
> > filesystem may unhash that dentry forcing a repeat lookup next time the
> > name is wanted.
> > 
> 
> Hi everyone,
> 
> Amir suggested I run these through, and this commit was flagged:
> 
> commit 62d49d1e44667e4f93bec415faabec5526992ac0
> Author: NeilBrown <neil@brown.name>
> 
> ovl: change ovl_create_real() to get a new lock when re-opening created file.
> 
> This commit changes ovl_create_real() to drop the directory lock and
> reacquire a new lock for lookup when the created dentry is unhashed. It
> also removes ovl_lookup_upper() which is no longer used.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Fwiw, all patches that are applied go through AI review. My plan is to
have a discussion on getting automation set up for this at LSFMM so that
we can have the bot directly reply to reviews but under our control so
we can vet reviews.

