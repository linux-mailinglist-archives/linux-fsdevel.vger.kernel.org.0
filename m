Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD74FA973
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 18:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiDIQPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Apr 2022 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiDIQPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:15:08 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A63A6
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Apr 2022 09:13:00 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id p8so9846892qvv.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Apr 2022 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZY4VkjSviGBqUtQ915TWrSdiPXMVE1Mr2PV3/3xCmVk=;
        b=bqOMGSQbkcnxoLHiW0amrXvSw6r5DSG39kO+p8PRtDCK3lKDehOHSAnq08gykjl61p
         9eATpM+TO9DEo2baHF2AygN3hxNqnS/yJN64txNhFkWMt1eTh0v9VImOFO9fmh3Z+4ZH
         mDN8Jnvrm4FU0fg/zAek0yI0zMYKR1aUVML9Sd+QjOMRtmNvGBxIAhSefNHzl0HjPAmR
         OHfv1rt+FDTVdYa52fT9JN0LBGoB4XAz+3mvR+/eJpXb+02vDjlKlCgqgMyS2j5o0/rN
         XMotmDZ7pHxenYs22xkdCWgGFsqFe2CAu+kj9u/iMMMyaIOVNXLOE7lEdzYlSfSeNjAX
         BALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZY4VkjSviGBqUtQ915TWrSdiPXMVE1Mr2PV3/3xCmVk=;
        b=eqeoSPRcQ14lZ8VCRu7mWVdBD3qRdlb011ez2/w44Tys5htM8xsEII3ikAyBdHLWsj
         48BJZvBAuR5DQNT/PPZZCGBrJeU139AK5zSAAw6zJhXlWh32s8Hz7XBnok180JVDE4Uz
         sbviq5hLZjFRevICya5Rh05U3DSNVRVMU6lHCFAcg4LRTu+3fmHKV6vjLUS+eySrIux9
         FxHDAVhjRAaquWMzS7eP2WZe3M+1pt+aGktdRq/6NK+4yP07lCokLG2y2msHuGYEmlQi
         lmIwiceYzdlQt62STGvuqvoPc2OqCMYrfbKpUc0zaC1VckV9qEu3m09rD1+ad277q5Iy
         JMew==
X-Gm-Message-State: AOAM533ILGqIT39/nYufpiplaFyaAssnl1LkoY/cK8I9j0DXTDGZQfs/
        KGv3tHUCcQlEezOpetR7GgVsrUUkfFq7ZRyAUjmm6nMtSV8=
X-Google-Smtp-Source: ABdhPJwaYH0IvzeVbqR8B9yN4r0iXevhlommq5qUsUXrb8yRkVNxYS7B8UZzR/gvlgKnf13nSDD2FO0ninRizd74rtw=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr20311896qvd.0.1649520778968; Sat, 09 Apr
 2022 09:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com>
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 9 Apr 2022 19:12:47 +0300
Message-ID: <CAOQ4uxiT0Og3nsGSwKZZApCTPSwm+uRaYGA-j3Grq6xz6UFWmw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Evictable fanotify marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Jan,
>
> Following the discussion on direct reclaim of fsnotify marks [2],
> this patch set includes your suggested fixes to core code along with
> implementation of fanotify evictable marks (rebrand of volatile marks).
>
> The LTP test I wrote [3] reproduces that deadlock within seconds on my
> small test VM if the FSNOTIFY_GROUP_NOFS flag is removed from fanotify.
>
> To be more exact, depending on the value of vfs_cache_pressure set by
> the test, either a deadlock or lockdep warning (or both) are reproduced.
> I chose a high value of 500, which usually reproduces only the lockdep
> warning, but worked better and faster on several systems I tested on.
>
> Thanks,
> Amir.
>
> Changes since v1 [1]:
> - Fixes for direct reclaim deadlock
> - Add ioctl for direct reclaim test
> - Rebrand as FAN_MARK_EVICTABLE
> - Remove FAN_MARK_CREATE and allow clearing FAN_MARK_EVICTABLE
> - Replace connector proxy_iref with HAS_IREF flag
> - Take iref in fsnotify_reclac_mark() rather than on add mark to list
> - Remove fsnotify_add_mark() allow_dups/flags argument
> - Remove pr_debug() prints
>
> [1] https://lore.kernel.org/r/20220307155741.1352405-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
> [3] https://github.com/amir73il/ltp/commits/fan_evictable

And here is a first man-page draft:

https://github.com/amir73il/man-pages/commits/fan_evictable

Thanks,
Amir.
