Return-Path: <linux-fsdevel+bounces-16036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC95D897202
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DFA1C26143
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B3148FE5;
	Wed,  3 Apr 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuXGQlbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D748147C61
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153439; cv=none; b=uAvN8UMdc/yfwjxOiy8nyu2tIFEFRHbeAG9anJ8okfs0xCttLvLb8i690l7JK30RJJGK+C4BKsNqG2pQvzilAmwwfTiby7dKQ8v7Fv5+atcKD1Z9W1w8PyCuj39rE64/u7bUoksbZhOicL/zJpO5M23nhNvomYDvVn3dEDzzTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153439; c=relaxed/simple;
	bh=gnQFujUVd4le7PN2eYoz/fObbbbcl8DGK6hCKJ6Zjnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/fRG61lTvPf/sKYf1P+1Q5AO6yOpV04Z2JNnoqYD3UJiK5bVlDP+8wvz0w+9Pz/Qoi3WQfsWbz3o3cSAhsfrYm77EppUdWvXPIpGzQKDYugvz5Ls/xdSipCvFDOYnObiuHiEhG11MOYGrZOzcYRqonmp4S4dM9eCyEk/WvNvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuXGQlbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712153437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2aBTyYb+Nt/ptLDXgMV8oWUST4z7rOytIWtEbvnm/I=;
	b=KuXGQlbeSVapxqTFQFAdsWWIaj0XDHNAiD/3OPOPJN/Y1TnJC7yKiI5UhQlY1YsrvYYK/8
	SpJrXk/28lwvGk1/wkE5kw896SfU6hT7MpKLOholLpN4LckomqFS79E/RnPLdFCrGD6pVm
	Y3CZ7zI6rg78g0VWzFosZeBiCWV6wv8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-eW8n61ReNeuGqyLOdL1GKg-1; Wed, 03 Apr 2024 10:10:35 -0400
X-MC-Unique: eW8n61ReNeuGqyLOdL1GKg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56e0ce8d705so245408a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153434; x=1712758234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2aBTyYb+Nt/ptLDXgMV8oWUST4z7rOytIWtEbvnm/I=;
        b=o9wJECAL6KjCpqjZNOxMzcpwY+IHV1hq+QYOv+jVf96/R62mRPvUO6T8hxPlGwVzsa
         WRfpw8T+T/TUp/OqfJHTfVqSU+TOZ+LFvV8E7M9mINLE/BNzFFf9OWZG60FHYs1H41Go
         E7CYnTKeaJz4qn8kQQ60YySyN6/ilSr5xUllj3GjEOVFDWu6NO9jRJ6aMvwCvb7rsJ5W
         9n33EKiDlvOw1EPAAxSPLru14fCE0Z3lZkHxtnLLNXZdvBvrRPxckTGCjwS3srp4+oH1
         5gkBIH9IwqCpi3QEXmRwxiCG8zncWB20bBndbOL1RS0dOuKZ8d0AdBinhTUHpZ8iCwne
         UDkw==
X-Gm-Message-State: AOJu0YzIFK1P4y3wi3xmGf/EHMGziTXD6GqD/NPb3ynbbTR0VrJa2O6g
	fhwD29ib0B1BXECC0GQbgU5JNORncakxuFKHA5ziwT3HG9PnxDIAaWJzH2m3hCuqrNh+U6Q1/8Y
	I/S7Yhmrdjw8bT/ZlZpb/JjInVA1Ukhe7+uk/gBtjbpjExEWgTHjokKUXKni/GTk=
X-Received: by 2002:a05:6402:27d3:b0:568:d315:b85e with SMTP id c19-20020a05640227d300b00568d315b85emr2403728ede.36.1712153434327;
        Wed, 03 Apr 2024 07:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGTz1BJSzH4XsYtIvDxE2Ibd4gH2Fl0QoKJfEwumIBmM+YFFAAfM84ZxOKH6aulkAAP1jXrg==
X-Received: by 2002:a05:6402:27d3:b0:568:d315:b85e with SMTP id c19-20020a05640227d300b00568d315b85emr2403684ede.36.1712153433621;
        Wed, 03 Apr 2024 07:10:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f4-20020a056402194400b0056c4cdc987esm8055405edz.8.2024.04.03.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:10:33 -0700 (PDT)
Message-ID: <6898c729-cc96-4611-9a5a-8e3558e1b69c@redhat.com>
Date: Wed, 3 Apr 2024 16:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: explicitly deny setlease attempts
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240319-setlease-v1-1-5997d67e04b3@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240319-setlease-v1-1-5997d67e04b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/24 5:32 PM, Jeff Layton wrote:
> vboxsf does not break leases on its own, so it can't properly handle the
> case where the hypervisor changes the data. Don't allow file leases on
> vboxsf.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have added this to my local vboxsf branch now and I'll send
out a pull-request with this and a couple of other vboxsf fixes
soon.

Regards,

Hans




> ---
> Looking over the comments in the code around cache coherency, it seems
> like it ought to deny file locks as well? We could add a stub ->lock
> routine that just returns -ENOLCK or something.
> ---
>  fs/vboxsf/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 2307f8037efc..118dedef8ebe 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -218,6 +218,7 @@ const struct file_operations vboxsf_reg_fops = {
>  	.release = vboxsf_file_release,
>  	.fsync = noop_fsync,
>  	.splice_read = filemap_splice_read,
> +	.setlease = simple_nosetlease,
>  };
>  
>  const struct inode_operations vboxsf_reg_iops = {
> 
> ---
> base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
> change-id: 20240319-setlease-ce31fb8777b0
> 
> Best regards,


