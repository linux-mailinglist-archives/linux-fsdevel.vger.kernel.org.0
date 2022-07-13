Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626D573DB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiGMUVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiGMUVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:21:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5D2E694
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 13:21:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x184so11208445pfx.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JcYpGy4wzAqqtoFWvjiTbUFlKhGd0IaTVFe++/A2tj8=;
        b=j3/yPTm93If9fOoylNboDvrKY3qdKwD+2gPm56U744CITZPKzrmWQSjHCfhH1XDpj8
         1cg3oDoehjlRPSBHyP8ld4ZTcOZak844Ie0+2k+5lJcfIfQZSoIGqHARuNSFIjGwjnGL
         u6uZgq//x3qX/jONleOFz8cx+pRBR7fXRzYNMIZIgglFxnUIpqrZFJnTyphVoH97Z1N/
         iO1m1byzqdETeZiNlLI75M09vhqyTk8V7+7eVYsstdXAWCpSZC8OrNIDIWvD4V/UWNzh
         fdS3KD6wg0P37ss2wfWteZ1vRhx4LiwAjoWv9IR3h2NwYKzV3o+PsggSFyJiiJw+ip/W
         aSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JcYpGy4wzAqqtoFWvjiTbUFlKhGd0IaTVFe++/A2tj8=;
        b=Hx7F/RaScKQc91LvfmKHCMGp6WHxAHnh//TbXw7U+o1t6p4FdB439eaqkh9kf8qXMS
         ttiv417KJWS5lWYrtMbdG4b4ubbOOkVpUw4V2659tkVDwfvzBtd2O3WR2RZGNk+lLoGg
         AYxY95cpvhvgjHUnh2Il4GrWrHJ9sBdPiDz1b+zlg9Vh7VYj8COdfHPKQcR6F8ANPfM7
         Db30ED24P7mAQgXP9sijeCzUsKG1lsYhsbCVCT7qVBO6eMyvsCNMa0J6UVsmOZ/9N/UT
         jAAA54jkDdeY5dlxZbazPiHDcFfOb9zmw/ALOXkr5U0uEQH1fu9gHNyU1n5hNnPv2uLO
         YQ+w==
X-Gm-Message-State: AJIora/EX5eb1emV6Nl0GGoQFnJIpTDk1WrBoy2sP3nYsVKMjk8x53ap
        3/Vhy5pBZ/ugw58rlMbON27BkA==
X-Google-Smtp-Source: AGRyM1sRtpOzM8so8J17lC2HC0Gp5PVrftTwsJh5/KvwUQD6vq4e+sEjRVff8ts6usamWE4TAZfvFw==
X-Received: by 2002:a63:4042:0:b0:411:bbfe:e736 with SMTP id n63-20020a634042000000b00411bbfee736mr4375329pga.1.1657743688555;
        Wed, 13 Jul 2022 13:21:28 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00168b113f222sm9357024plg.173.2022.07.13.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:21:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kbusch@fb.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, kbusch@kernel.org
In-Reply-To: <20220712153256.2202024-1-kbusch@fb.com>
References: <20220712153256.2202024-1-kbusch@fb.com>
Subject: Re: [PATCHv2 1/3] block: ensure iov_iter advances for added pages
Message-Id: <165774368761.35656.10611792606953434095.b4-ty@kernel.dk>
Date:   Wed, 13 Jul 2022 14:21:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 Jul 2022 08:32:54 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are cases where a bio may not accept additional pages, and the iov
> needs to advance to the last data length that was accepted. The zone
> append used to handle this correctly, but was inadvertently broken when
> the setup was made common with the normal r/w case.
> 
> [...]

Applied, thanks!

[1/3] block: ensure iov_iter advances for added pages
      commit: 5a044eef1265581683530e75351c19e29ee33a11
[2/3] block: ensure bio_iov_add_page can't fail
      commit: ac3c48e32c047a3781d6bc28bb5013e4431350fd
[3/3] block: fix leaking page ref on truncated direct io
      commit: 44b6b0b0e980d99d24de7e5d57baae48a78db3b6

Best regards,
-- 
Jens Axboe


