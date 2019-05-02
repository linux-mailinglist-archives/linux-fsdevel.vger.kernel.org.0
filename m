Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E861811A96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBN4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 09:56:44 -0400
Received: from mfb02-md.ns.itscom.net ([175.177.155.110]:50392 "EHLO
        mfb02-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEBN4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 09:56:44 -0400
Received: from mail03-md.ns.itscom.net (mail03-md.ns.itscom.net [175.177.155.113])
        by mfb02-md.ns.itscom.net (Postfix) with ESMTP id E431817489AD
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2019 22:47:33 +0900 (JST)
Received: from cmsa01-mds.s.noc.itscom.net (cmsa01-md.ns.itscom.net [175.177.0.91])
        by mail03-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 231B3FF0527;
        Thu,  2 May 2019 22:47:33 +0900 (JST)
Received: from jromail.nowhere ([219.110.243.48])
        by cmsa-md with ESMTP
        id MC3hhjzZ0z4K5MC3hhE3tC; Thu, 02 May 2019 22:47:33 +0900
Received: from jro by jrobl id 1hMC3g-0000Ze-UE ; Thu, 02 May 2019 22:47:32 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     ezemtsov@google.com
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu
In-Reply-To: <20190502040331.81196-1-ezemtsov@google.com>
References: <20190502040331.81196-1-ezemtsov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2208.1556804852.1@jrobl>
Date:   Thu, 02 May 2019 22:47:32 +0900
Message-ID: <2209.1556804852@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ezemtsov@google.com:
> Incremental FS is special-purpose Linux virtual file system that allows
> execution of a program while its binary and resource files are still being
> lazily downloaded over the network, USB etc. It is focused on incremental
	:::

I had developed a very similar userspace daemon many years ago which is
called ULOOP.  As you can guess it is based upon the loopback block
device in stead of the filesystem.

(from the readme file)
----------------------------------------
1. sample for HTTP
Simple 'make' will build ./drivers/block/uloop.ko and ./ulohttp.
Ulohttp application behaves like losetup(8). Additionally, ulohttp is
an actual daemon which handles I/O request.
Here is a syntax.

ulohttp [-b bitmap] [-c cache] device URL

The device is /dev/loopN and the URL is a URL for fs-image file via
HTTP. The http server must support byte range (Range: header).
The bitmap is a new filename or previously specified as the bitmap for
the same URL. Its filesize will be 'the size of the specified fs-image
/ pagesize (usually 4k) / bits in a byte (8)', and round-up to
pagesize.
The cache is a new filename or previously specified as the cache for
the same URL. Its filesize will be 'the size of the specified
fs-image', and round-up to pagesize.
Note that both the bitmap and the cache are re-usable as long as you
don't change the filedata and URL.

When someone reads from the specified /dev/loopN, or accesses a file
on a filesystem after mounting /dev/loopN, ULOOP driver first checks
the corresponding bit in the bitmap file. When the bit is not set,
which means the block is not retrieved yet, it passes the offset and
size of the I/O request to ulohttp daemon.
Ulohttp converts the offset and the size into HTTP GET request with
Range header and send it to the http server.
Retriving the data from the http server, ulohttp stores it to the
cache file, and tells ULOOP driver that the HTTP transfer completes.
Then the ULOOP driver sets the corresponding bit in the bitmap, and
finishes the I/O/request.

In other words, it is equivalent to this operation.
$ wget URL_for_fsimage
$ sudo mount -o loop retrieved_fsimage /mnt
But ULOOP driver and ulohttp retrieves only the data (block) on-demand,
and stores into the cache file. The first access to a block is slow
since it involves HTTP GET, but the next access to the same block is
fast since it is in the local cache file. In this case, the behaviour
is equivalent to the simple /dev/loop device.

----------------------------------------

If you are interested, then try
https://sourceforge.net/p/aufs/aufs-util/ci/aufs4.14/tree/sample/uloop/

It is just for your information.


J. R. Okajima
