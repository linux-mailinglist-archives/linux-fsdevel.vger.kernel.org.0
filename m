Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4F45C791
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356850AbhKXOjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 09:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356551AbhKXOjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:39:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5AC1F38B7;
        Wed, 24 Nov 2021 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5Bp6Rfma9GvNlchoY1NvLTwJANeJ3HEug26+8isXwE=; b=hhbQZhJwK1Tb9e+q0Q28e25DAv
        Od9pIYN2Gyiv0dA95pkKXYVes6wIzr6Dyrdz7zE6LWYwQgtKQRddQQj3KlF/6e+rGlvDwZn81SO0L
        jmyNcKHUwuAAL4hqFxxBoCLbZ78/8YU9GtUBk2390mHdprFJB6Q5NEsOuCM+WqTROXedt17OSU57K
        Znwqwh32TO/nbgJf5ps0iEH4WpPxtncH2AfxYxaIDPl/mI7K7oszTaCg2ZYrE3yeotZ03DTuOQM8q
        SbFyM9HClWrBqJvP/vIs76mbieTIOeBHp8+RY1gteGkIKaIRwSzmIllOlYTn9YYs66Or0n5wDgTmB
        pHDv3JGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpsWA-004tSi-D1; Wed, 24 Nov 2021 13:40:58 +0000
Date:   Wed, 24 Nov 2021 05:40:58 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, benh@kernel.crashing.org, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        amir73il@gmail.com, phil@philpotter.co.uk, viro@zeniv.linux.org.uk,
        julia.lawall@inria.fr, ocfs2-devel@oss.oracle.com,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] inotify: simplify subdirectory registration with
 register_sysctl()
Message-ID: <YZ5A6iWLb0h3N3RC@bombadil.infradead.org>
References: <20211123202422.819032-1-mcgrof@kernel.org>
 <20211123202422.819032-7-mcgrof@kernel.org>
 <20211124094409.GF8583@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124094409.GF8583@quack2.suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:44:09AM +0100, Jan Kara wrote:
> On Tue 23-11-21 12:24:20, Luis Chamberlain wrote:
> > From: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > There is no need to user boiler plate code to specify a set of base
> > directories we're going to stuff sysctls under. Simplify this by using
> > register_sysctl() and specifying the directory path directly.
> > 
> > Move inotify_user sysctl to inotify_user.c while at it to remove clutter
> > from kernel/sysctl.c.
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > [mcgrof: update commit log to reflect new path we decided to take]
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> This looks fishy. You register inotify_table but not fanotify_table and
> remove both...

Indeed, the following was missing, I'll roll it in:

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 559bc1e9926d..a35693eb1f36 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -59,7 +59,7 @@ static int fanotify_max_queued_events __read_mostly;
 static long ft_zero = 0;
 static long ft_int_max = INT_MAX;
 
-struct ctl_table fanotify_table[] = {
+static struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
@@ -88,6 +88,13 @@ struct ctl_table fanotify_table[] = {
 	},
 	{ }
 };
+
+static void __init fanotify_sysctls_init(void)
+{
+	register_sysctl("fs/fanotify", fanotify_table);
+}
+#else
+#define fanotify_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
 /*
@@ -1685,6 +1692,7 @@ static int __init fanotify_user_setup(void)
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
 					FANOTIFY_DEFAULT_MAX_GROUPS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS] = max_marks;
+	fanotify_sysctls_init();
 
 	return 0;
 }
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 616af2ea20f3..556cc63c88ee 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -5,8 +5,6 @@
 #include <linux/sysctl.h>
 #include <uapi/linux/fanotify.h>
 
-extern struct ctl_table fanotify_table[]; /* for sysctl */
-
 #define FAN_GROUP_FLAG(group, flag) \
 	((group)->fanotify_data.flags & (flag))
 
