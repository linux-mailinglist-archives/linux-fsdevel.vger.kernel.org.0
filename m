Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47B23AE0FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 00:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFTWpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Jun 2021 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTWpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Jun 2021 18:45:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC472C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Jun 2021 15:43:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lv69Z-00AZac-O1; Sun, 20 Jun 2021 22:42:57 +0000
Date:   Sun, 20 Jun 2021 22:42:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC] what the hell is ->f_mapping->host->i_mapping thing about?
Message-ID: <YM/EcUZqqJ3RRu57@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	In do_dentry_open() we have the following weirdness:

        file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);

What is it about?  How and when can ->f_mapping->host->i_mapping be *NOT*
equal to ->f_mapping?

It came from
commit 1c211088833a27daa4512348bcae9890e8cf92d4
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed May 26 17:35:42 2004 -0700

    [PATCH] Fix the setting of file->f_ra on block-special files
	
    We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
    points at the right thing.  And we need to get it from
    inode->i_mapping->host->i_mapping too, which represents the underlying device.

    Also, don't test for null file->f_mapping in the O_DIRECT checks.

Sure, we need to set ->f_ra after ->open(), since ->f_mapping might be
changed by ->open().  No arguments here - that call should've been moved.
But what the hell has the last bit come from?  What am I missing here?
IDGI...

And that gift keeps giving -
fs/nfs/nfs4file.c:388:  file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
is a copy of that thing.  Equally bogus, AFAICT...
