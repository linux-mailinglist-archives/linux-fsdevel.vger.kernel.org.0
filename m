Return-Path: <linux-fsdevel+bounces-32100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB949A0706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DC31C21F86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB99207A08;
	Wed, 16 Oct 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zn/X7IVk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xv0TLHqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CD206E87;
	Wed, 16 Oct 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074070; cv=fail; b=KXtWvCvdoFj9nhFJVGstr7DE9lgceGQacxVb/dp5QqQqK2cYI8ypA3bpZCs7VOz6uQzZo5/pa2nDX2ijrBiUgsmyRMaBYpqAzzjW/6/UZlGUpTr0bIADgONmh0lOGU2SVbY7WQiJlmZZ+743z8Ap6znGtV+dr4O8/CPElPodu50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074070; c=relaxed/simple;
	bh=crBvDB53mKcdWE/b14vL7ki8GPoLhouRy/fOrmcCw90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PrVWzlrA6loMKEyywQnkrH6uj19mqHS7zc9fEi6iuPoRuVmQgCRDsGQju7NTvQhcxkdulYHXjaSYnK51ofODoCY7rPXow3Leo1GryASSSCgdl1+3YvnXLoPgtuLsxVGNUgxW7g7yKcDdfZkwM1y4GWvQp8xcfrZVJskA9HyS6iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zn/X7IVk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xv0TLHqu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tjaR022244;
	Wed, 16 Oct 2024 10:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=; b=
	Zn/X7IVkbdv2SjFSFumlCBhE8eISKx5Ae3Hx5X0Ugz1jY/JA0n711JICv/MUV0lR
	JKEtrMyC8r5jBG7JV2xYvAlK/q7zVpDXrcfbMhsXlPvVeQqbstsWHiP8BQkyBBmY
	hV+tFFBSEn51lCSlZoktU23ztlDUW0lL0m0MoXNbZMPM/VBZN8kOlBfnQgRiNW5Y
	KwXThAVgkv+PYwMmbZMXniFgIbnnNbT9n658MwMgbp1+q856KbvuI7On8V/cGCqA
	1aPM5Vsy3sC7HOW49v05wpxLhl0yaovncMMv0eQul6DCg477LlchizehQcxoAz6z
	VTH5afPCVWRwhQ7U7zrS/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcjyuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9xbWS026283;
	Wed, 16 Oct 2024 10:20:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8n3mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AioKK+OdMVSWIvLcnKlQIHFpxT7OFgiy8qiEvnaime1oMl5EuZyEVAWfwHpCkSQVwuL3Wwzli+1f8LgkU9yMUaQyo+FjmleVH4lbiazusotwGWC3Y9ZXA+lcuwKQVJW3+CTPXcM7SRK2l5imKxo4OvS9esiFW+fKK5/HTnacI1gbLpf42yBPox4c9EXAaJ9ucFgyy/9gN8bHmHgxarEZiy2Gufv0TxdMTI+cyBvsIHuNfdPY4zbtdH6SF27rZFTZ9nV0IanaMfP8U3etlscGGSugm6BgHBqlJ/RDu8AFNjCj2wkGfmWduDk9xKhfiH9/tchDaFkD2iXPjzUU32kbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=;
 b=neBy2bjgrUnpNq1Hd0eTi1c67M/B3DhZ+2f/Z6WMsjCWZ6sxcD5LkhXzjkX9b3EG1WNM/5W6N+51CSc7d9xB83jlMmvjwwcPJ+A+XNY5Xo+UO2ooV5K++7ZnyEJMXt6Ku26Pz7nVnp86qer4QKsmaL/RaG4kVb6ni1PJdW1nWJW9ei/LOnp/nxQDWxJLrT0LCN43Iv0ZUz4/iGEsZcxUbIEVEBRLtod98LLhz1BYlfR1NeSMX+/O+KMAPoWM91K37A/M6aTxBmcvj7CUYL4u0Zv72Tih7fne41j6tEVlUhurMC+Z1ujeMzDgWFa3HvGMQcsQ/N3p135JT+IAXV3sjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=;
 b=Xv0TLHquU3wWssdegp9KsRrXTgFIJBIlOJE9oimEFtSy5wcIPlsIdzZQLGX6rPsgHO59tcYdbIs5s4CvDDSeVhhXG2kzaZ3sa727FG8R3FkTAbbQJc1S2am1d43ydjr0apCvlQJLF9a3HAMExxYwT+fktDCRmQ34aAXyscTlOc8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:20:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:20:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Wed, 16 Oct 2024 11:20:39 +0100
Message-ID: <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::31) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e32e5e-505e-459e-8d66-08dcedcc3669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4AIyedOtj5y2VuKxnJ/23cFJuaa4VKLD1PF/pFhBc6hcR5zcKjqDQmq/w2o?=
 =?us-ascii?Q?quVkJeEtKShIOVe8ueAtK4+9ZB3FdxLlot6LZ7u4kGQGrh1pbvZTqUkbk3/B?=
 =?us-ascii?Q?pi0C/bBD61egiU/QVMEWfagnPFumTK13Y7Y0qB+8KECFbRCfamdONU8atdOO?=
 =?us-ascii?Q?rMJu4QAG5FDYi0JLSzU0MOQ7/rQ0LEgCxhsiIKYAkGWraCE6/TjtgvRDChWz?=
 =?us-ascii?Q?WCir7kl/zhC5hSrkujo/tjYY/RBJyZ/CUN3NAjGx19ollAtKk9AMhnI4wgeG?=
 =?us-ascii?Q?8NBRgPIl3OD81fz8bwlDohKtryz4G1ReCXaWiM3vPC9w1yQGoT8JMn4eADOX?=
 =?us-ascii?Q?JW6T9DsAnlkBaFr2MCfVOZ5zxn175nHKptGzGmQneRF3buYxwcw079rwxZry?=
 =?us-ascii?Q?KGvFkUzq1n32GFzNo/4GqRJA1UFRKIxh8sIneJ79xQojdNjuymM6ObY8ig+C?=
 =?us-ascii?Q?2R2HkYyezZOgOlVDden9Sv8AXfQx/efPwuelfpIGo4TqlmKOb++j40H6G7/P?=
 =?us-ascii?Q?UhZHxmMziIvMqlmMZnRuf11DBV6uno6cDoeqyxhgy0xaVEzFx54DtuHSaTKA?=
 =?us-ascii?Q?eD443T79ageoJubybdyZJtFMC+9rgi11xIvhwg1HLja3q0dslPpPGU2nRQpX?=
 =?us-ascii?Q?Yhciv8p/g/MzJIU19WjF8phP64OMQ+ks5NVwOEJO1Z1l/eiPu24Iv6M1MqPZ?=
 =?us-ascii?Q?bj9Xu3WmQMVe0pMMdztZGU1vGlDhG3PsB8om6f9I+k4K5+/yNpjEElbmAjFg?=
 =?us-ascii?Q?bqn4pkoaTwGx6xD9huxit5nRZ34Zu0ivcWiAw96Zbs2qwAQdjjzMv7JDJOTS?=
 =?us-ascii?Q?QFHqbSd0YF4NWD5KyWhNszYYGyU+wTpWwrYoBgnFUvmEeK4bJ2Juc9OGkAR1?=
 =?us-ascii?Q?OKOvZ7YcnoF/xyVXeEIBIGDCxKpv1q/83AcIMjJQNYbGaHqZTA/2ez96y3O3?=
 =?us-ascii?Q?Uk4vAuc0Bi295Tc97cW/IHzfsrg34cqmlkSz2rfYpg4p0mfcMqaNZw+BPJ++?=
 =?us-ascii?Q?LWiqWc1qUABbCAFQ46pnIw+UCThw5rbaLQBtvO0rJkh1udNyFInMF7iyrp52?=
 =?us-ascii?Q?cSB+NHJFDuLoCiKuAy0uvSB2dEnOMsN87VK+EPzX1o/dcZBhpPCqVKZ6Qisn?=
 =?us-ascii?Q?mcE/98Dle+Mw7hArEE1fUjekn9nnHTc4kQXVVzpfz84ol3+yBH2/RN9ClVG7?=
 =?us-ascii?Q?HrQLfIlJw9dtDOxfHfyA3vYfhu0UjpeikJ82JKxJ6Dk698ZaCbLxm4i7fZIM?=
 =?us-ascii?Q?vupGOhBHWo3HR2vWTft5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWKbAx/K5gIO8Ff3koqHPh26ggjUr5gE5oZpgKmD/setJLa/iYdCZFcXk9ON?=
 =?us-ascii?Q?4Lm4lEiNmM+KVqwR5HK20PU6Bu2Ft3v18C7tA/iIFKLHKDRaIjTBcHhMMNQJ?=
 =?us-ascii?Q?dKBYOzFubBmHxhOQ8qYEPXDKFSbJT8vIdkXqx9n51tJcFeNBJ34bUVOofuDE?=
 =?us-ascii?Q?b96B0OOxmqbBULm3BmZswVpHUE9KV2r/HMQEbO14gtoj1tLS3LUztqtTx4x4?=
 =?us-ascii?Q?6Kzx6OBPM1KStrui7tK0w6XopTii7VNa/XwiKneRVOKZmJpwjz4crP9GcZbd?=
 =?us-ascii?Q?QFiV1fZjuPzTHbjVAsGALG2ww+HTxHo65ULEAZxQsMiHIpH47F20e8RWnC5e?=
 =?us-ascii?Q?/3vUGzROuW1KmZWkoRox6lRNFUUmiEJmn4EpxXZzaPvaNvbCExpyaYYXY8d1?=
 =?us-ascii?Q?W/LszUDyAebuTH8HS5ZbZg2Wqe4Pjcc8XjaPTfAnD1wMXNdjz6o+9nturiAL?=
 =?us-ascii?Q?SbMpySvk+MaMa29i5W9mbHyF9o8oIup4ZxlvjFG/TZ76UDvrXjhCfKjaxk1P?=
 =?us-ascii?Q?tDxTc5p4xWuvrZJIS5I7ZfwQqP9X0Wn/ILNaXGxa6Ny800zh9j9y9QRXmGYa?=
 =?us-ascii?Q?Z0SL6bjOB4CJaseEQe6ZY0crNrUZuVxpiQKZpEIf0NBsKxT1Xa/5mqNpbVgD?=
 =?us-ascii?Q?rIHgRafLwbdY4LkCuEbJp/7bPpE/GQovqOXOwN87lDT98C+Ldpt4NPTArpbM?=
 =?us-ascii?Q?Q/biNd/bNyceLEhG598x4wtuNL96BW5ZzYlAYAuTbGpl9SkrIzXmVhwDkM1c?=
 =?us-ascii?Q?PP9SvdU1sblHZL3xUl2LSqByZ6k/EiUCizUGKgelPHfT/SVnUptkvyq0vpR+?=
 =?us-ascii?Q?j3fIxiS1xbfEPmudU+hqorSbrSI8ISPg4aXj0/VtaXAS2WCEFC/9tvk0uSuA?=
 =?us-ascii?Q?AvXWEQSqC1u1Wey4ZDHSOaIqPGiFqMwksIuVRoLGa18rkNx9mDTYTx8RJc38?=
 =?us-ascii?Q?eSXCmfejIoGQeqnX6OXg3m5MblQ21BTRC2AkMY7Kg5H0gHJRHbmsuFyfThk4?=
 =?us-ascii?Q?2ixkrzP8yFT0FyeMkPBKCudcgLvJCXwREb8NHSM0SrrtgeBBfAcdbDCQMHD1?=
 =?us-ascii?Q?KZix5nKaQ+ka4yPUVk7OqFa6OrfzFUT0C8zrLROO2tnWQDQQN4OTKfCTiDJD?=
 =?us-ascii?Q?jlxVFSYuMzA8ojrN/Y2fdaCv8Rkn1GvhgTOcBHqj+SuIqHEtmkskTzlhoAHt?=
 =?us-ascii?Q?i6hxScMeBsjVUssIsfInzEE+yz+nw8YeiR//5mn4gp0UM0Yz72SUrjGCiymR?=
 =?us-ascii?Q?3B4W6eYMM5s0I4Jz/wyxCD5iws0XlE+s46pm/PRoLJxcdQnLvW9n24VEB15d?=
 =?us-ascii?Q?F2DcaY+RM9MZ4i09D7YAkW6nenM3aiMZ4X/cXj/H2OXwHkXN32v3Kh9Ctobj?=
 =?us-ascii?Q?0YYNbsiOW5Tk4+wKKzEjmdIOcdIidYJWc1rDMyIMGjwEiDgAzwW+zWJ3oNlz?=
 =?us-ascii?Q?4/nLFyEhesuHh9s2BInL6ZIoHHAgPhWlL+6P2pOkCSW3YZdiyiWrnbhT+KOo?=
 =?us-ascii?Q?d/ondQP0zFKrLh7mMwcgvO4p5OX9bX2M2kZRd0WILVKXf4WZioSZFsGR6Uuf?=
 =?us-ascii?Q?0WkXolDUG2HVIc+tPtjQ+8cIUM16HPvpRbgffdQEWNcNlCnV+xB1lM++2pgj?=
 =?us-ascii?Q?TyZ6NzQkGvktflFERpj4wTQe6T1VHdm52YVD/LIp27oU5YhwNTyj27E4JSwy?=
 =?us-ascii?Q?WfLZWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E9vm9T7nazp4H3d4xcy1tCLeTucWOG+qyQLgoK7UQZFKKjXMLFn9h0rzytY1v3ZyIwhaSSnApolgFaWauNvKTZwbWxnZtXataVI377vxYD6c0WAMlMAzhxUOjYfWugCeQMlxJBujDhn789jF5gCOKUlNK50z9Upv43R5WVGns7daikukx+/e1/s6+V8xaGF0DisthueiEsH1lz5Hpy3aAep5xVtAQFgzN6A16Q62GO/+I7shhBsl05AIX2nYHSoM+etrm8cVdhdOhReXtwTeO0rVJRAP8fnbLHsO6fWimML4B8hoh04jlb/RFJ6fQ6f0W+y4zjGsle+P3Rtmq0aeWxBFYKHU/M4RTT8g3D96LDKzqtUo0WVzlvgVdLSALHuN8P46CKyElb/itCakM/jTuVGNyYx13iCakfnvqB9kxAnd+Re9NxET4Wf5Mp/jxORybLx5tcBDLSeqOxNPMLOg8hdO9Xtp/CIw+ljGWtky1AJGFaz4IPiPXqp2OoCpggP4V4iP5CeJkoqtWswJmNnXzc57QV/Yz7N3kP++QUfki4EMMzQpLS5oRfGV8zTE3lBvpMZY6pyK8BXxEQIp4R+9rDi+CJRPA+QFXIuVMlLWhYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e32e5e-505e-459e-8d66-08dcedcc3669
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:20:52.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ID9sjXpRpZgYC8h0m9aM7xD7iWyvEDQjNg0VoFDZu3ww7ZaIlgjDjaa2bPsipiOM/AyP5kmJrI9lBjkvYfUlZuQ1A+Aa9PuQrW4ZyPvKqJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_08,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160064
X-Proofpoint-GUID: AaFJVgT3LBv58RGyEibGWiA7zZPvlh40
X-Proofpoint-ORIG-GUID: AaFJVgT3LBv58RGyEibGWiA7zZPvlh40

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   8 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 4 files changed, 224 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..1640b711889b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -50,6 +50,14 @@
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+/* System header file may not have this available. */
+#ifndef PIDFD_SELF_THREAD
+#define PIDFD_SELF_THREAD -100
+#endif
+#ifndef PIDFD_SELF_THREAD_GROUP
+#define PIDFD_SELF_THREAD_GROUP -200
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..48d224b13c01 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,94 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int err = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fal.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (memfd < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	if (ftruncate(memfd, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	if (memfd == newfd) {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+	if (ptr[0] != 'y') {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+exit_close_fds:
+	close(newfd);
+exit_close_memfd:
+	close(memfd);
+exit:
+	return err;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = __pidfd_self_thread_worker(page_size);
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +354,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..440447cf89ba 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.46.2


