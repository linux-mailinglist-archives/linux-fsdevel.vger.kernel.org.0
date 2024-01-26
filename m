Return-Path: <linux-fsdevel+bounces-9050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF483D876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA41CB38396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE1224F0;
	Fri, 26 Jan 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOuwyWAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90A224DB;
	Fri, 26 Jan 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261812; cv=none; b=QXWE2/M8ysOvVcN4H5ylIm+atnoFRfzZh0e9nOY207cj1ZebNv8olV1R6COOpuyCRTRCui+7/GzVZ7BgMa2CT5bDNzn22+GCrA4ZwEA0zppm12DgtFgG+PVFRlbferSNzEf+QDJr7/cgmluXIqfXIrNNzSJK/KUjeePKrFBwCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261812; c=relaxed/simple;
	bh=Nqs9TinaaXHwHA6044b8Z8mw+/GdCqpp7NnA+gCBoRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkXrXMFPXD8OUYpefDROU9fZAL3LjJJAsIq9+eG8kac48mzladCJlwBw5DsDFUKoZrig5217WQ7GQZPeTqsy4EKjrh8eGPXD1ZfN2HHGuEEnHGLJYcFLIyOaZ4LNHwcts1TzBwyhKWGoJpUIZTxYwuZcRzhxROYUmNYD2/qPyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOuwyWAt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Fscjw5+02nWcqj9YGEOz7mXAdbzE5tCE48cyS+dnnGE=; b=gOuwyWAtOHJYZZB8kDVsEgfvNa
	tzk+b/d/l2FYsERlAfsujmb8rKjohGn4n+Bjerm1Nu7gIas8kU4qd1vl82CdJSFqXa7a7TwZvpl2E
	OJHMXMGJ1HLGeFpsSeuP+rp+sjh7BCtodOy1dwYLVP8zU6Ulx8F3lb+AslA+ZfZ3vkVmeiJ5m8xDo
	leXDzaEjSp7e1eJfAjjruhDlU8oyRIKOV/IYs65et9NcfRBY7K79zrMREaTPQlZu1sVc7ZtQHWONm
	1GV/jWHI8v3hXvaje41swjLKtQeaESAwcfX5HYtX0rrFvpERUrGeI4fzSiqEEBY1By36pBnx56t6t
	x9B7Ww9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTIdY-0000000DBIw-3Qwx;
	Fri, 26 Jan 2024 09:36:36 +0000
Date: Fri, 26 Jan 2024 09:36:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
Message-ID: <ZbN9JDE50Th-dT3Y@casper.infradead.org>
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <CAGWkznGpW=bUxET8yZGu4dNTBfsj7n79yXsTD23fE5-SWkdjfA@mail.gmail.com>
 <ZbNziLeet7TbDKEl@casper.infradead.org>
 <CAGWkznGG1xLcPMsWbbXqO5iUWqC2UmyWwcJaFd4WBQ-aFE=-jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGG1xLcPMsWbbXqO5iUWqC2UmyWwcJaFd4WBQ-aFE=-jA@mail.gmail.com>

On Fri, Jan 26, 2024 at 05:28:58PM +0800, Zhaoyang Huang wrote:
> On Fri, Jan 26, 2024 at 4:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jan 26, 2024 at 03:59:48PM +0800, Zhaoyang Huang wrote:
> > > loop more mm and fs guys for more comments
> >
> > I agree with everything Damien said.  But also ...
> ok, I will find a way to solve this problem.
> >
> > > > +bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
> > > > +               size_t off)
> >
> > You don't add any users of these functions.  It's hard to assess whether
> > this is the right API when there are no example users.
> Actually, the code has been tested on ext4 and f2fs by patchv2 on a
> v6.6 6GB android system where I get the test result posted on the
> commit message. These APIs is to keep block layer clean and wrap
> things up for fs.

well, where's patch v2?  i don't see it in my inbox.  i'm not going
to go hunting around the email lists for it.  this is not good enough.

> > why are BIO_ADD_PAGE and BIO_ADD_FOLIO so very different from each
> > other?
> These two API just repeat the same thing that bio_add_page and
> bio_add_folio do.

what?

here's the patch you sent.  these two functions do wildly different
things:

+bool BIO_ADD_FOLIO(struct bio *bio, struct folio *folio, size_t len,
+		size_t off)
+{
+	int class, level, hint, activity;
+
+	if (len > UINT_MAX || off > UINT_MAX)
+		return false;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+
+	activity += (bio->bi_vcnt + 1 <= IOPRIO_NR_ACTIVITY &&
+			PageWorkingset(&folio->page)) ? 1 : 0;
+	if (activity >= bio->bi_vcnt / 2)
+		class = IOPRIO_CLASS_RT;
+	else if (activity >= bio->bi_vcnt / 4)
+		class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);
+
+	return bio_add_page(bio, &folio->page, len, off) > 0;
+}
+
+int BIO_ADD_PAGE(struct bio *bio, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	int class, level, hint, activity;
+
+	if (bio_add_page(bio, page, len, offset) > 0) {
+		class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+		level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+		hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+		activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+		activity += (bio->bi_vcnt <= IOPRIO_NR_ACTIVITY && PageWorkingset(page)) ? 1 : 0;
+		bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);
+	}
+
+	return len;
+}

did you change one and forget to change the other?

> These white spaces are trimmed by vim, I will change them back in next version.

vim doesn't do that by default.


