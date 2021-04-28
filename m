Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2936D7E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 15:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhD1NE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 09:04:28 -0400
Received: from verein.lst.de ([213.95.11.211]:49158 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhD1NE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:04:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A80F68C7B; Wed, 28 Apr 2021 15:03:40 +0200 (CEST)
Date:   Wed, 28 Apr 2021 15:03:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arusekk <arek_koz@o2.pl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] proc: Use seq_read_iter where possible
Message-ID: <20210428130339.GA30329@lst.de>
References: <20210427183414.12499-1-arek_koz@o2.pl> <20210428061259.GA5084@lst.de> <9905352.nUPlyArG6x@swift.dev.arusekk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9905352.nUPlyArG6x@swift.dev.arusekk.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:02:13PM +0200, Arusekk wrote:
> The instructions at the entry point of the executable being inspected.
> The flow of the tool:
> - parse ELF headers of the binary to be inspected,
> - locate its entry point position in the file,
> - write short code at the location (this short code has used sendfile so far),
> - execute the patched binary,
> - parse the output and extract information about the relevant mappings.
> This can be seen as equivalent to setting LD_TRACE_LOADED_OBJECTS,
> but also works for static binaries, and is a bit safer.
> 
> The problem was reported at:
> https://github.com/Gallopsled/pwntools/issues/1871

Oh, this patches just the userspace binarz, ok.

> > Linus did object to blindly switching over all instances.
> 
> I know, I read that, but I thought that pointing a real use case, combined 
> with the new interface being used all throughout the other code, might be 
> convincing.
> I would be happy with only changing the f_ops of /proc/.../maps, even if only 
> on MMU-enabled systems, but I thought that consistence would be better.
> This is my first time contributing to Linux, so I am very sorry for any wrong 
> assumptions, and glad to learn more.

Unless Linus changed his mind just patching the file you care about for
now seems like the best idea.
