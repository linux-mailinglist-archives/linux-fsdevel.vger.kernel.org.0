Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC06CCB8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC1UiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC1UiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:38:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78971FDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6VEMyMAylbvcGGJ3YdTfsXsIcfRhCqojazFU2K00sH0=; b=D671lvPOQqfcYgm3jOcY6UVN2M
        mMhAnFhkyzh0H5axxXcZ/gQOpy3GF3Tl4KHCxAegr6WtaUUdUlNWob+fR9h0C48au6SCLZDPxFGuR
        UL8/Ps43wi2a0ILEuNqP8xJid0cFfIuyXsRxGzmSv3Ey0tHqO/H2XYNUluHIVqCtBiXeS7EaNDe++
        M6URtqfJ9XY1+DlaG9KSwAZoxUZgBTWD+plOyAv/1cWLa2wPn0+ws18vYddxf/Vyyvts6lhaFugq3
        YdBITmLGTDVOtwge6E5K4GXXSIVv+Qp3lry9OVgUEJxQPQVPE1xJRvpym06qSTTLIq/b4mtNSGBa0
        opXPMeoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phG4x-002xA8-1v;
        Tue, 28 Mar 2023 20:38:03 +0000
Date:   Tue, 28 Mar 2023 21:38:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Message-ID: <20230328203803.GN3390869@ZenIV>
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:43:34AM -0700, Linus Torvalds wrote:

> And if you go blind from looking at that patch, I will not accept
> responsibility.

... and all that, er, cleverness - for the sake of a single piece of shit
driver for piece of shit hardware *and* equally beautiful ABI.

Is it really worth bothering with?  And if anyone has doubts about the
inturdprize kwality of the ABI in question, I suggest taking a look at
hfi1_user_sdma_process_request() - that's where the horrors are.
