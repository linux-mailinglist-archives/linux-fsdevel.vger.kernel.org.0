Return-Path: <linux-fsdevel+bounces-77796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBz3Hb58mGkdJQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:24:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3865168DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDCE30A4490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DF279358;
	Fri, 20 Feb 2026 15:24:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116C24A069
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601047; cv=none; b=czLFgt4CCLzoWIJ5IyMsc54YYLsXia5q9ymj725wSMxMVSfifhsOzbnm3CzJ8QxbZd5wg2XV5rGY1LlSrPzuMv/5Kh+s8rgLqwOkdxa+Js+0fiU3suzEDvbetWyvQA/+a8AICYnXX3uclPC5Y/D9A1nGLbyrre2uFKzqM0vq1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601047; c=relaxed/simple;
	bh=0YEaGQf9VHMe3xPg/4Ifg7n53vaRK2P892FnP2cHtOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTLIrVv9KADOwfeFZVrAuKpUhBQYRbFpSrCGSfp1D7qsEU35jYAmECL5VUjrZ+h+IhwqzbMfOTrvXGe3KiMlTOZg15TQuYNb7t/6ZitOcbGteHTL+4txteZ/d0XG8+SH01iOskBfBOjxMIBe39HdROJlJSGYXw0n86zY3QraLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FC2768B05; Fri, 20 Feb 2026 16:24:03 +0100 (CET)
Date: Fri, 20 Feb 2026 16:24:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fs: remove fsparam_path / fs_param_is_path
Message-ID: <20260220152402.GB14300@lst.de>
References: <20260219065014.3550402-1-hch@lst.de> <20260219065014.3550402-4-hch@lst.de> <20260219160428.GQ6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219160428.GQ6467@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77796-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F3865168DB2
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 08:04:28AM -0800, Darrick J. Wong wrote:
> > diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> > index b4a0f23914a6..e8b94357b4df 100644
> > --- a/Documentation/filesystems/mount_api.rst
> > +++ b/Documentation/filesystems/mount_api.rst
> > @@ -648,7 +648,6 @@ The members are as follows:
> >  	fs_param_is_enum	Enum value name 	result->uint_32
> >  	fs_param_is_string	Arbitrary string	param->string
> >  	fs_param_is_blockdev	Blockdev path		* Needs lookup
> 
> Unrelated: should xfs be using fsparam_bdev for its logdev/rtdev mount
> options?

Not sure what the point is in having separate string helpers with meaning,
but maybe I'm missing something/

> Or, more crazily, should it grow logfd/rtfd options that use fsparam_fd?

What would the use case be for that?

