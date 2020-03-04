Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548B3179649
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgCDRGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:06:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52685 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgCDRGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:06:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2981079wmc.2;
        Wed, 04 Mar 2020 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eAvOIF6AGY3vlZ1kzI6VwMQbeJQz/suMmkKBmXk6J8Y=;
        b=UzWuKWhwSTJKSKcktovi82mOWChrc/f0KtLo4X5rUYd9T9r93VZEsjULHytd8lrxv5
         YIjTecmQzPuwr7GMOVXPUDzk7lTvc126GlJ12boC1Sz8lUEzTYLgcL4e4+ZzBgZnaXgV
         yJnsaPX9X5VH511KEtLXIvytDFOzksJdNlA9OVlQIJHT1qYZpqldWsMilzD7CoLwojYe
         dUPg13pM6AO6vwLFYzO4RMgsvkXMOQwQ7VjuWB5iu3uobCoFQICIbneHO+1KAYyyzoAT
         rs+eqJyYPk72BAxEhnWCrgwDElzuYrpfn0wpJMW+tKXYEHArAEXOCq/oElUgKrHDfO1x
         49+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eAvOIF6AGY3vlZ1kzI6VwMQbeJQz/suMmkKBmXk6J8Y=;
        b=kCRGx/qbvGHvOIExprw0DDgkP+eOmEhGn+Aq946pDkC+5ITaDABqXsREVseqztX9bj
         imCTr/cd3ElcID1uCdt9MhKJkePYFyHBcGR0uYm9vtAGCVSYCIR5A8uTk6Tfh3DNfiyI
         n1q05AtsU523nCq8bRaRxpUdcQ2KlwJaA8k/YJftyN/tzQ4CnA1PWtLu6XIv1j0n45Jn
         BG6FxGm6e1n4PUG3G/6yNmsTnvHby5DuF2e7fcvay4kpaKC5XvH9+3fY6Vsf2NkDZVZ1
         CQY5OlNqDLJxlS1t71GsB64Ah4WWZ7oBkAQ3q7NyGGrRBuUvlMJI/6WZ1+R0erHK7U0B
         k2KQ==
X-Gm-Message-State: ANhLgQ10xC8+0hoqQtyHTo3rg3tLU5Lz5s6NqdtfvnMzIX3D2WC9qxyO
        Cav+OHza28a77rtmWqiMeM0=
X-Google-Smtp-Source: ADFU+vs1u9SfcjF5RGIglTQpijbTZfS8yfBBuwrm2uVF6l/ojNbTblWiBQyIEcYPkcSSRfs4nBBHBQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr4622479wmb.16.1583341611386;
        Wed, 04 Mar 2020 09:06:51 -0800 (PST)
Received: from dumbo ([83.137.6.114])
        by smtp.gmail.com with ESMTPSA id o8sm4841231wmh.15.2020.03.04.09.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:06:50 -0800 (PST)
Date:   Wed, 4 Mar 2020 18:06:46 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] hibernate: Allow uswsusp to write to swap
Message-ID: <20200304170646.GA31552@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

It turns out that there is one use case for programs being able to
write to swap devices, and that is the userspace hibernation code.

Quick fix: disable the S_SWAPFILE check if hibernation is configured.

Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reported-by: Marian Klein <mkleinsoft@gmail.com>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

v2:
 - use hibernation_available() instead of IS_ENABLED(CONFIG_HIBERNATE)
 - make Fixes: point to the right commit

---
 fs/block_dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/fs/block_dev.c
===================================================================
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode))
+	/* uswsusp needs write permission to the swap */
+	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
