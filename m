Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33532472DA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 14:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhLMNmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 08:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhLMNmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:42:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF694C061574;
        Mon, 13 Dec 2021 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fzITg/C3AS/xrQ0JoO9TDJsVEk/WX7/81xritNYAsiM=; b=a3g9gHu2+gfYdV7A698je03RQW
        U3hQDkE6nmLgCdzcacomQPwTyfAEMg8EbiUnwbA1r+G4w8GHzmG8bNzGWm2Rgyjx9S+vaB16ho13J
        MBXtE5Eff2mDxmDJbd6xqqnH7MwRUvVuVklLEUvtBiPT65P70G52RhCfNikNrZq5ZJmsWDgoJpPOP
        4YmjK9Hi7l10AaGPO1KGlUoO9AG7xxU8D/EDx0Df2lyTnEwsf2CcXYWVAKMCckHCOcbSxS32XjJHa
        4wkLpX0pKi302peWLolD9n7Eh/yWFkQwWRfa+CX9u6JEaTdy0NYxiuUi195i7pDy+KCmTD8K6PZUB
        1krsfYVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwlb8-00CpkO-IA; Mon, 13 Dec 2021 13:42:34 +0000
Date:   Mon, 13 Dec 2021 13:42:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <YbdNyjqSugLqsEXN@casper.infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-4-willy@infradead.org>
 <20211213080257.GC20986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213080257.GC20986@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:02:57AM +0100, Christoph Hellwig wrote:
> >  
> >  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> >  {
> > -	return read_from_oldmem(buf, count, ppos, 0,
> > +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> > +	struct iov_iter iter;
> > +
> > +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> > +
> > +	return read_from_oldmem(&iter, count, ppos,
> >  				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> >  }
> 
> elfcorehdr_read should probably also take an iov_iter while we're at it.

I don't like how that looks.  For example:

@@ -1246,11 +1247,14 @@ static int __init parse_crash_elf64_headers(void)
        int rc=0;
        Elf64_Ehdr ehdr;
        u64 addr;
+       struct iov_iter iter;
+       struct kvec kvec = { .iov_base = &ehdr, .iov_len = sizeof(ehdr) };

        addr = elfcorehdr_addr;

        /* Read Elf header */
-       rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
+       iov_iter_kvec(&iter, READ, &kvec, 1, sizeof(ehdr));
+       rc = elfcorehdr_read(&iter, &addr);
        if (rc < 0)
                return rc;

@@ -1277,7 +1281,10 @@ static int __init parse_crash_elf64_headers(void)
        if (!elfcorebuf)
                return -ENOMEM;
        addr = elfcorehdr_addr;
-       rc = elfcorehdr_read(elfcorebuf, elfcorebuf_sz_orig, &addr);
+       kvec.iov_base = elfcorebuf;
+       kvec.iov_len = elfcorebuf_sz_orig;
+       iov_iter_kvec(&iter, READ, &kvec, 1, elfcorebuf_sz_orig);
+       rc = elfcorehdr_read(&iter, &addr);
        if (rc < 0)
                goto fail;


I don't think this makes the code clearer, and it's already pretty ugly
code.  I'd rather leave constructing the iov_iter to elfcorehdr_read().
(Same remarks apply to elfcorehdr_read_notes())

> I also don't quite understand why we even need the arch overrides for it,
> but that would require some digging into the history of this interface.

I decided I didn't want to know ;-)
