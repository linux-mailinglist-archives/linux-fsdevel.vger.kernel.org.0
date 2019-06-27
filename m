Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA958D02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 23:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfF0VZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 17:25:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45877 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:25:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so1833563pfq.12;
        Thu, 27 Jun 2019 14:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcIz0jVRYTUruhG/KoFDVf1SI7yQGass2g5eWReCXuc=;
        b=VUJkDMW4orOAYGtS10zzEXJxw8ya6LPyOH+uVOe08eu3/htXvrF2KgN7VCGI0l+UIx
         Df4SGisiSNDCCslaFtc5naTwJlmcmEdvcY0plVod19ep4gxYne3uWUDx/qKQSp6iA0Fz
         1wt1Tc7b1Rlqww1BlY0RXbAf+F8hLTKvdfa0KcahNiptvCUcTpGdfrut3yLoDrbiH5EH
         XLoLfuXnAw+GQJ/KNRchsvrcEckmHOA7SK0W0ss7vYQ3Zq5nRrLG47Zq1ROGZuOzye19
         b0vVfM/iYzCmDvsdfN3ph//Iu3lchMpUrxwpcRTs36daAEZ64zb97P36gQ+F1bIwXju0
         fWew==
X-Gm-Message-State: APjAAAXwhYpBsmt+To12Go9gGVr34GZ72G8XD/GuhA1rDwhKGmLFo6vg
        jup2vx3eVl5X6AUhGhCvNCA=
X-Google-Smtp-Source: APXvYqyGsCu1nPJ5bWmdfsOj/NIWWCfOB1DP91SvS5iulJBr8pRy1i6aED362EmiH8cSwbKJ5LuQ2w==
X-Received: by 2002:a65:538d:: with SMTP id x13mr5857316pgq.190.1561670733735;
        Thu, 27 Jun 2019 14:25:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a25sm41703pfn.1.2019.06.27.14.25.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:25:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DF854403ED; Thu, 27 Jun 2019 21:25:31 +0000 (UTC)
Date:   Thu, 27 Jun 2019 21:25:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Waiman Long <longman@redhat.com>,
        Masami Hiramatsu <mhiramat@redhat.com>,
        Masoud Asgharifard Sharbiani <masouds@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem slabs
Message-ID: <20190627212531.GF19023@42.do-not-panic.com>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-3-longman@redhat.com>
 <20190626201900.GC24698@tower.DHCP.thefacebook.com>
 <063752b2-4f1a-d198-36e7-3e642d4fcf19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063752b2-4f1a-d198-36e7-3e642d4fcf19@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 04:57:50PM -0400, Waiman Long wrote:
> On 6/26/19 4:19 PM, Roman Gushchin wrote:
> >>  
> >> +#ifdef CONFIG_MEMCG_KMEM
> >> +static void kmem_cache_shrink_memcg(struct mem_cgroup *memcg,
> >> +				    void __maybe_unused *arg)
> >> +{
> >> +	struct kmem_cache *s;
> >> +
> >> +	if (memcg == root_mem_cgroup)
> >> +		return;
> >> +	mutex_lock(&slab_mutex);
> >> +	list_for_each_entry(s, &memcg->kmem_caches,
> >> +			    memcg_params.kmem_caches_node) {
> >> +		kmem_cache_shrink(s);
> >> +	}
> >> +	mutex_unlock(&slab_mutex);
> >> +	cond_resched();
> >> +}
> > A couple of questions:
> > 1) how about skipping already offlined kmem_caches? They are already shrunk,
> >    so you probably won't get much out of them. Or isn't it true?
> 
> I have been thinking about that. This patch is based on the linux tree
> and so don't have an easy to find out if the kmem caches have been
> shrinked. Rebasing this on top of linux-next, I can use the
> SLAB_DEACTIVATED flag as a marker for skipping the shrink.
> 
> With all the latest patches, I am still seeing 121 out of a total of 726
> memcg kmem caches (1/6) that are deactivated caches after system bootup
> one of the test systems. My system is still using cgroup v1 and so the
> number may be different in a v2 setup. The next step is probably to
> figure out why those deactivated caches are still there.
> 
> > 2) what's your long-term vision here? do you think that we need to shrink
> >    kmem_caches periodically, depending on memory pressure? how a user
> >    will use this new sysctl?
> Shrinking the kmem caches under extreme memory pressure can be one way
> to free up extra pages, but the effect will probably be temporary.
> > What's the problem you're trying to solve in general?
> 
> At least for the slub allocator, shrinking the caches allow the number
> of active objects reported in slabinfo to be more accurate. In addition,
> this allow to know the real slab memory consumption. I have been working
> on a BZ about continuous memory leaks with a container based workloads.

So.. this is still a work around?

> The ability to shrink caches allow us to get a more accurate memory
> consumption picture. Another alternative is to turn on slub_debug which
> will then disables all the per-cpu slabs.

So this is a debugging mechanism?

> Anyway, I think this can be useful to others that is why I posted the patch.

Since this is debug stuff, please add this to /proc/sys/debug/ instead.
That would reflect the intention, and would avoid the concern that folks
in production would use these things.

Since we only have 2 users of /proc/sys/debug/ I am now wondering if
would be best to add a new sysctl debug taint flag. This way bug
reports with these stupid knobs can got to /dev/null inbox for bug
reports.

Masami, /proc/sys/debug/kprobes-optimization is debug. Would you be OK
to add the taint for it too?

Masoud, /proc/sys/debug/exception-trace seems to actually be enabled
by default, and its goal seems to be to enable disabling it. So I
don't think it would make sense to taint there.

So.. maybe we need something /proc/sys/taints/ or
/proc/sys/debug/taints/ so its *very* clear this is by no way ever
expected to be used in production.

May even be good to long term add a symlink for vm/drop_caches there
as well?

  Luis
