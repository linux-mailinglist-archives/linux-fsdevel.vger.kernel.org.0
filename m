Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D717698E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGaODx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjGaODf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F24C0A;
        Mon, 31 Jul 2023 06:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7FE6113E;
        Mon, 31 Jul 2023 13:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21BBC433C8;
        Mon, 31 Jul 2023 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690811876;
        bh=75UoLt2odqW/ibvFDWeID4RRBL3oJ0UWvU1rniIL4WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfpV3AHBwj3d+4lAwHWFmFZHE7nx7W75+3JKO9zZ6etU3ciYUnH6G6h4l/IfDlP2n
         OHOz4Et2ua3NAcqrM9oKAUdf44nuTwUNjwNYfBga+Wuvx2N368MKCWmhRsLpnd8df9
         j+OpiCKdwowcaiUHzPBeYbT77aFn3J5BD8qwTAyvoXKGwRXEnOp8BPK5DJR7SSkUrt
         kK9gY2tlPYwM1Qog5Sh2yPO9bdCNqgPPelJDUOBKi+CbQay48O9GSVHFz7jJ+H23QC
         Xre+/rMjaiFq873h/G6M5diNcjdO2qwTo5kyFI4T9/1FZTzMVhJsxbp/ezg+zRIIc3
         v5ANPBfib1qYw==
Date:   Mon, 31 Jul 2023 15:57:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jack@suse.cz,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731-deswegen-chatten-4ff6c45563ad@brauner>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
 <20230731-augapfel-penibel-196c3453f809@brauner>
 <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
 <20230731135325.GB6016@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731135325.GB6016@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:53:25PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 03:22:28PM +0200, Christian Brauner wrote:
> > Uh, no. I vasty underestimated how sensitive that change would be. Plus
> > arguably ->kill_sb() really should be callable once the sb is visible.
> > 
> > Are you looking into this or do you want me to, Christoph?
> 
> I'm planning to look into it, but I won't get to it before tomorrow.

Ok, let me go through the callsites and make sure that all callers are
safe. I think we should just continue calling deactivate_locked_super()
exactly the way we do right now but remove shenanigans like the one we
have in erofs_kill_sb().
