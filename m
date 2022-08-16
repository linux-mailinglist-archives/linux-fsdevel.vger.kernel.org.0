Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131DD5962EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiHPTNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiHPTNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:13:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC519474DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:13:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w14so10047227plp.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wjb5AIGvJ0V/NRfbnr8gg1CmISm7LqELqnVgTQyStiY=;
        b=kcRvnsyQxQFHsWdfWXFnfndrEg9iTlHZ6mWrwbnit1nAo6eG6dy+jF7fzmrAOX0D6w
         PV/SPPDR/yqFq61RQA3XA2PArX4zhNJBJ6T15oJzHiKglGulaShDpvWscxkNM5zm1jLX
         x/1NLGqoybEaNuaplQ5naYBLROAf3CXKFVEqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wjb5AIGvJ0V/NRfbnr8gg1CmISm7LqELqnVgTQyStiY=;
        b=WtW7xy7gttL7TM5QKDFJ6kWwZEKeS0e0a9tpZC9Xm/NWcus04LuqfRZ4wDeT4Z4vSU
         tw/EDibn4IsMtLmn5hZMYbbv9R68GWaBNWHts0Gzr4i1BKGbMmkKzIIcEniBHKUIswCq
         bPL3us+B3u7qMI0LvygHSDKvAvxE5mAbpYn1VqzMLlqt7oCtK+mB9/igkoEFrHZfoQ/H
         28fxVKdTYooGH4OjjVwUB+xz22klJnFCXLe//0SF4zKgK33WiGAZGcBdE78apCwpuDQ/
         lS571nazjLsX+GCnx/33qrBKIceSSs9x1AfkKqAkpcfYTNtcYbuH7gKGSjWnYBQLUYDu
         wkvQ==
X-Gm-Message-State: ACgBeo24/mUrWpnLJ1pA0EBRI5gOLKBdwo+8Lfmvie1uU3B3u0ZEsp9l
        DucghuUgfw25HuSgOrejPpBd5g==
X-Google-Smtp-Source: AA6agR5RH5ulJC813IEBEmxie0ssFd9t03UEuh1L8tR0gUeIP734M/uNntfcALDO/3NmVB5msDGQ1g==
X-Received: by 2002:a17:902:f083:b0:172:9128:c70d with SMTP id p3-20020a170902f08300b001729128c70dmr2154759pla.145.1660677198128;
        Tue, 16 Aug 2022 12:13:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b0017272667a56sm3734063plh.196.2022.08.16.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:13:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        fmdefrancesco@gmail.com, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] fs: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Tue, 16 Aug 2022 12:13:08 -0700
Message-Id: <166067718637.5584.14452180962626793627.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220803182856.28246-1-fmdefrancesco@gmail.com>
References: <20220803182856.28246-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Aug 2022 20:28:56 +0200, Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs: Replace kmap{,_atomic}() with kmap_local_page()
      https://git.kernel.org/kees/c/3a608cfee97e

-- 
Kees Cook

