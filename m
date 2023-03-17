Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966566BF3A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCQVO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 17:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCQVO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:14:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1512884B;
        Fri, 17 Mar 2023 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cHqfWu/5jLA19Bc4SPAq+8G3pCotHNCQZAShat/fUf4=; b=ThJc2vpScZAiBQxgjZDotCj6p9
        DTMXzCRy/yOVCF1einZD1BU3rJhnQlNH/lx0rME2jZK8WR2dHAQCIrEvB7h+6AuCu2BbZMhLp0Q00
        nTH6K91KnBffoDwCNL9mWkxkDt119Qqu2/YNsFWqzbKjFjUHE0YRZOL0HNo27frzNWUMmSiPS/RrA
        vaJ19v53ST1t6XJKO8KVCuiX7sa9MO4YtCw2PcXkZt7xKzB3MGXTHTztFzp0+U4jZWfUduusForhh
        XiwJ6m3g2kURSNAnW4uDwXALalBS5zSd/NEhT8m1wOrCLKqKICf2NMWUdxUCp9JkxOHQg9ozJu8u/
        ZOqYY8aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdHOl-00HSsX-0w;
        Fri, 17 Mar 2023 21:14:03 +0000
Date:   Fri, 17 Mar 2023 21:14:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20230317211403.GZ3390869@ZenIV>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
 <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
 <ZBPjs1b8crUv4ur6@casper.infradead.org>
 <CAEf4BzbPa-5b9uU0+GN=iaMGc6otje3iNQd+MOg_byTSYU8fEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbPa-5b9uU0+GN=iaMGc6otje3iNQd+MOg_byTSYU8fEQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:33:17AM -0700, Andrii Nakryiko wrote:

> > But build IDs are _generally_ available.  The only problem (AIUI)
> > is when you're trying to examine the contents of one container from
> > another container.  And to solve that problem, you're imposing a cost
> > on everybody else with (so far) pretty vague justifications.  I really
> > don't like to see you growing struct file for this (nor struct inode,
> > nor struct vm_area_struct).  It's all quite unsatisfactory and I don't
> > have a good suggestion.
> 
> There is a lot of profiling, observability and debugging tooling built
> using BPF. And when capturing stack traces from BPF programs, if the
> build ID note is not physically present in memory, fetching it from
> the BPF program might fail in NMI (and other non-faultable contexts).
> This patch set is about making sure we always can fetch build ID, even
> from most restrictive environments. It's guarded by Kconfig to avoid
> adding 8 bytes of overhead to struct file for environment where this
> might be unacceptable, giving users and distros a choice.

Lovely.  As an exercise you might want to collect the stats on the
number of struct file instances on the system vs. the number of files
that happen to be ELF objects and are currently mmapped anywhere.
That does depend upon the load, obviously, but it's not hard to collect -
you already have more than enough hooks inserted in the relevant places.
That might give a better appreciation of the reactions...
