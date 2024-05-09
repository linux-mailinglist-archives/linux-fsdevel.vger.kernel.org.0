Return-Path: <linux-fsdevel+bounces-19201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CDA8C1259
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C921C21523
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D716F825;
	Thu,  9 May 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olNP++PA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48A15F3E6;
	Thu,  9 May 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270370; cv=none; b=TUEZHUXdYDmIOv3SxA/fd7W6S7xjl4/MySlyEF2RLojle6I14Nr69e4ioeyxpKne7vyHfVdAJv+W02+RQDAmeZmUH/A/iDa9v7MNq7616zJlC2EWE0s9ICDGUQXYKCyjeErAYwqX/izmsdzbiaLqaqwhPTghLT1VTzG/nR/N0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270370; c=relaxed/simple;
	bh=4FZ9KCdwhV378VJePVkML7by6JX1CpOAHNYUyYjZYiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZI7LrgGaq+VAITHY8ptXUs80y7ppZpgJjcqatH0JP4frJMFVU1xypcVoqcrUGCZNPmSip/K1xUR4zvk5lcKn4pXP0pcX4cBV/PD6A/iK0EPuqfdo/Faw7z7UwJOXi7rxsDAVFTGillZHIRrCPkflfwXCqgjVKAkCKBdXAwuotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olNP++PA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OA/KerpuD6GFy1MyF9RTN0/KECfL/+yD5F3VNtsdfN4=; b=olNP++PAF4VbAFAgrvp/dplFAi
	aqTtngcdYzIMYK1thrnhLTt6uqGWAnxFhhAlKIOxpMqPxByeeQ3biiv42jyIHW14MYqgNVx/MKwha
	oShgzh+fmn6jnMMi4ChPhhnsRMcmPNhYloDBE7mYXy+ao155qUqYpWKryDswS732HRGPjsgCoHiPZ
	GY5V8nV5GXOBm0L1oQRtiKyVoGJuDpWsUgvyDTFJ8fgvi9sC+OANHl6om3i2yVnGhV09JAqMhhhty
	S4yGLLJiKFNKyk1y9Hg3lOjpF/g+RqV0JfvA52Gf4YhkhsCV6sTS4Z4JCH7qLz8KKrveeaIL4l4Gs
	G6XFaz+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s56B5-00000001xz2-2bpY;
	Thu, 09 May 2024 15:59:27 +0000
Date: Thu, 9 May 2024 08:59:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
Message-ID: <Zjzy34y7aT0B2J77@infradead.org>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org>
 <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
 <20240509155528.GN360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509155528.GN360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 08:55:28AM -0700, Darrick J. Wong wrote:
> Ritesh and Ted and Jan and I were chatting during the ext4 concall just
> now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
> bof after that?  That would give us some time to chat with hch about
> iomap (and xfs) direction before he has to leave.

Well, I probably need to leave at about 3pm if I don't want to push it
too much.

> Alternately, we could announce a lunchtime discussion group on Monday
> following Ritesh's presentation about iomap.  That could fit everyone's
> schedule better?  Also everyone's braincaches will likely be warmer.

Sounds way more useful.


