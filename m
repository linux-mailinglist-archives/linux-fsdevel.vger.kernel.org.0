Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAFE207B13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbgFXR7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 13:59:12 -0400
Received: from verein.lst.de ([213.95.11.211]:45420 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405929AbgFXR7L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:59:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16BA068B02; Wed, 24 Jun 2020 19:59:05 +0200 (CEST)
Date:   Wed, 24 Jun 2020 19:59:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624175905.GA25981@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175644.GR21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624175644.GR21350@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:56:44PM +0100, Matthew Wilcox wrote:
>  	/* don't even try if the size is too large */
> +	error = -ENOMEM;
>  	if (count > KMALLOC_MAX_SIZE)
> -		return -ENOMEM;
> +		goto out;
> +	kbuf = kzalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		goto out;
>  
>  	if (write) {
> +		error = -EFAULT;
> +		if (!copy_from_iter_full(kbuf, count, iter))
>  			goto out;
>  	}

The nul-termination for the write cases seems to be lost here.
