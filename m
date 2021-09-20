Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6C412D48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 05:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhIUDS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350243AbhIUC2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:28:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FDC1E7C70;
        Mon, 20 Sep 2021 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ce9uaTKd/D6QGSNbhvZvPAgEhomYs3uXfZuXWEuTyDo=; b=369USbNlI+62qdglSNQET5FERT
        WUvD7ynkbpEFudjb0fzSZMx1jcQ0hKOHBeMIB+Pj2VdvtrEfRI3LKt0bQAnDxpHRqpv5P6niCIlsb
        vlDnHHYc0zuAPHDcADuSeTRcnr78tG8F+7PK1OVCzWdHqzs8WbAVQXI7ZLfan7YbWZ7KDaPGTxirF
        ZZUKGCVxE52zlioB/QkdVf6IrxxosbDb/xyQxcCB90Zl17FaLFDtLVrcFXNLdGJErM4FQk4iaUTAV
        SaWz38ee84P1Ya6hFVMqeeHYnwzGrok3ud5aKaVEzLkEZd9ECbjJ+/ib+sgCJQAbOHqO0IwNeYwk+
        Wfyl9zcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSOl8-002uHl-FF; Mon, 20 Sep 2021 19:15:22 +0000
Date:   Mon, 20 Sep 2021 12:15:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUjdytEDkCughtSz@bombadil.infradead.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
 <YUjKjLzqpcxjRyit@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjKjLzqpcxjRyit@slm.duckdns.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:53:16AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 17, 2021 at 10:04:27PM -0700, Luis Chamberlain wrote:
> > If try_module_get() fails we fail the operation on the kernfs node.
> > 
> > We use a try method as a full lock means we'd then make our sysfs
> > attributes busy us out from possible module removal, and so userspace
> > could force denying module removal, a silly form of "DOS" against module
> > removal. A try lock on the module removal ensures we give priority to
> > module removal and interacting with sysfs attributes only comes second.
> > Using a full lock could mean for instance that if you don't stop poking
> > at sysfs files you cannot remove a module.
> 
> I find this explanation odd because there's no real equivalent to locking
> the module (as opposed to try locking) 

Actually there is, __module_get() but I suspect some of these users are
probably incorrect and should be be moved to try. The documentation
about "rmmod --wait" for __module_get() is also outdated as that option
is no longer supported. I'll send an update for that later.

> because you can't wait for the
> removal to finish and then grant the lock, so any operation which increases
> the reference *has* to be a try method unless the caller already holds a
> reference to the same module and thus knows that the module is already
> pinned.

Right, the reason I mention the alternative is that we technically don't
need to use try in this case since during a kernfs op it is implied the
module will be pinned, but we have further motivations to use a try
method here: to avoid a possible DOS from module removal by userspace
mucking with ops.

> The code isn't wrong, so maybe just drop the related paragraphs in
> the commit message?

Does it make sense to clarify the above a bit more somehow? Or do think
its not needed?

> >  static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >  					     struct kernfs_node *parent,
> >  					     const char *name, umode_t mode,
> > +					     struct module *owner,
> >  					     kuid_t uid, kgid_t gid,
> >  					     unsigned flags)
> 
> Is there a particular reason why @owner is added between @mode and @uid?
> Sitting between two fs attributes seems a bit awkward. Maybe it can just be
> the last one?

No, I just picked an arbitrary place. Sure I'll move it to the end.

  Luis
