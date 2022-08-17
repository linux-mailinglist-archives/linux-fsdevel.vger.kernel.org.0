Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29480597955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiHQVzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiHQVzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:55:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76756A74DB;
        Wed, 17 Aug 2022 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2JWh42nBBT7KEjqKtK1toMHmrJaPfUqyLAJLBY5gBZ8=; b=U+86hu6DEq4M7ldnxT6E2aMkwR
        qfF8RjLR6x+dTlt951HTJuEChS2lirIffUV6nIeTihmT7DIFh8ZPG2USgMPUMK5DB5WUrn7uXAZkL
        NprxGu/HSzKky+pJg51XTToQ6WVsM8BL3I00Rq4Lg0oUpZ++j5PrML7qkO3ReADWFkJYtPvdOKdn1
        ogG+/9Wu8r+pdL7RhcxfqaVMdUxxVGy6qKVLIiZL/IwfwQJtHF0rVbXSjQmYzrh7ec+QUs5BAIpEB
        Hu2lelL5a0H+ojnx+oA51sBO202BRWewKd/8YUP6XcLwuLN7fahR26+WRN3Hb79oYjFqHwsFjc5+L
        q+z6vXgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOR0M-005VPm-Fg;
        Wed, 17 Aug 2022 21:55:14 +0000
Date:   Wed, 17 Aug 2022 22:55:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-nfs@vger.kernel.org
Cc:     Olga Kornievskaia <kolga@netapp.com>, linux-fsdevel@vger.kernel.org
Subject: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Message-ID: <Yv1jwsHVWI+lguAT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	My apologies for having missed that back when the SSC
patchset had been done (and missing the problems after it got
merged, actually).

1) if this
        r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
in __nfs42_ssc_open() yields a directory inode, we are screwed
as soon as it's passed to alloc_file_pseudo() - a *lot* of places
in dcache handling would break if we do that.  It's not too
nice for a regular file from non-cooperating filesystem, but for
directory ones it's deadly.

2) if alloc_file_pseudo() fails there, we get an inode leak.  It
needs an iput() for that case.  As in
        if (IS_ERR(filep)) {
		res = ERR_CAST(filep);
		iput(r_ino);
		goto out_free_name;
	}

But I'd like to point out that alloc_file_pseudo() is not inteded for
use on normal filesystem's inodes - the use here *mostly* works
(directories aside), but...  Use it on filesystem with non-trivial
default dentry_operations and things will get interesting, etc.
