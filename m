Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67816C4FA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCVPpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCVPpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0E62D94;
        Wed, 22 Mar 2023 08:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AD2FB81D37;
        Wed, 22 Mar 2023 15:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB4C433EF;
        Wed, 22 Mar 2023 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679499911;
        bh=piznudyQ7uqbaBZcF98HpIF4CU1dBOZ+wPLdqX0TKmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPTMOF2QYze+8g9op7JZXCl4pxzpbiXWubKMKya6NKMfPPSCGp43Ffx1kefd5rQuo
         9VFqJAAQ86YK7t4MJT7ii5MQZI6E45Hj5aXg3fFcM+34JVAE9bTrAsbKLA1GJYdO3E
         GScOT5p3bPBNZtrVCqkEgiljnrgsSeGJWISFVGz3jfgJY7pEh086t5cdx38iyjHN+g
         KlPygj/UDC31vTBV0TBtTOCYsv5z2VvPQ9utBCNF7EdgoHzNWSli5J5mGyOw4tMVEL
         3dnojFfiV/VvdOGIChvgg8ax/1pfu530QH3LG7iRqJcfiHsMbkxf/mJpe+qAgtPBnE
         mrNf2qH8OPv2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E5E34052D; Wed, 22 Mar 2023 12:45:08 -0300 (-03)
Date:   Wed, 22 Mar 2023 12:45:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
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
Message-ID: <ZBsihOYrMCILT2cI@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava>
 <ZBXV3crf/wX5D9lo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBXV3crf/wX5D9lo@casper.infradead.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Sat, Mar 18, 2023 at 03:16:45PM +0000, Matthew Wilcox escreveu:
> On Sat, Mar 18, 2023 at 09:33:49AM +0100, Jiri Olsa wrote:
> > On Thu, Mar 16, 2023 at 05:34:41PM +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > > > hi,
> > > > this patchset adds build id object pointer to struct file object.
> > > > 
> > > > We have several use cases for build id to be used in BPF programs
> > > > [2][3].
> > > 
> > > Yes, you have use cases, but you never answered the question I asked:
> > > 
> > > Is this going to be enabled by every distro kernel, or is it for special
> > > use-cases where only people doing a very specialised thing who are
> > > willing to build their own kernels will use it?
> > 
> > I hope so, but I guess only time tell.. given the response by Ian and Andrii
> > there are 3 big users already
> 
> So the whole "There's a config option to turn it off" shtick is just a
> fig-leaf.  I won't ever see it turned off.  You're imposing the cost of
> this on EVERYONE who runs a distro kernel.  And almost nobody will see
> any benefits from it.  Thanks for admitting that.

I agree that build-ids are not useful for all 'struct file' uses, just
for executable files and for people wanting to have better observability
capabilities.

Having said that, it seems there will be no extra memory overhead at
least for a fedora:36 x86_64 kernel:

void __init files_init(void)
{
        filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
                        SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
        percpu_counter_init(&nr_files, 0, GFP_KERNEL);
}

[root@quaco ~]# pahole file | grep size: -A2
	/* size: 232, cachelines: 4, members: 20 */
	/* sum members: 228, holes: 1, sum holes: 4 */
	/* last cacheline: 40 bytes */
[acme@quaco perf-tools]$ uname -a
Linux quaco 6.1.11-100.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Feb  9 20:36:30 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]# head -2 /proc/slabinfo 
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
[root@quaco ~]# grep -w filp /proc/slabinfo 
filp               12452  13056    256   32    2 : tunables    0    0    0 : slabdata    408    408      0
[root@quaco ~]#

so there are 24 bytes on the 4th cacheline that are not being used,
right?

One other observation is that maybe we could do it as the 'struct sock'
hierachy in networking, where we would have a 'struct exec_file' that
would be:

	struct exec_file {
		struct file file;
		char build_id[20];
	}

say, and then when we create the 'struct file' in __alloc_file() we
could check some bit in 'flags' like Al Viro suggested and pick a
different slab than 'filp_cachep', that has that extra space for the
build_id (and whatever else exec related state we may end up wanting, if
ever).

No core fs will need to know about that except when we go free it, to
free from the right slab cache.

In current distro configs, no overhead would take place if I read that
SLAB_HWCACHE_ALIGN thing right, no?

- Arnaldo
