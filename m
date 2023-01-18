Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A23672A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjARVdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 16:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARVdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:33:42 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6B366A2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2WuvGVVjPfhcIZhsbkz2EarT7sqqS33Y8zjJm+VJ7vM=; b=fe7L45tMENKiRxn7zi4tRhwwlq
        Ka5ppExwaE6DFwx/CqB0+37N0aLfxrGY/yR9SU+3bXUd3gORpegWv9nUm+2xC7bL4vmAzx5/INwtP
        Muh6AjDBr6uaZRUQp5hjyDiAfWKZJcRlsP90J26QDLBymCU0J5DZdzOH28NjQUaoo0Hp253JJ1gJB
        9j3DtqzVyJoKWUQzVFGORlGKXga7hvqMNhnbJxggVrWAK1fcbnDifJY4WSVkls5Oqns7E+mEXLKJb
        kF6HRfCmp8w+gJBHWrYBaHDyf92WPI//I8sS7CAUUG6DlDpar9pHmO6O4wsyehqHizyo0hV2CQBk7
        bElPFxdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIG3o-002cgd-1s;
        Wed, 18 Jan 2023 21:33:32 +0000
Date:   Wed, 18 Jan 2023 21:33:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page v3
Message-ID: <Y8hlrJJZ2uJbZSCv@ZenIV>
References: <20230118173027.294869-1-hch@lst.de>
 <Y8hjWSfC8TVCx5Fe@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hjWSfC8TVCx5Fe@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:23:37PM +0000, Al Viro wrote:
> On Wed, Jan 18, 2023 at 06:30:20PM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series removes most users of the write_one_page API.  These helpers
> > internally call ->writepage which we are gradually removing from the
> > kernel.
> > 
> > Changes since v2:
> >  - more minix error handling fixes
> > 
> > Changes since v1:
> >  - drop the btrfs changes (queue up in the btrfs tree)
> >  - drop the finaly move to jfs (can't be done without the btrfs patches)
> >  - fix the existing minix code to properly propagate errors
> 
> Grabbed.  I'll split that into per-fs branches (and synchronize wrt
> fixes), fold the kmap_local stuff into that and push out.

BTW, do you have the check for minix_delete_entry() failure when called
from minix_rename() anywhere in your tree?  I don't see that in this
series; I'm adding the trivial fix, hopefully that won't end up
creating conflicts...
