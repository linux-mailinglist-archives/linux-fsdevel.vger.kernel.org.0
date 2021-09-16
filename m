Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2740D354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 08:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhIPGlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhIPGlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:41:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C3C061574;
        Wed, 15 Sep 2021 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7BbuzwOthGVRqV8KZor3zQQ2pilc0nFfPq3ri52XdlM=; b=jyQaVrliIgQoL05ExjcW2HtXwO
        OkntrAQuOUDI/s3Hb3yICfIhHkK/OH05ncz+FjvCZE2yrk/hB7iqcg4y/SVq5AhESnfSmdRj2CeYI
        m6XKJYTZTwoyCTId3snqur1urlSvkGVgaBP6nd6NxsgGOscJXUSZhUhljhywneeBYujPg7LqpgSJx
        ePmMieZYnfH/2NtqEy0zGKNxfysRLhWys68FzmkHET68k/5S0lMZYzONHG/tx1Xjdo4+s7yQpka4s
        agnBMCGDH19ouIvzKDxndQegOuZDXuAtLuD1kK12filXsQdW+BXEttO1njalILinutDXS453CG1E9
        YzMQAHFw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQl38-00GNxg-QV; Thu, 16 Sep 2021 06:39:18 +0000
Date:   Thu, 16 Sep 2021 07:39:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, xu.xin16@zte.com.cn,
        Christoph Hellwig <hch@infradead.org>, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <YULmjmBL9fIx6XwB@infradead.org>
References: <YUIPnPV2ttOHNIcX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUIPnPV2ttOHNIcX@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:22:04AM -0400, Vivek Goyal wrote:
> Will be nice to pass size of input buffer to split_fs_names() and
> put enough checks in place so such buffer overrun possibilities
> do not occur.

Will be nice sounds weird.

> 
> Hence this patch adds "size" parameter to split_fs_names() and makes
> sure we do not access memory beyond size. If input string "names"
> is larger than passed in buffer, input string will be truncated to
> fit in buffer.

There's really two aspects here:  checking for a max size and explicitly
passing one.  I'm fine with passing the argument even if it always is
PAGE_SIZE, but this should probably be documented a little better.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
