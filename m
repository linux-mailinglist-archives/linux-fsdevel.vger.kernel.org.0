Return-Path: <linux-fsdevel+bounces-13237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E0B86D9E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E84B22266
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5641C93;
	Fri,  1 Mar 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="APX3wsoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958640BE0
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261347; cv=none; b=QHd4ceRjb8MUNPBxftJy3givaYhvYJiBYjFg7aJiT7bcbblplOywiK3OKhf4npU6NL4IuVvxrgtCQxLV6H4I+cnSKueKtW6WyYqmm+LHVL4OdouvYMgdbdRkWCZe5C4vrBzdfv/PAJKosEegUnrnwzQ9zgPhpGaTZBO2vC0sQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261347; c=relaxed/simple;
	bh=AjvcAEAjMzfUz8OjT5t7Y+LgCa352AKbVmGmmiMfqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2zvofe2Dw1zUbq8U6YU96W4DynOmG72KuSt6JwY5P8JorttOwWLB6aL0yVBuTROGhpzuyg/olra1LFcPd4FMgUtbk6XTjiOUM4/rsCIVFJlqPJiMAFcV2a4ZrYFANhMMnPORFbNJ9wwGxIP6jXdfb6lJJPyz8BV/jlytWiY+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=APX3wsoE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6b1p1CdxXqPV7bP/CjdoesvhrJHckhGwDXs2VSS+vDA=; b=APX3wsoEeg4QYO0/GObrtgup+E
	HMFJCf/5HamxqqI4Ih5pRmfTnBsv0TBs0JH20L2dtED2V1AZTsLu8U9RgdCvU17Pg0w43IAVCEnG8
	D5aNvyHYAYNNHWzxXegDJnThYpAgovn8yrrV5mMXTx/iPSldHhrwIuMDbTP2ARAux+MhxHdfozaBg
	+XDa5PPH7o54uok9b4Vt6Jtlw7+kM4EKvdkD/l38iOsvt1D8+WD4ZPwsMDK2sbe1VyxsmRW6KgfGM
	Bq/bVt0pIGjjDEntiqXUAwoqFV07pBoSimwca18fvssiI+lKaVMlVAhOcLeRCWZPrCZb/Y8Ak6ton
	v49SZGbg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfsxA-00000009hNq-3THo;
	Fri, 01 Mar 2024 02:48:52 +0000
Date: Fri, 1 Mar 2024 02:48:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>,
	paulmck@kernel.org, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeFCFGc8Gncpstd8@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>

On Thu, Feb 29, 2024 at 09:39:17PM -0500, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > Insisting that GFP_KERNEL allocations never returned NULL would allow us
> > to remove a lot of untested error handling code....
> 
> If memcg ever gets enabled for all kernel side allocations we might
> start seeing failures of GFP_KERNEL allocations.

Why would we want that behaviour?  A memcg-limited allocation should
behave like any other allocation -- block until we've freed some other
memory in this cgroup, either by swap or killing or ...

