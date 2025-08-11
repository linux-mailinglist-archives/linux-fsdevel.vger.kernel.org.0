Return-Path: <linux-fsdevel+bounces-57439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6023B217FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 00:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62F062448C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07592E284D;
	Mon, 11 Aug 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SbK9YZ/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAA2D876D;
	Mon, 11 Aug 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950349; cv=none; b=ulUwKQiq7U5eQG15pHYBTOBtafvqbHbgMm4hl3FsTc9Dol14gg3YM0WBjkX3qCz3avdawFXQWm5I+WJ8JX3IWRJCFU9bC6VyhNDFAtgDIign34rSq//hcvfZ5IWR/TOxjkkBlhOiGSl6l7/SgxtOC5Yhyng+d+Q3ux6gEV4n6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950349; c=relaxed/simple;
	bh=HQzW0W9hUpp+D07ct3CNrIaVtPJNUUrETiIKOlXVoR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTh8mhSya+/zhc3u1TNwwhFuNpfvO62O0VTCJDRRX/36lZeSoyIs9Z0q+DPtT+BpodK1AlmN8oZ3U2bFbSd6fOkBZHgMAPZpVmoiwibfx0zkDxVLEkn6+XMgOeTLAh+EpJGTznNTnnHwznfuaAKPZ8z6C+OjxgzLS7tv6nd7Dik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SbK9YZ/f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rXqzGHAwzizgQD53Mjxeb903A2U+44cwCUAeygyiGKM=; b=SbK9YZ/fUv9DCfDjNmheFRS4wS
	96oZ+qUTvCJk1lHMAo25sHKSescMQ+9sNFYmzQMil9ZI0hVuDtLvuTATGZFZR3p7epAPToeL6E+E9
	DN83yl3uNYBVCMbBU3fHWjQf0TLD1na8FgRYd29QpkHObCw0k1ETjlgrOaVUF7ViXg3w+LEtyH/3q
	Zj4p8lH5OC1R1CNzvJJUc4DvLcMI7O5elCS+cqM+YQ4vP0hWcruX3KjnRXiPkPVavkZ4pEcj+qWEX
	MkrantxBfj5qcN/q8r1+JN7D/T3XHxFqgMcPhgleggxqKZ/P4BWn6luO2AYDJujtVlJg8DbzAiUgI
	13fYZc5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulakd-00000009yzg-3pn5;
	Mon, 11 Aug 2025 22:12:20 +0000
Date: Mon, 11 Aug 2025 23:12:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Hans de Goede <hansg@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Convert vboxsf_write_end() to use
 kmap_local_folio()
Message-ID: <aJpqw4HhLVsXiWvt@casper.infradead.org>
References: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>

On Mon, Aug 11, 2025 at 05:42:00PM -0400, Tal Zussman wrote:
> Now that vboxsf_write_end() takes a folio, convert the kmap() call to
> kmap_local_folio(). This removes two instances of &folio->page as
> well.
> 
> Compile-tested only.

Yeah ... I don't know if this is safe or not.  Needs actual testing.

