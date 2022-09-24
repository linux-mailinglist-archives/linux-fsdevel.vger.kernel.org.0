Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1846A5E875F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 04:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiIXCWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIXCWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:22:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A439124763
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ZnV+eBC43KOeWy8+ax0A7t7+DqkuNwSAMVbzruZiTk=; b=hqcQ9Uw2BAsJrdKuQR/amfYVUd
        S9JZIft3A0tOIG0iEHudxoOThQa0oKQzQQgzg1HN6KILfbb8CfRNcW1nr49vHWhDLv84fwLq1veIY
        p6z0SNzCBYea17Q0jvuY4FJ7gLmsTe5/bEzFcwNaQqZf6SkzjbHEUNEDDHNxlVhWnVDK1GHEW6rg5
        FNH98jPytkM6C6Q9pkRR2frsop41gMEDhx+/izgL8pigLgUaSO9VgMD5EBDCsuKH0bfujnYXNylv3
        kgDPtHtw+szS/zHivPO1eXWhTAyR2vcolLhQd1bXE4XXxhsdGPHw11NCvLn2WlaMHbWvzaPJMeTEa
        kLs3DylQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obuns-0036wI-2B;
        Sat, 24 Sep 2022 02:22:04 +0000
Date:   Sat, 24 Sep 2022 03:22:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@redhat.com, smfrench@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add extraction functions
Message-ID: <Yy5pzHiQ4GRCOoXV@ZenIV>
References: <3750754.1662765490@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3750754.1662765490@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 10, 2022 at 12:18:10AM +0100, David Howells wrote:
> Hi Al, Jeff,
> 
> Here's a replacement for the extract_iter_to_iter() patch I had previously.
> It's a WIP, some bits aren't fully implemented, though some bits I have tested
> and got to work, but if you could take a look and see if you're okay with the
> interface.
> 
> I think I've addressed most of Al's comments.  The page-pinning is conditional
> on certain types of iterator, and a number of the iterator types just extract
> to the same thing.  It should now handle kvec-class iterators that refer to
> vmalloc'd data.
> 
> I've also added extraction to scatterlist (which I'll need for doing various
> crypto things) and extraction to ib_sge which could be used in cifs/smb RDMA,
> bypassing the conversion-to-scatterlist step.
> 
> As mentioned, there are bits that aren't fully implemented, let alone tested.

IDGI.  Essentially, you are passing a callback disguised as enum, only to lose
any type safety.  How is it better than "iov_iter_get_pages2() into a fixed-sized
array and handle the result" done in a loop?  No need to advance it (iov_iter_get_page2()
auto-advances), *way* fewer conditional branches and no need to share anything
between the 3 functions you are after...

> +ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t len,
> +			   struct sg_table *sgtable, bool *pages_pinned)

Your *pages_pinned is user_backed_iter(iter), isn't it?
