Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15BB6686CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjALWXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjALWXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:23:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3941CB1E;
        Thu, 12 Jan 2023 14:18:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31D53B81E63;
        Thu, 12 Jan 2023 22:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2050C433EF;
        Thu, 12 Jan 2023 22:18:01 +0000 (UTC)
Date:   Thu, 12 Jan 2023 17:17:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Brian Norris <briannorris@chromium.org>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] tracing mapped pages for quicker boot
 performance
Message-ID: <20230112171759.70132384@gandalf.local.home>
In-Reply-To: <Y8BvKZFI9RIoS4C/@casper.infradead.org>
References: <20230112132153.38d52708@gandalf.local.home>
        <Y8BvKZFI9RIoS4C/@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Jan 2023 20:35:53 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Jan 12, 2023 at 01:21:53PM -0500, Steven Rostedt wrote:
> > What I would like to discuss, is if there could be a way to add some sort
> > of trace events that can tell an application exactly what pages in a file
> > are being read from disk, where there is no such races. Then an application
> > would simply have to read this information and store it, and then it can
> > use this information later to call readahead() on these locations of the
> > file so that they are available when needed.  
> 
> trace_mm_filemap_add_to_page_cache()?

Great! How do I translate this to files? Do I just do a full scan on the
entire device to find which file maps to an inode? And I'm guessing that
the ofs is the offset into the file?

(from a 5.10 modified kernel)

            <...>-177   [001]    13.166966: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a0 pfn=2586272 ofs=1204224
            <...>-177   [001]    13.166968: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a1 pfn=2586273 ofs=1208320
            <...>-177   [001]    13.166968: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a2 pfn=2586274 ofs=1212416
            <...>-177   [001]    13.166969: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a3 pfn=2586275 ofs=1216512
            <...>-177   [001]    13.166970: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a4 pfn=2586276 ofs=1220608
            <...>-177   [001]    13.166971: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a5 pfn=2586277 ofs=1224704
            <...>-177   [001]    13.166972: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a6 pfn=2586278 ofs=1228800
            <...>-177   [001]    13.166972: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a7 pfn=2586279 ofs=1232896
            <...>-177   [001]    13.166973: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a8 pfn=2586280 ofs=1236992
            <...>-177   [001]    13.166974: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776a9 pfn=2586281 ofs=1241088
            <...>-177   [001]    13.166979: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776aa pfn=2586282 ofs=1245184
            <...>-177   [001]    13.166980: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776ab pfn=2586283 ofs=1249280
            <...>-177   [001]    13.166981: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776ac pfn=2586284 ofs=1253376
            <...>-177   [001]    13.166981: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776ad pfn=2586285 ofs=1257472
            <...>-177   [001]    13.166982: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776ae pfn=2586286 ofs=1261568
            <...>-177   [001]    13.166983: mm_filemap_add_to_page_cache: dev 259:5 ino 9b11 page=0x2776af pfn=2586287 ofs=1265664

The dev 259:5 is the root partition.

Doing the following:

 $ printf "%d\n" 0x9b11
39697

 $ sudo find / -xdev -inum 39697
/lib64/libc.so.6

I guess that's what I need to do. Thanks!

I'll try it out. But I'd still like to have an invite as I have lots of
other fun stuff to talk to you all about (mm, fs, and BPF) ;-)

-- Steve

