Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1FC4010C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhIEQI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEQIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 12:08:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6930EC061575;
        Sun,  5 Sep 2021 09:07:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E257F6CC9; Sun,  5 Sep 2021 12:07:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E257F6CC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630858039;
        bh=zhphZcWVKNbwXAEiog4EBMI4GzK2vfsJdfnbXhq4C7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5SY6uzR6ztVa9niwLxGeTKGeflbxRpEbFJCKDKB0qE8EeXoctSQ1QGthekab5zc4
         jCg92MPihiNk/m9sJFlVzwm1X07vbgsPI8mXYXMNKAR+7BY3B846/kd30KuB1XmlUE
         CNr9yADAxPI6tSDUw6sP6zQcfsbKTTRdCRV8o+DM=
Date:   Sun, 5 Sep 2021 12:07:19 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <20210905160719.GA20887@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org>
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org>
 <20210901152251.GA6533@fieldses.org>
 <163055605714.24419.381470460827658370@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163055605714.24419.381470460827658370@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:14:17PM +1000, NeilBrown wrote:
> On Thu, 02 Sep 2021, J. Bruce Fields wrote:
> > I looked back through a couple threads to try to understand why we
> > couldn't do that (on new filesystems, with a mkfs option to choose new
> > or old behavior) and still don't understand.  But the threads are long.
> > 
> > There are objections to a new mount option (which seem obviously wrong;
> > this should be a persistent feature of the on-disk filesystem).
> 
> I hadn't thought much (if at all) about a persistent filesystem feature
> flag.  I'll try that now.
> 
> There are two features of interest.  One is completely unique inode
> numbers, the other is reporting different st_dev for different
> subvolumes.  I think these need to be kept separate, though the second
> would depend on the first.  They would be similar to my "inumbits" and
> "numdevs" mount options, though with less flexibility.  I think that
> they would need strong semantics to be acceptable - "mostly unique"
> isn't really acceptable once we are changing the on-disk data.

I don't quite follow that.

Also the "on-disk data" here is literally just one more flag bit in some
superblock field, right?

> I believe that some code *knows* that the root of any btrfs subvolumes
> has inode number 256.  systemd seems to use this.  I have no idea what
> else might depend on inode numbers in some way.

Looking.  Ugh, yes, there's  abtrfs_might_be_subvol that takes a struct
stat and returns:

        return S_ISDIR(st->st_mode) && st->st_ino == 256;

I wonder why it does that?  Are there situations where all it has is a
file descriptor (so it can't easily compare st_dev with the parent?)
And if you NFS-export and wanted to answer the same question on the
client side, I wonder what you'd do.

--b.
