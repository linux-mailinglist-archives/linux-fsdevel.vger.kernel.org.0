Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63615BAF6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIPOdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIPOc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:32:59 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E7741D12
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 07:32:57 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 129so22888472vsi.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GOoFJtWRlokIqg4gxluGsowIyazAfY+Och7COPUtRRg=;
        b=jEeilPuvyOOSKCEn44KyXtqmed9zEp2OkknZHyCf6DFckGxsbmn3rfVR17d/79OIhO
         qNWoGHil+GyUY5MmYo4K1gVpDZuXvEfgp3pNEgSj9Q5xVh+Sx2ll+Z758wBrIRTBsn2a
         UdtBt7Dzjnq6rsP6PbdKDqQbvp+xhI+3ARsgA8yEIIbrAyZXzyAuz/hIYT3tnfSHiQMg
         YwJGePtNQP1h+A7UOm8dfI0u4fCLAoc+SIvlXlvPC0fi/RzvFoztTlwlvaJThz7ZZFm4
         pActjwTuYlNoUls5HkMx/Ho4dHpov0t4j5fyf3MzywH/8rHcBVaROY40GHm0DIctPVKn
         +1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GOoFJtWRlokIqg4gxluGsowIyazAfY+Och7COPUtRRg=;
        b=KyN7pEKRWyIwik5lFIhdjqUMR/87aTPKcQcv9EI55p3MqjlJg8wrwtb8YIYm2/3ihe
         75+CGl9TOVieam8VscGrjQG0Ene86RCUllxUydXZUQRd4v2sXToLX3oaW7hlPvftRpf+
         uz7nryw8Zpb53go4xds2N+M+L+uxQm4zKBBF3BVyEroxxMy1tMvJbCffm1Rpqy6eNXZe
         WmvAHmXQ6w7SF3Fv3By3lYmqygv1ejWMDvBGGeECIxrh2HWdv+stUDl0N89UWXLyszhU
         08aQ25BLFyKuwx0Y3NuOvtyX8InqtHIt2rkOaB/AXkYGhqoQ1TLpv5Std5rSYs/fDAIR
         u3CQ==
X-Gm-Message-State: ACrzQf1tKgy88gH48gykfCcymzClUOVVXNeiNusuwh7o2gvanN1M5CsH
        TKokWFQBEC2e1LVO2TmJpBhL9mbGtiovZK6BCmw=
X-Google-Smtp-Source: AMsMyM6xUQilKL19V/5jgRbUT+YkRytj9xTN8QDJdXHM1MsSBAmhnwuJBAXVPqMYk7SUggAZ/ylW93p99yEuaBPjksU=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr2189026vsh.3.1663338776864; Fri, 16 Sep
 2022 07:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220221082002.508392-1-mszeredi@redhat.com> <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV> <166311315747.20483.5039023553379547679@noble.neil.brown.name>
 <YyEcqxthoso9SGI2@ZenIV> <166330881189.15759.13499931397891560275@noble.neil.brown.name>
In-Reply-To: <166330881189.15759.13499931397891560275@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Sep 2022 17:32:45 +0300
Message-ID: <CAOQ4uxgS5T=C6E=MeVXg0-kK7cdkXqbVCwnhmStb13yr4y0gxA@mail.gmail.com>
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename race.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 9:26 AM NeilBrown <neilb@suse.de> wrote:
>
>
> rename(2) is documented as
>
>        If newpath already exists, it will be atomically replaced, so
>        that there is no point at which another process attempting to
>        access newpath will find it missing.
>
> However link(2) from a given path can race with rename renaming to that
> path so that link gets -ENOENT because the path has already been unlinked
> by rename, and creating a link to an unlinked file is not permitted.
>

I have to ask. Is this a real problem or just a matter of respecting
the laws of this man page?

If we manage to return EBUSY in that case to link(2)
will everyone be happy and we can avoid trying to make link(2)
atomic w.r.t. rename(2)?

Thanks,
Amir.
