Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989605AE19C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiIFHxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiIFHxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:53:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9274CD6
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 00:53:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C9DA68AA6; Tue,  6 Sep 2022 09:53:14 +0200 (CEST)
Date:   Tue, 6 Sep 2022 09:53:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906075313.GA6672@lst.de>
References: <20220829123843.1146874-1-brauner@kernel.org> <20220829123843.1146874-4-brauner@kernel.org> <20220906045746.GB32578@lst.de> <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906074532.ysyitr5yxy5adfsx@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:45:32AM +0200, Christian Brauner wrote:
> > structure type for the on-disk vs uapi ACL formats?  They will be the
> 
> We do already have separate format for uapi and VFS ACLs. I'm not sure
> if you're suggesting another intermediate format.

Right now struct posix_acl_xattr_header and
struct posix_acl_xattr_entry is used both for the UAPI, and the
on-disk format of various file systems, despite the different cases
using different kinds of uids/gids.

> I'm currently working on a larger series to get rid of the uapi struct
> abuse for POSIX ACLs. Building on that work Seth will get rid of similar
> abuses for VFS caps. I'm fairly close but the rough idea is:

Can we just stop accessing ACLs through the xattrs ops at all, and
just have dedicated methods instead?  This whole multiplexing of
ACLs through xattrs APIs has been an unmitigated disaster.

Similar for all other "xattrs" that are not just user data and
interpreted by the kernel, but ACLs are by far the worst.
