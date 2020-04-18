Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1889E1AF388
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDRSlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgDRSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B19C061A0C;
        Sat, 18 Apr 2020 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=SGvFqJlge/g9dh6ag6oSj2PmPKQuD0q8zfCwNpSxj1k=; b=px+muzACVI4ZR8Qma6/M2w08SW
        hySuB9tKA02KzaeL7Bz0hXOlFit5cPmIV408Ey2/X6DSkMu6cgZOGJNeXNArmsoAsUoc5WLXe/hw7
        PUb7y3czjGD9CQNnzOug4xBpyyS7F1rtcwnMYwldVZcEKIxxjt8fEjtiOCtqBiv/YhL1hpiEkcC32
        +Ial0oM3ilDiy7b15NOERaI8soL0uKgf7Q1zCQdIIn1pdo7wE4v1udirhHNffI5G2FWCaDzt7pqmn
        Os3cuV4r/Vol0BRefFeWzgu2YZhyihiwy2DDv2Uyg5GiuU2bN2PxS+V9KP2uy1ZGZchyZTVXk6HhJ
        OTstc49w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsOy-0007rZ-2e; Sat, 18 Apr 2020 18:41:16 +0000
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
Subject: [PATCH 3/9] input: fix empty-body warning in synaptics.c
Date:   Sat, 18 Apr 2020 11:41:05 -0700
Message-Id: <20200418184111.13401-4-rdunlap@infradead.org>
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

Fix gcc empty-body warning when -Wextra is used:

../drivers/input/mouse/synaptics.c: In function ‘synaptics_process_packet’:
../drivers/input/mouse/synaptics.c:1106:6: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
      ;   /* Nothing, treat a pen as a single finger */
      ^

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/input/mouse/synaptics.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20200327.orig/drivers/input/mouse/synaptics.c
+++ linux-next-20200327/drivers/input/mouse/synaptics.c
@@ -20,6 +20,7 @@
  * Trademarks are the property of their respective owners.
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1103,7 +1104,7 @@ static void synaptics_process_packet(str
 				break;
 			case 2:
 				if (SYN_MODEL_PEN(info->model_id))
-					;   /* Nothing, treat a pen as a single finger */
+					do_empty(); /* Nothing, treat a pen as a single finger */
 				break;
 			case 4 ... 15:
 				if (SYN_CAP_PALMDETECT(info->capabilities))
