Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB626F1CD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbjD1Qm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbjD1Qmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:42:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B983
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 09:42:53 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32b2f781f59so1411265ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682700173; x=1685292173;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwKZXtxEC5afAI0RfzWLmHV77t7nAYDm5uvC1VRuKsE=;
        b=Uej+egb2aTEJUT8THcGD3Sihv+fBDktgenu91z1lvae+3hh9KFQmNn4zNTLCksM4QD
         EVPYiyoMbVLBCJCkgoZ9M+it1gw/aib01gxDZXDPJxN3Ha7G+4MSCpTqm+vZOat/BqSS
         /mPUkmOq8mPmlJftAxhj3ojf8HRvQCd9D8IQGMduH2b4G3qpJpF+AA58PPI11d0sAhgw
         AcDsD7FmwcYT2ImwhvVtb4pk6yJgRYuvH+udCTZDXeTWstDI1Ps/ED9h38Z5dYy0eb2h
         Aa/d48BQHQ8VFZDLj3expNBYtTLWcuckwDJf0JwwAbRAnwFQ/qcmOmAYfEceuNUVKDYr
         3S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682700173; x=1685292173;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwKZXtxEC5afAI0RfzWLmHV77t7nAYDm5uvC1VRuKsE=;
        b=DsG87uoin53MyaEiNw6bGVycjh9UIpwy3C4oIF1LUWMrUAZmFyFSXo3TWyAw8ns6kN
         RUjN/df+speQt+PyutVnvqQ5SHtqfzNvE6Sxc9scbX2kJ9UgedKyOOVrjBBOB13ahMcw
         Nx3QoUtC7Xmx0V5elgKd0g9UgReImpLmCMJqDirdw3ukulNd5yogEDDOGWoGlbz1GPuj
         oE6kUH2xwKDedWs8rGTo4pJeWvy55eGq8hz3cnWVRDp2GyNgyX4HJCi/dfOcVhVcbiLO
         +OiL6Ced+UuQvQjLQKrg+sieEcNdJklsn6BgFF5NaNzOablBkZXMOnQTlKDvmsHYSjAX
         PiVw==
X-Gm-Message-State: AC+VfDwr4IYbj6DKQCq9Bgf70kkApkHjyZ62kLm/qwNstLQ99NOuBqDK
        8CJvhWjVJQjNyEEs+FfQX7iMgQ==
X-Google-Smtp-Source: ACHHUZ40B8F4CPjsbNfKnbRvhC1bgopLD1WmRmD6PNjBlG+vRNcCJJGmTiZ52B8O6xOLzk5a53sBUA==
X-Received: by 2002:a05:6602:1554:b0:763:6aab:9f3e with SMTP id h20-20020a056602155400b007636aab9f3emr3881933iow.1.1682700173266;
        Fri, 28 Apr 2023 09:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a25-20020a6b6c19000000b0075c37601b5csm5851117ioh.4.2023.04.28.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:42:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
In-Reply-To: <20230119104443.3002-1-korotkov.maxim.s@gmail.com>
References: <20230119104443.3002-1-korotkov.maxim.s@gmail.com>
Subject: Re: [PATCH] writeback: fix call of incorrect macro
Message-Id: <168270017224.244941.5034701442870522823.b4-ty@kernel.dk>
Date:   Fri, 28 Apr 2023 10:42:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 19 Jan 2023 13:44:43 +0300, Maxim Korotkov wrote:
>  the variable 'history' is of type u16, it may be an error
>  that the hweight32 macro was used for it
>  I guess macro hweight16 should be used
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied, thanks!

[1/1] writeback: fix call of incorrect macro
      commit: 3e46c89c74f2c38e5337d2cf44b0b551adff1cb4

Best regards,
-- 
Jens Axboe



