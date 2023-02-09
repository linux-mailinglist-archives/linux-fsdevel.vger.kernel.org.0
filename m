Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646B6690B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBIOFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBIOFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:05:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C34B740;
        Thu,  9 Feb 2023 06:05:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1587793wmb.5;
        Thu, 09 Feb 2023 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnUKwrf3QmUwHRYbPJhz1oxuhL0RjLzvi0U8XbLlOpg=;
        b=RnfF8r6WdKv8s7KDGECSXbdB+Dek6BzSaaDqDq42vhSJ7zuuK7XDZovNmyitEjA2zS
         UKSbw03VN/NKFo5OKrh1NqG7I8uCfs4LYo4HEZPKZr7L4Epo2bXLBpUrUTJgpReErF+E
         mN/EDanqdDS54R3YVZ20ue01rk9K3nosbqM7I8bnH3tvH7c76KRnX0L67kyAXiIggrcd
         lrpDewkEcV/xw0Jzk/qJwswf8D/+xzJmz8slTGA7ltTCL7fJveqpfPXdUhmyObv9K3ix
         PpUmVpAqJc6lClWSquZT8nI4aE/jQbB+JOeUwINSRfzXLXfZpmwkch38I863B+HY0LiA
         R/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnUKwrf3QmUwHRYbPJhz1oxuhL0RjLzvi0U8XbLlOpg=;
        b=P0Vz/OUfHYaThOXqYfktEBO4TXDVu74g8QC/4vMov3rmrxERDjmRMEhyon6b8rcoYe
         IdQ0gm8buU5Bfoay6vWW2Omh//ZhO9kSaMqRt6okywNMmON47HZdVdLspuT2hAxoPOOW
         Z5+lUah4sMII2x+kyP0n9vQyxsqaY9mvXkgz6vHtk3c6IIYECLq+do3UwFYiDqht7ayP
         L+C+iFys/Ov8E+ufXxxVASYGvYSe+0FjV8I320Jb2agZjKxriwQm4c5ab7ZfuiHn+Kds
         lS4GzzwgMnINMogupPJDjprMj0HUwZ528fPC4DQf7PhM7KBPQoBTKiP+Xnx50PHmPyfx
         GNVA==
X-Gm-Message-State: AO0yUKXP7SiqcKexubn1/COkoMrjiakaxRY6b6nVhGd2mBKX7o9DOwgJ
        iR9eQb78SZCYhwuZVR54BehU7r5qvt5eAYSI
X-Google-Smtp-Source: AK7set/JJyWcN/ZigLNQVpbyMC5FbBQwDmTp/uGnEBqtMWRRn8UgHASP8FT2mp83fiKVHo+M2g04Rw==
X-Received: by 2002:a05:600c:998:b0:3dc:59ee:7978 with SMTP id w24-20020a05600c099800b003dc59ee7978mr10073277wmp.38.1675951502499;
        Thu, 09 Feb 2023 06:05:02 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm2144836wms.34.2023.02.09.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:05:02 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 15:04:59 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH RFC 1/5] mm: Store build id in file object
Message-ID: <Y+T9iwfvj23gtDMA@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <20230201135737.800527-2-jolsa@kernel.org>
 <CAEf4BzZHwXiLPuaAwz3vexzaJbBC90p5pCawbrsu4-Rk3XZOYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZHwXiLPuaAwz3vexzaJbBC90p5pCawbrsu4-Rk3XZOYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:52:40PM -0800, Andrii Nakryiko wrote:

SNIP

> > diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> > index 3b7a0ff4642f..7c818085ad2c 100644
> > --- a/include/linux/buildid.h
> > +++ b/include/linux/buildid.h
> > @@ -3,9 +3,15 @@
> >  #define _LINUX_BUILDID_H
> >
> >  #include <linux/mm_types.h>
> > +#include <linux/slab.h>
> >
> >  #define BUILD_ID_SIZE_MAX 20
> >
> > +struct build_id {
> > +       u32 sz;
> > +       char data[BUILD_ID_SIZE_MAX];
> 
> don't know if 21 vs 24 matters for kmem_cache_create(), but we don't
> need 4 bytes to store build_id size, given max size is 20, so maybe
> use u8 for sz?

ok

> 
> > +};
> > +
> >  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> >                    __u32 *size);
> >  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
> > @@ -17,4 +23,15 @@ void init_vmlinux_build_id(void);
> >  static inline void init_vmlinux_build_id(void) { }
> >  #endif
> >
> > +#ifdef CONFIG_FILE_BUILD_ID
> > +void __init build_id_init(void);
> > +void build_id_free(struct build_id *bid);
> > +int vma_get_build_id(struct vm_area_struct *vma, struct build_id **bidp);
> > +void file_build_id_free(struct file *f);
> > +#else
> > +static inline void __init build_id_init(void) { }
> > +static inline void build_id_free(struct build_id *bid) { }
> > +static inline void file_build_id_free(struct file *f) { }
> > +#endif /* CONFIG_FILE_BUILD_ID */
> > +
> >  #endif
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c1769a2c5d70..9ad5e5fbf680 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -975,6 +975,9 @@ struct file {
> >         struct address_space    *f_mapping;
> >         errseq_t                f_wb_err;
> >         errseq_t                f_sb_err; /* for syncfs */
> > +#ifdef CONFIG_FILE_BUILD_ID
> > +       struct build_id         *f_bid;
> 
> naming nit: anything wrong with f_buildid or f_build_id? all the
> related APIs use fully spelled out "build_id"

ok

SNIP

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 425a9349e610..a06f744206e3 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2530,6 +2530,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >         pgoff_t vm_pgoff;
> >         int error;
> >         MA_STATE(mas, &mm->mm_mt, addr, end - 1);
> > +       struct build_id *bid = NULL;
> >
> >         /* Check against address space limit. */
> >         if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > @@ -2626,6 +2627,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >                 if (error)
> >                         goto unmap_and_free_vma;
> >
> > +#ifdef CONFIG_FILE_BUILD_ID
> > +               if (vma->vm_flags & VM_EXEC && !file->f_bid) {
> > +                       error = vma_get_build_id(vma, &bid);
> > +                       if (error)
> > +                               goto close_and_free_vma;
> 
> do we want to fail mmap_region() if we get -ENOMEM from
> vma_get_build_id()? can't we just store ERR_PTR(error) in f_bid field?
> So we'll have f_bid == NULL for non-exec files, ERR_PTR() for when we
> tried and failed to get build ID, and a valid pointer if we succeeded?

I guess we can do that.. might be handy for debugging

also build_id_parse might fail on missing build id, so you're right,
we should not fail mmap_region in here

thanks,
jirka
