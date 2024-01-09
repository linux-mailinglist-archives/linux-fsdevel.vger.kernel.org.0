Return-Path: <linux-fsdevel+bounces-7608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DA8286DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F4C282AAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3C38FA7;
	Tue,  9 Jan 2024 13:09:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB238DE9;
	Tue,  9 Jan 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W-IeJTb_1704805422;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-IeJTb_1704805422)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 21:03:44 +0800
Message-ID: <cab7415b-3c5b-49ea-86c2-bdd0aee3c4b9@linux.alibaba.com>
Date: Tue, 9 Jan 2024 21:03:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cachefiles: Fix signed/unsigned mixup
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>,
 Yiqun Leng <yqleng@linux.alibaba.com>, Jia Zhu <zhujia.zj@bytedance.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
 <20240109112029.1572463-6-dhowells@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240109112029.1572463-6-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/9 19:20, David Howells wrote:
> In __cachefiles_prepare_write(), the start and pos variables were made
> unsigned 64-bit so that the casts in the checking could be got rid of -
> which should be fine since absolute file offsets can't be negative, except
> that an error code may be obtained from vfs_llseek(), which *would* be
> negative.  This breaks the error check.
> 
> Fix this for now by reverting pos and start to be signed and putting back
> the casts.  Unfortunately, the error value checks cannot be replaced with
> IS_ERR_VALUE() as long might be 32-bits.
> 
> Fixes: 7097c96411d2 ("cachefiles: Fix __cachefiles_prepare_write()")
> Reported-by: Simon Horman <horms@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401071152.DbKqMQMu-lkp@intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> cc: Gao Xiang <hsiangkao@linux.alibaba.com>
> cc: Yiqun Leng <yqleng@linux.alibaba.com>
> cc: Jia Zhu <zhujia.zj@bytedance.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org

It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

