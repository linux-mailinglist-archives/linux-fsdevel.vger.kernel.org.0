Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356E073140
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGXOKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 10:10:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35981 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfGXOKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:10:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so21030230pfl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2019 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXhaeMPXQ8MNtkF+Sp+2bS4wghsA38PAkoq4RUXLo/c=;
        b=m6YvAC5UDmYi4TsfqlA07rTcUbfvc9lidZhL3ozBZPd9FuNWIKormAzLfT9QLJeXSF
         2DlJ04Pv53eAX5aDIefwhPa4ynnSAA98nz2zD5VGbt4BI8tgCFX+iFwGmIgLSHIE1zb2
         8tkJvPr+jPd5o5N/vsQKy8hTHoEz1YzrJNWUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXhaeMPXQ8MNtkF+Sp+2bS4wghsA38PAkoq4RUXLo/c=;
        b=N8eqAfIOjhvv2yi4SDpV6zbF4ZbQ+bMKDaoHGa/CYHDgfz2Rd+zZ5WVcygFjy3A/sE
         tTuc9Pj1rMr2hOzQ3B4W53CvWnipmt6AUCnlzWQNhI4DAPypnsCUFSFRkWMvdNsRvi7I
         kRT44iuAMfv0UPb+Axw3A+C2jWlbINpUcgeJrVK8eMy8OWRsGKmgivSgOVo/lFu7WEdE
         gnFrIz2jDvXNtsW2XkwS7VG42r1y8/WcO0mjr/qb2V2JoRBeqErfkhuPOK0ycLyeDLdW
         vg78Gr9J+4qeBFCqUdhHGS3lb47k6kCWV0usOXrVnm+Pf1Uj26TYQLfUmcpKv+Odip23
         u1gw==
X-Gm-Message-State: APjAAAUroQQq1S9B5HvcjFoOrPbaIg6c8WbLoe4/qTxyXpmYV5UQIBmz
        HXr6XJ4dwGPTlc6V6I1ynOw=
X-Google-Smtp-Source: APXvYqxhiuMEPHH8pRDkDkxK8JM+xQ0EECYE2I6dsIIwwk5MI/hkEsc+JGVOGaSpqK/SVp9B21n2eQ==
X-Received: by 2002:a63:dd0b:: with SMTP id t11mr41295651pgg.410.1563977454295;
        Wed, 24 Jul 2019 07:10:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q63sm61399100pfb.81.2019.07.24.07.10.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:10:53 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:10:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        sspatil@google.com, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, timmurray@google.com,
        tkjos@google.com, Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190724141052.GB9945@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723061358.GD128252@google.com>
 <20190723142049.GC104199@google.com>
 <20190724042842.GA39273@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724042842.GA39273@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:28:42PM +0900, Minchan Kim wrote:
> On Tue, Jul 23, 2019 at 10:20:49AM -0400, Joel Fernandes wrote:
> > On Tue, Jul 23, 2019 at 03:13:58PM +0900, Minchan Kim wrote:
> > > Hi Joel,
> > > 
> > > On Mon, Jul 22, 2019 at 05:32:04PM -0400, Joel Fernandes (Google) wrote:
> > > > The page_idle tracking feature currently requires looking up the pagemap
> > > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > > This is quite cumbersome and can be error-prone too. If between
> > > 
> > > cumbersome: That's the fair tradeoff between idle page tracking and
> > > clear_refs because idle page tracking could check even though the page
> > > is not mapped.
> > 
> > It is fair tradeoff, but could be made simpler. The userspace code got
> > reduced by a good amount as well.
> > 
> > > error-prone: What's the error?
> > 
> > We see in normal Android usage, that some of the times pages appear not to be
> > idle even when they really are idle. Reproducing this is a bit unpredictable
> > and happens at random occasions. With this new interface, we are seeing this
> > happen much much lesser.
> 
> I don't know how you did test. Maybe that could be contributed by
> swapping out or shared pages touched by other processes or some kernel
> behavior not to keep access bit of their operation.

It could be something along these lines is my thinking as well. So we know
its already has issues due to what you mentioned, I am not sure what else
needs investigation?

> Please investigate more what's the root cause. That would be important
> point to justify for the patch motivation.

The motivation is security. I am dropping the 'accuracy' factor I mentioned
from the patch description since it created a lot of confusion.

> > > > More over looking up PFN from pagemap in Android devices is not
> > > > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > > > the PFN.
> > > > 
> > > > This patch adds support to directly interact with page_idle tracking at
> > > > the PID level by introducing a /proc/<pid>/page_idle file. This
> > > > eliminates the need for userspace to calculate the mapping of the page.
> > > > It follows the exact same semantics as the global
> > > > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > > > where looking up PFN is not needed and also does not require SYS_ADMIN.
> > > 
> > > Ah, so the primary goal is to provide convinience interface and it would
> > > help accurary, too. IOW, accuracy is not your main goal?
> > 
> > There are a couple of primary goals: Security, conveience and also solving
> > the accuracy/reliability problem we are seeing. Do keep in mind looking up
> > PFN has security implications. The PFN field in pagemap is zeroed if the user
> > does not have CAP_SYS_ADMIN.
> 
> Myaybe you don't need PFN. is it?

With the traditional idle tracking, PFN is needed which has the mentioned
security issues. This patch solves it. And the interface is identical and
familiar to the existing page_idle bitmap interface.

> > > > In Android, we are using this for the heap profiler (heapprofd) which
> > > > profiles and pin points code paths which allocates and leaves memory
> > > > idle for long periods of time.
> > > 
> > > So the goal is to detect idle pages with idle memory tracking?
> > 
> > Isn't that what idle memory tracking does?
> 
> To me, it's rather misleading. Please read motivation section in document.
> The feature would be good to detect workingset pages, not idle pages
> because workingset pages are never freed, swapped out and even we could
> count on newly allocated pages.
> 
> Motivation
> ==========
> 
> The idle page tracking feature allows to track which memory pages are being
> accessed by a workload and which are idle. This information can be useful for
> estimating the workload's working set size, which, in turn, can be taken into
> account when configuring the workload parameters, setting memory cgroup limits,
> or deciding where to place the workload within a compute cluster.

As we discussed by chat, we could collect additional metadata to check if
pages were swapped or freed ever since the time we marked them as idle.
However this can be incremental improvement.

> > > It couldn't work well because such idle pages could finally swap out and
> > > lose every flags of the page descriptor which is working mechanism of
> > > idle page tracking. It should have named "workingset page tracking",
> > > not "idle page tracking".
> > 
> > The heap profiler that uses page-idle tracking is not to measure working set,
> > but to look for pages that are idle for long periods of time.
> 
> It's important part. Please include it in the description so that people
> understands what's the usecase. As I said above, if it aims for finding
> idle pages durting the period, current idle page tracking feature is not
> good ironically.

Ok, I will mention.

> > Thanks for bringing up the swapping corner case..  Perhaps we can improve
> > the heap profiler to detect this by looking at bits 0-4 in pagemap. While it
> 
> Yeb, that could work but it could add overhead again what you want to remove?
> Even, userspace should keep metadata to identify that page was already swapped
> in last period or newly swapped in new period.

Yep.

thanks,

 - Joel

