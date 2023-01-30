Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB46E6806A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 08:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA3Hlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 02:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3Hlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:41:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732923874
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 23:41:44 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so7006159pgh.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 23:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wa4WRnsKtnxyryeAkeLMil3fZbp4U2WqsUJUssOKyY=;
        b=eHcc5UixAAKKUIer3AGWabkdnpH3eKCNftr0KIAYujXYvrEvJm+3TXGcxWLNgIIomO
         t7g/mOPuINYcq+7zzknXkcFgfdpkpuPUX3EYtDEOua0SmmBLvK9PUFfnPHMCVnCWJ7PZ
         RrZBTZm1mIhjA8gmmenOuH+oKT7EjzRuguIq/i+rk/soxGtCmjmoVM5o5bvQD3Y1lfwp
         eNHFKSeMKbz5RAssMm/ddeP8obPC1cCAJqY3cnrTH7af3BMfjMPS5NvV9FcljjUfAd5E
         V7G/OahoAYXlBDrrHMuq101UvzYwvRc2iAVurLerxKGyh1P1TdzEGKLvOrKCFyigiP4b
         zc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wa4WRnsKtnxyryeAkeLMil3fZbp4U2WqsUJUssOKyY=;
        b=m03Fd2n85fBa3gnfWrh/twF2VgPb+vqqR4mmyl3TeHIOHMMFVCRnukhq2vSx/lxjcu
         gxRFHe9YRnd+w6xyT3fm9OxJ9gvi0BIhvMsrP70e8FlQzPZyVckyD4B8dzQ+sLKE2HuU
         QGbQ2YU6TlK/oRVIQ0idP85JMxQDjvYEmCptIb2XjB1MfAgsx92ktslE/0UrPgoYjg5L
         ynWo06wT+3yAJGmcwRDrxB0HaDcp0BKSNG1tMBYQCO3WCfNH57dbu31BBiFQz2ypBj6k
         G9QG6RUak5tu+Kbzx+0XTNM6W+kjQhLfBtaglYBWAPT2wH071ILAfZML1yz/VuS/1Lfr
         9BUQ==
X-Gm-Message-State: AO0yUKWvuFojhVLWtaSbIi4nzrpB4njeKBHJd1jdfoj6+j+fhW+k6Ckr
        rQBCssxzD5Xm8JjL/nl9sSvM/Q==
X-Google-Smtp-Source: AK7set8Qt8AjHVXxLhDGUh1q7E1driVciP+P94S8PBr9mCyXFHUBsSMhsytYSnS78m6SzeTcDznXOg==
X-Received: by 2002:a05:6a00:278e:b0:592:52a0:6817 with SMTP id bd14-20020a056a00278e00b0059252a06817mr11856005pfb.6.1675064503424;
        Sun, 29 Jan 2023 23:41:43 -0800 (PST)
Received: from localhost.localdomain ([124.123.172.194])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00575fbe1cf2esm6705696pfg.109.2023.01.29.23.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 23:41:41 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     dhowells@redhat.com
Cc:     axboe@kernel.dk, david@redhat.com, hch@infradead.org, jack@suse.cz,
        jgg@nvidia.com, jlayton@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, logang@deltatee.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v11 0/8] iov_iter: Improve page extraction (pin or just list)
Date:   Mon, 30 Jan 2023 13:11:29 +0530
Message-Id: <20230130074129.28120-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126141626.2809643-1-dhowells@redhat.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Build test pass on arm, arm64, i386, mips, parisc, powerpc, riscv, s390, sh,
sparc and x86_64.
Boot and LTP smoke pass on qemu-arm64, qemu-armv7, qemu-i386 and qemu-x86_64.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>

Please refer following link for details of testing.
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-mm_20230126141626_2809643-1-dhowells_redhat_com/?results_layout=table&failures_only=false#!#test-results

--
Linaro LKFT
https://lkft.linaro.org
