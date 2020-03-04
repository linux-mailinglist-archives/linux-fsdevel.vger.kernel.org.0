Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5A178C89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 09:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgCDI0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 03:26:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52812 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDI0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:26:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so897817wmc.2;
        Wed, 04 Mar 2020 00:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to:date
         :from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cew+TTcIlK2By1bAt5CHCB+JbVcMMEPMguJwF68q6nc=;
        b=EkGDq+M902cBO3hGsFctGZEpXVHP36fXlc32Rl6xk16tnjw64LxLDxz/lFLgINWm/Z
         C/yaFDEEmhgPZrTbzxQxuWJgXybNi3qjCD8WeW/5tMCCcxizyM0H/RCPzPEfcPl+IQdU
         Pi75F8tVezaToHcvKCuiy5VrC+9NrUMxtsBwek7s2aVSzYwMEF74j3KcggLoFr1GQEyp
         eZgjsohxI6JBj1BXccjYALKFUFbBoxPWDTnvChlhwUa5Gk4mNW0cMXtbzKB54z/i5FYt
         Wo0h/9JXjsZ4dxpZJC+nkULdUwyZ5ZkJTmv3quOP6BIpWW6bMH7n1MF5GkATpZt/VgNr
         MQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cew+TTcIlK2By1bAt5CHCB+JbVcMMEPMguJwF68q6nc=;
        b=JZyecqF9DsjFsheVmMiWDButvkhMynxq6+dhimaOa0R2cg4nxANLAD7k4jii9q37jk
         8XjQe8NOfxeahrWVLtJ3tS5ugjQtnCdZMa3AJM4HqW1syizM2uNgWgo8RgGC19kn/H+H
         /Gtb8TKbp5j0dPkyJBWheOCH2uuYaT8Uv7tg7rCivIAtPOCgMIHwWm3rbC00FW91qTwq
         E+4VxHRsm1CXqdUgmBoYEjKLUWSW5XOUQxjSCGzEqwiNF3h1oyi+IKRqDsuvoTFTLJmt
         9M/Dhf7s6WXGXPJrI6b/S6hc8sUuO3sK4MVQCUezSB5IIcyGwPERwdBdArPuPkByeJ7E
         cOCQ==
X-Gm-Message-State: ANhLgQ0ZKG+oEyjdIUospA8CSaVLNpRHOpHj8BQ3gNgHX1gUfvNMdmGf
        oLXTRTZAxyha+CFIan8czhs=
X-Google-Smtp-Source: ADFU+vu7adAidQTk9w40n9EY1EUCejzXdBQ6wWbVxorNNvSm/fXI6OMtAlZDLhyHCq1lsHgvoY8Dxg==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr2387419wmf.63.1583310392885;
        Wed, 04 Mar 2020 00:26:32 -0800 (PST)
Received: from dumbo ([83.137.6.114])
        by smtp.gmail.com with ESMTPSA id j14sm38671237wrn.32.2020.03.04.00.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 00:26:32 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:23:27 +0100
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
Subject: [PATCH] hibernate: Allow uswsusp to write to swap
Message-ID: <20200304082327.GA14236@dumbo>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200303190212.GC8037@magnolia>
 <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
 <20200304011840.GD1752567@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304011840.GD1752567@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

It turns out that there is one use case for programs being able to
write to swap devices, and that is the userspace hibernation code.

Quick fix: disable the S_SWAPFILE check if hibernation is configured.

Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reported-by: Marian Klein <mkleinsoft@gmail.com>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 fs/block_dev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/fs/block_dev.c
===================================================================
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2001,7 +2001,8 @@ ssize_t blkdev_write_iter(struct kiocb *
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode))
+	/* uswsusp needs to write to the swap */
+	if (IS_SWAPFILE(bd_inode) && !IS_ENABLED(CONFIG_HIBERNATION))
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
