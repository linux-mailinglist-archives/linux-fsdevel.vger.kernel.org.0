Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70097FE321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKOQrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:47:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfKOQrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLV+AcEBB3jNMQPnx6NT/0oMloj69XAoEcsuwbPVrgk=; b=l3mQflryCpdI3yViX5gI6U6Rj
        b43a9bEATr64qVCltsrLiS+MBOa/bn+GDfbJXsJabVa+yUv97Bifk36iuV/fI6cIBHlrFVkehPjO2
        oOZIY5zOAP5xLNQ/fo67IVfSUJEqrVF/ftYCo7ermvNNDZJohjUyBl7jCJHabjQ9+Fe08jXnQAkYL
        4HkZSPV0v26Fr8Tc2dz9lUyobnDMJ45UfRz1E1yBmEnXgEY+s8Z6tSw3GaY9SlcDCjaXRsAxF6bqa
        tqOgyru5arybs1OaIw9qnjYFRINzdS3PMnkL2TvazqK+5/TAL56nybrZbYmbnLPJdZXSn3pxb0qkt
        G5xQhincQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVekW-0008Rj-25; Fri, 15 Nov 2019 16:47:08 +0000
Date:   Fri, 15 Nov 2019 08:47:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/7] iomap: use a function pointer for dio submits
Message-ID: <20191115164708.GB26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The subject is a little odd, as we only optionally override submit_bio.
Maybe something like:

iomap: add a file system hook for direct I/O bio submission

On Fri, Nov 15, 2019 at 10:16:56AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while
> submitting for I/O. This could be post-write operations
> such as data CRC or data replication for fs-handled RAID.

You can use up to 73 chars for the commit log.

> +	if (dio->dops && dio->dops->submit_io)
> +		dio->submit.cookie = dio->dops->submit_io(bio,
> +				file_inode(dio->iocb->ki_filp),	pos);

Any reason to not simply pass the file?

