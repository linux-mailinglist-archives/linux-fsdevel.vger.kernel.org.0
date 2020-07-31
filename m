Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2855A2346A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgGaNLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgGaNLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:11:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11DC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PFWfBZ4q8OVm2xOhbYpzuKcyALtkma9PfQ40uHYLTnw=; b=M2D7p7M+F2o3o4VWc7QevPmvo2
        HDEsCtmZND4pVl1Y0UEcNCN77kaOzjRhIn+IIMKaqpP0kzWWEwAQtmxJaaV6PRZwr5sx/zkcubqDn
        mGONjkkt2eCUBF4q6l9eywNgC7KFEGATnuEFPSmPxPjvEtXQvL9HWGI9tQWs/H3tJ1xecYhq7PNCf
        0197KH3aE4tq4iajcnmgcjnVMtYmXnKiCdnAsFk/Ohpb5q62B4tPJwQIJw6yqIOCTsyJFzDdlFbvb
        SeGGlVkIDR9SI+EGA8WttVf7fT8FryJWg8IcKQqwAyQUF/zAR12CnZYaygS3+whQfghPbftfw305a
        hSc67LSQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1UoZ-0004ov-Hc; Fri, 31 Jul 2020 13:11:11 +0000
Date:   Fri, 31 Jul 2020 14:11:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Avi Kivity <avi@scylladb.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] fs: Return EOPNOTSUPP if block layer does not support
 REQ_NOWAIT
Message-ID: <20200731131111.GA18024@infradead.org>
References: <20181213115306.fm2mjc3qszjiwkgf@merlin>
 <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:08:21PM +0300, Avi Kivity wrote:
> 
> On 13/12/2018 13.53, Goldwyn Rodrigues wrote:
> > For AIO+DIO with RWF_NOWAIT, if the block layer does not support REQ_NOWAIT,
> > it returns EIO. Return EOPNOTSUPP to represent the correct error code.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

I think the main problem is the EOPNOTSUPP return value.  Everywhere
else we treat the lack of support as BLK_STS_AGAIN / -EAGAIN, so it
should return that.  Independ of that the legacy direct I/O code
really should just use blk_status_to_errno like most of the other
infrastructure instead of havings it's own conversion and dropping
the detailed error status on the floor.
