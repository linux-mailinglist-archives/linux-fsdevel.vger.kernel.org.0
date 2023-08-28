Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1378AF78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjH1MEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjH1MEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:04:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF711A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:04:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F6216732A; Mon, 28 Aug 2023 14:04:18 +0200 (CEST)
Date:   Mon, 28 Aug 2023 14:04:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] super: ensure valid info
Message-ID: <20230828120418.GB10189@lst.de>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org> <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> For block backed filesystems notifying in pass sb->kill_sb() in

I can't parse the 'in pass' here.

> @@ -1260,6 +1270,7 @@ void kill_anon_super(struct super_block *sb)
>  {
>  	dev_t dev = sb->s_dev;
>  	generic_shutdown_super(sb);
> +	kill_super_notify(sb);
>  	free_anon_bdev(dev);

Maybe I didn't read the commit log carefully enough, but why do we
need to call kill_super_notify before free_anon_bdev and any potential
action in ->kill_sb after calling kill_anon_super here given that
we already add a call to kill_super_notify after ->kill_sb?

