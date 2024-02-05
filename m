Return-Path: <linux-fsdevel+bounces-10243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8684942F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 08:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25DB1C22FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD610A13;
	Mon,  5 Feb 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVRN1gqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F510A0F;
	Mon,  5 Feb 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116923; cv=none; b=Vx8A8z2hVosBXAq9DzFO4jn7jMprPW2bZ76QjTJBCNnt86LKJel0sZAzt9qKWetG7fBJ8Z2pZsz06ANF00wOMcUlCf9DdrcoREn6zq/FhSs5eMn2VF7NADkqsjni5Ysun0khhTgv0o2yi1llGXwEHQxDijTpfiaUTvqkgMwDY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116923; c=relaxed/simple;
	bh=gAr+MDVELsnUKJQZ409nve34GLwlo6Me/VR/Z5ROzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbGZDeYU4W8g2J8JJSgSvUCBr6CrSWKcOawDG+4SHL5lFCZcO7puyP+xK8nNx0UmzIxGTlziyk7HpZHgwlojmAaJMNSwSa4vs63JbYG+JUtoiI3/NhjMQIRIddXI/WxiFBP4D4hUu9VfbT52QXb2IBfkhCJlqQyhVvGYvFut0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AVRN1gqq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1EzODtl5peWgnUYGa8/WEGTfj53jhArigeFkkcGKpZU=; b=AVRN1gqqM32em/ISC8QfP6Y8Zn
	f1pRBJyEhxB91b3bT8BeLyPgxZ+O2Mc3F9fw2vd+ZKyotutw1OQ6OW3WBYQK0jFlILxZCwLA0MqP6
	8bzqihOWhiXz2bdHKp7Wu8A3hZ8b8Ucs9Oy5IHkZa9Pd+/A9UlcGKLYpdKpIX5Q4AEta5Alq6jpBz
	vjguJM6idosO0XpOif6G7b1MLCCUq/HVEpC6wwxXNZizND4RzcIEqrk3rW/4L44KuuU1ygGVr6gHL
	B5MxRKm4wCTEqoQQSPkHCxpj6wHoff4Kb7VeSTk/VJMla9CVWBWZEEfWdaLOu7VsF42lVdWbjrX+Q
	BSSfKFEA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWt5i-00000008nfl-3Xjc;
	Mon, 05 Feb 2024 07:08:30 +0000
Date: Mon, 5 Feb 2024 07:08:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv7 1/1] block: introduce content activity based ioprio
Message-ID: <ZcCJbtX3xwBRCqYJ@casper.infradead.org>
References: <20240205055705.7078-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205055705.7078-1-zhaoyang.huang@unisoc.com>

On Mon, Feb 05, 2024 at 01:57:05PM +0800, zhaoyang.huang wrote:
> +/*
> + * bio_set_active_ioprio() is helper function for fs to adjust the bio's ioprio via
> + * calculating the content's activity which measured from MGLRU.
> + * The file system should call this function before submit_bio for the buffered
> + * read/write/sync.
> + */
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +void bio_set_active_ioprio(struct bio *bio)
> +{
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	struct page *page;
> +	int class, level, hint;
> +	int activity = 0;
> +	int cnt = 0;
> +
> +	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +	/*apply legacy ioprio policy on RT task*/
> +	if (task_is_realtime(current)) {
> +		bio->bi_ioprio = IOPRIO_PRIO_VALUE_HINT(IOPRIO_CLASS_RT, level, hint);
> +		return;
> +	}
> +	bio_for_each_bvec(bv, bio, iter) {
> +		page = bv.bv_page;

I gave you the prototype:

: No, stop this.  What the filesystem needs to do is not
: s/bio_add_folio/act_bio_add_folio/.  There needs to be an API to set the
: bio prio; something like:
: 
:         bio_set_active_prio(bio, folio);

Do not iterate over the bio.  Use the folio provided to set the prio.

Or is there some reason this doesn't work?

