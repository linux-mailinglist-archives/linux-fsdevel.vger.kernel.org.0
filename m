Return-Path: <linux-fsdevel+bounces-2625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945417E71BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B4028123C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348F20334;
	Thu,  9 Nov 2023 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqqqBShm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TGopOQ/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DF1DDD8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:50:25 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E73C0E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 10:50:25 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9IIwEf005951;
	Thu, 9 Nov 2023 18:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=IEfEWB2aiDu4uWc30AEc6LPLcpfpjA8FNYQXLDn3FbI=;
 b=dqqqBShmvjCixy3by05s4f3Oqj6gIKFXk4E8vqFQ64mgTeTc/+Bjy5HdXGJe1WfuGzBM
 185c4CULghMJSHi4QYk2FpUMajdvVTTQ9/+gxHVAONd1e/mTFk3TS2osxOi1V7F7HjsL
 PGxXYYpALrl2E+1AvLxfrA9GlujjUo9jBaUu7bWlOxQbMpX3ZgnumjWxSbHIsD9Jl84k
 eFSY9y7vB79GhdKzFxdUK19oS3pHriOJDfJkeF2F3Fa2PHL2OIfFcrwb8eyFBHtBJlzN
 UylOkJWbk3+cHr07jpy3R3Rvygzvh1IfBDP+PN1VQ69ZkdNYdTcZ5I19AjTHGSqjdEqV 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22mmya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 18:50:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9I5rOc011074;
	Thu, 9 Nov 2023 18:50:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wuvk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 18:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1I+vci9S30zrJhtB1p/I1QsJkpyzDf1OjE/t2M9OLukF21hojiIFBOZhCDSXwa09h0CUaKNbjo4LyBOc/JLu15e42XQ4zVW0TOjsjMd0zG6mwoSgjYH23ClAtPcWeHOlqxD90NE7GRmS84k8vY2A2/AVhKbp+q+GLrXItjJdG20leVULKrz66dsJ5Phu7UBQTbsm+8J8+UerGhyXnplOD7t30j0OBddkUXoqJP+5tZZOhEGfz/+NaHciyplVxF40Mpurn4la/7x/Xd5/5nsrPH+EFejqydLuzyh5kThD8sejA7LOoifa1h/DurchmxfoWhi5q4rMVydNowmOzGRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEfEWB2aiDu4uWc30AEc6LPLcpfpjA8FNYQXLDn3FbI=;
 b=NwZ/TJPYQWKo/Fi/lMsBMfeOnAdV936HO/LmmUfZGheXhHFY+tsgawJt8V6Xkd4c8Bl97r4ARq26F6F+VFOLdqFP0gWSYoAvBlSIB3KA7vQFh8ydwx5+UNiqnyELAObktg2bih6hZAndxunY29V4KeFdm3Ib+r7HUmQya314BhMXrgBvRRMXqjCy0D+CClBlaMK1znSo3UzX4XAB/PHiAccUoD/5YeTZ1+KTt0JI5BqglUPhaYqHufbI6fbOnGOt+XbrqF5Mve7jcjtei+gfJhdQBOX4KUN7adEohY5z3R4lQxShXWcpoBLvAoGX4g+awTx01gh4uLxtUomW791V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEfEWB2aiDu4uWc30AEc6LPLcpfpjA8FNYQXLDn3FbI=;
 b=TGopOQ/Aaj2pzGODuDQ1oIfEr00f+MuYuExjDi4XfNyX+yQd4KDNit7qvPVPFb0cZtAHDVegZBeId0a+QwpRJarauv1MrVmGW9mP+qkyryUIEkACUZ6TNa4KSjH+FNSMiuF7BD9JpvF/LbmoVk60PEXTKjwSa0ps2Lj8tNEobAQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 18:50:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 18:50:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH 02/22] switch nfsd_client_rmdir() to use of
 simple_recursive_removal()
Thread-Topic: [PATCH 02/22] switch nfsd_client_rmdir() to use of
 simple_recursive_removal()
Thread-Index: AQHaEtTxiF2+Hj87s0yr2D07Ke2y0LBxsPQAgACjyICAAACxAA==
Date: Thu, 9 Nov 2023 18:50:13 +0000
Message-ID: <53A3698C-9EDB-40C3-AEAC-4EEDF2E37BD7@oracle.com>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
 <ZUzmL0ybLk1pMwY2@tissot.1015granger.net> <20231109184733.GB1957730@ZenIV>
In-Reply-To: <20231109184733.GB1957730@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB6399:EE_
x-ms-office365-filtering-correlation-id: 6748b2af-5432-4de2-e8b7-08dbe154b4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HhDrElCfeqRuZgPpxhyAw3/Bv9Dh0h+HEJWvokyIT3Em+6IbiM8yczYIb8PHFspl8FfHfb410wPzkby7FbCAOqWuWhn12iNd2i3e7p3fec+dwC5nS05xTTrm7Pq2pYnAbduIyHoHn9z7wqKp8F4GbpUx2RUtJIu1/a+eOumEB1RG3LnfJbZcOStIg+5oOPPkS+XFhhemiqn0cLfSSzbhRLKQQslTTxqzC1ESQP3P6i+ldXvbgIfkeqedbkViBq3uvKs1bh/afoQ/7eNwmK32Jg3QKFuiJWDDqUq3DJ1h3kt7VVAhgeVbGOJlvtaOvO7X9tCC4UJGb3j94B6qR+TDyLliAlrah0sYo1gE/djHd7r4T2fAF01mkXkukXYJNNwlcAzObvNmyAcI3oezDByl6/Fz8lsmCSWk5C3uf45JFV4UsQj/oXVK4h0YnE86ObDV8nRJwmPXRCKbQ9RF1rCQdpQqYNpNnaWmHT4hEmFKRF6lLmB+vrerg3nHfuFfeSfruEO3mumhsivZtAEwG7wesQd+o/I+k0dQKyvjgamYpqIW3CzyLUjCl+XpAJf9pVCahEj02q3iAK3X2JcUrikW6IjfsKg9VSCwL3FwciqGGU+Jr5GtXHBOuZSt4/09cnS93mG7oJ1edf8qnbEh1Rg/Lw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(6506007)(53546011)(38100700002)(83380400001)(26005)(122000001)(6512007)(2906002)(86362001)(4326008)(33656002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(66946007)(91956017)(54906003)(64756008)(76116006)(316002)(66556008)(66476007)(66446008)(6916009)(2616005)(6486002)(478600001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pYL3HPYvb73oGESB22OasOcMSHPO1p8MaPkQFzKta4hi7tjxT4KLAMtN7OHl?=
 =?us-ascii?Q?6GRktADY0fNJI6E1nuD4ex2jcHJmL8Sd+HCICthJNttz8h03ap8yy/7Iu5uM?=
 =?us-ascii?Q?6HxA6oyBDhrZiewxHydasyOffUcYkkYtNm2WRRYZ6y5KxnONzN5yb2LxL6ie?=
 =?us-ascii?Q?03HP1vPWgcauf1JMZbxB+qZRvcmIbk6LnN7jwdoafN/HoGTJRcFbE3n8sdxJ?=
 =?us-ascii?Q?kegsHieHqFFNfLgTReMvNSSX4WuJRc173M9eHDiQ+KrsPXNQmfSBDLZiqPxD?=
 =?us-ascii?Q?OYdZ4O/pVjJMEyVeaV7Pvs02IFGSRDga8PMkmJh5wOnSYnU6ELALny/+cBdR?=
 =?us-ascii?Q?oWoWRP1sBahl5hK/e8dC2HhYBKifAxdmm4gYXddJYl1SllTluy81IFM2F9zh?=
 =?us-ascii?Q?QwEUxfouSEBeIYVHeKREstDaNQIcN9jz1dD2FUM7ZH2NKelMymTKfsllggpF?=
 =?us-ascii?Q?mhWdVDNzRZ5DNkQ0M/0pyJZw+QlogIyEDCq1Vhe7yRyBm2o7tkUzGlS8dtxj?=
 =?us-ascii?Q?ghTnluYGBjAY7zmAowPCbpLuIfupbiXuEB+f8agndPpa60SGZrxvkEI27Sxe?=
 =?us-ascii?Q?oFwtqsyC8AFE+3INE8YSfldcG9iQEUWfETOjoMeOJsjSI7UZintcCZoxX4dU?=
 =?us-ascii?Q?AU7YeE1b7xJoc3ZV1I7xyf5I+ghMYR4dhO8NMOxgAe8lCooxOcCPGcrffV9I?=
 =?us-ascii?Q?LPx48vNgQu+GGpMLwKb8tLgDpTK8S3LCTzjV0AD362L/yiEmvogj+Xt3IcrG?=
 =?us-ascii?Q?/0VjCSk9alYIdhEp0VKaXdRGsf9cVQtnrcAvJubuVg/wNzl3/hMdl3qRC33B?=
 =?us-ascii?Q?/EaIBRjSDG/omBFrLbVwoyjIv8tvFrW8TutI8HJNDivMMYxNgZHT/KqX5iTQ?=
 =?us-ascii?Q?z+WFjXWT7cbcTM5oeQp8hRJDeEbr4eKOBlhoZSnaHGJb+mak7fog0/v4khMk?=
 =?us-ascii?Q?+LW0MbztfBcZietSsD0OY2MAN5D8MzKXyCGmIpJRzuXz+PcsZa1ckN7ZQqze?=
 =?us-ascii?Q?Sw+2eCIlhDA0IhBRhDI1o4DY3XL/F6FR6EHnp7KO30+xNUO6zCa2m9qsU/09?=
 =?us-ascii?Q?TAVG+QX7ueOmeAuM2fRYZ5S2HClbW8mUYCTjj5BQHoq1TSvZ/Hco1IfSE1Ua?=
 =?us-ascii?Q?0Ndg/DZvxtZ+6wNOKvfYn6BvvFniKjMauEK4UaBB15i/tSMyHyAoZtNhI1g4?=
 =?us-ascii?Q?LR+qhUPZqmN4Uz7HF04yghRP2Ghz0ED9Era2+YTBJMb70cQhd3pYIUjB1v1q?=
 =?us-ascii?Q?vSlEcsGJxoM9Wir7F4n0R7/wuiIGm2+iNK8kg9bxPw8sx4dhV397UuCKAp1q?=
 =?us-ascii?Q?IJaqIGqcKPPKGE0sQJ7GuFOWh0FJVq9XEvl7qdoNSQBAG7AvGlN4fCxS6xzw?=
 =?us-ascii?Q?RZnceAwVXr69QOakIC8IvC7Xq35myLoqmEU6Qi2u2rzQZZ9unxx7mU1andaO?=
 =?us-ascii?Q?Gu/cifEMAHYhpzoz+xtLRNwt4Jl0m3y1l0jWVCU+aCXkpK42zeDjvbzpLmcY?=
 =?us-ascii?Q?pC6LO2vfFYXeENy+v7AKJpmIzJhXa8AfH2VVJZGmWGHyPhQUfbEYroAytzYn?=
 =?us-ascii?Q?JVIEZEfNqaA/EIop8f5kL/rupPXx9UOZM6mSqLgBEfR/k4AFpcAZXtDUe/rp?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BB58159E9526C4488FE70566F1141C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YMJ7uhQwyNKChi9iRPn8zey+pmra6T8mUwAX2i0PY1tHQNSVcORzMGhtKoMcqXRenrKKz1o93/68UMj7P3q24ChNRxbpzN+kfvK72pBWuPK+hC10vU+NNYgCC+cvC1TEtHdInayoWDNjb6Lx17OD+vamuvf5EEKAlotQe5dR541pktTP7nMFGxAw5raMX61odCnpVTcDpVcBwAlYN9KTOvbgHrVm7pHUPv3b/kNgNa2iCGyWxVX61puEfNWQHut5dg5B0Ij+z+Ad+plsBnrSYfHs0O1kfilsbt/d3MQj3rfeby/0RVTWHOxR9ly1PY1hgnieKlRx2n0lPE8ALYMO3xn3zwHXVggnLWSpGcNuvZ/jpSEAYHvUm8+Lg07bMNHMtR7kjEIvihSelBe20oR/Ul9rhJgk9VfmwcNtAV80bym1bwO3khmJkJv72GPznQMxxNJ02Ko9tr7Nbp7ssqJc38SMDI6l2dCKFvP9HGjyPXVCLkyxFVh4su5YgX4RKDmdYk6y48AW2JluFY8qo1Xe/UQn3RLLVuEAWI976xIgZq/nfdnC3T4F9xsxOh9oyykUIysjHJQO4rbxtfOrPFZV/9keK67QRFkdY9C6JykqIiNUZgC9jGAwgGGvueRmA/ta2e/Cb4MsaxWKseqSk6Pm8Wi0YwGA8TFTdhrAjViyoZL7DjKWz4As/CXVaEqfTbp57XLiAgkXEfTkWopOrHzokWowCxbHWhBRJpEWZJI3RsDHQv8Aa7WvXygTW9r4uxGF+Los8uTYaU2M/et/t8Q3GtFB6EN/FqsdewLFe3k3+xEXXf/Bvv9l9RuWoHLsyT8lsukxTJPUz7Y0o1M1UHVvGurHXQ6G6zj9AoyGVb+GiqR1nQ/UxrNcAG396d7w7fzSKpkTLiyQTmAWuRQc9/av1w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6748b2af-5432-4de2-e8b7-08dbe154b4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 18:50:13.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQZ4pL/Pf15JbuRMvkYfcF0CdtawfWgxFYKn6TECXUWVCbW1zhnLB3xCGcABXboN9c1QendhineuizmKagG67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090137
X-Proofpoint-ORIG-GUID: hQF5Qr_TLiaYu9W3vXDu6kEvH5-O3onH
X-Proofpoint-GUID: hQF5Qr_TLiaYu9W3vXDu6kEvH5-O3onH



> On Nov 9, 2023, at 1:47 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Thu, Nov 09, 2023 at 09:01:19AM -0500, Chuck Lever wrote:
>> On Thu, Nov 09, 2023 at 06:20:36AM +0000, Al Viro wrote:
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Tested-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>=20
>> Future me is going to be mightily confused by the lack of a patch
>> description. I went back to the series cover letter and found some
>> text that would be nice to include here:
>=20
> Does the following work for you?
>=20
> switch nfsd_client_rmdir() to use of simple_recursive_removal()
>=20
> nfsd_client_rmdir() open-codes a subset of simple_recursive_removal().
> Conversion to calling simple_recursive_removal() allows to clean things
> up quite a bit.
>=20
> While we are at it, nfsdfs_create_files() doesn't need to mess with "pick=
   =20
> the reference to struct nfsdfs_client from the already created parent" -
> the caller already knows it (that's where the parent got it from,
> after all), so we might as well just pass it as an explicit argument.
> So __get_nfsdfs_client() is only needed in get_nfsdfs_client() and
> can be folded in there.
>=20
> Incidentally, the locking in get_nfsdfs_client() is too heavy - we don't=
=20
> need ->i_rwsem for that, ->i_lock serves just fine.

Very nice, thanks.

Acked-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle.co=
m>>

--
Chuck Lever



