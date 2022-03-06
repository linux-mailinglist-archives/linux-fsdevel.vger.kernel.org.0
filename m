Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C04CECFD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiCFSCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiCFSCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:02:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D903EF37;
        Sun,  6 Mar 2022 10:01:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D52368AA6; Sun,  6 Mar 2022 19:01:15 +0100 (CET)
Date:   Sun, 6 Mar 2022 19:01:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220306180115.GA8777@lst.de>
References: <20220304175556.407719-1-hch@lst.de> <20220304175556.407719-2-hch@lst.de> <20220304221255.GL3927073@dread.disaster.area> <20220305051929.GA24696@lst.de> <20220305214056.GO3927073@dread.disaster.area> <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
> Yes, I think we should kill it. If we retain the inode hint, the f2fs
> doesn't need a any changes. And it should be safe to make the per-file
> fcntl hints return EINVAL, which they would on older kernels anyway.
> Untested, but something like the below.

I've sent this off to the testing farm this morning, but EINVAL might
be even better:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/more-hint-removal
