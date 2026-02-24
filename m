Return-Path: <linux-fsdevel+bounces-78257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILM+IAyUnWnEQgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:05:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCC186B58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70E01304651B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3338BF86;
	Tue, 24 Feb 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrQISAiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0D38BF60;
	Tue, 24 Feb 2026 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934718; cv=none; b=l2it+w6H6V09d1m7OP6u6V3umCCcIMBIeLtcXNQKaVLppkrXhgKJCiqxOSTgjWMhao80sW5Xw8Um1FPQ2/qvi4hStFVTp/pDWKrK0ff6km+QJfgfzJzidBnawTCtac/IU+R8ceA5TWcRzueBF4pAfGKJtptupHD6B0dJh8FPTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934718; c=relaxed/simple;
	bh=uyHZHiDaI76P3wMbcjfRYTIsblHmF/n0kgvN3nM67TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug3n5kkiZZiUQVrfJWeFfo3YggddQo8huw2JLQWCMIfLuiCRVq4VZ0//e44tNhHTYjA/yGUyG0hxfrpUiV6pdqnAub0cpgTXE7JXbUjVBUApt43TleHaZ6oC2Zi/EY2JKCiBgtrhsfsfMqMUJRgyfZ/2m8fVgsiMgPd9fYFhY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrQISAiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68992C116D0;
	Tue, 24 Feb 2026 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771934717;
	bh=uyHZHiDaI76P3wMbcjfRYTIsblHmF/n0kgvN3nM67TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrQISAiBZbxi014QUg+0NsptwrL/HoyNe8+pINU/fOqAkzXQsDuOc+HYQYbjDNcdj
	 N6xdOuLC/SxMD9Xdhcv7Z98YsMQ9QmF8DRDkt+bXUVV6xi3RpzHjg17N9Y/7VwRLMZ
	 76/KE+jRmQYHAeRgOyoHawrUN6z3yc+KUHErpaMZnbQv+6uGfsCxqDRL6qI1Mx+wNW
	 oHZcdtCST1nMSg6ynsSFVAQZm3BESolWjq70dCl5geiZwATPdeseqECT9dP0rM8MYn
	 qdFpW0IQ1DbuPnN+Bdm0+vOBkvOAjtmYUDullhHcIQClGLF6rWQ/50RlGr6xiMzKwt
	 W+/lgwN81vx2A==
Date: Tue, 24 Feb 2026 13:05:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-api@vger.kernel.org, rudi@heitbaum.com
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <20260224-erbitten-kaufleute-6f14e3072c5d@brauner>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
 <lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhuecmaz8p6.fsf@oldenburg.str.redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78257-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,gmail.com,toxicpanda.com,suse.cz,cyphar.com,heitbaum.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6BCC186B58
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:23:33PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> > index 5d3f8c9e3a62..acbc22241c9c 100644
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -61,7 +61,8 @@
> >  /*
> >   * open_tree() flags.
> >   */
> > -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
> > +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
> 
> This change causes pointless -Werror=undef errors in projects that have
> settled on the old definition.
> 
> Reported here:
> 
>   Bug 33921 - Building with Linux-7.0-rc1 errors on OPEN_TREE_CLONE
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=33921>

Send a patch to change it back, please.
Otherwise it might take a few days until I get around to it.

