Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36D11B7181
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgDXKHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbgDXKHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:07:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1DC09B045;
        Fri, 24 Apr 2020 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tp5Mwh7r6IJcLAecCyqpJ/TIyjlhLNkCAk6T+XXKm0U=; b=eAhRMSwilNFW7B7zKTBZ5alNKJ
        fPFREmSw0xGNKNBzK63sZg1a8xpj8CJScj/VFUbRZx1x1NAI5Fm7fHAmBMl5pyeTQfDWTF7DQOL7F
        9HwgWkueNAYejVuEyAhJAeIYAjIkCNLaHnVj1NgOOu4ypyjJO7Ljcwh01WYh1enEfR8BfimD5u5jt
        1E8TEyq8yUJRI5PdA8rSafyMhUwNbcAMeuv6b31PjFl3sqakCabOOS7qd85J6tc0bBViPQ4z8lZ5U
        V4f1BYJ7HhnPZ6KQbVS5s8mc6eH1hUx4pjz0aVVffEu/E6MEjZhZNjVyidcCw7fHc8PGB3Xy3LI9X
        bIz6dzRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRvEt-0000Ni-Cx; Fri, 24 Apr 2020 10:07:19 +0000
Date:   Fri, 24 Apr 2020 03:07:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200424100719.GA456@infradead.org>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:52:17PM +0530, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to WARN all user of ioctl_fibmap() and return a proper error
> code rather than silently letting a FS corruption happen if the user tries
> to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
