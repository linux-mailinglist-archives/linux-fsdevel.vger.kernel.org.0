Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A4760177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 23:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGXVpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXVpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:45:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD5126
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb8e45185bso9587355ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690235129; x=1690839929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL+qyCoyo+/FJmxYMvT7Q+EYVA+uxQICVRbaCHaHDjs=;
        b=DIHnVpSEwqHHJlzY6W9W4NKUk5XErF3q7aFfo3LVjbbdatZgl/wAoDVnstbjon4uIe
         2GuyeWvFugaMgG2rSx4cMe1TTZkeK/cTue+Ze8zEmfUbhZVXNRGMaXboZU61TpTDRkXf
         XFYCUa4te9rMhtXUVLVcCsM3fiyzctK4mNfRQj1SaJlJl1RATSiTcbNih/JPLeBnuu5D
         6AsdNm/IEEGRbEKHOV+npEAa6zqwwyvVKnP3Kj3YsSsafZR5ZTI08Ff43V1vzwb/Ou75
         wEMT9uTA+iz/8cWLApA3PwP2p0tnaX9VyQjsak6hUJ9+7q58aW19fxZjmau/Fnpxj1SV
         ZCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235129; x=1690839929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL+qyCoyo+/FJmxYMvT7Q+EYVA+uxQICVRbaCHaHDjs=;
        b=Ks5H2/fi08QbQBWeXf1yw57wmpqMxn6b94Rm0OK3IStvbz9GVVGSXtwbJEv3zqvxId
         wdHRA6OiGDyWgaPMdD2JMB9IgfNivSqH6VEpyx/xo6cX8fwBZR4sLUXkUlpBxHVStGv1
         TxvHc+HiDwuyfgP6dnRgjiBJpomRes8eTfBtELOW2OekrR5vFZ2Kb7vstNRcSp4BhYEu
         PjAI8U7zSV8QymrQW8dLhhR2JiMWcwnyGDRg2Pxz8CCALtaSOGF/PvnU37RKO6hpk8mi
         NKhgjhDJVedkEz56htwaRgyMuZLse7sEsnxtQXHIJsRKS/jVpf0B5UsiNAz27ajUsuW/
         D6EA==
X-Gm-Message-State: ABy/qLa3U/gfwjOoaaDQWBY3y/yUni8zpsC3yVkB2wA4dG0qnm6quT0W
        3bxeCNL3USShtba2X4p9qmt/Kw==
X-Google-Smtp-Source: APBJJlFVYzbLkqR812PkG7EThpJBwIewq1AsZm8jSGhh6K6T+XZ7HOnrvtv6QkZaNw91N+189A/okg==
X-Received: by 2002:a17:902:e805:b0:1b8:4e69:c8f7 with SMTP id u5-20020a170902e80500b001b84e69c8f7mr9822845plg.23.1690235129133;
        Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001bb9f104330sm3196450pll.240.2023.07.24.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:45:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qO3Mr-00A6cJ-2H;
        Tue, 25 Jul 2023 07:45:25 +1000
Date:   Tue, 25 Jul 2023 07:45:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZL7w9dEH8BSXRzyu@dread.disaster.area>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:23:31PM +0100, Daniel Dao wrote:
> Hi again,
> 
> We had another example of xarray corruption involving xfs and zsmalloc. We are
> running zram as swap. We have 2 tasks deadlock waiting for page to be released

Do your problems on 6.1 go away if you stop using zram as swap?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
