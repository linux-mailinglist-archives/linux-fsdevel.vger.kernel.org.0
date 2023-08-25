Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55A788898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbjHYN3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbjHYN3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08A2133;
        Fri, 25 Aug 2023 06:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A6564C8A;
        Fri, 25 Aug 2023 13:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0DEC433C7;
        Fri, 25 Aug 2023 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692970155;
        bh=Kbv8RLcnybXhh3ttzFimO6pE4mxcaj6dzrHQVawJyzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grIN7LIZkkYNWjyPZ9wdNShrKsqLEIxiD5DA3+05miHUlznDEQvH6Ktel0RIvZJgB
         CztgbPtF7RajFgnZTBM6aCApgzPh4WjpTkn9RI/WaL6nfENdcFY+VvwcBEvrU8REcI
         jU7kswT1Y5isPklQedJ4jvAZk4WPCYblBejr0UeaEZQdZVZxUyGhb9ATeoPLrxs6TY
         c9mfg9z/yGL4GkSfw4Jym2O1Wi3molOOvrFenW6NQoAOxxGQt7RBoo2/qoP9KWE8G/
         LZsjTP4epY1sOategbyVfag4i58nTNWlrlKS73KCdis+EFvhVLNymbILXjvlTBseGS
         kqrFlqYtNShmg==
Date:   Fri, 25 Aug 2023 15:29:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230825-attribut-sympathisch-6dfddfe25f45@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
 <20230825022826.GC95084@ZenIV>
 <20230825094509.yarnl4jpayqqjk4c@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825094509.yarnl4jpayqqjk4c@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> file->f_flags. Attached is a version of the patch that I'm currently
> testing.

Appended patch looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

The patch also has another fix for O_EXCL. In earlier versions of this
patch series it relied of f_flags. Thanks for that comment you added in
there about this now. This really helps given that O_EXCL has special
meaning for block devices. Ideally we'd have kernel doc for
file_to_blk_mode().
