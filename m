Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B278B17A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjH1NSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjH1NR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A6125
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 06:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16FFF610A4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 13:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6611AC433C7;
        Mon, 28 Aug 2023 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693228675;
        bh=wnKEZq/mjYbtW0BJPKKrT028dQgkvzw5lKtw5ykI1t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdDeKPlck5+/3ojvLx9TnlE/L8ONnZp3GoV/oUxd0jkAlhHlFUrCNb2xt40QK0aDd
         s/l6TbXvlGCElCmXTrH7DF3X7gZ16TMOBqCTc7a29la4ZZ+c4VCqdd4RbgaKCdCfnk
         69bi4WstLkL0NDaL8LRz8OUtDj4CrelW9mlPCVMY0pL1ynA4W+CgDS+1qf97l/ccEa
         KitQ4u6ZbQyR/mSEiKypvwUTxRAW4pkYOCUVHvOPyuS3Dw3eUqbSm6kYUqCkaoxcd0
         +D4q/ezagCvZV4hHP/Rr4n1QHlP+AWpahxu2Y+lMoLDx1349SzPv2f8GRHvXgoJMOX
         LmBXDNiJiMWsA==
Date:   Mon, 28 Aug 2023 15:17:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] super: ensure valid info
Message-ID: <20230828-lehrmaterial-anekdote-bec060709867@brauner>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
 <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
 <20230828130725.azxxf2hrhokwugxk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828130725.azxxf2hrhokwugxk@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So AFAICT this fixes the UAF issues. It does reintroduce the EBUSY problems
> with mount racing with umount e.g. for EROFS which calls bdev_release()

It shouldn't as erofs doesn't use block devices when it is in fscache
mode which is when kill_anon_super() is called. For regular erofs
kill_block_super() is used and notification happens as before.

> after calling kill_anon_super() but I think we can live with that until we
> come up with a neater solution for this problem. So feel free to add:

I think ultimately we might just provide callback to kill_*_super() like
we do for sget_fc() or something. But let's keep thinking of course.
