Return-Path: <linux-fsdevel+bounces-46157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F064A83725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB908A7D51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE71F09B2;
	Thu, 10 Apr 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCEElIs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D71E5B66;
	Thu, 10 Apr 2025 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255138; cv=none; b=hsBG9n5GZswNkJEPB480xvs+TFb0uY/8MlUXbu+Ps9cYqdb/JkGLdIfTobrcHxDk8DrXXDllAES/5prbRdSwpY2wqJkeyw2yoZT298txCfWpEwszXW/2GSgZ/3sbGe+cQmCDC4lhP78R3YYyCSxs4jGGgzkBkz5iv5JxTGjBpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255138; c=relaxed/simple;
	bh=EMtW09fUhktkO2AOepqHbaCDe31Ls1yt+zdCaTHXZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBcHwGN3TCAMLjsd5BQ6StV65CHgldvdxF3Wz9QnlcyfBETlnrd9iQ7B2VO9sZD5K6D03SY3kDfOD2t7QivKHJ7Y0ABYV2g1oG6lKhKmbG321FdYuT1bFY20DCBCxgpB9ygsCGwV6gQD9M0dnaq80ngse1I4uPqwZ2yM3j6qyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mCEElIs0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ljKJOmsWbynBd4FZmekRdfQrkUbaBvmD89GjQhG0uSQ=; b=mCEElIs0+DTDV1eWLUS5E0AV8R
	htQrK03I82aCZqN+M+naQeahCg6yyCX1lOVqwE2ETxdfWtgwhqNPU6aj6aIn/7AsCSKql0y4gi4PH
	fg+WELo9aqTGP5UYddpzzl90Vj2tQYjyeNcS7WusDxzKS9aSp0ilHwdtmM5dBb78lPHAJKNiYTprT
	m2ZCiFf6d4qK4wvzNFrIFa/HnBbWFkzbuVbLuUSMYv2UMZGTP6Qvz94SXNmEFOJA9sBXa2ouIh+0h
	W2VOuruSeS2OE2BvNcQ90SAlj+IWck2DtnUjo+KHFLd8zu2p1+E2nu5QwwVcZdqZkB3IGnyDwjQi/
	QpQkB2GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2iRF-00000002Jfz-0HTT;
	Thu, 10 Apr 2025 03:18:49 +0000
Date: Thu, 10 Apr 2025 04:18:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, dave@stgolabs.net, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <Z_c4mPrGnrED5lb3@casper.infradead.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410014945.2140781-2-mcgrof@kernel.org>

On Wed, Apr 09, 2025 at 06:49:38PM -0700, Luis Chamberlain wrote:
> +++ b/mm/migrate.c
> @@ -841,6 +841,9 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> +	if (buffer_meta(head))
> +		return -EAGAIN;

This isn't enough on filesystems with bs<PS.  You're only testing the
meta bit on the first buffer_head on the folio and not on the rest of
them.  If this is the right approach to take, then we want:

+++ b/mm/migrate.c
@@ -799,6 +799,8 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
        struct buffer_head *failed_bh;

        do {
+               if (buffer_meta(bh))
+                       goto unlock;
                if (!trylock_buffer(bh)) {
                        if (mode == MIGRATE_ASYNC)
                                goto unlock;


