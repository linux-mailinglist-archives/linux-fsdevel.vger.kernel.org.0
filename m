Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB27392B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFUWwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55219AC;
        Wed, 21 Jun 2023 15:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E39616F9;
        Wed, 21 Jun 2023 22:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57237C433C8;
        Wed, 21 Jun 2023 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687387924;
        bh=QomhkGLLN8W2r9HjMDHaZujXKKaC8553z5+wqMaD2HY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dP4OACt1y8GyQBFosTzrkVpOpXUr+pMHBbNogmBbDeFFjXgKnnzJ60+1mlM6CZzHm
         x2+siVaEzqnEoL6vU1STdW8JXtVK8chEbIAyDY6KM5Zyn6m13mkls6+Y6ppYJ0XfCO
         3qBjdH31QeNCnC4BK69/H5yS1Hw/aHslc38fCjzE=
Date:   Wed, 21 Jun 2023 15:52:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] hugetlb: revert use of page_cache_next_miss()
Message-Id: <20230621155203.40c9e05d1a80f522f7e9e826@linux-foundation.org>
In-Reply-To: <20230621224657.GB4155@monkey>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
        <20230621212403.174710-2-mike.kravetz@oracle.com>
        <8a1fc1b1-db68-83f2-3718-e795430e5837@oracle.com>
        <20230621153957.725e3a4e1f38dc7dd76cc1aa@linux-foundation.org>
        <20230621224657.GB4155@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jun 2023 15:46:57 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 06/21/23 15:39, Andrew Morton wrote:
> > On Wed, 21 Jun 2023 15:19:58 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> > 
> > > > IMPORTANT NOTE FOR STABLE BACKPORTS:
> > > > This patch will apply cleanly to v6.3.  However, due to the change of
> > > > filemap_get_folio() return values, it will not function correctly.  This
> > > > patch must be modified for stable backports.
> > > 
> > > This patch I sent previously can be used for the 6.3 backport:
> > > 
> > > https://lore.kernel.org/lkml/b5bd2b39-7e1e-148f-7462-9565773f6d41@oracle.com/T/#me37b56ca89368dc8dda2a33d39f681337788d13c
> > 
> > Are we suggesting that this be backported?  If so, I'll add the cc:stable.
> > 
> > Because -stable maintainers have been asked not to backport MM patches to
> > which we didn't add the cc:stable.
> 
> Yes, we need to get a fix into 6.3 as well.
> 
> The 'issue' with a backport is noted in the IMPORTANT NOTE above.
> 
> My concern is that adding cc:stable will have it automatically picked up
> and this would make things worse than they are in 6.3.
> 
> My 'plan' was to not add the cc:stable, but manually create a patch for
> 6.3 once this goes upstream.  Honestly, I am not sure what is the best
> way to deal with this.  I could also try to catch the email about the
> automatic backport and say 'no, use this new patch instead'.

OK, how about I leave it without cc:stable, so you can send the 6.3
version at a time of your choosing?
