Return-Path: <linux-fsdevel+bounces-9212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5783EE4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64E5B2183D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB02C1AA;
	Sat, 27 Jan 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdFaxO8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462E28E23;
	Sat, 27 Jan 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372289; cv=none; b=rqvAT6oJ4FB3p/tXWIZ4IaaPB6etQD4T4AZHnKeAd2ELsHpO2G2Q7GdMQBaRILrKHdCuxQIu5inwtz0v/K8aa177qOp8uIQ81ebx0mb+1InJK+8Zhbxoosu7KY3KMRWl+4GR0RgBe84wAzPn0SsxDY3oMpMtS2vcjdwj01fPQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372289; c=relaxed/simple;
	bh=aHPBBvTe1Yv5eAiaidgAePZFK/VRhuggBoBZrMj6VwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTNQZeoWvVqbHHGMbDUcAVJmhz8YjqclZ2lEOq4ZzmXG6XMadQC7RbJkWYiybVZudUP4bBjq45SY5mgpA1R09yPp9GqnELIfWJ7GU/3c7bIRFPTSPcrcYeDlTBgUsp53xlac4YHdXVJun/CBP9gS1ax1X19EnDMfmUc/KbguGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdFaxO8t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KhHNxgF3fX8abmBvoOAyuYkGMYHZsCw8fbKtovSaG/I=; b=gdFaxO8t6tnCSKV8WTnvzfHz2e
	vL3goFmREafb6BeoodiQOqw7C6OocFzhyq/eIYwdJAhsYIdpoCUXYDONbVTFM9Wc/aGWtxQ6yl021
	APdqJgfTxUUXMDYm7Re0cYNuq4tL18oadwnRPa7Hum6f6R2lvDwbqc9TVET+KbAHR+C5N+KuDNf6S
	EeVNaMcEFmgUYrmxhgcrjFDhDXK+jLn9UsH4bE+3ON6iblEXxOR8UGQMyj8M0emHEm5KI5oT38/y8
	WMH9ok4+pBbJkgSTOd4sC+FOfd8sq1abWCj78o1W14txC4lKOh33kzs4Mo/W/uhNb7OKnJxMm8ndZ
	cpI2T1MQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTlNa-0000000HLiT-3PXm;
	Sat, 27 Jan 2024 16:18:02 +0000
Date: Sat, 27 Jan 2024 16:18:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZbUsuquUXXq4D6fw@casper.infradead.org>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
 <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>

On Sat, Jan 27, 2024 at 12:10:32PM +0200, Amir Goldstein wrote:
> Matthew,
> 
> And everyone else who suggests LSF/MM/BPF topic.
> 
> Please do not forget to also fill out the Google form:
> 
>           https://forms.gle/TGCgBDH1x5pXiWFo7
> 
> So we have your attendance request with suggested topics in our spreadsheet.

I'm pretty sure I already filled that out months ago within a day of the
initial announcement, and I thought I included SOTP as one of the topics.
But honestly, I'm not sure which topics I filled in there.  Is there a
way for me to know what I wrote in and edit my initial response?

