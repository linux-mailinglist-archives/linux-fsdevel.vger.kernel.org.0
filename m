Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29F7AFBDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 09:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjI0HUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjI0HT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:19:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F1192;
        Wed, 27 Sep 2023 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CKWvCi3pssjKE1FCsQtfmBLbQMUs5oHya/7o8qVXlsI=; b=No/Cz9j3LyIqDGzlz022ssJXat
        0kUyoH7LO1F/UtIfueVzW7lfbjl4kqrUnaeqs9AMDZAh1Ke2xwaWYj33Pc/ZHsMUiHeCpDAAw/wZ5
        huJ04nKE22e8msJL5F/9GILmiA8p6jvdplF01ZT2HPyBFkOMl9jgwNtafedT5ddSTfM+1rqLUqKEY
        7fGLTZBwg0u5e88Ht3tjxUoIl2TkKcACR7lwpYvSYPGWfieGH8tXugl97xuGOUV4o0DIOcEES9X+Y
        XW5zYnZiKhAYDRPWZxzARRB3m+RZGbEf7GsabFFcnQ45/M/SAIMF0LOagat6c3jonb5GKWnW7evEd
        qu7JWyUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlOpp-00CSZW-DI; Wed, 27 Sep 2023 07:19:49 +0000
Date:   Wed, 27 Sep 2023 08:19:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dianlujitao@gmail.com
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Subject: Re: Fwd: kernel bug when performing heavy IO operations
Message-ID: <ZRPXlfGFWiCNZ6sh@casper.infradead.org>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
 <ZOrG5698LPKTp5xM@casper.infradead.org>
 <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
 <ZOs5j93aAmZhrA/G@casper.infradead.org>
 <b290c417-de1b-4af8-9f5e-133abb79580d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b290c417-de1b-4af8-9f5e-133abb79580d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:36:52PM +0800, dianlujitao@gmail.com wrote:
> Hello, I got some logs with 6.5.4 kernel from the official linux package of
> Arch, no zen patches this time. Full dmesg is uploaded to
> https://fars.ee/F1yM and below is a small snippet for your convenience, from
> which PG_offline is no longer set:
> 
> [177850.039441] BUG: Bad page map in process ld.lld pte:8000000edacc4025
> pmd:147f96067
> [177850.039454] page:000000007415dd6c refcount:22 mapcount:-237
> mapping:00000000b0c37ca6 index:0x1075 pfn:0xedacc4

It still looks like memory corruption to me.  If you go back to an older
kernel (say 5.10 or 5.15) does the problem go away?  It's not really
dispositive either way, since a newer kernel might drive the hardware
closer to the edge, but it might give some clue.
