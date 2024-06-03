Return-Path: <linux-fsdevel+bounces-20900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6410D8FAA86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ED01C21908
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868C1411C8;
	Tue,  4 Jun 2024 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOQCvNDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86813F451
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481290; cv=none; b=c15iAEyn1rENtcNnc0qXF/4lw+3th2/tRfmMaDsnKMlpOkDtOjRKrRV6zu4HoTTQcWdSyi4zx5Fs9W6uWlNx3fGpzdbrsugi/bp8YzGJzH5Q3jyinvpGf8/OXNpeQxCC/57xLM0XZTZhu2QtI2SYl860gANYDDgweQrt8dK+apA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481290; c=relaxed/simple;
	bh=uBSMT/rJCeQH+/WQQglX9BDaLJwuZrWJKb3tRGMkiPg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=cz2TbOlCS5Vj8b3IF/7IKS3aTQMPk3GbwMlVMsWjURNxjvFjbteLMqUNqyDPnaGvIOmxP4cTDISayVchpWHoeIBDiaSrfeENc5QDsx5Xdz2lbqMVqWpJEpglcpf5Byutchc+35eCZ1z8F35RyqCa/DIDGSvzl/B/OtaG19AV8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FOQCvNDj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240604060807euoutp02d309b449e7e31a298d012e8d6ff00bc1~VuCGLnkq50472104721euoutp02e
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:08:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240604060807euoutp02d309b449e7e31a298d012e8d6ff00bc1~VuCGLnkq50472104721euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717481287;
	bh=fXwWGleR7MHxbZ9YCCDvKWivlC67g5iAbwjZphmcEeo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FOQCvNDjITCsVlOK5DnP7AKdUUhnBoTxmx++M1JNSbYwNy17ppTni8OiPszB1Fi3i
	 UBEmU0yZv+O/n60AxEBLD9MvFY2gztGx3P8MK83pmTO34sBzguMV5ifT2vNxP1AKXP
	 DDpiowbDAe9oc06geVgINEEbaADEW4BnJVVez44M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240604060806eucas1p2b5d355cdd13db417969c9a1b4a4f89ad~VuCF4AeEm1450314503eucas1p2L;
	Tue,  4 Jun 2024 06:08:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.49.09620.64FAE566; Tue,  4
	Jun 2024 07:08:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240604060806eucas1p22862dbc5e160cc485614c823ba1f77a3~VuCFhbCqT1406314063eucas1p2q;
	Tue,  4 Jun 2024 06:08:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240604060806eusmtrp162ffe2f0926e959a7292f45cf7162b99~VuCFg4hoQ2337423374eusmtrp1J;
	Tue,  4 Jun 2024 06:08:06 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-78-665eaf460f05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.A0.09010.64FAE566; Tue,  4
	Jun 2024 07:08:06 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240604060806eusmtip13627c1055fc783b6978f153609ec32c3~VuCFTUs_T2258622586eusmtip10;
	Tue,  4 Jun 2024 06:08:06 +0000 (GMT)
Received: from localhost (106.210.248.71) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 4 Jun 2024 07:08:05 +0100
Date: Mon, 3 Jun 2024 15:23:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] kernel/sysctl-test: add MODULE_DESCRIPTION()
Message-ID: <20240603132305.ji6mpwao6q4hnsfl@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240529-md-kernel-sysctl-test-v1-1-32597f712634@quicinc.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOV239XFpBrO2aFuc6c612HpL2mLP
	3pMsFpd3zWGzuDHhKaNF45a7rA5sHrMbLrJ4bFrVyeYxcU+dx+dNcgEsUVw2Kak5mWWpRfp2
	CVwZ267OZS64xlFx5fYZlgbGXvYuRk4OCQETiSvvVjF2MXJxCAmsYJTY1baeHcL5wijRtOsc
	VOYzo8Tsp2uZYVqmf/rCBJFYzijx7+9vhKobjxdCOZsZJSa+WAXWwiKgInF2UgMbiM0moCNx
	/s0dsLgIkN36dAsbSAMzSMO5H/vAioQFHCXu7J4HVsQr4CDRdmMTC4QtKHFy5hMwmxmoecHu
	T0D1HEC2tMTyfxwgYU4Bb4mZH/czQpyqJHHw4nsWCLtWYu2xM2DPSQic4ZA4d/whVMJFYvmX
	XjYIW1ji1fEt0KCRkTg9uYcFomEyo8T+fx+gulczSixr/MoEUWUt0XLlCTvIFRJAV+8/bA1h
	8knceCsIcSefxKRt05khwrwSHW1CEI1qEqvvvWGZwKg8C8lns5B8NgvhswWMzKsYxVNLi3PT
	U4uN81LL9YoTc4tL89L1kvNzNzEC08rpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIrx9ddFpQrwp
	iZVVqUX58UWlOanFhxilOViUxHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUyTVnqeKV7q1vDu
	/1r+bU8eHQptvrOh/dTcqa+D455oh706mPjTeNn5bX/45Iw13/578k3wlg2f+pr8g0t+8V5c
	uybMb/7E5yc+y+YtT71mPJdh2/4Ze20fCIou40i4paWl9fD6u2MFm6q7/U7dvRZ9IOHnscbt
	X08/nDFV9ofuP49jXpI9BfMFVh8PWb+2+x1fL1sBW2D/+wurhNjcJUz5Nh0P3LeY5cVdpayw
	iQfKt08tPXcgxOGz9JFn81oXPDt6e3HkToPfO544vbnT1SndahoiG9e1//wJf6+MAJ5Nvjd7
	v/1+698YxL5+rv6JB1Wbi6V+NZZmyJp8n1M5/6P83gSuF+oTRNTFfjHfKNiePFOJpTgj0VCL
	uag4EQDm2WNKmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7pu6+PSDD7eEbQ4051rsfWWtMWe
	vSdZLC7vmsNmcWPCU0aLxi13WR3YPGY3XGTx2LSqk81j4p46j8+b5AJYovRsivJLS1IVMvKL
	S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQytl2dy1xwjaPiyu0zLA2M
	vexdjJwcEgImEtM/fWHqYuTiEBJYyijx8tw1JoiEjMTGL1dZIWxhiT/Xutggij4ySpy8eA/K
	2cwosePzVmaQKhYBFYmzkxrYQGw2AR2J82/ugMVFgOzWp1vAGphBGs792AdWJCzgKHFn9zyw
	Il4BB4m2G5tYIKbOY5T4PmkRG0RCUOLkzCcsIDYz0KQFuz8BxTmAbGmJ5f84QMKcAt4SMz/u
	Z4Q4VUni4MX3LBB2rcSr+7sZJzAKz0IyaRaSSbMQJi1gZF7FKJJaWpybnltspFecmFtcmpeu
	l5yfu4kRGF3bjv3csoNx5auPeocYmTgYDzFKcDArifD21UWnCfGmJFZWpRblxxeV5qQWH2I0
	BYbFRGYp0eR8YHznlcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw
	LVCdF7MwIsLxY1Yo45HFWVtSmpeed+t/zHNrQ94h6YpDB+y6D/29duLvi2PmjJ2ynZVPyueJ
	m10JYmvyfPae+6XrLs12VS+pp7v/3mOo3HrXPGDbhkYLpQaxDyZ7mS9caFQ5776oxeEy2+28
	X/w84RnvzzOfmnNPrirTRfz85MunTVt/yShl/NbdnP7Wr66jWCNR6V16uO7Eww+EpcMe/16o
	fdCLw/hwWHNPaxDDwReq71dsVZPeP+vezXSnKwIzHx53TNKzvrFCd18Z35IdcpaF4VPk2ETk
	7Ivddh5SbfIPSrsl7M08Xbi5TsBcLrirSO3CeSGVrgzn6TIvVQ2XJd7yOmSaoT5/5yru+weU
	WIozEg21mIuKEwHXFM0GNwMAAA==
X-CMS-MailID: 20240604060806eucas1p22862dbc5e160cc485614c823ba1f77a3
X-Msg-Generator: CA
X-RootMTR: 20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23
References: <CGME20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23@eucas1p1.samsung.com>
	<20240529-md-kernel-sysctl-test-v1-1-32597f712634@quicinc.com>

On Wed, May 29, 2024 at 02:25:41PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/sysctl-test.o

I changed the message to this
"""
sysctl: Add module description to sysctl-testing

    Added a module description to sysctl Kunit self test module to fix the
    'make W=1' warning (" WARNING: modpost: missing MODULE_DESCRIPTION() in
    kernel/sysctl-test.o")
"""

> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  kernel/sysctl-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 6ef887c19c48..92f94ea28957 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -388,4 +388,5 @@ static struct kunit_suite sysctl_test_suite = {
>  
>  kunit_test_suites(&sysctl_test_suite);
>  
> +MODULE_DESCRIPTION("KUnit test of proc sysctl");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240529-md-kernel-sysctl-test-2bbad793ac62
> 

-- 

Joel Granados

