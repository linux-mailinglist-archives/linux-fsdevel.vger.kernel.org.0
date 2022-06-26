Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809355B019
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiFZICZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiFZICY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:02:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A5912D21;
        Sun, 26 Jun 2022 01:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SK+swlcj6rLcYyyEH22hFIwnnjq41UijC+puP+o30FM=; b=wN58s+9LPW73zb5DoSpwvMBn9P
        O/0NbR77FfD6DhAmB+MTVnzTVn8/OfidqNggFO2TJyTP3S4XOhaiKax3LUFsBYb4ecM+vYKuy17ps
        XfP6jWHbB8eIpF2w9OzL9re1M/XfHRq4g8WaXepqS5sdNIn7YVYWBEAYYTJLYHc0l+orBDSeW/s9Y
        sDQ9RLe/7W0KZO3jhcRkotRD33Ygde6DunnVQAzX/kqS0jsMFPH6vT/QGaNF6eT31kMkfYYJEiTBN
        WVYRtwkq2pzsOM6jx/SVS4iEfk0a+8LJxrt8Kf4MHvo8TO86kVLBLNDyjUyEA675JY82UgpOEawTn
        jEluIU6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5NDr-00AWLf-UX; Sun, 26 Jun 2022 08:02:23 +0000
Date:   Sun, 26 Jun 2022 01:02:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Message-ID: <YrgSj8w+Q3HmSEwv@infradead.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
 <YrSNlFgW6X4pUelg@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrSNlFgW6X4pUelg@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:58:12AM -0700, Darrick J. Wong wrote:
> Hmm.  Does the XFS port of XFS_IOC_DIOINFO to STATX_DIOALIGN look like
> this?
> 
> 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> 
> 	kstat.dio_mem_align = target->bt_logical_sectorsize;
> 	kstat.dio_offset_align = target->bt_logical_sectorsize;
> 	kstat.result_mask |= STATX_DIOALIGN;

Yes, I think so.  And it would be very good to include the XFS conversion
with this series as the only file systems that already supports
reporting alignment constraints.

I also suspect that lifting XFS_IOC_DIOINFO to common code by calling
->getattr would be useful because now all existing software using that
will also do the right thing on ext4 and f2fs now.

