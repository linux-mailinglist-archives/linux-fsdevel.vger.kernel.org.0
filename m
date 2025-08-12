Return-Path: <linux-fsdevel+bounces-57477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694BDB22032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A249B1A20260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4718DDC3;
	Tue, 12 Aug 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKILUHKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069782D6E4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985834; cv=none; b=k4UaHkHSG925iDA/hFaeGrR/a9EL23kkz1btF6S0b/q75nfECHY6GCPTTDUib7GVEPyDwBmjB5YP8mRohgfV7F9ajhm0Ns9Ku6ab/MSnHCtEyYOqRClOghdU+DX3hKrZcZYzVRuf00cvbKEBgWolAiJwRVTNKqEfvaJfNVLgmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985834; c=relaxed/simple;
	bh=6CwQGyWvOHVXHPBd11JgAdDfsb3+1bTz5ROp4j0wtVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0cO2jfys2EG1H6yreT+AfoRyVSIhSMREJuHCDLu7WTo8hyUADsNHV82hisph+TONAh93lxOVHTPVKxf+ovkyuXVhWTOyziFRykm2XJjEtIPr56Mji2UfwN85jX2tVLp2Iq2xZYCslv11OinrQc2695vVijBotAT8yqqyMpqeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AKILUHKy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6CwQGyWvOHVXHPBd11JgAdDfsb3+1bTz5ROp4j0wtVw=; b=AKILUHKytLeXOyjtjZI9RuxTnr
	l2NlRe6nl+wEIOnwOiw5aw81SfIgoQewKOSde84U8v3S2NFIAIdXsEJ/teHxKjonC6erHM70cy6g5
	UuO4laOxqFQ50XPNe7cyHCn2mbcsI2DtXD1HjvDd58kxESiD4+iNafWOzsf/vgohuKYq+pfI1iaf/
	zVFCIYBPutsqMAHljcWKPP2VbiozpqPyj/J4QawF0qhWN9KK2PqYjDwSHIW+ELFxlpYaGRAQmT/83
	gx9iX+CvSrHJQqwageiLqhasB5Hvsw1o7SHrOSVS4QbNumsMPgKMNG2Ynq4wYlpFlau9p9rqpderJ
	kAsOhy+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljz5-0000000AC8Y-16gB;
	Tue, 12 Aug 2025 08:03:51 +0000
Date: Tue, 12 Aug 2025 01:03:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v1 03/10] mm: add folio_end_writeback_pages() helper
Message-ID: <aJr1Z5ERIsrBBpK5@infradead.org>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 31, 2025 at 05:21:24PM -0700, Joanne Koong wrote:
> -/**
> - * folio_end_writeback - End writeback against a folio.
> - * @folio: The folio.
> - *
> - * The folio must actually be under writeback.
> - *
> - * Context: May be called from process or interrupt context.
> - */
> -void folio_end_writeback(struct folio *folio)
> +void folio_end_writeback_pages(struct folio *folio, long nr_pages)

Please keep the kerneldoc comment for the now more complicated function.


