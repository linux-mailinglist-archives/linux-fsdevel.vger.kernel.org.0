Return-Path: <linux-fsdevel+bounces-48204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD3AABEC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8586521143
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33490267703;
	Tue,  6 May 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IP/Wi5dU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FWfgY1Zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAA274FC8;
	Tue,  6 May 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522502; cv=fail; b=jobkk7Lb/q4UTC6ikFSDUyT7kZqSX/E2evJ7fSH0utJVHXajayDVxgkJvuGH0n9OBx56E6sKIfrmVedDB31Ae45NY3eHJV6w/Ee2hi7P/ghGdGBCtROaBdMY5iFz5Orv/lqEVwKH8f11IZqDh/qqH/TFQoQjxYHFl5qXLpedSGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522502; c=relaxed/simple;
	bh=e8Rx4wKUghn5UbLRBAKEFYhg4Sjn+njknH+/5eTBz8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh9bzqhfB7+K4E+pFIRwkF+/U46+o8/J+60tVD2P8DMWubmAl6/swPSTF/yfcQlBtBMo+ReCsdbb/9nB+yn+fKvAQlz843TXiWI7r2FbWGPRCxHQq4szrCCc6wY3IFE8UzM2axgvNfoKNLyV+DF5n1H79bA+3Pho1TgieUxzIDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IP/Wi5dU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FWfgY1Zn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54682GHX003156;
	Tue, 6 May 2025 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=; b=
	IP/Wi5dUdItGJRRTDXa6YuxkbMJhK1R+f9OuUxmJQpizjJMGhNkDtTVPTPLQKXDg
	YrWPkqEia2Ay3XvuUzsHAkRrWZVQ5NKd2nKYoycKULiO2W7h18EBmU7kTSC1Vl/M
	jpDdYXOIaDHBaO5lkYXqWMfG4b/WBFXxgwxjoIehobEqjARdvQn8JZA6BeCCy2Oh
	mmPb0j/dD99gWngrCO+3dd8j+zJC6PxQq1glHeo8eZSKuWI1969unk0foajy5OWV
	gMvQVpCjJhGia54eMpEEguG9uyonXZwXVaa4jSr+PIsiGyfDrcuYHfXxD6eug4Fu
	8F/hgK+8Gk4/cVhoDzMqZw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fejbr4wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54680ZwT035632;
	Tue, 6 May 2025 09:05:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf06ur-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4/MlxzC+ILiC45ExtKWQx+J3HJd8/6lQmgrQUADh/XsZ83CFQqC8k5Vd+pg7qB1vfNLXrQj9rccfYcGsxIOEhJtBHwkxxmxkqwNUO+6ZqAAIh/7Pg227y/4ecDSpmCmom7zd3RuXvScMN2uMji9hntH8dB/DoeKkeeFJnvUslWqKwuYWtSTmcghlK32gMsTG4jhsIsnQvhu+1Fu4oKGv0WfZfByeXItf8ECgYXggmD4tg7XR5uewRtZnjXzyM5VDjUfQfNrmQcgpt+wlOKsBtFkOxFq19PlNNjqEO5Cvak3vt7aTz3l13CXQdam7IUsy6UoJqi+yxvfu/1fnls8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=Q58ivfxrcNmU9HCSnlu4WTATuHVLJZ4XnL7je81l2QKyBcVIu2App/63FfE6EGNAOQbCu6AytZIrfMJj0wwM52S9pPHVKxjzbbjBCbIX9qlOQ+/JnMVUEe4niRAFgqYip5F6aeenHgD4RGU44sB8DLCyXrUbgzoXRFEU2DXCOpkoG/RU1VTMqY7LIJ76C1NV7BAoC+EghQy0pcty8g2XwufMpNjsyPgZ7BxOGsRH96iWJ58oEySvtZ+vK1YhqbWPIyfxWThgN0MpQDCUkLA0cYnsOVy/CsHY14czRG4zN28BiKqS/WI+isI6qMGA2QTJNl9JFbE/h+aRMWV6cpcjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=FWfgY1Znr92vdXKdrf1ywbuqf3AicIQbbFUghXdDOBZFCKOpJax95RWTNzy0jhzisw/9Cxpg6XpjVuN/PeFigS++XZPFNoDkiUGy+7KSFcfRXjxDyJ5S4ff2ZlSIjiWy393mgRUkfC9LdVg4BQpj3BNPwRCheQjI+sZFM4hRgNg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 16/17] xfs: update atomic write limits
Date: Tue,  6 May 2025 09:04:26 +0000
Message-Id: <20250506090427.2549456-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 44320426-9cb6-4f39-b262-08dd8c7d298d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7p/61rfV2bitLJlGed0sAY9Rguh5xDvBvAEpImI1GvICXOr8npCYBJPSGV4?=
 =?us-ascii?Q?ez4XfbB7Klj3Sus4GKam9QgT5bEPOCpTqAJl4M/jCxDDa8elHgYCVCcDRrfW?=
 =?us-ascii?Q?9Dd79G2OrPnUME7Wl5TvgYgkanPbEz+3CcgXomZabAnCUa4TQLYZ8KjVPAe+?=
 =?us-ascii?Q?IB6dwe7O95GgILLcHCN8l16JRcfplXZTIQZRUQys3ugc8WxfJ+sNGBJMhKWd?=
 =?us-ascii?Q?gWDrXJN7TIE7NuO3bnwEHvGbSMf0bfuzCGjonY39XGp/7UhudrdGjNOOVKwB?=
 =?us-ascii?Q?6nejbbo37ISSgsRAus6oa+DdpeFsFHeTn+otzvMuznMumCVxClXOh90appwK?=
 =?us-ascii?Q?XGz0FkDW2z9PREaM+14nL63wyKC/u9n4poZAD1eqNG1cALhOqbG8mCJ/zGHG?=
 =?us-ascii?Q?EIp537eRQiph4eUStCFh9SxEWcHkTu3iwChwFfJagrTAyeI0DPiE2I8tRpfK?=
 =?us-ascii?Q?MckrZksHO2K7twmeFMmtbp3gWrdi2gFkltA50qfGU+ggpXOPF5JMWPIlcEY+?=
 =?us-ascii?Q?h5DCh6ZEx4ep4oQmIoY1OFamNFcbzQXpNppaUFK6tRJr0o8QEqlr86dFytaY?=
 =?us-ascii?Q?LiQhrgbAWEhtnH3qrRQF1UCSPy1UrU86zVpLTmJ/4xHgY/OFXMOVX4Iue4jQ?=
 =?us-ascii?Q?Hv+G8WyMpZGHPd8Qd0dxZsf9KJpAdv41n7uRCM3CZ+JPBsRV2aD6bbhT8CX6?=
 =?us-ascii?Q?2EwGABkw0c//ljLbUyvOhS6f9VDnJOsWFvUGemwNT82CLcdpRvvnJvnHpLEL?=
 =?us-ascii?Q?HWuPpvKq2AaOYfI62mBIK6T3ZgiymO8NfVcRYPH/14jpnaqbkL6qkBLBKBh0?=
 =?us-ascii?Q?oJDIJEPjvSJjWwGlwWwiNfSTqG6F+GV2pYpuCxF3IBLywXKiF0O1gwLxuiA4?=
 =?us-ascii?Q?95qPR5zJkB52frouaph8UjnoLsSxlMN2ZJLC5JXkv/tyIpYUJ0clVcxus1iO?=
 =?us-ascii?Q?kUgOCAHBNxZT+opZeICQiMcqP3j2emGvRbCs0pPQMcSjPl//ix66ewF4SbAP?=
 =?us-ascii?Q?WgbJ8BfNhBd6v+98umFjfrV68sy37VVnPt6bP/wTmQnOBFbdJzg1EpRAq7cN?=
 =?us-ascii?Q?/5OLHSbVxECIveHJkMLAxGEL68j+ZkazBHGt30fSknhfCuH/SZ8AKjGWuvDj?=
 =?us-ascii?Q?4vVBAt/0jI6k0LKCijFtTxWQW7YtGBm+5tUNh42SmTRznIF5zZml5mUlQFCD?=
 =?us-ascii?Q?WNN9PgWMJWNKHO76xuQwCZy/lIoZCqLinGq54uJKT/Ab5ZieCSQbSVg5C/KC?=
 =?us-ascii?Q?N73jBed9AWl2l+rm5b4gieZNVyJTH4Y9wNxvufevucgznj5LogN662OdTepG?=
 =?us-ascii?Q?4PdNJSg0tRJlEm31EYPDF6RPMHxE4MJP5R5r6S+aA8ZkQMHdle7ABluoAVxE?=
 =?us-ascii?Q?84tgHw8RqQVbrF0uCnkmwkPimyoEMM95NReSDlUleqWH0UVMmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iduc0TqGD41AL2/QwHJ8wkVR9meKYsTo4OpfYKfi1RHoQvHQoScLcuwOrcAh?=
 =?us-ascii?Q?9y4lGS8kZcf1GUuWZCIfJOyVIE7l2SLRgfZHCA37ypmneO79pCW8PujpRaU+?=
 =?us-ascii?Q?+XkdSGXTIl7Fky+aIkokKsvnr/R8yoIcEcZEAJ3nwbm4ndfIKzrfJiLNjy9g?=
 =?us-ascii?Q?R2/sWiclWFyI3UitUkEajNoMDS5UGXwkZjPP3a7QnT1hP7AFSgKESGS7BBu2?=
 =?us-ascii?Q?ywDIXyZLHRuy0Bh6CsE5rwtbu+5y65tjrgxdhSTsPjTxDXzvI62glDiFnonO?=
 =?us-ascii?Q?ZaZlRZZpxwVtrynDSgEGleRYDfpm95chQOPmwV+OWqJkuxTXM/xozGZKNGBo?=
 =?us-ascii?Q?XZ3UeXKDOAqVUZLHnoDZMZsP3Qvj/VJVufhyhz0r0dlv4tS37ICYQqgicdBy?=
 =?us-ascii?Q?yv6qoAGny7Q1MfeHFH0gXCbupIy7BL6PTVUiHBE66mvfpiCXRaV1+MIZknhL?=
 =?us-ascii?Q?jg56jdVxyFEeHP+/ToEE0YlIiiYqKaqftmRbfgheKN+GAtOaEDtTMWyt0ynA?=
 =?us-ascii?Q?kojvkaLgBzQThYJvPGC/UXqpOlrp0FzL90N1G4AbNui3qFogH1z/lulU/HFY?=
 =?us-ascii?Q?X3HLPyw/MezgiQpq8RfiFJS1DB9NeZgjrIuDGDiCaBsDUnwLAJQMPIiPmY59?=
 =?us-ascii?Q?YEs06AUNlkS3WPuIQ6TUA1Y52nK8rt5jK6Xi5UKO8nCkjB8P12qiYnhH1/Mi?=
 =?us-ascii?Q?qzxZN6zav+3h6NKAvbdnfBQnydAhO3zF75Fr7MbiIm9bCdcPwEDDqmH378LP?=
 =?us-ascii?Q?uSIuzS0bBsKbCc303V+YVL7fXqQDhtWoibGqnszXQ5dY5CA+rqGFn67CJFKT?=
 =?us-ascii?Q?rgDB1Sb7smEstqtGJQYVXjOz7tqgP0zW1By2aVsx2Xi41LH+/BKSzDsYib6h?=
 =?us-ascii?Q?OjBtK8oKnMKsK3+JVwOhMPy4rvL+hw0cW4apSz/xIMYSh2IiQ/qfh8NoNAEs?=
 =?us-ascii?Q?280vjtliiE3Rz6661aRcKyQMpCjlFHQIeIon48C4ABGXSmFxdFRm+LeFm32Y?=
 =?us-ascii?Q?CY7IH0GgTNDbUO/n8cs4tfcFWDZXSwu4mjfyGN//cEZH2dcAp6qQUXBPucxf?=
 =?us-ascii?Q?oeqLxUtdd3eSBOnlD74hom2EnDAjTpuwx81UPws2RnY7IRyqzX54dBydajVJ?=
 =?us-ascii?Q?JRN6Pok5LwIHzxFE0vOmTQqD8nybjiarKnB7Kxl4CCJGCINTJdA7Fe92VLgQ?=
 =?us-ascii?Q?XH8xQ1GuOY1kKXUV1pUpwk1xbSoyeIkre4Lli8JDCPU2rRnF6VpXs3060ByB?=
 =?us-ascii?Q?qOBBAfqY3oR+t9tcPf6USx7MtNoh9rkwHXQcyjhZ+bXucf5aBnZRLGCsiE0b?=
 =?us-ascii?Q?Yyqa/8+zVUuaqAbhPU+clU9TRaO7R2nz0u/nVNu4QwL8+ccLYxgq3PiVr1Eb?=
 =?us-ascii?Q?C07pcyZe281ERVgmg7NGu5KHyc8X/aUOuPvON81b1Ab7OUdFZhUQJjudt4wS?=
 =?us-ascii?Q?xlgT90Tz3YTpx+d/HyE5c2wyDgjbU4JRItp0OAObvv7QhkZkZpJCbh7XLoLx?=
 =?us-ascii?Q?vTGC0tKA0UU09p7Jm2A/bi2/FIibrk8D9qFUBkWlCOqz3MtK2lbpDXde5Xk9?=
 =?us-ascii?Q?8jQzk2e+7NqpvstlyP5uAhJbvakWka6dEyUIEz2UQR/Sr2EMQ6su+y+gkY7h?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3gBs4OUoAuEnLBDN7dIfdBHefGDqxeKVpUusPZYUHAP1Og03NfFHSRt9xMT7bdKzDIeoiC7ns8dyk3n/+VbRhFCWwcjiWml+rctqzrN1FaeXw79CjiqkGW+jVy8o6U8IxxJMr9OM2OE5RNOvV9x5p3khdohSpU6J+ZNak7EQmPROkl6WwqWUeSM/Sa9FyerdO2DRKg48ZQsU7X5UiMh7A14a/1LYOU6evllgpLvLg7CZJIC1bZHzAXcEzqNYIqo2R+sGb2h8JrQtD3360usqi5LruE9XyJ1xW0Y6bCKQtTw/7glI0QEVoBIvE7YehJpzummjTHLsstQ6xTjwB5JtuggUzJasP8gqudL6xDv1FQ1dVd/BcGzu9SWV9t5HpJf9Eeh12c/PjJICuSfOZlTejdyd7yRFXGJOpZaqjc0LzEMUrJz84///BiKivDFFT+VRurNtulL5XlbT6Ri6Rk6Wyrvv3RRdhGIzQ8FOkmlz7L8V86Y/L576k5TxjuIXiFUp8sZNGo+HFT7yu7lgy0gWQUWfUW4LNiRaJm4XwX9itjZ3l1GFqHvFfCR5zDGzZRyG0ofLWYaftOV6UbXMxCYVlYkATJe1oXj9VRHwhlVaEW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44320426-9cb6-4f39-b262-08dd8c7d298d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:35.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iroAEKkLC3eioQSEKu+rUzLv76yNwZweGQ0FkDzohXWMnY572xIZE5DCqBZpwQDVVPx3zS8RLvD+dJ5Gpm+5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-GUID: hUJ6OOytBxHAAQsBwuVRUWoKMKCdP-B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXxlnXZLq7QQBJ y46XQ56dVWc9VJsNJ2DHgxpOvgJXUVLcAh/dXafSMzEFSKoKpDRJX1NBV7a9vn3QvqwGQi6G/D7 aPChF21VE4D7274nutxo3VBRru83huy7m8v26ZfLGa2DtqiRD48GP9TIqgWkdSjaFwWWtv5/Vm+
 pz6abgSVXqfV+jc0O2dHh9WZPrzm/zpTO5nh1KoMmKTqaAiqQEIMlkcwp3V6iXqWUcpgD6bNNgH RuZNx1RC2FwKy5hd9tABaKQNZgy8eVqUsP4JegsnarHcLQYxQs80nfwnGWlDnkEf/ARK3dQxsNt 1S3GUtFPD7i+x+JSFOIyASrMaUzjQwErz86Spd0xZg/t7UagJUGqbsFpk1cvfSCdH0ouf0HHrGK
 akNU70oX/z97DiJXkHclNpfqgMc3yWrNQysFmNWKLQo/Y92tPVFk0YcKa+AW9pVZd8yzPbgE
X-Proofpoint-ORIG-GUID: hUJ6OOytBxHAAQsBwuVRUWoKMKCdP-B9
X-Authority-Analysis: v=2.4 cv=PoOTbxM3 c=1 sm=1 tr=0 ts=6819d0e6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-okyUcW3L33xbzEWqc4A:9 cc=ntf awl=host:13130

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f4a66ff85748..48254a72071b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 77a0606e9dc9..8cddbb7c149b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,67 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_can_sw_atomic_write(mp)) {
+		if (xfs_inode_can_hw_atomic_write(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, xfs_inode_buftarg(ip)->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1


