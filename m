Return-Path: <linux-fsdevel+bounces-78293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBhwAxLcnWmuSQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:12:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F96018A5D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83461305D6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0513A962E;
	Tue, 24 Feb 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOnfWfwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FA38BF86;
	Tue, 24 Feb 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953160; cv=none; b=EX8MgjoboXJWp81LN5CpLMitVXLXtiEAEj9pF9+V6ecM04XfOf0E8CyZQGpySdhZdMeIM77kzHUX22N0WsWe3VpMA3ACNzxt2UXKpb70u/nRLqW0kSIlbiri2dG5LUobjL0GLlhzNDCco8mglRPqtzIcGVSRTOz4KZqPfgwOuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953160; c=relaxed/simple;
	bh=v18m4sWpJy3t56Ijmk/Cs0vA7QklpoiTcEmzG1UWFvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBzwo/0ZYBigRatU5/FoaT8qc84eRZ8qEmGv0O9U4m5JxEoOgeiAEhC/o262E4iQE4Ys2nu4jqg5OMNcm/tbWYrY40ibDLeHACKZ4TTMcEYX5DHdV1rbiOm8vIYE1Qp7FWEj+AHJoS52605Y86Eu3cQm3DWHDtIv+YD/ycM58dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GOnfWfwQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZRrV1VHZ/6QVC5Vj9yUAZNw2SnJjDuMUrONaqUgvN9o=; b=GOnfWfwQN6lREpPoT4jBFQ1uTi
	fwrYQXjSxJVIBJUANIlvIH9lJjM8rH/7A+7UK+EKzxmOPaQMwmb+9F1J4dH9dAnwyGxvjVuQa3KqM
	oNdJwEQJk+mBVE6K6v6IreZX+uCb9WUGaBIng7b/VNxIwiDd6zbQ0OWX2BPBo827dG9sblyXqZhfe
	aO9DlsCMmnKm67YYpVxJm1To72BEMhx8UtSkbXhxZ+z2BebG4yKBR952n24yvjOzf9/iGYNDgBCaf
	pbzzcCeSYHhcWww3OAGAJSOjA3AZs/UybdqVrgHC1TwqONlNARueGkSLfpKs5vamkiMGbW0nGPV96
	eOOwL0uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvxb-00000002S3P-2iTg;
	Tue, 24 Feb 2026 17:12:35 +0000
Date: Tue, 24 Feb 2026 09:12:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] iomap: don't report direct-io retries to fserror
Message-ID: <aZ3cA0dv0XNAbiTl@infradead.org>
References: <20260224154637.GD2390381@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224154637.GD2390381@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78293-lists,linux-fsdevel=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F96018A5D2
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:46:37AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> iomap's directio implementation has two magic errno codes that it uses
> to signal callers -- ENOTBLK tells the filesystem that it should retry
> a write with the pagecache; and EAGAIN tells the caller that pagecache
> flushing or invalidation failed and that it should try again.
> 
> Neither of these indicate data loss, so let's not report them.
> 
> Fixes: a9d573ee88af98 ("iomap: report file I/O errors to the VFS")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


