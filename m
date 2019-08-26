Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4036A9CE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfHZLvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 07:51:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHZLvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1TviH4OE9g0ePmo1qrMkYXUOeKWbt5qrTfsr6aQ4WxU=; b=O5LzO9tgN9SeWoWyNekXsB84f
        z4Ph/BrpqE+paC2R4jl2cl2TzLbtp+2yxI/fOw+MeqKPMnQK4QJX02locG6ZNxYahWDmjweD6nnpg
        nva5LPAg0YFTr0PZea8YcP/FFVV1VzDZD6JvgezWruy98VHRS+ZkdjTBpAK3iq45ziNpZGN+BQfyS
        aQYxVxYIk/0VrRqweGa/QpVtUNU4zCDyPzo8JtaUeYsE38Q/BoMXY9yLOwEoeGoA+o4oHh7VfCKDf
        kZKrL8CCks1psw19Ta4SajwqsffaKQBtg+wngaRH25bXkw9vP0oY6UM4WHCmXkT7MQvhJ118VjupW
        hmWIo3Yzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DXM-0007qP-IW; Mon, 26 Aug 2019 11:51:52 +0000
Date:   Mon, 26 Aug 2019 04:51:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190826115152.GA21051@infradead.org>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821175720.25901-2-vgoyal@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:57:02PM -0400, Vivek Goyal wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Although struct dax_device itself is not tied to a block device, some
> DAX code assumes there is a block device.  Make block devices optional
> by allowing bdev to be NULL in commonly used DAX APIs.
> 
> When there is no block device:
>  * Skip the partition offset calculation in bdev_dax_pgoff()
>  * Skip the blkdev_issue_zeroout() optimization
> 
> Note that more block device assumptions remain but I haven't reach those
> code paths yet.

I think this should be split into two patches.  For bdev_dax_pgoff
I'd much rather have the partition offset if there is on in the daxdev
somehow so that we can get rid of the block device entirely.

Similarly for dax_range_is_aligned I'd rather have a pure dax way
to offload zeroing rather than this bdev hack.

In the long run I'd really like to make the bdev vs daxdev in iomap a
union instead of having to carry both around.

