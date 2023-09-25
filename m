Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1477ADD69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjIYQur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:50:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5CBE
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:50:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5043120ffbcso10218264e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695660637; x=1696265437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FkfAX/RWqq7mVXYD/yvB+HIjbofX4XxbkSlj+NRMAVM=;
        b=HTHoiywt6JngFrE3y8v0EtgBcSxzgnrJHTWvNP2fMqrA6OTcLAGHDax0LgiRlsqyh4
         kWxN0TY6r5NEbXkParsW8qotzJtPXlIBiskcgsca1lyd2y5rmcmmyXnOgIQTd0sqnvg3
         Hp+VY7mIc23rjLKPss3I7GISFBOtj5Oe9CokA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660637; x=1696265437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkfAX/RWqq7mVXYD/yvB+HIjbofX4XxbkSlj+NRMAVM=;
        b=QU/fJCk32a+XGwRJE3zEt6mXGTC8kEAfbF7/cx8s76xw3Sre6JbRhXSSkbwKkNPDlr
         iEwaVsXgMOmGmzvdu+FxOVLysf38J6/TKk8A5dVsOZ6vRtAVXmr0r1kYeIo6UFxKfVl1
         pEvilYy8mbq+ajaD3eBk1QeM6+9AJ+XycyWx98d1TxKOJwLZ1QlquhR2KD+8RdSrNwQN
         bxQV26jP0IP359hzyOmbEy9x0S/h0i584E6BGVPb7ivssrOdfRR1nc1U7MgNcRPfoURf
         4DnyGcfli6Et98BLDnjPvtmacAt95wdbj1n4fGWAIXyF31lMvS3gFQ9ivyuuRkYrCjnn
         k5Yg==
X-Gm-Message-State: AOJu0YxBmwWeoE79JVhiXJgo68m/FKNSSseI4sx71ufIx62HVxFwk5HE
        iQFF9FDS4S07o4lRCWuPw/SqUdzBC50HFbxZzfarYHet
X-Google-Smtp-Source: AGHT+IHzQ5HsjE28pw8yqqBn7JiH7s2Mbdd5GOjZAgphzb5Yqpwt6K64QT9UKA18riioZaKD0P9fww==
X-Received: by 2002:a05:6512:318d:b0:4fd:f84f:83c1 with SMTP id i13-20020a056512318d00b004fdf84f83c1mr7142977lfe.64.1695660637574;
        Mon, 25 Sep 2023 09:50:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fb9c625b4asm1902383lfe.210.2023.09.25.09.50.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:50:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50309daf971so11101922e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:50:36 -0700 (PDT)
X-Received: by 2002:a05:6512:238f:b0:503:1992:4d63 with SMTP id
 c15-20020a056512238f00b0050319924d63mr7791737lfv.19.1695660636109; Mon, 25
 Sep 2023 09:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area> <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZRFVH3iJX8scrFvn@infradead.org>
In-Reply-To: <ZRFVH3iJX8scrFvn@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Sep 2023 09:50:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD6561fJPoNQXmT1nBcoJ=WQk=batM0BcNFdEJKFa8gA@mail.gmail.com>
Message-ID: <CAHk-=wgD6561fJPoNQXmT1nBcoJ=WQk=batM0BcNFdEJKFa8gA@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Sept 2023 at 02:38, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> >
> > Yes, don't enable them, and if you enable them, don't auto-mount them
> > on hot-pkug devices. Simple. People in this thread have already
> > pointed to the user-space support for it happening.
>
> Which honetly doesn't work, as the status will change per kernel
> version.  If we are serius about it we need proper in-kernel flagging.

That would be good, I agree.

The obvious place to do it would be in /proc/filesystems, which is
very under-utilized right now. But I assume we have tools that parse
it and adding fields to it would break.

The alternative might be to add "hints" to the mount options, and just
have the kernel then react to them.

IOW, the same way we have "mount read-only" - which is not just a
semantic flag - the kernel also obviously *requires* read-only mediums
to be mounted that way, we could have some kind of "mount a
non-trusted medium", and the kernel could say "this filesystem can not
do that" on a per-filesystem basis.

                 Linus
