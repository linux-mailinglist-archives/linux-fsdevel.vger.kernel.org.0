Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4971A77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfGWOfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 10:35:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45483 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbfGWOe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:34:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so19242420pfq.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11EGKG6b5hoi9YzMa3B9zcamZozuOz9TYFdeDHSi/VQ=;
        b=WLqofMgKgwX+GBBcQ17R0iUnyDTfMjIuZc7IpLN2ckGPX+hUVUkkKoMZj9FhwUiZKT
         AdminwPznOb1OAPsVPVbdpz5CvE0xheQ+a2Fa7GnwReA17UPZf46ynImqYVTMnImoysB
         TvEXipsHmJVKm9XkI32JDbIEWcb+EWSJ+gYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11EGKG6b5hoi9YzMa3B9zcamZozuOz9TYFdeDHSi/VQ=;
        b=iS3jPqjDL7wNAdF/53EgWs1MBJ1tDS0u0BooFP5ozZMjKbfpXi8D+Btg0f/jHCLSjh
         AWVdnueosj/d3Qd5TWiAn/oobbpF2YK1vz/qXiza63oFFZNvluyS+nNPxgqTHoaaUZX9
         yBx2v5mxyZfIedtAR/tX/xrHZxFkOj2wMR2uOFFU9DIFBWt9WcvdBJ56jRp16WkJkGwJ
         hoRiQ8druxPibhf/OuLi2IHb7j3jy9qaT44/72HgrwSu0DWe/B7mi0ENl+Uizn2RALSY
         Wp8td0Vi41cmovPtnUaUIPQELDscJ5MJdcSDm3BToMv8fcJh9NDE5HiSqlTGdFwtYGYb
         c18A==
X-Gm-Message-State: APjAAAUhJLNYFRY1v+oboRk6nCCLWdQRB9U+qeg218vXxaveGZIsCs5C
        lAXPU3HQCvf4zkwYtH6QzrQ=
X-Google-Smtp-Source: APXvYqxOGRZiTbW/QTUYHoxI40F9UeoHJjkS/MqxYprvHRJGH4uUkNovTWILl0d4sr9ylHebOwhw0w==
X-Received: by 2002:a63:d852:: with SMTP id k18mr5381517pgj.313.1563892498725;
        Tue, 23 Jul 2019 07:34:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r1sm48527298pfq.100.2019.07.23.07.34.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:34:57 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:34:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
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
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>,
        minchan@google.com, minchan@kernel.org, namhyung@google.com,
        sspatil@google.com, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, timmurray@google.com,
        tkjos@google.com, Vlastimil Babka <vbabka@suse.cz>, wvw@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190723143456.GE104199@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723060525.GA4552@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723060525.GA4552@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:05:25AM +0200, Michal Hocko wrote:
> [Cc linux-api - please always do CC this list when introducing a user
>  visible API]

Sorry, will do.

> On Mon 22-07-19 17:32:04, Joel Fernandes (Google) wrote:
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > This is quite cumbersome and can be error-prone too. If between
> > accessing the per-PID pagemap and the global page_idle bitmap, if
> > something changes with the page then the information is not accurate.
> > More over looking up PFN from pagemap in Android devices is not
> > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > the PFN.
> > 
> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file. This
> > eliminates the need for userspace to calculate the mapping of the page.
> > It follows the exact same semantics as the global
> > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > where looking up PFN is not needed and also does not require SYS_ADMIN.
> > It ended up simplifying userspace code, solving the security issue
> > mentioned and works quite well. SELinux does not need to be turned off
> > since no pagemap look up is needed.
> > 
> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time.
> > 
> > Documentation material:
> > The idle page tracking API for virtual address indexing using virtual page
> > frame numbers (VFN) is located at /proc/<pid>/page_idle. It is a bitmap
> > that follows the same semantics as /sys/kernel/mm/page_idle/bitmap
> > except that it uses virtual instead of physical frame numbers.
> > 
> > This idle page tracking API can be simpler to use than physical address
> > indexing, since the pagemap for a process does not need to be looked up
> > to mark or read a page's idle bit. It is also more accurate than
> > physical address indexing since in physical address indexing, address
> > space changes can occur between reading the pagemap and reading the
> > bitmap. In virtual address indexing, the process's mmap_sem is held for
> > the duration of the access.
> 
> I didn't get to read the actual code but the overall idea makes sense to
> me. I can see this being useful for userspace memory management (along
> with remote MADV_PAGEOUT, MADV_COLD).

Thanks.

> Normally I would object that a cumbersome nature of the existing
> interface can be hidden in a userspace but I do agree that rowhammer has
> made this one close to unusable for anything but a privileged process.

Agreed, this is one of the primary motivations for the patch as you said.

> I do not think you can make any argument about accuracy because
> the information will never be accurate. Sure the race window is smaller
> in principle but you can hardly say anything about how much or whether
> at all.

Sure, fair enough. That is why I wasn't beating the drum too much on the
accuracy point. However, this surprisingly does work quite well.

thanks,

 - Joel

