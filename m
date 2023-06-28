Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9A7417B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjF1R7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjF1R6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:58:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409392684;
        Wed, 28 Jun 2023 10:58:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b74791c948so3462667a34.3;
        Wed, 28 Jun 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687975131; x=1690567131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzqci8MIgjVyIUaoMuFMWhowYf714G+EhdihjPJLgC4=;
        b=JAO1w2EsXI/zq+eWUGmEP73JL7iOhBWV4lhCpiCiU6RN5gwNWB77X1NBAUmnwNGT/r
         wU4/m9Ru19vZvQDm2ByOZvYQngyoRsTMMwJM9+7HmOeHJS7xuFKVPqVmxPIBRdXZMa3C
         qKU9HAjqyLzxXGgD51nAY5LlvGeuvmoTBCROQPANrzDAO7Wyf2of3jrbf7DaQcgpWP2+
         90/N2JFkc/CMW+AJS+184bxNbK9I3p1SXDopemvaSFZgBS28ah1TwqYBbSsUHJj66V8f
         DjkyPURqn3aTYF/vfazJk7tl7dvpfMqWGArA77hqbNvWazGmmxa2tC9iBFexJh4SXLhy
         /TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687975131; x=1690567131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzqci8MIgjVyIUaoMuFMWhowYf714G+EhdihjPJLgC4=;
        b=ExszOr8GTntwcEqhumlHLamC77OQIVgX9lRlA4u/Bn2mHV3u4+4R1NcSZUK8pyeVrA
         Wmb27aqbTfyXW4Hee4vF+H1p4z7NwsEEmyCHh6UG97Z6fvZuNGvJt8RjYrVSnCfa2KuL
         wqv2dSwSN5rf6AqvvY3Tu1me0c428iDzO5LcSs7vbMDg20wXY1la8nVzW/aYIS5UeAIX
         WnLqF9e4nSApusW7PUXvPYsViIiuo8LZHhR2U4P2PyiU+L9RFkjxx0wwAFvBSZNCQyI+
         2GoBMsvcBZU3+YEts4Ixsx9KTbs60Qb3sq+21WUpc43IktOAWMW74rzKXUSMecYkNsOZ
         izcQ==
X-Gm-Message-State: AC+VfDzVd0nlbHeY6jgKw/5rRobA25aqWVS75KWk/8Xt/pdj6enccIJl
        l9RtayySLt7dxdUN6YhFMSs=
X-Google-Smtp-Source: ACHHUZ5A7zd60EGbwmpQzAHSXDA312GDpaOsaJNZTZmM1ms9rxWbixg2tyPndqWk6gtgquDwq6Px4A==
X-Received: by 2002:a05:6359:6a0:b0:130:f1e5:acc4 with SMTP id ei32-20020a05635906a000b00130f1e5acc4mr24345550rwb.15.1687975130876;
        Wed, 28 Jun 2023 10:58:50 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7961])
        by smtp.gmail.com with ESMTPSA id z28-20020a634c1c000000b0050be8e0b94csm7529454pga.90.2023.06.28.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:58:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 28 Jun 2023 07:58:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJx02OVPd4BJGmZk@slm.duckdns.org>
References: <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
 <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
 <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-meisennest-redlich-c09e79fde7f7@brauner>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Jun 28, 2023 at 09:26:07AM +0200, Christian Brauner wrote:
> > I think the root cause of this problem is that ->release() in kernfs
> > does not adhere to the common rule that ->release() is called only
> > when the file is going away and has no users left. Am I wrong?
> 
> So imho, ultimately this all comes down to rmdir() having special
> semantics in kernfs. On any regular filesystem an rmdir() on a directory

Yeap, rmdir needs to revoke all the existing open files for kernfs to allow
the subsystem to disappear afterwards.

> which is still referenced by a struct file doesn't trigger an
> f_op->release() operation. It's just that directory is unlinked and
> you get some sort of errno like ENOENT when you try to create new files
> in there or whatever. The actual f_op->release) however is triggered
> on last fput().
> 
> But in essence, kernfs treats an rmdir() operation as being equivalent
> to a final fput() such that it somehow magically kills all file
> references. And that's just wrong and not supported.

It is not supported in linux vfs but kernfs users need it, so it's a
semantic implemented in kernfs, which does add some complications but that's
the cost we pay for solving the problem of allowing device drivers or
whatever backing kernfs to go away when they want to.

I'm not sure what classifying a behavior requirement as wrong means. Do you
mean that we shouldn't allow device drives to be unloaded if someone forget
to close a sysfs file?

Thanks.

-- 
tejun
