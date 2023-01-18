Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E283672362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 17:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjARQcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjARQbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:31:55 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63346171;
        Wed, 18 Jan 2023 08:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=79tBezyevsf2Wxt0n7eAII57Vo+xNtqmBftZsLQEsak=; b=AE1dpnZ/RyCsAhZjNATK0qKchW
        MalbWxkYDaH7CPFLM6QjQBYvj+f8wHu/p3KYTaMnKBZcf6xFD3P0y4loZGMWsUhMgKygsP9WiMBIA
        PMiAr1iF3KI/4jOG/7P6H9pnw78sWVIN1wqSDKT02en3TvOUvzspx4fgNv6fxrXv7YaToj+dTbxtm
        1kXKhSFh8Co62Z4dCOPCNeGPVkwCKH+xfHFNRAfHbMZRH//pp1YSWJq0RGoDZK0AZuAJ0ZxR69F8N
        waSdo5JVLSs0u5piImKsTtBxvqo+WxwHDC+tTfT2cvDCwHk1Bb+Py1GY8hQKR8OrxsfgrEm2BWsOo
        6CPWQBIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIBKA-002a04-0T;
        Wed, 18 Jan 2023 16:30:06 +0000
Date:   Wed, 18 Jan 2023 16:30:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <Y8gejpDqxV6Uo/xY@ZenIV>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <Y8bTk1CsH9AaAnLt@ZenIV>
 <20230118091036.qqscls22q6htxscf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118091036.qqscls22q6htxscf@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:10:36AM +0100, Jan Kara wrote:

> 
> Yes, we can lock the source inode in ->rename() if we need it. The snag is
> that if 'target' exists, it is already locked so when locking 'source' we
> are possibly not following the VFS lock ordering of i_rwsem by inode
> address (I don't think it can cause any real dealock but still it looks
> suspicious). Also we'll have to lock with I_MUTEX_NONDIR2 lockdep class to
> make lockdep happy but that's just a minor annoyance. Finally, we'll have
> to check for RENAME_EXCHANGE because in that case, both source and target
> will be already locked. Thus if we do the additional locking in the
> filesystem, we will leak quite some details about rename locking into the
> filesystem which seems undesirable to me.

Rules for inode locks are simple:
	* directories before non-directories
	* ancestors before descendents
	* for non-directories the ordering is by in-core inode address

So the instances that need that extra lock would do that when source is
a directory and non RENAME_EXCHANGE is given.  Having the target already
locked is irrelevant - if it exists, it's already checked to be a directory
as well, and had it been a descendent of source, we would have already
found that and failed with -ELOOP.

If A and B are both directories, there's no ordering between them unless
one is an ancestor of another - such can be locked in any order.
However, one of the following must be true:
	* C is locked and both A and B had been observed to be children of C
after the lock on C had been acquired, or
	* ->s_vfs_rename_mutex is held for the filesystem containing both
A and B.

Note that ->s_vfs_rename_mutex is there to stabilize the tree topology and
make "is A an ancestor of B?" possible to check for more than "A is locked,
B is a child of A, so A will remain its ancestor until unlocked"...
