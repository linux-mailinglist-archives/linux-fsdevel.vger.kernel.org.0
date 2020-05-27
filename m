Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2C1E491C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgE0QDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389267AbgE0QDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 12:03:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B8C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 09:03:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l3so11382757qvo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4XAF2qs5g4AY/r0EWrS8+9mLHbgcJOtXMG15PYfY1M=;
        b=FAkcrvKPhwXHPzhdsTR4NIhbFqwfLMvAV5bGTRBFGbczDHZC/aQDPVNA9PY7cGrlvI
         OAU7sMfEHvFrbqT7CvtkuJGTkLTQG5KPLvLc06tbn9wyvDUbjiyyqowgDNO9WndwvoJj
         X2dl1qZDNUOZqVESipiKNZd2Z60Nw52ZyxG0kUa5w+Kb9fsoxQn99KBAnvXQXuidqHXF
         g8B5P2fMOTarggI1cwoQW6OJquoa9Iej9VuFDR2ehmtvCwzE99l5fAoHQpqyCpeiAEEr
         Af1ivrgSbwVp3LHhcKFdtzo1qHJKVNeAaLsKpBMc9QZNWJkGiTDvSPU22BKqJthweSfF
         Xblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4XAF2qs5g4AY/r0EWrS8+9mLHbgcJOtXMG15PYfY1M=;
        b=Efs/8lENdRpmnHYpDRpyuMQAa4dA6Ug1db9rVrTDBqa9if4J0WMEajAve1/Oag3F/h
         456wtQmezPYO7kYffpO2uWX3lHUQoQ45oGKH0tJtPQM9r+7/q+km88Cy1VNAI/x/IR7j
         uxB21qnPrbBTKY610k+OY8Mgb1J1JuxJsfKTwIqLCzBuK6V3WZtsjoeI9n7LIQmUNW0R
         W0wqnj4Y7NuMjD88A5JA1JD0LzoZEq61acInqGOeECtJwmRumg4CyRAspIA4+pWlLEzC
         vrezlBPCpluGtg6b3fo8uvgWEYFVPXZeTr1uS2TFVW+VGM7wP26iVIX9tjj9DI0mr3J1
         xUoA==
X-Gm-Message-State: AOAM530Fi/+62D4e7SKqh654fiZTrOotJ2DuuaclQiArdFB6aBP1OQTa
        xbHBAY/YHz2mUliNdwIiUgf/sQ==
X-Google-Smtp-Source: ABdhPJyGGNRt6GbiZDvAAJR7JhnDFJNuzQwWePJEhdbGDeVQFHSsv2y//UkvfCBcqxVwmEGqiS8tHA==
X-Received: by 2002:a0c:f486:: with SMTP id i6mr24701658qvm.190.1590595402656;
        Wed, 27 May 2020 09:03:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id g66sm2485148qkb.122.2020.05.27.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:03:22 -0700 (PDT)
Date:   Wed, 27 May 2020 12:02:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 04/12] mm: add support for async page locking
Message-ID: <20200527160257.GB42293@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-5-axboe@kernel.dk>
 <20200526215925.GC6781@cmpxchg.org>
 <152529a5-adb4-fd7b-52ac-967500c011c9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152529a5-adb4-fd7b-52ac-967500c011c9@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 04:01:07PM -0600, Jens Axboe wrote:
> On 5/26/20 3:59 PM, Johannes Weiner wrote:
> > On Tue, May 26, 2020 at 01:51:15PM -0600, Jens Axboe wrote:
> >> Normally waiting for a page to become unlocked, or locking the page,
> >> requires waiting for IO to complete. Add support for lock_page_async()
> >> and wait_on_page_locked_async(), which are callback based instead. This
> > 
> > wait_on_page_locked_async() is actually in the next patch, requiring
> > some back and forth to review. I wonder if this and the next patch
> > could be merged to have the new API and callers introduced together?
> 
> I'm fine with that, if that is preferable. Don't feel strongly about
> that at all, just tried to do it as piecemeal as possible to make
> it easier to review.

Not worth sending a new iteration over, IMO.
