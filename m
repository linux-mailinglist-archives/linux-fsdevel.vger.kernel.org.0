Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644878C311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjH2LEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjH2LDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C91AD;
        Tue, 29 Aug 2023 04:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E26654DF;
        Tue, 29 Aug 2023 11:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D1AC433C8;
        Tue, 29 Aug 2023 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693307020;
        bh=dmhRaIoPYrHNxkH4ZB1VVK692yXKEC04ivOUvYbVaY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDeq8V00xGngbcNjE8R26ooRTE8CMWgG0Sq886mzIiSadRDDb2o7kmsxQtnRXW3gQ
         zU8LFGQX0rOUGnxbsufITcGHa/jTxEC+lNAyQwB6CsMPepryhcjvStQwBxEX57fFSl
         TQYxMLuCnl7Q47z2UMB8AsE6t9rNxrGbGaNF8qU9JGVZyAdlgZg3wJxzUk4lWK+Wld
         gASZCUMBvtcy8ntHEuVqF+gwduJdJ/gdiMSIvK5ZLMKq9lpTiIU21IQC81ceh6MrnG
         Ziv17Fr/8MDqsFThV1PzrpAp7RQVJ9t9t2gWVrcEC9woKJDuSJbqK+PIglo8frydKD
         NZuACq9V7ImaA==
Date:   Tue, 29 Aug 2023 13:03:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230829-zinspolitik-beruhen-521109e35cdc@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
 <20230825022826.GC95084@ZenIV>
 <20230825094509.yarnl4jpayqqjk4c@quack3>
 <20230825-attribut-sympathisch-6dfddfe25f45@brauner>
 <20230828164613.i6angwprxm57es6s@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828164613.i6angwprxm57es6s@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 06:46:13PM +0200, Jan Kara wrote:
> On Fri 25-08-23 15:29:11, Christian Brauner wrote:
> > > file->f_flags. Attached is a version of the patch that I'm currently
> > > testing.
> > 
> > Appended patch looks good to me,
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > 
> > The patch also has another fix for O_EXCL. In earlier versions of this
> > patch series it relied of f_flags. Thanks for that comment you added in
> > there about this now. This really helps given that O_EXCL has special
> > meaning for block devices. Ideally we'd have kernel doc for
> > file_to_blk_mode().
> 
> Thanks for review! I've added the kerneldoc comment:
> 
> /**
>  * file_to_blk_mode - get block open flags from file flags
>  * @file: file whose open flags should be converted
>  *
>  * Look at file open flags and generate corresponding block open flags from
>  * them. The function works both for file just being open (e.g. during ->open
>  * callback) and for file that is already open. This is actually non-trivial
>  * (see comment in the function).
>  */

Perfect, thanks!
