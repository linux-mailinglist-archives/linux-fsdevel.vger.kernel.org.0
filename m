Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70952232C36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgG3HDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 03:03:32 -0400
Received: from verein.lst.de ([213.95.11.211]:54769 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgG3HDc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:03:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FD0D68AFE; Thu, 30 Jul 2020 09:03:29 +0200 (CEST)
Date:   Thu, 30 Jul 2020 09:03:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for
 files having ->read_iter
Message-ID: <20200730070329.GB18653@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-23-hch@lst.de> <20200730000544.GC1236929@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730000544.GC1236929@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:05:44AM +0100, Al Viro wrote:
> On Tue, Jul 07, 2020 at 07:48:00PM +0200, Christoph Hellwig wrote:
> > If a file implements the ->read_iter method, the iter based splice read
> > works and is always preferred over the ->read based one.  Use it by
> > default in do_splice_to and remove all the direct assignment of
> > generic_file_splice_read to file_operations.
> 
> The worst problem here is the assumption that all ->read_iter() instances
> will take pipe-backed destination; that's _not_ automatically true.
> In particular, it's almost certainly false for tap_read_iter() (as
> well as tun_chr_read_iter() in IFF_VNET_HDR case).
> 
> Other potentially interesting cases: cuse and hugetlbfs.
> 
> But in any case, that blind assertion ("iter based splice read works")
> really needs to be backed by something.

I think we need to fix that in the instances, as we really expect
->splice_read to just work instead of the caller knowing what could
work and what might not.
