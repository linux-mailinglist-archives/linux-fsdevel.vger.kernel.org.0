Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3891B304A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUT0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUT0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:26:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E6CC0610D5;
        Tue, 21 Apr 2020 12:26:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQyWW-007mYP-P6; Tue, 21 Apr 2020 19:25:36 +0000
Date:   Tue, 21 Apr 2020 20:25:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421192536.GG23230@ZenIV.linux.org.uk>
References: <20200421154204.252921-1-hch@lst.de>
 <20200421154204.252921-2-hch@lst.de>
 <20200421184941.GD23230@ZenIV.linux.org.uk>
 <20200421190148.GA26071@lst.de>
 <20200421191909.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191909.GF23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:19:09PM +0100, Al Viro wrote:
> On Tue, Apr 21, 2020 at 09:01:48PM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 21, 2020 at 07:49:41PM +0100, Al Viro wrote:
> > > >  	spin_lock(&ctx->csa.register_lock);
> > > > -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> > > > +	__spufs_proxydma_info_read(ctx, &info);
> > > > +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));
> > > 
> > > IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
> > > the damn thing goes through copy_to_user().  Why bother with separate access_ok()
> > > here?
> > 
> > I have no idea at all, this just refactors the code.
> 
> Wait a bloody minute, it's doing *what* under a spinlock?

... and yes, I realize that it's been broken the same way.  It still needs fixing.
AFAICS, that got broken in commit bf1ab978be23 "[POWERPC] coredump: Add SPU elf
notes to coredump." when spufs_proxydma_info_read() had copy_to_user() (until
then done after dropping the spinlock) moved into an area where blocking is very
much *not* allowed.
