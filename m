Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327B55ECAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiF1Sgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 14:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiF1Sgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:36:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C01F63D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yYNL0wXAVauQl3AW7aadY26+DFdEzYsbe5qQbwSJNh4=; b=BHFfFMm31MaiDU9gUlc5urXtnD
        TQtJ7v6QODoXB2IgWGgbAs4xMp255Am+nfr4/Q/EmKGZ/TFXMfXiapqnbzxOHc8K/fEYVUfbKvKEY
        HB/c1m4P7nNnzscCGmGXyxHgIlSglugkAVabuH7fallETnDzwkfzHSaeIY/0reuZyIL6v4Y3WnNc8
        tsqQHpsC8lEdc4fi8E9pNX8hylEt88Z/8bsL/SbdyG+y7XsHIWwJuGoot8xXxUFAI0VBVCEbkvzzt
        6eubTTi3rYpx6w2kKOOixc7jixtFFr4cojZQOCy2RDOpJAa3RFU8vWH6aey9tb5g7wVXBY2b14APs
        LayDbg+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o6G4j-005i7Y-FQ;
        Tue, 28 Jun 2022 18:36:37 +0000
Date:   Tue, 28 Jun 2022 19:36:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 08/44] copy_page_{to,from}_iter(): switch iovec variants
 to generic
Message-ID: <YrtKNf6OgP8qkE0p@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-8-viro@zeniv.linux.org.uk>
 <20220628123205.4mh7luq5lha2c2qe@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628123205.4mh7luq5lha2c2qe@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:32:05PM +0200, Christian Brauner wrote:
> On Wed, Jun 22, 2022 at 05:15:16AM +0100, Al Viro wrote:
> > we can do copyin/copyout under kmap_local_page(); it shouldn't overflow
> > the kmap stack - the maximal footprint increase only by one here.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Assuming the WARN_ON(1) removals are intentional,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Deliberate - it shouldn't be any different from what _copy_to_iter() and
_copy_from_iter() are ready to handle.
