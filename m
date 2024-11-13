Return-Path: <linux-fsdevel+bounces-34661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C659C74E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD780B36BD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B22200B84;
	Wed, 13 Nov 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OIokINVp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E7MzgUJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799277E575;
	Wed, 13 Nov 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508924; cv=fail; b=RrSCbP3HTh46wpkOmMVszwyS7LLRnntiZElwL4JnY2C7ZMtNX0bJuKcH2Bf4abvEsQsmRH91o4w0JQjXSCTOpJ8iJWJRktvcHSFhm+FNCsI8KaGNd8Bj+jDS+7vmlrGQyd/SppYkcji6H1DEtDQilQ978KzE1E9MtXAH55+HMMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508924; c=relaxed/simple;
	bh=ZB8gJaWiyZGa8V5SaM2lYzWVc8WV2hsrcumy+eoLnH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TjyN0SZaNLMTPYQA8VflWBTopOsq9MJSQfcDFTvXQZiMCw/sRDj8dpiU6gA63+Esw1z0vWkYhbuy+FVf8+egZlWBm56qWWJ43JHPJeOm+PFKzfqRqVFBsgN2T0WgxMvN53tx4ylwLc8i0k+iuusR6Cjh6cSUcaxFhi/6fuWgzaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OIokINVp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E7MzgUJc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXd8B013757;
	Wed, 13 Nov 2024 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZB8gJaWiyZGa8V5SaM2lYzWVc8WV2hsrcumy+eoLnH0=; b=
	OIokINVpTfAHyX7bkBxOHNx7KkSBqyudz9kHB4f9/XxWDgTmlH/+sUt0FldxUAbI
	0Mz37UwKSioS6528PQiYHOtCpWTyUmc8Tf+irIiAZYt0M1cA8xgUCTCKBiKfbv7f
	7SNLl7MCE2xEO54kMq0Y9pUnNgYleufgGMVBcwacg2//xChuRz+REMnYgiFIJ2pb
	nwETl/Wh6WSd4eCSAGV+EdJvtdjyRvRytSQYtnxGg/V6eYHIyJPYsFGkFZiENdWE
	n0i6cmS837kLPfYSWJpc/7gVS4JTTXT8kgJDNP7ke6I9P5CQcRXH+ezhOQB6mmmZ
	5+nM5IQU4o1Hz7SFEuf//Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf2nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:41:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDFZuk035933;
	Wed, 13 Nov 2024 14:41:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69db5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co+9KmUHFLJ57N8x+5Z82jaEguYLj9lUSOaqLYK8vqjxRO+qWRKYW7STTOZfs1IWXy9xmykwKPH5YAYHtb5teKDid+Klw0pR0ZNQzi16Mf7p7Roz8cBqtaYf+ad1HeFq1i9q/m1m1tf0KOuqp0lyFYT4Bfjcz77tR/mx6LsWaHZ1AE+a9Tw9RDFhmxNHM6J1m5VFO+MLLZohPgbYKrOG1I8TI2CPd+FThX75Fb/GwbxOwCMr8Flf/RKUkZvyPvrs6kBz+7914u+cfdfD1Dgv9wQFLGOqWa9JnnoH9uxlgRA4yUDRWxC/GkAbPQdTRz8YWwCfmYrUnD3+vQ+bb04WXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB8gJaWiyZGa8V5SaM2lYzWVc8WV2hsrcumy+eoLnH0=;
 b=eXium1wBUEkNyNHJmBi/fCWz6I1IZw/hkFUBWoQfmC5/jZ0wTFQHPW1ScoQb0ERMJUTcwM3kMDdNZ37PFsyYk0qL8LRBtNCaH3aGeqo+5airYbkGqVYeVJ49ugphJcjJkWo77rRGW0sVGQ4LJVV0Xtj+0autG2TdYfmkxuILQFAEhLVYikdiCcARiOWW3+RJqIIaIiDA+H6XSpRkv2PjgMTwJpjaL2LVmIaeSUV/5dMR2XASe+LiH6IUzbjDm5lFtCCxC5ACK44SKBuoP+6yyGYVv2nKutbHuuwZvLqsE6zJXiTQlElwzXKXH0s2TC9GsNsimfb23uqhw0Bsh2ecxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB8gJaWiyZGa8V5SaM2lYzWVc8WV2hsrcumy+eoLnH0=;
 b=E7MzgUJcb464B+tYXiUizUVRuAheCkFYOAt52nLF3n5mekUOzTsIUAjIEG1HSptbEzZGIbEVjJCHZiRe06Ct++alpFr8gH6cfc1TP5t8VthcpMyhqaDwCfmpgQ5r2/0toK4l3yNL31ooHe7HHaR4ZMasoc76ZwC1cu37GqDr2og=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:41:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:41:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Erin Shepherd <erin.shepherd@e43.eu>,
        "Darrick J. Wong"
	<djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein
	<amir73il@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "christian@brauner.io"
	<christian@brauner.io>,
        Paul Moore <paul@paul-moore.com>,
        "bluca@debian.org"
	<bluca@debian.org>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Thread-Topic: [PATCH 0/4] pidfs: implement file handle support
Thread-Index:
 AQHbLGW4mIV1zbr9/kGdguiTaYtKY7Kzr5cAgAClsQCAABsdgIAAoTUAgAA1pQCAABQpgA==
Date: Wed, 13 Nov 2024 14:41:29 +0000
Message-ID: <78CFACCD-E2F1-4FF6-96BA-3738748A3B40@oracle.com>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <05af74a9-51cc-4914-b285-b50d69758de7@e43.eu>
 <20241113004011.GG9421@frogsfrogsfrogs>
 <e280163e-357e-400c-81e1-0149fa5bfc89@e43.eu>
 <0f267de72403a3d6fb84a5d41ebf574128eb334d.camel@kernel.org>
In-Reply-To: <0f267de72403a3d6fb84a5d41ebf574128eb334d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4484:EE_
x-ms-office365-filtering-correlation-id: bd686fc1-86e8-4cc4-6d7c-08dd03f142ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXl4V01RTzdwNUVueWkwZ1ovaTNKZm1NNWtlK0JiTk51aDV0Nkd1MVBMSDdH?=
 =?utf-8?B?MklnSjlRQTdHOWNEQW9tT1dpaGFRQSsranpRcGtqUWxBdUpnV1VIYUlVUlVL?=
 =?utf-8?B?emNWK216cHJPMDNNRUkraGVnVDNxL0hQN011cGZXek9DSHhMQ1ozeW5BR3h5?=
 =?utf-8?B?bEZTeWFaUDhjRDVRUU5QbUJNSlFlNHBKTm1oSkdYM2MrdzlROThmeWFTUUh1?=
 =?utf-8?B?cTh5eTBUWUJKUkVDWEZnallUcEE3Tk9FUCtjYUVsY1VQc0psaXkvUTBvamF4?=
 =?utf-8?B?S1VnZ2F3dkc4N3NZYkR1bngvWFR5a280NC9PYkRLamQ0ZDJZS1NHOWJVdFdD?=
 =?utf-8?B?emZrNWpTQzBjUHluMGlyZVdyN241eW1jTEs3bUx1M1BNUGZxWnlERFViUHdV?=
 =?utf-8?B?UXpYSjdpMldkeUNEaTJVeWNPMWlCZE80VEg5QkxTdFlUVXN2MlBIM0h6YmZS?=
 =?utf-8?B?dWxYSkI2Q0pHRnBPaTdzb2hmU0k1SXlpcENTWFNldVlLaUYwaDVXRUU0andl?=
 =?utf-8?B?cmZPdVZWd1gyalk2WXppdTAzZlp1Wm5EVUp4aThGdXQ4cUJxTFFnWmJyeVVR?=
 =?utf-8?B?SnVFRHd4K3dacTU2dDFPSVZacGRPaGV6MUs3LzNGc3VFOVluOWtpMHBGM09Q?=
 =?utf-8?B?N2ZXd3lSbHlrNGVUZlRKd1lwUW1ITmFjazdSQ1VTVmMrWTVIZXVMVmcrWWx0?=
 =?utf-8?B?VXNoUXBFeWZlbDRYOGJVS2ZZaEYzanQ1YXVOTWxrSWg0ZURleVMyN3Q0dmNJ?=
 =?utf-8?B?TE1TdWEyb1FDbzlRZVRXYWt1WmR3M1RkZ215cWFLNGNJVFdZb29VcmdFdXp4?=
 =?utf-8?B?UjJlUjQ1MzFrNHB4Wlg0eStUdEFNdzNDRzd2a25KSDg4bVg3ZzJuamxmMzFa?=
 =?utf-8?B?Y1ppTnZaM1AzNStERko2b0JabmFZU3pmb29CUjFpNWxsS2ZBZFluUDMybHlY?=
 =?utf-8?B?VUQ0SVBoK01YU2t5c2hFbDdYdVkvOTJIdUFJQ1RkanR2WTRJUVFmTG9mWi9t?=
 =?utf-8?B?NFZRbkhQMGtja1dJQnVRVndCblFHeSs0dTRQWW1CZzB5ZkxCYWRiZVRQcEdV?=
 =?utf-8?B?elN3YXUrUzJPZTh1WnBZM1JGRWxmK2x5clpMRFQxbEtwRGFyR1ZiaFRJd1RN?=
 =?utf-8?B?ZC94Ni9YYjN3UWtuRlpKUUJ3b2s2dkRUTHc0UDk2OHlXWXlqTUJnNVVkSnhZ?=
 =?utf-8?B?QXlvbUkyc3BPcVVOTFkyL0lZeHVuVkdRMmhVNnN6UHVJWmdLY28xQWRybW41?=
 =?utf-8?B?eHJraEVkWlFqbzhvM2lMY0ZSa1p2d1ArWVY2QVgydThzYi9WWDhSZ0llbCtX?=
 =?utf-8?B?aEdSQnNQZkNTQjlhZ1hmYlJUY0Ywd0R4OTlROHNtemtOUkJLYVl0Q3pMK0kw?=
 =?utf-8?B?R3VDUzNJT2ZHbGZlQU1pTXBJcW5FSC9KRWhINkFYdjgzSnMrWnMwaE9yczJB?=
 =?utf-8?B?SmMwb3pqaTdZT2hVNHRYM1c4NVJuM1ZXQVQ5MlVOUTlJYmhROEJMUVB4U2pW?=
 =?utf-8?B?NVIxQzVrVWhFNEhqZlpJUUhURkNRZFIrSnlLcGtyOVo2b3hyNURkdXNPaHFJ?=
 =?utf-8?B?RVFmVWxlU3FxcFdGb0ZaekJwbTBGNloxRExXN3pZVHFWTG1mWW9weDNWYVdY?=
 =?utf-8?B?NnRDOHRsNCtHeEtaU28xSjFRT2IwcitXc3oxMUlsVUpkTHh5YnRnU2RTK0xI?=
 =?utf-8?B?bm13N3NiZ3B3YVFFbnVZdUtFWk16RlNhZW4xMEVISGZXaC93M2Z3MEFiU3dw?=
 =?utf-8?B?M1Q0bmlvak1McktRQ3BmRlYvcTk2V25WaDFqeU03WW95VFlkNnNIeG03R0Fo?=
 =?utf-8?Q?+ovKrNAbueqqlQyyWLTqK/J7BNgFqRKMxUDCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTJEZEdXWUllOXoxTng0ei9jRE5wNmhXZDJjdzBLUGdqMFpvQjM4aEhhU00v?=
 =?utf-8?B?UVNPOEpGNDdnSE9NQ3dVUjJ2SUlJZFJGd1IzSExQZHpzaGw4akpZR2dkbVJO?=
 =?utf-8?B?bDdvYzhQQVNaT0lrdzIydVdVRVN3VFFJU3paS2E2WWhvUm1jK1FWT2U2ckpO?=
 =?utf-8?B?UkhCWUR4Qnk0T1YwR2JtSkx2OEROT0t0TUE5eUMvZzkzSmdxcmlRUGFsVFlS?=
 =?utf-8?B?eU5SWnkvZzF2Z01sU0xwMzF1eExJTDZ6b0QyWmJ1ZTVYYnVwdnBZMVBWeXZT?=
 =?utf-8?B?S3RzVEdtTlRMZHpWdHMzYkROWVZtZnpJK0l5b2RBUmUweGhHTEQ1Rkd0aGRJ?=
 =?utf-8?B?MmVObnNwZWUwdTFNZGFMMy9QL3AzYnEyMGJvOTlwV2RPMEhUeXl3QlYwNWtE?=
 =?utf-8?B?TWh5SWExZmVmcmJ2M3loWU9DMkpYTUxJenFsN3lEcEVodWlEQm1zcjBuc2sy?=
 =?utf-8?B?Sm8xTm5KUk8zZXRNMkVGWHd2cm9lUCs2dnlUcWw3TWVaSFFuVjZZSWd6aG5O?=
 =?utf-8?B?bEJ3U2hEcExGeVptemNSNWt6bmFyeVR1WDZNRTJoTHYydHpRbXlLNkczcWVq?=
 =?utf-8?B?VkxlUEQ0SjNweWQxUkRxMWFyVFBGd3JrSjZmaFdOaEhUSGJiMG1Mdlh0MldB?=
 =?utf-8?B?R0pQZUZRT0lhSHY5QUlKVTREb016cXdMZ1MrRWpaZGt0Rm84dll5YkxGbDVp?=
 =?utf-8?B?Rk9TNE9OeWJ4SnJ3UXdOSmRCb2Fpa2VIaXFMRUJsU0VjSGovVlVzMHVkcmRX?=
 =?utf-8?B?L1pVelZjN3JGL0ZoVlZhYlBheFdMd253OEhrN1IxaElWY1QyMFFDR3RpOFJC?=
 =?utf-8?B?cGR3VEFaeXlCbFlWZ2RuaXdJYW1yMmwrVmJmc3ZoUWNvSUkyaDFOcTFCbkRx?=
 =?utf-8?B?YzRvcS9nMllqQUxpWWlWUnpjVHlEZEdrZzZ1Unl3dWlTL0laVU1MWTRad2RS?=
 =?utf-8?B?UHM2b3lSZDJ2YXdUNEl0UlJWdnBDRlc0QVNORGc5SVZybTMyVE5wTzEvVDF6?=
 =?utf-8?B?N01peGlhOG1UOVVzZE9KSDVHRHJRK3pQMEtLc1Vxa1hmODh6d0RFVzhySjVi?=
 =?utf-8?B?anlLQ2dxZ1JBM1h2RUpXVHlHdWg0cUEyMmhwVk1iRFE3R3h3RkZyNXV5WVNT?=
 =?utf-8?B?YmpMdHdmRjU2MnFpV3RncENBOU5zNlErTTRxYi9vNEljcEwvbmZlS2Zobi9n?=
 =?utf-8?B?NFptKzRQN1NtLzdrR2M0V2pQRWt1eWdVQWx0cFhPWDJXYjNrTndWU1g1RVVa?=
 =?utf-8?B?cjR1U1VjYzhNbzYwdHl2QUl3bU1DL3dkYmMrL2hJUmd0R29zSTNXMDBVQmNs?=
 =?utf-8?B?NXMvckJESmV0YzNUa29WTXBsOWpIVmtVRkZKU3YvS0pGRDZIT01jWExtNEx5?=
 =?utf-8?B?ZUVKUHdoR0VDVzVkd3puLzZveHBYV1NyVCtSZGJFS1B0cTdNaURwVGg2ZjBy?=
 =?utf-8?B?dDQwcXdHVXc0ZTRtYitQaFZUbVAyN2VsY0JaMWQveUhuaE1CSHVtN1VLSjVw?=
 =?utf-8?B?dFMxVjJxWmVnWTFXejVjTW5jTVNqL2lQVGtZbFNEcUFoclRwVlJWOFRSaGYz?=
 =?utf-8?B?VUk2NHRqZUx5cm92U21HVG8rQXM5QlRLYTd5QlAvTjk1YlliK1A1U0kzSUw4?=
 =?utf-8?B?SXYvd0htd2RNMnUwend4VXFPZnREdDdTdXd4UE4vM25NTW84eWE2bFFTQm13?=
 =?utf-8?B?RVNRdklBVXJYRWNGWXBjZm9oclJuU3lzeDl0bjE2L0R6TVJWeW5zNjhxcTUx?=
 =?utf-8?B?QlYrVDVwWU4vZGVyQ3ZQVExHTlBqWG8rSmlVSm5lUjMxbGJuSTFxVTkreVJ3?=
 =?utf-8?B?ekhZSlJLOG1jaFJPRnBZRUFleThVMzJBY1FvMzFYaXhGeW9qSkhQbHdCZU5l?=
 =?utf-8?B?VGh1Z0o3WEpkaUVheGgxWm1YVHYzQktYV2lQZ1Z2WjYyRndNRVMzSjdqMmR5?=
 =?utf-8?B?UDZlN3ptRXQ0U3JtalA0ajk3UHo4U0RLTGU3U1pvV1d4VzNodGE1dFNKZkJn?=
 =?utf-8?B?SlVkRGplVXp0VERuZWQ4VUZwME0yckkwU3FLWWFaMVgwZWdRaXlqTzJkOFNw?=
 =?utf-8?B?YkhXNDd6cGtMZlI5TjZBM1RmcTdCQ2F6S1JLRWl3UHU2VHJiQ05TWWplU3Ax?=
 =?utf-8?B?b3pubmFlNWlsOUlCMVV6TWRKN0t6dU1nOHdwQjdsTHQ4R09KVTFLc1poTWZX?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <765B91ED6B8CD245BE5F0F52529A5ADA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+GRp95Of1Dn3tTmYNViHM8ppBNdIEVueZZqVnLGAqqfV2vDThSWwCLIMlzmY8Tm/9KWun5NR4GBDT1smK5JEV92QxHAWoyzlZYeXfpUA/Yi3VE8BZ81lzOX+soA/Q2MQrFkTTn8E/tx51BBdptPjTNnoBjn3cWqS0NzmTMQiYU15/+ECzPIAoM89V9kj18uL4f0pMkOeoAGxywCi2Zc4jZwyLxQVtXta11EXmOtFM1w43UgA9K3rV7me4nESXhdfzA+GV9bTHadFtxA3Dqmj5JGEKD5JS32izpfhpShsVNFuPZjs6LuCqffrz713D8HXQXYEclmosmkfJF7SRAM/ml6ZNN7//AhyUKSHZhmU30QOZZnQ9QImkRvaR+q+egA0yzJDAW1nMEwUMp49UIPNuWxM7XcBOVbqyax7UVFBMOheVG/FaYY99Af7vTRdy8N4tVaIPhGdhIt53JU0Ahco6AihcfYUkAylNYf9hhPiumwVT292y7nYxADasCbBxrq37nGYXoaWjXcffyPGk31rQiWOPbkiMmhZhisSqi0Zno5UML5aydiu6yQk7+zNBGjb1MxVIusRQruM1vIoCbn+Q2LhTXXz0d25xT/wMP9bhiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd686fc1-86e8-4cc4-6d7c-08dd03f142ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:41:29.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whBwXObXM+dF+ry73i/VcO1uGsMc/F1h7nxYZoyqMH8U8qVju9hjjxZqMUUt03XwxkOg3ymjAcOJ9Ld/rvqN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=977 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130124
X-Proofpoint-GUID: DKsXlnmFOyq844EEnLmiNMMJlzcFa3jX
X-Proofpoint-ORIG-GUID: DKsXlnmFOyq844EEnLmiNMMJlzcFa3jX

DQoNCj4gT24gTm92IDEzLCAyMDI0LCBhdCA4OjI54oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDI0LTExLTEzIGF0IDExOjE3ICsw
MTAwLCBFcmluIFNoZXBoZXJkIHdyb3RlOg0KPj4gT24gMTMvMTEvMjAyNCAwMTo0MCwgRGFycmlj
ayBKLiBXb25nIHdyb3RlOg0KPj4+PiBIbW0sIEkgZ3Vlc3MgSSBtaWdodCBoYXZlIG1hZGUgdGhh
dCBwb3NzaWJsZSwgdGhvdWdoIEknbSBjZXJ0YWlubHkgbm90DQo+Pj4+IGZhbWlsaWFyIGVub3Vn
aCB3aXRoIHRoZSBpbnRlcm5hbHMgb2YgbmZzZCB0byBiZSBhYmxlIHRvIHRlc3QgaWYgSSd2ZSBk
b25lDQo+Pj4+IHNvLg0KPj4+IEFGQUlLIGNoZWNrX2V4cG9ydCgpIGluIGZzL25mc2QvZXhwb3J0
LmMgc3BlbGxzIHRoaXMgaXQgb3V0Og0KPj4+IA0KPj4+IC8qIFRoZXJlIGFyZSB0d28gcmVxdWly
ZW1lbnRzIG9uIGEgZmlsZXN5c3RlbSB0byBiZSBleHBvcnRhYmxlLg0KPj4+ICogMTogIFdlIG11
c3QgYmUgYWJsZSB0byBpZGVudGlmeSB0aGUgZmlsZXN5c3RlbSBmcm9tIGEgbnVtYmVyLg0KPj4+
ICogICAgICAgZWl0aGVyIGEgZGV2aWNlIG51bWJlciAoc28gRlNfUkVRVUlSRVNfREVWIG5lZWRl
ZCkNCj4+PiAqICAgICAgIG9yIGFuIEZTSUQgbnVtYmVyIChzbyBORlNFWFBfRlNJRCBvciAtPnV1
aWQgaXMgbmVlZGVkKS4NCj4+PiAqIDI6ICBXZSBtdXN0IGJlIGFibGUgdG8gZmluZCBhbiBpbm9k
ZSBmcm9tIGEgZmlsZWhhbmRsZS4NCj4+PiAqICAgICAgIFRoaXMgbWVhbnMgdGhhdCBzX2V4cG9y
dF9vcCBtdXN0IGJlIHNldC4NCj4+PiAqIDM6IFdlIG11c3Qgbm90IGN1cnJlbnRseSBiZSBvbiBh
biBpZG1hcHBlZCBtb3VudC4NCj4+PiAqLw0KPj4+IA0KPj4+IEdyYW50ZWQgSSd2ZSBiZWVuIHdy
b25nIG9uIGFjY291bnQgb2Ygc3RhbGUgZG9jcyBiZWZvcmUuIDokDQo+Pj4gDQo+Pj4gVGhvdWdo
IGl0IHdvdWxkIGJlIGtpbmRhIGZ1bm55IGlmIHlvdSAqY291bGQqIG1lc3Mgd2l0aCBhbm90aGVy
DQo+Pj4gbWFjaGluZSdzIHByb2Nlc3NlcyBvdmVyIE5GUy4NCj4+PiANCj4+PiAtLUQNCj4+IA0K
Pj4gVG8gYmUgY2xlYXIgSSdtIG5vdCBmYW1pbGlhciBlbm91Z2ggd2l0aCB0aGUgd29ya2luZ3Mg
b2YgbmZzZCB0byB0ZWxsIGlmDQo+PiBwaWRmcyBmYWlscyB0aG9zZSByZXF1aXJlbWVudHMgYW5k
IHRoZXJlZm9yZSB3b3VsZG4ndCBiZWNvbWUgZXhwb3J0YWJsZSBhcw0KPj4gYSByZXN1bHQgb2Yg
dGhpcyBwYXRjaCwgdGhvdWdoIEkgZ2F0aGVyIGZyb20geW91J3JlIG1lc3NhZ2UgdGhhdCB3ZSdy
ZSBpbiB0aGUNCj4+IGNsZWFyPw0KPj4gDQo+PiBSZWdhcmRsZXNzIEkgdGhpbmsgbXkgcXVlc3Rp
b24gaXM6IGRvIHdlIHRoaW5rIGVpdGhlciB0aG9zZSByZXF1aXJlbWVudHMgY291bGQNCj4+IGNo
YW5nZSBpbiB0aGUgZnV0dXJlLCBvciB0aGUgcHJvcGVydGllcyBvZiBwaWRmcyBjb3VsZCBjaGFu
Z2UgaW4gdGhlIGZ1dHVyZSwNCj4+IGluIHdheXMgdGhhdCBjb3VsZCBhY2NpZGVudGFsbHkgbWFr
ZSB0aGUgZmlsZXN5c3RlbSBleHBvcnRhYmxlPw0KPj4gDQo+PiBJIGd1ZXNzIHRob3VnaCB0aGF0
IHRoZSBzYW1lIGNvbmNlcm4gd291bGQgYXBwbHkgdG8gY2dyb3VwZnMgYW5kIGl0IGhhc24ndCBw
b3NlZA0KPj4gYW4gaXNzdWUgc28gZmFyLg0KPiANCj4gV2UgaGF2ZSBvdGhlciBmaWxlc3lzdGVt
cyB0aGF0IGRvIHRoaXMgc29ydCBvZiB0aGluZyAobGlrZSBjZ3JvdXBmcyksDQo+IGFuZCB3ZSBk
b24ndCBhbGxvdyB0aGVtIHRvIGJlIGV4cG9ydGFibGUuIFdlJ2xsIG5lZWQgdG8gbWFrZSBzdXJl
IHRoYXQNCj4gdGhhdCdzIHRoZSBjYXNlIGJlZm9yZSB3ZSBtZXJnZSB0aGlzLCBvZiBjb3Vyc2Us
IGFzIEkgZm9yZ2V0IHRoZQ0KPiBkZXRhaWxzIG9mIGhvdyB0aGF0IHdvcmtzLg0KDQpJdCdzIGZh
ciBlYXNpZXIgdG8gYWRkIGV4cG9ydGFiaWxpdHkgbGF0ZXIgdGhhbiBpdCBpcw0KdG8gcmVtb3Zl
IGl0IGlmIHdlIHRoaW5rIGl0IHdhcyBhIG1pc3Rha2UuIEkgd291bGQgZXJyDQpvbiB0aGUgc2lk
ZSBvZiBjYXV0aW9uIGlmIHRoZXJlIGlzbid0IGFuIGltbWVkaWF0ZQ0KbmVlZC91c2UtY2FzZSBm
b3IgZXhwb3N1cmUgdmlhIE5GUy4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

