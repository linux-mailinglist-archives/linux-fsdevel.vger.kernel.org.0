Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE37B4264
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjI3QxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 12:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjI3QxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:53:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D9CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 09:53:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so44774566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696092779; x=1696697579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q746Z1/4KkmfJytKGnhZ2GnWo6R2JLlvnS7OdRP9O1g=;
        b=PNqeM1ICZKL9KXeW26ci/x7nii/tF3rKStJYvnt/I7uGvMaSKsr4x5zlseMH57nTzg
         myYLmLm6PzUmlin/PcAMaqD6iuqRgDSKctvscxXtv9s6tAB5zIWHHrVsdSv9bhh9g7+r
         h21CPBls+O1lvaIJ5U2svE04ZclGE2FcaWBpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696092779; x=1696697579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q746Z1/4KkmfJytKGnhZ2GnWo6R2JLlvnS7OdRP9O1g=;
        b=RLOYHHSEo5mcPtzoYOK5z93kDUauuMJQ8yEj6Z3s1DptupUp6R9ogYDxDAFfbQH/qq
         T/LRnIDytVn11JPor+qgJIlVt3LIqQZbjQatn5FKX/4Z0tiZV0YnHXdXEtHCn2EjePTZ
         QxSQvksBTKci3o4Kuo2Chy4zTsGN29tEqtKHOc/FFDOLrooTNgSZf4C9MNoOwzuR9+r+
         Z4gfX2K7/ZDoc6QlRgx/9vF8kVf5+H/Xo4Tm+rZ/E6kC0RLsTkuYLrgiWrNijxVZnABG
         mRtsOWCWCC2ibfmV9CGiLemEufTrMusFaZOZv/93QllLIV/ZK7Tj/rRYormv29V7fs9+
         0QVQ==
X-Gm-Message-State: AOJu0YwWb8qQrQX2rcCxzgJuxzo4eSDPMVDc2P+te1rNEYQUy2XNm+rK
        Vs4vMT6m+MeB3gqzwD6r4RvuVR7Ri/BCiY+QJPpN7lvo
X-Google-Smtp-Source: AGHT+IHEzNs5lrhf5OgqpKaJ99qVx3XjFmHe1IMVq7ZQ0bYDRlO+gfeIxfxv5aognzIGvoZIAQyreQ==
X-Received: by 2002:a17:906:2090:b0:9b2:8df4:f2de with SMTP id 16-20020a170906209000b009b28df4f2demr6792822ejq.15.1696092779564;
        Sat, 30 Sep 2023 09:52:59 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090639d200b00982a352f078sm14044213eje.124.2023.09.30.09.52.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 09:52:58 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so19784339a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Sep 2023 09:52:58 -0700 (PDT)
X-Received: by 2002:a05:6402:385:b0:52f:2a38:1f3 with SMTP id
 o5-20020a056402038500b0052f2a3801f3mr5973565edv.2.1696092778396; Sat, 30 Sep
 2023 09:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
In-Reply-To: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Sep 2023 09:52:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHA1d1kGhnzfXw7BsLuR93CPizeFzN0sNJruWsqvqzTQ@mail.gmail.com>
Message-ID: <CAHk-=wjHA1d1kGhnzfXw7BsLuR93CPizeFzN0sNJruWsqvqzTQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc4
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
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

On Sat, 30 Sept 2023 at 08:31, Darrick J. Wong <djwong@kernel.org> wrote:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-4

No such tag - and not even a branch with a matching commit.

Forgot to push out?

                 Linus
