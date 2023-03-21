Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107956C2A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 07:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCUGF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUGF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:05:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE929E0D;
        Mon, 20 Mar 2023 23:05:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16so10263120pjs.4;
        Mon, 20 Mar 2023 23:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679378727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+SP907X/SeUBhM/PRlD7SkiAzVdHeJVpNjB8FbspAg=;
        b=IWxX3ncjwV8aVOOeyMwIHGxyzIurlBvEVpEHWSM02rtq0lQRKKn6Fd0ceiP5HP5QCA
         6Iri1BCPFS/QW60zHMp0smnIhWfzS7+bHfhpox3t/xQ/Ry+TUDdXsXQJm7+Gm99wsnlR
         8HxBaXwRi13UHPqf9E7LGmbTbWUCRPhblJv35s8FU5cpbihDifZ+Ymp6S50yCTfU5BZM
         SvIIkz7y+rDP17894DoDKBX3sFK4C8QVU+tLPJedkVVW13+wCwAw3+16cqW3+9UgOQJd
         6jfnb2hXYTZTyuVAGDM/MSimYpDNanwaDgOkLEBXrz9GYDk/mtC0jeGqosLeSFjmD/MR
         4jDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679378727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+SP907X/SeUBhM/PRlD7SkiAzVdHeJVpNjB8FbspAg=;
        b=r1YfVHU84ak4moC0h6meDHCzQbk8Inb4KeFZpvk7FixHM2AsVKXEYIQJ3zYlwdqZ1V
         tQ0IHITS1mtesCyQ+LQKBmzhmTB0gq6wyGHQO3YIKO3Q6KSlhxQC7XYyrZWb2PpZezTq
         P30Ju3vdao+jOp36yh2Zc3p/HrUiDBp4/yv5E4rEKmyknp1TmMqNqMBuFaOp1vSIwR7H
         c+BjrfGDOSlH1Ce7aFwy5Oz+y9Fp01hA2o9QU+AV4hjJXdszrJXRhn1krATz1o4mqPd7
         51CLA/iZHZy6yIqrwDOOwYnti8LIxTOxdQR3R/MICxwxNVCCsthE10fQqXe3zh/TIWWh
         BtvA==
X-Gm-Message-State: AO0yUKXbJjYp/aDkOaFsx+8mKjVjM3+aE3VbMRhTb8opv3BqmpYeNW2n
        49Wqb9nuER4eGunTs/RUW5k=
X-Google-Smtp-Source: AK7set9ukTQm402ocqVk6fh4G3GBri9ryQ7FuCaGIfmYvRLaDVN3QObvZpwlqD55VtxXguDqxQSq2w==
X-Received: by 2002:a17:902:db12:b0:1a1:d949:a52d with SMTP id m18-20020a170902db1200b001a1d949a52dmr1370406plx.65.1679378726453;
        Mon, 20 Mar 2023 23:05:26 -0700 (PDT)
Received: from localhost ([2600:380:4a39:cac0:d7fa:8e4d:47d8:f561])
        by smtp.gmail.com with ESMTPSA id 13-20020a63134d000000b004fb171df68fsm7157609pgt.7.2023.03.20.23.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:05:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Mar 2023 20:05:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
Message-ID: <ZBlJJBR7dH4/kIWD@slm.duckdns.org>
References: <20230320210724.GB1434@sol.localdomain>
 <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

(cc'ing Lai.)

On Mon, Mar 20, 2023 at 03:31:13PM -0700, Linus Torvalds wrote:
> On Mon, Mar 20, 2023 at 2:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Nathan Huckleberry (1):
> >       fsverity: Remove WQ_UNBOUND from fsverity read workqueue
> 
> There's a *lot* of other WQ_UNBOUND users. If it performs that badly,
> maybe there is something wrong with the workqueue code.
>
> Should people be warned to not use WQ_UNBOUND - or is there something
> very special about fsverity?
> 
> Added Tejun to the cc. With one of the main documented reasons for
> WQ_UNBOUND being performance (both implicit "try to start execution of
> work items as soon as possible") and explicit ("CPU intensive
> workloads which can be better managed by the system scheduler"), maybe
> it's time to reconsider?
> 
> WQ_UNBOUND adds a fair amount of complexity and special cases to the
> workqueues, and this is now the second "let's remove it because it's
> hurting things in a big way".

Do you remember what the other case was? Was it also on heterogenous arm
setup?

There aren't many differences between unbound workqueues and percpu ones
that aren't concurrency managed. If there are significant performance
differences, it's unlikely to be directly from whatever workqueue is doing.

One obvious thing that comes to mind is that WQ_UNBOUND may be pushing tasks
across expensive cache boundaries (e.g. across cores that are living on
separate L3 complexes). This isn't a totally new problem and workqueue has
some topology awareness, by default, WQ_UNBOUND pools are segregated across
NUMA boundaries. This used to be fine but I think it's likely outmoded now.
given that non-trivial cache hierarchies on top of UMA or inside a node are
a thing these days.

Looking at f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from fsverity read
workqueue"), I feel a bit uneasy. This would be fine on a setup which does
moderate amount of IOs on CPUs with quick enough accelration mechanisms, but
that's not the whole world. Use cases that generate extreme amount of IOs do
depend on the ability to fan out IO related work items across multiple CPUs
especially if the IOs coincide with network activities. So, my intuition is
that the commit is fixing a subset of use cases while likely regressing
others.

If the cache theory is correct, the right thing to do would be making
workqueue init code a bit smarter so that it segements unbound pools on LLC
boundaries rather than NUMA, which would make more sense on recent AMD chips
too. Nathan, can you run `hwloc-ls` on the affected setup (or `lstopo
out.pdf`) and attach the output?

As for the overhead of supporting WQ_UNBOUND, it does add non-trivial amount
of complexity but of the boring kind. It's all managerial stuff which isn't
too difficult to understand and relatively easy to understand and fix when
something goes wrong, so it isn't expensive in terms of supportability and
it does address classes of significant use cases, so I think we should just
fix it.

Thanks.

-- 
tejun
