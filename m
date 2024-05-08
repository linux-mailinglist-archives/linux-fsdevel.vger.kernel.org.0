Return-Path: <linux-fsdevel+bounces-19107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8C8C0187
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4291F2824B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FC128396;
	Wed,  8 May 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="191FKoNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D528625B;
	Wed,  8 May 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183850; cv=none; b=VHz5c6aDMPvFKlYVcCKIGG0sHh/18SnsDDizXCWzmxAsyHtOpJyUAwUkbhcrrewfmKFtZ+g5zXxo3rbyybK0u3Ki/yWz2l05qpnuup8PMqVeQrDGAAG8lPW1teS/es/NMQBgU8fvhoXTleBWzC8UbZ01Hw/LLKFGnFVx5jQBK8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183850; c=relaxed/simple;
	bh=tPtSEqghp6X+xcXBgf6p9DZmYra2EVVIPkBYbj7ZAe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpNe6kDtDMTQjblzw0mSeyLIfTYuQl7MKT4G5kfYVp2m7ccG4Rrqkb+By6w/Cg+lZfhqibR49B1hjJKYts+qxepvlG6uULfx0JIFtl5gq5tWBYx2HXHscAW8WyaKfI+fREJdeuuxF9lo7nMaqkS5WBtZVzL1E7qIvLXluu9vfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=191FKoNE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=VgZ2foeBWNFhshAFEh20hHZWiXfRXeW8Nj8zaU2MzqM=; b=191FKoNEnsqepe1oU/+t+ooLkM
	/0x9s4xT63IOqeine6ftTBG1SVkanLvQXJOJI6MpIEVwMlSGB9d1uzQV/xN9Wh5BGCPqAIcWbmZjf
	PblqJDctAintRccFGWGq0BuPUqLcjDvsyONtCWiaAdC+YjK6GxMgfuH61nv0A0D38eULdNBesszYI
	jn0O22MmIGbuZ0mS3MELF4BbpEWyAIkrVYjtlMTiIsV89wL/d/TP99itexld514y03zsy/QUjBmwZ
	ZpCbD3KY0Zse1talZ7Bw+6C9vKmZxskpYH3IubLD76BEUnjc81jkab2fqlk9JkTU6e7EWx/ZrmvDt
	uz0jlMqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4jfQ-0000000G6J3-2Nep;
	Wed, 08 May 2024 15:57:27 +0000
Date: Wed, 8 May 2024 08:57:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, kdevops@lists.linux.dev,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, linux-cxl@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: kdevops BoF at LSFMM
Message-ID: <Zjug3BqYyW3hrMdy@bombadil.infradead.org>
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 08, 2024 at 10:45:33AM +0300, Amir Goldstein wrote:
> On Tue, May 7, 2024 at 9:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Dear LPC session leads,
> >
> > We'd like to gather together and talk about current ongoing
> > developments / changes on kdevops at LSFMM. Those interested in
> > automation on complex workflows with kdevops are also welcomed. This
> > is best addressed informally
> 
> wouldn't storage/MM people be interested in kdevops?

It is up to them, I mean, I've started to work on mmtests integration
so we can help test memory fragmentation, and plan is to integrate
automation of maple tree and xarray shortly, mm folks are more than
welcomed!

> I've placed you session instead of the FS lightning talks on Tuesday
> after Leah's FS testing session.
> There are enough slots for FS lightning talks.

That works great, thanks!

> kdevops session is for a very specialized group of developers,
> so if that group is assembled and decides to use an earlier slot
> we can do that on the spot.

I think the current timing is perfect, and does not even conflict with
mm folks, if they want to join.

  Luis

