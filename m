Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285986CCA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC1Sm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjC1SmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:42:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EE1BF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tIy54zuhBMfDyu45DgWsNco3z2DtHuFnbxINxu3lp2E=; b=DeGN+O6WH16nMSy427XmgJTDyY
        G8N7NEoO/Q0rrNZx1EXT+OKJ4p0oZ/dfYGp9zeACRyJ6/gkeTW8IT8ShDs9cw263JwqcgjrmBphNX
        JHj8xItA0hCct/P7TGCZjTyw5cE8BsW21Iro+yDkTNyeE8yvhMBwabpocLwln7uxOiVbZeD9G3pPo
        fOWBh8hgRdFawmbqyNrm7kvIUZdLanEwaWFH0+C04iU/7oxZmqeglw8sEesLxjjSZ1xcTNhiG4SMx
        1hUwLMOVL/Yb6aORtwzN1wLzWMQfcBr8AnTieU6UO+g84R/eB9HVhwjL0TCsN3YamJM8hkOisbxmH
        na4P2qMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phEGy-002unL-2m;
        Tue, 28 Mar 2023 18:42:20 +0000
Date:   Tue, 28 Mar 2023 19:42:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCH 2/8] iov_iter: add iovec_nr_user_vecs() helper
Message-ID: <20230328184220.GL3390869@ZenIV>
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328173613.555192-3-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:36:07AM -0600, Jens Axboe wrote:
> This returns the number of user segments in an iov_iter. The input can
> either be an ITER_IOVEC, where it'll return the number of iovecs. Or it
> can be an ITER_UBUF, in which case the number of segments is always 1.
> 
> Outside of those two, no user backed iterators exist. Just return 0 for
> those.

Umm...  Why not set ->nr_segs to 1 in iov_iter_ubuf() instead?  Note that
it won't be more costly; that part of struct iov_iter (8 bytes at offset 40
on amd64) is *not* left uninitialized - zero gets stored there.  That way
you'll get constant 1 stored there, which is just as cheap...
