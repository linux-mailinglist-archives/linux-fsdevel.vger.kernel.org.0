Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24830769471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGaLQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGaLQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:16:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6600E55;
        Mon, 31 Jul 2023 04:16:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A42B067373; Mon, 31 Jul 2023 13:16:22 +0200 (CEST)
Date:   Mon, 31 Jul 2023 13:16:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        brauner@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jack@suse.cz, jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731111622.GA3511@lst.de>
References: <000000000000f43cab0601c3c902@google.com> <20230731093744.GA1788@lst.de> <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:58:14PM +0800, Gao Xiang wrote:
> Previously, deactivate_locked_super() or .kill_sb() will only be
> called after fill_super is called, and .s_magic will be set at
> the very beginning of erofs_fc_fill_super().
>
> After ("fs: open block device after superblock creation"), such
> convension is changed now.  Yet at a quick glance,
>
> WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>
> in erofs_kill_sb() can be removed since deactivate_locked_super()
> will also be called if setup_bdev_super() is falled.  I'd suggest
> that removing this WARN_ON() in the related commit, or as
> a following commit of the related branch of the pull request if
> possible.

Agreed.  I wonder if we should really call into ->kill_sb before
calling into fill_super, but I need to carefull look into the
details.
