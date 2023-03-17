Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA796BDFD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 04:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCQDv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 23:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCQDv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:51:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C376070;
        Thu, 16 Mar 2023 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6e5vgV9Lhq/FUovigpv1aQ+kfiWhjBTgyYSzrwszW/M=; b=RkgV/CLM0H4tbM+sMx80KLuyZI
        dhlobK9j/Zpdl37/xfWN7sk8uzdEF1sMSNimFevN1BOWVS4+VnFHCRMPFNviV6jgqSKr/R2usMGVa
        RyLURFWSuNiUJOzucNIF0hAkeYzU9Mv2Re4vYNb7wEdkB+7c785k79P1Y2oSmegvz39Apa6v29/kp
        INL7HuskgHrZmd8pWt7+VcOEHVAcxYKBIdzqIw/z4Pp4Wd1rwUte1cGugOTh9sSNhSfZCfH0ap6wM
        I/ybbA6jm7zMzvCbNc7/lzIWdoJEP/lWSrKGnDyxaBrNDukTEYb5N6c+blBV4fKli/754t71UzsAT
        Y6R05JGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pd17b-00FTM7-BU; Fri, 17 Mar 2023 03:51:15 +0000
Date:   Fri, 17 Mar 2023 03:51:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZBPjs1b8crUv4ur6@casper.infradead.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
 <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:51:52PM -0700, Andrii Nakryiko wrote:
> Yep, Meta is also capturing stack traces with build ID as well, if
> possible. Build IDs help with profiling short-lived processes which
> exit before the profiling session is done and user-space tooling is
> able to collect /proc/<pid>/maps contents (which is what Ian is
> referring to here). But also build ID allows to offload more of the
> expensive stack symbolization process (converting raw memory addresses
> into human readable function+offset+file path+line numbers
> information) to dedicated remote servers, by allowing to cache and
> reuse preprocessed DWARF/ELF information based on build ID.
> 
> I believe perf tool is also using build ID, so any tool relying on
> perf capturing full and complete profiling data for system-wide
> performance analysis would benefit as well.
> 
> Generally speaking, there is a whole ecosystem built on top of
> assumption that binaries have build ID and profiling tooling is able
> to provide more value if those build IDs are more reliably collected.
> Which ultimately benefits the entire open-source ecosystem by allowing
> people to spot issues (not necessarily just performance, it could be
> correctness issues as well) more reliably, fix them, and benefit every
> user.

But build IDs are _generally_ available.  The only problem (AIUI)
is when you're trying to examine the contents of one container from
another container.  And to solve that problem, you're imposing a cost
on everybody else with (so far) pretty vague justifications.  I really
don't like to see you growing struct file for this (nor struct inode,
nor struct vm_area_struct).  It's all quite unsatisfactory and I don't
have a good suggestion.
