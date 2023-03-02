Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34E6A7CF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 09:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCBIla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 03:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCBIl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:41:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5924CAD;
        Thu,  2 Mar 2023 00:41:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg37so64354569edb.12;
        Thu, 02 Mar 2023 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1YXVoCyOwxQNnderTrmDeMC40tQAhZcHa0ukb6R9Ws=;
        b=Rszkk4uwKQuXpOD256yevOsKDiLr4NPBQeo7kAGO8nrR5c7v+uWhDLhg1c7DXe9CCg
         6sFJnQQ4ys8Xt1HBqHwDBQrCCPYrMZ6BlscFKL4kizHDhu5qs0Eh1RxAjc23brCl9Qui
         hLLRgbOMAGA591ODRdSldDjRHtZ2mZSN8n5Vl9ar1h5eHetOevpSNJNTs26ycj6OaG0L
         4L1Pd9hLwD1fUZaSEIK2u125UT6now9zJlMBhpMWKs1c/5nVFU6lq/vXdOsheBdpLFsr
         B8E2UMZSfprRlDOChYnYKKNzt5pl2CyVD9OZJZjYlsvamVh3NNY2DITQQ/F7gUn2Qwtb
         +sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1YXVoCyOwxQNnderTrmDeMC40tQAhZcHa0ukb6R9Ws=;
        b=XDITuMq8D89kWJpMsNCIgRa1eWq9V+RBSRJc85TH9jh6vSuKTr9gJhKJ8CC6DSOkqF
         aYcXbZ58sM1QNzAcVLV6tWbJp+t9gxUEKEWAeMawDjr7jjEuCnW/sSfKVbzsKGQUZW5o
         fMIgMWsJYWeKg+8grFoJyaebDsIccJxwDx93p+OQFp0/d0tvjg2HkSfCRjWKdRjKH1m7
         Dqcmt/cD+NMC9iYuaB2ucDZHwCaeq1RmuNwz4bPgPE7fGtjv8inHAHlZMwKeMgONWxI+
         mSc5tcoJhxhpDtigScMWxqR4pggoQcDJhKJpa0gW/qdB+Fz00rWi/l5PZO9s6aifxH0r
         WP9w==
X-Gm-Message-State: AO0yUKU4PsNvrcoLsbsfhdDat01zJFhtEtHMkmLfpD/Ie6uiYuGsXYTr
        rH3hO85snQwZz1dCw5RKpDUNE99iVFOgQg==
X-Google-Smtp-Source: AK7set+Wnc63PgyHHQ3ShMaX4eflGRmShodrFGCyynYYDAJoy+XWo1MzU/OGJ7YL2Ydiea70Fhp+9w==
X-Received: by 2002:a05:6402:1250:b0:4bb:f229:9431 with SMTP id l16-20020a056402125000b004bbf2299431mr1280219edw.19.1677746486483;
        Thu, 02 Mar 2023 00:41:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm6665583edf.55.2023.03.02.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 00:41:26 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Mar 2023 09:41:23 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <ZABhM913DI+DYSjL@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228220714.GJ2825702@dread.disaster.area>
 <Y/9yIJ9kOHcZqIzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9yIJ9kOHcZqIzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:41:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 01, 2023 at 09:07:14AM +1100, Dave Chinner escreveu:
> > On Tue, Feb 28, 2023 at 10:31:57AM +0100, Jiri Olsa wrote:
> > > this is RFC patchset for adding build id under inode's object.
> 
> > > The main change to previous post [1] is to use inode object instead of file
> > > object for build id data.
> > 
> > Please explain what a "build id" is, the use case for it, why we
> > need to store it in VFS objects, what threat model it is protecting
> > the system against, etc.
> 
> [root@quaco ~]# file /bin/bash
> /bin/bash: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=160df51238a38ca27d03290f3ad5f7df75560ae0, for GNU/Linux 3.2.0, stripped
> [root@quaco ~]# file /lib64/libc.so.6
> /lib64/libc.so.6: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=8257ee907646e9b057197533d1e4ac8ede7a9c5c, for GNU/Linux 3.2.0, not stripped
> [root@quaco ~]#
> 
> Those BuildID[sha1]= bits, that is present in all binaries I think in
> all distros for quite a while.
> 
> This page, from when this was initially designed, has a discussion about
> it, why it is needed, etc:
> 
>   https://fedoraproject.org/wiki/RolandMcGrath/BuildID
> 
> 'perf record' will receive MMAP records, initially without build-ids,
> now we have one that has, but collecting it when the mmap is executed
> (and thus a PERF_RECORD_MMAP* record is emitted) may not work, thus this
> work from Jiri.

thanks for the pointers

build id is unique id for binary that's been used to identify
correct binary version for related stuff.. like binary's debuginfo
in perf or match binary with stack trace entries in bpf stackmap

jirka

> 
> - Arnaldo
>  
> > > 
> > > However.. ;-) while using inode as build id storage place saves some memory
> > > by keeping just one copy of the build id for all file instances, there seems
> > > to be another problem.
>  
> > Yes, the problem being that we can cache hundreds of millions of
> > inodes in memory, and only a very small subset of them are going to
> > have open files associated with them. And an even smaller subset are
> > going to be mmapped.
>  
> > So, in reality, this proposal won't save any memory at all - it
> > costs memory for every inode that is not currently being used as
> > a mmapped elf executable, right?
> > 
> > > The problem is that we read the build id when the file is mmap-ed.
> > 
> > Why? I'm completely clueless as to what this thing does or how it's
> > used....
> > 
> > > Which is fine for our use case,
> > 
> > Which is?
> > 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
