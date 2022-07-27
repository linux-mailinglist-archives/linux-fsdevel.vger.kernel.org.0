Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F565834C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiG0VNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiG0VNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:13:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FA4E87F
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 14:13:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 72so16911281pge.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHrp+/mnJmHfV69EUAYZdN7aFUtabolaTlyqxdvvPaU=;
        b=Jtp2twDnzN+4lWaWTsFbsKGaBtyat8ch1PmoFuOXt68nO5wqOiMFomfJhAZjw3mihm
         Cj6sAu38qi4Mhu0CXP0FrbKv+B9zeWomjPcPK7nT9VNK3aUlepC9S5nuNfviS8aFofK7
         CeOTLuly65dMx9aZTq/hzifVONzGQiTDoxNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHrp+/mnJmHfV69EUAYZdN7aFUtabolaTlyqxdvvPaU=;
        b=SzuNeY1KpbCKF6KqzFvSCHYSBFaG/w57PWE/yOrYrx9uULzDKiRfGLCbC3uc1UgEnv
         p/NfYQs12FOfeBPrpEm7+3BRZwuDPP5TGu7n12Tt/d+JmkxVCCkmCUo0Cf1HxiaiVX+E
         5cLgmXxa2cw1HtCRJjcQ5at2AyhUhohxMnm3HmIAqEjON/R7hkzRhGeiFoMk4Bt8vfFK
         WEVxvxIMxXbBV/kmP07k+Gkqxf0eXjL2y27nab61akw6EhPDHf+y1kaurpTGZwZ2+g88
         tTzE3zT1AZnvB1vS8h8duLjyVokLxQjPU5pitUVLtjXeoZZkCHNBCBK+qa1NOGrozwBn
         h5yQ==
X-Gm-Message-State: AJIora8Paiq1B6wP7mW5hVTzbX7a78Ar9gTmcI2/cWmeoFQAxS+qBhek
        ErrHFRBPMSvjYEBhIX3NUWDlmQ==
X-Google-Smtp-Source: AGRyM1vdkfYRiqix/j7n8sooInJkoyk6a2nXU232zrO69Dea58sX+6BxmUs4R8B8kSGyKxalspeuTA==
X-Received: by 2002:a63:560d:0:b0:419:759a:6653 with SMTP id k13-20020a63560d000000b00419759a6653mr20669183pgb.219.1658956429931;
        Wed, 27 Jul 2022 14:13:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0016d6c38d37bsm8013304plf.156.2022.07.27.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:13:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fmdefrancesco@gmail.com,
        ebiederm@xmission.com, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] fs: Call kmap_local_page() in copy_string_kernel()
Date:   Wed, 27 Jul 2022 14:13:44 -0700
Message-Id: <165895642099.601089.13587838249930753502.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220724212523.13317-1-fmdefrancesco@gmail.com>
References: <20220724212523.13317-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Jul 2022 23:25:23 +0200, Fabio M. De Francesco wrote:
> The use of kmap_atomic() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
> 
> Therefore, replace kmap_atomic() with kmap_local_page() in
> copy_string_kernel(). Instead of open-coding local mapping + memcpy(),
> use memcpy_to_page(). Delete a redundant call to flush_dcache_page().
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs: Call kmap_local_page() in copy_string_kernel()
      https://git.kernel.org/kees/c/0ff95c390bc8

-- 
Kees Cook

