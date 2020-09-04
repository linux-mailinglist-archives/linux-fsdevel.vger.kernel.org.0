Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6C25D2A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIDHr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:47:58 -0400
Received: from verein.lst.de ([213.95.11.211]:40731 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIDHr5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:47:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBAAE68AFE; Fri,  4 Sep 2020 09:47:53 +0200 (CEST)
Date:   Fri, 4 Sep 2020 09:47:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/14] x86: remove address space overrides using
 set_fs()
Message-ID: <20200904074753.GA14932@lst.de>
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-13-hch@lst.de> <20200904025510.GO1236603@ZenIV.linux.org.uk> <20200904063813.GA12204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904063813.GA12204@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:38:13AM +0200, Christoph Hellwig wrote:
> > Wait a sec... how is that supposed to build with X86_5LEVEL?  Do you mean
> > 
> > #define LOAD_TASK_SIZE_MINUS_N(n) \
> > 	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
> > 		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
> > 
> > there?
> 
> Don't ask me about the how, but it builds and works with X86_5LEVEL,
> and the style is copied from elsewhere..

Actually, it doesn't any more.  Looks like the change to pass the n
parameter as suggested by Linus broke the previously working version.
