Return-Path: <linux-fsdevel+bounces-25165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AC9497F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654B8B23B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E2EAD2;
	Tue,  6 Aug 2024 19:04:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8D33118D62B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971076; cv=none; b=W9rHdc2jsr32QME+iavpVkJDN9EYy9fIaPHEmNRq0oxlOo58Ft+0fzYaDLetpBz66R/wlVMJsuUfVg2ChpNTeyJ7gQrRU3qvUlbnnmCCj3voQcKlxt3c7phBUpce7Rs+Ez7ftDB8ejjmXh6xvBT+QIQ4iw8Uv7JdQcOPWON32kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971076; c=relaxed/simple;
	bh=kXnF4Vdg5Vrsb77LBn7YP+mgUEhG4aFshvw+dHS7Y/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPFNoQH6Mi/SJTuKiPcbKttOUu7Ws08cBFWsK5A4Q5wKjijZYDfT5aMRgYFIG5T4/y62++VOcuhRHJuzT0l3MON+wjzOBqa/e0UpkLtax7spbuKiOogk97OIqauOu4YxhU30dkcIiULw/JfAC1Tld2Rrq/QpEZ9dH5eaMp8T+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openwall.com; spf=pass smtp.mailfrom=openwall.com; arc=none smtp.client-ip=193.110.157.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openwall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openwall.com
Received: (qmail 11632 invoked from network); 6 Aug 2024 18:57:47 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 6 Aug 2024 18:57:47 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
	id 0BF31A064E; Tue,  6 Aug 2024 20:57:37 +0200 (CEST)
Date: Tue, 6 Aug 2024 20:57:37 +0200
From: Solar Designer <solar@openwall.com>
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kees Cook <keescook@chromium.org>,
	Thomas Wei??schuh <linux@weissschuh.net>,
	Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <20240806185736.GA29664@openwall.com>
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com> <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
User-Agent: Mutt/1.4.2.3i

On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> sysctl changes for 6.11-rc1
> 
> Summary
> 
> * Remove "->procname == NULL" check when iterating through sysctl table arrays
> 
>     Removing sentinels in ctl_table arrays reduces the build time size and
>     runtime memory consumed by ~64 bytes per array. With all ctl_table
>     sentinels gone, the additional check for ->procname == NULL that worked in
>     tandem with the ARRAY_SIZE to calculate the size of the ctl_table arrays is
>     no longer needed and has been removed. The sysctl register functions now
>     returns an error if a sentinel is used.
> 
> * Preparation patches for sysctl constification
> 
>     Constifying ctl_table structs prevents the modification of proc_handler
>     function pointers as they would reside in .rodata. The ctl_table arguments
>     in sysctl utility functions are const qualified in preparation for a future
>     treewide proc_handler argument constification commit.

As (I assume it was) expected, these changes broke out-of-tree modules.
For LKRG, I am repairing this by adding "#if LINUX_VERSION_CODE >=
KERNEL_VERSION(6,11,0)" checks around the corresponding module changes.
This works.  However, I wonder if it would possibly be better for the
kernel to introduce a corresponding "feature test macro" (or two, for
the two changes above).  I worry that these changes (or some of them)
could get backported to stable/longterm, which with the 6.11+ checks
would unnecessarily break out-of-tree modules again (and again and again
for each backport to a different kernel branch).  Feature test macro(s)
would avoid such further breakage, as they would (be supposed to be)
included along with the backports.

Joel, Linus, or anyone else - what do you think?  And in general, would
it be a good practice for Linux to be providing feature test macros to
indicate this sort of changes?  Is there a naming convention for them?

For omitting the ctl_table array sentinel elements, it is now possible
to check whether register_sysctl() is a function or a macro.  I've
tested the below and it works:

+++ b/src/modules/comm_channel/p_comm_channel.c
@@ -332,7 +332,14 @@ struct ctl_table p_lkrg_sysctl_table[] = {
       .extra1         = &p_profile_enforce_min,
       .extra2         = &p_profile_enforce_max,
    },
+/*
+ * Empty element at the end of array was required when register_sysctl() was a
+ * function.  It's no longer required when it became a macro in 2023, and it's
+ * disallowed after further changes in 2024.
+ */
+#ifndef register_sysctl
    { }
+#endif
 };

But it's a hack, which I'm unhappy about.

So instead of a macro indicating that the "Remove "->procname == NULL"
check when iterating through sysctl table arrays" change is in place, we
could have one that indicates that the sentinel elements are no longer
required (and no need for one indicating that they're no longer allowed,
then).  Something like LINUX_SYSCTL_NO_SENTINELS.  This could even be
backported to kernels that do not have the "Remove "->procname == NULL"
check" commit, if they do have last year's removal of the requirement.

Alternatively, maybe "Remove "->procname == NULL" check when iterating
through sysctl table arrays" should be reverted.  I can see how it's
useful as a policy check for the kernel itself, so no space is
inadvertently wasted on a sentinel element anywhere in the kernel tree,
but maybe it isn't worth enforcing this for out-of-tree modules.  The
impact of an extra element (if allowed) is negligible, whereas the
impact of not having it on an older kernel is really bad.  I worry that
some out-of-tree modules would be adapted or written for the new
convention without a 6.11+ check, yet someone would also build and use
them on pre-6.11.  There's no compile-time failure from omitting the
sentinel element on a kernel where it was needed, and there isn't a
_reliable_ runtime failure either.

The other macro could be called LINUX_SYSCTL_TABLE_CONST, although I'm
not sure whether it should apply only to the "ctl_table arguments in
sysctl utility functions" (the change so far) or also to "Constifying
ctl_table structs" (a near future change, right?)

Alexander

