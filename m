Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACB744C5FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhKJRdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:33:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB941C061764;
        Wed, 10 Nov 2021 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WcUjZH1EzX6yTX4p+7INWloPdAndzg1p6tbNLkSRue8=; b=BVophCKHCVxfxXq52lon2r77En
        DkfrT7kkJ1SBgxUzuNOhKwlHlgha7LVo5+yEJjAyRSJVEfEaeZG6+0os+fKb+u0AEqty1rOid449H
        8/QOfufvj7rittgThxWYHhSeGt7U68shQay+8zKrxw2Vufqp4Rt/jv1FrNl6QdZ6wcvTfSkqc0N2N
        AEe2EUPpbR6UEbDqMaTw1EJeQdfXYD8gvqXpwhPLdrfR6aoTrvT/EJQLNQP7F0OC0YgRgzFrCaiaU
        miosAlN/h7g4A9R46nk5XyQ1urkFkuvMKnwFBV5SwG7oEFdC3oB/TyS8oY11qSsW/hMtDlluEBNs4
        UAMr/y9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkrR0-0023Jn-JN; Wed, 10 Nov 2021 17:30:54 +0000
Date:   Wed, 10 Nov 2021 17:30:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] initramfs: print helpful cpio error on "crc" magic
Message-ID: <YYwBzj0isuKOjjUe@casper.infradead.org>
References: <20211110123850.24956-1-ddiss@suse.de>
 <20211110123850.24956-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110123850.24956-3-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 01:38:48PM +0100, David Disseldorp wrote:
> Contrary to the buffer-format.rst documentation, initramfs cpio
> extraction does not support "crc" archives, which carry "070702"
> header magic. Make it a little clearer that "newc" (magic="070701") is
> the only supported cpio format, by extending the POSIX.1 ASCII
> (magic="070707") specific error message to also cover "crc" magic.

Wouldn't it be easier to just add support?  As far as I can tell from
looking at documentation, the "crc" format is the same as newc, except
that it uses some reserved bits to store the crc.  Since we ignore those
bits, we could just check for either 070701 or 070702.

> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 2f79b3ec0b40..44e692ae4646 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -258,7 +258,7 @@ static int __init do_collect(void)
>  static int __init do_header(void)
>  {
>  	if (memcmp(collected, "070701", 6)) {
> -		if (memcmp(collected, "070707", 6) == 0)
> +		if (memcmp(collected, "0707", 4) == 0)
>  			error("incorrect cpio method used: use -H newc option");
>  		else
>  			error("no cpio magic");
> -- 
> 2.31.1
> 
