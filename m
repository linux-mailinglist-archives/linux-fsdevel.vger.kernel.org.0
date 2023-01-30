Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90BB68084F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjA3JQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjA3JQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:16:19 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B91ABD4;
        Mon, 30 Jan 2023 01:16:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 524FF68BEB; Mon, 30 Jan 2023 10:16:15 +0100 (CET)
Date:   Mon, 30 Jan 2023 10:16:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 00/12] acl: remove remaining posix acl handlers
Message-ID: <20230130091615.GB5178@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230130091052.72zglqecqvom7hin@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130091052.72zglqecqvom7hin@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:10:52AM +0100, Christian Brauner wrote:
> However, a few filesystems still rely on the ->list() method of the
> generix POSIX ACL xattr handlers in their ->listxattr() inode operation.
> This is a very limited set of filesystems. For most of them there is no
> dependence on the generic POSIX ACL xattr handler in any way.
> 
> In addition, during inode initalization in inode_init_always() the
> registered xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
> inode->i_opflags.
> 
> With the incoming removal of the legacy POSIX ACL handlers it is at
> least possible for a filesystem to only implement POSIX ACLs but no
> other xattrs. If that were to happen we would miss to raise IOP_XATTR
> because sb->s_xattr would be NULL. While there currently is no such
> filesystem we should still make sure that this just works should it ever
> happen in the future.

Now the real questions is: do we care?  Once Posix ACLs use an
entirely separate path, nothing should rely on IOP_XATTR for them.
So instead I think we're better off auditing all users of IOP_XATTR
and making sure that nothing relies on them for ACLs, as we've very
much split the VFS concept of ACLs from that from xattrs otherwise.
