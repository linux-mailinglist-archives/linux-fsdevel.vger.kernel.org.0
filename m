Return-Path: <linux-fsdevel+bounces-21513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F8904D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D1B1F2234F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2416C69A;
	Wed, 12 Jun 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV443ofc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C916B73F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178685; cv=none; b=eEN8AAItQ5yxbnhRz/fWPsAksF2gI2M5NDm2vA0ZFbwwZRvu5Zt9KcnqcBSeCii7L9uR4/zE7/T2VqlvwMsUuDsIZroMm6Aae+6wbb873mYcuQOQFdcrSK7DT+HILPyFVWKURHWzVyrgejWEEw9xvZt4KLUYUYJdV1eWwW06qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178685; c=relaxed/simple;
	bh=sZYtzv4VmPJ9VIAC4vjHYxiewwXiUUTn7ioIQRg72b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXgSNb00AVOsxa4Gd5VIphwtnJmj5CMovjgCHamJvlnR3b0I3ww4rr/OBgZnC/x6IE0sPPDJSNVa9hEIB/+S9TeH1pEFrszuR6bDPiFXznBouA2TUQd8A5aJHMFAL+2Fw53M4nZMaI4IE6HQesCuaodoJikDWbrSN9lJEyAfcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV443ofc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718178683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIaaK6W8uT5BSnueoPNeLW1MUPaP1VwOj2mmYxfHPko=;
	b=CV443ofcnlcjevQJnCicindOBQw5tjGj/fAxKVZpKwu/dhu1KYMF1qGuLtvM0Sq6qIsB1k
	Jh/rmTn6YNzYkEBS0IjcNBn49w8bO7NOSPSJkgHVzsKFCmd9ETzFDdAiQTLTXtIH1GI6Uy
	Q47fcGGuF2gtxa5QajzSGVREhD4x+Dk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-JUccAlhmM0KA6ZmIUYte6w-1; Wed, 12 Jun 2024 03:51:18 -0400
X-MC-Unique: JUccAlhmM0KA6ZmIUYte6w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f728a74f25so17278685ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 00:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178677; x=1718783477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIaaK6W8uT5BSnueoPNeLW1MUPaP1VwOj2mmYxfHPko=;
        b=NdNm6CPi7U45FyjMBGcwpY7SAN549XcVbhqVhO3gKrcDIyUScFaYOwUe6DLPS9LYVY
         b3/sxEXftLX9Ys6iu/QXtDufrYh0qwdVyLgayk3frO7Hi3Df1G5FCoHN2XH3a5GnPEe9
         uG6CtyL5gdwxZHYRo0iqESeeYED7eJs76VhSNNCi9+geIbx6/HF8cieFcCcpYHGxiB0w
         9qwyR/VJS/dujJYS0wY2nGbhdjEAlxAJXiUhNauhQvS37qj6sPA9eLM3c5wI6TrTFk0D
         qYEF8bSZKaO0v6vF9EH/gYSLfijqZ8o6EYnWGamFOitk05N7LTtfU3fHDcNaBmXV562f
         cT6g==
X-Forwarded-Encrypted: i=1; AJvYcCWK/aY4wZaZFscCeAiGCA/IROvzw9HyIh6X8a3VkXxv4DOpRMAQFQSoTj3eyiaSi0W6IgrRPiINDYkKPmnNjH59OzmbnK7O5Yj15qzmNg==
X-Gm-Message-State: AOJu0YyqkfJqqhwWZWs1r4Qg2mlRCzuh18XkbMHiirQSxkVr+9XvIv1s
	aN9FXPheSWqZekRFfWBV+b6Pelmr7AdQ0TsQqAg3vhg/UTCBRPX03dG6irsdymf1aaCNQ6dEslk
	BTKGi21BVTbrzMMg9Rau33/2UOchOD8mkj4lAeVLemxIY5FSrQXTLbkYhCA6QLH0=
X-Received: by 2002:a17:902:d4c7:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f83b56bcf9mr11315745ad.20.1718178677076;
        Wed, 12 Jun 2024 00:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMX7aSBeEp6lKbXd+g1sAM5yfWtpI+0C98OJ7FfMPgAute/8BdN1T/JNbfc807HHvAghLdtQ==
X-Received: by 2002:a17:902:d4c7:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f83b56bcf9mr11315425ad.20.1718178676391;
        Wed, 12 Jun 2024 00:51:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72561cfb4sm35303155ad.268.2024.06.12.00.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:51:16 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:51:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 4/5] _require_debugfs(): simplify and fix for debian
Message-ID: <20240612075109.b7omu4pipo2p4sjx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-5-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-5-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:01PM -0700, Luis Chamberlain wrote:
> Using findmnt -S debugfs arguments does not really output anything on
> debian, and is not needed, fix that.
> 
> Fixes: 8e8fb3da709e ("fstests: fix _require_debugfs and call it properly")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 18ad25662d5c..30beef4e5c02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3025,7 +3025,7 @@ _require_debugfs()
>  	local type
>  
>  	if [ -d "$DEBUGFS_MNT" ];then
> -		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -o FSTYPE)
>  		[ "$type" = "debugfs" ] && return 0
>  	fi
>  
> -- 
> 2.43.0
> 
> 


