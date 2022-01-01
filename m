Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86BF482633
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 01:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiAAAb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 19:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAAAb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 19:31:28 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0257C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 16:31:28 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3SIv-00GKgI-3C; Sat, 01 Jan 2022 00:31:25 +0000
Date:   Sat, 1 Jan 2022 00:31:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] iov_iter support for a single kernel address
Message-ID: <Yc+g3btQAqvObg+x@zeniv-ca.linux.org.uk>
References: <Yba+YSF6mkM/GYlK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yba+YSF6mkM/GYlK@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:30:41AM +0000, Matthew Wilcox wrote:
> 
> When working on the vmcore conversion to iov_iter, I noticed we had a
> lot of places that construct a single kvec on the stack, and it seems a
> little wasteful.  Adding an ITER_KADDR type makes the iov_iter a little
> easier to use.
> 
> I included conversion of 9p to use ITER_KADDR so you can see whether you
> think it's worth doing.

I'd rather go for

static inline void kvec_single_range(int rw, void *buf, size_t len,
				struct kvec *vec, struct iov_iter *i)
{
	kvec->iov_base = buf;
	kvec->iov_len = len;
	iov_iter_kvec(i, rw, iov, 1, len);
}

to parallel the import_single_range().  You get more bloat in already
convoluted (to put it very mildly) macros in iov_iter.c than you save
on not declaring the local struct kvec variables in the users...
