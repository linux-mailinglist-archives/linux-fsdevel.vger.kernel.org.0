Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A126A7CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 09:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCBIg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 03:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBIg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:36:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687B14221;
        Thu,  2 Mar 2023 00:36:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so64540813edb.3;
        Thu, 02 Mar 2023 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeu2rejC7ALr4xJCaVvexwWFSyD3FJ1WGHKuY7P9Vfk=;
        b=gy6WYAUhPjCzDjYcBcwVYMJZNJqEGdfEtgTsJQdzZFbChfJc6OELVYJw1PDc1gtL78
         TYKCZoV7D06fuqQnTdyGeOg3mMHVjTpRu0DibqIvgbzD9UWbFsSJ5Gs13gTkb8D5zb0Z
         JBMYmdbYtIe7FNDGaMgb18mgrDT50bCu1C1rGjhYpNdxQa1z1VS11aitl/rz3ju9Z7Ts
         PQhyr0umfdiOkVbj1WfyMmA5biXNmw1qaKOZs1NYVZk/eUiYgU3tWbEU+GJzP66UFbEA
         zfAIpRA9NVmz55s9SKfRwvnFDgxI7hMVuD/8kT/W/26xmYm/hoULhs3i5FLn9XhsYkdU
         KJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeu2rejC7ALr4xJCaVvexwWFSyD3FJ1WGHKuY7P9Vfk=;
        b=nPxRnj7Zumjx1c+6igelVE+fN1wWiwoKpTdrfpCGh40/CbURH2+m1U8KIVxoSB3Tw4
         O1PHTCK7wJ/wXqygVPRxdgveXp4vKLMu8xv2rx6Puj+3iejb6U8Q5zzEgwXflwiYO+KO
         97UwC/7fXvIm0WUtdz6mqwVvnDhUWGljlov4wsvvLeGM4fiwmKFzny0l85/qOs7YmcPU
         gO0A3hXv8C0EcscsZpgPPDpHWMedMAKEIa1Tovlvs40RQd6i80IkYS16Ab5RwATzPu1P
         aKzzRx1ayT5js9gDqZXXppT0ExwKjjoJrsV4w7NlXaep5DAxL5jRe7LZI9SlZ5KVRXFe
         DLAw==
X-Gm-Message-State: AO0yUKV7IGJGRsluNlX3VgqjfYDUBQBp6B/OFE6RLCVk0metqlolPsvU
        x3cX4HV+pgacnoaSxYFYLVs=
X-Google-Smtp-Source: AK7set9fLLZJOXn1J6rQFaJEofA0z/w+K8ekwQdW33ZgC+u1ri5CMmPoim+VtKyA56aaChTmNA0unA==
X-Received: by 2002:a17:906:190b:b0:8f2:da10:c69e with SMTP id a11-20020a170906190b00b008f2da10c69emr11039594eje.52.1677746184870;
        Thu, 02 Mar 2023 00:36:24 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g19-20020a50d0d3000000b004c09527d62dsm292113edf.30.2023.03.02.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:36:24 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Mar 2023 09:35:39 +0100
To:     Dave Chinner <david@fromorbit.com>
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
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [RFC v2 bpf-next 0/9] mm/bpf/perf: Store build id in inode object
Message-ID: <ZABf26mV0D0LS7r/@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228220714.GJ2825702@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228220714.GJ2825702@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 09:07:14AM +1100, Dave Chinner wrote:
> On Tue, Feb 28, 2023 at 10:31:57AM +0100, Jiri Olsa wrote:
> > hi,
> > this is RFC patchset for adding build id under inode's object.
> > 
> > The main change to previous post [1] is to use inode object instead of file
> > object for build id data.
> 
> Please explain what a "build id" is, the use case for it, why we
> need to store it in VFS objects, what threat model it is protecting
> the system against, etc.

hum I still did not get your email from mailing list, just saw it
from Arnaldo's reply and downloaded it from lore

our use case is for hubble/tetragon [1] and we are asked to report
buildid of executed binary.. but the monitoring process is running
in its own pod and can't access the the binaries outside of it, so
we need to be able to read it in kernel

we want to read build id from BPF program attached to sched_exec
tracepoint, and from BPF iterator

we considered adding BPF helper and then kfunc for that, but it turned
out it'd be usefull for other use cases (like retrieving build id from
atomic context [2]) to have the build id stored in file (or inode) object

[1] https://github.com/cilium/tetragon/
[2] https://lore.kernel.org/bpf/CA+khW7juLEcrTOd7iKG3C_WY8L265XKNo0iLzV1fE=o-cyeHcQ@mail.gmail.com/

> 
> > 
> > However.. ;-) while using inode as build id storage place saves some memory
> > by keeping just one copy of the build id for all file instances, there seems
> > to be another problem.
> 
> Yes, the problem being that we can cache hundreds of millions of
> inodes in memory, and only a very small subset of them are going to
> have open files associated with them. And an even smaller subset are
> going to be mmapped.

ok, file seems like better option now

> 
> So, in reality, this proposal won't save any memory at all - it
> costs memory for every inode that is not currently being used as
> a mmapped elf executable, right?

right

> 
> > The problem is that we read the build id when the file is mmap-ed.
> 
> Why? I'm completely clueless as to what this thing does or how it's
> used....

we need the build id only when the file is mmap-ed, so it seemed like
the best way to read it when the file is mmaped

> 
> > Which is fine for our use case,
> 
> Which is?

please see above

thanks,
jirka
