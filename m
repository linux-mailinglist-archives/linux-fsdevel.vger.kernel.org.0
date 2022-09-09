Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6E5B3B57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIIO6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiIIO6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:58:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C813883F
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 07:58:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A38A68AA6; Fri,  9 Sep 2022 16:58:39 +0200 (CEST)
Date:   Fri, 9 Sep 2022 16:58:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220909145839.GA11530@lst.de>
References: <20220829123843.1146874-1-brauner@kernel.org> <20220829123843.1146874-4-brauner@kernel.org> <20220906045746.GB32578@lst.de> <20220906074532.ysyitr5yxy5adfsx@wittgenstein> <20220906075313.GA6672@lst.de> <20220906080744.3ielhtvqdpbqbqgq@wittgenstein> <20220906081510.GA8363@lst.de> <20220906082428.mfcjily4dyefunds@wittgenstein> <20220909080339.2rdbbk2g2p5evznd@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909080339.2rdbbk2g2p5evznd@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:03:39AM +0200, Christian Brauner wrote:
> This passes xfstests (ext4, xfs, btrfs, overlayfs with and without
> idmapped layers, and LTP). I only needed to add i_op->get_dentry_acl()
> as it was possible to adapt ->set_acl() to take a dentry argument and
> not an inode argument.

This looks pretty nice.  Two high level comments:

 - instead of adding lots of stub ->get_dentry_acl іmplementations that
   wrap ->get_acl, just call ->get_acl if ->get_dentry_acl is not
   implementet in the VFS
 - I think the methods that take a dentry should be named consisently,
   so either ->get_dentry_acl and ->get_dentry_acl vs ->get_acl,
   or ->get_acl and ->set_acl vs ->get_inode_acl or something like that.
