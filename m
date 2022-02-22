Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE74C0193
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiBVSpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiBVSpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:45:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B51D36151
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 10:45:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f19-20020a17090ac29300b001bc68ecce4aso393929pjt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 10:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=PMKYEWCDCMsP4EK+SamWNZKxFF4vjTSgauaCayRBeKE=;
        b=LYsSVxBz4ZoO4mbf1cPAomiWeU/r9SdwrB5IlF+jMaPMYf1cB43yDNtRO4zN9h0ZEy
         PwIT6hmUg3e1w5FduDfj28IUdcJrJeAEWbsyNTab3SYWJkV9ZDZrUTIg6Uz90oaI1gB2
         l2wMa4FslXUzTXk/waMamxX6JgI0sysQDojzo2kYSkt2Az7H904t9VYCF4j024Nu/h8B
         MG/Uv9qgi99vVMxm8bCekh8EBNwyK7RCN2QkUskXthwQK2H4zrGpEBYVTgPm6Jnz8wuE
         528AchVO9s1FHtOh5QTXGbAZ1o2YXOaqEhzgOx2R++f5zNbrMU5tr5RQG0Z9H6pnWToT
         udxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=PMKYEWCDCMsP4EK+SamWNZKxFF4vjTSgauaCayRBeKE=;
        b=XnXzDODZNsIODvVMhd4XHRT5Zcqbk9U/kwZkKcWBnoCdovzOLAgRSbai4Og66HYZgv
         S7lmdfAcRTrSYQpXFI02ejPyh5EMCAfEUoqFwXpNki3XjUMl4p1qeCcmX6NXpUfZ6FCw
         5SHfQP0BSNSZZcEe1BZT4aw2bZKtXuuIyLQgpeKUdMJcr06qsD3DBlKYSxvKbSNMsSdd
         rDUg8fp/55IdVQydl2vssXkdsIenBcgOKyMFHdym4J+zsHdLZvz7GQ5ZKuowbtjapOH/
         lxfM1ZMW1aZRo0NU9hUU3xe/9C/axPMK2HcLB2Ghv1BPW+nAjRjUuUvF054P5h/M4Enb
         TMTQ==
X-Gm-Message-State: AOAM533BW92Hk4kT4vKmPuI6u006oxhOMRGyAWgqrZA7mDNZfu63DmqC
        cXFpymuZPAnEhfUw4dgWb3cscg==
X-Google-Smtp-Source: ABdhPJwVYUrpMLzoTC9DCrhh59J61hLYFFnmLSX4NjObGw5vXjSBgqRUPjrThvaBsAcomdiQ4hgixg==
X-Received: by 2002:a17:902:7b81:b0:14f:1b7e:c83c with SMTP id w1-20020a1709027b8100b0014f1b7ec83cmr24535613pll.119.1645555511056;
        Tue, 22 Feb 2022 10:45:11 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q2sm18362284pfj.94.2022.02.22.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:45:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     kernel-team@fb.com, Stefan Roesch <shr@fb.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
In-Reply-To: <20220215180328.2320199-1-shr@fb.com>
References: <20220215180328.2320199-1-shr@fb.com>
Subject: Re: [PATCH v3 0/2] io-uring: Make statx api stable
Message-Id: <164555550976.110748.6933069169641927964.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 11:45:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Feb 2022 10:03:26 -0800, Stefan Roesch wrote:
> One of the key architectual tenets of io-uring is to keep the
> parameters for io-uring stable. After the call has been submitted,
> its value can be changed.  Unfortunaltely this is not the case for
> the current statx implementation.
> 
> Patches:
>  Patch 1: fs: replace const char* parameter in vfs_statx and do_statx with
>           struct filename
>    Create filename object outside of do_statx and vfs_statx, so io-uring
>    can create the filename object during the prepare phase
> 
> [...]

Applied, thanks!

[1/2] fs: replace const char* parameter in vfs_statx and do_statx with struct filename
      commit: 30512d54fae354a2359a740b75a1451b68aa3807
[2/2] io-uring: Copy path name during prepare stage for statx
      commit: 1e0561928e3ab5018615403a2a1293e1e44ee03e

Best regards,
-- 
Jens Axboe


