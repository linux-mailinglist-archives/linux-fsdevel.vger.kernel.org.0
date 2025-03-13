Return-Path: <linux-fsdevel+bounces-43897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF22A5F4C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07DB1885F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E32676C7;
	Thu, 13 Mar 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPw6GkMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229591FAC30;
	Thu, 13 Mar 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869850; cv=none; b=IfHGnWgfc73ecMBgD6TEahdao/LtJQyoNNwCJ58izHcKLdpxY3jspGSyuYO49HQYSm+REsOycVDDlFHcKSNiCLY5l9UL/arKxsym9HACLv3h9eXHuC/s6yqIYZ8ZuYqdTzGGTVbeO1fU02t+vUf7f3Ij9qIziXyz0NOm4RMA63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869850; c=relaxed/simple;
	bh=aKB+s4bnrAXllo8npSchGROsf4VcLKZBV4DKwx7+dD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXQzA5shZoW7yt/0zk0THGnTuZf2uD2B2pnPPIGMqpMRBr1rmIN/clX6+rZNxGBCDWHNYS3VHJeWr6EmelJWWUymyqlv8pd0RgKR+upkH4Aq65RFLxI5cAUMHwDliVhdWvKledjaSJpt/AueHRokeyn6olu1lm4Hm7zTWrtDeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JPw6GkMu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1uUgEW7azWchL67hvwzS3WcEAyvzL93XcDsI4ZY0hbw=; b=JPw6GkMut1ZelgPQo2OYm2eEya
	OGxRg17+oGLX+TH580OSum/KWGQPGma3i8r+cobFIhJRTB9x5V/xKjpKRE9NAEi7Njgezjlxfm/gD
	T1IyubVyXCsVpQOt1By1Xb0MacdrFIw+ZVEKtVohwTkwiMzT3WRyw44Cq07QQr6DQ3ImVDXclj5+/
	rJyfRkThsfGHqWQe7SrmsGvypcziM7KuyX1YNDu5r1zhRSRHFvx+jKLnBbkR6v3L7X7zoV9HmYnYo
	xIMQsGhrfVM8mvlCFZtkJtcR/XxAAxIaPXR3OaUIWmjtSTaeKobPyP5eAqkdGQc1HOWCkGnPKPALD
	vWVqv5Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tshut-0000000BH9Y-3IM1;
	Thu, 13 Mar 2025 12:44:03 +0000
Date: Thu, 13 Mar 2025 05:44:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z9LTE7p7DnFA2A1o@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb>
 <Z9GYGyjJcXLvtDfv@infradead.org>
 <c7znin3sdyzyggpnmwexlnlzhhyzwmrz5l7kyfr3wpszrfhvlt@q74rkjdjz53i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7znin3sdyzyggpnmwexlnlzhhyzwmrz5l7kyfr3wpszrfhvlt@q74rkjdjz53i>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 12:09:41PM -0400, Kent Overstreet wrote:
> > The right way ahead for swap is to literally just treat it as a slightly
> > special case of direct I/o that is allowed to IS_SWAPFILE files.  We
> > can safely do writeback to file backed folios under memory pressure,
> > so we can also go through the normal file system path.
> 
> Yeah, and that gets us e.g. encrypted swap on bcachefs

You can already do this pretty easily, take a look at nfs_swap_rw.
It just would be nice to lift the boilerplate code to common code
and make this the default.

