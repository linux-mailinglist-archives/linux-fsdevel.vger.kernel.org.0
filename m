Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F8161380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgBQNbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:31:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgBQNbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJ4Zkxvpvz5W+pY+zDjAJt/JTwqlyPBBYfHm14egUVA=; b=qkeFFr9lh/8KJMax3DFt0itzaf
        BypRniQZWts27SXNLLmWKtXtQ484kFWJZHD70Yeai5ElvP4naO9RkDdMsQTy8sq6UxmJcSGjfvQ4m
        7n1qN+ZZ9dzShGPCps+6Va+jNrf9EWVhMRSn2NNViWvChjbMVTODf6khUs5LL2Jcfc8fgxFTbukNc
        YZp/PfiDXqNhr3pHAQ5ZNCSHpWJW3fvKAkikoseL5209WN3fhp9gXaIBjXVhMf0GdrdIkt1/7eYzJ
        5Rj0DV8XbNc5cEsdJrOEak76hRMMkXlox0rFFTY+0qxVkbERzOh/lxlLIXu/rIlbzXwzaO02+enDV
        YyVU5kZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gUX-00082j-MB; Mon, 17 Feb 2020 13:31:17 +0000
Date:   Mon, 17 Feb 2020 05:31:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 2/6] dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct
 iomap"
Message-ID: <20200217133117.GB20444@infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:07:29PM -0500, Vivek Goyal wrote:
> Add a new field "sector_t dax_offset" to "struct iomap". This will be
> filled by filesystems and dax code will make use of this to convert
> sector into page offset (dax_pgoff()), instead of bdev_dax_pgoff(). This
> removes the dependency of having to pass in block device for dax operations.

NAK.  The iomap is not a structure to bolt random layering violation
onto.
