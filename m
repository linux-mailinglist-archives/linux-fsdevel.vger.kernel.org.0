Return-Path: <linux-fsdevel+bounces-29069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF89747CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 03:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602071F272C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B305E22092;
	Wed, 11 Sep 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1Eq9wfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD94B676;
	Wed, 11 Sep 2024 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018454; cv=none; b=Zh+n9A5wuTi75T3xbo2UabZkRIPZJaalTqcK+JKzCv1QlVig4+sYo5Ar07yDdlBCsr4/GF9kiTe6gnVQTFhPLBiSDNJsvicA/2bzcmcZbUU8uPiu5HDT1yeLTVnur7HuXSplYqBspvEpvxL53iviy3xs2E4uHBakQJ7z/4lN2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018454; c=relaxed/simple;
	bh=g+qUkng/FdNbH3C8UGjTbQQ+TEjqH1oGwgxN5YG7u5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP/zXdNp5pl1xu35d3vTI8b7xi94WZyVDdPmROTNborlNwR+zxcCdzOqkZQwrvyjk85LB2UdzXPhRXmSjHGNfbBarEtdyLSHSFZstzpr83g94No47JAxAXWDnjZX5foApUi087YyiB98B8eNF+uDYveAwcRS+05U9R3LlGcpje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C1Eq9wfH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=g+qUkng/FdNbH3C8UGjTbQQ+TEjqH1oGwgxN5YG7u5I=; b=C1Eq9wfHLeXbkf8CkIBfEKV8Uk
	aaRvBwac36C4hca5QAxOlZDSzIKoJkxIPDyKUIDSOBe/nOm4wSlG70k5p63OW3D7GDHempFf6Wven
	cdmPz0/sALT20LjF9Vt/zox9QfEaKaUoYvq4TD41c7CIslItWUnnixuj8tjy67T75TEWrzPAblf92
	5rCko0ql+MgL4DrKhYW6SFHia/P6au3V/eJ3u7mE3A2HcR9w4ADpe74upPsgCcLNeMdLmZEXQJaMk
	Z9QHgp5RMmaB9xYANZU5pY/Fh4/cNXOhpsVeL7ngkO3gkGERGZ4mwXUK+jX9D370zDK0/lLcM8BtT
	EjGwL42w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soCF7-00000001Qbc-3oLf;
	Wed, 11 Sep 2024 01:34:01 +0000
Date: Wed, 11 Sep 2024 02:34:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: remove redundant if overhead
Message-ID: <ZuDziT9eOyltK6qp@casper.infradead.org>
References: <20240910143945.1123-1-justinjiang@vivo.com>
 <ZuBtvW9TWCnHte4V@casper.infradead.org>
 <4a308d13-932a-494e-b116-12e442a6352d@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a308d13-932a-494e-b116-12e442a6352d@vivo.com>

On Wed, Sep 11, 2024 at 09:14:10AM +0800, zhiguojiang wrote:
> 在 2024/9/11 0:03, Matthew Wilcox 写道:
> > On Tue, Sep 10, 2024 at 10:39:45PM +0800, Zhiguo Jiang wrote:
> > > Remove redundant if judgment overhead.
> > It's not redundant; it avoids dirtying the cacheline if the folio
> > is already marked as dirty.

> Ok, Is it necessary to add comments here to explain and avoid readers'
> misunderstandings? E.g. 'Avoid dirtying the cacheline if the folio is
> already marked as dirty.'

No, it's a fairly common pattern to test-and-test-and-set(or clear)

