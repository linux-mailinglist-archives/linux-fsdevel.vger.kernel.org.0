Return-Path: <linux-fsdevel+bounces-35754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDB9D7B9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 07:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2143EB21B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251016CD35;
	Mon, 25 Nov 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zlQVfiY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518512500DE;
	Mon, 25 Nov 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516822; cv=none; b=RK4Clm+gU3DAz+NurFLk5XBMRIYsl0sPJD9xz89Fm+t+BmFzEGTzGN+IxL1SOmnwj3AVZHM9x4/BFvxSc/HONOvzPcSyxa5Tk6SiH6IQunIf+2cTheTDMEIlrFql8zEyOt2Q4S22Y8e8Im7qhYlmj+4WUFH9LbZ0QebyG+bGPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516822; c=relaxed/simple;
	bh=DbFh53SeoWGKBqeqW8X3ADxzrwB4Upr6iTSyJPOGXdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUDuewdGENRqT6jZp21faQJO6+e69fmOKwzesulLyCnLq78s4WmRcgCpnAL4nSkFqIRccWYhme0Pda1vvEM9+NkGydHK0W9PRuUzE1oGAFURfbZhyHk/Vccwoy7lNf7FDIKaBKeV+ffRhix30Q75rp3B+pxzkyJTFQwp+DSmhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zlQVfiY1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5mpupi8/X+Jcwk+pM+I9FE3bwtcCMUTbjkCOBAahy5w=; b=zlQVfiY1MVxihfZ41J/cH5EzDZ
	gouUZGypOYKrWg86WdREcu+HDEuROY0ehp6hChx1VM1ck+L0xIl4SBF3jVFlZvDH6DuzJhH/qG7RE
	nrbM93D4rRpeChVhoWTLHVGnv6jGxwLIg7tcogyBU9G/cDmIL4/8wJZozIcobNfOyN6j897YVuCiR
	+VlNjiqpCU86dYn7wyOJjeHT3RV+LnVqUX3KHnESu1tBBnYLnEE+IjMs5EWs/rdIrEEL2TLQ2V2NU
	vzTUvhC8S6oGVPcSt/C6Vqstz2rEvgRYYOVvE+EYWkafXIm8dEo7PGEW3HmGj3eXJsor879xj2zmg
	2nNuwzZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFSlg-00000007ArI-4AsH;
	Mon, 25 Nov 2024 06:40:20 +0000
Date: Sun, 24 Nov 2024 22:40:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Long Li <leo.lilong@huawei.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0Qb1HKqWJKyR5Q0@infradead.org>
References: <20241125023341.2816630-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125023341.2816630-1-leo.lilong@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 25, 2024 at 10:33:40AM +0800, Long Li wrote:
>   1. collect reviewed tag
>   2. Modify the comment of io_size and iomap_ioend_size_aligned().
>   3. Add explain of iomap_ioend_size_aligned() to commit message.

Just curious, did you look into Brian's suggestions to do away
with the rounding up entirely as there is not much practical benefit
in merging behind EOF?


