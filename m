Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C75FF314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJNRld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJNRl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:41:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFE41D2B73
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 10:41:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso8552927pjf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeL1nS8vd13W1beG9Y8nl+BAYPvf19LEhLug4v6bWi4=;
        b=SNm3j8u41fb+3dP9Ar8IxfGNRtifKe9pEmJVQtHSN7nWwcRPJmPpzKIdZNA6UpEZRA
         OivXuR+azXhWrnVLlBR32VLP8k2Ciew6ItIY4vnwbW5feed873r6MIHSWUkxJYMm67ea
         Upilyz5pWrND4gd+QuXUCLTptKU0vXEQAqG7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeL1nS8vd13W1beG9Y8nl+BAYPvf19LEhLug4v6bWi4=;
        b=uN6kfSZNTd1gI6PeKr54xaXSDXHlARbYHa1FpYbbA7wXcfvznJ/B/UKRq23LP9SyRq
         y1JsKXteAerzyfsoL8qLDGac8l21XHoFTXJfLhlJ/zwXPNbrRE35muPMDKs1BWsFAXdF
         iigPAvTGKtK8mSIslvawOlCl/k3lIpixPoieEPpVoiaBrSr33bNSoAOxQZU+Z2/JvyGf
         DKD56XeQ0/FOQLWX/YxNLlznSRp2nhr4CMA7T85ECmL30hvIrXiV0IUvwgDh3dlKFt8X
         PLVyM3hyRV7I3W/ZTt79LLHA1OIbt9NMuWCPuPMMbCb6tiHZepLyWLpDAgv445PdVu5x
         J0BQ==
X-Gm-Message-State: ACrzQf2Hm9yLanod3u48EGaEzU6xcFDOc6n1eu2Orp1UV+Uc9zaUTYzK
        EWDL/0AhaHY0syny6ZAa6oKQgQ==
X-Google-Smtp-Source: AMsMyM50b/KKDY+/bGbIoTGRY9NKmHEI+Wx5+Jp3Wpd0Yd+UEA04lNAdA1wCZgoJCXH5vrbYXlwudw==
X-Received: by 2002:a17:90b:17c7:b0:20b:7cb:9397 with SMTP id me7-20020a17090b17c700b0020b07cb9397mr13134377pjb.191.1665769280757;
        Fri, 14 Oct 2022 10:41:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nk7-20020a17090b194700b002086ac07041sm1731834pjb.44.2022.10.14.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:41:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, ardb@kernel.org,
        linux-efi@vger.kernel.org, anton@enomsg.org,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        ccross@android.com, kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: (subset) [PATCH V2 1/3] pstore: Alert on backend write error
Date:   Fri, 14 Oct 2022 10:41:06 -0700
Message-Id: <166576925933.1456464.14312248515298828648.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013210648.137452-2-gpiccoli@igalia.com>
References: <20221013210648.137452-1-gpiccoli@igalia.com> <20221013210648.137452-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Oct 2022 18:06:46 -0300, Guilherme G. Piccoli wrote:
> The pstore dump function doesn't alert at all on errors - despite
> pstore is usually a last resource and if it fails users won't be
> able to read the kernel log, this is not the case for server users
> with serial access, for example.
> 
> So, let's at least attempt to inform such advanced users on the first
> backend writing error detected during the kmsg dump - this is also
> very useful for pstore debugging purposes.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/3] pstore: Alert on backend write error
      https://git.kernel.org/kees/c/f181c1af1385

-- 
Kees Cook

