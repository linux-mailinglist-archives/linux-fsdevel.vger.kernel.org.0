Return-Path: <linux-fsdevel+bounces-25956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926669522B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F69E28454A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712A1BE864;
	Wed, 14 Aug 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nf+cUyKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F61BD4E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663965; cv=none; b=lADtWUrK3wMzFQvL9MLC0r16PuvoasqR29jUK7HPEoJxpwLPyhAmpyzHfxJ46aEc+dE5tIEYxQlqZttTewENXs1dXvFW3hI0XW06Af63Kjv1T9vhN3kyhnH4+aD6JD1PnBPLojjagyWfLBi27hIkQboxD4Mdd2rJzEeRdP1W3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663965; c=relaxed/simple;
	bh=ag5DESKQqIP2kEdlEgBasE6kzldncqpyC2lKo9gNJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl9lAZXqpjVQX98aG3bu+LfD7eRM0tUDGmRE9gwVOPHrYUrWuhUS7xuUmPcp3IirRycY0+eesF8RPGniOyAfYA85sx+52KzDZw/UV9LIqaC1GqtdodUGArkYADBWpwlEL+VybUDpU2Ju+hTbcQ6jhJsC4N7Ora2i8x1jaOCI95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nf+cUyKm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B+iKNFlIOqzslwyjFSZ8FWds8890ZMsk2aV69fNNTVE=; b=Nf+cUyKmuaHUX/oLnG9g7M0nN1
	E0O31MMvQmpA248G40jYqsINx4lUtbiYVRhsgCytdj4mNLlLxAwenG63x6FPV7yO7j/n2iea3CSTT
	GT9WYQbj3kv/dRuYGXN/91ULJ8X59MjoeZRh8O/HUabN8jI3vBkXuMbLSHqBr/Lu1dQc3H9bZ5BIi
	++JMG/WYVT+5yVk8wyum5AR7vygML24URuiVgbHHxbKM5FhFfTvpKGdh9p5M6VNglsBwjCQ0cZRmf
	R9iXe4+lbFya1pAVBix3d8s9uGJdMm9TB74LIYYEJOJDRDRShQO2PUiQRU8TXEXrdTUYl8jnT8D0/
	mk0ZUkhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seJjS-000000011Ib-1M6l;
	Wed, 14 Aug 2024 19:32:30 +0000
Date: Wed, 14 Aug 2024 20:32:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
Message-ID: <Zr0GTnPHfeA0P8nb@casper.infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
 <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
 <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>

On Mon, Aug 12, 2024 at 02:36:57PM +1000, Greg Ungerer wrote:
> Yep, that fixes it.

Christian, can you apply this fix, please?

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 68758b6fed94..0addcc849ff2 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -126,7 +126,7 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
 		}
 	}
 
-	buf = folio_zero_tail(folio, fillsize, buf);
+	buf = folio_zero_tail(folio, fillsize, buf + fillsize);
 	kunmap_local(buf);
 	folio_end_read(folio, ret == 0);
 	return ret;

