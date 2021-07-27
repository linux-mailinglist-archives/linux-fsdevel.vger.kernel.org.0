Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15793D75AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhG0NQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhG0NQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:16:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE2C061757;
        Tue, 27 Jul 2021 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RohD1sOJc0BJZG1+fLuPrgMdmyvKVUj/3FEqHqNiCTk=; b=vBWkH1hAGzNDQpul+rPDbUAvIj
        emVm/EQfiUYyAySpvivlY9KCKEzB4PC51XoKhScLWUBD906+jgYyswY3jLXdiyaGaqQZUe5Fv0l8P
        5k3W/lyMuHMXK8uQBFpKqmAmi5aNciv7/amscrs9w9b2n7IHDUoc1Rjs0P1XKyhWtYYao1b5TYxzS
        +BfFC7DBfYo0wK+DfiRCbydm/11Rnq1UmlPxCnoBn8jbmg8B76YGU27bXMEeQLJeysDMulWoGbgKj
        Q8RAsbBzdxNQiIkxvAO5QbR2DAAtj3efXEjulYblWMHmShrruzo0tA29QG+SWhFENbvcrfINpE4p9
        42QVVzAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Mur-00F1Zg-Va; Tue, 27 Jul 2021 13:14:56 +0000
Date:   Tue, 27 Jul 2021 14:14:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jordy Zomer <jordy@pwning.systems>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] fs: make d_path-like functions all have unsigned size
Message-ID: <YQAGvTZPex3mxrD/@casper.infradead.org>
References: <20210727120754.1091861-1-gregkh@linuxfoundation.org>
 <YP/+g/L6+tLWjx/l@smile.fi.intel.com>
 <YQAClXqyLhztLcm4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAClXqyLhztLcm4@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:56:53PM +0200, Greg Kroah-Hartman wrote:
> And my mistake from earlier, size_t is the same as unsigned int, not
> unsigned long.

No.

include/linux/types.h:typedef __kernel_size_t           size_t;

include/uapi/asm-generic/posix_types.h:

#ifndef __kernel_size_t
#if __BITS_PER_LONG != 64
typedef unsigned int    __kernel_size_t;
#else
typedef __kernel_ulong_t __kernel_size_t;
#endif
#endif

size_t is an unsigned long on 64-bit, unless otherwise defined by the
arch.
