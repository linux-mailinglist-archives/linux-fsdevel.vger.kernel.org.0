Return-Path: <linux-fsdevel+bounces-11758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB5856F18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10C8B25122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042013B797;
	Thu, 15 Feb 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GAKgR0+g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZyxdrTbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333F513B287;
	Thu, 15 Feb 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031351; cv=fail; b=ed6wHD7HV8q+bvaHvtwQTR/rA17fB08IKhEVbbIfL0Xhw3qfEfRgQIonzbnH5xqAHXSWV3xF6qhyv1k7q4iAOTCwakyvFnzlAyLzPFMNRKkuGettk2TsZYf8sx+vmX6qIgd/LB0fBB6j684vJDHNJTjaJg/O6xLWpedK/TPcAhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031351; c=relaxed/simple;
	bh=xGl9PXBJG2WEXQ0wM9RzBY6X+VSq5kSHqshqbfpAuMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eWqZMurjNboFDFbN/EJwrVWPt1jvok1BE3OE1SLrSzY09X003DK3MYkjurPMtGnj0L45M+kIqShF+mucMbPEFRKKnN7oW6A8TTHn+IjNX/IFZHiRsKKcJRwkbtEKl9Fbncfa/YYBcXgj6bnR+9OEJ7wHbqEGo3C1oqkePbz3nLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GAKgR0+g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZyxdrTbR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFTZgm030241;
	Thu, 15 Feb 2024 21:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=YW0Clse6HWiDx/J8eKf6undFT3x2SBRV087rBu4F0Ag=;
 b=GAKgR0+gLXkmLWbh1asH4cyeanlFJpwxR8qQISW/DksHzriWlkGx2EuptFZ1I9fxw7VF
 jT3KT6t5cJ9PfTPNc7GFu8Zf+yV8jrxMheR62umVqFiPvGvuK4urLVN8c9gTSgIIKZsX
 Mq3J4N0uKmCb6qb/3pV1rcU0spblzo5EzBzg/AWB8ItF7Gh2tVh2WQU4T8Ou7qQSH/BI
 pEGtr/GHye/3BSWz9GySKlvUqqTylRBrgOWYG5o+9hqLLIxDzLMo4WR5LgyEv3M7Axtq
 Tsz3t5/bI1ye9o9m9vixChh/wMA6dnIOMn8Uxb+yLQ7ZAw09CqcAVHtYzXG1qLQuZaQF eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f03kah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:08:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJkF1e031331;
	Thu, 15 Feb 2024 21:08:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb4nnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpvaszqmjtjRBLL/nkN3ndKg64dOpWA9/GuyKhuGnjh4PconLii6sUCGp1js3/ibAQq6RXXD9mrY2tdnBRQQVg242NAclSO4Sw/e4EhXDp8Ax2zu188vrXfCAN5vwusxoug2ldig18Zbsn1QTBtqZORmqUJkO1A5Hos8Vc58Uv6Fx8mQGeG4WO936Z7/9Q2cJIb8YZfDtf9gSheDwr/uWp8uOXTzPRCzKxbWjS3CBJ/N0Z9vPfjmfWLPWbCBNCNmbQdQe69XO/LT0y2qTJdcSlOoErcOOQzfO9ylcAuT7L8JIy7cy8TEKGWZDMzUZBuLQmxumf4+fVZNy2Fh7TRJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW0Clse6HWiDx/J8eKf6undFT3x2SBRV087rBu4F0Ag=;
 b=nJ/XGlcrNU4INPocw/wXGNQ3mCrlpt3GN1kmPzBn7RWtpRyOR9bIpo6hdm4jxN5tXhnjJQtVgOTcV06vMZ0hva8De5tWtH1ftaUsZhnPUHIAV74JpqMx79sr27RLHWDm1KyR0nYWlMLqj+EPJz8zShtntUpdsIK5Stf+7GmaWhz4dLT3PGzwr/iNiwUuuVx1mO0A7PRAC0/HIWDRTVIXlfEJVM+zdbwvo6/HUUfGFwiP/fMbDBMsix7pD5HuAyvp1yo3U/0QowOiepMdTK6+rJjek04lYUQD3ez75Cov+/zaGLR0GfR8cXP1SY+BJCUjP4GBZ/1pxQbH6W/2vKADUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW0Clse6HWiDx/J8eKf6undFT3x2SBRV087rBu4F0Ag=;
 b=ZyxdrTbRLvHRwSggQj5jsyOn2OP4hHcd2q/93HMbMqdce5/tQls1E5e7/kXTPwzsPC+RXGIB45obXMcrfUKc15fZxCAh/HL+QPGhS9w0nJV9QVXL5keT2bM7SxwOY7gBsZ8CVhg0thGig9A8+9O23nQrLXo6xvl7vidkJk2Xqo8=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:08:49 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::c092:e950:4e79:5834%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:08:49 +0000
Date: Thu, 15 Feb 2024 16:08:47 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org, oliver.sang@intel.com, feng.tang@intel.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240215210847.u3rnmvt5v2ay7zzq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	oliver.sang@intel.com, feng.tang@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <Zc5MnXdxASGiE3lK@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5MnXdxASGiE3lK@tissot.1015granger.net>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6473cf27-04e6-4fe9-7228-08dc2e6a4e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uTejr+u2xS9Nl9yooDZLFfQsLsTl/4Xa7XBfoRmkIMqZN9d++pFGy/nxsZ9IK/YGak4FDqItrAACj+AKZKnwvzqu0lOBXb2Q3gsLeZ90Ofhon2Vkfb1hqk4B+rO4kJRi+ohwQ+oi4NiBM91wHkmIJg/kjT2beWhQp5UTon81XeeMeiRCi8/K42ZzCZAG6A9SZyDUSVtMGf1L3Qc+xnLXm5BUxOUSeRVpRbiv3AojYaypzbmwaxdubER27H+CrM3xmV0MmhWLfyWYCDOm1Eqbx7ZuNDLmZTNjJYBsSXQlEVHa3zpyYzwmKz2fW54j0lcJBkTYn9TDCOcdSaNZllwBpK32Mq4thouJcF4nTpq24/Z2W8guu8wShuWbt6pfBOVbeJxBFVcOaqVgA4MHTIZdYBbHldwVNXXyO3/u9f7sDesW9iceneuQpRyVHFYn9fzF0x8z7z7Pxx0Kf2EVNeMSAvOadKQfkd30dDpmtZ+JzfXd9Z7TsHT2QPARZH46TsZnaGBIUjGHdaVpAlKFC6znipmlPUafJHE5dzpfwA6ysqYdoVVMkwyvOsQxVDf1WlQp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(6862004)(5660300002)(66556008)(8676002)(66476007)(8936002)(66946007)(2906002)(7416002)(83380400001)(1076003)(86362001)(26005)(6636002)(6506007)(6486002)(54906003)(6512007)(316002)(38100700002)(9686003)(41300700001)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6HJSWzFIlivdblqxrKEOxReBASaNJsznQAzEXvCuxWBaX5Q6GXF4DGeo6WEH?=
 =?us-ascii?Q?0QdAJ1oUe80IXiaipQ6RgHZwWaHoXeoBdFj/W9iME3kL1mUl+Nazm/r1KY2Y?=
 =?us-ascii?Q?FYQB4YfIfhnkh7P6lC9VPNHEigAtji3P7kmv5WhBRfXXUjvFwiOvYF5NkrOp?=
 =?us-ascii?Q?qkU4JTk0ZBltXZKReE3RrKLi3Pr+ZcBHmlwvogePqebx8MG4pWGArMWSiwan?=
 =?us-ascii?Q?0VSbllu/x7b3NpS6bgwabwZ4qETulNlFwPJEfXGpAracLyUxeabHuFB7BAz4?=
 =?us-ascii?Q?kJQIx8JhxERhaohM5cOEbnarTRje7AyGqqNgxkBklAKYchB4swmRgpn01dyK?=
 =?us-ascii?Q?VifsTwaQ1dIRaqSXccpHjBfVA0UuIk9vKOL3c/q/w0g2qw+mjyMyVywu0msE?=
 =?us-ascii?Q?ZT5q15SIuiSkIHtL/cV6QhChnftHWx2eb1p4fJKibbP94mrrfKTnpohFWty0?=
 =?us-ascii?Q?ByDxVBgdTbzhAgunIC6GVAbwL25SZu8zdTW3gBJI7cp8JRMQ8uLV0PUt6z+p?=
 =?us-ascii?Q?o42gfg4xkWdNBfcGxMpOCrZBAui1h6VVXzysGCMKuxVXeLDrHZ8knToQ+94N?=
 =?us-ascii?Q?RTiPISRwpUfhUZGzEm8MeepAD5f2tNz754Ude8AmVi8GXGReiu4l5DyKVnp/?=
 =?us-ascii?Q?dSdNn73RcvRY2FYsojnLd/HvDnp/WsalI/cjLmGwX4Tx9a/b9IkmSf/nMsF2?=
 =?us-ascii?Q?kiMWXPPjiLoME8u4ITwvjzwsFslQ6A46gi885z97TaxE4SluLycEukla5eDm?=
 =?us-ascii?Q?eY9+PTMjuncOZzqjj8PLiob/csWQH8GPSe5sx6pfSybo71vVFfw2MPByvsWh?=
 =?us-ascii?Q?uWzxIN3y0BRj8IxEva3/nQTfeT/CDCbnkZsZ/JEGgSOX563QJhpmJguX2Iif?=
 =?us-ascii?Q?qTA8JTg1d+Q58Tp4+hg1sw5vgmMzptZpRBx/mDok00/Pou8yfNHzpLyWo6M2?=
 =?us-ascii?Q?tYKB0rExM1/PwbVY2DDsDQbzS1jHzSx2/HVmERutLnlHW4Zx0loHwjjDbkiu?=
 =?us-ascii?Q?34ka1yhGx8hwdjXt26VMAoH1w4d1y0bDQbR1J/lBKGt0eypUyR6hba0pXnHO?=
 =?us-ascii?Q?XYR+60syB5F4RqVCkHX+en4+FMkVbRYrrEO7Oj5TZQ9mrfYzw2RyMO9bnORN?=
 =?us-ascii?Q?63nrNEE1NstEbFjAQGvCIxO6q9kPMN6+1ypdqX6qhsaI+Hlep5an7eqtt8xq?=
 =?us-ascii?Q?SlS9BZiEh1JSaeGUN06cOqPSHtFPGqtKzJgoy2s7jbGXiv3zFkcR+By1b7uL?=
 =?us-ascii?Q?o8VI3BiBAMFPZenLpwvwbOhBC1d3ifm3OWfvF/TwNwTP8APQGLg2KBSJrgi7?=
 =?us-ascii?Q?ePHX+/yoXDgr6w/1Vg5J1An9xJCaUDWdhrwGBYPIz+nDMAMHZXC/B24W69zI?=
 =?us-ascii?Q?fbay4h9qatt65/EL1TERgvjk8B0oCU33KpG9pj46BFtau+8J6OdcQ3QBJWcf?=
 =?us-ascii?Q?HNiz43c+als7nqa3PKv7Vw48SFyWrUeIvNPc/sZmWaPnIgdw6Ql6ac1maZum?=
 =?us-ascii?Q?8hacy0jO9/rB2sLvU8bYHbnZeS7t3c39vC5vQVVHX6pE9LJIp1Ty1fqDDij/?=
 =?us-ascii?Q?HaFREdu9tEpm1J60Ps1vxdXAn9RBhmKaXBzdzZV8+rOo3ND7tmyhev+CJptk?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hVc5h9QLZASdl3C9PIu+c7nrw95E483lCelcujSpcY/znYqLg27bycMGe1UoGiVFYhTw8IQuoOMb2sBQwMKLH0pZ3aXRxpwnMByACACFZkz/PybwbMimYwnc9LhDHGed9gUfUhIWTE5afNYKnEZ5DKmA/WSHjiXkR39GG2N6ZFnF7cX72Pp1LNDQV63OuPmKYZeV2Q++X2S0xb49CZQNu65dj0GlWE4OzCNAG958jnFXenO8HWeSzLqZRaxMuaOsUvYgr8JhZq1W6nO8lPXKwvaOMheG8fA0nXLMP91MJn3gLWTMtzoBgUEEy4kRPHkPWCTePtNLFoP/FTGMaCK2vxkUIEFN5xrkvKuximMKfU+ayJRH38kGGufb19ptRii17gCCFbtxwG0aIMyq6URuvUbLaKRc/Q6ubfm8p/k5Ldkps2SpI2hQRXp671G5U1vatSBRO23Gimjw0GXCzhJPjVCLYeg1eHeP3R0ntAGpXeUVHJSZU6QdaG3W4h31kbsLd0bYTg35T6wUwvzmQ0GfLMOkpm83PPkYS9CqXnDKO1w0AADSdK9OrpxTsbTF3jImllZAJdX8RXqgNyhFPugvmefURuJV/dT+2tlgaJ2+wWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6473cf27-04e6-4fe9-7228-08dc2e6a4e66
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:08:49.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aydEhWQ3vqsfGMbubDF4O0tZiG1PujP2RYpbVTAId5M/P1cj9XKXRLq0F6yMneC+BXGa7pFFoNroz3DXAclZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=963 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150168
X-Proofpoint-ORIG-GUID: 33f0wMru65IlyBrLpdDMOK6lObSnm4ub
X-Proofpoint-GUID: 33f0wMru65IlyBrLpdDMOK6lObSnm4ub

* Chuck Lever <chuck.lever@oracle.com> [240215 12:40]:
> On Thu, Feb 15, 2024 at 12:00:08PM -0500, Liam R. Howlett wrote:
> > * Jan Kara <jack@suse.cz> [240215 08:16]:
> > > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > Liam says that, unlike with xarray, once the RCU read lock is
> > > > released ma_state is not safe to re-use for the next mas_find() call.
> > > > But the RCU read lock has to be released on each loop iteration so
> > > > that dput() can be called safely.
> > > > 
> > > > Thus we are forced to walk the offset tree with fresh state for each
> > > > directory entry. mt_find() can do this for us, though it might be a
> > > > little less efficient than maintaining ma_state locally.
> > > > 
> > > > Since offset_iterate_dir() doesn't build ma_state locally any more,
> > > > there's no longer a strong need for offset_find_next(). Clean up by
> > > > rolling these two helpers together.
> > > > 
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > Well, in general I think even xas_next_entry() is not safe to use how
> > > offset_find_next() was using it. Once you drop rcu_read_lock(),
> > > xas->xa_node could go stale. But since you're holding inode->i_rwsem when
> > > using offset_find_next() you should be protected from concurrent
> > > modifications of the mapping (whatever the underlying data structure is) -
> > > that's what makes xas_next_entry() safe AFAIU. Isn't that enough for the
> > > maple tree? Am I missing something?
> > 
> > If you are stopping, you should be pausing the iteration.  Although this
> > works today, it's not how it should be used because if we make changes
> > (ie: compaction requires movement of data), then you may end up with a
> > UAF issue.  We'd have no way of knowing you are depending on the tree
> > structure to remain consistent.
> > 
> > IOW the inode->i_rwsem is protecting writes of data but not the
> > structure holding the data.
> > 
> > This is true for both xarray and maple tree.
> 
> Would it be appropriate to reorder this series so 7/7 comes before
> the transition to use Maple Tree?

I think it would, yes.

Thanks,
Liam

