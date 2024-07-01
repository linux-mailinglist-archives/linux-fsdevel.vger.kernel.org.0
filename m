Return-Path: <linux-fsdevel+bounces-22832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F191D5C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 03:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD11C20B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 01:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC52748E;
	Mon,  1 Jul 2024 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByQGJqIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502AA59;
	Mon,  1 Jul 2024 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797557; cv=none; b=Ivf7a1zdjSguSkcTONqtxsZxFVSP8wMMcKZtZ3Bjk+/0Oqz2Z1hyyMNCmZOzim7KD+gdbZALBPUPke0kibwfJLlJtoUfTSLE3mL2CvZbOX1k37ok8dZhh+Od8pfpfUy/VUMxTCGlMLxVVBVser0aUWEYTc0gCD8+/GgPmD46DoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797557; c=relaxed/simple;
	bh=K1t2Tw9n1Cy7rB8NRwbzX4nQwrqAGaSbuxjDdFUF2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOFRICkur/6z8bczwCqyyorSAJYgwFETTkIf6YSH1dek/mZ9bhZ5V9el5XyAbhqHQuPXM4py/HmD+nJFxiJFai4IrDA58g1QshKefncSve75pLGB53KV1EOotX/Sjhy4/CsAnH7ndgExnDcdXlV8Gp1++H05veVRCkU3TuqHU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ByQGJqIk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=K1t2Tw9n1Cy7rB8NRwbzX4nQwrqAGaSbuxjDdFUF2b0=; b=ByQGJqIkMc7jqly+3B9+FkjkYF
	utgM9OGm615mh59TEwG4fHb3MjF+hNeexxIjEzQuvCJU79ZZL0gS9tyRtVUjo3SQwjcK/YiwlY/OA
	oPNAo1YCTQ+WuhsevbWKafCt/TZmrOrurQyY84O7+Lr36oRywvyp8ImfMHXiAETJLOQqVyLFv2aHi
	WoDuq6Gd4U2dd3aX1KxylmSarVmbxvk2odUDELSzb9ZGCqA98AeirKyt0Eij4DPhKXnZq6NH5IhxA
	mi+wLNQu/Mgnyvue6AqyXzk7fs5Wp8DvSaecrr9qgpHua5lKxHOjxnFVi/4PdyrFtfWJ+EQoL8ddH
	wifHe1ig==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO5uA-0000000GqSA-29Ry;
	Mon, 01 Jul 2024 01:32:30 +0000
Date: Mon, 1 Jul 2024 02:32:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Message-ID: <ZoIHLiTvNm0IE0CD@casper.infradead.org>
References: <20240625211803.2750563-3-willy@infradead.org>
 <52d370b2-d82a-4629-918a-128fc7bf7ff8@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52d370b2-d82a-4629-918a-128fc7bf7ff8@web.de>

On Sat, Jun 29, 2024 at 09:45:46PM +0200, Markus Elfring wrote:
> Under which circumstances would you become interested to apply a statement
> like “guard(rcu)();”?

Under no circumstances.

