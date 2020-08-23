Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B224EBC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 08:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHWG0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHWG0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 02:26:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98164C061573;
        Sat, 22 Aug 2020 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xHNPas4uqQzNSMZwEJoiWBVI4RMLp8MHwIUwAk63z1Q=; b=Z8iL7NHaVRxDIHyP/BmrtuGDZ+
        I3inqX3HSz47Eu4p/9fCIK7Ou1agE7Br+HXlXAhWqVJLphgfELGc8HxD/uYIkXiWjce1/x9sro9QI
        2qEqhUHGzfhI8een9gxSRNmavstFClnpCjaxcVODYD8N3Q88GUYCsxvDBgIZl/vSPvgIJtlE5Sof8
        aHpBoBqhRWzfbZdyGrunlo2/RjGLrbPSxgASQT38gDhqileNV1DWTwfwzZZ0kiJ/YK+5uCrcFyJHB
        pu4cLFn8i0vmYE1TYlPMdBjeMmoEUaeJid5e43hj1CRXiusab3pmDyoGjfHZOs+UIAORqg/SGWndc
        KvlFXrhA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9jS3-0000G8-9B; Sun, 23 Aug 2020 06:25:59 +0000
Date:   Sun, 23 Aug 2020 07:25:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] bio: introduce BIO_FOLL_PIN flag
Message-ID: <20200823062559.GA32480@infradead.org>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
 <20200822042059.1805541-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822042059.1805541-5-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:20:58PM -0700, John Hubbard wrote:
> Add a new BIO_FOLL_PIN flag to struct bio, whose "short int" flags field
> was full, thuse triggering an expansion of the field from 16, to 32
> bits. This allows for a nice assertion in bio_release_pages(), that the
> bio page release mechanism matches the page acquisition mechanism.
> 
> Set BIO_FOLL_PIN whenever pin_user_pages_fast() is used, and check for
> BIO_FOLL_PIN before using unpin_user_page().

When would the flag not be set when BIO_NO_PAGE_REF is not set?

Also I don't think we can't just expand the flags field, but I can send
a series to kill off two flags.
