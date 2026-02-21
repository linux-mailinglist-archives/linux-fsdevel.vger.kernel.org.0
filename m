Return-Path: <linux-fsdevel+bounces-77836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKC3Flb2mGlKOgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:03:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CA16B7CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F19D3007528
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0064469D;
	Sat, 21 Feb 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTcXljw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796588F4A;
	Sat, 21 Feb 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632207; cv=none; b=VI660tmcJ/vwId0q/Zj/TfVHV14MHPlr375b0bQ/av76p+qwIqMBC19LEepxDuRqu/jTgFZ0xYLYWw+YrU1iTYGEIaORcDtdglWknYf8inUs4kC+I+3hpxoFVAMdYb7rwYK5sJqsX6yTIM9sLagbMX5Ns7zBcm6+m51nB00Da28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632207; c=relaxed/simple;
	bh=ZmGa5tIl8OA5KzSQQqrKLWKWS9mT3TwNVeOHxd0u60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kode/6dGpflGepHztproC28JxY1gWJoICl15XXk8xJOZtYI9KM99kNYVw+onF10GczGvYsRhWS00NRgPBGR6NKvKG0AXbfsxDjyDkLgxBdB5a20fi8RcpdgRctaGLuca/30pSsC2V3KWka7G129kjgdk6XFP4mltgRmD/yeVG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTcXljw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43295C116C6;
	Sat, 21 Feb 2026 00:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771632207;
	bh=ZmGa5tIl8OA5KzSQQqrKLWKWS9mT3TwNVeOHxd0u60A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTcXljw2vb7Kj9dQWNO0DAr4Fzq2ZV+nbvUzavcQDOCPQbhHsksbvN4P/mZQFiTTp
	 jxGFz/OR0+5GFzL0PTwcNdVZlGifjxqmXte5HjWO63X/t/GqESD9jDdBuUsRyb8+2v
	 C+SrYIWDq2y/C3DLPQfjDGJpx9K+nT/nlFvReuOhX3v0m4m6JuLrZtYX8jR4TmMuOG
	 OKbvv0xg5bNp47dmdtG/Jd4aNSWh9F2VXgMxZrh5G9z9MqHPf7P9kJo57rKIYe2Q1T
	 7VfnqWXai7h2I/MwJJQGGDy3wExJrV5M8KHm9+4fmdwT5DE4aMuzPGEt4b1d3CaF8M
	 N/g4IWbEgRHGQ==
Date: Fri, 20 Feb 2026 16:03:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/14] xattr: move user limits for xattrs to generic infra
Message-ID: <20260221000326.GB11076@frogsfrogsfrogs>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77836-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 064CA16B7CC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 02:32:05PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/kernfs/inode.c           | 75 ++-------------------------------------------
>  fs/kernfs/kernfs-internal.h |  3 +-
>  fs/xattr.c                  | 65 +++++++++++++++++++++++++++++++++++++++
>  include/linux/kernfs.h      |  2 --
>  include/linux/xattr.h       | 18 +++++++++++
>  5 files changed, 87 insertions(+), 76 deletions(-)
> 

I know you're just moving code around and that looks ok, but:

> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index b5a5f32fdfd1..d8f57f0af5e4 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -99,8 +99,6 @@ enum kernfs_node_type {
>  
>  #define KERNFS_TYPE_MASK		0x000f
>  #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
> -#define KERNFS_MAX_USER_XATTRS		128
> -#define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)

I guess this means you can't have more than 128 xattrs total, and
sum(values) must be less than 128k?  The fixed limit is a little odd,
but it's all pinned kernel memory, right?

(IOWs, you haven't done anything wild ala xfile.c to make it possible to
swap that out to disk?)

--D

>  
>  enum kernfs_node_flag {
>  	KERNFS_ACTIVATED	= 0x0010,
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index f60357d9f938..90a43a117127 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -118,6 +118,20 @@ struct simple_xattr {
>  	char value[];
>  };
>  
> +#define SIMPLE_XATTR_MAX_NR		128
> +#define SIMPLE_XATTR_MAX_SIZE		(128 << 10)
> +
> +struct simple_xattr_limits {
> +	atomic_t	nr_xattrs;	/* current user.* xattr count */
> +	atomic_t	xattr_size;	/* current total user.* value bytes */
> +};
> +
> +static inline void simple_xattr_limits_init(struct simple_xattr_limits *limits)
> +{
> +	atomic_set(&limits->nr_xattrs, 0);
> +	atomic_set(&limits->xattr_size, 0);
> +}
> +
>  int simple_xattrs_init(struct simple_xattrs *xattrs);
>  struct simple_xattrs *simple_xattrs_alloc(void);
>  struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
> @@ -132,6 +146,10 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  				      const char *name, const void *value,
>  				      size_t size, int flags);
> +int simple_xattr_set_limited(struct simple_xattrs *xattrs,
> +			     struct simple_xattr_limits *limits,
> +			     const char *name, const void *value,
> +			     size_t size, int flags);
>  ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size);
>  int simple_xattr_add(struct simple_xattrs *xattrs,
> 
> -- 
> 2.47.3
> 
> 

