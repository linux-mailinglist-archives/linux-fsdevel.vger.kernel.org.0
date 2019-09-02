Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96065A560B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfIBMba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:31:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfIBMba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UtOXrhZ6Qo2E9DiEP7YXIr28AIXW+0S0Ci2r4SnPHSc=; b=nZE3UBBQdpl31RWqK8b4lIqyc
        YNuxzTF6JzAbvix1mEl6wIYepkdU5wsfqTp2AI2Z5LCz+DvE1PglTfCQkjncbxOcdLPmpxi+KWjV4
        Rk/fESJLFGmo7mdQYNkbb8dq5A3BH6QbTcRnQ2rNyvZwMIdernWqo55AdvxwBMkj7No3/PcYu0Vlb
        oqonhW0z/6oPX3i1RL/OKFNUwyiTpkRanwau/B/TNZ6JhWY22G2VBP3DoBv5sghAgqE8GMdAkEqfU
        xWUBQmZrMYo5Vc1XQLIbyE76Yr08z0HT5raE7mEGwqHLk2ev/FFbbsmkgVuHAycF2Z0YVH1xSdLaO
        iyykZgaKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lUS-0005TK-Qb; Mon, 02 Sep 2019 12:31:24 +0000
Date:   Mon, 2 Sep 2019 05:31:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 20/21] erofs: kill use_vmap module parameter
Message-ID: <20190902123124.GR15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-21-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-21-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -224,9 +220,6 @@ static void *erofs_vmap(struct page **pages, unsigned int count)
>  {
>  	int i = 0;
>  
> -	if (use_vmap)
> -		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
> -
>  	while (1) {
>  		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);

I think you can just open code this in the caller.

>  static void erofs_vunmap(const void *mem, unsigned int count)
>  {
> -	if (!use_vmap)
> -		vm_unmap_ram(mem, count);
> -	else
> -		vunmap(mem);
> +	vm_unmap_ram(mem, count);
>  }

And this wrapper can go away entirely.

And don't forget to report your performance observations to the arm64
maintainers!
