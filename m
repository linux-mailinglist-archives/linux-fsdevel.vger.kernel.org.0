Return-Path: <linux-fsdevel+bounces-42439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A43A426E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87FF18905A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADB260A2C;
	Mon, 24 Feb 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bFJmoOAX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PDjuZM45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892A25EFB3;
	Mon, 24 Feb 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411969; cv=fail; b=aThDCJsdSgrU8+VnXIT8CVq1oo7wfmkudZkvnP0NE/77iX0VweuXQT2LI1qKAwDBQ3va+9puQVK0l+wZNHem75sPXsA3cdIfo6T8EmbNvLwc+a145x7OWEGS2inUd2l7rxgTJFC36P6ax6aAiIG0VDK3N+sLCvKncmzXjrusxiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411969; c=relaxed/simple;
	bh=9boCh28OktTS89xkgA9+zKjqmcBN0t5pKHikTr8OQI8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kq5+XZPCKWxN9NOD7bmCFBq8jcQM4f71BNjAn3k5rVnJ8/gveloQX/UrhO5NfXfbJDBd3A7P0OVJsUGoDcwoXJgsptD6GfsY7ow0VYehr5+z/tLqlUO7C8XafD1yE9NwdkttHcu0ykd8strphUpJMwVtmxP0oGvOXog/3jtk+jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bFJmoOAX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PDjuZM45; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFMeNf032326;
	Mon, 24 Feb 2025 15:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=PLqhUtx98Upt7eJ7
	e0ysM7H2dOKGwkJcVglDfNF262I=; b=bFJmoOAXC9LDCGYZKzmmBRp5DGmLRiOw
	sW5nj75miCbcUZ50sbCalKO6ETyXHJt9Lb45yq/Vp0HtCv9Ub/Hq50Drf4mEFMLW
	YAFIxv8SrsjypDLGlB29onhOjy/bPhEqgxpi8i36C8VVMHTDw6+PsXF/0Tg2om6h
	BF25M9V8PwZru7NtfdXUFp4LxWjqJAyEhDu+7+tGKUxelJ1RmXhw4fFkwl3t+uGi
	FWaVdgaWAko0bzexgsZtZ/YcOVl1+5SxeWZN2e4gkpMtewB4MzmzbPc64nuL4/AA
	M8IzJM0CeAv9CWtJnYTu1oBLrCDzVqvWzcgNZuYLs7JynJSwsIPrsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t2ufb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 15:45:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFQLr4002881;
	Mon, 24 Feb 2025 15:45:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51830hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 15:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2+vtIhtCdcX+NV9ijRGHDpnSxIFe1gzuG2Dm137zpVeyJkaXK0rfmE2/uwUh53bVUKR48t+JX55lSAv1Cx/4k0SJMPyniUfSdSPkbfYwpH8zdT5Fj+CCMtNhiYSvnODtSzFPwpiVsnBo/Lmil6i5ZYSZY85I3cuCE6JPNr+AvMR6Y4/sBlhNZTCPetC1B62y0+k8dJ4mx3cXVNNSdvP1cSODcdsKh4YYrH/wn3kjlBVNmK0Y4nLSpJn9KaDorsQKdlBvr689d6K7iGFc3Hp73h/EkReIntwTiHi2uMTE+4bZUCcDIoxbgubh+zmARu5KhpJrdv6PMTkwEUqxTknbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLqhUtx98Upt7eJ7e0ysM7H2dOKGwkJcVglDfNF262I=;
 b=C21qmHf+774kCZ6KsyiKdkW8qIWhM0Jom4zEtFppa+D7tQ5mQwxwkNoJ6ZP2zvaLVTUm8zOisXsXKU/z6kb+0HYLaKS/7KOEp7mcIi+/rQUuoEj+zCfBabHGAQyhDQGE3uCqThRr1idZo0fSk5jbk1+NvcSX/D1cADFqkB8rjKWBJX6tuEaMszZf17ksHIad6PLFyrNHblOzkwMai2mAs0oUhTXlYBxmMD3chZqQ7sR8pd5fTzUvuYKzQJqEe0cfgm5QyNI8kw3mIbIr8WD7OXLEZN4jtQu0El8HN94OUOyWjjmp7Ip560qy87VSxS+40UirmdUnKmfW/n3K7WmMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLqhUtx98Upt7eJ7e0ysM7H2dOKGwkJcVglDfNF262I=;
 b=PDjuZM45EkAp84rKEr9Ta4IHM2XX4SibRRmagqnUA3tSfW4f8lOpYKT3jqf+oOXfwBGfchbzBxFdKpjdMamAnWz0lY1z6rc3uYp7ni1tnWwWY4Of+kiAif0wBDeLJaQT2VtYd9LeBYLHw09XRr0HzUvdViqOO9I4FZTJoY5Nf70=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8225.namprd10.prod.outlook.com (2603:10b6:610:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:45:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 15:45:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] iomap: Minor code simplification in iomap_dio_bio_iter()
Date: Mon, 24 Feb 2025 15:45:38 +0000
Message-Id: <20250224154538.548028-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e27663-ae87-46db-8324-08dd54ea4e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbJRn8UgwPq63Aa5tu9cUXMvLMwWeqMyezjZ0YX9yhwmVvpMBCjj1Y9AxDkF?=
 =?us-ascii?Q?NluOqlUGgUq587Co9q6fH0WpVQ6pgZ0aNGJgLrSZ19pjsTDn/OxXnVG5jwEa?=
 =?us-ascii?Q?aw8Rr5kQMBiAZXSxZGv3MXAOSczcET414rjEjHifrHJbMmcIRp03pOIitIoc?=
 =?us-ascii?Q?JzOBbt4KZgkegJdyGcu0ITtNuMJM7bH8KV2A6xQsBXVoxdhO1T7MCCWNfOt0?=
 =?us-ascii?Q?EzjIL+KlFTOA4l/ruVKd3rTS3PTNnk/c5OB5BZozCncvlGS3ayneTclHC981?=
 =?us-ascii?Q?DpN3KtHUQ7N3U41Xzdd7DFbR59+FXJqUDuCkuXeGKh7KXAzBznMKqhETJb82?=
 =?us-ascii?Q?WVC28RVTACtm6kNjkbAqKPlQ206J2GIql8FA9bo7qw1tVD+60xdI9cgfNaz6?=
 =?us-ascii?Q?jU5/EFaEq/HCp3b8jAUwV6bu7Ti6PDF30i5gtaKpx1V/dfq3XD/y7Uyt8Bze?=
 =?us-ascii?Q?VBJmav3hjdzmjWvFosLAEAt25F9i8vH/7uw5Sugxytz5UyZ4UCs3JnpbhQoO?=
 =?us-ascii?Q?UmDLzag0Besdc0hBskYFhw9GAoruKtxAHH+CKio1l8o6V8lkLprygVKWfUHV?=
 =?us-ascii?Q?SexAoNILFqowQ29bIeRGe8OLe3BIf9+LtkDBovLN6U60VWHYierER52bq/L8?=
 =?us-ascii?Q?skUEbELNNe9ER0iqu9F8TYTWb30c1yXu3j8t5xinU4qiohWEXoyaraoe+V9F?=
 =?us-ascii?Q?/hZmgrrP8/MQEkdnZLWYcRa3jx5D/5WU762K3a048VQpYikiykTchykinjUm?=
 =?us-ascii?Q?G4+Tx8y/lcAvE3tHKTbSzF7or5zKVqeNl+rYXkKUred3EW2mGgd/kpTtkV9P?=
 =?us-ascii?Q?sti5D15OQSF8abuKSbUlA8n9N47Zre4/ZtyPyy06LZkT1X8/XcopkvZ0pID7?=
 =?us-ascii?Q?qbdtmaYi2Pg0m0Pti/4gdYbvxtFpK1wx0wkS4HejpHyQulswXqvsT9Kn5c/u?=
 =?us-ascii?Q?XD6dWQ1t35nJfaTe/3jcpcupfSGHBklHJroqD7fRdl1uAxS1cc5FYliTPwDb?=
 =?us-ascii?Q?Jk5OIdhXCFq/fQN48oKLeHPBcUNwVTTB/RH97grosJ48XrqHnuKyvF92+xh9?=
 =?us-ascii?Q?mlbEbI3eB5yk5w70S9BlxymCsuaohVDO0zFQRPxv42QPpVFtaFUg7mePvq3H?=
 =?us-ascii?Q?ctZdebAp/AmxGlMP76fpcaRdciwf/sk7C6plffTBx2xgxRiqWOBmcZIOH8AA?=
 =?us-ascii?Q?5uMoigSeTIRgLujwmCbJTWptY81oW7ykfvgiNUMW3aJi5hlauWlpO9uOYs+E?=
 =?us-ascii?Q?RgGLgE62FDkMO2FAD84soR5eipX9+KVX2lqZvkML+4Fts/RlHSmzLZIc4udJ?=
 =?us-ascii?Q?DJ8uSHWMx1UMxOE9pxCxVbM6jqP0FeUCzAgULLSrY9YSIHftYV18A1gchco9?=
 =?us-ascii?Q?6E5NIBF08zzYd+FKF0+RnDpY+7xo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvQxKwUdP8LHfcehrjwnecMDxlSnWCYgFYfRQYWBpC2mKYvYcW0IbPvHbXSz?=
 =?us-ascii?Q?jK9ysYSOpcBxlfOMPG9AT9tZ9ZeAjQ9v2lCanhWn2PYAd2JFZI0PptwqAEgR?=
 =?us-ascii?Q?UtpGM5r8QFfdXlotYVxZ1TXdbrdm48jKP13ciSRQjLx1YQwUEJNLXvMgTCGY?=
 =?us-ascii?Q?9CRKSj4vbR41l60wK5P6VZpoAJzOQX6CC1fR3SZJbDAKWlIq98xhkpS2tSlv?=
 =?us-ascii?Q?S3EBPX1gbgHaHajp3Vvn/ivM5GYT71kWkvPVkf6KW72pe0y/1phYrVCkjAht?=
 =?us-ascii?Q?WXiT9WWQKbBNltgaTZDzYNa0xybPRKDC0AjNXouyr7K1fHAeY3VANkoMFZaS?=
 =?us-ascii?Q?WjFdQJQDbOYfZ9J4ReEvUqJVdWV7cfEAxnwBfe9PpKY4XW/p7pm0Ez/DSDbq?=
 =?us-ascii?Q?34jQAmzcob4ME89zzuOkRJuI02iXTy2/aJIzkZw1oS5T86+N8HtMMqaohvGz?=
 =?us-ascii?Q?jgUC+hqi6Bwq18/umHuZIhYSxNF3z+KQJ8mu2zsrSJ9/lXj0exmUihQKyh8b?=
 =?us-ascii?Q?Kc5ipRToABXuUAjsAVgKh2+REqukB5pXAG/SAv66hf04O1uh8VF9raH2v6K2?=
 =?us-ascii?Q?WKr9IAzZ/FT+AnRHITEhLiGaK1XbwqeZRVrDekpi3Ucn21DHUpl0gZJBeR2i?=
 =?us-ascii?Q?mouEXe4Qrw30mHrUZuOxS9ZJpcFKutFL9Crkan7PYe2iYHkAjKaoPU2bXZyw?=
 =?us-ascii?Q?/4OB5yW8YwA+yrNv9yrnsFN2QQ1PgWJwhh750BkqR4Bl3syvuZf4bXEpQi+w?=
 =?us-ascii?Q?eI4pgidxXXs4I32/Oj4rzsvtvsVFOby2t1SokpmLd3CX8k4JoVFrRXlU5TmK?=
 =?us-ascii?Q?ZHz8BeX/w0VXTolCV9mtQZ/0mExKO1U26tm1xvQQxjAhoXNlYwe2wtAQ5hHL?=
 =?us-ascii?Q?xrOYrfodC/+Y27UzU68mcS1pMOMgvmSwrNhJH9BXHE6JMttGIk7yxEApZRT5?=
 =?us-ascii?Q?XmCXXZ2bQ0y6aXPQ1jYPN1SToGjreGtE54brwFtKHPMnHExK7QNrm7owys8O?=
 =?us-ascii?Q?RB/9+cGth2AgXBNtYo1mMf6ZCMGtlLywZtzczqL8Fln+oksw6jHTmqt9hlwr?=
 =?us-ascii?Q?wToX3RJPvfe9hrBhCopJ6C1tBmKcvslF+uArsw4+0XMx6vKdRNhA1m9CUkUi?=
 =?us-ascii?Q?Z/xeAgzbuhttAw385g8u7KwPcSMdig92RbbYCdCwTOIMXeRUPEAJ1GMjqUKY?=
 =?us-ascii?Q?kb+lsuZOsfKCSEM63Rud+iYcZMakrHKzvWWPSB28Zu0fxYxV1ZNujoc5aW2G?=
 =?us-ascii?Q?dX95weHqkmUiFq2ILo/N+eRmTeqRnWINYOE56LJKechbeF2WbD9V/qWodCRE?=
 =?us-ascii?Q?nBTd7gMdnhAb3/oCuC+Op8iIFkVxoHTIJj5xRhZMo7gIogjufstqHkVoMBwD?=
 =?us-ascii?Q?noFXUUVk3pCaPvyNik0XfbrWTCkgF7sE7rfTRCypca+Dk6i/l0wOrW6UsUDG?=
 =?us-ascii?Q?5giA3BFgMDMfFCw2uav9RdTi7ffwHnOwcvxCXeWsky9pagefV+GHwNaFBUot?=
 =?us-ascii?Q?LaPpYfRBPDKZcCbCxZK6VRuVGsizqxWmF0jZissS2XHf1gNET/mX4+uTHIlJ?=
 =?us-ascii?Q?zorekPXUjM2Y1HEFUeW5oaxi1ONZD8qQXkaVChAMACbxDJEALJetNffB2Pjx?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MF64Wyw2zyxFZlmYvPnpUUIIDnceKpMHsJcqmzAW/zcFTWgY2dr2g8IvLqq4pVg5PzIvqD1VfpL+egHtHzINVFeqj+288CYqYbJegUgGJiF4RoSM0zbuDvVk22+kq4KBcX3/9H0uvUiydAqUIGWzcvgiGY141sly0VZVVdNHHhhM5Ag3vhBLgx7xuAEqvn5E3UlJQ8nDmlKtvScab1PJffV2xWBXq/D7ErCOICl+vXxfmhYVhCkvzjuGqmft57WvlSmDEt+Mf2Rsexh6N2gCAzbgtvhLXAfR8PIJETkqiWpmayywFcprqeojpXeffMU0KEn+ZaCKNVV65/+8jOdPwrmzYrBsOwxsZgvPrDpPxuthTX6XEPHO9cKkh41pagIGf+tphU50fK88pf7LxZXiD3z2cLbYucAGjSQVzzyRQXjPhe/rBw0TZrQyGIyGsjRspEVWVPRGEj56gUN5JYFaaci9ajjl/nvsV+GK0k5zL4klFgu8W9kGBkNHoySffcll6gRsp9hDQj6LiunrsZrm247+DydJZz3ZMmkmJlUd6xbmhPzCX2jfPOm4uh9zF77Ywr3PQ5NeSWDYwc4lLNsvStjL2iOXgFLn3LKjpczRThU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e27663-ae87-46db-8324-08dd54ea4e59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:45:47.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHQ92ohrNdoHxyavnBoViOkZJlnBf9rJ1nU6+/CvJL8pWH0RglbW+AVJb+TikCmi3HIK+K0vk2UMo+487aluOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240111
X-Proofpoint-GUID: 6wCbv78qP8kmI7_TbZ6eIPjoR9DcZtx0
X-Proofpoint-ORIG-GUID: 6wCbv78qP8kmI7_TbZ6eIPjoR9DcZtx0

Combine 'else' and 'if' conditional statements onto a single line and drop
unrequired braces, as is standard coding style.

The code had been like this since commit c3b0e880bbfa ("iomap: support
REQ_OP_ZONE_APPEND").

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 138d246ec29d..cdcd5ff399c1 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -473,12 +473,10 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			bio_put(bio);
 			goto zero_tail;
 		}
-		if (dio->flags & IOMAP_DIO_WRITE) {
+		if (dio->flags & IOMAP_DIO_WRITE)
 			task_io_account_write(n);
-		} else {
-			if (dio->flags & IOMAP_DIO_DIRTY)
-				bio_set_pages_dirty(bio);
-		}
+		else if (dio->flags & IOMAP_DIO_DIRTY)
+			bio_set_pages_dirty(bio);
 
 		dio->size += n;
 		copied += n;
-- 
2.31.1


