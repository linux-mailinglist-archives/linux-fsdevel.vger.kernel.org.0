Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD9719B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbfGWNru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 09:47:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34570 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbfGWNrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:47:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so13246582pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y4bJNUBVZG75Wm6fTCb90iILIxIQdsm+YFE3cN2CDj8=;
        b=Zmts+InMHsGjlJGme/8wFfX+TuhCwWTW+otdQ5V8txyciEL0cqRu54oilSH2RbNNAF
         VWdY0Y/WyGvj48CrXvtBZLJzvdZFqixczAL7t2xx2vgMiD6TpktWsVIczAVKZN0pibRE
         X3xgb5a1uRr0Khp6dguCzf7wxkuf0OkwWPAOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y4bJNUBVZG75Wm6fTCb90iILIxIQdsm+YFE3cN2CDj8=;
        b=qGRzMrWEyepMCc+XShfJrQ5bXlEii1NBeXKyK8nrlanQ5jedX+hSz6khfFhY/Uojk/
         Ihmwk7MvvbIHXLcYSwcwSFVDwpxBB8RLpPw3LB+YX4SwI8DCvZ1rx8SveSE5zeJpzGlM
         7OVqGOQ7hHOgb5+8voWawO0bl1EMIFOAqGicjvfEevbk6bZIjXdGbRZM3CuOXEJmI1oo
         jrAPHjThs+GqrfkAE1fierhTmhdFI4KsTYTcwz0jlFNogwsZ9haYNPW0XwPvpLt2hux8
         9nGgyInPZkb9ZKyGZjflTCUXmSdaoCRrZfE6ZdSjlru2WXU7phnRrUbSgiNJ8rYXznJH
         QQTw==
X-Gm-Message-State: APjAAAXUiGjhhXNhN2XmxgoVwQecQWPctyZkb0BLAoYJJvLJXXpYtliR
        xrFTH/vYr+vwpF++tNWV3MY=
X-Google-Smtp-Source: APXvYqy1yaJdw72Q0Nn6ojy3Q+rfO8ub0HIQhJmz+v+fs5k97MSDA2l1FqDyB6T38VJefPW//aW01A==
X-Received: by 2002:a63:20d:: with SMTP id 13mr65441358pgc.253.1563889668469;
        Tue, 23 Jul 2019 06:47:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v126sm11955926pgb.23.2019.07.23.06.47.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:47:47 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:47:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
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
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@google.com,
        minchan@kernel.org, namhyung@google.com, sspatil@google.com,
        surenb@google.com, Thomas Gleixner <tglx@linutronix.de>,
        timmurray@google.com, tkjos@google.com,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190723134746.GB104199@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <01568524-ed97-36c9-61f7-e95084658f5b@yandex-team.ru>
 <8b15dac6-f776-ac9a-8377-ae38f5c9007f@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b15dac6-f776-ac9a-8377-ae38f5c9007f@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:10:05PM +0300, Konstantin Khlebnikov wrote:
> On 23.07.2019 11:43, Konstantin Khlebnikov wrote:
> > On 23.07.2019 0:32, Joel Fernandes (Google) wrote:
> > > The page_idle tracking feature currently requires looking up the pagemap
> > > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > > This is quite cumbersome and can be error-prone too. If between
> > > accessing the per-PID pagemap and the global page_idle bitmap, if
> > > something changes with the page then the information is not accurate.
> > > More over looking up PFN from pagemap in Android devices is not
> > > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > > the PFN.
> > > 
> > > This patch adds support to directly interact with page_idle tracking at
> > > the PID level by introducing a /proc/<pid>/page_idle file. This
> > > eliminates the need for userspace to calculate the mapping of the page.
> > > It follows the exact same semantics as the global
> > > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > > where looking up PFN is not needed and also does not require SYS_ADMIN.
> > > It ended up simplifying userspace code, solving the security issue
> > > mentioned and works quite well. SELinux does not need to be turned off
> > > since no pagemap look up is needed.
> > > 
> > > In Android, we are using this for the heap profiler (heapprofd) which
> > > profiles and pin points code paths which allocates and leaves memory
> > > idle for long periods of time.
> > > 
> > > Documentation material:
> > > The idle page tracking API for virtual address indexing using virtual page
> > > frame numbers (VFN) is located at /proc/<pid>/page_idle. It is a bitmap
> > > that follows the same semantics as /sys/kernel/mm/page_idle/bitmap
> > > except that it uses virtual instead of physical frame numbers.
> > > 
> > > This idle page tracking API can be simpler to use than physical address
> > > indexing, since the pagemap for a process does not need to be looked up
> > > to mark or read a page's idle bit. It is also more accurate than
> > > physical address indexing since in physical address indexing, address
> > > space changes can occur between reading the pagemap and reading the
> > > bitmap. In virtual address indexing, the process's mmap_sem is held for
> > > the duration of the access.
> > 
> > Maybe integrate this into existing interface: /proc/pid/clear_refs and
> > /proc/pid/pagemap ?
> > 
> > I.e.  echo X > /proc/pid/clear_refs clears reference bits in ptes and
> > marks pages idle only for pages mapped in this process.
> > And idle bit in /proc/pid/pagemap tells that page is still idle in this process.
> > This is faster - we don't need to walk whole rmap for that.
> 
> Moreover, this is so cheap so could be counted and shown in smaps.
> Unlike to clearing real access bits this does not disrupt memory reclaimer.
> Killer feature.

I replied to your patch:
https://lore.kernel.org/lkml/20190723134647.GA104199@google.com/T/#med8992e75c32d9c47f95b119d24a43ded36420bc

