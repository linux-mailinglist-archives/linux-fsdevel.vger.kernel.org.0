Return-Path: <linux-fsdevel+bounces-39037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DCA0B88E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846B31888C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562222F171;
	Mon, 13 Jan 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dd2QTv/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775E22CF3F;
	Mon, 13 Jan 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775968; cv=none; b=rKeiNo7dy/t0AgcSFb9ItsZLh6npTtXto9exSF2MlID+aj9PdH1HB5K2TKY2ZplzbDUl6GiPgF/1wdl6cxOqP+krF1ogD0E3JIvoCAZkY1AwbB0/nCtMAndilDlxt4N4/JiPItJKY6hNmvFgmrqjC3mh3PW/BTBRJK4lj9ihnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775968; c=relaxed/simple;
	bh=/KjVuxriQplZZvCD+gxuTOaPR/R7Ji24KNy3ypWbQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBBp1nFRuox5luV68XZxfkMgygL70uPrrNwhVApfsVMakfVIPnHJ8oFCSwFPt34o5KAG1JO0DYN4CqzZIi3I2lJgJZAfq0bHgQzyy7aall2qyLB1qKeNndwlDKVqnN+V2KdvMbDP3UuZkeBzG0wh6R56dQP1BfIInZrIovfsK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dd2QTv/Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VvP0e9YArN6B3UfWfkc7Tkwe7mdJjfmpdHvD597Eg9M=; b=dd2QTv/QBH8zyJY4djkIoU8ngd
	QA5Lf6nzLAj6IGaLDS+3XzNscJEbV5nEZ/UtsRA17h9LSz86jMcYTGn2fiROD070sMCKWruYPwO29
	gIDMpw1a30HRKPj9v199AdaA3QARwBGDnFP8X0CwSlRZxDL7NBh9HWGJNiklxNlC0bSMTtgT9Npem
	l4/x/J71kiXowdNHmojnhcVhkjYVYywueaBVJdd6lY4cHPEDrfeyXTB+wW7F/AXPYSAL7Gd7pBhPq
	VWnshn4vQVQMkOKO/g/1/QwObg2KsVbU/nDzFMiosjhdegkXpKDN8EBggxyD+na0nQxhIO+irL9OW
	p6M8EWTA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXKlJ-00000000mFp-0dRA;
	Mon, 13 Jan 2025 13:45:49 +0000
Date: Mon, 13 Jan 2025 13:45:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Remove PG_reclaim
Message-ID: <Z4UZDAWj_8Ez-vN-@casper.infradead.org>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>

On Mon, Jan 13, 2025 at 11:34:45AM +0200, Kirill A. Shutemov wrote:
> Use PG_dropbehind instead of PG_reclaim and remove PG_reclaim.

I was hoping we'd end up with the name PG_reclaim instead of the name
PG_dropbehind.  PG_reclaim is a better name for this functionality.


