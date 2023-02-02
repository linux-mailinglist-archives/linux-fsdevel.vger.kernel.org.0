Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE926882BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjBBPgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 10:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjBBPfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A95F234D4;
        Thu,  2 Feb 2023 07:35:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so1700284wmr.4;
        Thu, 02 Feb 2023 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trv1AGGi2ZldMb5ssniYbBdtJBugUHujIqtgNiIg+Vs=;
        b=c5Y63VtVWSajudI2t9sYCFJ5AT1CYvsF4csR+nQSPnF7R1hilM1CflU+yEw7hzHGfF
         zC7c9KRF8Pwl6wbWvUsYRfmMrxm7Qb3DCyPAd/wMtnPYPmj0d8uf+zNsANt4KVhXSSZB
         uDOmcIVC4rV/VF5glzM7bCdWCZ/LzSSa6SP+GylGOsnJW2VvaH2nFkeJtcA3IlztSaM1
         C2ZlzMCnCIjE8S1y2apGpv9Gcnkxt6OLU98GQt2B6g86l8H2v/wT8tuZvqZeklbqGkOc
         ahFu6jjeB+lqaMbkAUbEzXvuREDRnXl/xBLWubfPFJZFM2+V5iOCW2BUgVs9iBPt/3e0
         Pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trv1AGGi2ZldMb5ssniYbBdtJBugUHujIqtgNiIg+Vs=;
        b=Ikp3o5qH5MhPywB6XKS4wIdT6v4+z0s+2D7lBWeTVG7UGjHHFzf3iJI2SNXO9JxP/6
         hnHLXb3iSZPWkoOhYvTeVuJJ88SaHoewjJHRN/XpbRkH+M/bQduEE1wNRuea+1KCq5e8
         aTCumQorCQrA9AYJDdXzuIBtZC9c++kPbvFLFIozQIzoXog3BAqK4Nkwy4k198+RqVHd
         NfXWRI5OwGk9okMiUzJ+XWBsO4nBfs9l3xst352ijDaqt7ifCnHK4JRjvWR4WylEEuqG
         zKCwrrh6D8TvsmJzU9CQEhttBsWCJ/IRM1esgRxqTG9SbnPGGFFTojt1F2uQmtTIXs/D
         h5zQ==
X-Gm-Message-State: AO0yUKUlziFB+u3t0PDrnHtwvYZh2n0FT2lDJZ4Dl3ErwZHXTMOREVOB
        AjrwgJIWTUjMtNpiPpB3844=
X-Google-Smtp-Source: AK7set9AnusFcqc2c6udy8lC2Y6wkzqTL1MyGF5uggu+wfO/RWfZBQYHQvqUeEugk2/pBsVxs4pj9Q==
X-Received: by 2002:a05:600c:1e06:b0:3dc:18de:b20d with SMTP id ay6-20020a05600c1e0600b003dc18deb20dmr6553730wmb.33.1675352038166;
        Thu, 02 Feb 2023 07:33:58 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc22ee5a2bsm5522893wmq.39.2023.02.02.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:33:57 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Feb 2023 16:33:55 +0100
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
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
Message-ID: <Y9vX49CtDzyg3B/8@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <Y9vSZhBBCbshI3eM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vSZhBBCbshI3eM@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:10:30PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> > hi,
> > we have a use cases for bpf programs to use binary file's build id.
> 
> What is your use case?  Is it some hobbyist thing or is it something
> that distro kernels are all going to enable?
> 

our use case is for hubble/tetragon [1] and we are asked to report
buildid of executed binary.. but the monitoring process is running
in its own pod and can't access the the binaries outside of it, so
we need to be able to read it in kernel

I understand Hao Luo has also use case for that [2]

jirka


[1] https://github.com/cilium/tetragon/
[2] https://lore.kernel.org/bpf/CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com/
