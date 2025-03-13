Return-Path: <linux-fsdevel+bounces-43870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F932A5EDAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17063AA59C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA4261371;
	Thu, 13 Mar 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="buw5TLIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E01EFF98;
	Thu, 13 Mar 2025 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853366; cv=none; b=PnL+OCjUoAuvRllDBhZej4yNhPfIpLNbaOrsbX+t+8VEg6MU1WnvaUQabrWtKRJuSoH9dHKZSDVib9mBAqK/KnlJTPPQS8R4YJsZLlm4O0is4R98YvrL4pyqU1y19PLiuHLb4TBKKUvQbE+Sd5WjYgufuGV/ARqhkvZuQvF+cW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853366; c=relaxed/simple;
	bh=HTYBhoOAH8qqB5eAMcYxpt3clXVxQoGjYcOFRx1uZ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJQlX57BMVMg0T1+LXz9Seb9rt7FAEHDOh9HBodYU0tk68uZoMNsbKsB5lLNXn8jooCv9l2cbCQxgGyz+N/V3p2JHb8vYUd8wJSF+I3VruqBX/1XsbfLsgfqz34SpaEw75PY6JM3DB3VKBjpA/YAfvM3l1BQLAwP91BZnqJD0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=buw5TLIi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jngb08tIaNYFOZOPADK/xWpXXqbqO7deRanXDxaI9Aw=; b=buw5TLIiGTVY1EF1lHWD7M/lZA
	WKscX+M2lfufqSuyp60hAmWrNYldsr0w++E0cefPYzL14jYpiYsMoiNwkBloMJPQ/RmtLImIMt0Dn
	RHYxxHpJSQ6LT3IJxrmzKp48g7MbXPHWJbyLg0539fKmatcxQQ9m3zSMNZiudgikDloqOmyDSylJj
	wpX52Aq1jCzpavyGSmHjD6JXTs2ab1CUhrPWw8ZN0lNKNVdgZYVToX0uXxZARqE89j7faegTdV9FI
	KCaWrqQLyaJ7AKdynE18zOZkVESx/SB7ohZMwBjlM9bLVnHmF3LCEczJUUIL8tLQxyXRHfiPiyVJ5
	ECCTrrxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsdd6-0000000AVGl-05Vb;
	Thu, 13 Mar 2025 08:09:24 +0000
Date: Thu, 13 Mar 2025 01:09:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9KSsxIkUbEx5y2L@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
 <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
 <Z9KOItsOJykGzI-F@infradead.org>
 <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 07:53:22AM +0000, John Garry wrote:
> > REQ_FUA is not defined for reads in Linux  Some of the storage standards
> > define it for reads, but the semantics are pretty nonsensical.
> > 
> 
> ok, so I will need to check for writes when setting that (as it was
> previously)

Yes.  That entire IOMAP_MAPPED branch should just grow and additional
IOMAP_DIO_WRITE check, as all the code in it is only relevant to writes.
In fact that also includes the most of the other checks before,
so this could use more refactoring if we want to.


