Return-Path: <linux-fsdevel+bounces-29750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BDB97D6BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E88B23FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62B17BB24;
	Fri, 20 Sep 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FhxmYPUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180371E87B;
	Fri, 20 Sep 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841842; cv=none; b=WmveNbozZGipnbMj2w6X90SxCoE6uCTwR+LSzSTqol10DshlBthIS865pBWw9LVvalmw7PBZf6As799rI+0xhVI6geGL8dAUYaj6kLf7NO94MuQH8bozJPdN3/YeZjVSn6cl/WvxtVLUDrpEJAUAxM5kyPF2ev0QqrMeW07Pb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841842; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsXPjLhNJJbQEccEcOLhko9soJTrANejTInmGENflKBVbaPxxOdxO6nrDBbZmJ0f34zGAc48oQFg58YzNbve176GMoVySWh7LAf5lNPb3tZBP3MILfeqzXPRaQSyOlz5TdY+BJSTOCL2vdS/IgM3q2T9MEJ+h0RvnYt/CxavKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FhxmYPUc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FhxmYPUcXXwLcisDd0n/hG+19c
	dRJbP6j1ax4cBp+9qHaxMmXp+OaIQL4ca/lEEgl1t4HzcHTJQJhqnMKCI4Urrl2Uelpxqy4y1Jl/u
	j1pgVZkqK99xKSEGQr/aiTBdzHC4SaLCUDo73TId4HKoa8c5PixSYTuRBOXhfyVTbp3aCs3R70iHp
	mPfcDcX9PUkXNtWqzWWfXijPefQFJlYpGrpEwNdmgQLD1NVb9e8o3rwTHus13vwexUbkJ1qeV2749
	kQ0IeKYGzu+re+SZr6vpcVSTDvs04oVmADpWMdF3il25nG1xCU3hOUOpKIYbAMPFSpeu3pu1Bd8XQ
	L+8KPMnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sreRj-0000000CMS7-2UdD;
	Fri, 20 Sep 2024 14:17:19 +0000
Date: Fri, 20 Sep 2024 07:17:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	stable@vger.kernel.org,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing
 overflow case
Message-ID: <Zu2D75_kp7z_-Tnd@infradead.org>
References: <20240920122851.215641-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920122851.215641-1-sunjunchao2870@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


