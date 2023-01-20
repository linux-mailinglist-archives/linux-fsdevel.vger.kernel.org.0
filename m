Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A4674BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 06:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjATFTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 00:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjATFSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:18:36 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF185360;
        Thu, 19 Jan 2023 21:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g/TYi0LB0LucaQ9Jt/Zfn/ruUAjCWhwXHm/cIx9iKKI=; b=MA/iuuf4iMjeYtuAHKwoM2MYx9
        7PcVfgg/wTBfnv68t3jrBAZfi2WWE3wARYXliZxVXkh+4+LEf0AhmW+E9BsP2hNLVN+gQHmKjATGr
        O2ZlcE2H9MV6PYHu5oWKo0TGQdfL83CfZtpki0QjrYT7W8jpq50t5DiFvZZWU38C/pKuPjVmwtgX9
        D1vzxHMw70EYzvNynDowQsCR3OkEy4BH5fpvEGA5iWSQ0hJbjMXC/QG6eq6BMoQ3eEwFOspbfYt3V
        cPELBST0kyhHzzpjrPHY9LCJpNMEOAiJJh5G6KgvExA2I5tEVIz3FIj9Dt3v5sWFzwdbCM/ilkxY3
        cATIMMuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIjcy-002vbe-0X;
        Fri, 20 Jan 2023 05:07:48 +0000
Date:   Fri, 20 Jan 2023 05:07:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8ohpDtqI8bPAgRn@ZenIV>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
 <Y8oYXEjunDDAzSbe@casper.infradead.org>
 <Y8ocXbztTPbxu3bq@ZenIV>
 <Y8oem+z9SN487MIm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8oem+z9SN487MIm@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:

> > Sure, but... there's also this:
> > 
> > static inline void __kunmap_local(const void *addr)
> > {
> > #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> >         kunmap_flush_on_unmap(addr);
> > #endif
> > }
> > 
> > Are you sure that the guts of that thing will be happy with address that is not
> > page-aligned?  I've looked there at some point, got scared of parisc (IIRC)
> > MMU details and decided not to rely upon that...
> 
> Ugh, PA-RISC (the only implementor) definitely will flush the wrong
> addresses.  I think we should do this, as having bugs that only manifest
> on one not-well-tested architecture seems Bad.
> 
>  static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> -       kunmap_flush_on_unmap(addr);
> +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
>  #endif
>  }

PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
