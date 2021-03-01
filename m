Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1F3281F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhCAPMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 10:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbhCAPMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:12:37 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3EC061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 07:11:57 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id w1so12222873qto.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 07:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ct8/HXm4PvFW2Oulk/4QHDKP4zoUXmSFNvN+LgI4w3I=;
        b=AiQl/JDHfPsvedC1nQhgBTSI7smuAPUug2Krbf4f/MILwd2jUCJjL8u45oxJr3kTI9
         yLHIC0RJiD/sWvoyDqRwriCL7U1gtO4A8YcDSGZ6gn7VkOLKavHAT+Whv/56xYAFJK2F
         ncR9Ac83aWi/VtmrwrE73OgKi3PirvgMyOFOZxs9Mw/NMjtADCRByBZryRibrtUDmdcj
         zoM13AQjmI/B7HhnAkkH53l4e3p+mVp86j+SR4p3mxFx5Q6lSN13Hw5t8GU739THOXl0
         YegjMUNWm0cT4yHRLhlrGgRpQvfK1bfs6QrJPuCMSNNHmPmvyxFBDHqQmuqwU9+XxzpS
         Wt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ct8/HXm4PvFW2Oulk/4QHDKP4zoUXmSFNvN+LgI4w3I=;
        b=hy5Os6FoAABj6u6+LI918BFIHB6xetuoksf2WX2omGCavCE4N8EBABbJXN6RYuq7aE
         RWitnJnx/y0m30tLpyKJVcpuo8ppP1Lb7ZY3Gw+1Ph0DzDHGMBTQJcVpAbs3IwIxziim
         gHfV7cC5KNPkZtKb2LLpdeTCXcoA4efhg6PDVfKnaMDJhKNkI5juRMa/BD+U8MFC2P2Q
         izNTEstz0xMxOo1iYQaS8oj8CbTMZIOQV/Ja4+XxBlaL8hyXLt7YH66RzXfJK3t/KkF8
         lym0gl/sF0X19T96zUW/HzdKUKYQMISedAWP5u69bO7rdyQTpvG3q3eIpF8d+AQV2HeL
         MhGQ==
X-Gm-Message-State: AOAM5334B4ah1USv7nUTMqPVETR7fPrFaCS1152JqzbvjfMYXPJzrhBV
        B2i3jAUF/DYsvKGUtoQpTI6Xww==
X-Google-Smtp-Source: ABdhPJwfre6Kxdeuv/+tQbK34iuUy6atKpPva3cy6VBps76K4DBNRrqtT+Y6DVQohJfGc4AwOb1+dg==
X-Received: by 2002:a05:622a:34f:: with SMTP id r15mr13598379qtw.107.1614611516907;
        Mon, 01 Mar 2021 07:11:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c0b0])
        by smtp.gmail.com with ESMTPSA id a14sm9274552qkc.47.2021.03.01.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 07:11:56 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:11:55 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Pintu Kumar <pintu@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, nigupta@nvidia.com, famzheng@amazon.com,
        andrew.a.klychkov@gmail.com, bigeasy@linutronix.de,
        ping.ping@gmail.com, vbabka@suse.cz, yzaikin@google.com,
        keescook@chromium.org, mcgrof@kernel.org, corbet@lwn.net,
        pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
Message-ID: <YD0EOyW3pZXDnuuJ@cmpxchg.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
> At times there is a need to regularly monitor vm counters while we
> reproduce some issue, or it could be as simple as gathering some system
> statistics when we run some scenario and every time we like to start from
> beginning.
> The current steps are:
> Dump /proc/vmstat
> Run some scenario
> Dump /proc/vmstat again
> Generate some data or graph
> reboot and repeat again

You can subtract the first vmstat dump from the second to get the
event delta for the scenario run. That's what I do, and I'd assume
most people are doing. Am I missing something?
