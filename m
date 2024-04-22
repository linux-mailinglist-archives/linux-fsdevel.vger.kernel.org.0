Return-Path: <linux-fsdevel+bounces-17392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CB8ACFA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4296B23B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFE15219E;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dUhIns7w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k0XH9+XP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BC152169;
	Mon, 22 Apr 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796858; cv=fail; b=Vw1e9EY7rRwJuRlyKUw2vRkFczhRw1rr4raX4Zo1Xm/U+XgE0bPXmChLD0WgsdamduaNW6EyKwP1JMYFq1sZNn9/UY0Lpwmti0Ed8ntzXBv/ccrW/KWace7VN8OvL2yQOMewCe1miNM6Cf0C3LxyPeUyNpt85lKn3MxUrwedD+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796858; c=relaxed/simple;
	bh=d8jHRDYVIci8o1q6FyxHR0FDsFP3PY1DVBtiTlJfmwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+QEBwUEzDCRMe3jSOeb70tMRPoPJnjGEjZCWKZ6XQjX0xWSLpduVbmF4dQNwmjNM5CCiXYleAWpXonrRGzjJfL4qF6ds/ds5XZ/x5KdTZLkE8M5ObIGOCE+HpcXGC6qJdQ2AEDOpfpBIst+Q9UXy6pODngK0J9aIbOrbDxinsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dUhIns7w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k0XH9+XP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDXwDO005320;
	Mon, 22 Apr 2024 14:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xefVs4tJk5WRWK7zeBsAkORSf9tgcB2s8eHLN7n+TXM=;
 b=dUhIns7wKTHEYDddnTYjBsOoC2O1fJqva18LflAITTgRMS8//JKQQqtlkYkMeUDXmUaj
 812fccUEeMQu22MuOvHQBxTJvJ8+bgVQnZdDXwcQXwXYv9u2Rzba7jQuFkxNqu41Wcvj
 Lu/0+Z/R0mOFpH+fH2mxKtOFM5YrXRpvTtPR7sCAI/eQZeFOfuDQFzyVLEPsVdwyQcyV
 GF0OSFzaOZwCBAda7+uV2qI57vUiIi5y4Bzun61xIzJEpI6lJdJcWeqPlfZPXPp7S1Vv
 E0HB8y+oiC4uqqJ7UnOY7lhwtG9KGYmCbov79Iq9sUZl3MY49IFhUgpRVXsT7sZA+qXU Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5rdttq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ME73O7009698;
	Mon, 22 Apr 2024 14:40:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45byksu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSaWZ0GsRznrrRlegO7GUo0GusdLNW6RZ4rxeES6RbDLM1ejzDLhuN3JljWYDGUHjAU5G/0zj+/tbZZgvCoslgi71VrRlt5psCWgXwsAuUWAJyQ6dbHa8P/JBb8gSoV5fBeeW+Zr5M/VCEfbazM9XXav+ElyffVVd02knvzglNEnqOBo3rznhlF/72hPqOFWL33uoh5jXJsuiXXeodFHdpI6xQ6wIBfBnvyumfN2FNfW0lU5FFmKiNHm/NLIW3IJcn9zteXhiIfqBWXZmzwz7p0w8CSf8C/KtVMivkUebwRMrCQCABoiTkN3H+gJQVkr7gIwIUmqkjJqVD+4ajFp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xefVs4tJk5WRWK7zeBsAkORSf9tgcB2s8eHLN7n+TXM=;
 b=DruwAtGRZ8iIVO1dM6IwrEpcFZ1zAtKOFCPnpbEPBJYjRDMzc8ZVMGfk+vt7kQZ9WrI9PueWbaor2MJ84JuqsuSJdi8eAdqcSmqI1TZdLh3z1TKRgsyPfxAvi4Yy4Sj83aOpkj4Ek7wLXbPUDq3M3jyurAA/jpLhh/whW5x/lPUDcdSW30gXJCbPjjQD8ILp032dWPfa1kR3PG9mNxiCkMVeCmEgckzXcpnCAk9XSUBiZpM7otfDdPawNzdxoQJ18UFn0R8zWJceBlB8ltX67SkgtODg5L6JWr8NKIU2ppzxB3SOtBtEUBv4mQHzGHSR1d5d6eBJLOW6xyxckIw1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xefVs4tJk5WRWK7zeBsAkORSf9tgcB2s8eHLN7n+TXM=;
 b=k0XH9+XPaft3FeCnUSB9Ye+sM/YXIia/BbG+ey8S1Wvy+sso6wIbMQ36If442g1FPPEnLy/amHZasnGSC17qCazDv+ewfbE1VRUaG55iGdsb2HVU77GI6mEQ/+E68zW5DJr8Ww2jshha4FVoOkgNno09i2ceUJW/6kT3A/iBygk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 6/7] fs: xfs: buffered atomic writes statx support
Date: Mon, 22 Apr 2024 14:39:22 +0000
Message-Id: <20240422143923.3927601-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: ac170589-52dd-4bfa-e223-08dc62da26a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LiI4/SO/aCHPjPGACdZ8wKOzSl7/EM4PstNrkx5mNzG2d9B20LxiFtFLf4Q4?=
 =?us-ascii?Q?m7p14equDqxjctvSEbLyZ6x6dgI4RMrdOhr73OXMWe+ZabcUfZGCv+jKAwmE?=
 =?us-ascii?Q?/8zrXa9tYxr/XadQNwnmzREeP6xzajQavCUCzHcsz4KTHoYOHkRwzcxSC8af?=
 =?us-ascii?Q?ErMq+Vk79DkIbLDNdXqBsmKdfk1d9yuOo5PInWF2OlcKEfgyQIJwWT82tUoV?=
 =?us-ascii?Q?BMsvENBxQL/wpc/k7azesR5Mk1pesf0zogho4jtEdmUSGfm7li0ZtMzs8fQU?=
 =?us-ascii?Q?P5+bx0KB4DuAH9cK/OGoezQRtwlXvJjua/RpISOUW6kOPdt416SebYiSoe17?=
 =?us-ascii?Q?MbEgokGhY+ZRKHt5av4bZv9YSs72Ij5hbvQ79YWMjAeBhrw85SCTKkCP/AWE?=
 =?us-ascii?Q?nl7U8ZC9v57+ZPYjLppoYsrPvvO3cU/fY0He4iIarQ/qBFJhZNmRDyZ71sYr?=
 =?us-ascii?Q?XBFFB9C5WI0ZAUz+PbYIPkTPs7fjCq+n3JTsPzdE90S/QRy8wvRNjDT9MXyI?=
 =?us-ascii?Q?AOWSHzkwxrcASxEuu6VSYId1GMwF98hHeDPNhqxU7oIOjafAaGr66IXuFiQh?=
 =?us-ascii?Q?F5Plaqnd65jhZUPOD7PUdkPsuYNq+iSv6OGr5//TUw8NWQT17DlvqpTDf3Mo?=
 =?us-ascii?Q?8zgAmczpB9sbFATk6s9V/ftuOBh2/D1R5yUWtE4RVxqd3sIEMBerkXDrwSH9?=
 =?us-ascii?Q?u99Xu1qA2R2+jTGbMSSNT7soGujZJqyif3YHr9HuucbW4eEPTC9dxs8FXimu?=
 =?us-ascii?Q?biRft2fIQdJhtMa8Iox/RprPgpAfE0DOITkN30yVULEAOeT/Vh0JmnY4NxM7?=
 =?us-ascii?Q?zk88k8Afe1osRm//8AdnJn3dFw3y2LlvWuR1Xa31QoHmInSbfbmqUS6slfQy?=
 =?us-ascii?Q?PLgn9YZ5BenzHIAaawVqsXY3Fo+rtUeVecynJXueaqzkkfQui7/fb/c3b1vG?=
 =?us-ascii?Q?KdeTCCChD867F6UhEyeZcgz1R6o1h7n7/iU5uuo38OZxbjyNCd+uU2tzwGGV?=
 =?us-ascii?Q?IJLu/bKneF0PfcfvMt6WFgoewzqzEhOTt2HoiY124WKaFmY25rqfNZDTOCzA?=
 =?us-ascii?Q?0aGYWx2pKNeIN5X8885kCHFr8jkbHhj//6nov2QzEl0cIS6FDIBzsxsWE8jh?=
 =?us-ascii?Q?mxDAqjfrxx5WaO5mHVTNQCxCyQaW7SYJc0Mo39o+gviWuby/TEPnzf5b2rEz?=
 =?us-ascii?Q?CxXruoSM8gw/VRvk7G6m/Kl3hi9LG+s/VbJW0HgOyyukgqbgkp/MeuLGBNOJ?=
 =?us-ascii?Q?zOxlKVaLf6KcpHMV4sZgOTH3903/l+fF8Lrld+WE+omRs2/9YhN6L8aATZ+Z?=
 =?us-ascii?Q?aWendJYMECu3FfhkIrpMJMyf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wPW9obOt5Ddm+/RFtoq8uBTXUStdVA5vKBH3QlS32XKfGeg2R7/GoKGeD9Ov?=
 =?us-ascii?Q?eyhndDnPyWHaW5w6mqqoGR2y3Urw8ZrnjeDcvc4RDrsx4qFfwqyFicOY2QwA?=
 =?us-ascii?Q?ds99LMR02ENfJfDenEGu6gINU29Uy9SueoB+J5WowwExSNvGjIV0pGBgeSRU?=
 =?us-ascii?Q?FBJAAr79xoPcuoaSudd+C6tyqQZcY0AeGgEP/ZhvC/ZZiUuwCqwLLe4pQuHR?=
 =?us-ascii?Q?rw7vGhAFhqk7+/erWTwx8l6TLC33XhHSRj1Tiz+jZCb89mT6pXxptvVCnJVC?=
 =?us-ascii?Q?8KKNqV4ZPSL8ktFQkOgmOpgmNnjOEEbbMBEZSWxfe0EiUZJiy6vqcoPV2u4q?=
 =?us-ascii?Q?Vaw0IVxo/GEY2ur7mlmJrsFqw38XIueo5UNFTjh4pECd0iR6SNy2es0sZwEU?=
 =?us-ascii?Q?HWjycZWLGfi1ugAs+mPKr8i9paWp2Er/UCY/GxElZ+HBLHdS7SOLQPsvZ8Df?=
 =?us-ascii?Q?tZFLOF/NuslJHdEYtT498mm4/DUUqI5MJv8rsz9wE+Q7bZw3UYroejohltAJ?=
 =?us-ascii?Q?p67On7pmykabGmZPP2vu7R45xufwLJdM3he28pzHQQ9R4luYn6alcWxNxr2T?=
 =?us-ascii?Q?q0VuwaXlsblHnLPwoACwqn5mUnhxOb9K9wvpi2hYiOxCrXU/8QHbzOW0qd8k?=
 =?us-ascii?Q?W19tffzjpHwBUHBcMeJIl9WbfBrRRnFHdRlP0bd2wfTd3ALafptZnPNZd9jf?=
 =?us-ascii?Q?LFf2JztGOX/V0t68FajUBg5rKknf1N9O1j6Hxtf2L7MstVuu/2Zu5UzbBM0q?=
 =?us-ascii?Q?MBL4s2WveJTJtsZw0p8TP9wxsDYgTUDJArVMa1qHBueYUfCIXvV9tRsJ+yNL?=
 =?us-ascii?Q?XBDJmf6SteDwdxp1jig0FCNnGmpmhL+KyelBX/mTDYQlP/fP0cVBYDh0RAYE?=
 =?us-ascii?Q?gkK+/Y6jQIL6NfQTL3rN5DNzNpkGtYfoWKNPjUSAxvd+CJ2T7MRu6gMkJuVJ?=
 =?us-ascii?Q?oSBYeG9WUVzpkCdJBtZ5A4x8c0ldjFeBQSNGr8eYISsf6kkGwb0u97qBLnrD?=
 =?us-ascii?Q?8epxh+Rz/w6fucGdFPD7EWjQGsOeRerctMvjj7nAP8n/pSJM/Y4igoH6EdmX?=
 =?us-ascii?Q?veDPFXXsZHYbz7xva77zmVEjpbzEkARuNC4x4t6Zwc4tENILvWZ/mcGNsw8u?=
 =?us-ascii?Q?e1f56fLO82pyD+O4lDEXiT7yKVRLfOnwHevM+rPAxzOFHbgX2Hb6UwhE2H2V?=
 =?us-ascii?Q?Y4VuX1reyFgvZaNOxHyZBkZx4sfL4LJ4A/IbRx74+gVExf6NFABh0q+5GikJ?=
 =?us-ascii?Q?fzCY2JI/VTMdCkc0JM2VZbM6ju9HJIk0a9g5Qc7+IGPF7Spgqbt/wpedlTLC?=
 =?us-ascii?Q?pFxGSpEnoDYz0gtarwB8c24doOuw48rqtGvGmA4UP/HaIAFIg9JawyEZIofB?=
 =?us-ascii?Q?E0QyPQa7dnmp2e5+qQssEUZ1aiLbE4PdigipzogEVQVzwmXTz2fFH9NQGH3e?=
 =?us-ascii?Q?qC1aVJ0WlWvrsmQlFTwQbZ8CIMdP6/pe9RjAbCq2aBxaJ6N4kHwY8cjyzXXN?=
 =?us-ascii?Q?EFu5UR/9KoV8ZVy6KRQt38Ns7NRL/8cBKZ4A4BJn07wkfWABBTUSZmespzD1?=
 =?us-ascii?Q?CxheZWvUZc2yV2u8Ty8YukHXk6yFCucaEvath8Ikpie8PC7s594ZsB4es6Au?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xoCdW8nECbOonv/YBN4EqjD5cTZ3lA+68/IKNn8V6rJIoCPmj/rZQ7yJUSUkKDj8/n4UNAT+akjWPBkXlbwPiCqW17hRFbnpdghgm5lzppquRW0G3rsVU/IshDAb/N9/uKvxy+vCESHp2iQhSWYwE+2B2rdU+M0XlxISKGHP/WYM8hJZXqz2XINVrCPbzq16bbjAF6ZCpsiusPn8iF3FcUA+8VZXJMU/5fNB8+7hc2VMxdz1+smnevtE/ET/+LOj36JqvZx4mz7fYOU2p7Hr3DNpss1AKrAYFLK+6apE7f3Nx2B+16Vf5B1fAuqQlunCv4UBqiQsY+LJziHXcRyVw4PMr7qXmd2E1/UZba7SJqXKv0a4a88E7iAyTaZKxBwf4EnztvH2UZCgavUbfXmx2pUPwBTJw8LVvkJLeFxb81gLPyUIbz6Q730gNRqyhwmAm3oc/YJnuGp3Zx1jdZ2Q+3WJF8MZ7G4X7xwq+XloBt46lOABHQLMXBVCnXOUuUR9QUj+rPpFgdctyX6cubLQA8wzmsvrrezodEAkQt1KFqzlRpC1SQ2uB1cJEh9B6v3znpGX8oc9ZJO1bwrAlVwkx/Jc94+fv1ltZs3Q6S4XBBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac170589-52dd-4bfa-e223-08dc62da26a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:27.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzmzxJlR+twt7I2VV11Sskfcz1PJ0Qem3OHz8lXSUNo/pCPnbcIrWauvgdfv2+ee+NRYwlKAyJL6xHDIIGeF1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: qPHEibSr3geO_zjDXyDw2XwNDBdWlA2G
X-Proofpoint-GUID: qPHEibSr3geO_zjDXyDw2XwNDBdWlA2G

For filling in the statx fields, we use the extent alignment as the
buffered atomic writes size. Only a single size is permitted.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 05b20c88ff77..d2226df567ca 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -650,12 +650,19 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
-		if (request_mask & STATX_WRITE_ATOMIC_DIO) {
+		if (request_mask & STATX_WRITE_ATOMIC_DIO &&
+		    !(request_mask & STATX_WRITE_ATOMIC_BUF)) {
 			unsigned int unit_min, unit_max;
 
 			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 			generic_fill_statx_atomic_writes(stat,
 				unit_min, unit_max, true);
+		} else if (request_mask & STATX_WRITE_ATOMIC_BUF) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_max, unit_max, false);
 		}
 		fallthrough;
 	default:
-- 
2.31.1


