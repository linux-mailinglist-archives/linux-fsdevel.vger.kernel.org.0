Return-Path: <linux-fsdevel+bounces-64720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AABF2505
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F053BA564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F3283FC3;
	Mon, 20 Oct 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOolAoNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B69283C87
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976439; cv=none; b=nnJmXK+3ZIyBrzufzjfmibqkx565Av0g0MP7k1cviDMwKR2WZ4Btbuhn96S+wDN7QNT/dT9fBzlYhbn3Tvv19i6Pb7JX10zNs8xgiXCPQAsMeYnk6nbWtRABjZ3C5aGhQcHvxezDVwyNR6bJFrVeux4oDovS4RVpxuYX2rZ66RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976439; c=relaxed/simple;
	bh=caqCo+djmBt9IIT5JxxY0DzlLA/OqoJAy7cD7lPUh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI5xP67E3I86x7TGC2ZvwGUs9bH2TN0eqO9nLJpNhEcB9WZl0QHqxSPMFBy0wBjsNicDu8jmoiYD8w6FGCijjAKgbA+73Tsn0gZ7mtXsPte7IvALSxPQeviI/SVKeabv1A9yDZFIsgl1r4kNHpI1/DjcuQH2xx1qu5qoXtaRba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOolAoNi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KL/EaOnfXWg2FBg0qC5uKF2CErQG5N2rBwVjgfdyzCc=; b=EOolAoNikScuROTTirmCNNd3p7
	XPL43N9UeN+d5su36gP+5AMC0PLzqnJZJXKJWzeYyxTTnSiGKC9hL1rQDszBiP6qFQ5boT4h18Y4z
	VZNk7Vi1T9TPPqLxVXNDLCESfuGtRKaQhj7H72Av+QKgahoCBdHJS2wMl+sJV1xQwVxdFrpijyJd5
	7nVEHUiFTOw2kb4+kH4gZ5AcHZmXS4OIcfKV3SvIKeP4qVgA+v1CYckSGRHZkMRPClrgXanZnCkYb
	YQgKfnsDKbe9GjX7kAO1qD4O5CQmme9IESXVhIk61Cf2ikexeMWzOGHHEIxpItqKX1sZcO6E8JMzf
	VxrO/vEw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAsPe-0000000C6ls-3Bqv;
	Mon, 20 Oct 2025 16:07:10 +0000
Date: Mon, 20 Oct 2025 17:07:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: abdulrahmannader.123@gmail.com
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: RFC: Request for guidance on VFS statistics consolidation
Message-ID: <aPZeLmx4OCH3BBTK@casper.infradead.org>
References: <20251020155228.54769-1-abdulrahmannader.123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020155228.54769-1-abdulrahmannader.123@gmail.com>

On Mon, Oct 20, 2025 at 06:52:28PM +0300, abdulrahmannader.123@gmail.com wrote:
> 1. Is the current multi-file approach intentional?
>    Are there specific benefits to keeping these statistics separate
>    that I might not be aware of?

sysfs files export one value per file.  See
Documentation/filesystems/sysfs.rst

