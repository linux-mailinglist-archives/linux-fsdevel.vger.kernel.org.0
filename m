Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCD1B2FB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgDUTBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:01:51 -0400
Received: from verein.lst.de ([213.95.11.211]:48364 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgDUTBv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:01:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A51B68C4E; Tue, 21 Apr 2020 21:01:48 +0200 (CEST)
Date:   Tue, 21 Apr 2020 21:01:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421190148.GA26071@lst.de>
References: <20200421154204.252921-1-hch@lst.de> <20200421154204.252921-2-hch@lst.de> <20200421184941.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421184941.GD23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:49:41PM +0100, Al Viro wrote:
> >  	spin_lock(&ctx->csa.register_lock);
> > -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> > +	__spufs_proxydma_info_read(ctx, &info);
> > +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));
> 
> IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
> the damn thing goes through copy_to_user().  Why bother with separate access_ok()
> here?

I have no idea at all, this just refactors the code.
