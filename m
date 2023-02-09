Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7B6909BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBINTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 08:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBINTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:19:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D52D7B;
        Thu,  9 Feb 2023 05:19:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so1506607wmb.2;
        Thu, 09 Feb 2023 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4Q71AiGjsfLKoBxQOWiUkZxB1lpoWpjh8S6/VViVGM=;
        b=VYsTBOFOg7+qEy3LpjhJFQJ5IlOmZRSSFEFfejUhzvUmjmKz42pecTD9YrGtL5QvCy
         TFPh/kBqfJu5JHN+mpn1FuUxWtQClRcy/fYXNnur8eCOQ040VCMzfy1zOFWfSPtVI63M
         KAMZnVlmoOVF2aDtSeIb5vODf16+JY/+uA4dRIjRJqq+er5m69Za6ejhENuF0/esIa4P
         sYv0fMjtpqFcZY54ic+tyXnGV3MXZS0yQ0NCDnJHxbLZWGYyUXd9HL36Wjumo+xZHq/l
         v/QVmqEn6U36oY2vQt+SRceIa9T82S07raIaEn3k3ytOVpsnDExGC5LrxiHngiR6AOjE
         pk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4Q71AiGjsfLKoBxQOWiUkZxB1lpoWpjh8S6/VViVGM=;
        b=8I6JF4rGDV0KYR5FLWniwueSvvKdykGStzJMCNNPs0vJaE4gif6FxemmvNgkrdeVM8
         0SlER4dobkr5sQroIf4BEeolmeX/uvDmFgTGlgB4vSZCVEt/q22+QTsUIrBBczua1qKP
         Gor4D9+NoYwiR4IxLOy6gv2jrJ5wJVXV9NoOsC83pHRLohk5TlFkW7gVz/9o4tIDp1q6
         sIqbQXYa4zf1asTJDxMLksueeDfBjAVIxPwLPN1DIyy1byt5GcrNUcmw7DRPTArauWjs
         y5jCnplolIOJ6w9a8rWMkwrq+FTOTPD3BKwiL6bhruGEIenkKln8mJMGGc5cR93dq9Vb
         zpKw==
X-Gm-Message-State: AO0yUKWZVg/zRWO1vsymeFsWiJHQFLtNiqQyIjHRFSBT/FKsLN1am+eZ
        PL12mD3BMzYmn9OE3t7N1oY=
X-Google-Smtp-Source: AK7set8kUwYAxNHUD6tovIM8ZnOWsU0CeR/O9TTfthpdMDuZQbPWx2cIT0b0QPoUc5OSV30H7ZOElg==
X-Received: by 2002:a05:600c:990:b0:3dc:5abb:2f50 with SMTP id w16-20020a05600c099000b003dc5abb2f50mr9550565wmp.19.1675948753640;
        Thu, 09 Feb 2023 05:19:13 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a28-20020a5d457c000000b002bdda9856b5sm1244007wrc.50.2023.02.09.05.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:19:13 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 14:19:05 +0100
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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
Subject: Re: [PATCH RFC 2/5] bpf: Use file object build id in stackmap
Message-ID: <Y+TyyQ38wYubWZtF@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <20230201135737.800527-3-jolsa@kernel.org>
 <CA+khW7iGj=Y3NVxc9Y-MnwmPxCz5jHDmSfW-S6KS9Hko=jgJOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iGj=Y3NVxc9Y-MnwmPxCz5jHDmSfW-S6KS9Hko=jgJOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:23:13PM -0800, Hao Luo wrote:
> On Wed, Feb 1, 2023 at 5:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Use build id from file object in stackmap if it's available.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Can we insert the lookup from vma->vm_file in build_id_parse() rather
> than its callers?

that might simplify also the perf code.. we might need to rename
it though.. maybe build_id_read(vma,...), I'll check

thanks,
jirka

> 
> >  kernel/bpf/stackmap.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index aecea7451b61..944cb260a42c 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -156,7 +156,15 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> >                         goto build_id_valid;
> >                 }
> >                 vma = find_vma(current->mm, ips[i]);
> > +#ifdef CONFIG_FILE_BUILD_ID
> > +               if (vma && vma->vm_file && vma->vm_file->f_bid) {
> > +                       memcpy(id_offs[i].build_id,
> > +                              vma->vm_file->f_bid->data,
> > +                              vma->vm_file->f_bid->sz);
> > +               } else {
> > +#else
> >                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> > +#endif
> >                         /* per entry fall back to ips */
> >                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> >                         id_offs[i].ip = ips[i];
> > --
> > 2.39.1
> >
