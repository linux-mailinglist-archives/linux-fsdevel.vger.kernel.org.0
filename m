Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1305254B436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbiFNPJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiFNPJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:09:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE92558E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 08:09:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e66so8751968pgc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCjtBXke5NyaFriVJBoaZn9Z4g68RyDeHdJ5UXQYWpg=;
        b=jugy91NBZPZIHcuatVTSW4OX8xDcs/D/JLBqIjpVGI2aEHe26RryjY3Fh6tDtAu0bi
         a4qZKyya+E1jORA/unTh2BMyT+HD0qMxvY9Dv5AwCVx1B1aeFHMfSk81C1loimp4JsJd
         TunUFpi0c/BK9/sYM1P/O6bDPDYuQFemucwSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCjtBXke5NyaFriVJBoaZn9Z4g68RyDeHdJ5UXQYWpg=;
        b=qRdETszq9rKfDyvhne4arDTlI2cpGCv0s3YptWeAfDInn8Lm1DdMHY44ty3Ce1tQO0
         GGy+NHTizNMHUyy+Orr8cQjK/DusvyCtbqCafBbqGna+qRDlWoMIlYN0BSQI7YwBbVcL
         UPIpNicsDhpNGKe9bfMZGk+fjsaPEgrRlhpE3UHPWrB8PB4gVmtDQtsN0U8//C9mJz94
         KqUzmZQPQv6mD1PO/Ue8RMRz8fyKuPkhUEEB7+QjHlol0Hzt968m71hGl4rwUor/nakA
         Qc3pfa6jchDucc7Aio+rVzZ3fn+ke7c88Y3lAgDaxpoL2Co6A9iSaw/I8Pxo9IUvJGjh
         pDSg==
X-Gm-Message-State: AOAM530F8pM+gKzrJF9BgXyI7zRIAq1DFTKjpUzEFx1ObHvCzXIJ1Xhn
        YAx0F1xO8KFZzVYsvVfQTiiBhg==
X-Google-Smtp-Source: ABdhPJwrhsuNyNRt0k0cRWz03PtNgbgQ8JaGo8vAgHkShQNZIFRzIQkmVeLaecnomn0sdyLQsO5iTQ==
X-Received: by 2002:a63:a55:0:b0:3fd:e492:354e with SMTP id z21-20020a630a55000000b003fde492354emr4877729pgk.416.1655219376838;
        Tue, 14 Jun 2022 08:09:36 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e483:9a18:bba3:a0dd])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b001675991fb7fsm7330052plk.55.2022.06.14.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:09:35 -0700 (PDT)
Date:   Wed, 15 Jun 2022 00:09:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     sunjunchao2870@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        suzuki.poulose@arm.com
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <YqikqHUv51PXOjwq@google.com>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <Yqigw6vu6RYBIqHK@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqigw6vu6RYBIqHK@monolith.localdoman>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (22/06/14 15:53), Alexandru Elisei wrote:
> (+Suzuki)
>
> I was able to boot the board after applying this patch from Suzuki [1].

OK, so the board actually boots to panic and the issue is that printk
does not flush panic messages. I think Petr has a patch for it.
