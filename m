Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E7D1F114E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 04:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFHCF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 22:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgFHCF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:05:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C2C08C5C3;
        Sun,  7 Jun 2020 19:05:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1ji7AA-004wgp-2Q; Mon, 08 Jun 2020 02:05:22 +0000
Date:   Mon, 8 Jun 2020 03:05:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
Message-ID: <20200608020522.GN23230@ZenIV.linux.org.uk>
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
 <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
 <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
 <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 12:48:53PM -0700, Linus Torvalds wrote:

> Rasmus, say the word and I'll mark you for authorship on the first one.
> 
> Comments? Can you find something else wrong here, or some other fixup to do?
> 
> Al, any reaction?

It's correct, but this

> +	if (mask & (mode ^ (mode >> 3))) {
> +		if (in_group_p(inode->i_gid))
> +			mode >>= 3;
> +	}
> +
> +	/* Bits in 'mode' clear that we require? */
> +	return (mask & ~mode) ? -EACCES : 0;

might be easier to follow if we had, from the very beginning done
	unsigned int deny = ~inode->i_mode;
and turned that into

	// for group the bits 3..5 apply, for others - 0..2
	// we only care which to use when they do not
	// agree anyway.
	if (mask & (deny ^ (deny >> 3))) // mask & deny != mask & (deny >> 3)
		if (in_...
			deny >>= 3;
	return mask & deny ? -EACCES : 0;

Hell knows...
