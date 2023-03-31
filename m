Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C56D27EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCaSgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjCaSgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD51CBA0;
        Fri, 31 Mar 2023 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YE7GfOrERWcu2MD4hsCVsKkg8asC+YWQG3+Pv6uwbqk=; b=uEqp76fQYC/dZmRiYmKKO0zAom
        ZoB3UFNy+UtNl5yJRIrqU/CTlfpVSM+gJ7zG/HAQIPWEJKwiQZp9pVmGtTigRksP0GieeeGZa5Xd+
        HCDdjUd8/Wpi0h5ogPOJYaVs9rCqika3mc+IAnnS4JggKcEso9vLel1P3BD3jTBu4lZJsmnoaxqhr
        UiKc4Zy8F9bFcGyS0KOp7N/uzpEcu9BMY20AwDyBb7iRwvwqd294PwuxZkNc1AeDT3zidgzxhYbl6
        sXNyqw9Z0s1kSTtkYMbGBS/3WhW2jrgyMQEUtJSVcZ9uuH/76BKCypqP1kwXRA9aZ6NiYJKUcVe7w
        ow6TpxuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1piJbx-00BfMF-56; Fri, 31 Mar 2023 18:36:29 +0000
Date:   Fri, 31 Mar 2023 19:36:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, bpf@vger.kernel.org,
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
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZCcoLcncAVeKOZRL@casper.infradead.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava>
 <ZBXV3crf/wX5D9lo@casper.infradead.org>
 <ZBsihOYrMCILT2cI@kernel.org>
 <CAEf4BzakHh3qm2JBsWE8qnMmZMeM7w5vZGneKAsLM_vktPbc9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzakHh3qm2JBsWE8qnMmZMeM7w5vZGneKAsLM_vktPbc9g@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:19:45AM -0700, Andrii Nakryiko wrote:
> On Wed, Mar 22, 2023 at 8:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Having said that, it seems there will be no extra memory overhead at
> > least for a fedora:36 x86_64 kernel:
> 
> Makes sense to me as well. Whatever the solution, as long as it's
> usable from NMI contexts would be fine for the purposes of fetching
> build ID. It would be good to hear from folks that are opposing adding
> a pointer field to struct file whether they prefer this way instead?

Still no.  While it may not take up any room right now, this will
surely not be the last thing added to struct file.  When something
which is genuinely useful needs to be added, that person should
not have to sort out your mess first,

NAK now, NAK tomorrow, NAK forever.  Al told you how you could do it
without trampling on core data structures.
