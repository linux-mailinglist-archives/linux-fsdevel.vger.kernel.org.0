Return-Path: <linux-fsdevel+bounces-45731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F71A7B8EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FA13B5331
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CA1993B7;
	Fri,  4 Apr 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmBxv3+Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544791684AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755475; cv=none; b=JXowmZA0ZEIXXh4HM4AGOQnsdZLw8DHf1CYppOR51QfI2tn++3YF6etBcv/VmUhL5PM1f6Iv/BB+PfiicFwGer/M6gLnRVko8/d1IyFCp0yRcdO0TLQhIyZ5TYc6qSlEKyKm9DLGbU645yWIAnYItTByCSwsbas9d2x0R6m5kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755475; c=relaxed/simple;
	bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ioy3xDLxNpSsTSsVoqn55bnIuIqeZeyOIL/iB+24vRtnKV83TA4qe+U6eoAZtmIDIK90RA2spZvozIg38rdXOx9d9Eg4ajXpciQKSqUzzMZQ19F1NK0YAqlUnxEVf4nG0ovoZOv5JCN4rNlKRsEvsK65qBHVwoktFL+O4HFUOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gmBxv3+Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=gmBxv3+YsKaQUOox3/D9POOLlC
	buaE3GmpF/BKwDIizPM9bE+SXwlr9WPozDTwla/E/usOJEJE+CuJH9AXDMomS3kxgDaA4sm/g+w3/
	JU5fzwobQjUjjQxNxWsNC2xGRppdEEs0Vye5x2AehKQnRI0YgOBSrlMzOv7G4DAIZ2P5W2uS7/YT8
	qL8qNuc9ovK/Xmfa5sKCdcK4JAJQh1uqbERIYKgBlv0rjWbp11Opc/5vhIKum1AU3xV8ANFWxKMNs
	TNrIqaqRq1lRUHywgru3b30QqSXTJHjc8makSqjsg5xLnD3Hl6tNGdJEvWdnNNnbWSMz4bOIYTgUf
	xDct+lPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cSF-0000000B9ab-3R5k;
	Fri, 04 Apr 2025 08:31:11 +0000
Date: Fri, 4 Apr 2025 01:31:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/9] Remove aops->writepage
Message-ID: <Z--YzzLSj7B7ltYE@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


