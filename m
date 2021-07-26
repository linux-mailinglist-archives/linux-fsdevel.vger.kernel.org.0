Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BB3D5C04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhGZOCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbhGZOCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:02:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB13C061760;
        Mon, 26 Jul 2021 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iaSv9XlckqKB2UwnRrR8VLYaeIqdmoUPn76suZLRbTI=; b=ZLSLcYWYRiwCJiN8eqIjyy/6yH
        yUN5dmgb5ZhFJyNyotTjlqZ1PuSrFV22IOe8eNgFEzMPuxs58j0iv7BRoVMVLrWIFEi6D6NuYdUGp
        Vij57fOQ7eElnkwbJY6O5TPH76gI28dJK4VogusQXwJOwQMS6USC3SblkACb8ea0xjYbJ2iUuO0ej
        KMsecFXHq5RN9f8lYXxleem7nDtjHL56eZ17tnXViyjQHaNKDnq1IBZxSLQNBBnsH8G52M111AHsH
        HPiD+rWTclpEtFzawN02B8RHsArBokLzUmGXCtXENAC49P8+cLR4xAyyA4u4oCaIzYbTQMldwkmrd
        ORxVC4tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m81mz-00E2uY-O4; Mon, 26 Jul 2021 14:41:23 +0000
Date:   Mon, 26 Jul 2021 15:41:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 01/21] namei: add mapping aware lookup helper
Message-ID: <YP7JgZCb/AAG17xf@casper.infradead.org>
References: <20210726102816.612434-1-brauner@kernel.org>
 <20210726102816.612434-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726102816.612434-2-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:27:56PM +0200, Christian Brauner wrote:
> +/**
> + * lookup_mapped_one_len - filesystem helper to lookup single pathname component

Can we think about the name a bit?  In the ur-times (2.3.99), we had
lookup_dentry(), which as far as I can tell walked an entire path.
That got augmented with lookup_one() which just walked a single path
entry.  That was replaced with lookup_one_len() which added the 'len'
parameter.  Now we have:

struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
struct dentry *lookup_one_len(const char *, struct dentry *, int);
struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);

I think the 'len' part of the name has done its job, and this new
helper should be 'lookup_one_mapped'.

