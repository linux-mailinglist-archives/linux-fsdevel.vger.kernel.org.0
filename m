Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C96BFB23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCRPRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCRPRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:17:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7D303E9;
        Sat, 18 Mar 2023 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQqhoBxESfjz0MrhZuxEnWRoFia7U0MNzcHrY8Fhlv0=; b=d6ccJIc0boouKz1RgK4pvpGHi8
        4ZkGSh7ToGcaKfREyF2r2iGLEPicussMx8K0l2Li2ra249nXJO7hUZf38itouaruulqS1aOFTKTqN
        jJMx2gb8RC+xEru4EMEUbXlbziGm+fW8Fml8xSUcNodEmfqS15SK8uCirMJIR9JVRKxZaBwPAD74R
        K9n/THstFMW9NglqvNtSQmYgeP646r9HesxPdRri63hl3iM8CtBAdvbnwf953h05nlX4Ap9z9DTvP
        3+UTf5Zp5V2ZQKQBjwv/jwj26batJCHJXAy8GoUDqoSLOsLOteidAWyQR8ImH4PUgpewvrOdjbLIg
        85rR280A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdYIX-00Gudm-D6; Sat, 18 Mar 2023 15:16:45 +0000
Date:   Sat, 18 Mar 2023 15:16:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiri Olsa <olsajiri@gmail.com>
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZBXV3crf/wX5D9lo@casper.infradead.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBV3beyxYhKv/kMp@krava>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 18, 2023 at 09:33:49AM +0100, Jiri Olsa wrote:
> On Thu, Mar 16, 2023 at 05:34:41PM +0000, Matthew Wilcox wrote:
> > On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > > hi,
> > > this patchset adds build id object pointer to struct file object.
> > > 
> > > We have several use cases for build id to be used in BPF programs
> > > [2][3].
> > 
> > Yes, you have use cases, but you never answered the question I asked:
> > 
> > Is this going to be enabled by every distro kernel, or is it for special
> > use-cases where only people doing a very specialised thing who are
> > willing to build their own kernels will use it?
> 
> I hope so, but I guess only time tell.. given the response by Ian and Andrii
> there are 3 big users already

So the whole "There's a config option to turn it off" shtick is just a
fig-leaf.  I won't ever see it turned off.  You're imposing the cost of
this on EVERYONE who runs a distro kernel.  And almost nobody will see
any benefits from it.  Thanks for admitting that.

