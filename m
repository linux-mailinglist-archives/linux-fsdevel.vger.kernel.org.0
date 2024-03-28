Return-Path: <linux-fsdevel+bounces-15496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB288F4E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E01F2B4BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966262263A;
	Thu, 28 Mar 2024 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFJDa28K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F361BDEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590520; cv=none; b=lEw7JjS3fj+g5Fb7XJPxDRUwA2uCAO/5Bq4l3CjoE71GHiR1MHKPjgr8UJ9nea1ryNXeZfZA1a+Y5L99LFCHd9bsgHH0RlOlX8qkzIPEDhl25Nhk2InyJ/pJUpSZww7WgGd3ZHRwZfG/hgANBCBBITMvV04QkTr9i9Lv4cDfLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590520; c=relaxed/simple;
	bh=eOkbu3OBv4Si34quW3MgK7iQ7dO1Yuh23hV9JYBs7P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENVSyGHPxjd1rY4PLcW6VBteMoZ2aGQFFjmBEGFlZ8Dw63CyDVv8umLwIno/zMOk7V1PX3fqSEYtVtKgna4glkmiQHiRKzdhDAj75YLvV3QOmRmjpq4OrpCdTnuHegEArx3Sa4D+VJuILi0kDsxn0mDBbRzPPlh22x0utUR88mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFJDa28K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711590516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms3mo6grZ1J92R+XQiZMnioOtLmeHwZYPWNCbExS/N4=;
	b=CFJDa28KSV9dRMvT8sSdE4ECy31J5rrq9nzsaIkeGceXA2SBxRrtt9qzsW7/oDS4ZWBmSp
	ILRaRE1eSx0RXlVMDBY5XT/6PM9SmkyaDPVaiWWLae7UVCXCcKqE3qfRzWtuB2NRb7wQ9N
	HpkFqSSFMTJhLNGGZXwJ1M1uPk451OY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-lFeLVmLoN8m1AheDhDE6vA-1; Wed,
 27 Mar 2024 21:48:32 -0400
X-MC-Unique: lFeLVmLoN8m1AheDhDE6vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03AA02803622;
	Thu, 28 Mar 2024 01:48:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17290111E3F3;
	Thu, 28 Mar 2024 01:48:30 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:48:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
Message-ID: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 03/27/24 at 09:10pm, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated in
> some situations [1]. While the specific use of strncpy that this patch
> targets is not exactly deprecated, the real mission is to rid the kernel
> of all its uses.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we can see that both `name` and `dump_name` are u8s. It seems `name`
> wants to be NUL-padded (based on the comment above), but for the sake of
> symmetry lets NUL-pad both of these.
> 
> Mark these buffers as __nonstring and use strtomem_pad.

Thanks.

I didn't build, wondering if '__nonstring' has to be set so that
strtomem_pad() can be used.

Thanks
Baoquan

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c            | 5 ++---
>  include/uapi/linux/vmcore.h | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d7ecf3b75e8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
> +	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);



>  }
>  
>  /**
> diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
> index 3e9da91866ff..7053e2b62fa0 100644
> --- a/include/uapi/linux/vmcore.h
> +++ b/include/uapi/linux/vmcore.h
> @@ -11,8 +11,8 @@ struct vmcoredd_header {
>  	__u32 n_namesz; /* Name size */
>  	__u32 n_descsz; /* Content size */
>  	__u32 n_type;   /* NT_VMCOREDD */
> -	__u8 name[8];   /* LINUX\0\0\0 */
> -	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> +	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
> +	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
>  };
>  
>  #endif /* _UAPI_VMCORE_H */
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 


