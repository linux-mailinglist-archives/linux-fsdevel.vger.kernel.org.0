Return-Path: <linux-fsdevel+bounces-48197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D1AAABE83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5C21C26B12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91827A922;
	Tue,  6 May 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8YtGnsq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDz+FQ1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57ED2798E9;
	Tue,  6 May 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522344; cv=fail; b=ubcEHBnAR7J1aOL1Hjz6D063ijM4OSqu8Ao328ohvbyIulack7GI+voLCdHyPid3fB9R+oBtXcjBnd6qZUtE1YtwSwPdZTmO0SZ6q3scrWDGbvVevxNIevEF8iDT8wgqti3cp/xTbGzdgM8of4NkJ3U7+GQJP4AlIBXuYkc+KCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522344; c=relaxed/simple;
	bh=bao8ro5jB2y+yAP3hljkJAZmi18dQqmKw3XotU1xy8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bpNomVGdXZWX1XnZWWvm3NisfqAdJJH07iETgc2JgM9hWH5Ogm+60UbkEM8l7kqhpOH2m95RyqLIcFvXbW1d0pSPv7H3G/4WgYaw+ekZAUX4Bt44JwyaOalQrIRDFFTcUm5MgI9StmO37s+YiDy4ZehW+s9dO8FZiBiwom9yVfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C8YtGnsq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDz+FQ1s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468vf2I023352;
	Tue, 6 May 2025 09:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=; b=
	C8YtGnsquMfG9EMa2sz1AFfcdViD7vVtfPy++q7+/Gp3rzjufbwddTNFcnqxuFcb
	lpTkDh6BB2fsqMP7ujh+ow0bBho2DtLHC9yZAtAiHRoPCzdyGeSKGuaEHf/GMB8f
	I0MUdn3bsZzjM0mepigLjFQkra8gLIhW64/qahhls/F941dZax+vb4zQn1WlTP6y
	mpHG2LgVJ+F/4uEU38K/jbVLq5qa2My9Ga7aN4t+6jgABXzuThze9fDiupmTQVfj
	MKea8D9wDmFmzk9USbNUcWiqdMgYrdRCH6CEcDADp9a4B1woOJ6sOP7YK8Lw76Iv
	zgOiYdrQc8jK1kT+bZzqgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffc680f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467a1Sb025130;
	Tue, 6 May 2025 09:05:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf066e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOUuBFwqdxJhHBgyrERPA/t+INXl1xwfCe44Ln6j+8bKsa1DZDLeYkMzTwtVoLXsrK8jbQNIrMOnDW3rq3FoB6qRKigUFiKtQvOg7g2WG6LhVo0b/6GoKsBE87xjjk4BKi5mwUjj/92sP6uhWmAArvpGKUexKf45ACve/+JIpOHza55Bg47H+jumibXeBphcBW7TPbbfN5ARNrsQOFf7UUPxv11hLlYXhl8jSwCQmZ/foDHBAuOG4dXaJ/s1DgpMAre1IPf1ZCz1YtrS7jgHxnAsRzU8v8aaDPWcvNS/hTqPEOnNgQLK31o2QVzvo+9BJKr22k6LWrdGrdaiZSOSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=YjtX8GMOZwxQkueW65zqCyjNb9WrN7Mwc1p/xLecvMVsbZVuKC3cFQM8ZMTCp7m4Pmbkx/oJRsuo7UTElkxJzzcYPQxQWmEyrCgnlFC1hp8QmrB1pn2sATlAm5SfrcEKhibnk10o3ZO45gPpn+YQJrPkbZwcJe0qOU8C5UnrQ4zAICo0LwXYqwNuAztgHbntx/t3nrtmImdEoJ0JSBYIBS3cHf7Hx6g3bQ6BO8gj5SfGW+WTlZAm802IJ/2vWJSYSRIafA/NMOFGwbhw9htF7ZVYtTUB8sAVK/rCMUbXqNTV9hNXVTdwAlr204r3Zca0DIKJb2/GITuUt8UEP9RccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=kDz+FQ1s3bCvB5TvGYReyygHl0RPj7zh0tNprEvMJ3K5JYfvjeAZY/kCnBsyiTqRTR1u5qpeaUxaHLs0jfnGk/He1yIadI39ezaxgWuzcRpPmp42xy1p5lPddd87Phmc7JTfLuKeqEfKn1BVhfQOW1rJJ67H5lG24s3Dg0UG/XM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 09/17] xfs: refactor xfs_reflink_end_cow_extent()
Date: Tue,  6 May 2025 09:04:19 +0000
Message-Id: <20250506090427.2549456-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: f8218fa2-c589-4096-2a96-08dd8c7d20a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SdsB10omnK5nTjJd8rVQXY2DC9rW7n204EzlFadnj4Qy1eGwfcJ2CP8xjZH1?=
 =?us-ascii?Q?t3pY1q1vVGBSTFW56T9PAdoriulBwuBHmqlRjBv42kUBvzG8xsOjO2qzq8gb?=
 =?us-ascii?Q?+PvfY39f5cMORJ+BK/NoIfYdoqshHCR0a6U+C6QgvEETsKUrWBrxkY3LcGn3?=
 =?us-ascii?Q?Mhu3a/Pb3Gp5yN8cVSJpIABfHFaye4J3HFn7ZxSThpWAbkroz0GgQHu08vv7?=
 =?us-ascii?Q?/mBTqaruM2DjuBoyuzDZ7kxfjp9YE9WXfEzH7Bcpuf+us4Ah2hIV7yAEFutB?=
 =?us-ascii?Q?zdItRtqy83kMiC/FQWoL6hhWxP1qJOwPd319CKTSB3DrAB0x1NGA5C2qXFAf?=
 =?us-ascii?Q?cYqUbaX0McGhfCUo9V5MVKluYLEC1cbe6tw3gPwPq0j0r9WFix2lacAxP42t?=
 =?us-ascii?Q?tbkq7vYpGQTwff+kftly51PPvCjoZoENxHCNZw1bHKGvn14jWxS+/xq569Dp?=
 =?us-ascii?Q?IBFSI0sYq1glEPw6ClH7l0HMIBazMEmM5HP1yJH9qDF3hmgHu7ecvjbMapFO?=
 =?us-ascii?Q?WW7owSmoySndEfEInBqzo596ogRii6Qn0yQMXRe81RejSGHe2584RkmmId+d?=
 =?us-ascii?Q?z7aCIuKiFsfS1rLDR2LkAQP4rnwO7ePZ0cHtNgShdhjWpHldLBzojiBm8eDn?=
 =?us-ascii?Q?Igl7qkkdKO6jzH4m8lpxTjfKKcNQ5hwuOwyqaK/jlHjuB+EV/9XjALa+5PpM?=
 =?us-ascii?Q?q489sS2YMw6cD+SICTwLk426zY0W1YJCgREV+dbBWwY714Kf3npsutP275QJ?=
 =?us-ascii?Q?LqOtSgt1ha4VP123X49xN7QCG2X715919N6l1nAd42l9+c9T4c2FMU3tq7x/?=
 =?us-ascii?Q?YEE7mPrvnKHEdNhzhsFvLu0Gy5HZFwWULw+HtsIg0te7KiM70IN0IRdysKFI?=
 =?us-ascii?Q?vQy+IoVlenlixpnw5JLSmchK4BG4i5XGIi5AGoIvuiAnjURB9ECOr0TkPkMy?=
 =?us-ascii?Q?3LAtYRQSFCZKCV978Uvz12jyY97yw1lpOCgiv/GlC45sVfyd+yH1c5kfk/uC?=
 =?us-ascii?Q?/QDuzWS0xVQRYNmJAgmOHoOymu8O8tbka+9exwWaU25iMt2FR3ypUkausQWP?=
 =?us-ascii?Q?vG8pPLVQoMcAhhfsCQNQjYQYiahNuDY54+h5eVHnNJHn7cQOLhEpnHRNCLpu?=
 =?us-ascii?Q?/LzJ2yLaHSFHGY//9WdLUJ21GJEMOPZWfPcWxMH2TseHQSB3zsWBysQQNils?=
 =?us-ascii?Q?orKbxAqkqk22lyHTJTsFn/i2IDK4Uty01XoPh305g0UShgy9wYMJuob4InwV?=
 =?us-ascii?Q?OQlSYOpj5EXN2mfUQO6hZTaNtF7dUn8/Os8WSzlpxOAomligwOIqyasfMsi1?=
 =?us-ascii?Q?hrV9p+2CKpkyNbKjhl8qvGKgKvSDWtAi/rQVcCILRW5gfgHkyHfTIQm4eyr7?=
 =?us-ascii?Q?RtHWKRN0NKDntNpXRmlqySS0YKTfoam93W+p/74kPLlL83NJfR4uWSxXwSRJ?=
 =?us-ascii?Q?wLEeTIKqJik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCokl8WZtuSzewA71/Oz83FCXcuN7b3S2/sFf4mQGWu+cJDH8YozbUjggx8f?=
 =?us-ascii?Q?BoXohNJUwSRqHYhT0BoP6w73bILnvhJg78yJiAMdIgiTkrZKHwSP1efG+2au?=
 =?us-ascii?Q?GfVPo7aFSmvgY3sHgrPwtI/WLaEZIODnDeqn335shXmtrZ7JoyTUeu7LehG4?=
 =?us-ascii?Q?dhLol7rp66G5pzDIbQ5/+EfgLvxlqA6+nCMWFjXBBeoC8pKaeZVNdIB8a41o?=
 =?us-ascii?Q?U2ynQoK4g+UrjFfuZOHoo+3IJNqdTFgYztzn5sfs/ZN3FED6eqFIlCKwXRrC?=
 =?us-ascii?Q?ApfTzTIPVph2aLQwjXkkq3M6xhjCvK5gFu30J0vXFE/FDe/c6zh+Wdoj5kA8?=
 =?us-ascii?Q?PXpJ85zksiSIgA6CNqZ5iVAQe04GAEJT3jUrFhG9Z8/rWdAL3oGDGvMzSOIj?=
 =?us-ascii?Q?TzLWY59BngouJf8sWLlnuF8nQSQ6QvLKuOp7DGtyaMzw3E9IWlh0EJPumtHO?=
 =?us-ascii?Q?BsLRdu9aYd5Nw4Ni2fZIBB6KEKZN9XFERSsAHFM4zs1KPN91cu2cx2o2mq33?=
 =?us-ascii?Q?TPcCQKt7iJCUroXHos9roiRFiKrI6sRguhDJTPFoeCSci2mWyyd/NCSmCRMx?=
 =?us-ascii?Q?iivCabcdyGAo3qqD+JF51qPVW//+78but5Ihvv6tyKn5Zgg5hnQY16ZUEf4a?=
 =?us-ascii?Q?S8e9df708pTFxNCi32RsWxB+d+zD2wwZrzUtt7xLCC2w2CdHZ5eRa9X+nJSn?=
 =?us-ascii?Q?U24MMc9NsBN65uhsDiKPD1W/7zsmGdfbIwHGzaycgCk8rsEG5Emt7q/uu+mO?=
 =?us-ascii?Q?SxEstf/i6UrCVKYUh2xn46rxaayjgxx3FuDk4cisDFCPgjUG99avSmuzvfag?=
 =?us-ascii?Q?f64QyPpnyBcvDzZvG+qgSCUCx6Jbnbx8HM53U0Feoh92Zr8EKjEGjzyRysVm?=
 =?us-ascii?Q?nq0Jd9SRtdZ8H4wRizJRcyyB9q0dm8j5MbL7zj19vjLZJ23aRIiLQJsIxL4I?=
 =?us-ascii?Q?b2nOeNDQYJbKnfXGf7XUn4ITUi8/vvN88Zd9XhA5uJdvmTrFJGrJaoyjenSZ?=
 =?us-ascii?Q?rUkQbbwSdC3otOgzXSAeVCcISgUHKfIManxUkUNkx3Qijjq7Oj/9kvMoPVR7?=
 =?us-ascii?Q?BxV3He2y9aUTyBkNFMTB7I2Ibo1nKkMLgiEqupuSgyjNCQN1dhk3PcRH0qnp?=
 =?us-ascii?Q?KFAoGuESyNYndmrQFjt+psBzKE7OAlgV3M/FeNmCdXLc7R9OM1ZfP+rKi1QD?=
 =?us-ascii?Q?s2/Tx3HJRMDxHZkx0HaArJcHxZQEGm92KjNr0Cb5cc2rfGGjGxGVvDA6S+/S?=
 =?us-ascii?Q?L8kswohPhReWjk2r5tOv3aM94JG3xko7+AraaYYNsxTDsaTXdFB7Qy8YycXK?=
 =?us-ascii?Q?a8dtJE57FvtmhteHUj3ibd7KYU37KO2bEV5zanyUSAz8Kc4S0uoRanpQSeTX?=
 =?us-ascii?Q?oRBcU5wm4T16lW+qOZVKMHs8EsSCOuY3DeMhL5YpbBJpnZ54t/8Eglfdts/G?=
 =?us-ascii?Q?/9GX9jfn1ZLT+khhXsQxRG0rIm1mWUl7bD5N7rH0MDjkBSvPFA7HKcRqx8eA?=
 =?us-ascii?Q?nvJnuXDjxT5U1d+QeOHu6y3P7ft+SzqTkjMk3XIlwqp5WeFm7MX/Pmr6hJBZ?=
 =?us-ascii?Q?wXXL5Id2hluAXA2ekW9eNQcymPiSk70ZN6wYFP9hYRhrYlVbLVT8moxYQq64?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VWmztqFffOaTVebiBEixYIlk7XDnHoMCNOJ5zIlGkcW81WdQoxi/7ILYhVV8pK39RAt9mHp365jPIBSKMU/pYQaDBqCi2jdU+MUhezcxDi938GIMhnSys/s1VRIUFaidoe+HdSbcMepiKMZPMhoux10dcsD/W3LjTwWEjWknPJv3PEvDiYI3fGG0UdRsN0uwub9Xyc+9MjjVuCUFK5w/XomJW2cdlZEWjLWtFdYsDNk44GdMMoLo7w9YXjAgnQygOxnXHiL+F6RWV9xwDZ2wOV8WUA+t0C2rwN7+cXgFaEyvscKc2oKYBLknb6uykXRFG5tHNHiK6OzmzejrmFhpvSFF5QHwNg0rjJYg/iS1LnVJjK4XZc+Tga49oormGS0vrmDYMIIQyh7clXQjVuXBu6j6NykJpnw3hTH5w3MTORaAW7vUFif3hfW4KI1Ez0e6ddDBWv9P72jxvGobsK7o2Fyo87TL4ymAQQ1TF2b/ykDz7BM75qXqlpmOAdoLcxnoPVjwkWYatVGtcIGEfE+qwBLEnIiIPRNKg133hPZc5wjs5QvlwdX0l4wm4Vow+4pnk7LfxJ6q6z31kUx1UdrNVYglAIPzKapGg4gIkSYIplo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8218fa2-c589-4096-2a96-08dd8c7d20a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:20.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn2PWHb3gdr9Cfo6lsJVFgIvSxXtsYDwiqDnEX1qa/s7LazAP/pgxanBmbTPzxQ31Xvfiuqq7U8KcxGS8cA1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-ORIG-GUID: D90tLxMvUPIpKyMljZbyMBIp1Vkvl94Q
X-Authority-Analysis: v=2.4 cv=Q6jS452a c=1 sm=1 tr=0 ts=6819d0d8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zPHwHgG4P_mrsmFPOIUA:9 cc=ntf awl=host:13129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX0ojqb5qtSl3r IqtYD5iHQwU7G5m6Vq812HRB3pRVE4K2C4NskKph+Dp2UwnmR04tvvcpDzR5BS4M3zcgC+LBM3c Ghte//SxcIZl94vHSLNtDvf1yUhWwUfsQt/AXr5cwz4FEcFxvkVm3VoWajis5q+XyqmUq+2pkgg
 XRbPqnr7y+QAml/tPUP6VBRL09nYSRPtr/O83eLaHJZJuMnc2FjI9qYpPZDO2PS7hQXFO5MGfZn CHqe5Dg+s9qR3L4RWt0sGF/zVm3j5/lwZax8PcqGMvGGAG4bxSsBhK+zmiuSX3djJLrPDQm+rS/ OgpqN8YTAgCAoBNQubadszsNwGMYturSeZc89V36jMYOcxtU4Td6D1O44mX+FFSjePeXyhwDS1n
 gUUOSq8lmupJmxSVj1tXmmNAtmjmhgFrXSdELKZR0vzZrw9WQ3k0SWThMOaGBVdoQHEsMhEb
X-Proofpoint-GUID: D90tLxMvUPIpKyMljZbyMBIp1Vkvl94Q

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


