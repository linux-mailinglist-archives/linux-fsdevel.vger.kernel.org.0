Return-Path: <linux-fsdevel+bounces-60248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B94B4321E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A2A3A9397
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792ED2505A5;
	Thu,  4 Sep 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LgFIc2l+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A62215F5C;
	Thu,  4 Sep 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966501; cv=none; b=dD3Ds8FgXmt1eNASn8jnmIYN2Ay5swkaYeqIzHj4Vb6Y3pRocExBHh/cAtGKVbklZ7QYPGgnYVIkT20t2Vx2NDn5AhoBFbVpfTL7PaL3f3LHhBZ4DPmujWbsYDnNZMYxKGxL0a6p6He8h6Wv8NGH3EtRXKFumhoEL7LfyXzkTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966501; c=relaxed/simple;
	bh=1+CwnDoMMZ7vTlVj6cM6tOXDdDv5gY9fojQdnH/iwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H38epQCQwVGej5I3/wpJ1Nhk4/5tIRmlkHgpaz9K642lZx6K65asIJHkRJLJ0VbFpnnwsRAeJXFgXg+hhYmZvFGrMW4s+Sx1nYUy2ENueK1Ozc60ZbRQ2J2DgP4iSr2V4PlIk3a2nO3Q/LMIJnvsImIi6iS0JgGPZtYJ3OHLwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LgFIc2l+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1+CwnDoMMZ7vTlVj6cM6tOXDdDv5gY9fojQdnH/iwv4=; b=LgFIc2l+FFZUtYoCHEf78Wm/Xv
	gxEq3sKpmF38fO/CjcQTYNvpuLn31TAojPSIoBO3NHvVPXgZnlr5PnmGwBWzk14kAucQTs1NAOw4B
	NasRaWUgCIWxRfQQ+VDI2lDTJfemOaCJ6nb8KZeGTGdlXcAEzJ75XR/GH4yvVGO1HUcMqazJ4ibWA
	av0xTwLgGVRFoyVTSUMJ8opdMwKpjtePGXD0jRs87LMn3K2tqvuIKSDRh6GuEpDwm/6jRymCHfSuG
	wnVoXZHc/za4B85fAuWoMNM/d2LD2+Neck/MlM/11tQ33689BJoIerzRV5hbuRkVE/AbLz7scd0XL
	MpxW6BIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3FM-00000009SSl-1fm4;
	Thu, 04 Sep 2025 06:15:00 +0000
Date: Wed, 3 Sep 2025 23:15:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 08/16] iomap: rename iomap_readpage_iter() to
 iomap_readfolio_iter()
Message-ID: <aLkuZFPT5ZTtK_gQ@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-9-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 29, 2025 at 04:56:19PM -0700, Joanne Koong wrote:
> ->readpage was deprecated and reads are now on folios.

Maybe use read_folio instead of readfolio to match the method name?


