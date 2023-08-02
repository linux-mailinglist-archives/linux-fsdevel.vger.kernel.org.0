Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32B76CBFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjHBLrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjHBLrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:47:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B04213D;
        Wed,  2 Aug 2023 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EXLK/pRlg6GpBRndxugWt2D7Ek+uHN7KXz/ZmRarsw4=; b=mk08BRK+VtOlvuIRUJCoptKPgE
        DqWudXiToITeYjxGg2Ump/aFV02mKpyS8m/wBGj/2dl0wVVGOHsehSH3r9RR7fKsFY+F5NLuTRngH
        0LYkrsodrW1YTW3w2Eiw7kWniT34AYp9gjRYrPt+mHE3Y+vcAOB69/lrR7YYyb3rNOMflGNZpus2C
        RX7UO7TH7rcPQSymYTSNdTFY876US95+ZLhqvt0zY81L+0t9EYGBwrAEqGlXfkUhMPgnSCCiW+22m
        PysldnIq1CNFql8df9GsQ5ZqpcCELmHgVwbAh0DuWj5avc3N0Y3Wpje5MqGAHbHm9lrxdCWDyN/I9
        fkaxk/Ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qRAJy-004pus-2m;
        Wed, 02 Aug 2023 11:47:18 +0000
Date:   Wed, 2 Aug 2023 04:47:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 05/20] block: Allow bio_iov_iter_get_pages() with
 bio->bi_bdev unset
Message-ID: <ZMpCRpNyt0EJpg9G@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-6-kent.overstreet@linux.dev>
 <ZL62HKrAJapXfcaR@infradead.org>
 <20230725024312.alq7df33ckede2gb@moria.home.lan>
 <ZMEeOZZcOu2p0SDP@infradead.org>
 <20230801190450.3lbr2hjdi7t52anx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801190450.3lbr2hjdi7t52anx@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:04:50PM -0400, Kent Overstreet wrote:
> > Because blk-cgroup not only works at the lowest level in the stack,
> > but also for stackable block devices.  It's not a design decision I
> > particularly agree with, but it's been there forever.
> 
> You're setting the association only to the highest block device in the
> stack - how on earth is it supposed to work with anything lower?

Hey, ask the cgroup folks as they come up with it.  I'm not going to
defend the logic here.

> And looking at bio_associate_blkg(), this code looks completely broken.
> It's checking bio->bi_blkg, but that's just been set to NULL in
> bio_init().

It's checking bi_blkg because it can also be called from bio_set_dev.

> And this is your code, so I think you need to go over this again.

It's "my code" in the sene of that I did one big round of unwinding
the even bigger mess that was there.  There is another few rounds needed
for the code to vaguely make sense.
