Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5F9CE9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfHZLxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 07:53:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHZLxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lZnBdyi3U2JinlfRXPGTK6Ot4IAtObs74Nrk19Et59I=; b=h4nljASh9KzABQmHDW5KPiI5y
        rYfaQ9ckmtTLidzXqdVCp0kF98xjf4iYIvzChMQ+kZPX5dFnceTCsbzUIUgXzefxzhTIey+QON6E3
        HdKAyQOYx2zGew4MWxorz2O/U4UXjDKU8vLrNzb/YCEO23oqRpsSvaQ+xzPFCXiGigwnO51UQU8Ng
        c2nipNf141NY7vJYW1pgnwmI3CJ2N2UQXsUkB8/CWGoqHPEmwsC99YcpjCUNrRkng2qqYkxwezrRV
        bdEm2DiIK+AbKnMruJeHndTGfb4h0UTWaRATbqcGJPhWonnBXPiaTIWTzgA5TCnXYX7nZzgLDuvGR
        A5CXgO69w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DYi-0008I5-1i; Mon, 26 Aug 2019 11:53:16 +0000
Date:   Mon, 26 Aug 2019 04:53:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
Message-ID: <20190826115316.GB21051@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821175720.25901-3-vgoyal@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> is searched from that bdev name.
> 
> virtio-fs does not have a bdev. So pass in dax_dev also to
> dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> used otherwise dax_dev is searched using bdev.

Please just pass in only the dax_device and get rid of the block device.
The callers should have one at hand easily, e.g. for XFS just call
xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
