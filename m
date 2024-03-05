Return-Path: <linux-fsdevel+bounces-13620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF6872105
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595B41C22DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99686126;
	Tue,  5 Mar 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkYGzngk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1D8612C;
	Tue,  5 Mar 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647201; cv=none; b=NOGxa2Xaxzb8dZYCpKnU3nXYyvT3YZgwobsgLbd3Nhd+a0HbrBLvMN3oYQutVJX6OgivVvC9zpeIXJGGxc/COiTSy8UPIOwCQ5Edb2v1Wt4k0yfkizK+65pKeU2tdq0IJ3GaP2UeqG3aX5DBeiS2twP0AKfcZeqo4j2ox0rQLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647201; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnbOOCNIftlonK7d+Z9UpfJEQGTHBopsbPTlNJSX4oMMRADTV065bu5Nup6i6Vc0uZDRBsGROs5PVdyxgfeRfq4ljMVakQsQ7ce2b5DflZvX5mXsTj1rdtt1ewG7t9E7I+ktvR9mOT+amC8m55MHJityA65GFchiTb/R+rr515o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lkYGzngk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lkYGzngkN4KeD9AeqK0py5VOT+
	OS4WQl6feET5X6ScYZm3bOOv+D14V9xiaQfTBra9ddd8mkpAEJpHC38SUFOgq2suj0KgULBpYNoED
	7y71hcIdPsLoOXq1kSvAx7YwLa4OlXM1jLAmZGMMjqZURALMVRB4MlVsmdZloxJfb8nZgzE2ByuE1
	TyIPzM18NH62FktU5paFhmP/ufXzqH1H/+QL/4wTTLZ9cjZxR3fSSGfLBAgw4M06p9Vpf96lZUl+8
	RK03scoEjnN46EvJoFkNgTfAoOuSZm7eTPoPwqf3569xDng4ihGdnTJ2P5cx0buKxhDiA0O80SUNE
	rpgQQ/JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVKp-0000000DvnQ-1ltE;
	Tue, 05 Mar 2024 13:59:59 +0000
Date: Tue, 5 Mar 2024 05:59:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
Message-ID: <ZeclX-ITKr8pHjAJ@infradead.org>
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-effekt-luftzug-51913178f6cd@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

