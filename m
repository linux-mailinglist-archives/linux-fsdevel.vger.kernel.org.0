Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF084CE2C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 06:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiCEFU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 00:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCEFU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:20:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63B120F61;
        Fri,  4 Mar 2022 21:19:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE57B68AFE; Sat,  5 Mar 2022 06:19:29 +0100 (CET)
Date:   Sat, 5 Mar 2022 06:19:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
        kbusch@kernel.org, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Message-ID: <20220305051929.GA24696@lst.de>
References: <20220304175556.407719-1-hch@lst.de> <20220304175556.407719-2-hch@lst.de> <20220304221255.GL3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304221255.GL3927073@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
> AFAICT, all the filesystem/IO path passthrough plumbing for hints is
> now gone, and no hardware will ever receive hints.  Doesn't this
> mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
> are now completely unused, too?

No, for the reason tha you state below.  f2fs still uses it.

> AFAICT, this patch leaves just the f2fs allocator usage of
> inode->i_rw_hint to select a segment to allocate from as the
> remaining consumer of this entire plumbing and user API. Is that
> used by applications anywhere, or can that be removed and so the
> rest of the infrastructure get removed and the fcntl()s no-op'd or
> -EOPNOTSUPP?

I was told it is used quite heavily in android.
