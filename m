Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB58E718E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEaWay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEaWax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 18:30:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596209D
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:30:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-397f13944f2so52393b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685572251; x=1688164251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fxfV5VcNo1HuNl1BAlDq7x3auo0HGUulH0i8hWzvcQ=;
        b=aZHYvexed48WM5IBidrzNTTUHgyWvwj9jzFpiCEH/huHzSVxtvHsAWNH8JIHLFj67n
         4G0IYsOzn+FciEUpUgWQoR1hQKb2q1dm7vWFlTY+EyzkYvPTuy8mNZ+f11iJsy8+yZJn
         EKyubvVaua/MsplXg1t04POt9rYmzvWnkNjuYZoeY9f6+1X9FPfewNrOX6YFLeip1dAs
         LdObE2wvIsCWYpbdflvb21BNLg/QneriumlKUBicYw22PNqInLjM4SVdeUMh128KMLjU
         poox4XkN5tobPAgLGJ9uN7SOXZn1VMv4XLq8GYmNr++ilqWGT8xIEuRed4oXZFiPSg6z
         9ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572251; x=1688164251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fxfV5VcNo1HuNl1BAlDq7x3auo0HGUulH0i8hWzvcQ=;
        b=MtsdVfhzSVOMjGHp+VBTNj+wz6zxPH6DAj2qDit2iafkjFQnKnrIWs0zDJLKIDP8nk
         pcdWrC17084H73n80c2prIFctcngLh/CQtRHF1wJN9bcbaGpzdqU+XzHc9Rg9A2budPK
         qyF9iDLwajWsy5mxp/Q0P75OOWtueZoJkHBLj9sqIte4k/DLWH6kagKCncsJkhjhqpCb
         8n84r8NiPM/Nao28Y9J9jHchtlivSdNa0i6hkUeT51qrGW+sYFSpTAwgcHuAmgUa205g
         piA+p85r4Ft9ffuI1xeD7us3n6uMjgP/CMxp5ePSFSEv+Oc0OflwYp7KMy1CK00IzOY5
         7THg==
X-Gm-Message-State: AC+VfDzKcBh5TzmX80hPlMwE1QLR9CePWIdWCC5WmxCWZfJuW2WhcM05
        IJUaGk8lPuGvXgo2gfULSL3Kxw==
X-Google-Smtp-Source: ACHHUZ5eCf2tJFtsvUL8ppbW7rTCZstcQT9dxFkvwabquAdExDT8tCX3d8b1NHSMngPsfAhFMsLxwQ==
X-Received: by 2002:a05:6808:3090:b0:395:f4fd:9fe9 with SMTP id bl16-20020a056808309000b00395f4fd9fe9mr6871739oib.50.1685572251471;
        Wed, 31 May 2023 15:30:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id jd5-20020a170903260500b001a245b49731sm1908603plb.128.2023.05.31.15.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:30:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4ULA-006HBu-12;
        Thu, 01 Jun 2023 08:30:48 +1000
Date:   Thu, 1 Jun 2023 08:30:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Chen, Zhiyin" <zhiyin.chen@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zou, Nanhai" <nanhai.zou@intel.com>,
        "Feng, Xiaotian" <xiaotian.feng@intel.com>
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <ZHfKmG5RtgrMb6OT@dread.disaster.area>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
 <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4931D767C5277A37F24C824DE4489@CO1PR11MB4931.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 10:31:09AM +0000, Chen, Zhiyin wrote:
> As Eric said, CONFIG_RANDSTRUCT_NONE is set in the default config 
> and some production environments, including Ali Cloud. Therefore, it 
> is worthful to optimize the file struct layout.
> 
> Here are the syscall test results of unixbench.

Results look good, but the devil is in the detail....

> Command: numactl -C 3-18 ./Run -c 16 syscall

So the test is restricted to a set of adjacent cores within a single
CPU socket, so all the cachelines are typically being shared within
a single socket's CPU caches. IOWs, the fact there are 224 CPUs in
the machine is largely irrelevant for this microbenchmark.

i.e. is this a microbenchmark that is going faster simply because
the working set for the specific benchmark now fits in L2 or L3
cache when it didn't before?

Does this same result occur for different CPUs types, cache sizes
and architectures? What about when the cores used by the benchmark
are spread across mulitple sockets so the cost of remote cacheline
access is taken into account? If this is actually a real benefit,
then we should see similar or even larger gains between CPU cores
that are further apart because the cost of false cacheline sharing
are higher in those systems....

> Without patch
> ------------------------
> 224 CPUs in system; running 16 parallel copies of tests
> System Call Overhead                        5611223.7 lps   (10.0 s, 7 samples)
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    5611223.7   3740.8
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         3740.8
> 
> With patch
> ------------------------------------------------------------------------
> 224 CPUs in system; running 16 parallel copies of tests
> System Call Overhead                        7567076.6 lps   (10.0 s, 7 samples)
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> System Call Overhead                          15000.0    7567076.6   5044.7
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         5044.7

Where is all this CPU time being saved? Do you have a profile
showing what functions in the kernel are running far more
efficiently now?

Yes, the results look good, but if all this change is doing is
micro-optimising a single code path, it's much less impressive and
far more likley that it has no impact on real-world performance...

More information, please!

-Dave.

-- 
Dave Chinner
david@fromorbit.com
