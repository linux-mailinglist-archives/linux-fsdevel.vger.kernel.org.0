Return-Path: <linux-fsdevel+bounces-35792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FA9D8601
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E502858E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0101A9B4F;
	Mon, 25 Nov 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmlYGvSo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WWKrULfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED9567D;
	Mon, 25 Nov 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540299; cv=fail; b=tnCc47UdqohM0H2Nv2lUbCErxqL23WCcn0w4Mr+fAJeVI2kqYTP4Uqx0udywg2vchmz8dGDyAm7qlmznDap/WH1tDPHeS59sxdjZSsaV6T6UPFow2yMIX2gracBcgRJtY6Bhrt4mIQ2PXOPmLMnXLoIzIcWwSMm0cL0ctHKlu8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540299; c=relaxed/simple;
	bh=DS+OfayhwQWXAynH939s3eU/rtpLOfT3vtIn4mjMPjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phYXxAL7sJ7FmqN9f9giEcXEH/7sJWQBlgj0Z9BlVYBLB0MnsgvPZqeKRXuTEpnb5lMvGU+fCOqRiEcWUuRK3pbsieSXSZvjuKaUBDMjxpKYXZWZ+CutCXGHm0UxX/ROyMpAupjblfbRQA7q4xCXyo/5Zwv/ZHE4WgteLcKsjds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dmlYGvSo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WWKrULfv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6gN4v011384;
	Mon, 25 Nov 2024 13:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PZZbE+CEXBKfLXcUbP
	FW429xHWmUkrcbSs0qI1cQqAo=; b=dmlYGvSo1TFosd9JUbh7fC3Tb6fgjoEjcN
	FtOqfb9ghizVjG5P318Zf7Ec39hUwcRLHDwqF3jNc+TB9Hnmkz2a+ALMrK30kjTM
	h4KjA00MIMiYWtXks9kBg9ovW9lNzNCogYjgJt5GqL2OkXWxbQVQhOSSbzwr/9GP
	YLink7cWqOCEBJSpLZB1ivG9sswqSEXlgX5vnWtgKW1dZg/IfWEL9NVpL/rzocBG
	kqE2/qGD3hMbDUmMkaX8oOm+D+TdkXkG26LFuWL7kj5PmBZYo/gYaBbDxYd8IgaS
	WZ/oAWRjoEInGxAEOUdnoxGipDp7B4LOZHDiU8fVSiPDCGHEn2+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433869u35k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:11:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APC8qws004525;
	Mon, 25 Nov 2024 13:11:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7fbfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2o8gJsjyWUATUwV/VkFkCun65mC6bHGhz/ancMFDNHJW6JZbUVXHIgWoHrxEyRxMF3VbdHLKsR0pQhp6S7vCbcxqk2v5r6dUPrEM+n6ck2PKaNgA/OSqqeHwYBry6Pp1jR1H0OrabzUb+GPibelHeQJQa+5Ux5069oTYkBPyg50wJ8nSxW4i4zeVBL7ohoUWLxzhsGWg2zzLxBo30aSssYC9vKjk+YypG+t+6MqzMO+U9LKNOS8YYjWc3J/MIxNeZkFpqgI8h20kCPoV6K4CGhV3AQ9C0ev/rH6PBJ/p54Suz6NwTZIW1atkTGqAvzQSMQ8rmnLw+JOf3vOIw8qMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZZbE+CEXBKfLXcUbPFW429xHWmUkrcbSs0qI1cQqAo=;
 b=GUE3ypvNnNtwlTVlHM3Kr1druFSLhrXNRsEGWtlWFMLHX26rHN3YqW6urgKqO5GkG6dclLPNwdSUQ15cmDtD+eak2tzhHgSz+E9O9TzZy4lWT9sI4hf213GjsCuPaP1XUiuqneGLDaB3E+X2tTsohCMEMWdOPT08WpI2lMF5z+ZypbYsI/0HeElXIpa84JercOfoDeUvYNKXb1sELS4EcqI+ygY29Be1/eqfSL3nVK61feBCpW5I3COl/k59V3py45xEBjUValGkGNYS+cnj+b8Ef1DSXogSUxm8wD9xLuCQRFM6w/XP22c5siFqGG5hzs2Eb+bNennlr0PHkFgDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZZbE+CEXBKfLXcUbPFW429xHWmUkrcbSs0qI1cQqAo=;
 b=WWKrULfvpnw+rSmkcsf2t5uixED7FwO+mBJBIXyJWzZxWnFGpKYbGpyQzRnTxS9LauoKVq6SvPnsOBdnNewI0rSRLF16Lj2fvBu/dnSeBEKSOSZ9lSjYCoJkRMF/msIf4LKG7lNnfG85q1nRs6SCB9AuvXE8AdVEIlo0ogVOVow=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 13:11:25 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 13:11:25 +0000
Date: Mon, 25 Nov 2024 08:11:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/26] nfsfh: avoid pointless cred reference count bump
Message-ID: <Z0R3ejIMKnX1tmzc@tissot.1015granger.net>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-16-f352241c3970@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-work-cred-v1-16-f352241c3970@kernel.org>
X-ClientProxiedBy: CH0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:610:b3::33) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: c011d4d0-ec03-4ea2-7000-08dd0d52aa3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C6dyKpowexQh2+a9cEhqTJRiCMhr8NMMGndsckkZXnwZ/CKaHb9+/qGcsB8P?=
 =?us-ascii?Q?wt/y32CrLTl+rRPxpJ0yG18kV6HJpaU5H3eStZbskxhKed76rP+NUOJwQX2c?=
 =?us-ascii?Q?G6Td4P8dSeYFU11Vggz5KOusB5FflNmqFPHmzEkzuM7h0Ef7CuIufahLq8D2?=
 =?us-ascii?Q?P/69RiQWVVc8qhJwJrlE0LuyNzXPvIBB8wLU3qmMVRMWiT0msxqr8YBXI966?=
 =?us-ascii?Q?LEo30RLpNg/kh7uGkR797q/DBszmM1tQU+YZr78sgNxU1j5BkM6yMJqCRCHA?=
 =?us-ascii?Q?hbGduSZVR4AtTr8awIn0GzwIw36yBxPdJDe2xfwzPpC8XOETBR1E+nnDwcFw?=
 =?us-ascii?Q?fl+dqH9V+05k7kR9Wa6msoINWL7EoeCPyNhe/+svL7Aca+uipcblSwkuLoQQ?=
 =?us-ascii?Q?q6HHSlixHwv1rywfe2vGg3molQTSTH4hCAbloQJXPxAqt+bU+7pVcSCKwCjo?=
 =?us-ascii?Q?y9qd9gcWhL2Vd9fBR36BRBPValp+3cLcKt/c9sZzfPcfgNmUvNAe+fw2DEkL?=
 =?us-ascii?Q?MjWhL8dJLcZT+M/O4C+blZ1MP1isZM7J5RkwogakmqQIyUbuCbOc+BaYhE2/?=
 =?us-ascii?Q?tPxZGmJ6MV0vcrfIruvbvX6ropyE0mxrlgbEKnfoQvzAwpZjhlZpmyGRGY/L?=
 =?us-ascii?Q?UzinVzkMw1EKaO5rTLTbrWo8/y6zuRjseIDInZ2TspAsdpjGAH98Ew9+LhdN?=
 =?us-ascii?Q?dVyLkO1JvSMkAYuC8VN//tfRZ3DAzpqemp3LcQrdVssKE3jur5fvXkZgwEqH?=
 =?us-ascii?Q?VRJdlg/fAFhzjYIbbbbUOgLWO6G4Yj6I6ihuz+/ntGtwVlL13vftDNgQttIL?=
 =?us-ascii?Q?pyre62hcevL4CvrwPypHfAEdZk9XQ5ovVjBjlZMJDQXZ4betcQ2IHRjTMqpw?=
 =?us-ascii?Q?d3ijOy0loU2xlnzQSlYBOXoeUJq1cp46faMT5YQ2o/HC+PHfMhmQR81BeydY?=
 =?us-ascii?Q?o5nqvYOszGyLednbA0kAbwOOc5+ZL4WU+xngKtEF07plJtyulnPV9QzYofpg?=
 =?us-ascii?Q?Csdjm8CDWlK8uaP/6K4AtAPuhQlMYsdwcWpMY9hXrv47euF/F0TXJbZmveX1?=
 =?us-ascii?Q?KxKm6c+t0Hl1jrANqpYfhfbzqqy0JcjDqVU1YonagCB3E3LeoOdfI20i6JUn?=
 =?us-ascii?Q?1vhgrV7WTmw29FZs5ho9e1f9n8vzZDs+hkvnOPInEXeUz+x4JwXAP60Fk6OM?=
 =?us-ascii?Q?KsjB2lQpCPlPB2M8nRn8zGVEH/5Mtf8nihs4bumReOu8l27za5JHbBsAuyia?=
 =?us-ascii?Q?bc0AH12v7AnovTae5J0YleA9m6Z3vIHAd8A7fxUiQ/Y/PAAHIO5OIEMGo4t9?=
 =?us-ascii?Q?Q9sBLezBFm+DsFEbuBnfdWF7NZpvR28q+zRSEtR8gQwD5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zag2j3E98S95b025T+fZYVHkylpR6ua+ViUOIejvXIFd1Zsv4atM2wWD0yF2?=
 =?us-ascii?Q?0GIqY4DknUlYRdPn6ECW6WGATJfTfeC/azSgiiZzHG33VtCI9ADiQnm+w2uV?=
 =?us-ascii?Q?JUB1rFCfAs73/wel5hWTQfIIpL1l3iBdHz1/KjwSpFwjzOdqmkfbQJ+X36Dc?=
 =?us-ascii?Q?bi0aADs1EEcHZYFDKrYBM48dBuAfXPY76m5grg/crQGOTgbVVDg7+VDcrZCJ?=
 =?us-ascii?Q?eeaB57HhRLW1onaRNUOhE+GfDN48DeRRbnFtcS59Sjd+M3Iq7MfmRU8uNLEg?=
 =?us-ascii?Q?CUlwPdxFVoOXnNgS6jrMgTMaRuYXQWYJdZ0Dv094WVI8qroGoZTum6VDjZmo?=
 =?us-ascii?Q?nyIYCqaaFi/QuVvnOTZdcogYvXV1kD6rde4dAi0pf5Nb2Jxp+tqZbtoFcfuh?=
 =?us-ascii?Q?dv01D4hZymUu8t3jQyeP1y/JvTUkMQUfht5OYLyzhwk1dCoFvWqFNh2TSnzg?=
 =?us-ascii?Q?nZ5SncST7qNForzN8T7O4aZKtj2QA6jUpFSzEesaWzGqiOWF3CbeuA9Yww5g?=
 =?us-ascii?Q?A4JCxzDSUaED+jqTHYx7X0t3jx+ZviYhKxpvzahw80PWpSRj4ZLtO91pJqka?=
 =?us-ascii?Q?yWBvKV6y5O2R47bD5lATudKs6QCoxgC/i/1nOwPzcMeOm9bS035PWsW3FBf7?=
 =?us-ascii?Q?M3c0VZwPLltkBrbZgYhf+ybgrxVmZJj3IwzwLRYcF2LnmAD8UEZfl2NVoFFJ?=
 =?us-ascii?Q?1LfmMKy51lUjT5PulJhQzCcTR7eMTVZ7SJgoDhHaYATnUAExFxK5nwg/Esuw?=
 =?us-ascii?Q?4va+UFcv7mVwKQhWYOw/7wcWSFslUN3Nvt8MAmvBmKWkiuuZuAUZGfetbw30?=
 =?us-ascii?Q?SIzJi4uwKDSzwPrgRbgCyhpiASXkRktIvOTQjk2acv+ZqvCUznFKfqspgiFD?=
 =?us-ascii?Q?E84Aju4bXI9bizMJm0Ec4aJOjWTwOUXtfo1cet1MqK5/cBuOUmxM/WRToWho?=
 =?us-ascii?Q?AQiK/K6fmRwtWzpvDJnV5xizk0Ly/DQqi/vXtYz88s9ro3P0H0b0Qb1x/iyw?=
 =?us-ascii?Q?zFRfS0ZUph+Xxbfl394LgmozZVHHmPa+Z9ya2h93XReE571ndEOV7HrA+/I7?=
 =?us-ascii?Q?ZxxCI/QVih8LEIHZdlgE3L7NObB2x8zBzq5WQJiV53iazFvRJ6KNQCyfjKN/?=
 =?us-ascii?Q?YEuAhPb5fXfQBRqASiY/E6WNg4s7J9cXjfTp/SWAMfUiY/2ej/017g6Ryosj?=
 =?us-ascii?Q?UzsW6x1vgrbD0Eiy5/wuBhr12bgIBuJECTOHCAeobNJzOMzi07x6XqcC4LJ7?=
 =?us-ascii?Q?VKZA93YG6Z4DD0+dTQER4d9pRHMLadEKY44webprO8VsyU/7t3c/XZH+Z+/U?=
 =?us-ascii?Q?WqICdGooaE2W93qAktRtcZtnrRdcDSoY2WI+4/QBqaxVHUKKztGz5AR/0mMM?=
 =?us-ascii?Q?BdEv9MRZmX+RbyMVD6gUGFgMfCoUvZvMoCNleS+DzdY4VuAPA5zsvovJrNkG?=
 =?us-ascii?Q?36pF4RbjOHuzN63raa4IqiUaa1tuxdpfJcd55Dy0522Nt4QX7v5wfBCDBaaM?=
 =?us-ascii?Q?cg+cRxU0U5sy9wt+jAnRYKrpwdJrP3+V78JSAWG6F+QzerGjx07bEdnfiHYT?=
 =?us-ascii?Q?iKVNk06h14Poe4Naikcz6hCkt2+IMoLm8EASJu9f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ED1TWh4eG25ucKENAQ/Wb8w7grz7GPiqKFGw+W6NoPdvf7grL/uHLtxXc3cclsqauq259inTFb0bpkEUKGbK88O3dsMgEBaH3SmikviyPPOTDzLy1TXEebMhQunKV6fcpwMo+nH3NL7DmmweoH7f7FkbUKEC+aZTAS0fxjjCij7j72e1B3TNhPG40kwl0DdBma0tJmt9Dftc51DHwdbB6IxEc4jegeCj9rXB3KEkknfOwEaEmRfzvNJXy+4WOcVr8Z1OpXBlDaraCAyz4C7kJ+1A7VruLRoEVbuiPQmn7JeJY8MiFQGnmu0wMAinTN3R9elcNR5IofQ0HdwcJDbm8zoIk1Nrye0bWtZnnk9Yp8wBn/W+3SnBFDQOEG/a+rtYn0FxAn6n07lQZrdcp1vI7dd15g+SlQ+1eBPuiEvGQM/gVLWRfrcevd3D1+baBePno820wU7eYjvf26ENZCfBj1uo44lStQvwQQXIZLwyEmXTFBg2n7YjDE2QrKVnupdkLPQSa5nmyCPioK5wUiz0h16m+E1bXOdKthknUGb2vPRRlLAE244QAwYma2/JdBdKWjtQC16lv/3LxIqATSGiCHg4u1w9gDYXYAUAilBGuyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c011d4d0-ec03-4ea2-7000-08dd0d52aa3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 13:11:25.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4FwdEuGV6Xc8x5JIB5E7HUD/jC/btzNEuoGEFGSy4WkeaYw4iGgTV5IWWNqM4uY5IeTUbKevg961EubUyRucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_08,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=924 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411250112
X-Proofpoint-ORIG-GUID: fSCGCfpNe1HCrsTn8nPFYK9zz30msDu2
X-Proofpoint-GUID: fSCGCfpNe1HCrsTn8nPFYK9zz30msDu2

On Sun, Nov 24, 2024 at 02:44:02PM +0100, Christian Brauner wrote:
> No need for the extra reference count bump.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/nfsd/nfsfh.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 60b0275d5529d49ac87e8b89e4eb650ecd624f71..ef925d96078397a5bc0d0842dbafa44a5a49f358 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -221,8 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  		new->cap_effective =
>  			cap_raise_nfsd_set(new->cap_effective,
>  					   new->cap_permitted);
> -		put_cred(override_creds(get_new_cred(new)));
> -		put_cred(new);
> +		put_cred(override_creds(new));
>  	} else {
>  		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
>  		if (error)
> 
> -- 
> 2.45.2
> 
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

