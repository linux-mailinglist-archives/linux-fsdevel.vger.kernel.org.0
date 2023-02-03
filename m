Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8E6894BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjBCKEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 05:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBCKEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:04:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043110AA0;
        Fri,  3 Feb 2023 02:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YH/8ltZNkKStUJrvFHYeArjsVizSPTMYIhZUjUhNtIY=; b=RjeqYQeuDIs31bqFuDOVNCpJXy
        SpNnas9yZLnzPYarE3/z3e3WDDvHc3fZjPegGCVejqoPSEvAdO6tM9i+qeJPWqxks6FUe+3fVl7f4
        eQn3pkY4Hh65yDr6yK2jG++5WK86Yz5gf2vwUdjDJqSDfJcZlR5hgRa1Lx+f0v4rDPE8aCc090skS
        zbesIES7PWXubGSCZbntIyLgwn0pRnbuFjGeEws9uXjnYe2Glq+Wjoolll9ad525ijsVTVxSPnulC
        x2FY8YQQ08BQCGSwlC+xkiJP1OsnN5Jg+7so+8vNHwar2Tv8+QOkJJYhhsI6ETPcb+76oWBMHfGaq
        9N2l/kgQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNsuh-00EDRc-Qr; Fri, 03 Feb 2023 10:03:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2ED5300129;
        Fri,  3 Feb 2023 11:03:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 794802136B38A; Fri,  3 Feb 2023 11:03:21 +0100 (CET)
Date:   Fri, 3 Feb 2023 11:03:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <Y9zb6fUH3mAoPUzz@hirez.programming.kicks-ass.net>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <CAADnVQ+im7FwSqDcTLmMvfRcT9unwdHBeWG9Snw7W5Q-bcdWvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+im7FwSqDcTLmMvfRcT9unwdHBeWG9Snw7W5Q-bcdWvg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

There can be many vm_area_structs per file, and like for struct file,
there's vm_area_structs for non-executable ranges too.

Given there's only one buildid per file, struct file seems most
appropriate to me.
