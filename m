Return-Path: <linux-fsdevel+bounces-6829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED881D431
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5686F283F29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB34DDA2;
	Sat, 23 Dec 2023 13:32:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E4D505;
	Sat, 23 Dec 2023 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0Vz1O0tF_1703338328;
Received: from 30.25.242.252(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vz1O0tF_1703338328)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 21:32:11 +0800
Message-ID: <fac01751-73dc-4d93-b9c0-b637fece8334@linux.alibaba.com>
Date: Sat, 23 Dec 2023 21:32:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix EROFS Kconfig
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 David Howells <dhowells@redhat.com>, Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Jeff Layton <jlayton@kernel.org>
References: <20231221132400.1601991-5-dhowells@redhat.com>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <2265065.1703250126@warthog.procyon.org.uk>
 <d50555e9-3b8e-41d4-bec6-317aaaec5ff0@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d50555e9-3b8e-41d4-bec6-317aaaec5ff0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David and Jingbo,

On 2023/12/23 11:55, Jingbo Xu wrote:
> Hi,
> 
> On 12/22/23 9:02 PM, David Howells wrote:
>> This needs an additional change (see attached).
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 1d318f85232d..1949763e66aa 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -114,7 +114,8 @@ config EROFS_FS_ZIP_DEFLATE
>>   
>>   config EROFS_FS_ONDEMAND
>>   	bool "EROFS fscache-based on-demand read support"
>> -	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
>> +	depends on CACHEFILES_ONDEMAND && FSCACHE && \
>> +		(EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y && NETFS_SUPPORT=y)
>>   	default n
>>   	help
>>   	  This permits EROFS to use fscache-backed data blobs with on-demand
>>
> 
> Thanks for the special reminder.  I noticed that it has been included in
> this commit[*] in the dev tree.
> 
> [*]
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=netfs-lib&id=7472173cc3baf4a0bd8c803e56c37efdb8388f1c
> 
> 
> Besides I noticed an issue when trying to configure EROFS_FS_ONDEMAND.
> The above kconfig indicates that EROFS_FS_ONDEMAND depends on
> NETFS_SUPPORT, while NETFS_SUPPORT has no prompt in menuconfig and can
> only be selected by, e.g. fs/ceph/Kconfig:
> 
> 	config CEPH_FS
>          select NETFS_SUPPORT
> 
> IOW EROFS_FS_ONDEMAND will not be prompted and has no way being
> configured if NETFS_SUPPORT itself is not selected by any other filesystem.
> 
> 
> I tried to fix this in following way:
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 1949763e66aa..5b7b71e537f1 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -5,6 +5,7 @@ config EROFS_FS
>          depends on BLOCK
>          select FS_IOMAP
>          select LIBCRC32C
> +       select NETFS_SUPPORT if EROFS_FS_ONDEMAND
>          help
>            EROFS (Enhanced Read-Only File System) is a lightweight read-only
>            file system with modern designs (e.g. no buffer heads, inline
> @@ -114,8 +115,10 @@ config EROFS_FS_ZIP_DEFLATE
> 
>   config EROFS_FS_ONDEMAND
>          bool "EROFS fscache-based on-demand read support"
> -       depends on CACHEFILES_ONDEMAND && FSCACHE && \
> -               (EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y &&
> NETFS_SUPPORT=y)
> +       depends on EROFS_FS
> +       select FSCACHE
>          default n
>          help
>            This permits EROFS to use fscache-backed data blobs with on-demand
> 
> 
> But still the dependency for CACHEFILES_ONDEMAND and CACHEFILES can not
> be resolved.  Though CACHEFILES is not a must during the linking stage
> as EROFS only calls fscache APIs directly, CACHEFILES is indeed needed
> to ensure that the EROFS on-demand functionality works at runtime.
> 
> If we let EROFS_FS_ONDEMAND select CACHEFILES_ONDEMAND, then only
> CACHEFILES_ONDEMAND will be selected while CACHEFILES can be still N.
> Maybe EROFS_FS_ONDEMAND needs to selct both CACHEFILES_ONDEMAND and
> CACHEFILES?

I think the main point here is that we don't have an explicit
menuconfig item for either netfs or fscache directly.

In principle, EROFS ondemand feature only needs fscache "volume
and cookie" management framework as well as cachefiles since
they're all needed to manage EROFS cached blobs, but I'm fine
if that needs NETFS_SUPPORT is also enabled.

If netfs doesn't have a plan for a new explicit menuconfig
item for users to use, I think we have to enable as below:

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1d318f85232d..fffd3919343e 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -114,8 +114,11 @@ config EROFS_FS_ZIP_DEFLATE

  config EROFS_FS_ONDEMAND
  	bool "EROFS fscache-based on-demand read support"
-	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
-	default n
+	depends on EROFS_FS
+	select NETFS_SUPPORT
+	select FSCACHE
+	select CACHEFILES
+	select CACHEFILES_ONDEMAND
  	help
  	  This permits EROFS to use fscache-backed data blobs with on-demand
  	  read support.
--
2.39.3

But cachefiles won't be complied as modules anymore. Does it
sounds good?

Thanks,
Gao Xiang

