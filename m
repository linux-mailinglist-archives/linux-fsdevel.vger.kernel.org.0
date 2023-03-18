Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E526BF8FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCRId6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRId5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:33:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505A7B3BD;
        Sat, 18 Mar 2023 01:33:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so6330204wmi.4;
        Sat, 18 Mar 2023 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9sHt3Rf2cL+jGqcxr1xZgHTjHxy/0axlw587VfFCGU=;
        b=Oxbk+qbijSRgbsf4+g1B7UlphopCGL9JBY9sDifpEa/AujSjF9Jym8YSdzErz4V7f1
         gjo7qtaWoHqCu3fZVUWgLzP3aiXdXIHFJQoTru0PJj2njzYF6obI24Vnb3LX8qh32ngN
         eMnTa9ScUv9Zy0lBcfUBMdonW43muUBCSX8Ih4k8A9Hor+TyxPeXiyWZJTA2fAjTtfu7
         RNkPQKZrKDn35Cl1DktSmkM0CU4sIeRVXmovJrQxGYY7xHroqyG8WCa+TmskjOoTA/Dw
         zhp2u2WkV8KusoLKpCzqczbsQwB67CgmTE5Dwde916xxMh8V6uvbTV2ZpK5pBPg77UXa
         uy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9sHt3Rf2cL+jGqcxr1xZgHTjHxy/0axlw587VfFCGU=;
        b=GXYILhvJmLzHnsMX4Vpa53w5m4gw7f3t8qJH0AnzuMaRljL1D2Ld3hfDrjsCdWIw47
         FDN2LLhYYyVW59aq2+8YgofOg7XLyV0jLMK+LBW0qYDc5JZ3UEJaxDm5ORxZSTEIZ/Id
         K9aShhEmxCJr1vu0SU7GsiiU55lp0ocZnuWpGhn6MR8q5iVzja1okfQQBbWgDaHPwJF7
         cwXIhhLideA5sM5ormFqBtNvgY7HqXlE0OjSugcfCD5EG6jvx13CxapvaCeNxRqs/Z4q
         jEM5YwyEcw2qUrDSqcUP2mP+1oBfpjVk1+Gc6LtXEzUC8E8Rd30hA5APBZmJ54QzAKYA
         n+Ew==
X-Gm-Message-State: AO0yUKWnnFQNhcq37XhYKAVJ0fkcXMt/VIgvlQdRd7idaHpIRCXif4bD
        0UkOWIDTxqAChQe55O7y0qs=
X-Google-Smtp-Source: AK7set/XyqdLG67/Zy5aKz1TmxyiEeJC+xjLisH5ijGHWHZ2jctx9KBNchNoBHUBN5lkHY3q6/jNBg==
X-Received: by 2002:a05:600c:3846:b0:3ea:f883:4ce with SMTP id s6-20020a05600c384600b003eaf88304cemr25803660wmr.20.1679128433612;
        Sat, 18 Mar 2023 01:33:53 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id z24-20020a7bc7d8000000b003dec22de1b1sm4463821wmk.10.2023.03.18.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:33:53 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 18 Mar 2023 09:33:49 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZBV3beyxYhKv/kMp@krava>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBNTMZjEoETU9d8N@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:34:41PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds build id object pointer to struct file object.
> > 
> > We have several use cases for build id to be used in BPF programs
> > [2][3].
> 
> Yes, you have use cases, but you never answered the question I asked:
> 
> Is this going to be enabled by every distro kernel, or is it for special
> use-cases where only people doing a very specialised thing who are
> willing to build their own kernels will use it?

I hope so, but I guess only time tell.. given the response by Ian and Andrii
there are 3 big users already

> 
> Saying "hubble/tetragon" doesn't answer that question.  Maybe it does
> to you, but I have no idea what that software is.
> 
> Put it another way: how does this make *MY* life better?  Literally me.
> How will it affect my life?

sorry, I'm  not sure how to answer this.. there're possible users of the
feature and the price seems to be reasonable to me, but of course I understand
file/inode objects are tricky to mess with

jirka
