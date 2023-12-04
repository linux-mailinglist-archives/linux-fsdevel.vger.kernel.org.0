Return-Path: <linux-fsdevel+bounces-4791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92387803D36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D851C20A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33F2FC24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQZ6lFKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189AB9
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qih1MMcygv+L/VjoGaoIvgl1mwsYXvUSRf8N7krWJcs=; b=NQZ6lFKU3EFNi6+S3miZtMSyOz
	Fr02q5Q3nuxjCQhTDjXdY3FfL3llkEaulnLhWL2cbHZv2K78ttlaC2bvREaQbCzItgDF8ONq9OjLq
	EF/2GUAIv6X6HZLRBwQTVDkhOgTVlTJOVzteqTTJgbY3kmj0hKJZ/eJHVMy/aUGVWs0WHpSKfOHrq
	bWxcS7qQqOp9hpR9oHZaMhOlffbsgkl3MjQF8aemXHLnotr0ExpAUf+NN6R9xxXpdiXjGkV0z0Ii/
	0fqKAnFzUE7Wa6RM2GUib7izMNUNfAaKm8ZpEma9MfnMogEky3/hUegymZKYhvaVOITZB3stY4fbg
	nCh2F66w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rACZW-000ssm-4o; Mon, 04 Dec 2023 17:17:30 +0000
Date: Mon, 4 Dec 2023 17:17:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
Message-ID: <ZW4JqpKAc56aIUhF@casper.infradead.org>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com>
 <ZWzy3bLEmbaMr//d@casper.infradead.org>
 <ZW0LQptvuFT9R4bw@casper.infradead.org>
 <22d5bd19-c1a7-4a6c-9be4-e4cb1213e439@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d5bd19-c1a7-4a6c-9be4-e4cb1213e439@redhat.com>

On Mon, Dec 04, 2023 at 04:09:36PM +0100, David Hildenbrand wrote:
> I think for the pagecache it should work. In the context of [1], a total
> mapcount would likely still be possible. Anything beyond that likely not, if
> we ever care.

I confess I hadn't gone through your patches.

https://lore.kernel.org/all/20231124132626.235350-8-david@redhat.com/

is the critical one.  It's actually going to walk off the end of order-2
folios today (which we'll create, eg with XFS).

You can put _rmap_val0 and _rmap_val1 in page2 and _rmap_val2-5 in page3
to fix this.  Once we're allocating order-1 folios, I think you can
avoid this scheme and just check page0 and page1 mapcounts independently.

