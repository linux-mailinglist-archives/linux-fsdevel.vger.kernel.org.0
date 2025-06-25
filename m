Return-Path: <linux-fsdevel+bounces-52930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F7AE88DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285B5169F83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938729E0FA;
	Wed, 25 Jun 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Vq2k33H2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5871A7264;
	Wed, 25 Jun 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866919; cv=none; b=TF3OkT/4IBjchi1PDmEdTSeBHAoJK5NoPSSiDjH7ZXE/FC23kyQY+1CU/5hAZ131RQskdlcqFjHijQRSrO0DWkyEigaQQ3jxF0rLp2SRJmdXoOZ6jHcJn4M6zVTF6Ljyycs187XXXlRyOrtekeYRGFMuNWYTQYNms1WFS1rnca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866919; c=relaxed/simple;
	bh=nMg/fmRzABUVMBMxW77r3Z5ilmHMlpfCmcUZk5LUX2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmiL2Y1d2jA/IZT/H25fkrnnWuBs+02h6O1w5sS/kYg74FEdA7WlccdpELkM/sTuFPrFgDQ7CZ1mcnQz2U9wb4HJZ7AklC7PkUbvdEYjf4existBNPb7QhZMrUHXWj0pZSBf6QkToz4ItRj06bbHsXREtP7L7vfAz6rXpEmvyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Vq2k33H2; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=vQ2ISujzgMsOuy0zYRu3RYmEVeMJJSS3rBIsIzJ2HbY=; b=Vq2k33H2AlmHKFttx/KWXpfyFV
	nTP11K6mYya9sN2RyU3h9dUPIdisAgozsweNkF/oC/mlmrU+Eu5GE8jCBc8fl20lYAlRogduMqX3l
	O1I/qtDgFSwwtGSE4NfGnORUl5mqnItsTfDrQcEHOXXx/8mnMht3n5mQN84U4IOqttrY+yq8BGxno
	dlRRbQcNyUjDflXXvAqVk6hPPfDSROThMUml8cQjXFXBj1r72gKMOsXS7f1N5uU/1rZWiWV7Ty67u
	Q8K3yhthMZN9j61zUn/oMvDTLhCvp/Vv3GNQdEeZ2eDOiKmv5rQ1VWW+QVxwM/e/YPK8Dy3ifvpvF
	FVqT+zzPpTD/0q4kICF2ZgmlVdtZP+5KLQL6+qFQUePThJKbTx8P2p406RCun3RsUAQq0p62ANYMb
	MW1phQGkQ1hi2szjFwzIqB8d3CpY4tJEeOKR/ZoCOiXrjP3FPPy1TW6QJnF5wl9skAmwH8vwWgGEy
	ecCkskJul48CvOmrdxBv/4lD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUSSw-00CRa4-38;
	Wed, 25 Jun 2025 15:55:15 +0000
Message-ID: <011ec23b-d151-4ef8-bbe7-ba79e3678ae7@samba.org>
Date: Wed, 25 Jun 2025 17:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cifs: Fix the smbd_request and smbd_reponse slabs to
 allow usercopy
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1372501.1750858644@warthog.procyon.org.uk>
 <1382992.1750862802@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1382992.1750862802@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

reviewed-by and tested-by: Stefan Metzmacher <metze@samba.org>

Am 25.06.25 um 16:46 schrieb David Howells:
>      
> The handling of received data in the smbdirect client code involves using
> copy_to_iter() to copy data from the smbd_reponse struct's packet trailer
> to a folioq buffer provided by netfslib that encapsulates a chunk of
> pagecache.
> 
> If, however, CONFIG_HARDENED_USERCOPY=y, this will result in the checks
> then performed in copy_to_iter() oopsing with something like the following:
> 
>   CIFS: Attempting to mount //172.31.9.1/test
>   CIFS: VFS: RDMA transport established
>   usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_response_0000000091e24ea1' (offset 81, size 63)!
>   ------------[ cut here ]------------
>   kernel BUG at mm/usercopy.c:102!
>   ...
>   RIP: 0010:usercopy_abort+0x6c/0x80
>   ...
>   Call Trace:
>    <TASK>
>    __check_heap_object+0xe3/0x120
>    __check_object_size+0x4dc/0x6d0
>    smbd_recv+0x77f/0xfe0 [cifs]
>    cifs_readv_from_socket+0x276/0x8f0 [cifs]
>    cifs_read_from_socket+0xcd/0x120 [cifs]
>    cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
>    kthread+0x396/0x830
>    ret_from_fork+0x2b8/0x3b0
>    ret_from_fork_asm+0x1a/0x30
> 
> The problem is that the smbd_response slab's packet field isn't marked as
> being permitted for usercopy.
> 
> Fix this by passing parameters to kmem_slab_create() to indicate that
> copy_to_iter() is permitted from the packet region of the smbd_response
> slab objects, less the header space.
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Reported-by: Stefan Metzmacher <metze@samba.org>
> Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c |   18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index ef6bf8d6808d..f9773cc0d562 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -1475,6 +1475,9 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
>   	char name[MAX_NAME_LEN];
>   	int rc;
>   
> +	if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data_transfer)))
> +		return -ENOMEM;
> +
>   	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
>   	info->request_cache =
>   		kmem_cache_create(
> @@ -1492,12 +1495,17 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
>   		goto out1;
>   
>   	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
> +
> +	struct kmem_cache_args response_args = {
> +		.align		= __alignof__(struct smbd_response),
> +		.useroffset	= (offsetof(struct smbd_response, packet) +
> +				   sizeof(struct smbdirect_data_transfer)),
> +		.usersize	= sp->max_recv_size - sizeof(struct smbdirect_data_transfer),
> +	};
>   	info->response_cache =
> -		kmem_cache_create(
> -			name,
> -			sizeof(struct smbd_response) +
> -				sp->max_recv_size,
> -			0, SLAB_HWCACHE_ALIGN, NULL);
> +		kmem_cache_create(name,
> +				  sizeof(struct smbd_response) + sp->max_recv_size,
> +				  &response_args, SLAB_HWCACHE_ALIGN);
>   	if (!info->response_cache)
>   		goto out2;
>   


