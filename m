Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6624F574D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiDFH1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578362AbiDFGqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:46:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F233DC9A;
        Tue,  5 Apr 2022 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vqxJ46s1qeqVh8b5I6ydRXIhwjWlT/dFZD1qSfok+48=; b=B4F244K1t7i0S9VvsgftPFGVLL
        twk4UfeFzkxPTopcSzaeMxjEn5gzp3bjROlPuf41jSz2peCYKRvM2K5KrtS8rqY/IuEREqW7w8iWe
        dlNzOnFFnRN/UcR3HjvrkcBrhb+a2aKDxY15FvMwwib9aGOt/Ss/OK/c1eY8TcNJuKQ6Np2Jx538y
        RdMn1JCn6WhxVm3iL767HujuEQ28+HIKZDKYjOFfqYuBZQg8hTqkhhC0DTq0O3arV1NDtWSOvwkYQ
        OU41zD1ECjzE2uoK1byrm67/l1tCnM/dlbQPak1l6Wz7NY1Go0ZYFefdxLIR0geWUhRHcm2ysQ3/c
        EFnU1YPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbxqX-003nIX-Gh; Wed, 06 Apr 2022 05:04:45 +0000
Date:   Tue, 5 Apr 2022 22:04:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
Message-ID: <Yk0fbUs584vRprMg@infradead.org>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-6-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405194747.2386619-6-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:47:46PM -0600, Jane Chu wrote:
> +	pmem_clear_bb(pmem, to_sect(pmem, offset), cleared >> SECTOR_SHIFT);
> +	return (cleared < len) ? BLK_STS_IOERR : BLK_STS_OK;

No need for the braces.  That being said perosnally I find a simple:

	if (cleared < len)
		return BLK_STS_IOERR;
	return BLK_STS_OK;

much easier to read anyway.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
