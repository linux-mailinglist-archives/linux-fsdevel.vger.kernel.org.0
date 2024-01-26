Return-Path: <linux-fsdevel+bounces-9071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6383DD91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404CA1C211D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952A1CFA9;
	Fri, 26 Jan 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ALc1XdHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DA1CF94
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283244; cv=none; b=a2/h84QyFFpi1J+TnR2HIEQDy3VS6eoowazZ/IH9Ug8w77iKlx3VdsH060sb3LbPc829rKAwjO3E6tVGJijNbUCtNrS2WlkGQWt9oSviLYollIisSNd9kTPnbFfOOIwejp22WljX2rbme8HldeHYjoLuMG3dCXCU4MrFpakuYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283244; c=relaxed/simple;
	bh=WeAp1xpKSBY3b0T+ZjH+l8/LX3iYDDtbdJO1FNyLvCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RijzsesgZSSW8csdJlR4acviT8RwXU9yTaK0JUmPdrpZ/JvMSUKAGZNmbYSYFYp3aUmXdL3mxabwDjHS1a/jJl1Hoo9HdT0xKlXEAHurhF/iE+QbwHe4K3/ObajNnqtVC3M4IkY/b0ukKnX3Fw3Spk0cBY+R7tgjOVirdCtitVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ALc1XdHZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WeAp1xpKSBY3b0T+ZjH+l8/LX3iYDDtbdJO1FNyLvCc=; b=ALc1XdHZbyVUH4nIB2kLPP3cGX
	efc3fqy/n5mLxMtXV+QwwCJFcW6rsP2kK8wj+sqWGD2WIsX0RVTZqvniWlNM83yd2hSua8Pduh1sV
	9CnABsVn0HW/Og8u9x6ywcvZ5FkYk/U4fAWTE8XsQyVSJrk3W6DkAns3DDX4LPqr8b9NpAaleY3h2
	DWCjLNZdDEREzLeG5StqLPCu8ScrLNCqdi86aIFx1hvQrX2tOAhh/148XsznXGLkwljvEmSRLkPnW
	S7CZTkXCqVoWKWqHlFDBEi5oNIVTPF23a8sLAJaqz4bimf0enWJqoUgxbUihFxoyk+RscqZxTEzsp
	NOcrLmqg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTODQ-0000000E2E2-0dWl;
	Fri, 26 Jan 2024 15:34:00 +0000
Date: Fri, 26 Jan 2024 15:34:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <ZbPQ6K5am90uzhGN@casper.infradead.org>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126152118.14201-1-tony.solomonik@gmail.com>
 <20240126152118.14201-2-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126152118.14201-2-tony.solomonik@gmail.com>

On Fri, Jan 26, 2024 at 05:21:17PM +0200, Tony Solomonik wrote:
> +long do_ftruncate(struct file *file, loff_t length, int small);

Does my suggestion to drop the 'small' parameter from do_ftruncate
not work?

