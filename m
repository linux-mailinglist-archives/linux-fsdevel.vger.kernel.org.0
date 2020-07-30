Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7723288D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgG3AF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG3AF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:05:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B693BC061794;
        Wed, 29 Jul 2020 17:05:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0w4u-005K7w-W4; Thu, 30 Jul 2020 00:05:45 +0000
Date:   Thu, 30 Jul 2020 01:05:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for files
 having ->read_iter
Message-ID: <20200730000544.GC1236929@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707174801.4162712-23-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:48:00PM +0200, Christoph Hellwig wrote:
> If a file implements the ->read_iter method, the iter based splice read
> works and is always preferred over the ->read based one.  Use it by
> default in do_splice_to and remove all the direct assignment of
> generic_file_splice_read to file_operations.

The worst problem here is the assumption that all ->read_iter() instances
will take pipe-backed destination; that's _not_ automatically true.
In particular, it's almost certainly false for tap_read_iter() (as
well as tun_chr_read_iter() in IFF_VNET_HDR case).

Other potentially interesting cases: cuse and hugetlbfs.

But in any case, that blind assertion ("iter based splice read works")
really needs to be backed by something.
