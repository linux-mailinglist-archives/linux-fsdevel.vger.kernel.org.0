Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AA3A6D42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhFNRfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhFNRfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:35:53 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484BC061574;
        Mon, 14 Jun 2021 10:33:50 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsqSt-008ALc-Bt; Mon, 14 Jun 2021 17:33:35 +0000
Date:   Mon, 14 Jun 2021 17:33:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>, axboe@kernel.dk,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        gmpy.liaowx@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <YMeS780YarlA30E0@zeniv-ca.linux.org.uk>
References: <20210608161327.1537919-1-hch@lst.de>
 <202106081033.F59D7A4@keescook>
 <20210614070712.GA29881@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614070712.GA29881@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:07:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 08, 2021 at 10:34:29AM -0700, Kees Cook wrote:
> > NAK, please answer my concerns about your patches instead:
> > https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/
> 
> No.  This code pokes into block layer internals with all kinds of issues
> and without any signoff from the relevant parties.  We just can't keep it
> around.

There's a much more interesting question about that code: seeing that
psblk_generic_blk_write() contains this
        /* Console/Ftrace backend may handle buffer until flush dirty zones */
	if (in_interrupt() || irqs_disabled())
		return -EBUSY;
just what are the locking conditions guaranteed to that thing?
Because if it's ever called with one of the destination pages
held locked by the caller, we are fucked.  It won't get caught
by that test.

That really should've been discussed back when the entire thing
got merged; at the absolute least we need the locking environment
documented.
