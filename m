Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A568637B60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXOW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 09:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKXOWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:22:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C09B1C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 06:22:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a16so1334692pfg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e56HkPMZ1mNihNYXMlVzwK3kH5BryBSNp4U67FpserM=;
        b=Ykn9EQ5QfPXoU2mtDhievwp1DKdM8BlLadeQatHf1rzpJwz8h2tNPl59Ha1f/CmDx6
         4SN5nT9wRc21VrDP0fNrD3hlhy7rD8D3fj/+Bu63h9k/GNMxCLFH8vQ01tjHZEoysWEm
         F4JeF0a6/NaXJuFiIczzz+kMGn0+rXTmHBAKAbGNINpOB8gCwXehEHH5wurhwj72cb5C
         JRBjMPkx5rnCynpEpGeWy+MkA+WqdI0xZ6S+Zb3HvTSgbIh67rYuX/zjqhla2DSAOf18
         UrsUQIX8fwj3zcLCV1qSOgS16Mrd4U7lNyeRcj/PBmnjggqRQzGxlpIZuOFo3t1kCLA1
         0X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e56HkPMZ1mNihNYXMlVzwK3kH5BryBSNp4U67FpserM=;
        b=0yZBdkAsvCtuQh2ogcaUikWIKDAeOszttJl3OoJYLd5nk6GADWmbhCkZsO34z5zNBR
         D/hfA2hYX4X+rwcqlZrOUAK/8FwQ9LMZWpqhBM6RUcb9ApDTI4uGRwSySlIuqv2v5nFq
         tzsYE95fVRlG9rSk3iOeqc42kI04KYlfnrDKQA7Q3CMPiaKFN8W1+WBupSTqlx7/xtk8
         HP8iT6+h5CXWK8K4ibCuiLOdrzqxtTAVY5dQwqhjtSYH2Pci9yRLnT0wZ/fjizm4sVnU
         OWTw36SDzji1LaURT+yesAXr5moBsklOWxnPwcmRINclKhIV8IeajF0a9G0PGxwRAvlX
         SrLQ==
X-Gm-Message-State: ANoB5pnigKAZ7Wbvgv9sUmDv+5A8/Xv+XzK3LqUII7dT6ive6N/b0CbQ
        lhR4iOhLYYp1gKpglFzMaq/Ei9uqNZGvPElm
X-Google-Smtp-Source: AA0mqf4s/UlTHexFdgO+CVJtI9oiIdsuiStMrrOjZ3j2aL1dow8ko07qP7b6UiUqxhGEeySsBMmiBA==
X-Received: by 2002:a65:5782:0:b0:470:3fc1:5ed0 with SMTP id b2-20020a655782000000b004703fc15ed0mr12049259pgr.370.1669299741557;
        Thu, 24 Nov 2022 06:22:21 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c21-20020a63d155000000b004774b5dc24dsm1112865pgj.12.2022.11.24.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 06:22:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     Svyatoslav Feldsherov <feldsherov@google.com>
In-Reply-To: <20221124141806.6194-1-jack@suse.cz>
References: <20221124141806.6194-1-jack@suse.cz>
Subject: Re: [PATCH] writeback: Add asserts for adding freed inode to lists
Message-Id: <166929974077.103345.14091770376861017221.b4-ty@kernel.dk>
Date:   Thu, 24 Nov 2022 07:22:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Nov 2022 15:18:06 +0100, Jan Kara wrote:
> In the past we had several use-after-free issues with inodes getting
> added to writeback lists after evict() removed them. These are painful
> to debug so add some asserts to catch the problem earlier.
> 
> 

Applied, thanks!

[1/1] writeback: Add asserts for adding freed inode to lists
      commit: d6798bc243fabfcb86c1d39168f1619304d2b9f9

Best regards,
-- 
Jens Axboe


