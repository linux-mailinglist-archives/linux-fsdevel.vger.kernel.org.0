Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1D3E3B20
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhHHPft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHPfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 11:35:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61CBC061760;
        Sun,  8 Aug 2021 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+6AA0NxjMhZgnwgqTpBVqlB3Q6+197HzgumUBQ6qcrw=; b=XmuC5TKVtFDgjjrbI2ao6t8Tsi
        cNFzUy9H6cRJ1i/K+ZzhjFrYQMTAj5UosnmHIVAfXdYcLFq11WRWtq3BiOWRCen7VvTpDacsPKwop
        G8fnQ4OKH8rmFJn59GtUJ0QXQmY7G+iiq3EYr0BBk+F27naeOTDiYquJNjUOj/ywAYw+t67gAJ/HV
        Kj8WYoRN2FUSnLCAossMwPOuqGON0vwCEpW77xBQIVl0JEF3DHx9nl9sXnNc6hC1pn+dCNEhMm0lA
        SaWVYYVW0ZMCvObZDVMARLOUWamAfUoxIGtJuagr0k/8sMf0waMKGNCfkyAl84Os4lxNmBEdhVBGU
        E3YbcsLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCkp6-00A5da-DD; Sun, 08 Aug 2021 15:34:54 +0000
Date:   Sun, 8 Aug 2021 16:34:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: optimise generic_write_check_limits()
Message-ID: <YQ/5mCUBmfCWoyVs@casper.infradead.org>
References: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
 <YQ04/NFn8b6cykPQ@casper.infradead.org>
 <567d7e15f59a45f6ab94428261b3e473@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567d7e15f59a45f6ab94428261b3e473@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 08, 2021 at 02:41:13PM +0000, David Laight wrote:
> From: Matthew Wilcox
> > Sent: 06 August 2021 14:28
> > 
> > On Fri, Aug 06, 2021 at 12:22:10PM +0100, Pavel Begunkov wrote:
> > > Even though ->s_maxbytes is used by generic_write_check_limits() only in
> > > case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
> > > and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
> > > if it's not going to be used.
> > 
> > Is this "optimisation" actually worth anything?  Look at how
> > force_o_largefile() is used.  I would suggest that on the vast majority
> > of machines, O_LARGEFILE is always set.
> 
> An option would be to only determine ->s_maxbytes when the size
> if larger than MAX_NON_LFS.
> 
> So you'd end up with something like:
> 
> 	if (pos >= max_size) {
> 		if (!(file->f_flags & O_LARGEFILE))
> 			return -EFBIG;
> 		inode = file->f_mapping->host;
> 		if (pos >= inode->i_sb->s_maxbytes)
> 			return -EFBIG;
> 	}

You're optimising the part of the function that you can see in the
diff instead of the whole function.  And there's no evidence that
there's much win to be had here ...
