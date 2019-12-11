Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C596111A4E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLKHMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 02:12:08 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:42522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfLKHMI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:12:08 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 4ACD0B87F982C67764B5;
        Wed, 11 Dec 2019 15:12:02 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 15:12:01 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 11 Dec 2019 15:12:01 +0800
Date:   Wed, 11 Dec 2019 15:17:11 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        <linux-fsdevel@vger.kernel.org>, <ecryptfs@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191211071711.GA231266@architecture4>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
 <20191211044723.GC4203@ZenIV.linux.org.uk>
 <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:38:34PM +0800, Tiezhu Yang wrote:
> On 12/11/2019 12:47 PM, Al Viro wrote:
> > On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:
> > 
> > > static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> > > {
> > >          if (len == 1 && name[0] == '.')
> > >                  return true;
> > > 
> > >          if (len == 2 && name[0] == '.' && name[1] == '.')
> > >                  return true;
> > > 
> > >          return false;
> > > }
> > > 
> > > Hi Matthew,
> > > 
> > > How do you think? I think the performance influence is very small
> > > due to is_dot_or_dotdot() is a such short static inline function.
> > It's a very short inline function called on a very hot codepath.
> > Often.
> > 
> > I mean it - it's done literally for every pathname component of
> > every pathname passed to a syscall.
> 
> OK. I understand. Let us do not use the helper function in fs/namei.c,
> just use the following implementation for other callers:
> 
> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> {
>         if (len >= 1 && unlikely(name[0] == '.')) {


And I suggest drop "unlikely" here since files start with prefix
'.' (plus specical ".", "..") are not as uncommon as you expected...


Thanks,
Gao Xiang


>                 if (len < 2 || (len == 2 && name[1] == '.'))
>                         return true;
>         }
> 
>         return false;
> }
> 
> Special thanks for Matthew, Darrick, Al and Eric.
> If you have any more suggestion, please let me know.
> 
> Thanks,
> 
> Tiezhu Yang
> 
