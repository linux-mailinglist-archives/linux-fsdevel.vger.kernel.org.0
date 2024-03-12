Return-Path: <linux-fsdevel+bounces-14185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF3878FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E88B2155A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F57765C;
	Tue, 12 Mar 2024 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXuHJU+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29577649
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232482; cv=none; b=DzO3DFjbj8G5rGsVHXGiIRLc9jrJkIZJYri8bK6LnYGjbxr6iJ85MRytUAdGW/2P6yJVE8gX3ZY1iwkDrWMPiX5FR5reNdp+rZq9LmuOqWqx01z2D1AsYPQnY+7jkSlHgJBRFd8/IarYSoDIVDwkftgAdxiwOPAdFbBlKGEYtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232482; c=relaxed/simple;
	bh=dnUXV2BT0U/QHS1XqoridfxlcWnlBVFA9+slvCXLs9c=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0nN3UlPTyOI+jLaSqOCeNzdsgNnVtM4bGr8sDOy0nLzmWf18BRl1S/3/yhsHWsOKOTk65PgO//S+4nzt4kFKy6WYtau6iWesnFM5XeFdxn0/JeUokfdPEKMFYTcQjMMvSBlINQ4uEYMeH+KPmvqRT0HzQ5AI8f2s6IL3WYddkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXuHJU+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFAAC43394
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710232481;
	bh=dnUXV2BT0U/QHS1XqoridfxlcWnlBVFA9+slvCXLs9c=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=OXuHJU+0PaRguyLZ1eRHlk7a5WALSZtIa8r3hto9azSGZm0h/o+Qi/KYfh2A79hQ3
	 8AgvLXVgT9k+NJbZLowA2nzNjrTWbbpTU9lvJbG7dGNfg/Cuw23UTetwUfCA1MZCUg
	 jJ30gcCEovynpjIi+D4zMvzvgF4JVHMOBpjV5vxPUQ0ErfwoDKwsYOp2v8lbF3zcXM
	 amPFACgbhU5CBFpHGYBxs1kVzzK4cdJbm8UsxjFvYM7udqKswq5DIrEjIO+rPlmWEe
	 DpILkKNsMSd2jU9ggeFmoHxxQPAUiuJHdPLRJANfLX8vQQ53pcR3iUEz5M86++RVrI
	 QoxjYRopWfpaA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a2295cd61fso127519eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 01:34:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPoCJdlAz9TAX53ryOGE9C0l0lqyOX+mAqDQnUaFBiQZrtd4M44G3QeFGYMx5RwjJmX5evma0WVpH8GfA697oK4r3LHeLbrmKBLbdLVA==
X-Gm-Message-State: AOJu0Yy1CP/ibOPlI/Pw8RqP44/jBmF4AdP3AiNw82j3Q5BJeIK/l0L5
	9O0adxMZ7eTSei6HzKIt6IlyU48QMAINS4x1LHkX2srcIufygvUmtFWrOgllf1xgeWS7JUFdQ2u
	X58eKFWl39MJVRR90dX3z0Qqvwc8=
X-Google-Smtp-Source: AGHT+IGcQJiluaRkBMQJLLu1P3E1dvoxQ/H9QVNHboY0tWXioj8vMEiS1S+fn50Gccsi0dZHknKbTS1U8KCbL+pvZKY=
X-Received: by 2002:a05:6870:472c:b0:221:8787:89f7 with SMTP id
 b44-20020a056870472c00b00221878789f7mr8329293oaq.48.1710232480818; Tue, 12
 Mar 2024 01:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7bd4:0:b0:51e:5fb5:2f75 with HTTP; Tue, 12 Mar 2024
 01:34:40 -0700 (PDT)
In-Reply-To: <1891546521.01710140401877.JavaMail.epsvc@epcpadp3>
References: <CGME20240311042501epcas1p34655f4bf93feafb952ba35534b516c7e@epcas1p3.samsung.com>
 <TY0PR04MB6328049134D3D769E12E607F81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
 <1891546521.01710140401877.JavaMail.epsvc@epcpadp3>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 Mar 2024 17:34:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Ug-QjvPAyzkQQ+U47L1eRV1-O_x96o36Z_2kSmWep=Q@mail.gmail.com>
Message-ID: <CAKYAXd_Ug-QjvPAyzkQQ+U47L1eRV1-O_x96o36Z_2kSmWep=Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] exfat: improve sync dentry
To: Yuezhang.Mo@sony.com
Cc: Sungjong Seo <sj1557.seo@samsung.com>, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	Wataru.Aoyama@sony.com
Content-Type: text/plain; charset="UTF-8"

2024-03-11 15:21 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> This patch set changes sync dentry-by-dentry to sync dentrySet-by-
>> dentrySet, and remove some syncs that do not cause data loss. It not only
>> improves the performance of sync dentry, but also reduces the consumption
>> of storage device life.
>>
>> I used the following commands and blktrace to measure the improvements on
>> a class 10 SDXC card.
>>
>> rm -fr $mnt/dir; mkdir $mnt/dir; sync
>> time (for ((i=0;i<1000;i++));do touch $mnt/dir/${prefix}$i;done;sync
>> $mnt)
>> time (for ((i=0;i<1000;i++));do rm $mnt/dir/${prefix}$i;done;sync $mnt)
>>
>> | case | name len |       create          |        unlink          |
>> |      |          | time     | write size | time      | write size |
>> |------+----------+----------+------------+-----------+------------|
>> |  1   | 15       | 10.260s  | 191KiB     | 9.829s    | 96KiB      |
>> |  2   | 15       | 11.456s  | 562KiB     | 11.032s   | 562KiB     |
>> |  3   | 15       | 30.637s  | 3500KiB    | 21.740s   | 2000KiB    |
>> |  1   | 120      | 10.840s  | 644KiB     | 9.961s    | 315KiB     |
>> |  2   | 120      | 13.282s  | 1092KiB    | 12.432s   | 752KiB     |
>> |  3   | 120      | 45.393s  | 7573KiB    | 37.395s   | 5500KiB    |
>> |  1   | 255      | 11.549s  | 1028KiB    | 9.994s    | 594KiB     |
>> |  2   | 255      | 15.826s  | 2170KiB    | 13.387s   | 1063KiB    |
>> |  3   | 255      | 1m7.211s | 12335KiB   | 0m58.517s | 10004KiB   |
>>
>> case 1. disable dirsync
>> case 2. with this patch set and enable dirsync case 3. without this patch
>> set and enable dirsync
>>
>> Changes for v3
>>   - [2/10] Allow deleted entry follow unused entry
>
> looks good. Thanks for your patch.
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied them to #dev, Thanks for your patch!

