Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247367FD60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjA2Hdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 02:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjA2Hda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:33:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AD1C333
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 23:33:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p26so12650745ejx.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 23:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Khnf0tXeS7m38nFYQvDT/lNBrPynSjLK/zhidtRBTI=;
        b=Lf/xVkaeaMDwt7Zm+kxcMtYJVmn29ApHwgVM7VnG6guuj4kpruR287Bc9XQHGCRT4s
         bSU786g1S6qyfZRavQmyLBTKUa8OdxXm4koUdbrEMw/rQMYvviXC8ELK1exIHa7ANu7A
         N/rwegXubp8BVXJaLR2uYkFrSB2/WQ1TWObp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Khnf0tXeS7m38nFYQvDT/lNBrPynSjLK/zhidtRBTI=;
        b=2rNo4o/tKaijvnm+y6ZGVIVZNm5yTnfxjIXZiQ54IW3RA9mR79wOJYmQqLDlcApU0J
         pug1nsEXj/9L0TjUYuD//aavU86O37Fffif3/CtjTosnpz5YqjH/+FhiH1HzqzOoX0wG
         YLeuKxGsBlnvXW74L3vywn0CdWRFbRsGyY/Ze+lN4Pr1lemxgS3SPxO7jDWxiTqQUY7V
         iimmYyQDGQ5bgtSJ74bLfh95wIdVgrz6Pp8K1tk2z0TAhZkWrIAuflSVZPHFH2EK+Vcd
         XHk4dBk9tDKMx4LK0sJHkQUQYcSxjkiGtnrTQwhfQIleInZMoDHO1L7Jzu+pus+96Lx8
         e1Qw==
X-Gm-Message-State: AO0yUKXxvQLLQD9lXRKoXpX4qHHus/Kfa5fYD1zechbcruRsrcPHalq3
        iiPStU1YIEKWBtaGxJk6kO4s3HnHrKb1FYdUuW4=
X-Google-Smtp-Source: AK7set9pJEkjbXDH46DHYRFJRWNgdwRTET/rBsWJqGMw8lY5fJYRKQm9r5jRTm0FPfDtuLt5iDZEpg==
X-Received: by 2002:a17:907:8a24:b0:881:23a:aba5 with SMTP id sc36-20020a1709078a2400b00881023aaba5mr6903554ejc.11.1674977606389;
        Sat, 28 Jan 2023 23:33:26 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b0087fa83790d8sm2636022ejs.13.2023.01.28.23.33.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 23:33:25 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id me3so23868875ejb.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 23:33:25 -0800 (PST)
X-Received: by 2002:a17:906:add6:b0:878:51a6:ff35 with SMTP id
 lb22-20020a170906add600b0087851a6ff35mr3051378ejb.43.1674977604915; Sat, 28
 Jan 2023 23:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
In-Reply-To: <20230129060452.7380-1-zhanghongchen@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Jan 2023 23:33:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
Message-ID: <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 28, 2023 at 10:05 PM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> Use spinlock in pipe_{read,write} cost too much time,IMO
> pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> On the other hand, we can use __pipe_{lock,unlock} to protect
> the pipe->{head,tail} in pipe_resize_ring and
> post_one_notification.

No, we really can't.

post_one_notification() is called under the RCU lock held, *and* with
a spinlock held.

It simply cannot do a sleeping lock like __pipe_lock().

So that patch is simply fundamentally buggy, I'm afraid.

                Linus
