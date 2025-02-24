Return-Path: <linux-fsdevel+bounces-42443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51DA42700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0EC16D977
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6479261381;
	Mon, 24 Feb 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qP4VXbmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797D233714;
	Mon, 24 Feb 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412321; cv=none; b=Kj0ouPU5+irBVvOJZknUXQJ9bjbhRk52QHhxIK3Y2BTPLrRe4YxVe1vCuGQjUPmS77W9yoQOPWEexUShDS5Oe7XnxyAFUzEhr2dNEWIW+Qcf0fA/pqAnBRDlTss922Bz761zKkLi9D8AqnkRsYG2U3yBUMnqY21XCy5vG9zYtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412321; c=relaxed/simple;
	bh=1BdY7wS1iEF+XSdGwg6zBRnRVuZonMiaLGGShRDGGp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5RXY+I4xj6F1sRlWaGl6EL3OksJBjNgPDW+2ZAoeHBtB1NGG8MZxSCPMK1SB/DlQXWrsTGhJT5KnnxephH/KeSFfKIR4FUct6vkzpv8f60IMEmhKgir3gLj3ZhFE2OXypjO6FQKIHg1h/C/iYYFK0NDr3wdaDIT0dqiZmKD5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qP4VXbmR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J+FNxXVBZwl7yffXOvKolfq89JH5xPgIKGmft+woAV0=; b=qP4VXbmRvMGXQ3UZk6cclJWoCn
	8YE1m0cDFl3Sl9WQsoaPVGFqQo7B3ej+V9YsYTV2HQIUuzQ81ZG7M5QXq/S8A7DcJwQ8HxcuxJjvl
	rpUsL9qm88a2F6PElI7OJKK1p9sX0yTjN/2ArkkDMvOJ8Wp5UTdRM58pJjbQVQoFsdG14gio7qSJG
	OE/hNxFFLCR2H8vCdWlflVIRfzMmW3wcZgADCanQ7IK3ehMfMSZTIFNZd4MWpQgDybbtQY5NpVJvF
	Az4eiirGd2XTJQcvaNYqdkSJb4WVwhTEHyuPSYOfXDl7SGX93+gDzWPep7PTH/Ltpp8nG0qN7a3lu
	qHz2AM8w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmakQ-00000007gS0-1kDH;
	Mon, 24 Feb 2025 15:51:58 +0000
Date: Mon, 24 Feb 2025 15:51:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z7yVnlkJx23JbBmG@casper.infradead.org>
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de>
 <Z7yRSe-nkfMz4TS2@casper.infradead.org>
 <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
 <Z7yVB0w7YoY_DrNz@casper.infradead.org>
 <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com>

On Mon, Feb 24, 2025 at 12:50:48PM -0300, Raphael S. Carvalho wrote:
> Ok, so I will proceed with v4 now, removing the comment.

No.  Give Christoph 24 hours to respond.

