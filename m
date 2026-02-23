Return-Path: <linux-fsdevel+bounces-77930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKzfGWpEnGk7CgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:13:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502D175F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11D0B303098B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62921361DC4;
	Mon, 23 Feb 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtTqWE5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD6364E99;
	Mon, 23 Feb 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848799; cv=none; b=EjqV5nKWjbCJ67QYBetoW3kmTcGv5jIKL2DJe5reaVnU45dQlPAeag0oPXM0ySUqsHYR7MmQr42aLNF5AiZ+ugtfsHJ2OH5pkYksXVpq2z72gp88HLpKXdemX0tuT98aXSNDVZvANlWK1IIMxh5tQh4NIlKaUyhoKz/uYiyaeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848799; c=relaxed/simple;
	bh=oNuEDnFMo14V4sgwK5Ij+zwpbNPaHLPS58OsUoBe754=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPhsvs4O+1gIzzVENL//XzV+i+CEK5sAZFodSeMVfNyfXGJdT/odH5CaKBe8XEWviw4mvZyKYxvvwEObj80S6kgKS1EP9C3j4+LJ3SgU4j4ApNh08G9oUHmItdEQBQ/Z8dQGZrHDrlxOsMMoT9RQ7fFLM9n/RehXg6Mr+bo4r5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtTqWE5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E94DC19424;
	Mon, 23 Feb 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771848799;
	bh=oNuEDnFMo14V4sgwK5Ij+zwpbNPaHLPS58OsUoBe754=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtTqWE5dYnAKYm1Lzxcfk5B3SJEF2jpuy7dXe44+UUXXVmswqzuxUybUR4b18V0PE
	 iMMSo6bdz6JL9jCDC3VtDzNkd79KuE893ALD5dXsZby5fMDNzZPrz5WC40YHThssx8
	 aXR/GE4MqagmYqxWOQowsMdXtxYKAFPYHVxgYPCvfrAMUgMpMpn94S+7weovfYNAsq
	 2TTRtYQe7wLjMONEBfaEsmB+ARZAsRRneTjQ2lNDMD34Igp12uQzCH57MmaUWXydDS
	 RGXJYtx8/ECXVruWFyBFXPg8CkSgWT+F2glsw9fUXP4L+/XOSUvqaGXysUsLpPnanT
	 FemHaUl4Ap/6w==
Date: Mon, 23 Feb 2026 13:13:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 09/14] xattr: move user limits for xattrs to generic infra
Message-ID: <20260223-gewollt-tropenhelm-fbcdfb6b5a17@brauner>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-9-c2efa4f74cb7@kernel.org>
 <20260221000326.GB11076@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260221000326.GB11076@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77930-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0502D175F51
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:03:26PM -0800, Darrick J. Wong wrote:
> On Mon, Feb 16, 2026 at 02:32:05PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/kernfs/inode.c           | 75 ++-------------------------------------------
> >  fs/kernfs/kernfs-internal.h |  3 +-
> >  fs/xattr.c                  | 65 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/kernfs.h      |  2 --
> >  include/linux/xattr.h       | 18 +++++++++++
> >  5 files changed, 87 insertions(+), 76 deletions(-)
> > 
> 
> I know you're just moving code around and that looks ok, but:
> 
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index b5a5f32fdfd1..d8f57f0af5e4 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -99,8 +99,6 @@ enum kernfs_node_type {
> >  
> >  #define KERNFS_TYPE_MASK		0x000f
> >  #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
> > -#define KERNFS_MAX_USER_XATTRS		128
> > -#define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
> 
> I guess this means you can't have more than 128 xattrs total, and
> sum(values) must be less than 128k?  The fixed limit is a little odd,
> but it's all pinned kernel memory, right?

Yeah, it's all pinned kernel memory.

> (IOWs, you haven't done anything wild ala xfile.c to make it possible to
> swap that out to disk?)

First time I've seen that. Very creative. But no, I've not done that.
cgroupfs has been fine with a fixed limit for a long time no so for now
it's fine to assume sockfs will be as well.

