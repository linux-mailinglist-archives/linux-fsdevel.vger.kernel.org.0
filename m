Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7191BB7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgD1HrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgD1HrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:47:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156CBC03C1A9;
        Tue, 28 Apr 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqbZray/izI+DtrCZeQqScd+zG1eR8dDs357djsfCWI=; b=rzZ7dWmYdkxfunsUxfkxv/fh5g
        m6ldEYaWz6UCIpI8/bFvtB5yw82lrHnY1Hb6XCELINXMcsjN3oRwF8e+Xz1q1euYOOySS45KZsYfh
        b4WGefXAB5V6TN8vGK8Y3FXiUkQkSRPOq29fEVH0yQ3+TcBoO/PaxJjiqOHVXlCcy0wOwZQce8lAC
        ZG3B0UOXwRK542Kt9GwWMHogmveURyNb3D5r6NFGx0l0vwU2TJkQ/aanW++yi8+vD/f/xQcqed3Cm
        O0imsixLSHCWqkYtwyFFBv7q45RxeHIkh8OaWBSd8dGQNpHd0yBXn+1KRWxDj+NSLUmEmaWZdVOj9
        ANHmZgLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTKxV-0003KI-8Y; Tue, 28 Apr 2020 07:47:13 +0000
Date:   Tue, 28 Apr 2020 00:47:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200428074713.GA12180@infradead.org>
References: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:08:31PM +0530, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to pr_warn() all user of ioctl_fibmap() and return a proper
> error code rather than silently letting a FS corruption happen if the
> user tries to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Now iomap_bmap() could be called from either of these two paths.
> Either when a user is calling an ioctl_fibmap() interface to get
> the block mapping address or by some filesystem via use of bmap()
> internal kernel API.
> bmap() kernel API is well equipped with handling of u64 addresses.
> 
> WARN condition in iomap_bmap_actor() was mainly added to warn all
> the fibmap users. But now that we have directly added this warning
> for all fibmap users and also made sure to return 0 as block map address
> in case if addr > INT_MAX.
> So we can now remove this logic from iomap_bmap_actor().
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Well, this changed quite a bit from the previous version, so I would
have dropped the Reviewed-by tags.

That being said this version still looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
