Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E761A1FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgDHLV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 07:21:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgDHLV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWkE951pF6gwEgnZrr9rlPlV6Gs3OzC1B/guo+3Nato=; b=jL8HBJZUW04p8UIqAHE625jZEu
        pR+6oxFHckjc35R4VhzZcl01WIJomt7KJiZZRvnX/EC/5B2rTcTamkwArtYmzgw80e71f9+U3s1Nn
        9EbFYHkNZomfJ+Lc2/o0l696J0HTYsH7i+fAey2YjCaGuy3l94V5sxK/5b23Pku3AFe+SbtQGCMt2
        ptE8WU3lReh6n7K/OYuYAkv940+hijRidD+qYV9oep32w9shhbiP7f3AIzqA1aYrokjRexWTlefYj
        7lqqoamXNnvxVZdt+nV5xFauE2xq5BUlu5sp0kv9t9tcxIYgH1R+hKwMK41txIr8UAQzpQmCfog4D
        5EejFJ/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM8mG-0003CR-H4; Wed, 08 Apr 2020 11:21:52 +0000
Date:   Wed, 8 Apr 2020 04:21:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Message-ID: <20200408112152.GP21484@bombadil.infradead.org>
References: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please leave at least 24 hours between sending new versions so that
you can collect all feedback relating to your change, and we don't see
discussion fragment between different threads.

> @@ -84,10 +84,10 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
>  			      t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
>  
>  
> -	/* time_ms field represent 0 ~ 199(1990 ms) */
> -	if (time_ms) {
> -		ts->tv_sec += time_ms / 100;
> -		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
> +	/* time_10ms field represent 0 ~ 199cs(1990 ms) */
> +	if (time_10ms) {
> +		ts->tv_sec += (time_10ms * 10) / 1000;
> +		ts->tv_nsec = (time_10ms * 10) % 1000 * NSEC_PER_MSEC;

I find this more confusing than the original.

		ts->tv_sec += time_10ms / 100;
		ts->tv_nsec = (time_10ms % 100) * 10 * NSEC_PER_MSEC;

is easier to understand for me, not least because I don't need to worry
about the operator precedence between % and *.

