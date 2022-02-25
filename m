Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B94C4FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 21:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiBYUap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 15:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:30:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26411F0834
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 12:30:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb21so5759357pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 12:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ma9z/Vaet4cNibBLFUshjCbJ7RhLmRGmDBAidk2rjl4=;
        b=ZvPosqE1piSPRZUoxIztbYB69fGRRyeLsWxONElWVR37i/Ap2KhJev4WVvlQUtkAEy
         Sij2GlDgTJ5HDBY0NrjSNLQcc8Y1QF8+83PXHCxcKT1CygoE0T6hIPXAxWHqdLJm1spS
         cUncW/j/xwH5WGZ3OHFOMKcC9KF2j4M6TJ/JNGtzBRxWWPso+dHkdkYQNKFoZP0i5Qak
         e8PfCY1qcsowJijlHyrYkl6lRDQf5WANL0bWJuBzMUgVjMrkBEm5t0yiqi0i38vG9wt2
         9lM/5MoUaOxIo6CS4TVb7mh06VYQnMMaOffSQ7cJrGlKnFmZOpoaaIK3n+qP2YNURlou
         CSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ma9z/Vaet4cNibBLFUshjCbJ7RhLmRGmDBAidk2rjl4=;
        b=Kzq2TxgENX+2mCaoKQ8JNUvv61pkwSXKUyxuisEzEk84QwVZJPGRi2gcN7lMGZKkPz
         kTIaUR+kikUhRV7G/eY8tGF3obO20DaaHxruq3tufyglgLeFpDlFy4yROjfjLFAKWIll
         fpXkuuF//KppL3QshAg2re18rEXoE86PDygiZeI31Hd0POttLYuoVZbohmLsSUtAXOjd
         Ukv0uolS2IN4dq3KYvhAq2BOxB6Q3fQlY6LqWvyjtMop3LCMYXbuBgVyYkDkdlfCt+WI
         VukxtfLD57GFWOkbMCQwPAU3tR7H2JfIAZsbX7LC6tEsaMoUrqebwk8gFl5FeMdTD3zC
         tWuw==
X-Gm-Message-State: AOAM5317fMN2RVeYWr81YSvU4L0yR1JdhWQ4G6Z2P1bJ+tWehs2WPFJK
        cOu0zQZ58nkcrbf5F27FHiWb0UWYrc0KFQ==
X-Google-Smtp-Source: ABdhPJwyjnd+apDy5MI/WGOaTiaf3zRd4xwr8kucRv9gdSXCfpYIKalZM2EZts2dVT+2JObK6KW/dA==
X-Received: by 2002:a17:90a:1d0:b0:1bc:73ac:6e3c with SMTP id 16-20020a17090a01d000b001bc73ac6e3cmr4935181pjd.204.1645821011321;
        Fri, 25 Feb 2022 12:30:11 -0800 (PST)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c15-20020a056a00248f00b004f10a245b83sm4344513pfv.73.2022.02.25.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:30:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@fb.com>
Cc:     m.szyprowski@samsung.com, viro@zeniv.linux.org.uk,
        rostedt@goodmis.org
In-Reply-To: <20220225185326.1373304-1-shr@fb.com>
References: <20220225185326.1373304-1-shr@fb.com>
Subject: Re: [PATCH v4 0/1] io-uring: Make statx api stable
Message-Id: <164582101037.3890.2475866668522000841.b4-ty@kernel.dk>
Date:   Fri, 25 Feb 2022 13:30:10 -0700
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

On Fri, 25 Feb 2022 10:53:25 -0800, Stefan Roesch wrote:
> One of the key architectual tenets of io-uring is to keep the
> parameters for io-uring stable. After the call has been submitted,
> its value can be changed.  Unfortunaltely this is not the case for
> the current statx implementation.
> 
> Patch:
>  Part 1: fs: replace const char* parameter in vfs_statx and do_statx with
>           struct filename
>    Create filename object outside of do_statx and vfs_statx, so io-uring
>    can create the filename object during the prepare phase
> 
> [...]

Applied, thanks!

[1/1] io-uring: Make statx API stable
      commit: c22368edfa24ec033f9328b3328aaa0349c15e6c

Best regards,
-- 
Jens Axboe


