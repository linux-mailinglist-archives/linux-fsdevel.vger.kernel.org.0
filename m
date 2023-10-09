Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C87BD46D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjJIHgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJIHgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:36:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA58594;
        Mon,  9 Oct 2023 00:36:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16153C433C8;
        Mon,  9 Oct 2023 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696837010;
        bh=cyOr9wKSZbKTmoYhGi29W/BehcsluNpyqFhmV/79LkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuorHarbeq5vdYq06nmPq8nGX2pDzlhYY2aIguVOKLx86qrspW9qfoRixSiD2oG1N
         BX1bPZiKVWe177iMU3qJ145/6+2QVdLkcYwZxGa8AO5oMtIqJfoIk3nVEGqVXjIFOK
         veC1rvqC5QOFNQ1rskp5a1QGWowZeU/MLKC+k7IX27yaqQPwaC/2E0+1aTIIPnF7Zi
         jRQ0blTp93aKHoihZBYvcrr6adET4DoQoSOx+8sYbZ4o9kQCrjGdrCzmS/dXLNJkwz
         3hZTLiNv/d324k7T+CNsBKZE4Ai4/PYv3wZJOz/fGp/BoLGTd6qJlk9ik3kuHHAfUA
         f5I0X9VQZ9jOA==
Date:   Mon, 9 Oct 2023 09:36:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
Message-ID: <20231009-bannen-hochwasser-3f0268372b80@brauner>
References: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
 <20230925120309.1731676-9-dhowells@redhat.com>
 <20230925120309.1731676-1-dhowells@redhat.com>
 <1809398.1696238751@warthog.procyon.org.uk>
 <231155.1696663754@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <231155.1696663754@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 07, 2023 at 08:29:14AM +0100, David Howells wrote:
> Hugh Dickins <hughd@google.com> wrote:
> 
> > -		__copy_from_iter(p, n, i);
> > +		n = __copy_from_iter(p, n, i);
> 
> Yeah, that looks right.  Can you fold it in, Christian?

Of course. Folded into
c9eec08bac96 ("iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()")
on vfs.iov_iter.
