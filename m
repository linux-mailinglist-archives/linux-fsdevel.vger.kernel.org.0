Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B033B0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCOLHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 07:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCOLHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:07:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6EC061574;
        Mon, 15 Mar 2021 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZNct6xQZmdqGLu6zErOv+egUq8txW2WfMM6pOnN2n3g=; b=dtYhnpMsslwvpumHLcwJwdLsHD
        WROzWdxeIaV6jPiAjErSDbOD9acTXWtdFrmYbToZayj0oK1HfRi/REoMwAOVn2RXEz3OyeT+e9HNZ
        s3f+qKcJEBuzomH2m8aAN7koZz9sp9k4drjUra5wNqkDVr4HPZt8XlN9w+Is9pC5FsshfoQzYJZVs
        5TavQncOUvfuX7DPtzsGd+JO6tnq3jxon18vz86j0MJ3GMOXqZM95vfWLldzUGAqElG297uKYistp
        Y43HCCQqTFyZt8T9gxWSd0U5K7Q7A5cc6Y3eX4rwiEo29+DFwEJSGkFNXPrSWtNUu+Dn7uX9m3egX
        i1Vti9AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLl3r-00021x-M8; Mon, 15 Mar 2021 11:07:01 +0000
Date:   Mon, 15 Mar 2021 11:06:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <20210315110659.GT2577561@casper.infradead.org>
References: <YEsryBEFq4HuLKBs@suse.de>
 <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de>
 <20210312131123.GZ3479805@casper.infradead.org>
 <YE8tQc66C6MW7EqY@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE8tQc66C6MW7EqY@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:47:45AM +0000, Luis Henriques wrote:
> On Fri, Mar 12, 2021 at 01:11:23PM +0000, Matthew Wilcox wrote:
> > On Fri, Mar 12, 2021 at 12:21:59PM +0000, Luis Henriques wrote:
> > > > > I've seen a bug report (5.10.16 kernel splat below) that seems to be
> > > > > reproducible in kernels as early as 5.4.
> > 
> > If this is reproducible, can you turn this BUG_ON into a VM_BUG_ON_PAGE()
> > so we know what kind of problem we're dealing with?  Assuming the SUSE
> > tumbleweed kernels enable CONFIG_DEBUG_VM, which I'm sure they do.
> 
> Just to make sure I got this right, you want to test something like this:
> 
>  				}
>  			}
> -			BUG_ON(page_mapped(page));
> +			VM_BUG_ON_PAGE(page_mapped(page), page);
>  			ret2 = do_launder_page(mapping, page);
>  			if (ret2 == 0) {
>  				if (!invalidate_complete_page2(mapping, page))

Yes, exactly.
