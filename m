Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48530379CBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEKCNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 22:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEKCNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 22:13:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217FC0611F0;
        Mon, 10 May 2021 19:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eUSRI0JZmtwpPAHEvA7U9mROT0jj9LqgYZga+g9YTUs=; b=XmbYOM/N5/Q/Kt8OBxM7uWzmRq
        eyZgMKgMqyH3ifh1cbWESf+CdpSfPpUYA3SALxP0j3oRuTJIegyTtczxH5SoxQx4WCQtKOzP5POJ4
        lvhtFMzVJPvNjzDkAT2X6b7aboSF9iaUjtGxJ9Dqx0MzaTm51QkctWB7m2srMOk2XNI7mNFuO27RS
        laJAjmV3nxFq+Qref8rgukI+W74zB+dfwaVwv5BrIrCGCHt1X9MLvbtntbk3qe+KlXFNnWaA4+AYG
        G6azaCZNYjXNZR3jeCM25NRaepr/SNQyordxRYULchCTNe1cc2IEqpi+Xa3BW6rgjvNzhjnjGs8Tg
        8q12cf3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgHoN-006nX0-Lz; Tue, 11 May 2021 02:08:08 +0000
Date:   Tue, 11 May 2021 03:07:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Compile warning with current kernel and netfs
Message-ID: <YJnm97asL8gtmL32@casper.infradead.org>
References: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 09:01:06PM -0500, Steve French wrote:
> Noticed the following netfs related new warning when compiling cifs.ko
> with the current 5.13-rc1

I don't see that ... what compiler & version are you using?

>   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/fscache.o
>   CHECK   /home/smfrench/cifs-2.6/fs/cifs/fscache.c
> /home/smfrench/cifs-2.6/fs/cifs/fscache.c: note: in included file
> (through include/linux/fscache.h,
> /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> unsigned int enum netfs_read_source
>   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/cache.o
>   CHECK   /home/smfrench/cifs-2.6/fs/cifs/cache.c
> /home/smfrench/cifs-2.6/fs/cifs/cache.c: note: in included file
> (through include/linux/fscache.h,
> /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> unsigned int enum netfs_read_source
> 
> It doesn't like this enum in include/linux/netfs.h:
> 
> enum netfs_read_source {
>         NETFS_FILL_WITH_ZEROES,
>         NETFS_DOWNLOAD_FROM_SERVER,
>         NETFS_READ_FROM_CACHE,
>         NETFS_INVALID_READ,
> } __mode(byte);
> 
> -- 
> Thanks,
> 
> Steve
