Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B64DE185
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 19:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiCRS7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiCRS7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:59:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE8BD895
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:58:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a25so2122647lfm.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDmW+p2ypjT1HjKWJx8fh+7ifv3HKZNMXtvuE6nm2qs=;
        b=XHm5zI8ZBbpkWBIg6jHxN78K61Pegw6nnLu5ZR3iY8VEia03dmDXc3bRlF28jroE23
         doUqgjtYjvMH/budaSJuXxwTsP9wm1X3caE0hvtLwEj1Yzt9y1nJKLAZWQpSC1IyN0hj
         mypuoFL+N7hevvkbbmj5/rf2VzcZF7ajqMqyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDmW+p2ypjT1HjKWJx8fh+7ifv3HKZNMXtvuE6nm2qs=;
        b=jZH5fxySXWcQ2Vvnk3H/UA4/LQkkhqS0m1wdf/k5+H5RT+jsnCkI117EuYgQAL4o5y
         1YHJ/e3fhklwOJSCmzyI8u++P9NeR+yAWiyRMKYj5AwdmYaIaMgZnrUeahfyMFJm42c1
         SGyc2Z15vLDJbK8b1H0vr7Guuyn0V9sUcMfyHQ81GdBe6dES7fsNa8Zg8QIPIoEY4V0M
         12drKHqbJUCv4r/fOPQqa+7KHxronUC2S8L4eJGA3CGHkhVOUQ3x/41hpl3UM3ioZs1M
         xB54wUCjl6wHEchAUZo4u0PvsDgScPBIMwynVZAw7rK1lufK1rB4hiG+eMET6jIUb7n1
         yJOA==
X-Gm-Message-State: AOAM533sYRCjqoK32W0sEtxwbZSxTIHIgeBpaX8esxNOIYeKU4+fjYDV
        GW/ovnK2BkNMCGwzQXmqPJWGcKQhLq9m018RYHE=
X-Google-Smtp-Source: ABdhPJxVlV3U0yvfruor7bAKenwxXtQAED3GqH68ajXkV40/JrAnXaLbL/H+xGpyQQjZ5stIHtIZww==
X-Received: by 2002:a05:6512:3984:b0:447:6097:fb8f with SMTP id j4-20020a056512398400b004476097fb8fmr6814925lfu.166.1647629911984;
        Fri, 18 Mar 2022 11:58:31 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y31-20020a0565123f1f00b004487c89c46dsm966396lfa.66.2022.03.18.11.58.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:58:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r22so12454291ljd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 11:58:31 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr6973185ljf.164.1647629910974; Fri, 18
 Mar 2022 11:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
In-Reply-To: <YjSbHp6B9a1G3tuQ@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:58:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
Message-ID: <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 7:45 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Excellent!  I'm going to propose these two patches for -rc1 (I don't
> think we want to be playing with this after -rc8)

Ack. I think your commit message may be a bit too optimistic (who
knows if other loads can trigger the over-long page locking wait-queue
latencies), but since I don't see any other ways to really check this
than just trying it, let's do it.

                 Linus
