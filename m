Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62057BC4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiGTRGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiGTRGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:06:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3476B253;
        Wed, 20 Jul 2022 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QwPkRp//zT0UHUMFiPU7pgoKTbxcvEzlNYpUIO/C0YM=; b=WCHwPNLU1PBrUY32o2OFLClqfb
        d4zaISm63LnVx+Nulbh6GG4I3kfLeHKzMUfL8smEUB6i+CTceghPKPPf51h9g9C9QqJn4pYOz0s+v
        VASB9+m8e6DbzX4rHOLfCuLda+4QE1NyQXnDrVpahEObHdSMv+lyxlmaK0zCKTOiN6WLLbBSsJoTS
        Toho6dkQsE/qhN9cSk8uJUBmALTspeAd0xPmgai2V+qUoZcoLqlg4YU4eD5qEO233MyZ+/l8rZ2+3
        lxDswIVYBDna4mtMO+WC+wxai6uSqpMaSdQ6HOeQBCtZgL90TvCixWq1VR37DWfc1JWi1ymcvkTUF
        u1509Otg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oED9M-00EANu-4N;
        Wed, 20 Jul 2022 17:06:16 +0000
Date:   Wed, 20 Jul 2022 18:06:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <Ytg2CDLzLo+FKbTZ@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <Ytd2g72cj0Aq1MBG@ZenIV>
 <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de>
 <YtepmwLj//zrD3V3@ZenIV>
 <20220720110032.1787-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720110032.1787-1-hdanton@sina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 07:00:32PM +0800, Hillf Danton wrote:

> To help debug it, de-union d_in_lookup_hash with d_alias and add debug
> info after dentry is killed. If any warning hits, we know where to add
> something like
> 
> 	WARN_ON(dentry->d_flags & DCACHE_DENTRY_KILLED);
> 
> before hlist_bl_add or hlist_add.

IDGI.  That clearly has nothing to do with in-lookup stuff - no
DCACHE_PAR_LOOKUP in reported flags, so it either never had it set,
or it went through __d_lookup_done() already.

If anything, it might have already been through d_free(), with
d_rcu being confused for d_alias.

I'd do something like
	WARN_ON(dentry->d_flags & (1U<<31));
	dentry->d_flags |= 1U << 31;
in the begining of d_free() (possibly with dumping dentry state if we
hit that, not that there would be much to report; d_name.name might
be informative, though).

Again, in-lookup looks like a red herring - DCACHE_PAR_LOOKUP is set
only in d_alloc_parallel(), right next to the insertion into the list
and removed only in __d_lookup_free(), right next to the removal from
the same.  No DCACHE_PAR_LOOKUP in ->d_flags (it's 0x8008 in reported
cases, i.e. DCACHE_OP_REVALIDATE | DCACHE_DENTRY_KILLED).

What's more, take a look at retain_dentry(); WARN_ON(d_in_lookup(dentry))
right at the top and it had not triggered in any of the reports I've
seen in that thread.  Granted, it's not called on each path to
__dentry_kill(), but it is on the call chains I've seen reported...

Another thing that might be interesting to know is ->d_sb, along with
->d_sb->s_type->name and ->d_sb->s_id.  That should tell which fs it's
on...

I wonder if anyone had seen anything similar outside of parisc...
I don't know if I have any chance to reproduce it here - the only
parisc box I've got is a 715/100 (assuming the disk is still alive)
and it's 32bit, unlike the reported setups and, er, not fast.
qemu seems to have some parisc support, but it's 32bit-only at the
moment...

PS: please, Cc fsdevel on anything VFS-related.  Very few people are
still subscribed to l-k these days - I am, but it's impossible to read
through and postings can easily get missed.
