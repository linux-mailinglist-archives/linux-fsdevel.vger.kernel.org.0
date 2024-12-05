Return-Path: <linux-fsdevel+bounces-36519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63E9E4ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 08:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123B3282D08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4291B395D;
	Thu,  5 Dec 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TAxaQW8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F841B3920
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384489; cv=none; b=f1z0eavSQLteLXr5l+F10KhfjQxfv2wwSSkNi6yFuTwnS8SqbYodC8keCbJknF3Z2hSdARDX6lWX12OxO+NwnSLJm4x6ssG+3SRxpz0zySUQAYPk+eXZQxSmzKfDqwxQ7YFGJPTlYZQSq6/wkLGDGXbcZ4baEypt5IcFML78eqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384489; c=relaxed/simple;
	bh=DthMQoZKMTxvajq4Ylkmt9T/7bmSPBTFu2U1KbLcL5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=Q0oKYT8+i4R9ly//67K013NwFIkMU8EoR59SX8fB0BPrxbgFqjuU/cmOQnDiYnVGmfMyIIl9bUHVFELPUeHuI6cpKt3d+bYzO8wifKcUnq4TF4ik+PlwE5ikRTbQq3J1bx1IvLDWiKDSuaN1w/29VXrCtjF/+ffOI5i+j199hPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TAxaQW8q; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241205074124euoutp02c882dd08a6f49300354418bb36aeeb3a~OOAFP5Giu0866608666euoutp02j
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 07:41:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241205074124euoutp02c882dd08a6f49300354418bb36aeeb3a~OOAFP5Giu0866608666euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733384484;
	bh=9l5w3NB9miD8q0CXwkdquu/s2ItmY+DCoaSmhTGHlRw=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=TAxaQW8qjKXYpfB1rTUdDzaWLmIBLfyaHdQaPQC00aTAWRnrmfJ1c2u3pB1H5qkO6
	 sObyH8EWHJsgZmqA9JN7gablr8yBdM4Yo09qbuALStNTcag7+vk1tnqZG+p1nixpE1
	 FWtao9pOPUdzdsDI41V8xr3l6fK4jBLOlR0sH3Kg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241205074124eucas1p1c64d530f22215c16940745bdc80628f2~OOAFA6AjE1385513855eucas1p1z;
	Thu,  5 Dec 2024 07:41:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1F.41.20821.42951576; Thu,  5
	Dec 2024 07:41:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241205074124eucas1p1bbe274574d58be803dd2b85244e91406~OOAEwfPN43090030900eucas1p1E;
	Thu,  5 Dec 2024 07:41:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241205074124eusmtrp28114dc3f61b27dd015973135a1a742bb~OOAEv80-K0429304293eusmtrp2I;
	Thu,  5 Dec 2024 07:41:24 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-ce-67515924a24a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.60.19654.42951576; Thu,  5
	Dec 2024 07:41:24 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241205074124eusmtip21009833e885a3b01394641dd540705ff~OOAEjFrV70488604886eusmtip2_;
	Thu,  5 Dec 2024 07:41:24 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 5 Dec 2024 07:41:23 +0000
Message-ID: <95e41652-65c9-4fd7-9cc4-344b90b006b6@samsung.com>
Date: Thu, 5 Dec 2024 08:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/config: use modprobe -w when supported
Content-Language: en-GB
To: Luis Chamberlain <mcgrof@kernel.org>, <patches@lists.linux.dev>,
	<fstests@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <gost.dev@samsung.com>,
	<sandeen@redhat.com>
From: Daniel Gomez <da.gomez@samsung.com>
In-Reply-To: <20241205002624.3420504-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGOd/3bfscrY6z8O2Co6VFUVOhdHZZd1r0RxdLqaRaedo0tbE1
	a5ExNJOki6lhjVIDy7S0tdaycGazvLTKLkqiWURJIq3I2coKrflp+d/vvM/znvd9Doelxcd5
	k9iElH1El6JKkvKFjL2+/+mc4M3r1WEDLVK564hDIK92NDHytpwuJH/Z+ALJC2xLl/CU1vJj
	fGX3zXNI+aWmla/0WIPWMVuEC+NJUkIq0YUqdgg1tvzvfO2zoAPv0h0CEzJNzEZ+LOC50PnC
	irKRkBXjKwiyCh3IJ4hxH4IWD8UJHgTuq8d4Ix2WJx0CTihF0HvyCf+fq+H9GZo7VCE4Xlv8
	18ayIqwAV43I183gYChqc9E+FmF/aDr3gfHxBCyBt+1nBT4OwMvgddZRysc0DoT0vrKhyePx
	Dii1fKS5ejRk5H8ZWpWPZ0JNk3Wo1w9HweXSbL5vLI3nQ0Hjas4ugdvu8zQXYCqcPV3GcJwG
	j2ztQykBd7PwfjBz2LQCPG0ZAo4DoKfBNsxTYPBOEcWxGkoqzcMXaaG6w8zzzQW8AE4+TuLK
	S6G+7xLDlcdCm9ufW2cs5NoL6BwUYh71EOZRgc3/A5hHBShGTDkKJAZ9sprow1PIfplelaw3
	pKhlu/YmW9HfD+MaaOitQhd6vsqciGKREwFLS8eLjDHr1WJRvMp4kOj2btcZkojeiSazjDRQ
	FBIvIWKsVu0jewjREt2ISrF+k0zUyoTbwdsen7jXLrBkmvA0D5NaHW2we08XHIWtPLd3w1dT
	ZovmlXKZ83Pi2/KcbzCjLpJ3x6nI++1orYhbVGt3QQjrvbb4e6L29S+F/IZZMyekZ8xybQmp
	WJ2n1VTuDKUSqbLnYfzOiz3p6jpZ56H6/Ngb+ZHdG+OEFzaFeeGn/7Mxxltp542FedMiRJML
	eTEW4dXm2irvL8N+mduZOyViXLXN+KNi7fwPD4t2fyKo1zLzY6gsV1Iyu2Oeve5+S1cxItKs
	GJ5VQoU3303TgLA2upC57jp12NUYR0n6u/otlam5VsPgD8XU4mbT9E2ta1ZFUVE1b9ITYh+Q
	TCmj16jCZ9E6veoPrVwHE58DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7oqkYHpBocP81qcbtnLbrFn70kW
	ixsTnjJaXD5xidFi+hZHB1aPTas62TxebJ7J6PF+31U2j8+b5AJYovRsivJLS1IVMvKLS2yV
	og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQytkz5zlZwQa7iYdNe9gbGBsku
	Rk4OCQETiQ1nb7N3MXJxCAksZZRY2rGGBSIhI7Hxy1VWCFtY4s+1LjaIoo+MEvfv/2eGcHYw
	Smx6+gaog4ODV8BO4vQ+XpAGFgEVifk3TjOD2LwCghInZz4BGyoqIC9x/9YMdhBbWMBJ4k57
	GxOIzSwgLtH0ZSXYMhGBBInlG54zQ8SDJZqnvGeE2NXDKDF1znOwQWwCmhL7Tm4CG8QpYCmx
	bDnIdSANFhKL3xxkh7DlJba/ncMM8YGixIyJK6E+q5X4/PcZ4wRG0VlI7puF5I5ZSEbNQjJq
	ASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMD43Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmE
	tzIsMF2INyWxsiq1KD++qDQntfgQoykwkCYyS4km5wMTRF5JvKGZgamhiZmlgamlmbGSOC/b
	lfNpQgLpiSWp2ampBalFMH1MHJxSDUwdLxk23nzss9eqtDD7i6XxZ+kiofMlFrbygZaW4Rur
	5r3Ya8vwZ2Vpqbi26c6wrima1tvPzdefd81hj47Sp8rbyus/He5adOpsSefdWOdamecGq/ND
	DH82M2foLsrgO3G0YWu94vKQP22vXmpulsyJ+7t2zuLwyc9YZGfZTvRLm5nfpuvrNKV7vu20
	kEC144z3gt74KT4xLIgTfl8SxMDcbv8oki1pypz9WudPXrTOXry0Oerkvb9Swft0QgLfdDzI
	T3EsZxB9mt+8ZynPrvy13zxF8xWPVH1xyHb9nflH/E/HB/HrSQJ+CgwtH/nbO0u4leST3wV2
	lR3vd/d+/YuFVVNWkld3mnPFub4eJZbijERDLeai4kQAtcJbhFgDAAA=
X-CMS-MailID: 20241205074124eucas1p1bbe274574d58be803dd2b85244e91406
X-Msg-Generator: CA
X-RootMTR: 20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680
References: <CGME20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680@eucas1p1.samsung.com>
	<20241205002624.3420504-1-mcgrof@kernel.org>

On 12/5/2024 1:26 AM, Luis Chamberlain wrote:
> We had added support for open coding a patient module remover long
> ago on fstests through commit d405c21d40aa1 ("common/module: add patient
> module rmmod support") to fix many flaky tests. This assumed we'd end up
> with modprobe -p -t <msec-timeout> but in the end kmod upstream just

I can't find modprobe -p and/or -t arguments in the manual. What do they 
mean?

Well, I'm now seeing this "patient" support:
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=d405c21d40aa1f0ca846dd144a1a7731e55679b2

but i can't find the module remover support in kmod.


Nit. I find useful using the long argument instead of the short one 
(e.g. --wait instead of -w). as it's usually self-descriptive. But I 
guess we don't have that long option for -p and -t?


Daniel

> used modprobe -w <msec-timeout> through the respective kmod commit
> 2b98ed888614 ("modprobe: Add --wait").
> 
> Take advantage of the upstream patient module remover support added
> since June 2022, so many distributions should already have support for
> this now.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Eric, I saw you mentioning on IRC you didn't understand *why*
> the patient module remover was added. Even though I thought the
> commit log explained it, let me summarize again: fix tons of
> flaky tests which assume module removal is being done correctly.
> It is not and fixing this is a module specific issue like with
> scsi_debug as documented in the commit log bugzilla references.
> So any sane test suite thing relying on module removal should use
> something like modprobe -w <timeout-in-ms>.
> 
>    Luis
> 
>   common/config | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/common/config b/common/config
> index fcff0660b05a..d899129fd5f1 100644
> --- a/common/config
> +++ b/common/config
> @@ -264,7 +264,7 @@ export UDEV_SETTLE_PROG
>   # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
>   # modprobe removal to run forever trying to remove a module.
>   MODPROBE_REMOVE_PATIENT=""
> -modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "remove-patiently"
> +modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "wait TIMEOUT_MSEC"
>   if [[ $? -ne 0 ]]; then
>   	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
>   		# We will open code our own implementation of patient module
> @@ -276,19 +276,19 @@ else
>   	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
>   		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
>   			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> -			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-w $MODPROBE_PATIENT_RM_TIMEOUT_MS"
>   		fi
>   	else
>   		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
> -		# with environments without support for modprobe -p, but we
> +		# with environments without support for modprobe -w, but we
>   		# only really need it exported right now for environments which
> -		# don't have support for modprobe -p to implement our own
> +		# don't have support for modprobe -w to implement our own
>   		# patient module removal support within fstests.
>   		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
>   		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> -		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-w $MODPROBE_PATIENT_RM_TIMEOUT_MS"
>   	fi
> -	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
> +	MODPROBE_REMOVE_PATIENT="modprobe $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
>   fi
>   export MODPROBE_REMOVE_PATIENT
>   


