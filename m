Return-Path: <linux-fsdevel+bounces-74072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2FED2EAAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E533093521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F0346AC6;
	Fri, 16 Jan 2026 09:18:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A492E1758;
	Fri, 16 Jan 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555118; cv=none; b=jkQk6KoCIikGi0iWNtxLa6r5IgcrfUaEIaX80W3NylYc+W+SjPCt2cSpLlJv6TB006/Y5iT3yXUWLQ6gT/RFx4Wyb75iTao+C+jdBVGGED07kyf552fIRSRRXrT+ie8MarSNndbHnX08BTPlxlioyjeuhRHsfo4z+5jL+2wY0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555118; c=relaxed/simple;
	bh=Bcis+CcyMFCeebetxVg98dCzlWuLCsinncSr7RMUkjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6K/H+WmN8rck4WRbzCXgzOqT4FFF/FX3ODE+DBdXczJHmY95Ez+xNLNj0/UlK9DdU5K+Bnzv08/qHxa8p9m4js/qmJRzh/IX/THMxDRoIE3H9CSlNHgQUigyTTVlnp88WaUWDYjCnOiBIwyLNdgt4GOZ72J+zuAbcCOzX9G5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D7D5227A8E; Fri, 16 Jan 2026 10:18:31 +0100 (CET)
Date: Fri, 16 Jan 2026 10:18:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 08/14] ntfs: update attrib operations
Message-ID: <20260116091831.GB20873@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-9-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-9-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/* log base 2 of the number of entries in the hash table for match-finding.  */
> +#define HASH_SHIFT		14
> +
> +/* Constant for the multiplicative hash function.  */
> +#define HASH_MULTIPLIER		0x1E35A7BD

The hashing here doesn't seem very efficient.  Is that part of
the on-disk format in some way?  If so it would be great to
document that.  If not it might be worth to look into better
hashing helpers from the library functions in the kernel (not needed
for inclusion, but probably worth it).

> +struct COMPRESS_CONTEXT {

Other parts of the code got rid of the Window-Style all upper
case names, why add a new one here?


