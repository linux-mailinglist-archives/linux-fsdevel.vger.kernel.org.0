Return-Path: <linux-fsdevel+bounces-45841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD6A7D888
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E538C1891550
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A38228C86;
	Mon,  7 Apr 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Dnn0tsY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39331225764;
	Mon,  7 Apr 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015891; cv=none; b=NLv07j3VwC3RZXBComvUIyQU1kIdAmxUqQcO7ksHjIybcUm8Q5lHcUEMz56ed+vRpzt8hNie5UfOP+MMFcSQ/eeGw5Xsyvn1hqrrP/4f0AubMv9reesIaqfbkzkuZ/q4Yti6mFlLMN/x5fQukK53TRlFt1A8q8nFz4GB+7s1R70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015891; c=relaxed/simple;
	bh=cgFMoVhFsVsQuhzN0oPZnKuo1WBBdB+pN2xtQ9S128k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK4T0llBRfszXKWgYlTl5Smew8fJ86ifPDsXahPuV2KjOH/bmkI9SiwQGyq+bKqpmTPhVlCmMNVwr015kbz3C43PMqgkCE6DpeUFDJL7NpD6xvfG+DUVPHS6yBCDwz1CnhN0HuXVMSgI16exzrLTwxUW57EHOBKvoP8IIV3uVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Dnn0tsY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AqJgXjOTWo8t0DUAqIkgmqFLug8gZ7gxKZ1gLMUCv9M=; b=0Dnn0tsYcbtenCdb3OGIfRdXOl
	fstm/HPBAC6tjIUhoWZOWnPn3P/8rHZkCNV3mE3DTS17/kAUntZ44RHMoMxlA+Unz4HiB0vDbrcx3
	X9Pnd2Lr7zMlsQSJkkCXR6GleXwnl2qaue4MPVmxKHftgSYtcSS1RvTaQblcg06g3zt4lZxq+2KQJ
	mbV6xwCE1H/NmH1zKHcSq7lDWUhfIiTD5NFdA28ioouAwzBu7apvCkZu3O8matkPsHyJPIAB1XNoC
	MFI6k4Nl8Qrik/hl/uli7ovpjoRdp1VdBDAZWiIgi2RYk3yTIW8zR/qWoGQJPSVmmWnpd8oXEfZHb
	xQcXbjuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iCW-0000000H4sH-2j0J;
	Mon, 07 Apr 2025 08:51:28 +0000
Date: Mon, 7 Apr 2025 01:51:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christian Brauner <brauner@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <Z_OSEJ-Bd-wL1CpS@infradead.org>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
 <Z--YEKTkaojFNUQN@infradead.org>
 <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 07:19:27AM -0700, Linus Torvalds wrote:
> On Fri, 4 Apr 2025 at 01:28, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Or just kill the non-scoped guard because it simply is an insane API.
> 
> The scoped guard may be odd, but it's actually rather a common
> situation.  And when used with the proper indentation, it also ends up
> being pretty visually clear about what part of a function is under the
> lock.

The scoped one with proper indentation is fine.  The non-scoped one is
the one that is really confusing and odd.


