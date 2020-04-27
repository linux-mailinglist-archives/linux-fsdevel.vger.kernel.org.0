Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C931BAFC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD0Uu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgD0Uu4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:50:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790922070B;
        Mon, 27 Apr 2020 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588020654;
        bh=b3YRJyMbKe7izlxJnUJUG6JvHA8qd5m0P2WdjuVvShg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0rVVju/c1Zvmjo3N8tWUk8YTpm4HfugQ2PagUwbyF8N9miLcZpw7ThT96un3xYH7
         LPD1ypHkar7D4beD3Cg36iQfmv7EqFTQBXo/zxHwrfBoB2Ie2OQdef1JQxDKFbxrz7
         2S+fn1pY3qWnNxGO+FZXtkPTwcphzXfeXLX0Hrdw=
Date:   Mon, 27 Apr 2020 13:50:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Minchan Kim <minchan@kernel.org>
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
Message-Id: <20200427135053.a125f84c62e2857e3dcdce4f@linux-foundation.org>
In-Reply-To: <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
        <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
        <39bcdbb6-cac8-aa3b-c543-041f9c28c730@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 26 Apr 2020 15:48:35 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/26/20 10:26 AM, Randy Dunlap wrote:
> > On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
> >> The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
> >>
> >>    http://www.ozlabs.org/~akpm/mmotm/
> >>
> >> mmotm-readme.txt says
> >>
> >> README for mm-of-the-moment:
> >>
> >> http://www.ozlabs.org/~akpm/mmotm/
> >>
> >> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> >> more than once a week.
> >>
> >> You will need quilt to apply these patches to the latest Linus release (5.x
> >> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> >> http://ozlabs.org/~akpm/mmotm/series
> >>
> >> The file broken-out.tar.gz contains two datestamp files: .DATE and
> >> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> >> followed by the base kernel version against which this patch series is to
> >> be applied.
> > 
> > Hi,
> > I'm seeing lots of build failures in mm/madvise.c.
> > 
> > Is Minchin's patch only partially applied or is it just missing some pieces?
> > 
> > a.  mm/madvise.c needs to #include <linux/uio.h>
> > 
> > b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
> > has not been updated:
> > 
> > In file included from ../mm/madvise.c:11:0:
> > ../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
> >   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
> >                   ^
> > ../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
> >   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >   ^~~~~~~~~~~~~~~~~
> > ../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
> >  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
> >                                     ^~~~~~~~~~~~~~~
> > ../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
> >  SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> >  ^~~~~~~~~~~~~~~
> > In file included from ../mm/madvise.c:11:0:
> > ../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
> >  asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
> >                  ^~~~~~~~~~~~~~~~~~~
> 
> I had to add 2 small patches to have clean madvise.c builds:
> 

hm, not sure why these weren't noticed sooner, thanks.

This patchset is looking a bit tired now.

Things to be addressed (might be out of date):

- http://lkml.kernel.org/r/293bcd25-934f-dd57-3314-bbcf00833e51@redhat.com

- http://lkml.kernel.org/r/2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz
  (I did this)

- http://lkml.kernel.org/r/20200310222008.GB72963@google.com

- issues arising from the review of
  http://lkml.kernel.org/r/20200302193630.68771-8-minchan@kernel.org




