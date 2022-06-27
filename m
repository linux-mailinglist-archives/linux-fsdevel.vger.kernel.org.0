Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBCC55CE5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiF0Jis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiF0Jio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5D6335;
        Mon, 27 Jun 2022 02:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6516612A3;
        Mon, 27 Jun 2022 09:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E409C3411D;
        Mon, 27 Jun 2022 09:38:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fAPR5Jnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656322720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGTIlQ0ognNJhriKOu8KwAe4RJYfiDuDoUQUDY+58hY=;
        b=fAPR5JnxUvXSBQttuXGh/V5ytZ9k229MsPLuC0BSylr2gPWTgxims2aPgJH0Hh8Xt8JYLm
        Ry7jWuJlyu3tV1QqlhOW+O1OtGAKyxj+obfjETunznqOB7Zgws4loumtoRgESyw5jI/IMx
        U6LxF3s+3rTJ2GPbL+lPxBkYLirUi0I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70af3acb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Jun 2022 09:38:40 +0000 (UTC)
Date:   Mon, 27 Jun 2022 11:38:37 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 7/8] dma-buf: remove useless FMODE_LSEEK flag
Message-ID: <Yrl6nTFibUS7xISn@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-8-Jason@zx2c4.com>
 <YrlzkAlheCR0ZMuO@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrlzkAlheCR0ZMuO@phenom.ffwll.local>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Daniel,

On Mon, Jun 27, 2022 at 11:08:32AM +0200, Daniel Vetter wrote:
> On Sat, Jun 25, 2022 at 01:01:14PM +0200, Jason A. Donenfeld wrote:
> > This is already set by anon_inode_getfile(), since dma_buf_fops has
> > non-NULL ->llseek, so we don't need to set it here too.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> I'm assuming this is part of a vfs cleanup and lands through that tree?
> For that:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

With the exception of the first patch (which is more urgent), yes, that
is my assumption too.

Jason
