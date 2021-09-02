Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241123FE9CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhIBHNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbhIBHNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:13:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3332C061575;
        Thu,  2 Sep 2021 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yxQ+B6Ukg3zVw5HXezCpBfzdJ1y5rPw/KWlf+grn+dg=; b=VHn7btuBVz0pJrn8OzQp/B1KIV
        xpWh4PZNldgBonL4GfApypUMafAalZYJ/u1O8p3bRl9Re9LTEKZDUSXNtUMhc78s2yjy+vzXaBCd1
        O+J96YyqMmXO6Hbn+bLCnVRz4bmjUM9TJCpIQfz1/zNc87V6uUsdcqe8AgbDIXHBRnxLFH5Rv4cIG
        WNvLEDFXtcYecPVuYBGWkK9kOcr5M8R/RHwQeNsyZqXHGXidlkrHg7UhBY7oAaZVzXf9ZPb/rRhQR
        pubn7JB+D2UWxzv/kFhrKSJi0xu+e9nlsJWS7vfwKDzgcJ0s8VRVhL/0vwhZvZ/zigfLCBusF4Kly
        OyJuhwdg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLgso-003CwG-LW; Thu, 02 Sep 2021 07:11:48 +0000
Date:   Thu, 2 Sep 2021 08:11:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.de>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <YTB5JsW/KLcp10Ef@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org>
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org>
 <20210901152251.GA6533@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901152251.GA6533@fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:22:51AM -0400, J. Bruce Fields wrote:
> It's stronger than "a little more entropy".  We know enough about how
> the numbers being XOR'd grow to know that collisions are only going to
> happen in some extreme use cases.  (If I understand correctly.)

Do we know that a malicious attacker can't reproduce the collisions?
Because that is the case to worry about.

> > into the inode number is a good enough band aid (and I strongly
> > disagree with that), do it inside btrfs for every place they report
> > the inode number.  There is nothing NFS-specific about that.
> 
> Neil tried something like that:
> 
> 	https://lore.kernel.org/linux-nfs/162761259105.21659.4838403432058511846@noble.neil.brown.name/
> 
> 	"The patch below, which is just a proof-of-concept, changes
> 	btrfs to report a uniform st_dev, and different (64bit) st_ino
> 	in different subvols."
> 
> (Though actually you're proposing keeping separate st_dev?)

No, I'm not suggestion to keep a separate st_dev in that case.  So the
above scheme looks like the most reasonable (or least unreasonable) of
the approaches I've seen so far.  I have to admit I've only noticed it
now given how deep it was hidden in a thread that I only followed bit
while on vacation.

> I looked back through a couple threads to try to understand why we
> couldn't do that (on new filesystems, with a mkfs option to choose new
> or old behavior) and still don't understand.  But the threads are long.
> 
> There are objections to a new mount option (which seem obviously wrong;
> this should be a persistent feature of the on-disk filesystem).

Yes.  Anything like this needs to be persisted.  But a mount option
might still be a reasonable way to set that persistent flag.
