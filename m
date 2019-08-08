Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6286A85DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfHHJMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:12:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3527 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731054AbfHHJMi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:12:38 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C450A75703B499C5F0BD;
        Thu,  8 Aug 2019 17:12:35 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 17:12:35 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 17:12:34 +0800
Date:   Thu, 8 Aug 2019 17:29:47 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Goldwyn Rodrigues <RGoldwyn@suse.com>, "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <miaoxie@huawei.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808091632.GF28630@138>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190808081647.GI7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808081647.GI7689@dread.disaster.area>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:16:47PM +1000, Dave Chinner wrote:
> On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> 
> *nod*
> 
> Especially once we get the inline encryption support for fscrypt so
> the storage layer can offload the encrypt/decrypt to hardware via
> the bio containing plaintext. That pretty much forces fscrypt to be
> the lowest layer of the filesystem transformation stack.  This
> hardware offload capability also places lots of limits on what you
> can do with block-based verity layers below the filesystem. e.g.
> using dm-verity when you don't know if there's hardware encryption
> below or software encryption on top becomes problematic...

Add a word, I was just talking benefits between "decrypt->decompress->
verity" and "decrypt->verity->decompress", I think both forms are
compatible with inline en/decryption. I don't care which level
"decrypt" is at... But maybe some user cares. Am I missing something?

Thanks,
Gao Xiang

