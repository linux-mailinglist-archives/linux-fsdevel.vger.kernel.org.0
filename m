Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2444C70825C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjERNNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjERNNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:13:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743F198E;
        Thu, 18 May 2023 06:12:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4333668C7B; Thu, 18 May 2023 15:12:17 +0200 (CEST)
Date:   Thu, 18 May 2023 15:12:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230518131216.GA32076@lst.de>
References: <20230505175132.2236632-6-hch@lst.de> <20230516-kommode-weizen-4c410968c1f6@brauner> <20230517073031.GF27026@lst.de> <20230517-einreden-dermatologisch-9c6a3327a689@brauner> <20230517080613.GA31383@lst.de> <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner> <20230517120259.GA16915@lst.de> <20230517-holzfiguren-anbot-490e5a7f74fe@brauner> <20230517142609.GA28898@lst.de> <20230518-teekanne-knifflig-a4ea8c3c885a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518-teekanne-knifflig-a4ea8c3c885a@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 10:13:04AM +0200, Christian Brauner wrote:
> Fwiw, I didn't mean to have a special device handler for an O_PATH fd.
> I really just tried to figure out whether it would make sense to have an
> fd-based block device lookup function because right now we only have
> blkdev_get_by_path() and we'd be passing blkdev fds through the mount
> api. But I understand now how I'd likely do it. So now just finding time
> to actually implement it.

What's wrong with blkdev_get_by_dev(file_inode(file)->i_rdev) after
the sanity checks from lookup_bdev (S_ISBLK and may_open_dev)?
