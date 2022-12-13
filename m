Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546A64AE2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiLMD3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiLMD3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:29:19 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B571B9C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g7so10882559qts.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zp0U9Kl4wDERv8LP4SRbd+OyzbRFeaPhMPOi3/LSHe4=;
        b=VrN+0XdiySagFbzfZT3HDYXIZ9s7TWs9LITr1N9EkXfEoqvxLaPWUJn0CCF0lzpS2q
         mn6sM/KMo0sAcPdY48YkP/E8319NigCboqyj9OXDaOzw+vBHk9hMdOxiptzyzMQuGQO5
         b4Un4hq68aqroz/YhO57TR4fQjc/VNj8lkZm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp0U9Kl4wDERv8LP4SRbd+OyzbRFeaPhMPOi3/LSHe4=;
        b=uUjFLTXYaXvH2A/2EGNslepjpfzSuWtpoHJPnuh1HoPAm4z4+DWDKoxwh5fHsn84Um
         +uMrRTJsFX7zRc8/U6taL3TvK7HsspAGkhS+K3ouxWiFJqo6hXBVAiXTbXqOTHAAbVa0
         OdkLqPTPp2q3k0uZ/nUhHYbvNPgJB2wVy8cW0EPKvc45UKeNVKHr43xuBKTy+ji/9oww
         3SXnHIAJDNvP4q0a7D1ykmcmWvAEG8XEts4bQdLnXa8H+m/pIFxaFLW2H+KoD3j0obUw
         KEM0dGbkGG9i56pRXuDC7OVT3XgGNfQSl3aMZtZzeSmaxgvwsg1YLMQHhG77Emjc2oIc
         b1CQ==
X-Gm-Message-State: ANoB5pn3JYp9MFdtHgOHvRJ5be7JoGidtuCQg0s5ogHBv1M3bcL5Fy+R
        of1k76cixZvGufgDZPS6Rb/7Ue8BwHARWoHy
X-Google-Smtp-Source: AA0mqf4tng8q6hjKcGavuYlPPKmvcGQBq6af2thY38uA+1OeatyWLy6tNNi3DsvKVZKSWrRNedPOHw==
X-Received: by 2002:ac8:7616:0:b0:3a7:ea57:bf0e with SMTP id t22-20020ac87616000000b003a7ea57bf0emr26594949qtq.25.1670902156811;
        Mon, 12 Dec 2022 19:29:16 -0800 (PST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id w26-20020ac86b1a000000b003995f6513b9sm6684318qts.95.2022.12.12.19.29.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:29:16 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id j26so5999885qki.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:15 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10633201qkg.594.1670902155636; Mon, 12
 Dec 2022 19:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20221212123348.169903-1-brauner@kernel.org>
In-Reply-To: <20221212123348.169903-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 19:28:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Message-ID: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Subject: Re: [GIT PULL] vfsuid updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 4:34 AM Christian Brauner <brauner@kernel.org> wrote:
>
> This pull request converts all remaining places that still make use of non-type
> safe idmapping helpers to rely on the new type safe vfs{g,u}id based helpers.
> Afterwards it removes all the old non-type safe helpers.

So I've pulled this, but I'm not entirely happy about some of those
crazy helpers.

In particular, the whole "ordering" helpers are really not something
that should be used in general, I feel. I'm talking about
vfsuid_gt_kuid() and friends - it's an entirely insane operation and
makes no sense at all.

Yes, yes, I understand why they exist (those crazy IMA rules), but I
feel that those functions *really* shouldn't be exposed to anybody
else.

IOW, making those insane functions available in <linux/idmapping.h>
really seems wrong to me. They are crazy special cases, and I think
they should exist purely in that crazy ima_security file.

Again - I've pulled this, but I'm hoping to see a future commit that
limits that craziness to the only user, in the hope that this disease
will never spread.

                Linus
