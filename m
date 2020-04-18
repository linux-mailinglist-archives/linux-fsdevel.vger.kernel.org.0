Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5051AF384
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgDRSlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87487C061A0F;
        Sat, 18 Apr 2020 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=g1ONOf6MGj3aToaUeBLhJbF3d+tY5CMeHHoXTtmPNsE=; b=RZ4Q2VGMoE1Bka/a+kMpugnl6V
        WMVry8MWAMKA0AfBSRZP5GbN9pJJeG4gjR6sud7qBmDPy8K3i6BprqmwPWH5lOuW2gqRr/Z6Cm0gD
        LgdYYpcS7u+9zN1adQU6TRExKq4DBbaLs/fZ8BFQwxY4cbSn3IER0BNxv3UJFdqify3T+1KdTD2Qi
        vrHfuHPH4Z0QFf2MXKCGJ5k6d3bNzMgrjkWWTemljZSz/KV2Pcv1AoZFf0+EUry4IuzRrudoMMT/C
        ei8L5wfK4u7V/ulhuTnRRFf6mMeS0g5tdTHkmzzebQf9iIBlwwM0f/XqpVSnBSOE3/pCfTfbCtZ3f
        SvwQIVLw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsOw-0007rZ-8d; Sat, 18 Apr 2020 18:41:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: [RFC PATCH 1/9] kernel.h: add do_empty() macro
Date:   Sat, 18 Apr 2020 11:41:03 -0700
Message-Id: <20200418184111.13401-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the do_empty() macro to silence gcc warnings about an empty body
following an "if" statement when -Wextra is used.

However, for debug printk calls that are being disabled, use either
no_printk() or pr_debug() [and optionally dynamic printk debugging]
instead.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: Zzy Wysm <zzy@zzywysm.com>
---
 include/linux/kernel.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20200327.orig/include/linux/kernel.h
+++ linux-next-20200327/include/linux/kernel.h
@@ -40,6 +40,14 @@
 #define READ			0
 #define WRITE			1
 
+/*
+ * When using -Wextra, an "if" statement followed by an empty block
+ * (containing only a ';'), produces a warning from gcc:
+ * warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
+ * Replace the empty body with do_empty() to silence this warning.
+ */
+#define do_empty()		do { } while (0)
+
 /**
  * ARRAY_SIZE - get the number of elements in array @arr
  * @arr: array to be sized
