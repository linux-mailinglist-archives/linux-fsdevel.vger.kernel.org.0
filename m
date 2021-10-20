Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9970843514C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhJTRck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTRck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:32:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D7C06161C;
        Wed, 20 Oct 2021 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+FGWYrt19kRXssBmavQyj255iv67LtpvipodkUs4m4g=; b=aF/5cXPMZDkNtF7ux4qy/YwO1Y
        nESemWIn4gHeHISxfUmkraHW/rac69d7htiv+ZkbBmQI2LO5T6Bp8kLi2PeE3HwSJLhADCWNW4bnl
        tyzqJPbbUcd0uz4RBIFbDny9ntxh6NHL6QNY0NCbD5rpyN1I46uVc5AsmZl89R+7idOYh6fqX6tiv
        wHf7y0a/v/nmQtaIiKu2seWgXP03iv9Iwpv1pUfKb/PxEGUCSxxnNdN79cktuooojXBgRYgApQpLN
        nqdYKvxrB/57D5Cb55mZcKSK/+jR6ZIPtxgGmlCzYoxS2e/OM12THhNAmnwB77+8i5ziADuSAh4Hq
        ZsSoItKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdFPz-005KGY-Gw; Wed, 20 Oct 2021 17:30:23 +0000
Date:   Wed, 20 Oct 2021 10:30:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
Message-ID: <YXBSLweOk1he8DTO@infradead.org>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:
> It's not used for anything, and we're wasting time passing in zeroes
> where we could just ignore it instead. Update all ki_complete users in
> the kernel to drop that last argument.
> 
> The exception is the USB gadget code, which passes in non-zero. But
> since nobody every looks at ret2, it's still pointless.

Yes, the USB gadget passes non-zero, and aio passes that on to
userspace.  So this is an ABI change.  Does it actually matter?
I don't know, but you could CC the relevant maintainers and list
to try to figure that out.
