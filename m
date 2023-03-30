Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA36D11F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjC3WHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjC3WGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FC11EB7;
        Thu, 30 Mar 2023 15:05:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so8918919wmq.3;
        Thu, 30 Mar 2023 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680213931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vn1y/TSQU/s4um/hYxW7MiRhdM9UUyXaGxedueCrmV0=;
        b=H1JOaltVeZZCCsf2+4gSMJWB/xFr9MQhe7OJsxlrKiZG9lfCq4J6Gq0qOb8EGSo6Kp
         PSmEEJ2X8+dihMWZMtPqtxZ3Yj/J9x0qpgZ5ra/zm9oeFwyDkEIa25sweaM1LsI4ejVz
         GD9TZGcmecknzIg8E23rJfVeb0Z0xCsIVEDULJ/UUJ8E1oTMr728LmE6kclGF6WJa4kp
         5Nj6ON3y5s8eWVDJhEWTaJND31LCqECdsVXQLP5PHJlvHKcx7HP/RVv52jDk8G1Hvx24
         yVXkVyERPeoA22ufzn/HUyrqIVRAcmSW3F4SZgBJu4hWUz/CmM2lQbikPj0VggOVGx0d
         g1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vn1y/TSQU/s4um/hYxW7MiRhdM9UUyXaGxedueCrmV0=;
        b=PkRKyOSititEV6pZtfrJiessym98cYEJSypC2s/++5rPOiOrbswpuKg8vq+/AdQWXI
         eZSI15d1ScRx9ZArZNbAX7NEGWWXayTDMIockxqsV0RMGEQQIt3ITLWWeznGXNFN4NOY
         CuiAkfP4sPOoasRq2n3f968/YOEv2fCLrut2EV+2JqqRIvxzqu/ycsNki7mIcgO81iIS
         V8XabT3Ohy9cE2T+u9gPCiMvwLUMsvhjmuSKdz36yT3Dt6hmLydeE4qWZ6UUPUkUv5+1
         RZA14MAFam4/1m97nDNwAXEXufRAiLmsDKjr1oh2RtgXGjEDw/jTZGWdMljC0iOmSwWj
         i59Q==
X-Gm-Message-State: AAQBX9fylcj7ZHPJXYz/EJ4MbjYF2N0wKcS9mrLw3boMzUhqoQ3W/v37
        pLRZubRowUvSt9E9GZqMzFg=
X-Google-Smtp-Source: AKy350ZICrrUdVQb3X+xMlyj7UWwKz5tGv0mqHXM0pgeTHRgxsGX051MDWvlpYxSDr8+m0SD3v5WWA==
X-Received: by 2002:a05:600c:21cd:b0:3ef:6e1c:3fe9 with SMTP id x13-20020a05600c21cd00b003ef6e1c3fe9mr12576272wmj.16.1680213930692;
        Thu, 30 Mar 2023 15:05:30 -0700 (PDT)
Received: from krava ([83.240.63.154])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d4ec7000000b002c5544b3a69sm424300wrv.89.2023.03.30.15.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:05:30 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 31 Mar 2023 00:05:28 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 bpf-next 5/9] selftests/bpf: Add read_buildid function
Message-ID: <ZCYHqBECVe4SAEr4@krava>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <20230316170149.4106586-6-jolsa@kernel.org>
 <CAEf4BzZpXK0_k0Z8BmAB1-Edpc_BZYsu5wt9XVEJ4ryAxDYewA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZpXK0_k0Z8BmAB1-Edpc_BZYsu5wt9XVEJ4ryAxDYewA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 03:23:03PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 16, 2023 at 10:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding read_build_id function that parses out build id from
> > specified binary.
> >
> > It will replace extract_build_id and also be used in following
> > changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>

I'll send this separatelly as bpf/selftests fix so doesn't get lost

> > ---
> >  tools/testing/selftests/bpf/trace_helpers.c | 86 +++++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h |  5 ++
> >  2 files changed, 91 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> > index 934bf28fc888..72b38a41f574 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.c
> > +++ b/tools/testing/selftests/bpf/trace_helpers.c
> > @@ -11,6 +11,9 @@
> >  #include <linux/perf_event.h>
> >  #include <sys/mman.h>
> >  #include "trace_helpers.h"
> > +#include <linux/limits.h>
> > +#include <libelf.h>
> > +#include <gelf.h>
> >
> >  #define TRACEFS_PIPE   "/sys/kernel/tracing/trace_pipe"
> >  #define DEBUGFS_PIPE   "/sys/kernel/debug/tracing/trace_pipe"
> > @@ -234,3 +237,86 @@ ssize_t get_rel_offset(uintptr_t addr)
> >         fclose(f);
> >         return -EINVAL;
> >  }
> > +
> > +static int
> > +parse_build_id_buf(const void *note_start, Elf32_Word note_size,
> > +                  char *build_id)
> 
> nit: single line

ok

> 
> should we pass buffer size instead of assuming at least BPF_BUILD_ID_SIZE below?

ok

> 
> > +{
> > +       Elf32_Word note_offs = 0, new_offs;
> > +
> > +       while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> > +               Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
> > +
> > +               if (nhdr->n_type == 3 && nhdr->n_namesz == sizeof("GNU") &&
> > +                   !strcmp((char *)(nhdr + 1), "GNU") && nhdr->n_descsz > 0 &&
> > +                   nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
> > +                       memcpy(build_id, note_start + note_offs +
> > +                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr), nhdr->n_descsz);
> > +                       memset(build_id + nhdr->n_descsz, 0, BPF_BUILD_ID_SIZE - nhdr->n_descsz);
> > +                       return (int) nhdr->n_descsz;
> > +               }
> > +
> > +               new_offs = note_offs + sizeof(Elf32_Nhdr) +
> > +                          ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
> > +               if (new_offs >= note_size)
> > +                       break;
> 
> while condition() above would handle this, so this check appears not necessary?
> 
> so just assign note_offs directly?

good idea, it will simplify that

> 
> 
> > +               note_offs = new_offs;
> > +       }
> > +
> > +       return -EINVAL;
> 
> nit: -ENOENT or -ESRCH?

I kept the same error as is in kernel, but ENOENT makes more sense

> 
> > +}
> > +
> > +/* Reads binary from *path* file and returns it in the *build_id*
> > + * which is expected to be at least BPF_BUILD_ID_SIZE bytes.
> > + * Returns size of build id on success. On error the error value
> > + * is returned.
> > + */
> > +int read_build_id(const char *path, char *build_id)
> > +{
> > +       int fd, err = -EINVAL;
> > +       Elf *elf = NULL;
> > +       GElf_Ehdr ehdr;
> > +       size_t max, i;
> > +
> > +       fd = open(path, O_RDONLY | O_CLOEXEC);
> > +       if (fd < 0)
> > +               return -errno;
> > +
> > +       (void)elf_version(EV_CURRENT);
> > +
> > +       elf = elf_begin(fd, ELF_C_READ, NULL);
> 
> ELF_C_READ_MMAP ?

ok

> 
> > +       if (!elf)
> > +               goto out;
> > +       if (elf_kind(elf) != ELF_K_ELF)
> > +               goto out;
> > +       if (gelf_getehdr(elf, &ehdr) == NULL)
> 
> nit: !gelf_getehdr()

ok

> 
> > +               goto out;
> > +       if (ehdr.e_ident[EI_CLASS] != ELFCLASS64)
> > +               goto out;
> 
> does this have to be 64-bit specific?... you are using gelf stuff, you
> can be bitness-agnostic here

right, I don't think it's needed, will check

> 
> > +
> > +       for (i = 0; i < ehdr.e_phnum; i++) {
> > +               GElf_Phdr mem, *phdr;
> > +               char *data;
> > +
> > +               phdr = gelf_getphdr(elf, i, &mem);
> > +               if (!phdr)
> > +                       goto out;
> > +               if (phdr->p_type != PT_NOTE)
> > +                       continue;
> 
> I don't know where ELF + build ID spec is (if at all), but it seems to
> always be in the ".note.gnu.build-id" section, so should we check the
> name here?

this section name is not manadatory as stated in
  https://fedoraproject.org/wiki/RolandMcGrath/BuildID

  The new section is canonically called .note.gnu.build-id, but the name is not normative,
  and the section can be merged with other SHT_NOTE sections. The ELF note headers give
  name "GNU" and type 3 (NT_GNU_BUILD_ID) for a build ID note.

> 
> 
> > +               data = elf_rawfile(elf, &max);
> > +               if (!data)
> > +                       goto out;
> > +               if (phdr->p_offset >= max || (phdr->p_offset + phdr->p_memsz >= max))
> 
> `phdr->p_offset + phdr->p_memsz == max` would be fine, no?

right, will change

thanks,
jirka

> 
> > +                       goto out;
> > +               err = parse_build_id_buf(data + phdr->p_offset, phdr->p_memsz, build_id);
> > +               if (err > 0)
> > +                       goto out;
> > +               err = -EINVAL;
> > +       }
> > +
> > +out:
> > +       if (elf)
> > +               elf_end(elf);
> > +       close(fd);
> > +       return err;
> > +}
> > diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> > index 53efde0e2998..bc3b92057033 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.h
> > +++ b/tools/testing/selftests/bpf/trace_helpers.h
> > @@ -4,6 +4,9 @@
> >
> >  #include <bpf/libbpf.h>
> >
> > +#define __ALIGN_MASK(x, mask)  (((x)+(mask))&~(mask))
> > +#define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a)-1)
> > +
> >  struct ksym {
> >         long addr;
> >         char *name;
> > @@ -23,4 +26,6 @@ void read_trace_pipe(void);
> >  ssize_t get_uprobe_offset(const void *addr);
> >  ssize_t get_rel_offset(uintptr_t addr);
> >
> > +int read_build_id(const char *path, char *build_id);
> > +
> >  #endif
> > --
> > 2.39.2
> >
