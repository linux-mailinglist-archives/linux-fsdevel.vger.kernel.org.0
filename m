Return-Path: <linux-fsdevel+bounces-25238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00494A263
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347F31F225FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F51C462C;
	Wed,  7 Aug 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m04rgmSG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0nh9lDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EF19A28F;
	Wed,  7 Aug 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018141; cv=fail; b=He31odyf+74Hhu1aybQ7kMDn9FGzi5WwuoijCS0E8Xyi9eAHrlsNYdDaFCcPXAn+L3gYr3Lv0T7WAtVuvBQs0jvaVFPOkD+W6YaCds1iueqkikkfEM6f12HUF3fnAVkTwSSPgWuAsK+YuEY4v5WG90GL9XlXS6uaK831NrlVmr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018141; c=relaxed/simple;
	bh=kFt7ypuqgiU4m2GPgVDJ5swfQoVjvngS7KtEiKKx3cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m7dXOKD/55qUj8DHz0+bIYALIy7mcL4+zEX8zWccGyCNqnrbEnfy6iRRtTxvz/HUWjzupFXMtgjdtl4A/7/NgMjvV1LYcxBTIHUL/13gDtMLsau4abAg5+2CJ1jRdfRXiTZd6OtcIifecuxhgxyzn2v5neZnKuc388srGno99ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m04rgmSG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0nh9lDk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4776BVk3029538;
	Wed, 7 Aug 2024 08:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7nyWzW+4z9l1HQj
	bmaXr/0Y5TDw37VO2AbwcF4SbwJ0=; b=m04rgmSGuZCBdh4FA1v0Dy2McCeYVqE
	JuXUZ1ziKA74WPYFBfnW11aGO63sl2U4lBIRBZiGpT+zGbddE5EpDyEoFuNdGJJ8
	XxhHC22pcGhzuaTD7K6wQTNNMl1g6az9OcH5JTEO5TvipMhHOG5rVbsBJLLM0Ck0
	r51C3yQ7JI29N6rSj+8Y+lcDI6Xg2XiKuxAt0V7d+LeTA6+C2YLxAjybLgCC3+Y5
	6jYbw7/kLMQsrOAhKatIYz1w6t2gOcHNWcODI5aqGqbOFXPwt2hp2qmLA1Di+nXX
	dgObg6SaN/+OPvf38WU3NKBGOCX496494wc48Tq+3gcBD6Y63mQXUxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51f1v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 08:08:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4776JKTO027396;
	Wed, 7 Aug 2024 08:08:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0g0aje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 08:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXaiCJEMh0k1eJ63WEO12fO4xUpYGyIDhEB+AjrkTDQwgwapeMXOv9qEkGccXOqymp9rBTsv7AHmhzHFAAqt/EKtniHOKYVwUe4Q3wRyp6hdGTspcCX6uD+lVm+E1mcDnk/qVK3zQFeKMaDJ5r1A9Lj/Qo+AuGJykIgcwMLdR78mgCe/cM2VWDquIJqop6gBwWhcmFTGWaHEygIydH/uqz8O+cTesIyMJZAN5N31m5RWprvYm028iPfll9RSUKzGWJzl8PbvCMp5v6mBB7eS8+6GteFdXPXDeGmbKT7xgy9yyhRJ5tYN0P02qWSZ2inGc1SNhVjnKEMJCMzN4o0n5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nyWzW+4z9l1HQjbmaXr/0Y5TDw37VO2AbwcF4SbwJ0=;
 b=oKg3ZZne15qsUpZo6oSgUyH4+C5tbr2IxqG9dJuEcLy4rg4uYvVRW0ZBbYCdtkpEgeSNchmu0L+NrOkT0oxRrDddgezA4DMuaDgVijkTrdf/2A9mFpz2HCBKDmmfbXFgcr+tejrP2dcqDgh5X0n5Vq2QaMHz05gPWxdgGqZzTzHbDNj0PAC00VfPyWy7zTxvhpyUg0P5f3rCJrLCr8y65aCENLzrJWys/G5Y3kpblyG03/JjZ96UvIGQV1TWnjHI7Jv3GPqY06zzs17h+Mws7e331CTHd7zlP9I/Lx/UDrCb1mVJZEZffqLT4o8fwPkzNHACnLNkR6J9GNSSgmFafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nyWzW+4z9l1HQjbmaXr/0Y5TDw37VO2AbwcF4SbwJ0=;
 b=j0nh9lDk9a88kytz8OMzvmd2gIt/kVOmKIVX8XG3quDCbshCMORpzOtjm0aj16wy9TaOkJ3ZjGWtAFZnuiqUHsVH/Rm+cAMRG6IuIQUxlj6TWcHCNLnhhCxZqqTg+f3+XLpED3C0WlzQXtklvo/e3HrdF6fuEK/3VqYZMvlCBxc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 08:07:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 08:07:54 +0000
Date: Wed, 7 Aug 2024 09:07:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <12f75bbf-aab1-4c2a-92ac-268da81250d6@lucifer.local>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
 <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 05297a7e-cec5-4a25-642c-08dcb6b80a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMaqbifZPRAnMmJLUlhN3xz0RoMHiTkVUD0tG/TJ8NYo7EX/1eNKXg0n7Wuk?=
 =?us-ascii?Q?5fM2sAQLgHYgT7OVhzjXG/xFrfet38k7y22PZpABadYW9hXfgG3CVXeDJipi?=
 =?us-ascii?Q?F1Jtoul7gs+J2g1brPmyojtqbih1eyfABS0WyYdT9YNI/dp87zRobfc8bGL4?=
 =?us-ascii?Q?TuQpc3KQin9NBlJTyRcQzsq2jRT3LA8JkdyfiFMTyNTBKJ7B+tCmOofys5HW?=
 =?us-ascii?Q?O3B0v1Hvq63vF8BsdQAajt0Ly0lauBgaAbSABXzDfAtwQOmwUB4ctr00HZCd?=
 =?us-ascii?Q?8HSov0ljxmQOHCuTNg/5T3BgLe4TpcBGoi2qJPOFLYcl4XC8jQXQ7I5dE4d1?=
 =?us-ascii?Q?KMeJqw8nXwz24GVAIdXrKvxkK+72hULXvcQtV5rfq72Hkptx9P/ixTI/yc9c?=
 =?us-ascii?Q?ZIREaEqdWd0XDVec+wTvgGzEr1uwScOeYFynr5Dq0/QjekZpDtcJr4I4azqL?=
 =?us-ascii?Q?9VWCmQoOHSJBQ2ubhmO2Ykc/M8TL0MfeTg0u9FNIXcJc9V8zI8rJQQ7fyFFn?=
 =?us-ascii?Q?wcgs6y13dLEYIDXMngXL1nr1eY0FhTWqnpBAhqIwin0jT7aCrJ2IWzIAON4K?=
 =?us-ascii?Q?86NkH788HqNJ6SeLKU1Uzm9ugvOw99gTPYvCvzgA+/5N1KXRPzjIMMlMSo20?=
 =?us-ascii?Q?6OE7VpxG1kZ5RS0gXnBq+j4F4BD8OIYe+iWwtvJMKGA2DKfgpthdlsP8B9Vi?=
 =?us-ascii?Q?Tj2NnxJCvpeKKcqLTuO+kbwvsKZLvjjdaUgPIcEJF3PzHftYR0k0Y2Lt2QYN?=
 =?us-ascii?Q?OtbHW9PK+ZBohBhd5KXxWK6sx3wEV43F8Jke0/UEGQrcQkKV/6iVq7wAL7g2?=
 =?us-ascii?Q?p9ycideAqDUd/KINBqs0VK148uMbclHb+lT58WzR33Qga0RKGHHqiAk3Pst0?=
 =?us-ascii?Q?cBU4KqERa1RQ0uiMW8WX2dc2x5opwIkzAiTCGw7WzQefasT0aedmKOQj5NaQ?=
 =?us-ascii?Q?8jYjW8N+r3Ba2h/+8vuNZCMfeCjBIr/OYuPOS9K2/ETMhhS8IMCm4w23VD+y?=
 =?us-ascii?Q?WM3/pZAoS2Woe0UfHCDO3XiVKMfrFFPVs46VL2RkwhGvB/9VGB+hfr+h01Io?=
 =?us-ascii?Q?/5Ov0W2gMZHWiwdgKTAz2TR9dyp/ZPxxD2+Tx61Bxk2GquzUgH5d7S/cE6zG?=
 =?us-ascii?Q?jN7HcQvmF8i3Sw4Wsom/LWQGCz5vVhqTYis2QDXSgT0iNnum+Ieyo6+HadH9?=
 =?us-ascii?Q?y00EiupMF8nl/ZVghetCYzlYD7cJdZVYnZDtwFIXG+VKn/e8+MH2Oz4QZ0Si?=
 =?us-ascii?Q?tmM7NcMibePSbVle63eg136BjDjBcRPUdgk4X6z0tG+hU+53xtMX/i5uDqq0?=
 =?us-ascii?Q?4s4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TrimupYiCPN/ZZRL6KCJqfcZaGVr43K6AqFmow4Fdw89Ss/JWVWdmiBgKi12?=
 =?us-ascii?Q?S1bX0hPQZGWS2UwhKjeXFI0F5YM1Nep25iY23XPcszSZFI3DhRBEymCNzZ11?=
 =?us-ascii?Q?FMVQpxw+StBAhbN1eQqYs91aTckO29JINM4efF733B5MTfFwRrYrTkIFPO3G?=
 =?us-ascii?Q?4i5kmkau07V6Su4Z5itA1dw13DlEPIhQ0fs4OKPnm/u5Mna3n9YQ1UuG5lWk?=
 =?us-ascii?Q?3zRg4ULxBKpQZ5iDM+7ly0mdZdOEUWeNOv1H55O78iae2HRF1cNIhsNUd4Wn?=
 =?us-ascii?Q?+2eLKzmcWeBEQXXf2oTuvy1bSyout9V8yRG0E70e/l0L3rFagImlclQr3WH7?=
 =?us-ascii?Q?tc7r1ejv3mwh1Bitz6IRK1i+4+Ioy8wR7GQpnzPoVpCvtaHYMLnAJWSVrNKp?=
 =?us-ascii?Q?lnYVj68zXAouU5Q9mx7/mEkFwR4RoyzThit4LzHnGz0/pYAVuDC/zk0O9CD9?=
 =?us-ascii?Q?QONcxqrL9sP4h99Sv+vsmwjBfkJOFYkSV3jXLHF2TgTWFk2qw/v6UapI1oOW?=
 =?us-ascii?Q?tYPaPmO2LTSeM5zFT5uhdkTQ7Gz3CGiCxHPAbk3kY5KPfro2GEHeYvTNmIT4?=
 =?us-ascii?Q?imywOthtEXY6hWk67b4R7x+9cLiMsTM2F+L0ZWycbSj6oSxv43vOZp3DhSAv?=
 =?us-ascii?Q?3STxilpaSfFVXPWMjCPFrxu9sEXn6EWxW9JXLotTT/1NgXWIZ2pTHeRMyFTC?=
 =?us-ascii?Q?sxwNBLS6F4USfoRsOCd5XA4IMDxaCk+1kfs7Mc6Jqd39O80wck/2IzHmeyw7?=
 =?us-ascii?Q?48++vQqmFG5g33t8geZGGm9udDprYLM0W1uRk/AmmTXS+5zkpbijfI8gG1eI?=
 =?us-ascii?Q?BOxyOWyDQcodbcPUo4AX6gUOAi3iGKfENLcTAoLUtOsqvkLNLDXEs2w26RA2?=
 =?us-ascii?Q?Q17WTs0QgTbqVj2nN0iw1Cy3dIipYN+Pp+tEuuKdmJcyhBsAjcceAbnK/haG?=
 =?us-ascii?Q?En2ExXQH7atu9JxPXoUeVM9cp+l6hYiim1oHGCtzskNQDT0TXMIDER+pqSw7?=
 =?us-ascii?Q?+/6GG6zAJEvHxO6uqO5tESTehyVzJTh3k+BqZ0dseo6B32JG1kw2G8Atxhlv?=
 =?us-ascii?Q?sbg7DjVgSbq5264JxmpOIByqAoF5E5pyF5PLX0VtlOrc2LyHP4KJEghO4Cfv?=
 =?us-ascii?Q?68ZVaBBKYfxh62IhGwncB5DuC999kUTT8OjicZvDQQKaYpNlaVR4oCWBc090?=
 =?us-ascii?Q?ZE4RA0Q3nhjeNjI92+DMPAoPH9PAUIcLNoaxPm7XTZyrYfwVI61BeYwfXT6+?=
 =?us-ascii?Q?IUFWu5A+GrhLTwoLKc7+uByHzVhIOUq3GWEyK/9EueWfAvCYmV047TL72uVo?=
 =?us-ascii?Q?Sog6pzmxtuC6jGG+Me71wvPOcqKs0obuXQ1uTajKGiskAZNDyL33/dG+qm/h?=
 =?us-ascii?Q?972FgrGi5D3teRPiTRYv7U8j7z4N692UOg+IRNHDnOqSstDuJ72oSS5C4Vu7?=
 =?us-ascii?Q?0B/kan2thr9NWqNatDQC1+wWv4kAdGeOp3juVYWR/1S/2q5TQcbKS/qTSwds?=
 =?us-ascii?Q?+P+9rpF/wncBfe+zOmzwmodgcgFjopfXGDoioPqHDJA0epXMAxT5Y2VVgXTK?=
 =?us-ascii?Q?poGofyFmryC/Zjqw2CU3onpnSrY8pyoEnCDmF4I0KxGQr0WN5rqPfYxm8oV3?=
 =?us-ascii?Q?ICJCXffxtPUCmspLP3dqmj8YLUh7SmsQ3o4obm2azjzZWBAM8rT2dLaAebMS?=
 =?us-ascii?Q?eQbkQQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fu/YaZCMdyMZCvxlWaqkz8yT/7TdgEA2h1fv/dDUM8Eu2WqEdJcVxgJZQJJpW+q48eI7DtVXB316JFGBANxhdr5EgQIxT0/5FNXaW5COZvlijkucfRHjVtLKa4leN/hzZjaDsntFs0LB2GY9DGFHUdZYIbPRldUJ5fYKKhUOa63WLpCME8Oa009MFjf07wG/LaVBxauNxbKph7VUh+NUmTXE9zI2ndqq2PiZ5GYP5bnDmTbPXSZ4uIcLxmB/yOp1sGqjftL6Gw6iZiSeOTLQdnvJlld6Y6Ooet2N6cxTDSuGuIEZvdb+JRh2sdrya4Gp4kU1CrMmfKYWk2pUYsgfy1/OL730g3Y0SgUAhibmO9ehYf1w/2h3z8T+8Bqkxv5II8YQYijSA0ylITpnQTeDNwdifUKuL7c6T4GdOMeIyRMJ/mCIJp+7AEyP/YK7us3Mca0YuBj1U9xbDXlVEaRE6Lhb0NILsATN03ul/yIvc5UFsWm0fx3YjAT96ladSKe9SldWrUv0gFtkXxQsBY3FtC2IL69exFfSlisVSYNJPq7tg/TSll/YbpsT2+h6OlY0xL3ilbYzk8pqnFhMgw4RconeyxlNLvjcb2Iuq1CFJrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05297a7e-cec5-4a25-642c-08dcb6b80a36
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 08:07:54.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0ogXKhiOIfsRtyaFPxXlbLq2zl7R8UhZQshI9g6lDkJ1vY6Db0zzhhTlLNEk1wN4xromQy0OWHECcTmKI/caaDRJg4gsSyTBdu9gzypjfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_05,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070055
X-Proofpoint-ORIG-GUID: rLmS5iFNZAn7EeJG3_faYsvpfLWIkMch
X-Proofpoint-GUID: rLmS5iFNZAn7EeJG3_faYsvpfLWIkMch

On Wed, Aug 07, 2024 at 11:45:56AM GMT, Pengfei Xu wrote:
> Hi Lorenzo Stoakes,
>
> Greetings!
>
> I used syzkaller and found
> KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.
>
> Bisected the first bad commit:
> 4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c

Hi,

Thanks for this, I will investigate as a priority and work up a fix. As it's
simply a refactor I suspect this should be relatively straightforward.

>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ctx
> Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.c
> Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.prog
> Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/repro.report
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/bisect_info.log
> Dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240806_122723_userfaultfd_set_ctx/d6dbc9f56c3a70e915625b6f1887882c23dc5c91_dmesg.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240806_122723_userfaultfd_set_ctx/bzImage_d6dbc9f56c3a70e915625b6f1887882c23dc5c91.tar.gz
>
> "
> [   29.675551] ==================================================================
> [   29.676133] BUG: KASAN: slab-use-after-free in userfaultfd_set_ctx+0x31c/0x360
> [   29.676716] Read of size 8 at addr ffff888027c5f100 by task repro/1498
> [   29.677218]
> [   29.677358] CPU: 0 UID: 0 PID: 1498 Comm: repro Not tainted 6.11.0-rc2-next-20240805-d6dbc9f56c3a #1
> [   29.678053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   29.678910] Call Trace:
> [   29.679117]  <TASK>
> [   29.679296]  dump_stack_lvl+0xea/0x150
> [   29.679622]  print_report+0xce/0x610
> [   29.679924]  ? userfaultfd_set_ctx+0x31c/0x360
> [   29.680289]  ? kasan_complete_mode_report_info+0x80/0x200
> [   29.680716]  ? userfaultfd_set_ctx+0x31c/0x360
> [   29.681077]  kasan_report+0xcc/0x110
> [   29.681372]  ? userfaultfd_set_ctx+0x31c/0x360
> [   29.681729]  __asan_report_load8_noabort+0x18/0x20
> [   29.682118]  userfaultfd_set_ctx+0x31c/0x360
> [   29.682465]  userfaultfd_clear_vma+0x104/0x190
> [   29.682826]  userfaultfd_release_all+0x294/0x4a0
> [   29.683201]  ? __pfx_userfaultfd_release_all+0x10/0x10
> [   29.683615]  ? __this_cpu_preempt_check+0x21/0x30
> [   29.684003]  ? __pfx_userfaultfd_release+0x10/0x10
> [   29.684389]  userfaultfd_release+0x112/0x1e0
> [   29.684735]  ? __pfx_userfaultfd_release+0x10/0x10
> [   29.685114]  ? evm_file_release+0x193/0x1f0
> [   29.685454]  __fput+0x426/0xbc0
> [   29.685719]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
> [   29.686153]  __fput_sync+0x58/0x70
> [   29.686435]  __x64_sys_close+0x93/0x120
> [   29.686744]  x64_sys_call+0x189a/0x20d0
> [   29.687066]  do_syscall_64+0x6d/0x140
> [   29.687371]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   29.687779] RIP: 0033:0x7f3b67b3f247
> [   29.688078] Code: ff e8 cd e3 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 c9 f5 ff
> [   29.689519] RSP: 002b:00007ffd1f0ac7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [   29.690140] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3b67b3f247
> [   29.690717] RDX: 0000000020000100 RSI: 000000008010aa01 RDI: 0000000000000003
> [   29.691270] RBP: 00007ffd1f0ac7f0 R08: 00007ffd1f0ac7f0 R09: 00007ffd1f0ac7f0
> [   29.691822] R10: 00007ffd1f0ac7f0 R11: 0000000000000246 R12: 00007ffd1f0ac968
> [   29.692375] R13: 0000000000401bf9 R14: 0000000000403e08 R15: 00007f3b67c72000
> [   29.692939]  </TASK>
> [   29.693124]
> [   29.693258] Allocated by task 1498:
> [   29.693545]  kasan_save_stack+0x2c/0x60
> [   29.693875]  kasan_save_track+0x18/0x40
> [   29.694205]  kasan_save_alloc_info+0x3c/0x50
> [   29.694576]  __kasan_slab_alloc+0x62/0x80
> [   29.694921]  kmem_cache_alloc_noprof+0x114/0x370
> [   29.695319]  vm_area_dup+0x2a/0x1b0
> [   29.695630]  __split_vma+0x188/0x1020
> [   29.695952]  vma_modify+0x1fc/0x390
> [   29.696250]  userfaultfd_clear_vma+0xd4/0x190
> [   29.696609]  userfaultfd_ioctl+0x3c0b/0x4560
> [   29.696964]  __x64_sys_ioctl+0x1b9/0x230
> [   29.697295]  x64_sys_call+0x1209/0x20d0
> [   29.697620]  do_syscall_64+0x6d/0x140
> [   29.697937]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   29.698364]
> [   29.698508] Freed by task 1505:
> [   29.698779]  kasan_save_stack+0x2c/0x60
> [   29.699110]  kasan_save_track+0x18/0x40
> [   29.699441]  kasan_save_free_info+0x3f/0x60
> [   29.699797]  __kasan_slab_free+0x47/0x60
> [   29.700137]  kmem_cache_free+0x2f2/0x4b0
> [   29.700471]  vm_area_free_rcu_cb+0x7f/0xa0
> [   29.700819]  rcu_core+0x877/0x18f0
> [   29.701123]  rcu_core_si+0x12/0x20
> [   29.701421]  handle_softirqs+0x1c7/0x870
> [   29.701760]  __irq_exit_rcu+0xa9/0x120
> [   29.702082]  irq_exit_rcu+0x12/0x30
> [   29.702386]  sysvec_apic_timer_interrupt+0xa5/0xc0
> [   29.702802]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [   29.703237]
> [   29.703377] Last potentially related work creation:
> [   29.703782]  kasan_save_stack+0x2c/0x60
> [   29.704114]  __kasan_record_aux_stack+0x93/0xb0
> [   29.704503]  kasan_record_aux_stack_noalloc+0xf/0x20
> [   29.704923]  __call_rcu_common.constprop.0+0x72/0x6b0
> [   29.705349]  call_rcu+0x12/0x20
> [   29.705625]  vm_area_free+0x26/0x30
> [   29.705928]  vma_complete+0x57e/0xf60
> [   29.706245]  vma_merge+0x166b/0x3540
> [   29.706555]  vma_modify+0x9f/0x390
> [   29.706853]  userfaultfd_clear_vma+0xd4/0x190
> [   29.707227]  userfaultfd_release_all+0x294/0x4a0
> [   29.707621]  userfaultfd_release+0x112/0x1e0
> [   29.707991]  __fput+0x426/0xbc0
> [   29.708267]  __fput_sync+0x58/0x70
> [   29.708563]  __x64_sys_close+0x93/0x120
> [   29.708891]  x64_sys_call+0x189a/0x20d0
> [   29.709220]  do_syscall_64+0x6d/0x140
> [   29.709538]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   29.709965]
> [   29.710105] The buggy address belongs to the object at ffff888027c5f0f0
> [   29.710105]  which belongs to the cache vm_area_struct of size 176
> [   29.711130] The buggy address is located 16 bytes inside of
> [   29.711130]  freed 176-byte region [ffff888027c5f0f0, ffff888027c5f1a0)
> [   29.712104]
> [   29.712245] The buggy address belongs to the physical page:
> [   29.712703] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27c5f
> [   29.713349] memcg:ffff8880198eaa01
> [   29.713639] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   29.714173] page_type: 0xfdffffff(slab)
> [   29.714507] raw: 000fffffc0000000 ffff88800d319dc0 dead000000000122 0000000000000000
> [   29.715137] raw: 0000000000000000 0000000000110011 00000001fdffffff ffff8880198eaa01
> [   29.715765] page dumped because: kasan: bad access detected
> [   29.716220]
> [   29.716360] Memory state around the buggy address:
> [   29.716756]  ffff888027c5f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   29.717349]  ffff888027c5f080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa fb
> [   29.717940] >ffff888027c5f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   29.718521]                    ^
> [   29.718796]  ffff888027c5f180: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
> [   29.719388]  ffff888027c5f200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   29.720025] ==================================================================
> [   29.720671] Disabling lock debugging due to kernel taint
> "
>
> Thanks!
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!
>
>
> On 2024-07-29 at 12:50:35 +0100, Lorenzo Stoakes wrote:
> > This patch forms part of a patch series intending to separate out VMA logic
> > and render it testable from userspace, which requires that core
> > manipulation functions be exposed in an mm/-internal header file.
> >
> > In order to do this, we must abstract APIs we wish to test, in this
> > instance functions which ultimately invoke vma_modify().
> >
> > This patch therefore moves all logic which ultimately invokes vma_modify()
> > to mm/userfaultfd.c, trying to transfer code at a functional granularity
> > where possible.
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/userfaultfd.c              | 160 +++-----------------------------
> >  include/linux/userfaultfd_k.h |  19 ++++
> >  mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 198 insertions(+), 149 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 27a3e9285fbf..b3ed7207df7e 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
> >  	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
> >  }
> >
> > -static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> > -				     vm_flags_t flags)
> > -{
> > -	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> > -
> > -	vm_flags_reset(vma, flags);
> > -	/*
> > -	 * For shared mappings, we want to enable writenotify while
> > -	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> > -	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
> > -	 */
> > -	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
> > -		vma_set_page_prot(vma);
> > -}
> > -
> >  static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
> >  				     int wake_flags, void *key)
> >  {
> > @@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
> >  	spin_unlock_irq(&ctx->event_wqh.lock);
> >
> >  	if (release_new_ctx) {
> > -		struct vm_area_struct *vma;
> > -		struct mm_struct *mm = release_new_ctx->mm;
> > -		VMA_ITERATOR(vmi, mm, 0);
> > -
> > -		/* the various vma->vm_userfaultfd_ctx still points to it */
> > -		mmap_write_lock(mm);
> > -		for_each_vma(vmi, vma) {
> > -			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
> > -				vma_start_write(vma);
> > -				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -				userfaultfd_set_vm_flags(vma,
> > -							 vma->vm_flags & ~__VM_UFFD_FLAGS);
> > -			}
> > -		}
> > -		mmap_write_unlock(mm);
> > -
> > +		userfaultfd_release_new(release_new_ctx);
> >  		userfaultfd_ctx_put(release_new_ctx);
> >  	}
> >
> > @@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
> >  		return 0;
> >
> >  	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> > -		vma_start_write(vma);
> > -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
> > +		userfaultfd_reset_ctx(vma);
> >  		return 0;
> >  	}
> >
> > @@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
> >  		up_write(&ctx->map_changing_lock);
> >  	} else {
> >  		/* Drop uffd context if remap feature not enabled */
> > -		vma_start_write(vma);
> > -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
> > +		userfaultfd_reset_ctx(vma);
> >  	}
> >  }
> >
> > @@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
> >  {
> >  	struct userfaultfd_ctx *ctx = file->private_data;
> >  	struct mm_struct *mm = ctx->mm;
> > -	struct vm_area_struct *vma, *prev;
> >  	/* len == 0 means wake all */
> >  	struct userfaultfd_wake_range range = { .len = 0, };
> > -	unsigned long new_flags;
> > -	VMA_ITERATOR(vmi, mm, 0);
> >
> >  	WRITE_ONCE(ctx->released, true);
> >
> > -	if (!mmget_not_zero(mm))
> > -		goto wakeup;
> > -
> > -	/*
> > -	 * Flush page faults out of all CPUs. NOTE: all page faults
> > -	 * must be retried without returning VM_FAULT_SIGBUS if
> > -	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
> > -	 * changes while handle_userfault released the mmap_lock. So
> > -	 * it's critical that released is set to true (above), before
> > -	 * taking the mmap_lock for writing.
> > -	 */
> > -	mmap_write_lock(mm);
> > -	prev = NULL;
> > -	for_each_vma(vmi, vma) {
> > -		cond_resched();
> > -		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> > -		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> > -		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> > -			prev = vma;
> > -			continue;
> > -		}
> > -		/* Reset ptes for the whole vma range if wr-protected */
> > -		if (userfaultfd_wp(vma))
> > -			uffd_wp_range(vma, vma->vm_start,
> > -				      vma->vm_end - vma->vm_start, false);
> > -		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > -		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
> > -					    vma->vm_end, new_flags,
> > -					    NULL_VM_UFFD_CTX);
> > -
> > -		vma_start_write(vma);
> > -		userfaultfd_set_vm_flags(vma, new_flags);
> > -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > +	userfaultfd_release_all(mm, ctx);
> >
> > -		prev = vma;
> > -	}
> > -	mmap_write_unlock(mm);
> > -	mmput(mm);
> > -wakeup:
> >  	/*
> >  	 * After no new page faults can wait on this fault_*wqh, flush
> >  	 * the last page faults that may have been already waiting on
> > @@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  				unsigned long arg)
> >  {
> >  	struct mm_struct *mm = ctx->mm;
> > -	struct vm_area_struct *vma, *prev, *cur;
> > +	struct vm_area_struct *vma, *cur;
> >  	int ret;
> >  	struct uffdio_register uffdio_register;
> >  	struct uffdio_register __user *user_uffdio_register;
> > -	unsigned long vm_flags, new_flags;
> > +	unsigned long vm_flags;
> >  	bool found;
> >  	bool basic_ioctls;
> > -	unsigned long start, end, vma_end;
> > +	unsigned long start, end;
> >  	struct vma_iterator vmi;
> >  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> >
> > @@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  	} for_each_vma_range(vmi, cur, end);
> >  	BUG_ON(!found);
> >
> > -	vma_iter_set(&vmi, start);
> > -	prev = vma_prev(&vmi);
> > -	if (vma->vm_start < start)
> > -		prev = vma;
> > -
> > -	ret = 0;
> > -	for_each_vma_range(vmi, vma, end) {
> > -		cond_resched();
> > -
> > -		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
> > -		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > -		       vma->vm_userfaultfd_ctx.ctx != ctx);
> > -		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > -
> > -		/*
> > -		 * Nothing to do: this vma is already registered into this
> > -		 * userfaultfd and with the right tracking mode too.
> > -		 */
> > -		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> > -		    (vma->vm_flags & vm_flags) == vm_flags)
> > -			goto skip;
> > -
> > -		if (vma->vm_start > start)
> > -			start = vma->vm_start;
> > -		vma_end = min(end, vma->vm_end);
> > -
> > -		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > -		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> > -					    new_flags,
> > -					    (struct vm_userfaultfd_ctx){ctx});
> > -		if (IS_ERR(vma)) {
> > -			ret = PTR_ERR(vma);
> > -			break;
> > -		}
> > -
> > -		/*
> > -		 * In the vma_merge() successful mprotect-like case 8:
> > -		 * the next vma was merged into the current one and
> > -		 * the current one has not been updated yet.
> > -		 */
> > -		vma_start_write(vma);
> > -		userfaultfd_set_vm_flags(vma, new_flags);
> > -		vma->vm_userfaultfd_ctx.ctx = ctx;
> > -
> > -		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > -			hugetlb_unshare_all_pmds(vma);
> > -
> > -	skip:
> > -		prev = vma;
> > -		start = vma->vm_end;
> > -	}
> > +	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
> > +					 wp_async);
> >
> >  out_unlock:
> >  	mmap_write_unlock(mm);
> > @@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	struct vm_area_struct *vma, *prev, *cur;
> >  	int ret;
> >  	struct uffdio_range uffdio_unregister;
> > -	unsigned long new_flags;
> >  	bool found;
> >  	unsigned long start, end, vma_end;
> >  	const void __user *buf = (void __user *)arg;
> > @@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
> >  		}
> >
> > -		/* Reset ptes for the whole vma range if wr-protected */
> > -		if (userfaultfd_wp(vma))
> > -			uffd_wp_range(vma, start, vma_end - start, false);
> > -
> > -		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> > -		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> > -					    new_flags, NULL_VM_UFFD_CTX);
> > +		vma = userfaultfd_clear_vma(&vmi, prev, vma,
> > +					    start, vma_end);
> >  		if (IS_ERR(vma)) {
> >  			ret = PTR_ERR(vma);
> >  			break;
> >  		}
> >
> > -		/*
> > -		 * In the vma_merge() successful mprotect-like case 8:
> > -		 * the next vma was merged into the current one and
> > -		 * the current one has not been updated yet.
> > -		 */
> > -		vma_start_write(vma);
> > -		userfaultfd_set_vm_flags(vma, new_flags);
> > -		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
> > -
> >  	skip:
> >  		prev = vma;
> >  		start = vma->vm_end;
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index a12bcf042551..9fc6ce15c499 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -267,6 +267,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
> >  extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
> >  extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
> >
> > +void userfaultfd_reset_ctx(struct vm_area_struct *vma);
> > +
> > +struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> > +					     struct vm_area_struct *prev,
> > +					     struct vm_area_struct *vma,
> > +					     unsigned long start,
> > +					     unsigned long end);
> > +
> > +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> > +			       struct vm_area_struct *vma,
> > +			       unsigned long vm_flags,
> > +			       unsigned long start, unsigned long end,
> > +			       bool wp_async);
> > +
> > +void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
> > +
> > +void userfaultfd_release_all(struct mm_struct *mm,
> > +			     struct userfaultfd_ctx *ctx);
> > +
> >  #else /* CONFIG_USERFAULTFD */
> >
> >  /* mm helpers */
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e54e5c8907fa..3b7715ecf292 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> >  	VM_WARN_ON(!moved && !err);
> >  	return moved ? moved : err;
> >  }
> > +
> > +static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
> > +				     vm_flags_t flags)
> > +{
> > +	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
> > +
> > +	vm_flags_reset(vma, flags);
> > +	/*
> > +	 * For shared mappings, we want to enable writenotify while
> > +	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> > +	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
> > +	 */
> > +	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
> > +		vma_set_page_prot(vma);
> > +}
> > +
> > +static void userfaultfd_set_ctx(struct vm_area_struct *vma,
> > +				struct userfaultfd_ctx *ctx,
> > +				unsigned long flags)
> > +{
> > +	vma_start_write(vma);
> > +	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
> > +	userfaultfd_set_vm_flags(vma,
> > +				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
> > +}
> > +
> > +void userfaultfd_reset_ctx(struct vm_area_struct *vma)
> > +{
> > +	userfaultfd_set_ctx(vma, NULL, 0);
> > +}
> > +
> > +struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
> > +					     struct vm_area_struct *prev,
> > +					     struct vm_area_struct *vma,
> > +					     unsigned long start,
> > +					     unsigned long end)
> > +{
> > +	struct vm_area_struct *ret;
> > +
> > +	/* Reset ptes for the whole vma range if wr-protected */
> > +	if (userfaultfd_wp(vma))
> > +		uffd_wp_range(vma, start, end - start, false);
> > +
> > +	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
> > +				    vma->vm_flags & ~__VM_UFFD_FLAGS,
> > +				    NULL_VM_UFFD_CTX);
> > +
> > +	/*
> > +	 * In the vma_merge() successful mprotect-like case 8:
> > +	 * the next vma was merged into the current one and
> > +	 * the current one has not been updated yet.
> > +	 */
> > +	if (!IS_ERR(ret))
> > +		userfaultfd_reset_ctx(vma);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Assumes mmap write lock taken, and mm_struct pinned. */
> > +int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> > +			       struct vm_area_struct *vma,
> > +			       unsigned long vm_flags,
> > +			       unsigned long start, unsigned long end,
> > +			       bool wp_async)
> > +{
> > +	VMA_ITERATOR(vmi, ctx->mm, start);
> > +	struct vm_area_struct *prev = vma_prev(&vmi);
> > +	unsigned long vma_end;
> > +	unsigned long new_flags;
> > +
> > +	if (vma->vm_start < start)
> > +		prev = vma;
> > +
> > +	for_each_vma_range(vmi, vma, end) {
> > +		cond_resched();
> > +
> > +		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
> > +		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > +		       vma->vm_userfaultfd_ctx.ctx != ctx);
> > +		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
> > +
> > +		/*
> > +		 * Nothing to do: this vma is already registered into this
> > +		 * userfaultfd and with the right tracking mode too.
> > +		 */
> > +		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> > +		    (vma->vm_flags & vm_flags) == vm_flags)
> > +			goto skip;
> > +
> > +		if (vma->vm_start > start)
> > +			start = vma->vm_start;
> > +		vma_end = min(end, vma->vm_end);
> > +
> > +		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> > +		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> > +					    new_flags,
> > +					    (struct vm_userfaultfd_ctx){ctx});
> > +		if (IS_ERR(vma))
> > +			return PTR_ERR(vma);
> > +
> > +		/*
> > +		 * In the vma_merge() successful mprotect-like case 8:
> > +		 * the next vma was merged into the current one and
> > +		 * the current one has not been updated yet.
> > +		 */
> > +		userfaultfd_set_ctx(vma, ctx, vm_flags);
> > +
> > +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > +			hugetlb_unshare_all_pmds(vma);
> > +
> > +skip:
> > +		prev = vma;
> > +		start = vma->vm_end;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
> > +{
> > +	struct mm_struct *mm = ctx->mm;
> > +	struct vm_area_struct *vma;
> > +	VMA_ITERATOR(vmi, mm, 0);
> > +
> > +	/* the various vma->vm_userfaultfd_ctx still points to it */
> > +	mmap_write_lock(mm);
> > +	for_each_vma(vmi, vma) {
> > +		if (vma->vm_userfaultfd_ctx.ctx == ctx)
> > +			userfaultfd_reset_ctx(vma);
> > +	}
> > +	mmap_write_unlock(mm);
> > +}
> > +
> > +void userfaultfd_release_all(struct mm_struct *mm,
> > +			     struct userfaultfd_ctx *ctx)
> > +{
> > +	struct vm_area_struct *vma, *prev;
> > +	VMA_ITERATOR(vmi, mm, 0);
> > +
> > +	if (!mmget_not_zero(mm))
> > +		return;
> > +
> > +	/*
> > +	 * Flush page faults out of all CPUs. NOTE: all page faults
> > +	 * must be retried without returning VM_FAULT_SIGBUS if
> > +	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
> > +	 * changes while handle_userfault released the mmap_lock. So
> > +	 * it's critical that released is set to true (above), before
> > +	 * taking the mmap_lock for writing.
> > +	 */
> > +	mmap_write_lock(mm);
> > +	prev = NULL;
> > +	for_each_vma(vmi, vma) {
> > +		cond_resched();
> > +		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> > +		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
> > +		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> > +			prev = vma;
> > +			continue;
> > +		}
> > +
> > +		vma = userfaultfd_clear_vma(&vmi, prev, vma,
> > +					    vma->vm_start, vma->vm_end);
> > +		prev = vma;
> > +	}
> > +	mmap_write_unlock(mm);
> > +	mmput(mm);
> > +}
> > --
> > 2.45.2
> >

