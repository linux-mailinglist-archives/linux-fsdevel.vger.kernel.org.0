Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19456A6FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 16:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCAPl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAPl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:41:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E8410AB;
        Wed,  1 Mar 2023 07:41:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212BF6137B;
        Wed,  1 Mar 2023 15:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC4C433EF;
        Wed,  1 Mar 2023 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677685284;
        bh=+qv6It5dGq3Z5N42zbPSFy3HhrWC6PisO2WM+ec3U58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WP5sZE1YDwJteuvwIPzuCpoH8l4GQ3vJF3Z7Ew12qTs0sbiTAQoUAm1H0GN3neq0g
         kp546ONmr7KhXv/OQUUR8Q4v9HGkXwxIkySx2osYW0AECu/h+LiCSlJYGrORbKmaO4
         g4uq3yVfsDmsO3UgjEtMI3vZbLHI1G/1eW9MSUs9j0ASnxnxkn+q8ygx2oaGcvrg0A
         Q/i341yhJtzkSLYJaV+MfWAud9gG08qCfdCloNRQrNSpIBiVsvNHpv1gjpIzbO72iC
         rvMoh/37GKzizCK7Frcw3ReUx01IyAYKX8YsZSlI3EI3xgodOG7Alct6KUWKTHNaeR
         JERnhAKzpSPIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A4534049F; Wed,  1 Mar 2023 12:41:20 -0300 (-03)
Date:   Wed, 1 Mar 2023 12:41:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Y/9yIJ9kOHcZqIzo@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228220714.GJ2825702@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228220714.GJ2825702@dread.disaster.area>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed, Mar 01, 2023 at 09:07:14AM +1100, Dave Chinner escreveu:
> On Tue, Feb 28, 2023 at 10:31:57AM +0100, Jiri Olsa wrote:
> > this is RFC patchset for adding build id under inode's object.

> > The main change to previous post [1] is to use inode object instead of file
> > object for build id data.
> 
> Please explain what a "build id" is, the use case for it, why we
> need to store it in VFS objects, what threat model it is protecting
> the system against, etc.

[root@quaco ~]# file /bin/bash
/bin/bash: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=160df51238a38ca27d03290f3ad5f7df75560ae0, for GNU/Linux 3.2.0, stripped
[root@quaco ~]# file /lib64/libc.so.6
/lib64/libc.so.6: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=8257ee907646e9b057197533d1e4ac8ede7a9c5c, for GNU/Linux 3.2.0, not stripped
[root@quaco ~]#

Those BuildID[sha1]= bits, that is present in all binaries I think in
all distros for quite a while.

This page, from when this was initially designed, has a discussion about
it, why it is needed, etc:

  https://fedoraproject.org/wiki/RolandMcGrath/BuildID

'perf record' will receive MMAP records, initially without build-ids,
now we have one that has, but collecting it when the mmap is executed
(and thus a PERF_RECORD_MMAP* record is emitted) may not work, thus this
work from Jiri.

- Arnaldo
 
> > 
> > However.. ;-) while using inode as build id storage place saves some memory
> > by keeping just one copy of the build id for all file instances, there seems
> > to be another problem.
 
> Yes, the problem being that we can cache hundreds of millions of
> inodes in memory, and only a very small subset of them are going to
> have open files associated with them. And an even smaller subset are
> going to be mmapped.
 
> So, in reality, this proposal won't save any memory at all - it
> costs memory for every inode that is not currently being used as
> a mmapped elf executable, right?
> 
> > The problem is that we read the build id when the file is mmap-ed.
> 
> Why? I'm completely clueless as to what this thing does or how it's
> used....
> 
> > Which is fine for our use case,
> 
> Which is?
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
