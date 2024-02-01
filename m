Return-Path: <linux-fsdevel+bounces-9803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994F84505C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 05:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF831F240A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478903BB2D;
	Thu,  1 Feb 2024 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MROG4QYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57C1E49E;
	Thu,  1 Feb 2024 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762273; cv=none; b=W+tyZWc7GV9oDH79BapE/Y/RiNq6hUHlGpFL990p7JKjx7s4sZmDQCqD4fB/EUObviSmCTRGak77W6rvwuRl4Syi0fXAEKYwlFoogjXaV0GRM93Ur6S+lMqZiaIvbbowOPaKCKt/uNWAQzsBZjpFGeIToNnLm/oKyx1gRWOpOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762273; c=relaxed/simple;
	bh=ARRYNneIEyXEDaxYz6fwEt7fJdvAk9Doy/74t5Afyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbMqZESXCcu6wkTI4iEoQGU0z3tk7wDyfchaqizUWkwg0Fc0I2nGcICTmbe1idQ2kWnS5XFYKYbrEPKkgCkwyZrgEiUvojzCYhXL8AV7poiXMYjTAWiYq3WatniZ2waQPn8Mo3gtv3jP2ZJtkXWdgfetxn75i94Gr+3pdjMioLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MROG4QYT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ARRYNneIEyXEDaxYz6fwEt7fJdvAk9Doy/74t5Afyos=; b=MROG4QYTNG5JZFB8NEnuVPeI8Z
	TNtyPTdK9S7Vr8CYnd88Mg7jPKXLciOp7l0RuZIfOwEqVRofZBfPZKwEzLMm92AMP1ankMW3F7Hqz
	SBmAULRZXzU61nFgfZWuqhavU2NZJ/C7hRvsF6X0bLP7BHeuQ2s3KOjArU7bPcjrSdKzAzrwhelAM
	JDzLU2nxPK3vt+/kmhwR+AcdWMVfXN0LnWscd9tTfmJPsB1lsv/9MoS6pyAbUUdEahZIgGzFtBHVZ
	+QhYPxUSddEuZmYAlo+/nTuwFsjvNyOTmPmyeBzyaWLFewDR4tx5y0sKVcinRTDNuBiLZ6+wGSErB
	bG8+3lww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVOpV-0000000ErgJ-30iy;
	Thu, 01 Feb 2024 04:37:37 +0000
Date: Thu, 1 Feb 2024 04:37:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCHv6 1/1] block: introduce content activity based ioprio
Message-ID: <ZbsgEb9PY4b-LRr4@casper.infradead.org>
References: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com>
 <ZbpJqYvkoGM7fvbC@casper.infradead.org>
 <CAGWkznGLt-T1S7_BM8-2eLhxVYktYYLmdfMbRKRK88Ami-mEdg@mail.gmail.com>
 <CAGWkznEv=A1AOe=xGWvNnaUq2eAfrHy2TQFyScNyu9rqQ+Q6xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEv=A1AOe=xGWvNnaUq2eAfrHy2TQFyScNyu9rqQ+Q6xA@mail.gmail.com>

On Thu, Feb 01, 2024 at 12:05:23PM +0800, Zhaoyang Huang wrote:
> OR could I restrict the change by judging bio_op as below

bio_set_active_prio() like I said last time you posted a patch set.

