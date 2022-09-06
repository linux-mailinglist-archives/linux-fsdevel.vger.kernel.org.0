Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7377D5ADEAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 06:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiIFE54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 00:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIFE5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:57:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF68D69F58
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 21:57:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A53CE68AA6; Tue,  6 Sep 2022 06:57:46 +0200 (CEST)
Date:   Tue, 6 Sep 2022 06:57:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH 3/6] acl: add vfs_set_acl_prepare()
Message-ID: <20220906045746.GB32578@lst.de>
References: <20220829123843.1146874-1-brauner@kernel.org> <20220829123843.1146874-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-4-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:42PM +0200, Christian Brauner wrote:
> Various filesystems store POSIX ACLs on the backing store in their uapi
> format. Such filesystems need to translate from the uapi POSIX ACL
> format into the VFS format during i_op->get_acl(). The VFS provides the
> posix_acl_from_xattr() helper for this task.

This has always been rather confusing.  Maybe we should add a separate
structure type for the on-disk vs uapi ACL formats?  They will be the
same in binary representation, but the extra type safety might make the
core a lot more readable.
