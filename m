Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8283855E3A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345879AbiF1Mpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbiF1Mpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457B23BDF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D4FBB81E01
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297F5C3411D;
        Tue, 28 Jun 2022 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656420330;
        bh=2X7QgBSMR2DwkBBUlxIqciUTi9dL4qqqBxowGxNwo0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFvXG+nKW18Yn/81X7M/rqvSZj2rW5TgDpsKUcbk1UsvMRBG3dnIDHA5ABAACCxFB
         rJNHsi/vvYFmC4RwW5DOWuv/pnLD2hnvmO5HYGR56XbJoqAgNXofkIsmZ3Gto6ZC1s
         qOhOtlXUFIpCVIajSBRkgPBizi46yUBw2hLsMMkC3h8wAeClK4tkPPtjaCSLTwwDby
         Ojur+DzPrQq3hPtVp7CkCAaOEHgNOGZaZJ0Vt7a9atUgzNGVuAHm1ixCaK8tGhyLX/
         7HXUVjD+CKHpFRx/u2wmoUQjVBZGw9LPBde7cawBNBA2VsW7qzcLFg7aNdieKhOr5v
         yNHA8Y4/YYcYQ==
Date:   Tue, 28 Jun 2022 14:45:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 14/44] ITER_PIPE: helper for getting pipe buffer by index
Message-ID: <20220628124525.ghau343tekmptqkx@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-14-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-14-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:22AM +0100, Al Viro wrote:
> pipe_buffer instances of a pipe are organized as a ring buffer,
> with power-of-2 size.  Indices are kept *not* reduced modulo ring
> size, so the buffer refered to by index N is
> 	pipe->bufs[N & (pipe->ring_size - 1)].
> 
> Ring size can change over the lifetime of a pipe, but not while
> the pipe is locked.  So for any iov_iter primitives it's a constant.
> Original conversion of pipes to this layout went overboard trying
> to microoptimize that - calculating pipe->ring_size - 1, storing
> it in a local variable and using through the function.  In some
> cases it might be warranted, but most of the times it only
> obfuscates what's going on in there.
> 
> Introduce a helper (pipe_buf(pipe, N)) that would encapsulate
> that and use it in the obvious cases.  More will follow...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
