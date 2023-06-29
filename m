Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690BB742DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 21:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2TmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF2TmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:42:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A08210E;
        Thu, 29 Jun 2023 12:42:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso1212110a12.0;
        Thu, 29 Jun 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688067733; x=1690659733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J8xfd3Bi3FUEg2mdjjnrWh1F35O1rgPB2ctPxtJWJao=;
        b=LgBKMetrxewlKIGdFCcpoEPRF6NFs6XJRRca6Pvs1nL7hpytucBzWMjjhB6DivoOkT
         nqkSHsiswr4OJ5TPcl1HDBDEX3X01uWyUl34o8Qk7wqTqJ6XUGB/JlF/lWy6IYXXzd2j
         TNwn5f9XlqfqW9URN60MRZgDedy4THbCjfC0tIlbmkuATPbAb5fw5Ye67MY7fY5w4JHI
         8fS5xnHf0h3e7UjdnX9E1FMiA6HgrheVR5Zwu1j+EDg37QlmB9xQlC57u7JpoGBx1OVz
         BO+fSSJs9wIr4JHfKqIneRTn/Fl5uapvTuJIe6LWEdaiXxurU1C2KdKply9lMOsMhrTO
         i5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688067733; x=1690659733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8xfd3Bi3FUEg2mdjjnrWh1F35O1rgPB2ctPxtJWJao=;
        b=fXnc5eJ8YTebi5Tx9oVvOeDMS68goxg6hkM0WirD0s8pYAdBVhiT3DjkWqys6Vhan5
         vzZv9tilo3hBKvmHjXcv9feOrHnYV15DOqCUi7WuEj6wbdgp3rUedHS3HX9nhg2vvS8n
         jMn1VoDDKp814z+fC3VMSdJvehz7dUlEKnTq0iso2ru9t80j9GauIJ4ygHtYg+ocWkaf
         CvyAvEhrfoNfIj+uDvl86BFZsLUqGMBsnzpPj8pP22yAeF2JbPtwfL3lXgYP6UEAll4D
         zI3G50r9+bNppHzvPIPFbWrqCBtH3h7v5bAwVJmkxaHQ70xZ30Bu13Z7xjGTGtQWM8ol
         XN2w==
X-Gm-Message-State: ABy/qLb0u/AK4P2YVQQtugm72o/NBSJcbTaGbnMO1uLmfEnPcciy48Cf
        ysBplfX0JTc9Q1vue8apuw==
X-Google-Smtp-Source: APBJJlEeUZAGifvNNwYzIvE081khgiSAJja1TtD3q2wF1Yzd9TXgi1C48M+JMyOUgYcqh1bFDGtfKw==
X-Received: by 2002:a05:6402:205c:b0:51d:91cc:32e8 with SMTP id bc28-20020a056402205c00b0051d91cc32e8mr122204edb.29.1688067733196;
        Thu, 29 Jun 2023 12:42:13 -0700 (PDT)
Received: from p183 ([46.53.248.48])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7cd05000000b0051da8fd7570sm773742edw.41.2023.06.29.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:42:12 -0700 (PDT)
Date:   Thu, 29 Jun 2023 22:42:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 2/2] selftests/proc: Do not build x86-64 tests on
 non-x86-64 builds
Message-ID: <fd61fd96-f06f-4a2d-8707-0e1e395c9e51@p183>
References: <20230629162301.1234157-1-bjorn@kernel.org>
 <20230629162301.1234157-3-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629162301.1234157-3-bjorn@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 06:23:00PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The proc-empty-vm test is x86-64 only. Remove that test from
> non-x86-64 builds.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

What's the address space size on risc-v?

> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -8,7 +8,11 @@ TEST_GEN_PROGS += fd-001-lookup
>  TEST_GEN_PROGS += fd-002-posix-eq
>  TEST_GEN_PROGS += fd-003-kthread
>  TEST_GEN_PROGS += proc-loadavg-001
> +
> +ifneq (,$(filter $(ARCH),x86_64))
>  TEST_GEN_PROGS += proc-empty-vm
> +endif
> +
>  TEST_GEN_PROGS += proc-pid-vm
>  TEST_GEN_PROGS += proc-self-map-files-001
>  TEST_GEN_PROGS += proc-self-map-files-002
