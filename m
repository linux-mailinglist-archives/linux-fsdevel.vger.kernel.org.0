Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17660D6F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiJYWZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiJYWY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:24:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C833ECC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:24:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f9so8553794pgj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/99i6m4qA9/U6AcuZauGoH2LpcZL8zBcOargGjTGOT0=;
        b=QZeiRAUyskKFwBFknGXeD3Yb/V7iOyO4JeTvIgr6K5t2kwC/qpXuFpFnWOHADDsU6R
         UmGxSB3cDJ8QZcgUApqjIukszWT1nZqmb662qTBF2SaE4wVJoYXj+JZVMXIh8pyBbrtX
         U7fywBoSw2MAvU5hs0oquoEPpEYt9hCBb2Zjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/99i6m4qA9/U6AcuZauGoH2LpcZL8zBcOargGjTGOT0=;
        b=pJopeBOoygY9d5a9UIz/p9Ol2F2zhWspPIY+xxaUkqFBZgsurBN5AsHe6yE69ARAG9
         iWV+9Mw33+fVeYzwKvM2PM5P7Jhnvf3KuXgUz4ia7k6EGEdnaFvBAdq41DshvSKkyWDy
         xKwHFspfPGq7S//5wUyGm3LmaCpyYGKZNFFQfAakI8kYLv+KDqIA596YLrMRkDIFqqDO
         LXDN2T0Hpa+bsZht0ZiC16LCvKUdUNtspYivnZ2U2xWRTYYREh0pajXnW1KSWupFQchF
         xaUoUnVm/z59gVI9YLP8ErZrxTEy5c5WzfVMUW6/1OVrgO0sVe2PGA1G/JohTn+Ln5Xx
         BgUw==
X-Gm-Message-State: ACrzQf3KGjJnn9nh7Jcv3ZYgoolqoPQL5Tmm4ZKvNOuv2J3zy+kHELU9
        psYRQ54J9tCOYWkmMPiqT6zl6w==
X-Google-Smtp-Source: AMsMyM7Cekg1+h8kwQZmQbNIic9MNo7ctZTlKHM8mYqazCWD1Ml2A1BymNo4B5jHgsiVfPmnb9DXhQ==
X-Received: by 2002:a65:408b:0:b0:42a:55fb:60b0 with SMTP id t11-20020a65408b000000b0042a55fb60b0mr34906072pgp.431.1666736696690;
        Tue, 25 Oct 2022 15:24:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b00176ae5c0f38sm1654422plc.178.2022.10.25.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:24:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: fix documented return value for load_elf_phdrs()
Date:   Tue, 25 Oct 2022 15:24:35 -0700
Message-Id: <166673667324.2128117.2043189489693544116.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2359389.EDbqzprbEW@mobilepool36.emlix.com>
References: <2359389.EDbqzprbEW@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Oct 2022 09:43:01 +0200, Rolf Eike Beer wrote:
> This function has never returned anything but a plain NULL.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: fix documented return value for load_elf_phdrs()
      https://git.kernel.org/kees/c/cfc46ca4fdca

-- 
Kees Cook

