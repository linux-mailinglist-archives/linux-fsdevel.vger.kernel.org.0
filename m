Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFF606096
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJTMuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJTMuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:50:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C4EA377
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 05:50:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l4so20205616plb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T6X+tt7V+91kobXX12t6/xBrHgsUusEkXMw0L2QMKo=;
        b=V1e+eumcTbSiXyjph0yA3r/AC6Jy3E7VdU0fC5UdvN3Jjv5eHkX+KRzb3g/5Snd3ZB
         TO3UwH0dGpPsF3IU1lCS+drZ84tqXau9dHvtNPhV2RLawCrjLIQ8PR4P5KZqR87/eJqb
         SE0VT26rx6WgMpUXzQiyNswQClOxqQojw78L07iPRMxPxe3bOhmP16OZQ6rbU0gwzOxU
         KnGQSw+KJJBW8s1zOep5CjR4Fmsir+FCzi9T8L9Okp56p7CnC33SIIoZB1zuZMOvWIPD
         RMXguy9y9Ej7zdSAjXnm6we46Y+87YtUPtndgbrZl3Bjtl/wMhRUbj0BQhxgNuJ6Dgcp
         Y9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T6X+tt7V+91kobXX12t6/xBrHgsUusEkXMw0L2QMKo=;
        b=IZQCn+eplaLzOFUu7//4Qfgg580yH8qjmNT9fEH6lIgoanbqrXNCGVJekw+Tnxx31u
         NNfvtJhswPFAjvGUzuSpdfbvc81zv7UuMOK2XQIBBnyxzDrFbzR4r4Ea/p3gWKmHRmE9
         5+XKYwwkuVUAdzBrIWtG0fVQbYB0aJYI/NVwqdh6ks8MJb6esJQIVzEWZnjyXifsT5FD
         AQvFqX/JlpiSB8zBg9xfyTw6Bz2kZI5DALJRuyUfb2QjRr0AbcXcSa8f6Lby+hrmY5Ww
         Jo3PBf3QedTNQhsHy8gNRPYHxcyMq6EOfRDFhPu34qe5/f3sC7UQA0D9YdqQX2LpM+09
         yrcQ==
X-Gm-Message-State: ACrzQf3b6+IZsqsmEDLWmzFuiqABOOnWFLpWfem9DeECsvuZ9fRwFLYh
        OCIi1rsJC73+M7K6HHQr+R1y4A==
X-Google-Smtp-Source: AMsMyM4TRzgWshHzykwjj+0oSUfvvDKlhXsmbl0EEBW/4qsIASSjpO/zYNZVz/MgLoZQ1OlX/n7zyA==
X-Received: by 2002:a17:90b:2243:b0:20b:42a:4c0d with SMTP id hk3-20020a17090b224300b0020b042a4c0dmr49870333pjb.123.1666270238215;
        Thu, 20 Oct 2022 05:50:38 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm12885047plg.146.2022.10.20.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:50:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <cover.1666122465.git.asml.silence@gmail.com>
References: <cover.1666122465.git.asml.silence@gmail.com>
Subject: Re: (subset) [RFC for-next v2 0/4] enable pcpu bio caching for IRQ I/O
Message-Id: <166627023722.161997.8160242378689353670.b4-ty@kernel.dk>
Date:   Thu, 20 Oct 2022 05:50:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Oct 2022 20:50:54 +0100, Pavel Begunkov wrote:
> This series implements bio pcpu caching for normal / IRQ-driven I/O
> extending REQ_ALLOC_CACHE currently limited to iopoll. The allocation side
> still only works from non-irq context, which is the reason it's not enabled
> by default, but turning it on for other users (e.g. filesystems) is
> as a matter of passing a flag.
> 
> t/io_uring with an Optane SSD setup showed +7% for batches of 32 requests
> and +4.3% for batches of 8.
> 
> [...]

Applied, thanks!

[1/4] bio: safeguard REQ_ALLOC_CACHE bio put
      commit: d4347d50407daea6237872281ece64c4bdf1ec99

Best regards,
-- 
Jens Axboe


