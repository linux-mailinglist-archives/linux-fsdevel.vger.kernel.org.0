Return-Path: <linux-fsdevel+bounces-56550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B1B18B36
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04C91AA02FE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C91A3142;
	Sat,  2 Aug 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avcA02Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E28F7D
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Aug 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122730; cv=none; b=DXxgsz41N3ako52c6WWcwXXBA8WL5gLM2u53pPooj6oXFh8UPQTieKMmF+XurrBLllm6Nooyv9F56Jz/ScRGiV3TuFkyFqRbtEPuCkWrxJuK2ddia0+TWRUMz1NewaAXzxzm3DaA2g/H5Xp4XF2dFpOpuyMsxZj18JMq4G2617A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122730; c=relaxed/simple;
	bh=ZPb92UXoYoBstPxrvH+BmwG3tRUtSr1DqHtspTQBGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WieH94BqoyT/JlvZa9kRyvvtMOa+dTT3+lotYIQZgTnvJYUEpCxrREKT/4wksreaw3sS0qCQa+m5zGv9tLHDmf4PiG3caVhHvraAGpl/AQFVuJvY1lZD15DBNdpGln7pHFY61BULM7GkmN9aBttdV86/hEXGmp155bMh9q53cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avcA02Eh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754122728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ctkLsza+5GIefWa+vyFSs9TRNgx1inMYSvhWFJuNFnI=;
	b=avcA02EhfM4lr3uur2v6pNrpgZSEE0GILEseFiHCs8RG2YJmnPoJuD+MN6M3Ou2Y1iZa0H
	U83hG9f4c9gLuHDD24ivuNn0mbE9ZO6vll0X/HgsdzT1PoEA665FhS6zJfSHO5aNbcRXJS
	x9FhcRqJ9v59QvixsFhcPUAXjictV78=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-0j1fS0w_Mn613D8bA-0idA-1; Sat, 02 Aug 2025 04:18:47 -0400
X-MC-Unique: 0j1fS0w_Mn613D8bA-0idA-1
X-Mimecast-MFC-AGG-ID: 0j1fS0w_Mn613D8bA-0idA_1754122726
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-237f8d64263so33242975ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Aug 2025 01:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754122726; x=1754727526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctkLsza+5GIefWa+vyFSs9TRNgx1inMYSvhWFJuNFnI=;
        b=uxlWK1SJg1NbBICd94M5uRh5JFad4yNuSOykBtUezvNCS4is7i2F/JIiMtMLY2apEG
         Y3vhUU5atoNt6RsE4i4ijFrBQEgMBo+reZbtG8LdNgzW70iq+JS1rTUsThRxlLPpYGMw
         sOTepy+7HZVPtgOxnmliRS5hRTM/87rjQEwmutaOiIT64p4a7TxtGJzvTGgUAmEgC7/t
         o7sG25FE5r/zWBf2zwd7l+MID26rnCzS2rzSnbtc7VyJDF32CpSOWm5j2piJlVqtMMqT
         8UPg0OoLbCmo1w/bYqNJSV5MUhmX6CWUXyMvBqPYw9pKg1S6ZeDm9UqQUcmESNQqHYZt
         4UQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvapr6qRXmPJhDdfcvLogk4TNB4BTf/7yICs3tSuyjbBC9dvEXoqZ73QCKJWU1vebPOMwtO7fHpxykwtIe@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLaLxqaNuNXaXPsJ9SuF8oi64IV/EoL0y6cr/MiHrUC6OIUq7
	p7gFfHsjhH3oBUiEzaqYHFwhA+Lv3NC3wtxDZS4Fy3rY2JM3IwHmhAkIGL3owxdXNEX8iGSlQDt
	7OG2GGDMcy+xg5pSgCBborH7ai/MNYoDMidQc6bUZkPhVrw3A/kIOOJTowZ9QuRgjz3U=
X-Gm-Gg: ASbGncsmbdPI1N0i/yZLe8pNrsIVCNZ6Lo62Ubyhrt7/rOrJ4gMEKOw1nI3UhoS36cW
	r9nRG5UIvXr4reCg97IFpd05KN9BiwGmL/UR4G7aVfR9R4ciaXGnQOPldJHeqC5r4FQDCwx5bXY
	kfUuKBvcQJJPO0vmNNTWjeVPy6yncLqUULH7gjnkPd/MMhrhbvcbvwexh6fR5OTndg0PqQguX3D
	jJlOtpXjRPfrn8LELIWBUNTuFkA87mdIKo0FhbvINJhv/yaE3HnB1EoYYTZGyq13nvrCTgB1jFQ
	TrWRiKNGk/RQtXtWRdUpF9Y8dB9ZFW9CNRS/OSJhk7w61980x7gmlZT0PCPIPphhKvxYeXoLsZ5
	fNq0+
X-Received: by 2002:a17:902:db11:b0:235:f49f:479d with SMTP id d9443c01a7336-24246f3e84cmr29876555ad.3.1754122726002;
        Sat, 02 Aug 2025 01:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoyg9T+vcYnoLLXUhwyN/5RSxfQTEzfdYmpwkOJvClaFFujcVcJBED8MsKpFaVCp6Msf+p9A==
X-Received: by 2002:a17:902:db11:b0:235:f49f:479d with SMTP id d9443c01a7336-24246f3e84cmr29876445ad.3.1754122725656;
        Sat, 02 Aug 2025 01:18:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm61362585ad.36.2025.08.02.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 01:18:45 -0700 (PDT)
Date: Sat, 2 Aug 2025 16:18:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/2] aio-dio-write-verify: Add O_DSYNC option
Message-ID: <20250802081840.usinvu6tkv7anbvd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>

On Thu, Jul 31, 2025 at 06:05:54PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds -D for O_DSYNC open flag to aio-dio-write-verify test.
> We will use this in later patch for integrity verification test with
> aio-dio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index 513a338b..0cf14a2a 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -40,6 +40,7 @@ void usage(char *progname)
>  	        "\t\tsize=N: AIO write size\n"
>  	        "\t\toff=M:  AIO write startoff\n"
>  	        "\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
> +	        "\t-D: uses O_DSYNC flag for open. By default O_DSYNC is not used\n"
>  	        "\t-N: no_verify: means no write verification. By default noverify is false\n"
>  	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
>  	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
> @@ -298,7 +299,7 @@ int main(int argc, char *argv[])
>  	int o_sync = 0;
>  	int no_verify = 0;
>  
> -	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
> +	while ((c = getopt(argc, argv, "a:t:SND")) != -1) {
>  		char *endp;
>  
>  		switch (c) {
> @@ -316,6 +317,9 @@ int main(int argc, char *argv[])
>  		case 'S':
>  			o_sync = O_SYNC;
>  			break;
> +		case 'D':
> +			o_sync = O_DSYNC;
> +			break;
>  		case 'N':
>  			no_verify = 1;
>  			break;
> -- 
> 2.49.0
> 
> 


