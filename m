Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D584526E8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiENEoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 00:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiENEoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 00:44:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9723BC0;
        Fri, 13 May 2022 21:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AmIj0gSjkDYxzy2jeo+/OtEoFwBF/q9BWriaitKkkWg=; b=wv5j/9DDwgQTA0y9hUVOtUjX6Z
        dR+Vo9YSE+g8k6ZICXv7Fek6sU8MhthF1DC2nkxI6mnef9p660V9uS+bMLACvvhzRP/wcrACYZ5Nc
        KZu5Ew1/CEuZe/oPUClUS7OBHoG13cn5EozWPinj+M7PixODElCRGGNPrWr74eCmRd6RdWarrWEpG
        pVYiL4sVR4wwp9cDSZmsbflsrL4SB++wsu1SOb81yPoU1bD1xkJOMlX03qDRPQAi2HzIE59uzJiQa
        Qe1PMRU4C8TYuM+ZjKKlAJdjDRBaIXFBoTJ7HYmI3TL6SaRTkzmKzdmWFYjJ8toGllbHdbGbn8246
        jCYJ/4jA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npjdc-00Enxi-2A; Sat, 14 May 2022 04:44:20 +0000
Date:   Sat, 14 May 2022 04:44:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
Message-ID: <Yn8zpAbwe9yFq8/i@zeniv-ca.linux.org.uk>
References: <165247056822.6691.9087206893184705325.stgit@bazille.1015granger.net>
 <165247081391.6691.14842389384935416109.stgit@bazille.1015granger.net>
 <Yn7ZooZbccSrAru0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn7ZooZbccSrAru0@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 10:20:18PM +0000, Al Viro wrote:

> Yuck.  dget_parent() is not entirely without valid uses, but this isn't
> one.  It's for the cases when parent is *not* stable and you need to grab
> what had been the parent at some point (even though it might not be the
> parent anymore by the time dget_parent() returns).  Here you seriously
> depend upon it remaining the parent of that sucker all the way through -
> otherwise vfs_create() would break.  And you really, really depend upon
> its survival - the caller is holding it locked, so they would better
> have it pinned.

As an aside, the reason why vfs_create() takes inode of parent directory
and dentry of child is basically that it's easier to describe the locking
rules that way: vfs_create(..., dir, child, ...) must be called with
1) dir being held by caller (exclusive) and
2) child->d_parent->d_inode == dir, which is stabilized by (1)

inode of parent directory is a redundant argument - it can be easily
derived from the child dentry, for all that family.  The only real
objection against dropping it from vfs_create() and friends is that
having rules described as "inode of parent dentry of child must be held
exclusive by the caller" invites breakage along the lines of

	parent = dget_parent(child);
	inode_lock(d_inode(parent));
	vfs_create(..., child, ...);	// WRONG
	inode_unlock(d_inode(parent));
	dput(parent);

which *seems* to match the rules, but actually breaks them badly -
'parent' in the snippet above might be no longer related to child by the
time dget_parent() returns it, so we end up calling vfs_create() with
wrong directory locked, child->d_parent being completely unstable, etc.
Note that the difference from your code (which is correct, if redundant) is
rather subtle.

If you have any suggestions how to describe these locking rules without
an explicit inode-of-parent argument, I would really like to hear those.
The best I'd been able to come up with had been "there's an inode
locked exclusive by the caller that had been observed to be equal to
child->d_parent->d_inode at some point after it had been locked", which
is both cumbersome and confusing...
