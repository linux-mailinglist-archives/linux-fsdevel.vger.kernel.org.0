Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4B5A72D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 02:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiHaAlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiHaAlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25B2B634;
        Tue, 30 Aug 2022 17:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18B9617AB;
        Wed, 31 Aug 2022 00:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1AEC433D6;
        Wed, 31 Aug 2022 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661906317;
        bh=nblg12V1/C6LuB4b59SMW1k6ImcfN1zX4PRZ4rfiGBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPsw9hHl7o0c4UbkM02pZaor1X50lndnOai+l7iV+sOv7DtduLwkTWgbv4Q86dIQt
         DKS0nRxxCilBeb9A1VXU/dPs90zY89M32JZr4luA0OuE1S6IrDEWWSsLbT3mfbmcg9
         Fp29L1dXQ6B9+Vq7e0kzbRaHKyq6aL/feSELUvF8=
Date:   Tue, 30 Aug 2022 17:38:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xu xin <cgel.zte@gmail.com>
Cc:     adobriyan@gmail.com, willy@infradead.org, bagasdotme@gmail.com,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Izik Eidus <izik.eidus@ravellosystems.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v5 0/2] ksm: count allocated rmap_items and update
 documentation
Message-Id: <20220830173836.4e1a2a75c5e9cfb61638722a@linux-foundation.org>
In-Reply-To: <20220830143731.299702-1-xu.xin16@zte.com.cn>
References: <20220830143731.299702-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 30 Aug 2022 14:37:31 +0000 xu xin <cgel.zte@gmail.com> wrote:

> KSM can save memory by merging identical pages, but also can consume
> additional memory, because it needs to generate rmap_items to save
> each scanned page's brief rmap information.
> 
> To determine how beneficial the ksm-policy (like madvise), they are using
> brings, so we add a new interface /proc/<pid>/ksm_stat for each process
> The value "ksm_rmap_items" in it indicates the total allocated ksm
> rmap_items of this process.

I can see the usefulness and the code change is very simple, so I'll
queue it for testing and shall see what other reviewers have to say.

It's useful that the per-process file is called "ksm_stat", because we
may with to add additional content to it in the future.  Because
concerns have been expressed (by Alexey) about the proliferation of
procfs files causing major memory use when something reads them all. 
Putting more things in the same procfs files will help avoid this.

