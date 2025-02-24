Return-Path: <linux-fsdevel+bounces-42447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF3A42735
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F011188F486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D8261588;
	Mon, 24 Feb 2025 15:56:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F219C54F;
	Mon, 24 Feb 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412597; cv=none; b=GxWWdkAA4wkDzDbzkT7mrew8dV9U284O/TOaMy0fXbELeM8Y/S/dRHhgEzVTUVOZTYmnj4USguHxTeMZKaSdvmYikZ/CZ6ckJ3+EYTllP0JbwphjpC56GGLGWwv1dBGVdOXMG75ZodO+VDArsR5AD0Jxjtexy8b3VC5Jjnt1E2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412597; c=relaxed/simple;
	bh=AoN7Q3B2pJEyvZEruA1VQn66TscELx53nKgDvaHd28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXc0E0XB6wnRJvftoE9Iq+99eTVkf0AtOe3bjjRitxImYo9yArDFEpVvvuMrLBBUKSCTA6DEsh1EUbWj/FsXH6A4aHkrAnS0egM2NWU3VAtW9X/rBRP58jGmMT5osdqiHzhLl2q/Agp+GyBaDjMlsXB5cP9lHNJT0nN0l+1gLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C80668BFE; Mon, 24 Feb 2025 16:56:28 +0100 (CET)
Date: Mon, 24 Feb 2025 16:56:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio()
 with FGP_NOWAIT
Message-ID: <20250224155628.GA4617@lst.de>
References: <20250224081328.18090-1-raphaelsc@scylladb.com> <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org> <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com> <Z7yVB0w7YoY_DrNz@casper.infradead.org> <CAKhLTr26AEbwyTrTgw0GF4_FSxfKC2rdJ79vsAwqwrWG8bakwg@mail.gmail.com> <Z7yVnlkJx23JbBmG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yVnlkJx23JbBmG@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 24, 2025 at 03:51:58PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 24, 2025 at 12:50:48PM -0300, Raphael S. Carvalho wrote:
> > Ok, so I will proceed with v4 now, removing the comment.
> 
> No.  Give Christoph 24 hours to respond.

I strongly disagree about not having a comment, because while Matthew
might remember the issue in his head others don't.  But in the end he
is the maintainer for the relevant code, so his opinion counts.

