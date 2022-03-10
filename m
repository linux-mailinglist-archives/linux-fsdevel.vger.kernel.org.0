Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA84D524A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiCJShN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiCJShJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:37:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD519D62C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:36:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h14so10941887lfk.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpDrnPsAS8jhlqYsqpbk9Izj3698daXGmE+RS1//HxY=;
        b=UHy+dCOsa7FxiysvXGca8RRowRTsb+f9K8Y3q8uZRNidfKjZtYAUOhcwjei9ga9XcG
         +wtfxkazx1v2io2rfqD4ScGtNVv/JKMBAdplcBAzMMDJY/vbaSujZBBOR2CO/SDZU84T
         fnXVL4ZsOedT/Slbwc+d3/f0+tdUx2v0gDo5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpDrnPsAS8jhlqYsqpbk9Izj3698daXGmE+RS1//HxY=;
        b=nayADlJ7aKFL2Mc+9tTG0DdOQzKGtjfksa+0f6LujWi0F2TzDVKDpfkUXjPyLmSM5K
         t/+oTLnrWK3NAw4GEprS0jmnYfxR0UeglocDs5UiabQnPbotO4/heTArmOs/S68Hpc9t
         s3O6T4dr7WDK7WSfhbu+QBcAdBnuyZyIgUUdgVGBDWfWLCdM5lK6zFq1LmbUmUmM8TmE
         5RfUlM4qHuXGpcJNybkk4Fne6EFFjuoshyZOuhORvt0u1yUnqXnxLy/HVdoFZpaRIfOo
         2Cosf/gG5O4CU8+wQlkv8KFuY2YhO0ndN+S2/xCs+xGSnM7/0tNL7PniClV+pWbmQnMQ
         bTmw==
X-Gm-Message-State: AOAM5338IJJCfvFtBVXSWfXs70Av+2oeyIZq83f9xqI+1L4/ggwNEj6s
        5f0pqlqUpX9TCAqwlR2+UiyruRx+ZONrvDfjtlo=
X-Google-Smtp-Source: ABdhPJzzJxJNqTOQpUuW62sd9CBkyhtYkYfUGN3VnYparx9rZ0HI34ER5tJ1xoegMWy1GyYtcmQMyQ==
X-Received: by 2002:a05:6512:3242:b0:448:4a8f:6ae1 with SMTP id c2-20020a056512324200b004484a8f6ae1mr3581348lfr.665.1646937362182;
        Thu, 10 Mar 2022 10:36:02 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m27-20020a056512015b00b00445b827ccf0sm1115309lfo.236.2022.03.10.10.36.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 10:36:01 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id s25so10949838lfs.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:36:01 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr3725894lfb.687.1646937361137; Thu, 10
 Mar 2022 10:36:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com> <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
In-Reply-To: <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 10:35:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
Message-ID: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
>
> For the time being, the idea LGTM.

I'll take that as an acked-by, and I think I'll just commit it to my
real tree rather than delay this fix for the next merge window (only
to have it then be marked as stable and applied that wat).

I do agree that we should look at future changes in this area, ranging
from limiting the number of pages to the (I think already pending)
work for arm64 to use an instruction to probe every 128 bytes instead
of on a page basis.

It might even be reasonable to have some hybrid approach that walks
the page tables and faults things in - not quite GUP, not quite
'handle_mm_fault()'.

That said, this is hopefully always going to be the rare case. Yes,
people do IO on "cold" virtual memory, but people doing any
performance work hopefully know that locality (temporal and spatial)
matters not just for the regular CPU data caches, but for pretty much
everything.

                    Linus
