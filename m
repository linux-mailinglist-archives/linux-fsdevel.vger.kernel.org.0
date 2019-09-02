Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82397A567D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfIBMoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:44:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3969 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729690AbfIBMoM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:44:12 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id C88019D5F1F8E04FB1EB;
        Mon,  2 Sep 2019 20:44:10 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 20:44:10 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 20:44:10 +0800
Date:   Mon, 2 Sep 2019 20:43:19 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 20/21] erofs: kill use_vmap module parameter
Message-ID: <20190902124318.GB17916@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-21-hsiangkao@aol.com>
 <20190902123124.GR15931@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902123124.GR15931@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 05:31:24AM -0700, Christoph Hellwig wrote:
> > @@ -224,9 +220,6 @@ static void *erofs_vmap(struct page **pages, unsigned int count)
> >  {
> >  	int i = 0;
> >  
> > -	if (use_vmap)
> > -		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
> > -
> >  	while (1) {
> >  		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
> 
> I think you can just open code this in the caller.

Yes, the only one user... will fix...

> 
> >  static void erofs_vunmap(const void *mem, unsigned int count)
> >  {
> > -	if (!use_vmap)
> > -		vm_unmap_ram(mem, count);
> > -	else
> > -		vunmap(mem);
> > +	vm_unmap_ram(mem, count);
> >  }
> 
> And this wrapper can go away entirely.

Got it. will fix.

> 
> And don't forget to report your performance observations to the arm64
> maintainers!

In my observation, vm_map_ram always performs better...
If there are something strange later, I will report to them
immediately... :)

Thanks,
Gao Xiang

