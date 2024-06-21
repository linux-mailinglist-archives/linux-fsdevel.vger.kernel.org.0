Return-Path: <linux-fsdevel+bounces-22101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0769121B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8681C22144
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9900171E47;
	Fri, 21 Jun 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZV/J0xJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QQmVjub9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820917106D;
	Fri, 21 Jun 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964444; cv=fail; b=Y9edq4K+1MJcEEjEGEJSlt2bCCU2mEGUT3pqf3+2BokF+zWX+sRczd4LpcDTWz/KCT1QBMJHMe/SrKzgZXdaXwkfoMFwhj+Gt3kCdtqV/BqXQXZ7vXFB/lT+qIvKnt/wH2hJ7RH6zJhgm67sM0D3Dv60cUOhzg3wz4NvzEXjVz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964444; c=relaxed/simple;
	bh=GG1e5Fl+BNTKRdViUSAYYz/c0SVz9zdybzXKdAiBcEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmEsfVtspUSKBH1VXFnC8fhD/7o0CgzBSWDbfoDKvhxJCIcpkbDe2aVr5UQrlgVz12sZAhv7JaOQKmpEOEX2VB1btRXLDISsnsc87Y8wKO4ngyx0a/t6qPQoF9A0mlRgMVPDKQQNZ4bU8TjAuFwF+t3VcYeJy5wpEqJjyf0Nfjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZV/J0xJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QQmVjub9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fP3P018883;
	Fri, 21 Jun 2024 10:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=k7sYp+nF8Sim2/j9sZS6qHhfQVk5MUQg4WmJHATUNW8=; b=
	GZV/J0xJBjIsoQUGOnP3v6aWJoTY+j6vThHKhuC+kECjfy7BcYjt1Awc26Bn/Kkq
	/SRAPthNy/vGlKPvbC4FFK7ZlRp1MROv5YCbP7DVHfLFyV7aQMkDxV5tt3mM1tiU
	VNHdgfdME3spXr+jJ2kpCtFMyAknI1y9TC6kS41HETs+KOCij/4BE0L3a14+gfcx
	8Dk0MCA3uJiKVcqie91c3k+v13VC75pWFHazy2qmfC8aVFKkRFoG0K3XkRasoksR
	GA9Wz/+tvQenuamisyAxAhoVpYXn9kGcsyN28cIRGj25/JkhDWCrEeJuVPWzmiWG
	2LNSyevnFX7wABT4gWhLqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfseem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8MZmk012854;
	Fri, 21 Jun 2024 10:06:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4er7h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW6R9I2WX6CZv0KPfowVAWX/8srPslDFuiUzXkx2A3vyPctLhu5JzUew4JjdmDXf7Qvh2VRUjSZJ+l7E1BxT1tf+uCJOnjRQwYo/8Tp2LIgufDs6ChO/4X2Hf/N19DnuIoZQWimX5/o2366Lw1JdSLDbCi5T2HXRBttcBoS41NlHZEuvZA60BK+qf0VQxRuurrOGnrrKXD/iqLfxxb7P7y/yiZP/QD6S8tgfx+u2Sh+zEGfdrbjOwZx5FaIA3mx2VMDXZso1MqHfXFf/GaP1GbxhuBfp1YNkw1l0tiayMfanWOGlB70/2aG/47U1MX2KR5ZNx+bUOGZ1RfPc5gNApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7sYp+nF8Sim2/j9sZS6qHhfQVk5MUQg4WmJHATUNW8=;
 b=QKQ8MFVDDSsjYUYZM9UT6xRSzW7EgAqgGcH5gnECF64St6gN5zeEhobEqqjBkWx/na66/zFGFUPyiDuOG3fuMJDcnivHJR4FjWyra8zNEDqfDYDI7X5DIsC3zkGdgjqh7F/vEwcf11bUa7D1TWvN+otqhvfQ54WYD0xaK9ljrlNX6GX9oGE9XVHUN2oNFjws/ReV09WlasgUVHK03TIbz09XLotMEzaaJylK5brTw0ayCSJM5u+4ZraAmuxZ9ccwv7SYVo5eJ+34RP0HntCcvAuk0MSIvHd67lBjlQiCyo1Wg3WAdwtfAjIHMrWVYlEL4NdK91cs2Ua9KkV4hoGgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7sYp+nF8Sim2/j9sZS6qHhfQVk5MUQg4WmJHATUNW8=;
 b=QQmVjub9C+AGoQq7ZiR3UE3d6q6gNCkIz8Pbs+oH7IXoh0XrPbfGNJOrD02PvioI1NaXLdb1A2jUMgwJopOpzh0s/yBJYCbbBzuwvOAyw2+ztYMgenDADBiDLPufEbe59VYU69KG2Ua+FZUHQlGaWOIR70p+a9sA38eZysvtlaM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 07/13] xfs: Introduce FORCEALIGN inode flag
Date: Fri, 21 Jun 2024 10:05:34 +0000
Message-Id: <20240621100540.2976618-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a796d16-2c4c-41a1-9571-08dc91d9c715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nwI6OZPHHZckR4KMGcbalKZBqh74MKHJ1682kXkTZD9Lj0g5qFU945gfC4/L?=
 =?us-ascii?Q?SQ7rVw/O4jQOzehdy16dK6NaKGm7+XqHbOpLhaMIEflafvvT1SwtylJdeo7U?=
 =?us-ascii?Q?DrHNuFF/nTYP4SSOc2O970Tq2PAEVKnl6qs/nyjL9BMCbZyGk0bkVS2DJogs?=
 =?us-ascii?Q?3wHftOnzVpF/v9+B+igI9x0nUroLvjAkw1hT31Nwjhtio4fGVprrantkKnmv?=
 =?us-ascii?Q?Nkc28xlv3Jo1oBo2tUzC5aqd7tOUfbUlMky4t+0+LfKj8M2rtnzcVdv+e3rL?=
 =?us-ascii?Q?1hwopgxyrnCuI0mQn1rnrzy3HKucNP0TlIRAE8S214oUBfEzL2CyiDb1dUxQ?=
 =?us-ascii?Q?mopEh9VSmX8fhUUEaQynQpARZV0TAIg8Rsb766wJdx+UxtvIUSAOd9yn1kKu?=
 =?us-ascii?Q?0n18F/rdUMZh+PiwRlT2JhLfHqB2bpMSzsfS5YHAy4SyVKFx+T3POPzbl/KQ?=
 =?us-ascii?Q?+LFi9uRFzW8yNr1pIF4YN4FvjmZ2i0jMKmkexdEGef9h4Brv+a7EHF4wiqrY?=
 =?us-ascii?Q?CTPjOO6Acj0o3S7AB1PM3DocXsfoD4X65uMexWBK0XXu290sb1CtkuAFUv1y?=
 =?us-ascii?Q?LozmSJqq5YCcoumMjkpGrTY2/aqXAkONfpevf1YWDyQdYyaB421krViNbsw4?=
 =?us-ascii?Q?A0CH9Zj0bo8EANAnWr/Fhrq8BTOS5oo+PsgRoD1io7rnDVsThJOwxXm/hS/h?=
 =?us-ascii?Q?whHUeRCCKeHX9VGwzVLxXSbnjVJUbJmd+iO8EFzNecDgGPFfHKvNvAb1Hm0m?=
 =?us-ascii?Q?OD+t7UnM+bqIDIwEpG8fM19HyHGIpUoJqeLmfyHjDlT3BBSVtBejoCTeaA7y?=
 =?us-ascii?Q?CVVWf+salFE6j5X7v13dSFvv6uD9fD4P+y60FQMylVjIuD0TGc8y/2pq+A7A?=
 =?us-ascii?Q?EW3Ekx7EvDwj1rf9dRpAALlf6QqEJRqRHuyIUgnY7t1mFHwnp4K2p18+or37?=
 =?us-ascii?Q?nFlzgKg3bknKVK5B96vf/kD/K6OVjiDqFu0Exw3whDGZvuYEHfGMtAh41g9T?=
 =?us-ascii?Q?Wqwgm/p0m0qLtXMA9OL2EpdLcxH37yvDMjO3MGsKpRboTrLVGJQxC3NSWUjU?=
 =?us-ascii?Q?b2SBvKIoPux5le0tn0LAdUDzUSox9k3kmmCj1kP5/OUJoJU40E9vxEzwAEAS?=
 =?us-ascii?Q?zxAgVVhcmoXM5MtT7KEEZg9byAdneNjr4Q+yWo6K7nZvRP67iYcCKYQyziTE?=
 =?us-ascii?Q?PPZnCTQyaEc+RDqBASPxmpPswIAUBmD+qfMNSiKsnarthte8J6hwGCoRW3Re?=
 =?us-ascii?Q?FYKLRT2n8AwOwcsm6EUdGqI5TSSVXJP0JDHChp0NOUONoIAnQgyYC4pDJqYi?=
 =?us-ascii?Q?31NR+hN0FlhQfjTZo8hfPwIc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OGSkm+hZWqqNyYoQnaRfBsU+pbNN8ogHzba6kTtJ4iYNQaS27dCJLEtxM11d?=
 =?us-ascii?Q?moipRBapxMOaVNb+4CKq2SjFtiqiR+Fm3l3wiTjdtUFYSSYlyYqe3e2EG6ai?=
 =?us-ascii?Q?c2HQFNxngp34oqgEXjteaNq6llPccFu6HMeduFW+esDdFKmm+noBQ+qiN3JF?=
 =?us-ascii?Q?xdbrjFFVAafYSpTpiC6gha/u65xe/klzO8nHIj48ovVnA2moFxi31rGksZfo?=
 =?us-ascii?Q?sP6y8B722v+H8kPhs2MtIQDxX1H0tyxcZY1mXSCE1aNkQKG0HYhU8gOzIHlW?=
 =?us-ascii?Q?aCgWyMfVbUpXmymWrH0h9nzVicQTYlZPgUpRHwMcmeedXMmm1UIJ1g+sQVvp?=
 =?us-ascii?Q?aeXYgJH2FacHTIueC63KzaAmAl3u7fyhnEkr7a/DYFPvv4DzCMXJ5Pkspyye?=
 =?us-ascii?Q?7tejSzaRqXJ6QU7z+7yZNHdsDjCOMKPNM4BzxQ1ejMCFtth/abCErbXuXhqQ?=
 =?us-ascii?Q?82xxXqn71jBxU2qaJIwR2rMfaDh/am8xmJfr936cYkk26Cf7z+4R0XdShJio?=
 =?us-ascii?Q?uzWRIYZAKl8fdWoTJbLHZJLSQOnoV8aIvOgNjRRXpiAaxFpJgyrK2mS6Pb/I?=
 =?us-ascii?Q?RuX+KpjsljW+trVcpctLY8o9QeaVA9ABGlcyUPlJPqui18dimBoHizlYR3Ss?=
 =?us-ascii?Q?ax4fsbEPC0yVp6Ewud2jyp1VwtZ+B9Clk6kO/FmtJ/3uq1LAW8dZZgDvPEMN?=
 =?us-ascii?Q?xHPfSrWjHt7jcW/LyRUssC+0/rvtUkAqMtfpaTSIZWkUiDg09luOYsTkuYkE?=
 =?us-ascii?Q?TmqZCHRZTGsfMFzQ0de2mcw7JA2Dwfj+mLz3Q7PMqcq/bVoRTIPMGGNPkFKF?=
 =?us-ascii?Q?yHSijYerTtLmMkFtEa83N+Kz+THl9viClyuFF4eSwIp5STdfPHG/eJ2uETYc?=
 =?us-ascii?Q?BQ8NKWF9k7pY2In4b0zvvON7Ng3jAkQmnNFwhnhCoq9ESfx2JZh76Mc4vvzT?=
 =?us-ascii?Q?vCWmEeB96fXrtavAFtzYUpkCDacnBEt8kujGFkiOTLEVnrijHSQ/CQF2tgcB?=
 =?us-ascii?Q?FQ9pHvrKmi9faxGdIRFVlKCXKmUEpm7K6D0ewWc3m35IvGBWJ0RGQabjg3z2?=
 =?us-ascii?Q?yf11HqH/hstH37IF2XAByF95GZ6fa6wmsoVVrYZYJifzXd89xo/A129xyGLf?=
 =?us-ascii?Q?aAkqb1cCwcQGegSnY6qaYaA0eq+LCfc3ZiosZg4KH7JW7Bs0msQ9KHdTELpw?=
 =?us-ascii?Q?0ZjJwbPEQs2z4YS+ig32i7hUjFe6Am4LNmyJy+HojwCo5kTPrd/iuZAKeBOL?=
 =?us-ascii?Q?Cm4bdiV3okIlzHhvX6+rhhd7cJZQHN+8QW5Q2+QVvYAtCtq4cYiJK+2J7NkC?=
 =?us-ascii?Q?L7waCC4rx1K9MQf599MW6pnz04He3Cbn4I+Ls4aQGwihpSLy4U/ZOckLte70?=
 =?us-ascii?Q?gVtZY81lIyK7iRv+7qF+0RWEaUNU5KDxQHX1v4DGukfG+POCXVLb15GWpq2Z?=
 =?us-ascii?Q?97Sd0DWGiTKdO4XRxgGkMTRZVrPBWgJCj71LT4kH+mv1MQOAwtYuQGgQjJg+?=
 =?us-ascii?Q?dv/2Jt6OeRqrXdF6ECIZQgrC8D2ItmTRYsGF4t8ZlDvylFQVvQ1m5cRsf+dg?=
 =?us-ascii?Q?LjCTWXv2aezamiJ/4xvV4grZikjttV9dHXr561SmC/2CB6EabXaMM0MQsckO?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lwwHqXJBtxVbg/Dk+RCib7r0ziT496jPiCfkoZLa7S0ii6smvjVbauGszb61mwg0PCpK9wiIwfU8uH8O0JXOT492I1S6lMfGv1q84Dj9N5ohdu7j5fKGHUddrLQ9lGUsyPc1GwPY9CRhcCgzpjJo4z0udb9Fn5uatNnlZYOOcKpIwwMyr3OM0nj8JSNd44z9DpvZJ4SBbV8+5viITTH71PBoMg8ocBDC9qwVI8fF8Y90Q8CfuGjplhmD31bMtZwgL1b1pXqjTlom5XM/JQ6pmneLInaPD0IXeKGPaeNtDa+PsBZRXncNtmGnqSiBUitUubFXiRNr8HVO5WKWEJFuvog5tWbvBqxnJDAdnTagKNl0QlcAsvnU2Vqa2iJF8gn2uG0EF5+F0Gn7nalyETkF2lsLb+6i9cF0INRlyj5Q+ZpfKyikY1A4q/ow062GY4NMHrMwE2msqFLFUtkeDUEj8rLFDaGBL0CTk97n0Ug4hsGVNDOHOB9iFeoRbCzyB6u8dkim8UhDBivKElckWhtL2UzcaWpA7xUwYG1C+j2sfxmvqFsCgvhsI3Ey9WJxca85a86wfnOnovGfyDdwy6Yt2Ni7w0SXrf/Veol07b5xcNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a796d16-2c4c-41a1-9571-08dc91d9c715
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:11.4667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1qvnKxis43ile8apkdwP9WZEdxId0MTrk4ObPM5yVhDtZrZHC2YszrnkI1MuTZk2WgvHP4GfTuqlfvCts2ZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: j0xuMG7hRhqlRBoCn_Dkj3WzokcLeVKu
X-Proofpoint-ORIG-GUID: j0xuMG7hRhqlRBoCn_Dkj3WzokcLeVKu

From: "Darrick J. Wong" <djwong@kernel.org>

Add a new inode flag to require that all file data extent mappings must
be aligned (both the file offset range and the allocated space itself)
to the extent size hint.  Having a separate COW extent size hint is no
longer allowed.

The goal here is to enable sysadmins and users to mandate that all space
mappings in a file must have a startoff/blockcount that are aligned to
(say) a 2MB alignment and that the startblock/blockcount will follow the
same alignment.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h    |  6 +++-
 fs/xfs/libxfs/xfs_inode_buf.c | 53 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
 fs/xfs/libxfs/xfs_sb.c        |  2 ++
 fs/xfs/xfs_inode.c            | 13 +++++++++
 fs/xfs/xfs_inode.h            | 20 ++++++++++++-
 fs/xfs/xfs_ioctl.c            | 47 +++++++++++++++++++++++++++++--
 fs/xfs/xfs_mount.h            |  2 ++
 fs/xfs/xfs_reflink.h          | 10 -------
 fs/xfs/xfs_super.c            |  4 +++
 include/uapi/linux/fs.h       |  2 ++
 11 files changed, 148 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 61f51becff4f..b48cd75d34a6 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
@@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define XFS_DIFLAG2_FORCEALIGN_BIT 5
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index e7a7bfbe75b4..b2c5f466c1a9 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -644,6 +644,15 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
+		fa = xfs_inode_validate_forcealign(mp,
+			be32_to_cpu(dip->di_extsize),
+			be32_to_cpu(dip->di_cowextsize),
+			mode, flags, flags2);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
@@ -811,3 +820,47 @@ xfs_inode_validate_cowextsize(
 
 	return NULL;
 }
+
+/* Validate the forcealign inode flag */
+xfs_failaddr_t
+xfs_inode_validate_forcealign(
+	struct xfs_mount	*mp,
+	uint32_t		extsize,
+	uint32_t		cowextsize,
+	uint16_t		mode,
+	uint16_t		flags,
+	uint64_t		flags2)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_forcealign(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISDIR(mode) && !S_ISREG(mode))
+		return __this_address;
+
+	/* We require EXTSIZE or EXTSZINHERIT */
+	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
+		return __this_address;
+
+	/* We require a non-zero extsize */
+	if (!extsize)
+		return __this_address;
+
+	/* Reflink'ed disallowed */
+	if (flags2 & XFS_DIFLAG2_REFLINK)
+		return __this_address;
+
+	/* COW extsize disallowed */
+	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
+		return __this_address;
+
+	if (cowextsize)
+		return __this_address;
+
+	/* A RT device with sb_rextsize=1 could make use of forcealign */
+	if (flags & XFS_DIFLAG_REALTIME && mp->m_sb.sb_rextsize != 1)
+		return __this_address;
+
+	return NULL;
+}
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index 585ed5a110af..b8b65287b037 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
 xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
 		uint32_t cowextsize, uint16_t mode, uint16_t flags,
 		uint64_t flags2);
+xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
+		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
+		uint16_t flags, uint64_t flags2);
 
 static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
 {
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 6b56f0f6d4c1..e56911553edd 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
+		features |= XFS_FEAT_FORCEALIGN;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f36091e1e7f5..994fb7e184d9 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -608,6 +608,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+			flags |= FS_XFLAG_FORCEALIGN;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -737,6 +739,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
+		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
@@ -745,6 +749,15 @@ xfs_inode_inherit_flags2(
 		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 		ip->i_cowextsize = 0;
 	}
+
+	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
+		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
+				ip->i_extsize, ip->i_cowextsize,
+				VFS_I(ip)->i_mode, ip->i_diflags,
+				ip->i_diflags2);
+		if (failaddr)
+			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
+	}
 }
 
 /*
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 42f999c1106c..536e646dd055 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -301,6 +301,16 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
 	return ip->i_cowfp && ip->i_cowfp->if_bytes;
 }
 
+static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
+{
+	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
+}
+
+static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
+{
+	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
+}
+
 static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
 {
 	return ip->i_diflags2 & XFS_DIFLAG2_BIGTIME;
@@ -313,7 +323,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 
 static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
 {
-	return false;
+	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
+		return false;
+	if (ip->i_extsize <= 1)
+		return false;
+	if (xfs_is_cow_inode(ip))
+		return false;
+	if (ip->i_diflags & XFS_DIFLAG_REALTIME)
+		return false;
+	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
 }
 
 /*
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f0117188f302..5eff8fd9fa3e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -525,10 +525,48 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_FORCEALIGN)
+		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
 
 	return di_flags2;
 }
 
+/*
+ * Forcealign requires a non-zero extent size hint and a zero cow
+ * extent size hint.  Don't allow set for RT files yet.
+ */
+static int
+xfs_ioctl_setattr_forcealign(
+	struct xfs_inode	*ip,
+	struct fileattr		*fa)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (!xfs_has_forcealign(mp))
+		return -EINVAL;
+
+	if (xfs_is_reflink_inode(ip))
+		return -EINVAL;
+
+	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				FS_XFLAG_EXTSZINHERIT)))
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
+		return -EINVAL;
+
+	if (!fa->fsx_extsize)
+		return -EINVAL;
+
+	if (fa->fsx_cowextsize)
+		return -EINVAL;
+
+	if (fa->fsx_xflags & FS_XFLAG_REALTIME)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -537,10 +575,12 @@ xfs_ioctl_setattr_xflags(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
+	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
 	uint64_t		i_flags2;
 
-	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
-		/* Can't change realtime flag if any extents are allocated. */
+	/* Can't change RT or forcealign flags if any extents are allocated. */
+	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
+	    forcealign != xfs_inode_has_forcealign(ip)) {
 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
 			return -EINVAL;
 	}
@@ -561,6 +601,9 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (forcealign && (xfs_ioctl_setattr_forcealign(ip, fa) < 0))
+		return -EINVAL;
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d0567dfbc036..30228fea908d 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -299,6 +299,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(forcealign, FORCEALIGN)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 65c5dfe17ecf..fb55e4ce49fa 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -6,16 +6,6 @@
 #ifndef __XFS_REFLINK_H
 #define __XFS_REFLINK_H 1
 
-static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
-{
-	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
-}
-
-static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
-{
-	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
-}
-
 extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 		struct xfs_bmbt_irec *irec, bool *shared);
 int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..852bbfb21506 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1721,6 +1721,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_forcealign(mp))
+		xfs_warn(mp,
+"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 45e4e64fd664..8af304c0e29a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,8 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+/* data extent mappings for regular files must be aligned to extent size hint */
+#define FS_XFLAG_FORCEALIGN	0x00020000
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


