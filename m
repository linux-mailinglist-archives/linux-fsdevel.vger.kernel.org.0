Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC542E8FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhJOGcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhJOGcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:32:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D66BC061570;
        Thu, 14 Oct 2021 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nv5FQ/6vTqDP+uvH/XRZgii5X0jrEJS0CQSXWJp5LYY=; b=AgLYGCmRq2PJF2LjCKSd3i9+8e
        dHwI13PRvpN84mnLWiuxm2DChcEhVcL2j5+G1MpSJir3s0No/Qfr1Rc8t6UEqhTNN8Yl8OhMq9idC
        OUkFJTOu8aJEH16iajD3jt8dTV51n6PDAj57s5WW6B+W+QaO8+c+gGeHVuwm4Lmk/DSqA7AEi81Cl
        UncMAun5PjoNTSZUZzmqUtS8j8fowmcifrwLlRcsWWfNhYX+YuGfzYVV+e/Kri4YxoQewkvDHMDGv
        Lm0Hnnnj3TVXzQyCyBTnNCY6cTlzXqxT1AGI3g+zWo6TmUYKE045vQecRQ5rjR3xUGmEWkdrRSJfn
        tAXfOAvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbGjD-005WWo-Bs; Fri, 15 Oct 2021 06:30:03 +0000
Date:   Thu, 14 Oct 2021 23:30:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v7 1/8] dax: Use rwsem for dax_{read,write}_lock()
Message-ID: <YWkf63g44Puobxrp@infradead.org>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-2-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:52PM +0800, Shiyang Ruan wrote:
> In order to introduce dax holder registration, we need a write lock for
> dax.  Because of the rarity of notification failures and the infrequency
> of registration events, it would be better to be a global lock rather
> than per-device.  So, change the current lock to rwsem and introduce a
> write lock for registration.

I don't think taking the rw_semaphore everywhere will scale, as
basically any DAX based I/O will take it (in read mode).

So at a minimum we'd need a per-device percpu_rw_semaphore if we want
to go there.
