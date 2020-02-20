Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9D166218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgBTQRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:17:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTQRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NSWLtlmetFp5G7Pe8HMrBNqOIm0958sxhvgDA5Cq93k=; b=FTYXknHDF7ConhNuFYAFuGL/+c
        o1KGxvw0fy0cxHZ+0dr7F1OiKQ7IKLJmYjbWmoAqBsi3ArU361m/Esg9Os1U8VSb4BYzlVt+UXGsB
        87bTwd6uLaDH9TurObmiB3LKMhj+2Ztg04bQqI/yPIzPzCQltd0O96tBJjADovpoZx5hFO5pzm00y
        mTWd70W7yHPfaQ4ZhKMjjz/OF8KdVEFJcGKtlptS6LBiwsQdSWcZi6yvCYI7eSiBd2n2CfBujSEuL
        K5mEAYRocukGYVGgH/ApZMAaJF2lPIxd3BOq4E11onrUhLaqrFyza1Lud83simLsNWt3L9lObpSr+
        1pUR/a9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4oVo-0008FD-Vd; Thu, 20 Feb 2020 16:17:16 +0000
Date:   Thu, 20 Feb 2020 08:17:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200220161716.GA31606@infradead.org>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218214841.10076-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:48:35PM -0500, Vivek Goyal wrote:
> Currently pmem_clear_poison() expects offset and len to be sector aligned.
> Atleast that seems to be the assumption with which code has been written.
> It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> and pmem_make_request() which will only passe sector aligned offset and len.
> 
> Soon we want use this function from dax_zero_page_range() code path which
> can try to zero arbitrary range of memory with-in a page. So update this
> function to assume that offset and length can be arbitrary and do the
> necessary alignments as needed.
> 
> nvdimm_clear_poison() seems to assume offset and len to be aligned to
> clear_err_unit boundary. But this is currently internal detail and is
> not exported for others to use. So for now, continue to align offset and
> length to SECTOR_SIZE boundary. Improving it further and to align it
> to clear_err_unit boundary is a TODO item for future.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

This looks sensibel to me, but I'd really like to have Dan take at look.
