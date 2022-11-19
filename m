Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02166308DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKSBxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiKSBxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:53:03 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9B7A364
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:38:42 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id j6so4509603qvn.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6PysuEoX+Eh/Sw/Kn1LajWAkbhS+3PmJgg/eTiCHmY=;
        b=bE1HOEOkCaIWihWXjI63+6WzgnoKhSU+hV4usA1MUxdL8HT73RmC7nYl+BGYMW/HHC
         ZZUgQgH4lV32dUhWOLzml4B/fLW5mvpT0yIQa2BlGkwDyJB1I73ILOMbGwoxDYpTgzTI
         pc4S8HTT0iv4icPjC0yGNMvfO8IxJY2QhrEjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6PysuEoX+Eh/Sw/Kn1LajWAkbhS+3PmJgg/eTiCHmY=;
        b=dCVHXCgVOblbtf7NSRqY+wFO6764NyaB1JN3wWCTXA1ZMQ6mUWU4UA/G0qgLAJ7Jvv
         n61IN5ig8AZ5J4SY9p9daOX+2rqP6bL4mWcdeAucROeatdhErEFz8TXxefqL8ZcuY+vF
         Ryq+7Vj7ftsW4IlGN2wFY6huPyxpswlPW765rWtlc2/mmHroSiEtDZhr5QQttFEOEBeo
         Lhx7soS8ziTB1EVVuWyrVEYsJVgV+WDWv17aUD0WjuS8mCDu+16SniDO7JZBQZNa7Ztw
         JzpFvmG2+lzAuDXzK+sPbr9eZpAVVmp0m4hP+51yrjsXCDslisPjH3zBpEHjuisR0rOh
         +BFw==
X-Gm-Message-State: ANoB5pkW/nVrB0aC2MstyVD5sOaxgseDQT82DlJ3zN0RLYIuPgpCf+83
        YSKFNvm1qGfc3irf+wdgocTOdLKhdfF+gw==
X-Google-Smtp-Source: AA0mqf78hmD2POkwxJzaoGDbVMT2SmDH3D5oGEqFJt4tHWJnVj3LB1XyYMYMbQ/YSXFV70cOVOO+6Q==
X-Received: by 2002:a0c:ec88:0:b0:4b1:9054:b54a with SMTP id u8-20020a0cec88000000b004b19054b54amr9051349qvo.122.1668821921408;
        Fri, 18 Nov 2022 17:38:41 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a25d200b006e16dcf99c8sm3512625qko.71.2022.11.18.17.38.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 17:38:40 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id z1so4671377qkl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:38:40 -0800 (PST)
X-Received: by 2002:a05:620a:1fa:b0:6ee:24d5:b8fc with SMTP id
 x26-20020a05620a01fa00b006ee24d5b8fcmr8271235qkn.336.1668821920437; Fri, 18
 Nov 2022 17:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Nov 2022 17:38:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUq50yc7MavtZXcFiv9VxW9YyJDMB2ht1sHnDBieVB5w@mail.gmail.com>
Message-ID: <CAHk-=wiUq50yc7MavtZXcFiv9VxW9YyJDMB2ht1sHnDBieVB5w@mail.gmail.com>
Subject: Re: [GIT PULL] zonefs fixes for 6.1-rc6
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org
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

On Fri, Nov 18, 2022 at 5:09 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> zonefs fixes for 6.1-rc6

Hmm. I'm not sure why this one didn't get flagged by pr-tracker-bot.

It does seem like it never made it to lore (your pull request also
doesn't seem to show up in the web interface), which is probably
related.

Maybe it's just some random delay and you'll get the automated
response in a few hours, but here's the manual one...

              Linus
