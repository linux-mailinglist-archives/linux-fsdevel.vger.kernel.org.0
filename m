Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB121EB5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 10:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgGNIaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNIaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:30:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE8C061755;
        Tue, 14 Jul 2020 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J+0osK+Fxg+72fGn0wO7G+VSVT9u39niv0zQodGewxA=; b=GGFZ/32ztn1yvRwa28bhdMwZlc
        qWlF3sGTc2CTy9vUmQ+NIs3pHRCdsTz/Khl28pOpmNq8DpsBys6DI54/F79jBOAnaFs6R8zpVR4vI
        Kspqwp7LX0fz8DJaj0tZuKspeQFVvn+ivL7Yya1UCNCcr/oo2ffsAoWAzU8n2JASWhtCgr0oA4P7k
        Q12H534IzTd43L9pRUnQ8lOOSwZHndFvHxKb56fdl78UAzZ7xK2GZ2BBuN5waqJuN6o19fDCYcuvp
        jLgEDBNgUUvE92EWafVAh0R2BfUpw+07yXA1eM6nuf98/f+AgCO8koDjWmeTinvvX9889dJvOzJPW
        J7/GOjEw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvGK8-0008DC-8v; Tue, 14 Jul 2020 08:30:00 +0000
Date:   Tue, 14 Jul 2020 09:30:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Dave Chinner <david@fromorbit.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200714083000.GA31189@infradead.org>
References: <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <0404aff7-a1d9-c054-f709-521458d7901d@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0404aff7-a1d9-c054-f709-521458d7901d@sandeen.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:45:19PM -0700, Eric Sandeen wrote:
> I wandered back into this thread for some reason ... ;)
> 
> Since iversion/noiversion is /already/ advertised as a vfs-level mount option,
> wouldn't exposing it in /proc/mounts solve the original problem here?
> 
> ("i_version" is wrong, because it's ext4-specific, but "iversion" is handled
> by the vfs, so it's meaningful for any filesystems, and it will also trivially
> allow mount(2) to preserve it across remounts for all filesystems that set it by
> default.)
> 
> Seems like that's the fastest path to fixing the current problems, even if a
> long-term goal may be to deprecate it altogether.

But they should not be exposed as a mount option.  E.g. for XFS we
decide internally if we have a useful i_version or not, totally
independent of the mount option that leaked into the VFS.  So we'll
need to fix how the flag is used before doing any new work in this area.
