Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9504579841E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjIHIed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjIHIed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:34:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69D173B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGwiDB0rXV/EDJSBZ850L9EWY8XuPHw40Uxw3N9RFoM=; b=ub7bJBnon9hJFmyc7rkdHEoHgX
        o1oh/pSar4tDlq64pBHuv+givXaan2hgTllGR0PFl/X0n8f3EaQh2j2BliLUhdj0dYn66fkC99MRu
        mUx2qNEXLsgOkmQUxxFYhKgk6tI2C+Ocgq//x1mgMU6kby/RNPeOBxZWZhxYktmfi6LARtfV5riJH
        mFNz0f+lF8supfHy92Hv6MR9osS/JNeH6xo1CwDxCok8nrjJ2O13q0XOFI8GvC0+712Izsc+VSZV9
        VQNzFfSa4zHXd6qtUsNM0tod9r8jB85pRQ0SdfTp1UxQpgqL9Q06UnVuanHjMnaTaZBAMsUuvFQMQ
        5JYlT0CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeWwY-00DK8k-2s;
        Fri, 08 Sep 2023 08:34:22 +0000
Date:   Fri, 8 Sep 2023 01:34:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPrcjnZ/zXMlL/X8@infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <ZPffYYnVMIkuCK9x@dread.disaster.area>
 <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906-wildhasen-vorkehrungen-6ecb4ee012f1@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:06:29PM +0200, Christian Brauner wrote:
> So adding another RFE to libmount to add support for a global allowlist
> or denylist of filesystems and refuse to mount anything else might also
> be a good thing. Actually, might go and do this now.
> 
> So that we can slowly move userspace towards a smaller set of
> filesystems and then distros can start turning off more and more
> filesystems.

A global list is good, maintaining it in util-linux is stupid.  This
needs to be in the kernel as that's where we have all the data.  IMHO
a flag in struct file_system_type thast gets exposed in
/proc/filesystems and maybe even a flag to the new mount API to tell
"this is an automount" and refuse it it the trusted flag is not set
will work much better.  That way we can also easily upgrade/downgrade
the status of a file system as needed.
