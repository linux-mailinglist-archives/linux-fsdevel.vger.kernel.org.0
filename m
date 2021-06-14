Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573103A5B4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 03:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFNBTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhFNBTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 21:19:31 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C99C061574;
        Sun, 13 Jun 2021 18:17:29 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsbDt-007rq5-Aw; Mon, 14 Jun 2021 01:17:05 +0000
Date:   Mon, 14 Jun 2021 01:17:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <YMauEdVL/RoycCPS@zeniv-ca.linux.org.uk>
References: <20210608161327.1537919-1-hch@lst.de>
 <202106081033.F59D7A4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106081033.F59D7A4@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:34:29AM -0700, Kees Cook wrote:
> > diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> > index 8adabde685f1..328da35da390 100644
> > --- a/fs/pstore/Kconfig
> > +++ b/fs/pstore/Kconfig
> > @@ -173,6 +173,7 @@ config PSTORE_BLK
> >  	tristate "Log panic/oops to a block device"
> >  	depends on PSTORE
> >  	depends on BLOCK
> > +	depends on BROKEN
> >  	select PSTORE_ZONE
> >  	default n
> >  	help
> > -- 
> > 2.30.2
> > 
> 
> NAK, please answer my concerns about your patches instead:
> https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

	How about concerns about the code in question having gotten
into the kernel in the first place?  Quality aside (that's a separate
conversation, probably for tomorrow), just what happens if that thing
is triggered by the code that happens to hold a page on block device
locked?  AFAICS, __generic_file_write_iter() will cheerfully deadlock...

	Kees, may I ask you where had that thing been discussed back
then?  All I can see is linux-kernel, and that's "archived by", not
"discussed on"...
