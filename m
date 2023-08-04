Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91D770381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjHDOt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjHDOt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6D49C7;
        Fri,  4 Aug 2023 07:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639F962054;
        Fri,  4 Aug 2023 14:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DFFC433C8;
        Fri,  4 Aug 2023 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160562;
        bh=QT3MsKCVhyq7VXab1vdD48amnZ+BMWNEaJcvg9qS81E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+aVO57g/9aDf6XFf85v+Um2i+7ugfkgJSbQn9w+sRC97KE33UWkfv0FdfCdtuO2C
         TpgkLyjYMx+VGtpfTUJueN9x/+mSbUgFD7wGm6hCG01zxMx3hJyUysA4u5TW8TdMez
         0nxYGtxYYCHp7iRq6QKiwx+qi0C6HD80XQvfC2YNr08YPvGYjghcF+eZPE4hcFsQQ5
         aSFLwQNw1Y/HMB9Z4V529Dd8BQVplruGbP9/ZSOv1If3HB/JAMyCpPZzSv7FowCCit
         J37rstuQ7NfpC5Uw5ihFnlC1/w9YgPZsdjc4JPpcEbIrVGVVJCtuUW6lbX+ma0X/7i
         O1a5fc0qmInSg==
Date:   Fri, 4 Aug 2023 16:49:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230804-kurvigen-uninteressant-09d451db7458@brauner>
References: <00000000000058d58e06020c1cab@google.com>
 <20230804101408.GA23274@lst.de>
 <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner>
 <20230804140201.GA27600@lst.de>
 <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner>
 <20230804144343.GA28230@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804144343.GA28230@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:43:43PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 04, 2023 at 04:36:49PM +0200, Christian Brauner wrote:
> > FFS
> 
> Good spot, this explains the missing dropping of s_umount.
> 
> But I don't think it's doing the right thing for MTD mount romfs,
> we'll need something like this:

I'll fold a fix into Jan's patch.
