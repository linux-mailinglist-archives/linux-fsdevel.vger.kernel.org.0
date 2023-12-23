Return-Path: <linux-fsdevel+bounces-6809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF481D207
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 04:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F8B1F22BD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E42117;
	Sat, 23 Dec 2023 03:55:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7E10F4;
	Sat, 23 Dec 2023 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0Vz0J.hE_1703303701;
Received: from 30.212.153.241(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vz0J.hE_1703303701)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 11:55:04 +0800
Message-ID: <d50555e9-3b8e-41d4-bec6-317aaaec5ff0@linux.alibaba.com>
Date: Sat, 23 Dec 2023 11:55:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix EROFS Kconfig
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Gao Xiang <xiang@kernel.org>
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
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2265065.1703250126@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/22/23 9:02 PM, David Howells wrote:
> This needs an additional change (see attached).
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 1d318f85232d..1949763e66aa 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -114,7 +114,8 @@ config EROFS_FS_ZIP_DEFLATE
>  
>  config EROFS_FS_ONDEMAND
>  	bool "EROFS fscache-based on-demand read support"
> -	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
> +	depends on CACHEFILES_ONDEMAND && FSCACHE && \
> +		(EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y && NETFS_SUPPORT=y)
>  	default n
>  	help
>  	  This permits EROFS to use fscache-backed data blobs with on-demand
> 

Thanks for the special reminder.  I noticed that it has been included in
this commit[*] in the dev tree.

[*]
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=netfs-lib&id=7472173cc3baf4a0bd8c803e56c37efdb8388f1c


Besides I noticed an issue when trying to configure EROFS_FS_ONDEMAND.
The above kconfig indicates that EROFS_FS_ONDEMAND depends on
NETFS_SUPPORT, while NETFS_SUPPORT has no prompt in menuconfig and can
only be selected by, e.g. fs/ceph/Kconfig:

	config CEPH_FS
        select NETFS_SUPPORT

IOW EROFS_FS_ONDEMAND will not be prompted and has no way being
configured if NETFS_SUPPORT itself is not selected by any other filesystem.


I tried to fix this in following way:

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1949763e66aa..5b7b71e537f1 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -5,6 +5,7 @@ config EROFS_FS
        depends on BLOCK
        select FS_IOMAP
        select LIBCRC32C
+       select NETFS_SUPPORT if EROFS_FS_ONDEMAND
        help
          EROFS (Enhanced Read-Only File System) is a lightweight read-only
          file system with modern designs (e.g. no buffer heads, inline
@@ -114,8 +115,10 @@ config EROFS_FS_ZIP_DEFLATE

 config EROFS_FS_ONDEMAND
        bool "EROFS fscache-based on-demand read support"
-       depends on CACHEFILES_ONDEMAND && FSCACHE && \
-               (EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y &&
NETFS_SUPPORT=y)
+       depends on EROFS_FS
+       select FSCACHE
        default n
        help
          This permits EROFS to use fscache-backed data blobs with on-demand


But still the dependency for CACHEFILES_ONDEMAND and CACHEFILES can not
be resolved.  Though CACHEFILES is not a must during the linking stage
as EROFS only calls fscache APIs directly, CACHEFILES is indeed needed
to ensure that the EROFS on-demand functionality works at runtime.

If we let EROFS_FS_ONDEMAND select CACHEFILES_ONDEMAND, then only
CACHEFILES_ONDEMAND will be selected while CACHEFILES can be still N.
Maybe EROFS_FS_ONDEMAND needs to selct both CACHEFILES_ONDEMAND and
CACHEFILES?

Besides if we make EROFS_FS_ONDEMAND depends on CACHEFILES_ONDEMAND,
then there will be a recursive dependency loop, as

fs/netfs/Kconfig:3:error: recursive dependency detected!
fs/netfs/Kconfig:3:	symbol NETFS_SUPPORT is selected by EROFS_FS_ONDEMAND
fs/erofs/Kconfig:116:	symbol EROFS_FS_ONDEMAND depends on
CACHEFILES_ONDEMAND
fs/cachefiles/Kconfig:30:	symbol CACHEFILES_ONDEMAND depends on CACHEFILES
fs/cachefiles/Kconfig:3:	symbol CACHEFILES depends on NETFS_SUPPORT


Hi Xiang, any better idea?



-- 
Thanks,
Jingbo

