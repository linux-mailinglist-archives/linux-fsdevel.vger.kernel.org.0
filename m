Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420074DF6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 22:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGJUiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 16:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJUit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:38:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB81195;
        Mon, 10 Jul 2023 13:38:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9e9765f2cso6389985ad.3;
        Mon, 10 Jul 2023 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689021528; x=1691613528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AANwmYnIjrNG1ny8ADZlcMF6VhBoiSpdnMPHT/u0j+U=;
        b=a9vlDHib/vMGEM7aj5ZziEIfVB9053U+yrZ7to7Yd8hR15TTgPRZXqM+aIlJDlWKPY
         CrJBsGBouks3CfFEd3QRv1Yh7dQm6xNAOqgHHU3VN9DNSaL1+tpwRU5rlXJO9ismFxe4
         Hq/4DleBOQdSXFD+XjWaDWY5xLt3mvgWf3U05EAxLNXXbn71AVZT33qR+hN/ZA7W5iti
         j2FlnXR+XTocZTLDWBsxKRyv8pcEf/x0EXhFXyFuz/MUiowyCCXOmCwW+UUzggU47gSN
         4bXR7XPV2Dca04qA0GJHy7NqllrEwRZPjVMgpFgoNDCPdqsRtEzr3a5JOoqHOKvIgcfJ
         pOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021528; x=1691613528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AANwmYnIjrNG1ny8ADZlcMF6VhBoiSpdnMPHT/u0j+U=;
        b=jfc5ZugQLFri2Phl+plsTHes12Ah8ake1U3fyrvQZ6Bq1naVi6PE/3bPjpSijP2PID
         0JzlE1eJa4WoGHWtZFjw6xqPnepn46RY+6mF5vb8gvP8e9OHZOwL6c0XAqSyqNtvR6zQ
         4/UgFxGs7QgulX2+Kyo76cBU8jkkUXyl+g3pPV++yAGbleF2sGpvKb1H8xE/L1P/EwBg
         VTUx1Y6b7jBADEOpo6LaJbnh6U0W5gOsYiceyGa9QYVKxKfsshGGDLAuup8hztn+IJxL
         RONwK31w54a7YNd/M6mC4zxuz/3f8YPgpZjmDs1Z7jUF0nDn4G0myK2dt42edYruNAwm
         BwUg==
X-Gm-Message-State: ABy/qLa5hEe1qNwldFMg7/1YoXEwDykei4Yd9HVQweubANhpaFLYd7af
        Qc+iO5VRpOQsgCfjOnBBafc=
X-Google-Smtp-Source: APBJJlEZWuY/msbyREsMLqJ7pXCL+z6hIoLk4MAu/D5lqGRN52QX2Ydh0HXQ3I0i0YHXmtzXIStPwQ==
X-Received: by 2002:a17:902:da92:b0:1b8:50ae:557 with SMTP id j18-20020a170902da9200b001b850ae0557mr12453868plx.36.1689021528394;
        Mon, 10 Jul 2023 13:38:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709029b8200b001b891259eddsm300297plp.197.2023.07.10.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:38:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:38:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZKxsVuDqdr6IJeyv@slm.duckdns.org>
References: <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner>
 <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
 <2023062845-stabilize-boogieman-1925@gregkh>
 <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
 <ZJyZWtK4nihRkTME@slm.duckdns.org>
 <CAJuCfpFKjhmti8k6OHoDHAu6dPvqP0jn8FFdSDPqmRfH97bkiQ@mail.gmail.com>
 <CAJuCfpH3JcwADEYPBhzUcunj0dcgYNRo+0sODocdhbuXQsbsUQ@mail.gmail.com>
 <20230630-fegefeuer-urheber-0a25a219520d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630-fegefeuer-urheber-0a25a219520d@brauner>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Fri, Jun 30, 2023 at 10:21:17AM +0200, Christian Brauner wrote:
> What I'm mostly reacting to is that there's a kernfs_ops->release()
> method which mirrors f_op->release() but can be called when there are
> still users which is counterintuitive for release semantics. And that
> ultimately caused this UAF issue which was rather subtle given how long
> it took to track down the root cause.
> 
> A rmdir() isn't triggering a f_op->release() if there are still file
> references but it's apparently triggering a kernfs_ops->release(). It
> feels like this should at least be documented in struct kernfs_ops...

Oh yeah, better documentation would be great. The core part here is that
kernfs is the layer which is implementing the revoke-like semantics
specifically to allow kernfs users (the ones that implement kernfs_ops) can
synchronously abort their involvement at will. So, from those users' POV,
->release is being called when it should be. The problem here was that PSI
was mixing objects from two layers with different lifetime rules, which
obviously causes issues.

As Suren's new fix shows, the fix is just using the matching object whose
lifetime is governed by kernfs. While this shows up in a subtle way for
poll, for all other operations, this is almost completely transprent.

Thanks.

-- 
tejun
