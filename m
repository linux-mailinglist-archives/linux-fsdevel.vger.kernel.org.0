Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C51213FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGCT0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCT0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:26:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F8C061794
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2020 12:26:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so24955529ljm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mo/Lr6vtY0FHiwQhfz60EO8eUAwTqrdef24sgk/B+aw=;
        b=CvUdAxIUjjv3eTbj/BWheCVE2Pg7nWLLM86PV0t6XiWuayCHWPxFfaZ8EbZpon319V
         VCY8rg7b8q5a4X3vnWEWulRKh9vC5zcI8uKUn93TOfwMf1XNkpMYMf+ksYc9LPXSKWyw
         o64QSDIrjSME00hQS6hVsF2vNMnsXDtOFTpv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mo/Lr6vtY0FHiwQhfz60EO8eUAwTqrdef24sgk/B+aw=;
        b=meNbdnYRw7TBI99gRp38CiJCF4GUrimMP7bUTbLbJNDrB0xQxf5xAE/GZDggDfCGZJ
         gQ1ayDmO5r0Mj6oqyjemGgC7DZQRuIt1aq0zboz2UInX84B+/GR4TvvwJ+ziE35W+lWQ
         2tPixAUDSrSxNXeOdSGE7m7Dy8MTIsCWHIgNXu4ydUVaGL2qbZEh77770x8jobE8ZMYD
         cfZtRoRiRVmRFXXVG7SqArDsaj3CLzGD06kiiYMEcrqZCHOLcNWPUWhIwuVntBxSxL7g
         MX7t1kZco4RkYGSy7/q/VtiCm+lOC/c37hjXCdjvQ7utrVuJdjVtOplQdp2qfhsH5llm
         GkSw==
X-Gm-Message-State: AOAM532uiRdqz4mf4L4LJziKl3XxyyLAv8hr8/nbFPWklNpIhXaIHbzK
        6FuLItbTQFVAuSyyZIYrl1/hyiry6DM=
X-Google-Smtp-Source: ABdhPJynVpHfuPRUgg8HQvaIOZKCKIx8Lp9iz2SuBmLEdzfeaF9Sh2X6N81EAdh61Zarn2HWCacQDA==
X-Received: by 2002:a2e:8882:: with SMTP id k2mr11202842lji.352.1593804395429;
        Fri, 03 Jul 2020 12:26:35 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id t15sm4394310lji.49.2020.07.03.12.26.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id s16so13627944lfp.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr23140481lfq.125.1593804394241;
 Fri, 03 Jul 2020 12:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com> <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
In-Reply-To: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBk-jYM6_HBXbu6+gs7Gtw3hWg4iSLncQ0QTwShm6Jaw@mail.gmail.com>
Message-ID: <CAHk-=whBk-jYM6_HBXbu6+gs7Gtw3hWg4iSLncQ0QTwShm6Jaw@mail.gmail.com>
Subject: Re: [RFC v2 0/2] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 12:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I see nothing wrong with this [..]

Again, I didn't actually look at the gfs2 parts, but I assume you've
done all the testing of the deadlocks etc.

The IOCB_NOIO patch you can add my acked-by to, fwiw.

          Linus
