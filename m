Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7321A185AFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 08:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCOHQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 03:16:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgCOHPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wAfYh2xdWxAPIQJMB0mxlXqUYNASxsyPuzu7mvOnmEc=; b=AU/XB7mVJWInyKEADhOo52OrCP
        mHHs4FpGwJVFsaEJIkwKB7GPlSxFxK5wb8lY/h7k1B2HI8/TEkr5nu6+qzH+meQbqOy+RBLbLEzMk
        9fYmB10Qv6zwHhHdlZUG9O6k8w5IYi/7TpGJuqYkAqVdyyT0bjQ6ygAnsKRb9gPfM5sRlcnTnPCbK
        2iYLwNUNb8rV7WJLCE/o74fQ9dC9we5VzowkOyE++PUmAj8V16Z1EeO6ce6YjYBTThvu3AlG55kgl
        96pb4yEWavmHxUe1+6udBFG6cZbW2IQZohTgCBHmFUUSJ/hKXIntwyV8/kQhr2nyk0+BVsgcfEUMH
        RyPc/nhQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDKEa-00050h-44; Sun, 15 Mar 2020 03:46:40 +0000
Date:   Sat, 14 Mar 2020 20:46:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200315034640.GV22433@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> As there is no limit for negative dentries, it is possible that a sizeable
> portion of system memory can be tied up in dentry cache slabs. Dentry slabs
> are generally recalimable if the dentries are in the LRUs. Still having
> too much memory used up by dentries can be problematic:
> 
>  1) When a filesystem with too many negative dentries is being unmounted,
>     the process of draining the dentries associated with the filesystem
>     can take some time. To users, the system may seem to hang for
>     a while.  The long wait may also cause unexpected timeout error or
>     other warnings.  This can happen when a long running container with
>     many negative dentries is being destroyed, for instance.
> 
>  2) Tying up too much memory in unused negative dentries means there
>     are less memory available for other use. Even though the kernel is
>     able to reclaim unused dentries when running out of free memory,
>     it will still introduce additional latency to the application
>     reducing its performance.

There's a third problem, which is that having a lot of negative dentries
can clog the hash chains.  I tried to quantify this, and found a weird result:

root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.402s
user	0m4.361s
sys	0m1.230s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.572s
user	0m4.337s
sys	0m1.407s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.607s
user	0m4.522s
sys	0m1.342s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.599s
user	0m4.472s
sys	0m1.369s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.574s
user	0m4.498s
sys	0m1.300s

Pretty consistent system time, between about 1.3 and 1.4 seconds.

root@bobo-kvm:~# grep dentry /proc/slabinfo 
dentry             20394  21735    192   21    1 : tunables    0    0    0 : slabdata   1035   1035      0
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m5.515s
user	0m4.353s
sys	0m1.359s

At this point, we have 20k dentries allocated.

Now, pollute the dcache with names that don't exist:

root@bobo-kvm:~# for i in `seq 1 100000`; do cat /dev/null$i >/dev/zero; done 2>/dev/null
root@bobo-kvm:~# grep dentry /proc/slabinfo 
dentry             20605  21735    192   21    1 : tunables    0    0    0 : slabdata   1035   1035      0

Huh.  We've kept the number of dentries pretty constant.  Still, maybe the
bad dentries have pushed out the good ones.

root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m6.644s
user	0m4.921s
sys	0m1.946s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m6.676s
user	0m5.004s
sys	0m1.909s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m6.662s
user	0m4.980s
sys	0m1.916s
root@bobo-kvm:~# time for i in `seq 1 10000`; do cat /dev/null >/dev/zero; done
real	0m6.714s
user	0m4.973s
sys	0m1.986s

Well, we certainly made it suck.  Up to a pretty consistent 1.9-2.0 seconds
of kernel time, or 50% worse.  We've also made user time worse, somehow.

Anyhow, I should write a proper C program to measure this.  But I thought
I'd share this raw data with you now to demonstrate that dcache pollution
is a real problem today, even on a machine with 2GB.
