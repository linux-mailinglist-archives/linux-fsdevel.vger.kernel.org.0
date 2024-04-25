Return-Path: <linux-fsdevel+bounces-17817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C58B2883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D841C21BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA921514DD;
	Thu, 25 Apr 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jxve/Ywx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480B14D717;
	Thu, 25 Apr 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071250; cv=none; b=pw5d/U4B7Xm94q0ju7Dp1KJEVuJQNTwIhx238oc6o0PO9aVk3n1XQjD+Bn7PqyMLHbTcIssBDe+RP6bedHG2qYo+DE2e+Rt3YlZGBQmPH+nvJS42doyAHyPbBMoCRKuls0LVdE979zHYO9cUfjlyrHs6mLtkNwJjH4PHgb1VRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071250; c=relaxed/simple;
	bh=EmD01qjkuxsGFRwgYYLCHqdE8rYkUVWUDM7DxHmc0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFDOoJQ4IfNMt3rGUTJ1IpPAKIyFoyPSuF7+aWi6ADY7w5BrMX0Q9OLhy76/8tRzl4tkZpQsUs8BcTYJe2sU0U3Y5z/5FcdoQEa+FyILWy+kmcJg2Atsuub7sTxVbkXArL/MTlgp755lpZwARQDszn8Q2aiCZxjIvUzE6pAcc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jxve/Ywx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oyktM7E7M+KuWF5/aH7rtY519Fb1ZAYOKfjC4XC5Z9w=; b=Jxve/YwxL+dQtqIlLtYdKWLJMs
	UbHt8PJvUuKGgFbyB3H/5NK/iatBxYjqomlid8oQOKtjGb/7lMi/9+lVr06WliZh0NZyxuEalolj4
	vyNiKjVObuqv2rnIgkltCLSW29eDwOXj5WiF+di6I1l0zKXkRkt6SbG8OqH6+NCnCtxQMd9ZLPXNg
	ov2w1wl4w5UwEqDCzwWnAYQrrNeYzO6BDIAiN/tuRCVA/yuz1EEKLRpk6xav/3RT81EL3RmVvwAgF
	kNBk9P0Y7DcOxH1NZPnqVX+0LNpHA1jrI7WovPoDfiyCwIPnEKRyzRIoKDgJTy55B+TnC6F/ATIlt
	pPpvhqJg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s04EG-00000003apA-0XsP;
	Thu, 25 Apr 2024 18:53:56 +0000
Date: Thu, 25 Apr 2024 19:53:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <ZiqmxCn0ks_GUq5-@casper.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-5-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:39PM +0200, Pankaj Raghav (Samsung) wrote:
> +	unsigned long index = readahead_index(ractl), ra_folio_index;

This is confusing.  Uninitialised variables should go before initialised
ones.  So either:

	unsigned long ra_folio_index, index = readahead_index(ractl);
or
	unsigned long index = readahead_index(ractl);
	unsigned long ra_folio_index;

> +	unsigned long i = 0, mark;

ditto


