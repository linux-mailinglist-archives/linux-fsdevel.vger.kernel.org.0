Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC72AAED5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgKIBuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgKIBuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:50:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 17:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AobZxJ/HiQYFTgs4zqC9zfaXXKVlXCBSCwwjLD1KjZ0=; b=VPWIUXEkn7yjll3UOVUmXLbIcA
        YMnxFyPYYzn4DTPL5anGuzZwIqHfAh9oX4jdLowsEs29/895OopcscxmA620gE0/nJ4NfTqMY7URw
        BNexVF7JDxKxv6ip9/Zc+HOuSB97Y2UqkQ5g7YX8LDudu5YajcnTkxNwl6uUGY+TuGZ7ZiqcHL+cn
        lsnmsZsfxBBb09s6jr/22M2VHJIojwdAeqd1IOT//5TfZ2nqH9g7/SdY6H5f7XEQ3stg0lzbRqSlQ
        BZb2pyGvLHNu/ahXhtbz/ind2IYXxf7AIsUiLozPIg3uelHzStb/4dX9Qd6kVfUYinbp9kaU47BSA
        23tCnATw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbwJl-0006Kt-Lq; Mon, 09 Nov 2020 01:50:01 +0000
Date:   Mon, 9 Nov 2020 01:50:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        Jan Kara <jack@suse.cz>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201109015001.GX17076@casper.infradead.org>
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109013322.GA9685@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> > to XA_ZERO_ENTRY for representing holes in files.
> 
> Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
> same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
> because we took a read fault on a sparse file hole").

There's no current user of XA_ZERO_ENTRY in i_pages, whether it be
DAX or non-DAX.

> > XA_ZERO_ENTRY
> > is defined in include/linux/xarray.h, where it's defined using
> > xa_mk_internal(257). This function returns a void pointer, which
> > is incompatible with the bitwise arithmetic it is performed on with.

We don't really perform bitwise arithmetic on it, outside of:

static int dax_is_zero_entry(void *entry)
{
        return xa_to_value(entry) & DAX_ZERO_PAGE;
}

> > Currently, DAX_ZERO_PAGE is defined as an unsigned long,
> > so I considered typecasting it. Typecasting every time would be
> > repetitive and inefficient. I thought about making a new definition
> > for it which has the typecast, but this breaks the original point of
> > using already defined terms.
> > 
> > Should we go the route of adding a new definition, we might as
> > well just change the definition of DAX_ZERO_PAGE. This would
> > break the simplicity of the current DAX bit definitions:
> > 
> > #define DAX_LOCKED      (1UL << 0)
> > #define DAX_PMD               (1UL << 1)
> > #define DAX_ZERO_PAGE  (1UL << 2)
> > #define DAX_EMPTY      (1UL << 3)

I was proposing deleting the entire bit and shifting DAX_EMPTY down.
