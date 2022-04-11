Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC04FC268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiDKQd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348622AbiDKQdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:33:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F33134F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so22502877lfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTF2lMXV9wxXsFaw1Yi/+Bse2dwqUs9rz7Y6bCytCHk=;
        b=eiXuxRx5rFIGmeq+qfzK/Xn1pQaet+b/9Zs+2H9POBlnw0ck60/0qGYLtHx/djEgly
         pZzBAjknNQpN4cx4F9pMy5jT60GShUDw43qPsexrJUZtJDq0wVRIv5FNa6cgd3CdMmNY
         bzWBDUh6ZkBVhtjpQd3F8gLgssTUHnNEZ7JXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTF2lMXV9wxXsFaw1Yi/+Bse2dwqUs9rz7Y6bCytCHk=;
        b=XqyNcfkXaS/9hTqZjtV9CetUrb3k91EuuC+EuPJYu6ty3uy29+hyOV9qBMh60LNTUe
         +7n3qsQetRkPMFg60qS2bwD6/ABCRmwnZx3mmDuGpVky53XbaN7hVE1sppGn0gpmxSKt
         MPazGn0VJnXMLl+EJlaamQr/qh9bjw+FKCBzW2Om81Tl7lau7L1ut/uGhFUTzLdpVWfs
         f1j90zetFuWXXGz3oGoZR9ZkwKUD4W2I2zsF1++ElWmpoXrpNL6ZKmdt7XIncDcPKztb
         53k41+fKo5EfA+W2mXTYZdBpeNNcy1jXr180jEKiXpzvB0KbLNDtUtaNfw37Lv+w56vC
         1UCg==
X-Gm-Message-State: AOAM532wqmts3PB18mMgkOrOU9WU9skM2QrrRrAyI68k7WkH5yBcY5Jb
        Afgoc2IYFqDz0U9ibZAwlIaB9f88Ia0iMip+
X-Google-Smtp-Source: ABdhPJy1XN2nWOjk0oCJfD73zigTM4vBZt47EHhlS/jtcovn+Yb+mVUqeS8zGUspL5OdwgdsKxHjpQ==
X-Received: by 2002:a05:6512:2142:b0:46b:b223:16d7 with SMTP id s2-20020a056512214200b0046bb22316d7mr1301392lfr.415.1649694665072;
        Mon, 11 Apr 2022 09:31:05 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l11-20020a2e834b000000b00246308690e2sm3180100ljh.85.2022.04.11.09.31.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:31:04 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z17so3123741lfj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 09:31:03 -0700 (PDT)
X-Received: by 2002:a05:6512:2291:b0:46b:b72b:c947 with SMTP id
 f17-20020a056512229100b0046bb72bc947mr98236lfu.531.1649694663647; Mon, 11 Apr
 2022 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 06:30:46 -1000
X-Gmail-Original-Message-ID: <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
Message-ID: <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 4:43 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> If you run a program compiled with OpenWatcom for Linux on a filesystem on
> NVMe, all "stat" syscalls fail with -EOVERFLOW. The reason is that the
> NVMe driver allocates a device with the major number 259 and it doesn't
> pass the "old_valid_dev" test.

OpenWatcom? Really?

> This patch removes the tests - it's better to wrap around than to return
> an error. (note that cp_old_stat also doesn't report an error and wraps
> the number around)

Hmm. We've used majors over 256 for a long time, but some of them are
admittedly very rare (SCSI OSD?)

Unfortunate. And in this case 259 aliases to 3, which is the old
HD/IDE0 major number. That's not great - there would be other numbers
that didn't have that problem (ie 4-6 are all currently only character
device majors, I think).

Anyway, I think that check is just bogus. The cp_new_stat() thing uses
'struct stat' and it has

        unsigned long   st_dev;         /* Device.  */
        unsigned long   st_rdev;        /* Device number, if device.  */

so there's no reason to limit things to the old 8-bit behavior.

Yes, it does that

  #define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
  #define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)

  static __always_inline u16 old_encode_dev(dev_t dev)
  {
        return (MAJOR(dev) << 8) | MINOR(dev);
  }

which currently drops bits, but we should just *fix* that. We can put
the high bits in the upper bits, not limit it to 16 bits when we have
more space than that.

Even the *really* old 'struct old_stat' doesn't really have a 16-bit
st_dev/rdev.

           Linus
