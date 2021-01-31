Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F879309F3C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhAaW2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 17:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhAaW0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:26:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D4C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jan 2021 14:25:14 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id g69so16773944oib.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jan 2021 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1oyh2Jl0O/ZU/LP8p6NNf64XKYZ9MwxKvx3m6+kfJws=;
        b=BgTPexMcvFeDXCXADIDgup2fVqFmWou10We/CXGZrPC6KX/rpVGm9CWNA6ji+Y4OVX
         zG41Y/63LOpg6TKEperreR0cO4xh7w4Lb2HdciHqqgsx7Z2CnK084xUFNH6+tM0V0qUS
         +oUhT8s22PtxCBl7ZuqYXtcQLanvaoPJtqejwuU3xObZ1iwfsaHQ1YrfAmOH86maMC2Y
         5yyLiuPPL1VuhS0Mznqf/OyOgopcHnJRGRlieX7uupUn+08H3ypnFIxX9cCEkP3ZJyii
         rqXQt3K4C2z80nb8IjhZiKADaIBE0Djg+LX7aUxDiFbMMMBlrEzlCJ9/Fsb72pRSTG+O
         PsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1oyh2Jl0O/ZU/LP8p6NNf64XKYZ9MwxKvx3m6+kfJws=;
        b=HugRRgYedbVNB/tBspYIyMFunYEJRlFA6LlsDF5ghoa50d9KOQRERflcfgZEE73YvW
         kFrLWAg+kCK8BttpxzOVaVhKP4jV3870/l1lBWAkrG8pkkN16b/M8DqupCNeq2YdialB
         E31adbCdB/DYoYEa26CGOsX8E+5cVAT1SJaPPr9XgzY2QtmRouAzQG/D5eGK47Axjlki
         dD0j+P4eXcdIishHawoy0Oxahs34sOlhUsC8JKZ8ZcBpTY2ETQ1tCxpcbALiCyx0nFEg
         hgNRx4Hm0//aEnuMLaLjTlEjdn7/1XmJRnxxfiyZPNHY9aDvHRaiV353c/UESG7a2lkw
         gcdg==
X-Gm-Message-State: AOAM5328P/g/AW3VtWp0glj9sCopJhqDstLLiRXARnKOerwg25sdsxLN
        aHlzQVnE5IP9qNPSmOGjSctoSrzaZsBnPd8qgaiuIedEL4oo8Wzd
X-Google-Smtp-Source: ABdhPJwUrU/D/ml0qX5wsfqukkyaf5x9UfMoTl+BJ3ttgzb1mJNBsfF8VtpIttI2flnBxrutbsX868iKEWvcWwuRPV8=
X-Received: by 2002:aca:110b:: with SMTP id 11mr8864338oir.174.1612131913435;
 Sun, 31 Jan 2021 14:25:13 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sun, 31 Jan 2021 17:25:02 -0500
Message-ID: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
Subject: [RFC PATCH] implement orangefs_readahead
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few weeks ago Matthew Wilcox helped me see how
mm/readahead.c/read_pages was dropping down into
some code designed to take over for filesystems
that didn't implement ->readahead, and how this "failover"
code was screwing over the readahead-like code I'd put
into orangefs_readpage.

I studied a bunch of readahead code in fs and mm and other
filesystems and came up with this patch that seems to work
in the tests I've done so far. Sometimes code I like is
instead irritating to Linus or Al Viro :-), so hopefully some
of y'all will look over what I've got here. There's a
couple of printk's I've left in orangefs_readpage that don't
belong upstream, they help me now for testing though...
Besides the diff at the end of this message, the code is
in: https://github.com/hubcapsc/linux/tree/readahead

I wish I knew how to specify _nr_pages in the readahead_control
structure so that all the extra pages I need could be obtained
in readahead_page instead of part there and the rest in my
open-coded stuff in orangefs_readpage. But it looks to me as
if values in the readahead_control structure are set heuristically
outside of my control over in ondemand_readahead?

[root@vm3 linux]# git diff master..readahead
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850..682a968cb82a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,6 +244,25 @@ static int orangefs_writepages(struct
address_space *mapping,

 static int orangefs_launder_page(struct page *);

+/*
+ * Prefill the page cache with some pages that we're probably
+ * about to need...
+ */
+static void orangefs_readahead(struct readahead_control *rac)
+{
+       pgoff_t index = readahead_index(rac);
+       struct page *page;
+
+       while ((page = readahead_page(rac))) {
+               prefetchw(&page->flags);
+               put_page(page);
+               unlock_page(page);
+               index++;
+       }
+
+       return;
+}
+
 static int orangefs_readpage(struct file *file, struct page *page)
 {
        struct inode *inode = page->mapping->host;
@@ -260,11 +279,16 @@ static int orangefs_readpage(struct file *file,
struct page *page)
        int remaining;

        /*
-        * Get up to this many bytes from Orangefs at a time and try
-        * to fill them into the page cache at once. Tests with dd made
-        * this seem like a reasonable static number, if there was
-        * interest perhaps this number could be made setable through
-        * sysfs...
+        * Orangefs isn't a good fit for reading files one page at
+        * a time. Get up to "read_size" bytes from Orangefs at a time and
+        * try to fill them into the page cache at once. Readahead code in
+        * mm already got us some extra pages by calling orangefs_readahead,
+        * but it doesn't know how many we actually wanted, so we'll
+        * get some more after we use up the extra ones we got from
+        * orangefs_readahead. Tests with dd made "read_size" seem
+        * like a reasonable static number of bytes to get from orangefs,
+        * if there was interest perhaps "read_size" could be made
+        * setable through sysfs or something...
         */
        read_size = 524288;

@@ -302,31 +326,19 @@ static int orangefs_readpage(struct file *file,
struct page *page)
                slot_index = 0;
                while ((remaining - PAGE_SIZE) >= PAGE_SIZE) {
                        remaining -= PAGE_SIZE;
-                       /*
-                        * It is an optimization to try and fill more than one
-                        * page... by now we've already gotten the single
-                        * page we were after, if stuff doesn't seem to
-                        * be going our way at this point just return
-                        * and hope for the best.
-                        *
-                        * If we look for pages and they're already there is
-                        * one reason to give up, and if they're not there
-                        * and we can't create them is another reason.
-                        */

                        index++;
                        slot_index++;
-                       next_page = find_get_page(inode->i_mapping, index);
+                       next_page = find_lock_page(inode->i_mapping, index);
                        if (next_page) {
-                               gossip_debug(GOSSIP_FILE_DEBUG,
-                                       "%s: found next page, quitting\n",
-                                       __func__);
-                               put_page(next_page);
-                               goto out;
+                               printk("%s: found readahead page\n", __func__);
+                       } else {
+                               next_page =
+                                       find_or_create_page(inode->i_mapping,
+                                                               index,
+                                                               GFP_KERNEL);
+                               printk("%s: alloced my own page\n", __func__);
                        }
-                       next_page = find_or_create_page(inode->i_mapping,
-                                                       index,
-                                                       GFP_KERNEL);
                        /*
                         * I've never hit this, leave it as a printk for
                         * now so it will be obvious.
@@ -659,6 +671,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 /** ORANGEFS2 implementation of address space operations */
 static const struct address_space_operations orangefs_address_operations = {
        .writepage = orangefs_writepage,
+       .readahead = orangefs_readahead,
        .readpage = orangefs_readpage,
        .writepages = orangefs_writepages,
        .set_page_dirty = __set_page_dirty_nobuffers,
diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 74a3d6337ef4..cd7297815f91 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -31,7 +31,7 @@ static ulong module_parm_debug_mask;
 __u64 orangefs_gossip_debug_mask;
 int op_timeout_secs = ORANGEFS_DEFAULT_OP_TIMEOUT_SECS;
 int slot_timeout_secs = ORANGEFS_DEFAULT_SLOT_TIMEOUT_SECS;
-int orangefs_cache_timeout_msecs = 50;
+int orangefs_cache_timeout_msecs = 500;
 int orangefs_dcache_timeout_msecs = 50;
 int orangefs_getattr_timeout_msecs = 50;
