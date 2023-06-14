Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD872F7A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjFNITJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbjFNISb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F51985;
        Wed, 14 Jun 2023 01:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3F4A639ED;
        Wed, 14 Jun 2023 08:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E6C433C0;
        Wed, 14 Jun 2023 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686730707;
        bh=UZ7T6wpompPxMLQubsjrqybaIQtHskyAXV9BO5YKxak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQaMg0NzSyFNIp4l37g0LkhxIkUOA2wWyn19FzyKDrsWLukuKiFtrM51dRGHu7+j5
         BJpbxReA8PzxvYFFhuGQ+yJXo9jpZa2XOxXH2KsoZx3z9Dc7LCBGCI63ZxJaYjr1l5
         klIosYKVIgfUUiH7dhqv4x/46DpN1fCGvbJfcC3n+5PaFo32exCkaFDUjWwLbzUZUG
         Nvn0AhbXGidOlLWZthNFZWtS1M/AD+vTlFYhSBDdQLO0tBgtNMJ4DYFIL5rTIu1i1G
         R1yiuvZ7LmkgMwUMnxOQxuWrCLCwtXgS7CJCJJ6/Ds6TWwyZI3BUVYfTrK/LSXyI5K
         7h/qC8Y5LeAJQ==
Date:   Wed, 14 Jun 2023 10:18:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614-anstalt-gepfercht-affd490e6544@brauner>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
 <ZIlphqM9cpruwU6m@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIlphqM9cpruwU6m@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:17:26AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 13, 2023 at 08:09:14AM +0200, Dmitry Vyukov wrote:
> > I don't question there are use cases for the flag, but there are use
> > cases for the config as well.
> > 
> > Some distros may want a guarantee that this does not happen as it
> > compromises lockdown and kernel integrity (on par with unsigned module
> > loading).
> > For fuzzing systems it also may be hard to ensure fine-grained
> > argument constraints, it's much easier and more reliable to prohibit
> > it on config level.
> 
> I'm fine with a config option enforcing write blocking for any
> BLK_OPEN_EXCL open.  Maybe the way to it is to:
> 
>  a) have an option to prevent any writes to exclusive openers, including
>     a run-time version to enable it

I really would wish we don't make this runtime configurable. Build time
and boot time yes but toggling it at runtime makes this already a lot
less interesting.
