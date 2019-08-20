Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C549568D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 07:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfHTFNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 01:13:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728960AbfHTFNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:13:19 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 30C0D55AD62F7D7E5F5A;
        Tue, 20 Aug 2019 13:13:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 13:13:15 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 20 Aug 2019 13:13:15 +0800
Date:   Tue, 20 Aug 2019 13:12:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chandan Rajendra <chandan@linux.ibm.com>
CC:     <tytso@mit.edu>, <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fscrypt@vger.kernel.org>, <chandanrmail@gmail.com>,
        <adilger.kernel@dilger.ca>, <jaegeuk@kernel.org>,
        <yuchao0@huawei.com>, <hch@infradead.org>
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Message-ID: <20190820051236.GE159846@architecture4>
References: <20190816061804.14840-1-chandan@linux.ibm.com>
 <20190816061804.14840-6-chandan@linux.ibm.com>
 <1652707.8YmLLlegLt@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1652707.8YmLLlegLt@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chandan,

On Tue, Aug 20, 2019 at 10:35:29AM +0530, Chandan Rajendra wrote:
> On Friday, August 16, 2019 11:48 AM Chandan Rajendra wrote:
> > F2FS has a copy of "post read processing" code using which encrypted
> > file data is decrypted. This commit replaces it to make use of the
> > generic read_callbacks facility.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> 
> Hi Eric and Ted,
> 
> Looks like F2FS requires a lot more flexiblity than what can be offered by
> read callbacks i.e.
> 
> 1. F2FS wants to make use of its own workqueue for decryption, verity and
>    decompression.
> 2. F2FS' decompression code is not an FS independent entity like fscrypt and
>    fsverity. Hence they would need Filesystem specific callback functions to
>    be invoked from "read callbacks". 
> 
> Hence I would suggest that we should drop F2FS changes made in this
> patchset. Please let me know your thoughts on this.

Add a word, I have some little concern about post read procession order
a bit as I mentioned before, because I'd like to move common EROFS
decompression code out in the future as well for other fses to use
after we think it's mature enough.

It seems the current code mainly addresses eliminating duplicated code,
therefore I have no idea about that...

Thanks,
Gao Xiang

> 
> -- 
> chandan
> 
> 
> 
