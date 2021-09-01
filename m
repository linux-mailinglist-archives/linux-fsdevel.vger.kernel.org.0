Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703C23FDE85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbhIAPXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIAPXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:23:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136BBC061575;
        Wed,  1 Sep 2021 08:22:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DE22E35BB; Wed,  1 Sep 2021 11:22:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DE22E35BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630509771;
        bh=o/wgkqf+HNM4jw0xc68wZiht+EdeCND2pgRsIXP1Y5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdjRKPBogUMbLDVhrxt9qYx1CNpuiwFjoul4G11wtXpJ3/k5PsPURbp8/GF0vvtCk
         +XUY8Wn7uAwoJpE4dPS92EO2wcTMvX+IlsG3YQB6FLkOsQSJYxP+iOr6urSBizRbls
         zcQM7mGMlNdvVFkFMRZ2RsPzxNjiM9misvamhyDQ=
Date:   Wed, 1 Sep 2021 11:22:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <20210901152251.GA6533@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org>
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS8ppl6SYsCC0cql@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 08:20:06AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 31, 2021 at 02:59:05PM +1000, NeilBrown wrote:
> > Making the change purely in btrfs is simply not possible.  There is no
> > way for btrfs to provide nfsd with a different inode number.  To move
> > the bulk of the change into btrfs code we would need - at the very least
> > - some way for nfsd to provide the filehandle when requesting stat
> > information.  We would also need to provide a reference filehandle when
> > requesting a dentry->filehandle conversion.  Cluttering the
> > export_operations like that just for btrfs doesn't seem like the right
> > balance.  I agree that cluttering kstat is not ideal, but it was a case
> > of choosing the minimum change for the maximum effect.
> 
> So you're papering over a btrfs bug by piling up cludges in the nsdd
> code that has not business even knowing about this btrfs bug, while
> leaving other users of inodes numbers and file handles broken?
> 
> If you only care about file handles:  this is what the export operations
> are for.  If you care about inode numbers:  well, it is up to btrfs
> to generate uniqueue inode numbers.  It currently doesn't do that, and
> no amount of papering over that in nfsd is going to fix the issue.
> 
> If XORing a little more entropy

It's stronger than "a little more entropy".  We know enough about how
the numbers being XOR'd grow to know that collisions are only going to
happen in some extreme use cases.  (If I understand correctly.)

> into the inode number is a good enough band aid (and I strongly
> disagree with that), do it inside btrfs for every place they report
> the inode number.  There is nothing NFS-specific about that.

Neil tried something like that:

	https://lore.kernel.org/linux-nfs/162761259105.21659.4838403432058511846@noble.neil.brown.name/

	"The patch below, which is just a proof-of-concept, changes
	btrfs to report a uniform st_dev, and different (64bit) st_ino
	in different subvols."

(Though actually you're proposing keeping separate st_dev?)

I looked back through a couple threads to try to understand why we
couldn't do that (on new filesystems, with a mkfs option to choose new
or old behavior) and still don't understand.  But the threads are long.

There are objections to a new mount option (which seem obviously wrong;
this should be a persistent feature of the on-disk filesystem).

--b.
