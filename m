Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67F5EDF64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiI1O7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiI1O7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:59:15 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DBA6C3B;
        Wed, 28 Sep 2022 07:59:00 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id r6so2934626wru.8;
        Wed, 28 Sep 2022 07:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4bbjkrUOljrgmRoZno24QNrvhVLTbzBU814ynKHACuc=;
        b=gxla6/79gyFBi9rUERJnRrwrOFr5VSzU3ilbIOCbMqvvWiOtc6qI71XuM2+zBxabdb
         XlfzqtKD0Uw0OsnJS+rOhW+PBstA3MTIrMtn1xCkvLuuS2RRUe/sN6KnuGEtG7ebSGPo
         lcS+N4eAB5lwmrECLrufOMXtYz6oJi0XBgYm7VW/+8us7dX09Ofl7+zKNWzaekT6GTfs
         XTlWEjmPn8fxkUQ6nUKRwb/cw8fNZ1PYkXgIFhGfpzUSdJf9Gv87dqvHqBRRHEsO2bkH
         6ALkatQqKUZGQxudE7qN5mHwKobDMDnZP6XNt9H8G1mh44N9HX9TlgEXioJrac9vtptu
         NaBA==
X-Gm-Message-State: ACrzQf1qK56Qkl2EG5Ns1vCfnmZxKtFxt8UADTC/sJIt55qATowTz13K
        9MoPKgjYcrxtBIZCq5yVC+MB1okOydQ=
X-Google-Smtp-Source: AMsMyM5RKbnXhzfaWq66o8aetgmUIRnVCf4JDu5bDRQ8blAeKzo1UhI1ScAeK0mArkDtTC0Zqp5D4g==
X-Received: by 2002:a05:6000:1565:b0:22c:8da7:3cf8 with SMTP id 5-20020a056000156500b0022c8da73cf8mr15576161wrz.688.1664377138583;
        Wed, 28 Sep 2022 07:58:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a5f54e3bbbsm2206752wmq.38.2022.09.28.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:58:58 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:58:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 01/27] kallsyms: use `ARRAY_SIZE` instead of
 hardcoded size
Message-ID: <YzRhMBE+QoBpghNl@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-2-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:32PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This removes one place where the `500` constant is hardcoded.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
