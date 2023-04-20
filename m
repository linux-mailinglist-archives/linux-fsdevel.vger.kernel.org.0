Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9706E9ECA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjDTW1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDTW1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:27:50 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9730FC;
        Thu, 20 Apr 2023 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=040afLTXtuJ7sunsvWN7ukvubv6Dl2i6jINIQL+37rA=; b=tAfQYE1utUBSIoz61+DqYdj6Du
        OfHbwHd0MHaZYU8m36rJ6xGk0jqQh95Md0XF4DTSB++h3iwAFex/r5yyJIGyyRYortVzhLLgmclP7
        ooxTIa6qaJOXwjvs5bboz2dYFeTIbL3/FQwt6EKLpDRsZwnfqgovfYvge6IqKFVnUIRlhdWTjdMDs
        cRL3IJpjxtNXKwZqaCmjh72CgKllwSKBHUamt9Pd/BluAwbO0J2h3ws523YIeFKr/bGdY/+BK9Gah
        Cl+HNPycCpKHiaGFy6UntkI7TU7t25EyexEYFceBUoNU9Wo/emBGJ+CRCy6L70xEhZJswHa1XeuZT
        radWFa/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppcki-00AyoD-2q;
        Thu, 20 Apr 2023 22:27:44 +0000
Date:   Thu, 20 Apr 2023 23:27:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
Message-ID: <20230420222744.GU3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>
 <20230417-beisein-investieren-360fa20fb68a@brauner>
 <168176679417.24821.211742267573907874@noble.neil.brown.name>
 <20230420213529.GS3390869@ZenIV>
 <168202806952.24821.15445938161479912532@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168202806952.24821.15445938161479912532@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:01:09AM +1000, NeilBrown wrote:
> On Fri, 21 Apr 2023, Al Viro wrote:
> > On Tue, Apr 18, 2023 at 07:26:34AM +1000, NeilBrown wrote:
> > 
> > > MNT_FORCE is, I think, a good idea and a needed functionality that has
> > > never been implemented well.
> > > MNT_FORCE causes nfs_umount_begin to be called as you noted, which
> > > aborts all pending RPCs on that filesystem.
> > 
> > Suppose it happens to be mounted in another namespace as well.  Or bound
> > at different mountpoint, for that matter.  What should MNT_FORCE do?
> > 
> 
> 1/ set a "forced-unmount" flag on the vfs_mount which causes any syscall
>    that uses the vfsmount (whether from an fd, or found in a path walk,
>    or elsewhere), except for close(), to abort with an error;
> 2/ call ->umount_begin passing in the vfs_mount.  The fs can abort any
>    outstanding transaction on any fd from that vfs_mount.

How the hell would you recognize those?
