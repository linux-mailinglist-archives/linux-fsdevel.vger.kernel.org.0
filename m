Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A503D4A5326
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiAaXXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 18:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAaXXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:23:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5FAC061714;
        Mon, 31 Jan 2022 15:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC36260B74;
        Mon, 31 Jan 2022 23:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BEC340E8;
        Mon, 31 Jan 2022 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643671421;
        bh=lqSX0aoQIGN96BLzSundbxGHzVX1dMX9SwLuAAeQx6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yzOivcZb1NBXcGG4WBvrbyiZDztKZxmkAVRwqz8kuA3d9PxoavglnZLUSsjFaxnhj
         322Ykf0iYN5a8Zw1lk1PYzMuFugPz2L4gHRUKX2YDaVl0T2vRgZDTizZjmCJvTK2Sx
         dMz0IoghaJLdiRRhqENw66mbks//HIw+jWz1yE6w=
Date:   Mon, 31 Jan 2022 15:23:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        yzaikin@google.com, mcgrof@kernel.org
Subject: Re: [PATCH v2] mm: move page-writeback sysctls to is own file
Message-Id: <20220131152340.98e6bb584df772875f48f184@linux-foundation.org>
In-Reply-To: <20220129012955.26594-1-zhanglianjie@uniontech.com>
References: <20220129012955.26594-1-zhanglianjie@uniontech.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 29 Jan 2022 09:29:55 +0800 zhanglianjie <zhanglianjie@uniontech.com> wrote:

> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> So move the page-writeback sysctls to its own file.
> 
> ...
>
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -70,30 +70,33 @@ static long ratelimit_pages = 32;
>  /*
>   * Start background writeback (via writeback threads) at this percentage
>   */
> -int dirty_background_ratio = 10;
> +static int dirty_background_ratio = 10;

These conversions will generate warnings when CONFIG_SYSCTL=n.

mm/page-writeback.c:2002:12: warning: 'dirty_writeback_centisecs_handler' defined but not used [-Wunused-function]
 2002 | static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/page-writeback.c:545:12: warning: 'dirty_bytes_handler' defined but not used [-Wunused-function]
  545 | static int dirty_bytes_handler(struct ctl_table *table, int write,
      |            ^~~~~~~~~~~~~~~~~~~
mm/page-writeback.c:531:12: warning: 'dirty_ratio_handler' defined but not used [-Wunused-function]
  531 | static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
      |            ^~~~~~~~~~~~~~~~~~~
mm/page-writeback.c:520:12: warning: 'dirty_background_bytes_handler' defined but not used [-Wunused-function]
  520 | static int dirty_background_bytes_handler(struct ctl_table *table, int write,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/page-writeback.c:509:12: warning: 'dirty_background_ratio_handler' defined but not used [-Wunused-function]
  509 | static int dirty_background_ratio_handler(struct ctl_table *table, int write,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-move-page-writeback-sysctls-to-is-own-file-fix

fix CONFIG_SYSCTL=n warnings

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: zhanglianjie <zhanglianjie@uniontech.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page-writeback.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/page-writeback.c~mm-move-page-writeback-sysctls-to-is-own-file-fix
+++ a/mm/page-writeback.c
@@ -506,6 +506,7 @@ bool node_dirty_ok(struct pglist_data *p
 	return nr_pages <= limit;
 }
 
+#ifdef CONFIG_SYSCTL
 static int dirty_background_ratio_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -555,6 +556,7 @@ static int dirty_bytes_handler(struct ct
 	}
 	return ret;
 }
+#endif
 
 static unsigned long wp_next_time(unsigned long cur_time)
 {
@@ -1996,6 +1998,7 @@ bool wb_over_bg_thresh(struct bdi_writeb
 	return false;
 }
 
+#ifdef CONFIG_SYSCTL
 /*
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
@@ -2020,6 +2023,7 @@ static int dirty_writeback_centisecs_han
 
 	return ret;
 }
+#endif
 
 void laptop_mode_timer_fn(struct timer_list *t)
 {
_

