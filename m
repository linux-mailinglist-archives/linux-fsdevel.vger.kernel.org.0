Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142F13FD45B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhIAHWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbhIAHWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:22:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8F0C061575;
        Wed,  1 Sep 2021 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lc17SoGeHMPTwzG9UqBo7b/uRedgJVdZcuMDmdo1GPY=; b=pjipg5YvXPbY+yZUIhU9oHqA44
        4MalxhjZ2SS+OKHxo2aveAICM9LTOcm4142w4c30rtCKyKG+A7owPY/VeQBvquBl/TfQ8ea9emyGn
        7uwz/H8lJGKIP12pKgmO9th+8so2ZmcwPUUHev1N3walCATnee9iWznlRJfidW0+eva/Wbqy3SYyl
        RBVBoWhZyji+RNzdnM4ZTlFciO7qBZXxSxEhUr1GeSLvIXWj9GD2NGFSTVuy+Ssdp8nibATafXiqC
        EWBDphWlCKmAVQbDVx52kyq9DCmTYOMwqC5bgi3kJ2KBB11KrxT1zajcCZlIrwa1aMbQfRsf7PLDC
        zHOfWBdw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLKXW-001z9l-Ul; Wed, 01 Sep 2021 07:20:18 +0000
Date:   Wed, 1 Sep 2021 08:20:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <YS8ppl6SYsCC0cql@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org>
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163038594541.7591.11109978693705593957@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 02:59:05PM +1000, NeilBrown wrote:
> Making the change purely in btrfs is simply not possible.  There is no
> way for btrfs to provide nfsd with a different inode number.  To move
> the bulk of the change into btrfs code we would need - at the very least
> - some way for nfsd to provide the filehandle when requesting stat
> information.  We would also need to provide a reference filehandle when
> requesting a dentry->filehandle conversion.  Cluttering the
> export_operations like that just for btrfs doesn't seem like the right
> balance.  I agree that cluttering kstat is not ideal, but it was a case
> of choosing the minimum change for the maximum effect.

So you're papering over a btrfs bug by piling up cludges in the nsdd
code that has not business even knowing about this btrfs bug, while
leaving other users of inodes numbers and file handles broken?

If you only care about file handles:  this is what the export operations
are for.  If you care about inode numbers:  well, it is up to btrfs
to generate uniqueue inode numbers.  It currently doesn't do that, and
no amount of papering over that in nfsd is going to fix the issue.

If XORing a little more entropy into the inode number is a good enough
band aid (and I strongly disagree with that), do it inside btrfs for
every place they report the inode number.  There is nothing NFS-specific
about that.
