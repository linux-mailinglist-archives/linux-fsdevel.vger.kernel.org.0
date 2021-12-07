Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787F46BC4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhLGNVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhLGNVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:21:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F19C061574;
        Tue,  7 Dec 2021 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KNt00b+X/O/eyE0M0uiBvOXE1rZ5vTZToKRi5+eUtTM=; b=QeGj4Ie2hjZx6TNAs1n6xaBULG
        RbrCxXRJZKbLmwSwJ8qoZZLkfxhd8b3D+d2ALM46wHALGWz/PlcuZejY3HA89jDBOx3w8yBSt6PKv
        rpWgyHmaMmBETDg2I4HXOsHwW0RK/FT95i4c5pORK/o9q8aIiADVbeg8eyON1ASEFC6WU+KIArqkq
        jbXhsC0ivzjG5Ii+HFa4xD4f+Hm8DchjwrS1Dd6ea13rxMSOau87u2j1AcCM/A3yGO8NyxhESWmp0
        OrKDcLNoEXILp1Ypd0W6eMwMDLINo9n4OQzzTxv5OtesTRtjEO5GaXjHZ6oszMJvnrhGRFhzNhygr
        JaW6JarQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muaLl-007Msw-5u; Tue, 07 Dec 2021 13:17:41 +0000
Date:   Tue, 7 Dec 2021 13:17:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fs/dcache: prevent repeated locking
Message-ID: <Ya9e9XlMPUyQUvxp@casper.infradead.org>
References: <20211207101646.401982-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207101646.401982-1-lv.ruyi@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:16:46AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Move the spin_lock above the restart to prevent to lock twice 
> when the code goto restart.

This is madness.

void d_prune_aliases(struct inode *inode)
        spin_lock(&inode->i_lock);
                        if (likely(!dentry->d_lockref.count)) {
                                __dentry_kill(dentry);
                                goto restart;
...
static void __dentry_kill(struct dentry *dentry)
        if (dentry->d_inode)
                dentry_unlink_inode(dentry);
...
static void dentry_unlink_inode(struct dentry * dentry)
        spin_unlock(&inode->i_lock);

Did you even test this patch?
