Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEB689F42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 17:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjBCQ3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 11:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjBCQ3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:29:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA3A7ED7;
        Fri,  3 Feb 2023 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aKb0TcrT5HcwknHd0UpHTjJTmEsJjOCtGhiYiz34rX4=; b=F5eJctUgZhs3Fw+CRoaIZxwLr5
        QLrqqcy2wvllXqLy302hai+Ai+zxqMtdQx9W1Y6Tg0bhXD9arU5mgpKe+m44Lv82ov2FoiuUbAJA/
        dpQ1p9lIfH8mpwUIT4GDlkGxJpgJic3E+5q0zA67mFwusHbShYPeBbitkBNAcMDBZaKtttUuTTkuI
        5vwv1oZBMEEPZRd8nTxIyMCh5ELDr6k0hrsIwc0xaBR07opZesopKjVl+vut4xXKESSa5GzOgD1gt
        zifZLK3DMeyTLJwcNy1mg/3OVy6MIFZH5F7gKd50xvr3ldC4GrFIS0u7k+igKDP+YvGKkVYeryWiw
        Ws461cTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNywV-00ESXM-OO; Fri, 03 Feb 2023 16:29:39 +0000
Date:   Fri, 3 Feb 2023 16:29:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 0/5] Fix a minor POSIX conformance problem
Message-ID: <Y902c9MRvXghKJMy@casper.infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
 <DCEDB8BB-8D10-4E17-9C27-AE48718CB82F@dilger.ca>
 <Y90KTSXCKGd8Gaqc@casper.infradead.org>
 <c16be18cb68a4adbbcd73cf9be9472df@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16be18cb68a4adbbcd73cf9be9472df@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:23:32PM +0000, David Laight wrote:
> From: Matthew Wilcox
> > "The system shall always zero-fill any partial page at the end of an
> > object. Further, the system shall never write out any modified portions
> > of the last page of an object which are beyond its end. References
> > within the address range starting at pa and continuing for len bytes to
> > whole pages following the end of an object shall result in delivery of
> > a SIGBUS signal."
> > 
> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html
> 
> It also says (down at the bottom of the rational):
> 
> "The mmap() function can be used to map a region of memory that is larger
> than the current size of the object. Memory access within the mapping but
> beyond the current end of the underlying objects may result in SIGBUS
> signals being sent to the process. The reason for this is that the size
> of the object can be manipulated by other processes and can change at any
> moment. The implementation should tell the application that a memory
> reference is outside the object where this can be detected; otherwise,
> written data may be lost and read data may not reflect actual data in the
> object."
> 
> There are a lot of 'may' in that sentence.
> Note that it only says that 'data written beyond the current eof may be
> lost'.
> I think that could be taken to take precedence over the zeroing clause
> in ftruncate().

How can the _rationale_ (explicitly labelled as informative) for one
function take precedence over the requirements for another function?
This is nonsense.

> I'd bet a lot of beer that the original SYSV implementation (on with the
> description is based) didn't zero the page buffer when ftruncate()
> increased the file size.
> Whether anything (important) actually relies on that is an interesting
> question!
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
