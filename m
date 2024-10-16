Return-Path: <linux-fsdevel+bounces-32091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7169A067A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E13B21276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530872076A5;
	Wed, 16 Oct 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2K8r9eC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M73Xhwvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6C207207;
	Wed, 16 Oct 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073054; cv=fail; b=l0iQm1L86tJK4+uiVKCfSHPJ4QAJXK8tdT741cD8SOGjwxWUJeHFJMJUBPYlxPyJlUmBdTRgei5s+DMgR/9K58aRJPVohCy3TkW32kNwWY7oNYdQmDiycj1nCt5Zdw1/A7I4tMQyGJvfIAy0FtSj6KrBmZPp9nkcYhno3g4LQa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073054; c=relaxed/simple;
	bh=EOxTGgWGNvSBh5KVqmsKi5I5eCDIe2YPdvjUuB0v+j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPEJVR9p9AZF0R+6KNNQnmzdqYNrQjq02lWhsMP7zsG4Oi6sO4s+8V3DLNoszt5yLEDenmcSs1Z08HRPT2fCDUncMS3pzuLkA165Xb4cnQeqm5CD2JwjubLJOZsO7tpcmVpUuMrNnGw/BRJIQK3EcVHzDDD9QIn8ltDWdUIAVkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2K8r9eC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M73Xhwvo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9tjDL016191;
	Wed, 16 Oct 2024 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=; b=
	k2K8r9eC+Xis++yP1v1x3BXoEgjVOKV2qKj4yBBKH0gKCCt6xbKoRyvVZv8765JO
	GqlG9in712e4P/HNb1EXA0NGXObOw5bIIRMpha/x0uS35BOgM0vucS8YXRtvTs0H
	brqncFxomlohE4Wv4ReIB3NRh+to2e4yU1Q0DnSfWIkJq+BUPU1uBt9g/7LSxDcb
	rq2rQaK+drLo14ARkPotcPuohW3/GtkXMDWwHEWOSMYfXEtab81iWo08COCrbF7j
	ZAZIDphsSmaILpqh4NTa1rgwD2eWsvbXJ+5L0ONKNUdusXKieOd7h0iurptPLBHm
	bQax+rs8NhYSeIQ3s5Jplw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7kd3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9MF2r026319;
	Wed, 16 Oct 2024 10:03:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8mhnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 10:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfEQVL9cuy85h0A+4+xiqJ0zUWenWBD1K4Ty0ROZ5RtzwL5CPOyu3XQpIGWlmkJYT39TaJWcvC9dvISiEE00D5w7m8h/zFWrJMMoC6X68gkH93t4PKQzMPkpVUU4iBSaKADzZOwOJUNE6Tx4Igy5n+H//EM906IpnKFeDnuyFDHoGS2CjMHvl70OiK2VAYm9OOthJL3wmSiIaE2jBv8ePXnpPpdIHFX7oM9HFhOmv7o4+fHue732BB4JlGx7E4oD2CyutHIr8FAfTd19WC7ipSfDi9oPu22m33PK/OH0kdqi0JCosW36ritTEAaihfIR39C/T5pJrzq0I2kNIRWXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=pKF2f77j60MQ9rc1U6et+Ncq7reVsge/07areZVudWgRoUUov8eR6HZEawJQdVVZpiNqYeJS9rCNJPqUpUGcr+51NbMyIa8d+IakL2FA3AHm7ffz9yd6dxn2DGXvqXp72rWK9i4/Rw+S8NzoNa4CSySt9b8Kk3q2umcmshdlHyZ4Fvgj0JRasyjHYUbKjORBixovKLZ6CzimkHWmSfZF1VH+cugDmyUwKr20pNqEIN3Brma7CIbCW7VkxJvppu6ymHuV2/HJU1T0+PVyCEO97Tt+YLd2aaKeXqx9H1WD2tA4Gaq94bDE3V3UBy6NeKJBKzM8siLMxuBBKhkqTtw8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwGjmoZ5QwxhepSH5fFJmt5e9UiJ6neS0UoagzexhoA=;
 b=M73XhwvoSAQEEHzFwckVS95+OmP2mW0AKnBzaOC4yrxhAOACCJMl3OGBYYitAX5e6TDSmQTnbzfXHPNOhVJNMKX4doh6lAUBrhR4lTBwGe14MGSeleRmu4kyEd7Wh26tZUeCGQVAuAXvs8HdDoshaNWf+knnzZKBjJEYs8T+zJU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 10:03:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:03:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 4/8] fs: Export generic_atomic_write_valid()
Date: Wed, 16 Oct 2024 10:03:21 +0000
Message-Id: <20241016100325.3534494-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241016100325.3534494-1-john.g.garry@oracle.com>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a488de4-5bfb-4472-cf7d-08dcedc9d6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gavx/gdtJdfB6RV3DuKBFbCST5Mbh352lATlgGqdzRiN29Zfii27ow2PVFS7?=
 =?us-ascii?Q?ecQduAkv39bjx/gZhNrg+WDkOFti1t6YE63ufhBBL57hJqn/TnHc/BbVkGTN?=
 =?us-ascii?Q?3RcWOxkvXz6jgIMbmhDk8vFjlPZNgjvtqrzQhPwscdyKpvpBmtMh40rPSmmn?=
 =?us-ascii?Q?aE6gmpvxa3+Qshe/zMt7y8ajzVDaVBrX9YGODh6jgSia71lOxfZE38HUZQ1z?=
 =?us-ascii?Q?rLKrf7LW9k+LdXbdpSoYJwPMRA8tjpQslFvsnz87h8rk16RmmeIlH7ivNCZJ?=
 =?us-ascii?Q?/XNfK+k1dbYztUc/Y1yRxjUOviXctpXhJxNSMoBM+wMaKo+fD66dXKmzyhy5?=
 =?us-ascii?Q?KM6a9RjMd+OiXvzv0etOsIMFmOMZktaXOfZi71Qeqzr7nMPbRUfdRdVJ1B4J?=
 =?us-ascii?Q?cqhAJ66p/W3uoFs9OTguA7gZYP/g9fPypbQYeRbVyetjeoD+T6Sj6/JGctNe?=
 =?us-ascii?Q?NwLo6oiccayrveTL8dEXhtHow43lWYXv3Rgpl5bwQ8eK5rN5k0eTkAQdtYfJ?=
 =?us-ascii?Q?454jv9AQ4ySXUMLEu3RergEuSZAYIiByNs0OLmMQw55ASQkmZd5OXkoH7eV+?=
 =?us-ascii?Q?JMuMDQ2h3yFNV9u+V7ErEH6VSiaUgJJ08816UOnQA82dSIrpyQv6fmFJ62Yz?=
 =?us-ascii?Q?+1XPaHOxiVkHLYLuL3VMZJ/jYsBQKiUVPUqh9mBUmh0uPV/FdEv6dKOScdQI?=
 =?us-ascii?Q?EVxbhgjpHgn+M5uGBqPPG/O9AwPrSZeEDiPuP0WSZvGibl2sFQoNO5LhMQOg?=
 =?us-ascii?Q?GfOjmvX/sfAOgA9/qTzd04MLvYg4J4BrSudJuUJxSuIoCgDMM4PWsxgA3PMA?=
 =?us-ascii?Q?yYM6jbvIYt/zcqQebLbCpRX7cDyFYEM2z34XBK7hkTTnHOmWdqlP3g86UhHO?=
 =?us-ascii?Q?v2xu/XFxegE34UAPPTVnrT64BbAYqYRUZVUlGw/reL1a7rmZBFzB5fukrjET?=
 =?us-ascii?Q?A/Y9Vb1FZleNwmPABdCLs1I5PzcSAkJqvlkdRXDib/LV7inUMB+q+D0BxYcr?=
 =?us-ascii?Q?fVd36sVmol4OfpjghGAgMbLPbBXr39Tcsq2Xl+EWal7MDEOeog9SLD+44pI7?=
 =?us-ascii?Q?SsMSq3D+AGZ0EQYEI08bm4YDbgiI8YAZCIyD3tTw+fUan5OP6IRVp0UV75dt?=
 =?us-ascii?Q?NKzMBPb0UaKBPy3yKtYD3GOcZtAt3Bs6vW78Gx/qXgl92omYg9GihFgMnphh?=
 =?us-ascii?Q?0caowO9Ts6H0QzH5SpY+sGnPU8XBKXsA6o/6lEAN2iRy/G/66Kg98uMUc6/U?=
 =?us-ascii?Q?kKov9DaUWyV2/gJ6rCrJpTks/a2C1yYXsaleoEg/XQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/l7uF5QnEnhOlPEIgC4N7aytx+aRMnUkpHodeokBq5oFmjlDwJm/Gq8Uin7a?=
 =?us-ascii?Q?d84+ZXkRsk86sWtawZHUc6OFG4ANAY0TQTC2qEGi5R7iORvnWbwc5LUcX99A?=
 =?us-ascii?Q?8mKoxhKLHpsji3cblRjhrB3qfGBG06UjTHXxJN5Kt45S7Qj4hqdXfgBogLFt?=
 =?us-ascii?Q?EPC/CH+WY36oUZoRBUddBVp/Z+fbzH3A65zF+JjvaFIWg1mYj8Pb3nk+F2P5?=
 =?us-ascii?Q?O/smMQyOV6i90b1mOvve3+K4vqN34t+clxcJzx33bwZVFMijbRD9LnXtmy8L?=
 =?us-ascii?Q?SN6VTOyjSl0nzYBw3uT9s8Ogptrixnan/0IpQau/QK2eiI65FDOKdYxqgvfF?=
 =?us-ascii?Q?KUtVcPskh68SSX3InA1uA5ByOM6GxS0XQM5YxaZghYgRK+jppHZGYzGBrZ2P?=
 =?us-ascii?Q?0cqEQ9VTDmb/Uw/51nQldS6edubO1f7GSc6bA26O2oHq09PmMcX5vYM8Z7EP?=
 =?us-ascii?Q?M6s8euHJtHVd1EXDBUPPXJtsOvcVC8S1vbhJ08DNrUaP2EJsCXinTEvjpUy/?=
 =?us-ascii?Q?68vMBY/uVqAZiWS0Glu62jHIg8Z5hw25w0/akDXVisD/yt03rqrD41lhHE/V?=
 =?us-ascii?Q?RNWRpQHgOLAgAAhbsVDXi228HQbKGH9HbL3XJJfRULEcqp+FkSKGQJrWAAvC?=
 =?us-ascii?Q?n3z70wWhZA+tZ/bzzj8pdH3A/b7VMwofB7vcMkCQCElafeBj5+j+XythuvNa?=
 =?us-ascii?Q?Wwk2cbsOtOSuPoB5bOkpSjL33ITotwfk2wOg5jF93ndLjMkoJiLzTNSEZVaR?=
 =?us-ascii?Q?J7Y9tXvuFjGxAdWZjNGSM7B3IevRupTcmkMdAeHcP5VxM0ktGW1EcVmLxvn4?=
 =?us-ascii?Q?3fZrcE0Nzf7aIi3SN9+6XrEmuJOiWErsNEKP9JlcvfW0DrZ0bqf9/OHfiA2y?=
 =?us-ascii?Q?6Wd2r208snQRP8Wxk4q8Nu8iBSx3ZhuNQ/IOTAJ9IF68NEXFMQnXytzzOQIL?=
 =?us-ascii?Q?y2PEk2O38wfIt+q8PB+BDokAZdYVS1KO73Pei/KONIOJEyvnj3ngMH2B74yu?=
 =?us-ascii?Q?pP0rlsiI6WChRMCAJ/5JJZ9VHILLeHZnKqxxUs7bKn0x6OAMSd5cc1By15sd?=
 =?us-ascii?Q?A2Um4/I6hJCQPH23CF4CHUpjHGeulRL5Wd+PYcuSzmETsy/8TRl7KMH48VOw?=
 =?us-ascii?Q?Sb8vbq32DAJ6mfBxlM0SRxAhrA465jKzkv72K9E9WeoH9+Tda/JAwL8diUu5?=
 =?us-ascii?Q?qs//hGKEWoD9IHk4u+Qm/riXs78QNuK9NiSqaTBjlDb2dcH76JaQG2tHFK+n?=
 =?us-ascii?Q?Prat4oMfEHb9QIocoW98QdToY1Pd4pYSIKExctPq5QGof1bCEozxw3KgoBIk?=
 =?us-ascii?Q?xwhIyY7DRIeuW3CHy085m85R92vqS4RETN0FlhS8O5jTUYV3FQMMlHOrHF7/?=
 =?us-ascii?Q?LPC+DPpphKp+WS5g2SzW4N+/RVCXACLc8K5FCqazHLyOC0zyF5lrn/hamvIi?=
 =?us-ascii?Q?49s3XC2/3iS4uOyaN8iQP7GedQTTZRlQBbeI4qxATL8MLgjrskVknQj05J1I?=
 =?us-ascii?Q?JQ0Y3FFBXIVdv9D7U8JnmRC9pEGU73tkj2QbXgEQO6Kz32uGT6vG7DpyilCU?=
 =?us-ascii?Q?s4ihtmNEYS8tTk1m+vapGVnlBcKUJM5fcr1iARK6uCE67DUT3ew5pq9AVaLd?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I28hZDuSVI/EUmTk8smKv0l4VZzb+dKPW6TM0b7iw3AJipev2Cb2yX96ewetRATNRjFiX0t0aJ5Ts87CsV1EQeEjLP1F3zfe4uDzjH7572suXMMamzqKQ2oWD135yNpLvPaHcXLGQ8B1zZ8CHJoRkWFRU4hPUMfrUQ0NvGGkNJsF3JkNwZdkYdhOH0F06JW2MaZPLV+gAoYw73jhXdDVB5Ulme/aoxkAxNSyHcrh2YovZvs9NQs7SWqKvjkuzhc3F5gFP0DdMDZKR7JWtTs66LUjPOjwGhPQsmMVBN/PnUGXAIh/lmZ6W+Dgt1Dif2zUJr+qIgrqs8CNyqUC770XeIj9qCgrHOsxl9+S72D55creLELvPXgAfseI9SlU7Hf0U9gSch/1ZTTsvtwy/+8N9YaO4X3u6kbmlDeC7wtS2Br3tZvjtZXNniHKf3T84KPXoMhnRuajqzszi1j+yozUFuj4w4EmX2TYKUXHBxVHjZYdvxc3DyA8QbFHKN90S2BmyXGmikOpHOvZV9EWlihAC19ZhUfZqoW0RtlYwyyBI4EZEJ5lEBXMF3sXbc9nLkBNqZGNouyeW4YFDKc2iPQYzSMtek/WoC24krNy7UOwgCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a488de4-5bfb-4472-cf7d-08dcedc9d6bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:03:52.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLlYhfLzWu+Y6WxG/84Kat4f87WQng3tfNGSPTjVakNYH+iALnumYKLnyehB4ubjlgSwpEq5V9ZPaOacEqgG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160062
X-Proofpoint-ORIG-GUID: 4FHVNSEQwHo5tDknQ_KsAHNpCXJdiwq8
X-Proofpoint-GUID: 4FHVNSEQwHo5tDknQ_KsAHNpCXJdiwq8

The XFS code will need this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index befec0b5c537..3e5dad12a5b4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1848,3 +1848,4 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


