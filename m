Return-Path: <linux-fsdevel+bounces-79244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCCiG271pmmgawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:51:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1D1F1CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E613A30219B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94289421A11;
	Tue,  3 Mar 2026 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKsHdlMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9E3502A7;
	Tue,  3 Mar 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549482; cv=none; b=lLBiRJiiOMjoObykRKfVA5nIaRmON6GUcKebS0tM0wqT2wmkKc3q9IVLinn3m0ljFz+TK4R+HYHDuglDhFaxDVT7AdNMvQUY/qkFV7OLmCVUXACBFvbZ5MX+B0BJntr5B5iRG/KWUwNB7jcvzaGgYtQNpvd10wq83NwUpmvR0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549482; c=relaxed/simple;
	bh=rgNL1inaPJ7m8XSklo6WqH97eI0lqnqRQLRDL64gSJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mabaHp4vhYrklL1RvJnw/zFrjECrKNYbsJ9zMTsPB599qwH54KAw93hGKkFX2sGQGpxCSNucPlXQgWU1zgCAGHeAQ7sx6jTDdm0xRKuCST1GXRELSsxw5UDz4ftB0ZDQjQOHbhek5MQtUza3MYVgo2j0HFTlDMzv2m2Y3Vy4WpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WKsHdlMn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0azL9xrP6RjsDUWM8INKgKlOF2jsHNXZZ1YqkDP2LyI=; b=WKsHdlMnkEgxG2jMJsdzyNnAM1
	gzZbuFiJ1/V8ZzmO1LPj9LSCIMe92E/4TSnW/2LEozoRgcNnS/Tmbzbr8VwBZDUFyk8lf0YdHHnyU
	OGhRH3DqO6vlgf9RzInWHL+4//md+jo7+ligTbO8SkPQDtCnWo5/DUFJ4ZYs78L6/sU9nk4KUmiqx
	lDtXODNXhuW0El8IYf93I7qB6NtkM1O8sU+jSizp4ICfE7FCNb7Sax8iLmqjCXOUJIUmoekLGbVye
	Pk/yEElZPvkvgoAjmyAyyLAwpkPjueWPB8YvMszj2/ekXOBJvRcI4CtmoO6asn/FGfmM09IXAmY5L
	bd+8O/kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxR5j-0000000FMKT-3PDm;
	Tue, 03 Mar 2026 14:51:19 +0000
Date: Tue, 3 Mar 2026 06:51:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gabriel@krisman.be,
	jack@suse.cz, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <aab1Z7J-m97VfFvS@infradead.org>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: D5E1D1F1CAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79244-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:21:04AM +0100, Amir Goldstein wrote:
> On Tue, Mar 3, 2026 at 1:40 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Test the fsnotify filesystem error reporting.
> 
> For the record, I feel that I need to say to all the people whom we pushed back
> on fanotify tests in fstests until there was a good enough reason to do so,
> that this seems like a good reason to do so ;)

Who pushed backed on that?  Because IMHO hiding stuff in ltp is a sure
way it doesn't get exercisesd regularly?


