Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCC4FCF12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 07:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348314AbiDLFuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiDLFuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:50:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8EF28E23
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:48:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so22683324ljc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/Bwip0EbgIHLBZtJM96nXGyW0WOvATodmBqZPPM7cY=;
        b=QbvslhXIWcVihs2/1cCG1xx91Oc5mnEJqi86MopVrkAZNGNZAV9AgY1MXfnCYHJDG/
         m/oq0mrkRpKWu2ycwX9aa+9AJjShS/4Ez4O9Wv4Q/O8K91h7u937nLuWkcKGEHGkUc4h
         cYswC1OGPs3bbvwOqWxjKjF+4YQhZjsaSlPoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/Bwip0EbgIHLBZtJM96nXGyW0WOvATodmBqZPPM7cY=;
        b=FwAuo9lmvMKnVnlqNyFFy3eVV4bmiQ/eLmpp9d/rh8iPojzS3RdjYzkg+k8bHrDtW7
         PlTTsZFFx7OdtRebA5w51I3WhWiYPy0VBIwB3LuQC4xNIcsDumxWqi3gKQFUqyUxBgNw
         OSD95g3jv93mCcWlj6TZi8wfZKOVr+F9WJs7jZSkUrBnSxsGNVK+GV+hh3dcaYJytDRE
         cS3g/ghz/z9Hu1mF42GczWuX2eFe4R4BT0eN3sA1XgiGxTdLr6PwDB2tKazKx+Ey0Aq6
         SdDxOnmHy0RdNSeOyQ82BIzKGi/6iooV4Fcbo+OYXqXGiNR6ShmkfuhJGszmzaFBUeMm
         HrLQ==
X-Gm-Message-State: AOAM530HxBtQ1dsJI5JJ0rfRX4XpdOZjpAL0d/ncVAlhdGSnqoLnR8D5
        xoWTxiEvmRuEnyTW4fyO0ZpABDzaXlu7Cuf2
X-Google-Smtp-Source: ABdhPJwiDyu+8ZjUty1e1zNAlB2B4rm/4pj72c8TJBFN6CthY2MxE7/bpwFNR7I13juj998Ktq9/bg==
X-Received: by 2002:a2e:911:0:b0:24b:60c0:67a5 with SMTP id 17-20020a2e0911000000b0024b60c067a5mr6228465ljj.179.1649742481280;
        Mon, 11 Apr 2022 22:48:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n23-20020a056512311700b0046b926fd343sm964400lfb.142.2022.04.11.22.48.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 22:48:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c15so22703304ljr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 22:48:00 -0700 (PDT)
X-Received: by 2002:a2e:94c5:0:b0:24b:7029:75eb with SMTP id
 r5-20020a2e94c5000000b0024b702975ebmr1364165ljh.506.1649742480179; Mon, 11
 Apr 2022 22:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com> <YlUQ9fnc+4eP3AE5@infradead.org>
In-Reply-To: <YlUQ9fnc+4eP3AE5@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Apr 2022 19:47:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjOiBc3NiMRQJC6EsVosKOWmXiskqb0up6b5MOxCKSCBQ@mail.gmail.com>
Message-ID: <CAHk-=wjOiBc3NiMRQJC6EsVosKOWmXiskqb0up6b5MOxCKSCBQ@mail.gmail.com>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
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

On Mon, Apr 11, 2022 at 7:41 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> And that is easily fixed by using a lower major for the block dynamic
> dev_t.  In theory userspace should be able to copy with any major for
> it, but I fear something might break so we could make it configurable.

We actually have a ton of major numbers free, although it's not
obvious because of the whole "they are used by character devices, not
block devices" issue.

Ie 4-6, 12, 14, 19 are all free, afaik.

But yeah, somebody might have a static /dev for some odd embedded case, I guess.

That said, it really does look like we just return -EOVERFLOW much too
eagerly, for stupid and bad reasons.

Considering that BLOCK_EXT_MAJOR has been 259 since 2008, and this is
the first time anybody has hit this, I don't think there's much reason
to change that major number when the whole error case seems to have
been largely a mistake to begin with.

                  Linus
