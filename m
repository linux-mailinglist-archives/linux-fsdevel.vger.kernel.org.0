Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810777BA296
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjJEPmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjJEPlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:41:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992B9EEB
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 06:56:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47FA96732D; Thu,  5 Oct 2023 08:48:19 +0200 (CEST)
Date:   Thu, 5 Oct 2023 08:48:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] porting: document block device freeze and thaw
 changes
Message-ID: <20231005064818.GA5728@lst.de>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org> <20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org> <20230927151911.GG11414@frogsfrogsfrogs> <20231002164524.lh6ljbdxdqln33jk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002164524.lh6ljbdxdqln33jk@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 06:45:24PM +0200, Jan Kara wrote:
> > "Filesystems opening a block device must pass the super_block object
> > and fs_holder_ops as the @holder and @hops parameters."
> > 
> > Though TBH I see a surprising amount of fs code that doesn't do this, so
> > perhaps it's not so mandatory?
> 
> This is actually a good point. For the main device, fs/super.c takes care
> of this (perhaps except for btrfs). So this patch set should not regress
> anything. But for other devices such as the journal device or similar,
> passing proper holder and holder_ops from the filesystem is necessary.

It is is necessary to gain functionality where we call into the
fs based on the block device.  In the old get_super based world these
never worked either as get_super was based on sb->s_dev only.
