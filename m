Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1A68805F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjBBOr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 09:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBBOrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:47:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67E8F53D;
        Thu,  2 Feb 2023 06:47:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y1so1946450wru.2;
        Thu, 02 Feb 2023 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jg1FM+l1x90qZRI+1yXniygncn9Da3UxYbqywq4gpY=;
        b=CrNUnrXXJMEMMhrHPxmBs1XGQMa7YxqjqYblWbTA3uR3de2kBsyU9biCdNkh5y/ykW
         vuUWKJfKqc3D6zptmk1Jwi2DqdF/89tVGDYjhDcryv6+JrTDH+awQC5lsQGzkVFCM06/
         kk3Dp33w8kpqYx7gXQz2LaMWTnWPPiRUKA8r7jtGY7OSRNCN2RM1UdfLv9eUDYgPpTAa
         4i6fdtttpvw9JHfn8LBVSZnAuE80scqklJD80KF+mdfcGs/ugQVjrM2WF/kiO3UEuhC+
         SvLb4EEX4KJH6P8RCSIVowFebZo3rNb5cUVc2K4KLxoL8v/8Vb89/1gLV+r5dPRKA77l
         AT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jg1FM+l1x90qZRI+1yXniygncn9Da3UxYbqywq4gpY=;
        b=utAulXnD3EJwFtQ01FL/wiur6wklYgQmq3jJlJHU4i3S7HBUl44AQIPSbAthVDaSVJ
         dZt1L93fD0L7hEGq86I+5jfUR1eYIAc1A+WKy7Bz2xtUZIsEvI4/wCRtdqh2UUmU83Da
         Q2Xy8GyQMnr/Zk4T6qy5OilEzZ3URXi0OamIQjJ2c5slTFWHAfmPyr3zitCGVad7jfJs
         hIHgq8UOPhWacHGR5s69d4kgijiSjE0ziMO9slRLPEx/GS2ORak3Z3DqngEngjAvUpXb
         KWOGZIa8rzhRrD+UaU2S1YZgxkh+O81bO26IrH6ZLwSRkAsu/aRx7tMb26WJ98YJvDAT
         8gag==
X-Gm-Message-State: AO0yUKVyoV/IoQVWXt4gMi+smrAMnS2S03lyvoQaTFRLTSNxJBAzTCh2
        PoX5xLl7M2pgiqChOJ6BMrQr9d4fr84DN06y
X-Google-Smtp-Source: AK7set8fehSj0T9hBTlYwSrsIkFREbiUWEWCpLMiuMMQpN0NTg6HQ0be2OEaDS5lWPFDeb+zfp56gQ==
X-Received: by 2002:adf:ed07:0:b0:2bf:f029:8ac7 with SMTP id a7-20020adfed07000000b002bff0298ac7mr5559202wro.67.1675349267983;
        Thu, 02 Feb 2023 06:47:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6daf000000b002bfe266d710sm1821764wrs.90.2023.02.02.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:47:47 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 2 Feb 2023 15:47:45 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
Message-ID: <Y9vNEYsx/SQcN79y@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <CAADnVQ+im7FwSqDcTLmMvfRcT9unwdHBeWG9Snw7W5Q-bcdWvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+im7FwSqDcTLmMvfRcT9unwdHBeWG9Snw7W5Q-bcdWvg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:15:39AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 1, 2023 at 5:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > we have a use cases for bpf programs to use binary file's build id.
> >
> > After some attempts to add helpers/kfuncs [1] [2] Andrii had an idea [3]
> > to store build id directly in the file object. That would solve our use
> > case and might be beneficial for other profiling/tracing use cases with
> > bpf programs.
> >
> > This RFC patchset adds new config CONFIG_FILE_BUILD_ID option, which adds
> > build id object pointer to the file object when enabled. The build id is
> > read/populated when the file is mmap-ed.
> >
> > I also added bpf and perf changes that would benefit from this.
> >
> > I'm not sure what's the policy on adding stuff to file object, so apologies
> > if that's out of line. I'm open to any feedback or suggestions if there's
> > better place or way to do this.
> 
> struct file represents all files while build_id is for executables only,
> and not all executables, but those currently running, so
> I think it's cleaner to put it into vm_area_struct.

I thought file objects would be shared to some extend and we might save
some memory keeping the build id objects there, but not sure it's really
the case now.. will check, using vma might be also easier

jirka
