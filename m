Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED0690B49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBIOE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjBIOEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:04:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20444B740;
        Thu,  9 Feb 2023 06:04:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so1884614wrj.3;
        Thu, 09 Feb 2023 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csJasq92cQmgdlmc30exQ4r04Rw6v9M4O3MDFtr27zU=;
        b=h0abjL1+Fen4Sbn7cI38Zvq0+OE80BaF47mew5oxIgrZRQ8iAsOkgh9otxAMibYgEz
         8u26U1vP7VQqtgvUCZEWWeGp8qRomJ1ChZjGmZH5gQuMOUN6Daiqd9Lqm53GXnihOPJV
         lhTz6YhE5az1B3chsM3RNtqfFJCTNTF+zY2ZY5UeevQ4Bzg7C/Wi3wQYuJeoEZZ6ABjm
         5eFaz6HXmGSZ8tieqbCPdOCOYWDBuOzxpU25ZOXMmPQCOgW7rTEvLGvFcY9oeFGI30B0
         Tosn53R2OAEVjjkbwLQp5xhsl49dT8+3Hhl8/V9CzDYXG+09TYtOAaXiemsksIdwIukE
         C0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csJasq92cQmgdlmc30exQ4r04Rw6v9M4O3MDFtr27zU=;
        b=NiY+twv24xXZV9Mad7p2x8ojrI3lA0kQvXdG74BwOhszhvnz10wwsFI8ULmzaohiED
         Wsp0982ScdK1QFU4NGYWNpIDcxnfR2clIAiZuUTbQSfhnx0oOCy9qWSvY6yIrN3fkId5
         uOcypeb+7b/3lB+PZAAiRrCEBaE86FGBK60o1ewQOQylx4+5uJpPz11Jgg+SOMCAlKdb
         XVs7OQNMo5ujBaBRBOYOF3QqK7uhN/vKI6rEZ8a81m4T89lKZqaHiY4mhsnOK7aow9ST
         RJi3/rcQEp7c5zz8SMOgCM1jUxaP2gEByvHu8frGQPOj6ilOBng5TN9BIug21ImaNVJJ
         6UJw==
X-Gm-Message-State: AO0yUKXdz/DNV+KtCajObUnHYTzABeUd3AVI+2uFF/Fq74bCOBkz43mN
        uxFHzrgHkQYB967JQJ1lXQE=
X-Google-Smtp-Source: AK7set93VTtzQGNnswlfV0x9Tfe09Pc5BJ7Uwp3cFtmFXXGx8IEP5S/ev69y3JbXDBJj/rWyuaOyyQ==
X-Received: by 2002:adf:f40a:0:b0:2bf:d937:3589 with SMTP id g10-20020adff40a000000b002bfd9373589mr1969372wro.14.1675951488305;
        Thu, 09 Feb 2023 06:04:48 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b002c54241b4fesm248687wri.80.2023.02.09.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:04:47 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 15:04:45 +0100
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
Subject: Re: [PATCH RFC 4/5] selftests/bpf: Add file_build_id test
Message-ID: <Y+T9fYbGcDDb2RFt@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <20230201135737.800527-5-jolsa@kernel.org>
 <CAEf4BzZ6BVeLV5mG=nB88Ni_8WSYTG0xhFgn-OEM2s6dc14yVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ6BVeLV5mG=nB88Ni_8WSYTG0xhFgn-OEM2s6dc14yVA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:58:06PM -0800, Andrii Nakryiko wrote:

SNIP

> > +
> > +       /* parent, update child's pid and kick it */
> > +       skel->bss->pid = child_pid;
> > +
> > +       err = file_build_id__attach(skel);
> > +       if (!ASSERT_OK(err, "file_build_id__attach"))
> > +               goto out;
> > +
> > +       err = write(go[1], &c, 1);
> > +       if (!ASSERT_EQ(err, 1, "child_write_pipe"))
> > +               goto out;
> > +
> > +       /* wait for child to exit */
> > +       waitpid(child_pid, &child_status, 0);
> > +       if (!ASSERT_EQ(WEXITSTATUS(child_status), 0, "child_exit_value"))
> > +               goto out;
> > +
> > +       if (!ASSERT_OK(read_buildid("/bin/bash", &bid), "read_buildid"))
> 
> can we use urandom_read for build_id ? And it would also be nice to
> check that build id fetching works for liburandom_read.so as well.

ok, will be better together with the shared library

SNIP

> > diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> > index 09a16a77bae4..f5557890e383 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.c
> > +++ b/tools/testing/selftests/bpf/trace_helpers.c
> > @@ -9,6 +9,7 @@
> >  #include <poll.h>
> >  #include <unistd.h>
> >  #include <linux/perf_event.h>
> > +#include <linux/limits.h>
> >  #include <sys/mman.h>
> >  #include "trace_helpers.h"
> >
> > @@ -230,3 +231,37 @@ ssize_t get_rel_offset(uintptr_t addr)
> >         fclose(f);
> >         return -EINVAL;
> >  }
> > +
> > +int read_buildid(const char *path, char **build_id)
> > +{
> > +       char tmp[] = "/tmp/dataXXXXXX";
> > +       char buf[PATH_MAX + 200];
> > +       int err, fd;
> > +       FILE *f;
> > +
> > +       fd = mkstemp(tmp);
> > +       if (fd == -1)
> > +               return -1;
> > +       close(fd);
> > +
> > +       snprintf(buf, sizeof(buf),
> > +               "readelf -n %s 2>/dev/null | grep 'Build ID' | awk '{print $3}' > %s",
> > +               path, tmp);
> > +
> 
> shelling out to readelf for this is unfortunate... maybe let's write a
> libelf-based helper to fetch build ID from .note section?

right, I was thinking of that, shouldn't be that hard
and will speed things up

thanks,
jirka
