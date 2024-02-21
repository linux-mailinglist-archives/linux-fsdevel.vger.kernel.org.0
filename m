Return-Path: <linux-fsdevel+bounces-12259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E285D864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1EBB23D0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024BF6BB27;
	Wed, 21 Feb 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6zGfZBE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837C6996B;
	Wed, 21 Feb 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520042; cv=none; b=AUup9wiR/xRwyXvbZOmgkiT06h5bSItK9TycduSyc33n/Q5M/L7QkfIcXMItRDc3Un6zow2iTlqrVUHMXDulZmij2Ilw2F5hYb/17CaGL1gMzs/taZUDCfScc8wNRuxCRxksO3vSgm40RGocAVZuaxKsmRem7DxJmLaFHcyrmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520042; c=relaxed/simple;
	bh=sGiET0xN9hzb4InjiWaqljy5e6057YTe0jFE9du/PDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4XYs/uDOZG3/P6UrOkKBNIye6vKxWSg5GAuigftFS34/0MYJWMB2v8WFPnpeMoWV87vAGnTGDunhF0qu2AJBrSgVpHddSdnzfwv0hEep+BFtJvvY3fpcErknZEpDRJK8faWCFdKHjgo3NMjPkeZgqxmLb+WtcnkFNHgEVUiCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6zGfZBE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U3tS2U7fjI3XT1dHAOSsOfyc5Svv4m3e3L/dHWrwhbM=; b=N6zGfZBElVsIA3qFNFyhKubrdV
	6Ltaep4JfSvYR6yiOj+5/keq2j9j4qBx1ElOyVA8aohNd3BumgEd9ykR6oMLuQsT1sErAkihZ1dJ/
	rsCss4OpOd1k9nJXI1Qj69PxvGxJwpIa85Z7hT1tfyygliHtS0aHsOUIVpllMU6QO0Z0Ki7EnCMus
	WIK2BDtjxnhGSXlI1i8aK+cra+Z4WUzPXVzClCBx1q0I7kGGRkQ7u4oZClzb16qjZ+QRDuN47bYav
	xSRtO7ZVtgVblGkfWpFc8Z7yweFV8ksYhgaRigCIjbns2zZRE6IAHg7qF7qPXYG39DI2n7yBptEDk
	x25y8puw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm6j-00000000lEa-1BdU;
	Wed, 21 Feb 2024 12:53:53 +0000
Date: Wed, 21 Feb 2024 12:53:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Darrick J . Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH 1/2] block: introduce content activity based ioprio
Message-ID: <ZdXyYd6WCXTXbhH5@casper.infradead.org>
References: <20240221075338.598280-1-zhaoyang.huang@unisoc.com>
 <20240221075338.598280-2-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221075338.598280-2-zhaoyang.huang@unisoc.com>

On Wed, Feb 21, 2024 at 03:53:37PM +0800, zhaoyang.huang wrote:
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This gives the impression that in some way I approve of these patches.
I do not; I am sick of reviewing them.  NACK the series.

