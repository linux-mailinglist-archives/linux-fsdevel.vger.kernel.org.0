Return-Path: <linux-fsdevel+bounces-74079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132BD2ECE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04EA7304436A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607913570C1;
	Fri, 16 Jan 2026 09:34:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C352FB8;
	Fri, 16 Jan 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556045; cv=none; b=TdZp/QLjlSxz9BqsCjSqKENpBtb3BCe56XDDGs+PIC8hxIAKTCwHd7bwDARS/MaSxq67TRiy+RDARMUAKwDnUDBedB36cPioJLNjwwSqqPS8EZxzlyIFoyUGqZ4/OpjZ1Z+enSgg/LCswlmcqv8hBN769+xRRtL5XLIL/Yf2IaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556045; c=relaxed/simple;
	bh=hbBhHFQaGDCtYfGm8vtthzbBv6AveA4kp+gJvRit+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdgV2PMzRxnMtp6E2X6QT+lS3veTdxf9x7qBpXUDeRyxZIZAo9fi1dw13WRcAo5rwqxZbI12Tyy5eJjwthAS7E0mg6lcXSko6+kc3Ru7sSlpwZqmCcYyXaRH0Auve76BjVc9PyIFyQ8361b3zWNHGi4/MVBOnNEH/RzFxeI8uCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 492BA227AAF; Fri, 16 Jan 2026 10:33:51 +0100 (CET)
Date: Fri, 16 Jan 2026 10:33:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v5 00/14] ntfs filesystem remake
Message-ID: <20260116093348.GA22781@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-1-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:30PM +0900, Namjae Jeon wrote:
>    a. Pass more xfstests tests:
>       ntfs passed 308 tests, significantly higher than ntfs3's 235.
>       ntfs passed tests are a complete superset of the tests passed
>       by ntfs3. ntfs implement fallocate, idmapped mount and permission,
>       etc, resulting in a significantly high number of xfstests passing
>       compared to ntfs3.

I'm not sure how many tests are actually run for the ntfs variants
because they lack features needed for many tests, but how many still
fail with this, because with these numbers I suspect there's quite
a few left. Do you have any good grasp why they are failing, i.e.
assumptions in xfsteasts, or missing feature checks?

Also adding this here instead of for the various patches adding the code:
there's a lot of problems with kerneldoc comments that make W=1 warns
about.  I think a lot of those are because comments are formatted as
kerneldoc when they should not.

Sparse also reports quite a lot of endianes/bitwise errors which need to
be addressed.

