Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8189A2985BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 04:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420581AbgJZDCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 23:02:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56864 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389589AbgJZDCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 23:02:39 -0400
X-Greylist: delayed 1591 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 23:02:38 EDT
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWsMZ-008uQf-1v; Mon, 26 Oct 2020 02:35:59 +0000
Date:   Mon, 26 Oct 2020 02:35:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: Re: [vfs:work.epoll 17/27] fs/eventpoll.c:1629:3: warning:
 Assignment of function parameter has no effect outside the function. Did you
 forget dereferencing
Message-ID: <20201026023559.GC3576660@ZenIV.linux.org.uk>
References: <202010261043.dPTrCpUD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010261043.dPTrCpUD-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:09:47AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
> head:   319c15174757aaedacc89a6e55c965416f130e64
> commit: ff07952aeda8563d5080da3a0754db83ed0650f6 [17/27] ep_send_events_proc(): fold into the caller
> compiler: h8300-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "cppcheck warnings: (new ones prefixed by >>)"
> >> fs/eventpoll.c:1629:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
>      events++;
>      ^

Who the hell has come up with that warning?  What happens is,
essentially,

f(..., events, ....)
	loop in which we have
		g(events, something); // store the next sample
		events++;

More specifically, it's 
>   1620			if (__put_user(revents, &events->events) ||
>   1621			    __put_user(epi->event.data, &events->data)) {
>   1622				list_add(&epi->rdllink, &txlist);
>   1623				ep_pm_stay_awake(epi);
>   1624				if (!res)
>   1625					res = -EFAULT;
>   1626				break;
>   1627			}
>   1628			res++;
> > 1629			events++;

If anything, that should be reported to the maintainers of the buggy code.
Which is not the kernel in this case.

Google search on that thing brings this:

	Cppcheck is an analysis tool for C/C++ code. It detects the types of
bugs that the compilers normally fail to detect. The goal is no false positives.

IOW, that should be reported to the authors of that thing, seeing that
their stated goal is obviously missed in this case.  Badly.  Assignments of
function parameters can be perfectly idiomatic and this case is such.
