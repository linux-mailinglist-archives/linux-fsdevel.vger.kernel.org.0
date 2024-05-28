Return-Path: <linux-fsdevel+bounces-20375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245EE8D26B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1DE282EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404017B421;
	Tue, 28 May 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rC0QR5IT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316B224D1;
	Tue, 28 May 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930363; cv=none; b=Pvq1GpSKT/92bSnQTjaZe4pvcAqUYs8AyVNvness7OwUblOkSN176QWRkPfeLpuLGyx5Zz7pze7X3B7N5GhWJJOy8aI8cRHqMK5qLhynaFx5fM72tprQbFXALpFcqwNoBfJYV8lYzxV5JoXK9PqZCPaTzd9+V4zd/0uK5mUufq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930363; c=relaxed/simple;
	bh=Z0GgS2XxzTLFcL4ineMAYqGOyHY9Kfgtq8U+6irNxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1K9MQ3FCM+/eAC/Fa0MF/nE/knNm6wOKCJCc7SrpSlmuxKWKNbegGhUqIfsXxUnuEpeIQSLChHOflESFBtIPWzfA9cEt7Y/n2Ju7uLpa2pWBDGkzCUVHm8GFNLUbMZXqMXuojwt/uQpd4UCSOvcAFp44Jbvsvmlqpwihvf4VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rC0QR5IT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HBLV8SvG69KfYXPdP3B1zrE6MIyDczjFiBRIaa4NQ3A=; b=rC0QR5ITv2CA9Ipf7v+jUm8llu
	xzdDQMbhnzOIDI3OH1SAqaHlK2Lz9spkp881yIjwb4PNHEDohJRk6hpNKEqope0BcIFdIhR3BtlJH
	j7QeU5vdHO44akhrm4ABPYEQzHchL5DKyX3E/gdm0FokRbrG+lKXIVT62PJ9f+ElX7rE5B0tUT05C
	8l7SvB97uifbOq6ESv7yAFZWXQKTkTINBWxB/Ddo8pXSsQAn0Zb8zakKUvElhf52vhCWSYRp1X8bT
	3md4wcANgHxkNkzY0al3ZvCPB2gSVPebVtnnnbkv+hy7WYRQGZek8GyYvwOQ3Bu78KuS/Wkts4uiy
	jQ88WT7w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC418-000000093ou-43mF;
	Tue, 28 May 2024 21:05:59 +0000
Date: Tue, 28 May 2024 22:05:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: support large folios for NFS
Message-ID: <ZlZHNsejJkJNhKHR@casper.infradead.org>
References: <20240527163616.1135968-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>

On Mon, May 27, 2024 at 06:36:07PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds large folio support to NFS, and almost doubles the
> buffered write throughput from the previous bottleneck of ~2.5GB/s
> (just like for other file systems).
> 
> The first patch is an old one from willy that I've updated very slightly.
> Note that this update now requires the mapping_max_folio_size helper
> merged into Linus' tree only a few minutes ago.

Kind of surprised this didn't fall over given the bugs I just sent a
patch for ... misinterpreting the folio indices seems like it should
have caused a failure in _some_ fstest.

