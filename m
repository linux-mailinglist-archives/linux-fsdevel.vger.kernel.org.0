Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12814A788C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbiBBTN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 14:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiBBTN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:13:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52AC061714;
        Wed,  2 Feb 2022 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=v2e0WdPhnMuqy5lca2IGo1LNlcc3q9ND2Vr3RjYckkw=; b=BqlgWZqQiTtxFsxiRg9sLdQInC
        rZqlvuvfTGyPyGGB66p5K/976jM5Ql5WDA+zI+6OMNXbxPBz2C6NBtmC9/hWqWTn0AMIXMxnvvA91
        5ydTLFr2o1lSXhubUQt1ALg6bljW7spNcfO3OF6okRAmcf6t9egkcG5aHwVla26KPU1JGVqFM1DN0
        PWNHxvik2ZHI068aaMr4OXbws4SFu0nwrJAPFLzut9ox9CxKLTVZLD7i7w7iq1PhHXZ3rliBtiRzI
        a2Jn1Uc21WrowrNj4WirmIe59FY03ZAwzLfA4wsmFn8pscyNzst84I9oWb9AGLk9wRiwA/cAFdWrH
        +RD1N23A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFL4G-00Fjda-Ny; Wed, 02 Feb 2022 19:13:24 +0000
Date:   Wed, 2 Feb 2022 19:13:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     BTRFS <linux-btrfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: How to debug stuck read?
Message-ID: <YfrX1BVIlIwiVYzs@casper.infradead.org>
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 07:15:14PM +0200, Dāvis Mosāns wrote:
> I have a corrupted file on BTRFS which has CoW disabled thus no
> checksum. Trying to read this file causes the process to get stuck
> forever. It doesn't return EIO.
> 
> How can I find out why it gets stuck?

> $ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
> folio_wait_bit_common (mm/filemap.c:1314)
> filemap_get_pages (mm/filemap.c:2622)
> filemap_read (mm/filemap.c:2676)
> new_sync_read (fs/read_write.c:401 (discriminator 1))

folio_wait_bit_common() is where it waits for the page to be unlocked.
Probably the problem is that btrfs isn't unlocking the page on
seeing the error, so you don't get the -EIO returned?
