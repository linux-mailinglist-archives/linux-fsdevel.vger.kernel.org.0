Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22865B07F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF3P5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 11:57:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF3P5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f4I9bdxhuM8BTi0gPCX7v6Yy+8KEHx95K6cAIKvQPAM=; b=GHfbfkyquQn/yZQgR5eAV71Zt
        SEXDwz/jpfVbWZGF4kTy9za5fAEMW+xBuUxIELk1nkATn+OeydWl3BUbUD4heYvIW+3qoJWGc0Cwr
        qqlGKF9xSg9SXGzCIARNnpVNani3Wn9GhUklps713aQ7K2dewrATLXJqnUqZs1ms4KZj7z5dGAiPc
        d8AU0eU1EnIvboA0my6Aggrqn6yVEXvnH+2/OLgnko1mxXlGOSOU620X8UJcy8l6qaduwxW0NzfQ/
        AwyV3KeYrjC2vduF6yEVAtJdwLAsAtaS5dM5suuEU2wcd+bJKeGHUZJk50oGMeDGD8zNSTJa90gUq
        ySCI6EMfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhcD3-0006gX-VK; Sun, 30 Jun 2019 15:57:45 +0000
Date:   Sun, 30 Jun 2019 08:57:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/16] nfsd: add a new struct file caching facility to
 nfsd
Message-ID: <20190630155745.GC15900@bombadil.infradead.org>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
 <20190630135240.7490-4-trond.myklebust@hammerspace.com>
 <20190630135240.7490-5-trond.myklebust@hammerspace.com>
 <20190630135240.7490-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630135240.7490-6-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 30, 2019 at 09:52:29AM -0400, Trond Myklebust wrote:
> +/* FIXME: dynamically size this for the machine somehow? */
> +#define NFSD_FILE_HASH_BITS                   12
> +#define NFSD_FILE_HASH_SIZE                  (1 << NFSD_FILE_HASH_BITS)
> +#define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)

Isn't this what rhashtable is for?
