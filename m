Return-Path: <linux-fsdevel+bounces-54173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6CAFBC82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474304211A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459021CA0D;
	Mon,  7 Jul 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWV4dvNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AD2E370C;
	Mon,  7 Jul 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920082; cv=none; b=A/x98hx7JrJpqw1G0KSvByAuJuX/jxRpjH+t4UlyPY1GEGwwBnmhWXc+A6zBOaWwwRPKFef5VabPTeFWK92N1t43neKDVryKX23/0rEIr0nLn0hVRiAE7DnpTQXVM/qm/m31mhDjWX8xejVnSJC2vzXMUNe0+k+dzGIqM66RPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920082; c=relaxed/simple;
	bh=4AlC4BxlYGVG7vuDbnpf2nVHE7V26Rt7KLX52RFWz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7UadoeIMbE3Ojatl941HH5yyydPApTlq3U+eJYPw0UiQfqNItnmkms5sxaI/6HyPpIoO8127KngpnS0J9U76jIsEEuTipgEEZHPIeq5QEqDmhf+qnNh9T8wNAAfyX5/Sw2O94ZeVnWF8R3wfBJuvfZtR3JWz0WWrFbPvL+uXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DWV4dvNT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wAa82/dAXaQIBwO4VSNfPeCzWqiriwIUN2Gp2481/Zg=; b=DWV4dvNTWiibE7Q8bBILAJUlPY
	c2AkkH9Gbywmt/SVl5ljU+bqoA+of6xZ7GVpQoy9cVHGBFV+lG0LP30RZTBZI8fnvWJb727K9R/ds
	pJI7XObzLfngCKrvRu/XCnoANLUGERH+KmMKEpgvn4pdZy58SIY1Zwodcr5sXdtTrfJ/KHBJ/4jXP
	pxRxHWN/2DLRUigF4+g+AHOYdjZvwbJO61UX3GwW2rRa39W4n6oXxo9+H5a39FqLxYQWotYqeIYqK
	k1E4Ixnwr64QwV7Yt1I/fcFZJoQTD3TnfXrjJwiTOczX1ACOr7NjhQUfSr8x+KiihSKednakQEKxF
	bK9/Tt8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYsRR-0000000EU4K-0qqC;
	Mon, 07 Jul 2025 20:27:57 +0000
Date: Mon, 7 Jul 2025 21:27:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] ceph: refactor wake_up_bit() pattern of calling
Message-ID: <aGwtzNKatYxN1U7p@casper.infradead.org>
References: <20250707200322.533945-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707200322.533945-1-slava@dubeyko.com>

On Mon, Jul 07, 2025 at 01:03:22PM -0700, Viacheslav Dubeyko wrote:
>  	spin_lock(&dentry->d_lock);
> -	di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
> +	clear_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags);
> +	/* ensure modified bit is visible */
> +	smp_mb__after_atomic();
>  	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);

Seems like you're open-coding clear_and_wake_up_bit()?


