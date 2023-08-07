Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C739771EBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjHGKsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHGKsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:48:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE301993
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 03:47:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE1476732D; Mon,  7 Aug 2023 12:47:14 +0200 (CEST)
Date:   Mon, 7 Aug 2023 12:47:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: bd_holder
Message-ID: <20230807104714.GA14922@lst.de>
References: <20230807-hinzu-barhocker-7e7826d113cb@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-hinzu-barhocker-7e7826d113cb@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:28:54AM +0200, Christian Brauner wrote:
> I've been looking into reducing sb_lock and replacing it mostly with a
> new file_system_type->fs_super_lock which would be a
> per-file-system-type spinlock protecting fs_type->fs_supers.
> 
> With the changes in vfs.super bd_holder always stores the super_block
> and so we should be able to get rid of get_super() and user_get_super()
> completely. Am I right in this or is there something that would prevent
> us from doing something like the following (completely untested sketch)?:

I have a series killing get_super, and it looks pretty similar to what
you've proposed.  I'm completely under water right now but I hope can
get it into a good enough shape to post it later today or tomorrow.

user_get_super OTOH can't go away.  It's only used in two legacy APIs
where it must only work for the device in s_dev.  It's not performance
critical and we could use other lookup schemes.

get_active_super can go away, but with Darrick having queued up work
in this area it'll have to wait for next merge window.
