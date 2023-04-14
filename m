Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F86E264E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDNO6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDNO6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:58:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DDC654;
        Fri, 14 Apr 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V5bF/giLnmiuSWUUww4zKnjupwvTlof72GkeF0z3SVk=; b=NokI3OdXLvkpvpwCRmy8q7lGCI
        y4waF4+isNFsvbOvQRRL0Y5GmMZPrglod3TVl5pxGutBUhhDpmbahwmnJeZSquZlnrei977fNpQzq
        3j9pIM40yOUXtIOMcRnfS+jd7kVnD1GvJPxOg/NdTZfjs7aRnZoV1BntP9DO3COxKFG4nXhJQn790
        WxIrKxsGZ2FSJxzkxoANQpParXBVpbvAuAgFb32iSXfcnhhveH0CIddgXZiSPQABQOkYa16KintWz
        ZMVkSMa83sYvn+dS12r+ZIqeNE/x0NyL9FRn+KuelxIQm7AX58rqORksQS6R6iL5hxfQhe3Wd4qgA
        LFv75VKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnKsB-0090JN-19;
        Fri, 14 Apr 2023 14:57:59 +0000
Date:   Fri, 14 Apr 2023 15:57:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414145759.GJ3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <20230414023211.GE3390869@ZenIV>
 <8d2c619d2a91f3ac925fbc8e4fc467c6b137ab14.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2c619d2a91f3ac925fbc8e4fc467c6b137ab14.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:01:59AM -0400, Jeff Layton wrote:
> On Fri, 2023-04-14 at 03:32 +0100, Al Viro wrote:
> > On Thu, Apr 13, 2023 at 06:00:42PM -0400, Jeff Layton wrote:
> > 
> > > It describes a situation where there are nested NFS mounts on a client,
> > > and one of the intermediate mounts ends up being unexported from the
> > > server. In a situation like this, we end up being unable to pathwalk
> > > down to the child mount of these unreachable dentries and can't unmount
> > > anything, even as root.
> > 
> > So umount -l the stuck sucker.  What's the problem with that?
> > 
> 
> You mean lazy umount the parent that is stuck? What happens to the child
> mount in that case? Is it also eventually cleaned up?

Yes.  Lazy umount takes out the contributions to refcount due to being
present in mount tree; as soon as other references go away (opened
files, current directories, in-progress syscalls on files in there) struct
mount instance releases the active reference to filesystem instance
(struct super_block) and goes away.  Once all active references to
filesystem instance are gone, it gets shut down.

> Yeah, I hadn't considered symlinks here. Still, if we have a cached
> symlink dentry, wouldn't we also already have the symlink target in
> cache too? Or is that not guaranteed?

Not at all.  What's more, why would we have that symlink dentry cached
in the first place?  If you suddenly impose that kind of restrictions
on umount(2), you are pretty much guaranteed to break userland...

Symlink dentries are rarely pinned, BTW - they may very well be
cached if we hit them often enough, but outside of the things
like lchown()/lstat() or pathname resolution in progress that is
currently traversing that symlink... refcount is going to be zero.
