Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A298A21B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfH2RDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 13:03:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727735AbfH2RDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:03:18 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 4EE0AB0F9047B018262E;
        Fri, 30 Aug 2019 01:03:13 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 01:03:12 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 01:03:12 +0800
Date:   Fri, 30 Aug 2019 01:02:25 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Joe Perches <joe@perches.com>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829170225.GA215901@architecture4>
References: <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4>
 <20190829154346.GK23584@kadam>
 <20190829164442.GA203852@architecture4>
 <74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joe,

On Thu, Aug 29, 2019 at 09:59:21AM -0700, Joe Perches wrote:
> On Fri, 2019-08-30 at 00:44 +0800, Gao Xiang wrote:
> > Hi Dan,
> > 
> > On Thu, Aug 29, 2019 at 11:43:46PM +0800, Dan Carpenter wrote:
> > > > p.s. There are 2947 (un)likely places in fs/ directory.
> > > 
> > > I was complaining about you adding new pointless ones, not existing
> > > ones.  The likely/unlikely annotations are supposed to be functional and
> > > not decorative.  I explained this very clearly.
> > > 
> > > Probably most of the annotations in fs/ are wrong but they are also
> > > harmless except for the slight messiness.  However there are definitely
> > > some which are important so removing them all isn't a good idea.
> > > 
> > > > If you like, I will delete them all.
> > > 
> > > But for erofs, I don't think that any of the likely/unlikely calls have
> > > been thought about so I'm fine with removing all of them in one go.
> > 
> > Anyway, I have removed them all in
> > https://lore.kernel.org/r/20190829163827.203274-1-gaoxiang25@huawei.com/
> > 
> > Does it look good to you?
> 
> Unrelated bikeshed from a trivial look:
> 
> There's a block there that looks like:
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> []
> @@ -70,7 +70,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
>  		}
>  
>  		err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -		if (unlikely(err != PAGE_SIZE)) {
> +		if (err != PAGE_SIZE) {
>  			err = -EFAULT;
>  			goto err_out;
>  		}
> 
> The initial assignment to err is odd as it's not
> actually an error value -E<FOO> but a int size
> from a unsigned int len.
> 
> Here the return is either 0 or PAGE_SIZE.
> 
> This would be more legible to me as:
> 
> 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> 			err = -EFAULT;
> 			goto err_out;
> 		}

Okay, that is more reasonable, I will update the original patch as you suggested.

Thanks,
Gao Xiang

> 
> 
