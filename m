Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7655A912
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 12:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiFYKxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiFYKxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C7FF4;
        Sat, 25 Jun 2022 03:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6913E61186;
        Sat, 25 Jun 2022 10:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C4AC3411C;
        Sat, 25 Jun 2022 10:52:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h2qP4oCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656154377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oL3nAKlbbfO6qUKbOXk0RssI91UWyjPx1AiTUHBNgJY=;
        b=h2qP4oCq2VK0IpUMdssCe3ZU/XuWUjlDYm6nd4mcJMczkGfrzZMfgqYkV/pWEUaBb9E2rA
        JkyS8Ff2nMCvSfN4WUkkcZYouDKvrlGqpewMipm6ydswQQrhgPvXkpr8/YrZ8uLJ8v+I4J
        Fhigw+vXpJ1rtlEpXz01/mbqX57ZaeA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c399745 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 10:52:56 +0000 (UTC)
Date:   Sat, 25 Jun 2022 12:52:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 6/6] vfio: do not set FMODE_LSEEK flag
Message-ID: <YrbpBoYR7cSYlLR9@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-7-Jason@zx2c4.com>
 <YrYyT0msDtQWSdSs@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrYyT0msDtQWSdSs@ZenIV>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:53:19PM +0100, Al Viro wrote:
> On Fri, Jun 24, 2022 at 06:56:31PM +0200, Jason A. Donenfeld wrote:
> > This file does not support llseek, so don't set the flag advertising it.
> 
> ... or it could grow a working llseek - doesn't look like it would be
> hard to do...

I started doing this, but it looks somewhat involved and a bit out of
scope here. vfio_device_ops would need to grow a new member, and then
the various types of vfio devices would need to start using it and so
forth. I'll save that for another series.

Jason
