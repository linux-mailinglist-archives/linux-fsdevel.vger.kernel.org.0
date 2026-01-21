Return-Path: <linux-fsdevel+bounces-74871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAykCRX1cGmgbAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:47:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38E596FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF2E37485AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBB48C8C6;
	Wed, 21 Jan 2026 14:53:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B838BF6E;
	Wed, 21 Jan 2026 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007205; cv=none; b=cRvhwN+MiBDKUdK4+0jqjaeiZ3Htewx9FlHVcw1bzgNMAmLvisqlOWTtdAkpG24lW+ai1rrmyv58LM1ivNnakAJqQ+lIegmHK1Hur7SpWKwsV6KDqmPOmgarOQPIV1j1m7WmG45SXAm8sJ8whExViioDm99pCGgafywXPzdzEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007205; c=relaxed/simple;
	bh=42Nce56/PaVMWl8jsxdgzHKUZoZpcn3sDLGJj2LfwMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxRLErcVf5qeWgnEAA4rZ/gnruv6zblqodBk08PucDt7D063v2v3vvlZUYDFL5zVKCBBtP6Ho3QiNWKPhbLt1te+7190tFImN6r+0iXc/MKOYmeS5aJKQGKgrU6XuarM1z7lLg1JAZdwj64oUZILDyencGV+b1BHWGfp+Yhby54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8AE19227AAD; Wed, 21 Jan 2026 15:53:19 +0100 (CET)
Date: Wed, 21 Jan 2026 15:53:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel
 filesystems
Message-ID: <20260121145318.GB13325@lst.de>
References: <20260121085028.558164-1-amir73il@gmail.com> <20260121101234.GA22918@lst.de> <CAOQ4uxjRoK-tEEr+QsdSm-yce1+n2XZkkO-uFKrbhLXdyw4cgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjRoK-tEEr+QsdSm-yce1+n2XZkkO-uFKrbhLXdyw4cgA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74871-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: BF38E596FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:35:11AM +0100, Amir Goldstein wrote:
> On Wed, Jan 21, 2026 at 11:12 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jan 21, 2026 at 09:50:27AM +0100, Amir Goldstein wrote:
> > > pidfs and nsfs recently gained support for encode/decode of file handles
> > > via name_to_handle_at(2)/opan_by_handle_at(2).
> > >
> > > These special kernel filesystems have custom ->open() and ->permission()
> > > export methods, which nfsd does not respect and it was never meant to be
> > > used for exporting those filesystems by nfsd.
> > >
> > > Therefore, do not allow nfsd to export filesystems with custom ->open()
> > > or ->permission() methods.
> >
> > Yeah, this was added in and not used in the existing export_ops users.
> >
> 
> Not used in existing users (nfsd) on purpose to my understanding
> That's the point of this patch - to fix this misunderstanding

Well, I've dug through the documentation and commits that added it,
and there's absolutely nothing explaining the intent unfortunately.

> >
> > Please spell out here why ->open and ->permission are not allowed.
> > Listing what the code does is generally not that useful, while why
> > it does that provides value.
> 
> This is what I had in the RFC patch:
> /*
> + * Do not allow exporting to NFS filesystems with custom ->open() and
> + * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
> + */
> 
> I took Chuck's suggestion to rewrite the requirements, but TBH,
> I'd rather not touch the existing comment myself at all.
> I prefer that Check and Jeff apply a separate patch to rewrite the
> documentation if they feel that this is needed or to propose the
> phrasing that they prefer.

I don't really care who writes the documentation, but if we reject
based on the presence of the methods we really need to document
the why.  

> > While looking this I have to say the API documentation for these
> > methods in exportfs.h is unfortunately completely useless as well.
> > It doesn't mention the limitation that it's only used by the
> > non-exportfs code, and also doesn't mention why a file system
> > would implement or have to implement them :(  The commit messages
> > adding them are just as bad as well.
> 
> I will leave that to Christian for a followup patch or to suggest
> the phrasing.

Yes, I think we really need a braindump from Christian here.  If
you don't want to add that to the documentation I'll find some
time to include it into a revision, because documenting these
kinds of things is really essential.  We're already confused only
2 years after this was added, and it's only going to get worse.

