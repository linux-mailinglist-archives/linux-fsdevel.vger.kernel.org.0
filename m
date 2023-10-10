Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613057BF3B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 09:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442408AbjJJHER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 03:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjJJHER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:04:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E2D99;
        Tue, 10 Oct 2023 00:04:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so1094395276.2;
        Tue, 10 Oct 2023 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696921455; x=1697526255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ALhOBkCqcossn/bCquFde8p2R9AjxMaSkLGBH7l2xU=;
        b=gTblv9TRnXR2KT8rbdIizoK69LjR/n4/lA6r7nA29P7QalzWvZmTtJNYIATXVLdO2B
         1entQ9vxaLGTQNv69vyfV5DM820q5h1ZnTw+1jJjm4kkw3/MU96i6qbh5ykIePYH1eYT
         UenFMej1chcBNLklW97OhNExNEP3BTHnUoO/owQhjOs+9N6YJS8BJzM6Yr2Sypwx9P3f
         aKks3EZ8Gh8wgd701vdwILRkbfi4x0IqV9WywA9tyhq+bkwkm169nR8JmOUYZLfFPsbE
         /wuN9yLp0/STkpjRRVJcDXu15T8LyJ8wiOVsqo+TjK9/sfa/hK8yiVU5whhop402y/bT
         vtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696921455; x=1697526255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ALhOBkCqcossn/bCquFde8p2R9AjxMaSkLGBH7l2xU=;
        b=eMKK5HocKw3j35NzHwv6Zpa/+KtXKqfnzwzH7jpagjxURGL+bjJGSkJfEGnF+lEDrO
         gw8xUs7WbQuQLWy5nQ0XJq07vZamey0gSHces+po7hG3MluqXY6kzzH6At8AfRxRY2GY
         N3PYldQDKqDRL5fFVMQELcJgQDybZetdVc6drDl2qMy4IiK9DEeWmqAP2zVe7MQGikuz
         6Gkr5OHIWr9i2UgBhq5nkmONE/9U8JrOAB+xRKc64r0TLbJDDt5pIkmiY/4cldeWqFUC
         /3iBWhlZQm+XL8UrtYEWYHlrqAiB5e0/gPjjFjwvtUWQQ5Qqz73l+VjRazz8Zh86147I
         G+YQ==
X-Gm-Message-State: AOJu0YwB8PCXjGhANkMDrO9PN8OOAb5LVPhlhx8uQvdZ9lET83k0hy4w
        dXG9rt3DepzRt00Pyy+mFKa07pi75gl+I8c7V7M=
X-Google-Smtp-Source: AGHT+IF7QcF2TlHLBoYOP9/mPyg+/HVFbAWVj+VYF7gXeM5zWwQqecjHClq93f4Cv1AUajZ3N1ZHRRlOQmXlvcVBWa4=
X-Received: by 2002:a05:6902:1507:b0:d81:917c:69b with SMTP id
 q7-20020a056902150700b00d81917c069bmr18771867ybu.10.1696921455072; Tue, 10
 Oct 2023 00:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032833.398033-1-robinlai@tencent.com> <ZSTLxuiJssT9aYb0@casper.infradead.org>
In-Reply-To: <ZSTLxuiJssT9aYb0@casper.infradead.org>
From:   lai bin <sclaibin@gmail.com>
Date:   Tue, 10 Oct 2023 15:04:04 +0800
Message-ID: <CAE82Ze2HSJcTp4aNzMne877L+kyCwG3WXTLMdSwJ+HqsfbnHSw@mail.gmail.com>
Subject: Re: [PATCH] sched/wait: introduce endmark in __wake_up_common
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes,  you are right. Now that bookmarks weren't actually useful any
more, removing  bookmarks  is a better way to address the livelocks.

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2023=E5=B9=B410=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C 11:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 10, 2023 at 11:28:33AM +0800, Bin Lai wrote:
> > Without this patch applied, it can cause the waker to fall into an
> > infinite loop in some cases. The commit 2554db916586 ("sched/wait: Brea=
k
> > up long wake list walk") introduces WQ_FLAG_BOOKMARK to break up long
> > wake list walk. When the number of walked entries reach 64, the waker
> > will record scan position and release the queue lock, which reduces
> > interrupts and rescheduling latency.
>
> Maybe we could try removing bookmarks instead?  There was a thread a
> while ago where we agreed they weren't actually useful any more.
>
> Patches to follow ...
