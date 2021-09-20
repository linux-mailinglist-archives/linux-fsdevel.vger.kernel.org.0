Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE534129E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhIUAYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhIUAWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:22:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D1EC0FA75C;
        Mon, 20 Sep 2021 10:55:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 17so18161117pgp.4;
        Mon, 20 Sep 2021 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vR0eyDgW0+ZEcHoejwvFez2+LwYKhi8aV0OBAhaelJo=;
        b=p604AQfCitOKbr2cWdPPPs2nIliLZL00TGv3Mox5xld5PWEq869Y8KyemmmF7xDKy+
         eznw9TiloP+yS7DvUdNW3EUPHieVBVpmlNyfHCirogTorYJwxpfJpot5/Ncknl0xQAaH
         keNk/Kkw3utp2XrCGofJr7QxW+Z2eQxrPAlQNS/Hg3Xssdo9nLf1uk5t6rqnexz3sqqQ
         CoXnFX4FmD5398RDC+ganCKBppgTv5Kx+xDyR87QID3hEpYWy592gHpA/ulKd3vB4TeC
         nnXt3QpQy2wo59YDhIX9TDeNkTdxMt2xRg+S4TUzt9xzf7WJ6IT8GWvz0JS7bvFq2+KJ
         Wf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vR0eyDgW0+ZEcHoejwvFez2+LwYKhi8aV0OBAhaelJo=;
        b=q2p6NxZ/ne3xhKCf1GbH6WsR1exnMhIV/lGIMNNll2kWAgq4rZiEKRTd0oFjDFk+zw
         q7Tz4K2UMRaGGdcoHdnklF65pjF19WRhuSNAtlwvyDQtBn+gp0zWHzc4aQvbogm7bG+p
         WCO6wXfr3QSLJIJ1iBNdtdtX6qBquuDr8CRwrS3weU4tKb4UH3GCgNQpaup8jM7T9s/J
         6flmGt16IwKTdtNYjO/VMPGsOQk0KKaO+BS7leIdlubxPD+iqRDNPgvFzQuxR+iWhddF
         J/XfdsLw3PQ+FE/jHDzm28DpCQE2c0yHAB5MeVF0D8UYcN5jh2VrnyFYJwL4kcQBLyF4
         mDOw==
X-Gm-Message-State: AOAM530eAYpFzLwI1T4zA//Wqxu+pCz7WlyA4qblgpiLVKaInj6M6m58
        eMPrfiB1ulE7fC0EBLJZ+5c=
X-Google-Smtp-Source: ABdhPJwKDDkC8MGcm/wrJKqX6PJkaGJO3PS+75jbEsUXhh8bTf0aqiNy3RmyulgGnbn8xmD1KseQUQ==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr24515003pgm.143.1632160514712;
        Mon, 20 Sep 2021 10:55:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z8sm14710084pfa.113.2021.09.20.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:55:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Sep 2021 07:55:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 00/12 (RESEND)] syfs: generic deadlock fix with module
 removal
Message-ID: <YUjLAbnEB5qPfnL8@slm.duckdns.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:04:18PM -0700, Luis Chamberlain wrote:
> In this v7 I've decided it is best to merge all the effort together into
> one patch set because communication was being lost when I split the
> patches up. This was not helping in any way to either fix the zram
> issues or come to consensus on a generic solution. The patches are also
> merged now because they are all related now.

Building up all the testing framewoork is really great. I have no opinions
about the license related stuff but all other changes generally look good to
me.

Thanks.

-- 
tejun
