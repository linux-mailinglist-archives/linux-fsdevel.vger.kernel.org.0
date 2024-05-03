Return-Path: <linux-fsdevel+bounces-18672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4888BB461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC061F22FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C0158D71;
	Fri,  3 May 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vcue1ghk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFA1581FD;
	Fri,  3 May 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765865; cv=none; b=SQKx1aqXii+VvVvWMpZE5fJaStp0CbW58B1/w//mP6TwR8IyVVcaV1/6prhMh1+Ej8KEaa9tOUhZyfHmEeLlzmtZzmbtLcBFphA/+zUkgF4djmnVPN0JZpW/JpyU1Di8h0NU+Do+coArdm1UN8kIRzBkl4h3wbyfkurzUV4EOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765865; c=relaxed/simple;
	bh=2JyPRo2Ro2xyGaHzv78UPZmNJQTNXNYjBIsAi3zZbGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3KjKacnWgJSjqI37srDcNTK/KgIqQkVPWzqZ0RQVhU9yEcRY9Qfmps7u5DKvSL8jLtbxTFAivDtZrUKsalqkJVQxh835kAw2rxbEs3CnwWvJGAlUr/lmsWrMihHdzOAlmyU8I3IAUQZKMSG3+OUZ1OnQCBeyTpIQK0D9EPZxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vcue1ghk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dT/tZ4BeVrX503tjBuNztLOilBaPjVoqnxlR5AjEN90=; b=Vcue1ghkLjZN/Pe40AnCT5GmP9
	p8Ci91b4oylITVwrlE0lJHNHQ8hYq8UsAy82XhSPcb+39l0pSU2jMCfwsg7UsBtpZdXW/2K3xIxGK
	u9HR7Zh2jJwR8nfJ2le4iJHsE2UB+SHcXEycw6svdqdqv/C/4U7+4JyRa+LItfjvHwd2Ds5L1J61F
	NTthaERztVnLYJ4DMtLSk5GPab0AxaDZJmRKX7Jo8NFhujqnDUmCjPDEcrf0hO5NLpC7lg2XzhU69
	fnoJsP0dMW8pBG/xWO/jjigWBxxAZ1sUDpqirxvfJSUOJp6BTVnpp8l394Zwx7d2VYgPLAvr8HYML
	e/xZoG2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2yvs-00000000EEx-2NIY;
	Fri, 03 May 2024 19:51:00 +0000
Date: Fri, 3 May 2024 12:51:00 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, keescook@chromium.org,
	j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <ZjVAJOsC-EtlIXd6@bombadil.infradead.org>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502235603.19290-1-apais@linux.microsoft.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

Thanks for the cleanups, this is certainly now in the right direction.
Generic long term growth questions below.

On Thu, May 02, 2024 at 11:56:03PM +0000, Allen Pais wrote:
> Why is this being done?
> We have observed that during a crash when there are more than 65k mmaps
> in memory, the existing fixed limit on the size of the ELF notes section
> becomes a bottleneck. The notes section quickly reaches its capacity,

I'm not well versed here on how core dumps associate mmaps to ELF notes
section, can you elaborate? Does each new mmap potentially peg
information on ELF notes section? Where do we standardize on this? Does
it also change depending on any criteria of the mmap?

Depending on the above, we might want to be proactive to get a sense of
when we want to go beyond the new 16 MiB max cap on new mmaps for instance.
How many mmaps can we have anyway too?

> leading to incomplete memory segment information in the resulting coredump.
> This truncation compromises the utility of the coredumps, as crucial
> information about the memory state at the time of the crash might be
> omitted.

  Luis

