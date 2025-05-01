Return-Path: <linux-fsdevel+bounces-47826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F05AA5EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 15:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CF16C479
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF11A3150;
	Thu,  1 May 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SCA5q0i0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GyiFxotf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8693597B;
	Thu,  1 May 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746104428; cv=fail; b=SGCgcZIgQxRQLrFGH83S3Nh/cmWcjcdIwvjunigjABw35NazcJhdX1QTo/QVhg+439GA8j/iGVIDhuSphm7bwJ7rGUl2+Uhtdm2MjqIRZYfJHcgdijzlIq//XxjlFsRzQMmauP8/ELKrSE/5r2OA7timlaiuhJgXYAG4O13kYdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746104428; c=relaxed/simple;
	bh=ZOi49/KAp49vGfTFBMWoEKV7Tm6zVxRkNKLN7oXBWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XaFd7hw1W/+e7sQOse8oMnuBe+qRKjTJe6ojL+i7sqruMMmtFpj1h5rrbGO1R4plr7r1vY4xw3KQ1lTAxVC8l3SZDBXYjmGlu9FQkIDcx6IYFhqbjcrMuy1vZeZA3gHSGFKcZ2HkrQCd0DPC5gDSEfd2KLdW++7Fgg1Z1WhrFYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SCA5q0i0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GyiFxotf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418fwRt001867;
	Thu, 1 May 2025 13:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZOi49/KAp49vGfTFBM
	WoEKV7Tm6zVxRkNKLN7oXBWDk=; b=SCA5q0i0qVJVyTLwOS8rJs5gx2Rj6AVQbC
	bacrmCZkFpagna3RVf8gurTXhUk99ktwfyI3weCkIZXfFa0wBT8UnUk2DpdQcDY0
	VzYe9xONzToPO3aGKYcWtZvKBCMkBV9xZ6dV3y/NapvkyyHrM6wvdbqNuxu0ZRjJ
	N5CgL1oCLa519XneKH2tJPp4XU3Nl60YqeD2YJMl8BLV2o8RzDKoOwD8YRX4+eeu
	3/foIa/Odrh18e1CAcVi7vr26GU17U2uylIj5414yjf3CwOl2mg5M9anHM1LjyF/
	7Qwh3rqBigzkAIvFS9bdLYMs1SvWMl6sYohqjhC+pZcz7BNeM8Jw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utayq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:00:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541CBJ2V023735;
	Thu, 1 May 2025 13:00:06 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxjrnpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 13:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XujvKnoNe/Tc/Ahwxbv3YbZFqERt3N9EaAJ/gGkCZdWDzwNtBsF14LQ74h/inWFtCflLCm962uE6JhzpJFipso7e7pQDeh7uAItcExY3ueq5pcXcmOE67D3oVB1LUqjN67el6bolTDn3cUhLQr73MeGcQEjpUr1OeUYsjcfIXtKOTsNZglMR5yQYqfmmoIAnh27huLbklaHvS5DLGB+UM3PV55/L6tqj5n9XnaUiYddjaXJ6/bAzBlk5BBWAjlgZE5f5PynkGeekR4PDUqZa7gpMgGF10j0u2LTvU/Jr7ltMgDrvjHcAoxypk37ACWVzRqRsgjMDTnrc/YivtFpXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOi49/KAp49vGfTFBMWoEKV7Tm6zVxRkNKLN7oXBWDk=;
 b=dSoIi4+gT40sHnUjQTgxuRMV5+0tCfCcdFbS+9BpUDxkvKMLAWV0jei6MYGYY1Gci4u96MZ7beC1Spt4Cq62+nRKRPnP3wrAQe80VjNVWw6FTuGduvrCCsJikmCAGpJYqjgS6wQeiBU/Z1qWSECdthZbPn1Y08bofiGjqE6zJjd+1conOwGWxmQgAdEh15T5FIgaOhDRXoz8oHPTeQBW6mjIysP4wz2R5PQxmXhMMZLt/psrz1NgARBh2Wa5wf6dBBT2x0G8AogF3PwFrd//DjoS2sl2sqh9AUKSP+Zh1nGoVXbXq051CUgTxnSLEum8AzHiqLfrCdzSKTW+6+WEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOi49/KAp49vGfTFBMWoEKV7Tm6zVxRkNKLN7oXBWDk=;
 b=GyiFxotfdLu3iSeZNhphqRoiaLLgPhq85WrLnVImMPRXgcF2NsWUBIfy9qNtpC9E7oCyxKDwGyeb9tkdH02dS+YsGqnc1AfHCgKl0ltiZogWOU67Bb5NPJ7YJPDk83oJz/oIIjSeneIDFd9J/WJ5zahrAvPv492iW629s7OdAKk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF2BC420A1B.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 13:00:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 13:00:02 +0000
Date: Thu, 1 May 2025 14:00:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Message-ID: <e505a8d2-2407-441d-8225-b7f94bc2b953@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
 <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
 <982acf21-6551-472d-8f4d-4b273b4c2485@lucifer.local>
 <aBNmQ2YVS-3Axxyh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBNmQ2YVS-3Axxyh@kernel.org>
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF2BC420A1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ad1ff7-6523-415a-8a5e-08dd88b0164b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJvKR3nRRkiBvDq51z5EeTSE38AEje2pldFEP1EbZZCoVJ5pCJC+vwYnqFpG?=
 =?us-ascii?Q?5rntycn2qmDSu0B6toIeBNmA0iALUVGlWkFI0DCXBO3shYugZNsHukCV97dx?=
 =?us-ascii?Q?nJl+jg8HrRy9tgROUxIj2ThMLw7J588Xxxh/kkf1tJgtkjs1MsjV/DMMF5OY?=
 =?us-ascii?Q?lho4TLMJqX7bEt0ddH782I1SuzNiVn08BNgyAqKd1HWuNBTwXaAfkf2fOGkd?=
 =?us-ascii?Q?cKssRl1QKUAYk/rCaWzX2mG26Gmp72jauxiAom50F5kW5YGKuaBr1XHAbRm9?=
 =?us-ascii?Q?Dmpd0vgwLhS1LEVRvZK/ckXgCfdJQxHTHK2TuTKwI3Ejke/kRsT8/6O7EMLy?=
 =?us-ascii?Q?fN52kLFRmQ1XwTGHjMyCyRaCMAdUt/Daq81vUW+aDh83XLc6Gx+xyMEAbGfL?=
 =?us-ascii?Q?lDwVxCtDKOqgvlHH65noEdB8aRVQsZZSwVEhivw1iUXLDn6rIOS995VQMoCw?=
 =?us-ascii?Q?6tQfv9UG69bC/DT/sSza0JNUSkC2Q7gSlA9gbilQHZgxskblVS20EKK1Ytpn?=
 =?us-ascii?Q?hoY12NeV2cF9x1FgfXkTu+8LgP2gl29XFSPF0y9wTyUZaaTc2V1AUU7oi7Sb?=
 =?us-ascii?Q?MRUXysb5lYAQ2GpBv5N2OfTwkIU1vkhBJviPV+eQovVucpzkfai3UPc3/SRI?=
 =?us-ascii?Q?okfZCmJlmp/VNGTMLRbzhuL1P37UI/Drh+GQo9UgzU8r9zF8BtK6Amf7FwPU?=
 =?us-ascii?Q?YNvh2hP8BzOSWW+kjnrfvfeL3r0WMoTfn8Of3WsKcHycFbtwZLrXieZcLslG?=
 =?us-ascii?Q?cq1AC4/eFofhmbVDO43afUNCTZvlIRYkQah80oVhh1fLUI4T47ST14c7NPA7?=
 =?us-ascii?Q?Vf3ZpClDnI/EPKgzKO7mSYaRIYAvT6+kBADEWNL3C+zDCBIfnBdychUdvXhS?=
 =?us-ascii?Q?kCIouLGY/aQ4KkYIDYYyGbidIL2msY4QVz/DEDLPKpMjv117nk9mTigNEKuO?=
 =?us-ascii?Q?k08KeYN5X4lwFig+A26uvxGBfveOwfO3BNH0ppkU+kGC80ekNMFiKo/BGgCa?=
 =?us-ascii?Q?BeNoc0dG/RLZY/szGQ6CSpeda1c8Pi1QC8ErLKrvDfUg8dXf7gQIPiJxxPtW?=
 =?us-ascii?Q?fByPUIlHRYupnZ+5qVVBctReONnrzLfbcFLc87FReJB9lwua2cJu5I0XofNP?=
 =?us-ascii?Q?89hm/3cDlGBxvbSfBgNrDDhj84l8SkKhQOIFuSCSh1WAEkKEGR+9663Aj0ct?=
 =?us-ascii?Q?4LppgbckU5M5/FUUbyLKyrkZcVizWHMaqy7FhUwN8yfN4T/6heeD/37TyhCJ?=
 =?us-ascii?Q?YfFX36ORFtyva4QeXc6wOAmOJ8DXDmwVaEFBCKU4ESMmsEIE2ShxoRp3y591?=
 =?us-ascii?Q?8gkOMsys1abo737pICITeA6UQi5OIXW9SlvgSsy+SaaVgDhyBXBFcrb3mxYm?=
 =?us-ascii?Q?w1CwjjrAvyL0atLElsIg23gnqDsbDlZ783fknHxyb4njdveseMkc32nO8qV0?=
 =?us-ascii?Q?qj1iSlZuIhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xzSdWhv7rB6y2Gmsvrhp7DzU7NPcIIf6W1T2Eqg5D2ukopb6nyARJwwWafE?=
 =?us-ascii?Q?kXgkqtCaZUbihbHJQGOATRlTTvZciAe/7ARV7rIoJEX/Pn+3NtJWo3WUUoAe?=
 =?us-ascii?Q?KXI8MIvkvLn7GZGJrOHdzgex/11Xuf7i1dEkBuTxH7/NMMq/zZWXyRGLV4Od?=
 =?us-ascii?Q?jxGx0Y+InJk4B7caUirz8DulC6dZv+tnekYAvmjyeUn+/llbqX7w52FSGR3R?=
 =?us-ascii?Q?r1j4hRRaE6QOfKF1sZlzcp+fcJy9/+9sn9lGZpVZ/8/p/W3SzccaXXKeI/5r?=
 =?us-ascii?Q?1HKLydxZsdNqNEQ5x80cTFz9vGfb41uI1665j0s5XLXLKKwhQyd6zp+nZbDg?=
 =?us-ascii?Q?/bqOOOMUKvyrGdQFEDef0+DevoLXmri6bOvzdc7qEds+B+Mnv/mn6ikZMhty?=
 =?us-ascii?Q?UBotMSBU5oBxtg5iIeC82cVCYLWU8ufNvu78lOpULAhOKOq2/t2mPxtA0WL/?=
 =?us-ascii?Q?bZUqf3wbruSHpOnnZyoqVN8IS0bpv96dxbrlfIMMADCm7PEN4Eo9+pvY6ehi?=
 =?us-ascii?Q?oWgXvbBIWrB+ilHsNSYE3OGPeEtkmIVldn1itXDFe8RC1gOao2+eNUSSQ9Y8?=
 =?us-ascii?Q?J5RBJC1kf7HqG6CklpIRadSLDSTJpEg6cDhCzrylotirnJrw6Ns5SETqWQrV?=
 =?us-ascii?Q?bx5O9rlG7bvs0QXPRR/l4WnUAmeLazlpvLRUvG8ZSUfIGBk7qDNNNZ6KFfWN?=
 =?us-ascii?Q?vBeOpUOIfeM1wPGSlpFi7m7qUGakGfDC2x3okZ+rB0DU2ErwVRoxVsYWILNF?=
 =?us-ascii?Q?c7zf+lrXjnF3y1k7jfazv9Ms6LXz3T6FjC8KAgbFDVvL9B21MdWt7Axd1NhH?=
 =?us-ascii?Q?4vHMerw7ci7Tu7oxayF46UIP70TMhkj1+9UTFrEOx12LaaGJoEcgmmO2pEm2?=
 =?us-ascii?Q?qDLjp56LsXlLjXX/nbwGrMNsI0m9CrqeMGnatFs4/NAPi4HcLE2v/XwO2utY?=
 =?us-ascii?Q?VhqD3bG9EgbFuIKgF6SVe1t9x/8MX5en5fXi9CV/zHurbV5qmXdbp9K1Vxph?=
 =?us-ascii?Q?4nfd8VYx3v45lg2TvWL2TQEHD+3MHumgwadBgOzgdRoosmNAmcwd2imsnh/x?=
 =?us-ascii?Q?00I7joFfr5ULrAjO1+4DBcO6M0ke6DOQS+ZgVIZ27nrLpyR4rCIdqYBUwxRF?=
 =?us-ascii?Q?e+/c7tw1y9q74WD3ULbDrKgdJqO+XQptYjBRPkTKh1kz4kxdgVozLYeOJdEK?=
 =?us-ascii?Q?FXV4sY1+pUmlt/P46g/VoNqMmig60H5xxlA+YAMq9DomF8Xuh5/kB7dkfSUw?=
 =?us-ascii?Q?y8ImEKYu1ghilOM5mUdMBx5yXl/eYATEGDMe4LWOCgBO95+a9sbu0ia3R2G4?=
 =?us-ascii?Q?Cv1z0JMMYq3tl9ZYsIHxPWezDTLx3NJIawNkgfTER264SMBWwkfuMb56620E?=
 =?us-ascii?Q?UwMhgbnE+EqeKVf7HMvH70RU8IH6eVNgEgOqQzvGrfzXOOhI0mychbzKCV8m?=
 =?us-ascii?Q?Se5Eul3LzLEtQtOUOoCGk4hD2lTrJzeUzw7azT45TZaSmylPtgycWKlucnxP?=
 =?us-ascii?Q?/t0IOufzn2r9quV1bnNDkNpVbeiKGin5lBMYWAnSEbPIu76Gql5Gz0eVg2U0?=
 =?us-ascii?Q?2faAzYgugMfQ2BqrQCcazNjaHXKYE+eZdBtVTxpNz2Xt1f1DaDVTLr8+zRtQ?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C2oGDVYhygtZqRXBkmGuMnAKZkuIRYLVAzlmlTmrFytXzPeE5sm0qiZ5tedIoShuCzcAadROU7U1CZHGlHNXnZbZF1uBi2eT/TkhzHwXWFpqDZnimFv3YY+a7apwRw7mhxJrCVV8OD/+PX0c5fCo6eCWZbnGaO46z4Jvq9fdUY29pQW3fKjxpZbI+hkn79g1VvfNXrkLCXmeWdKoXEtPKhRHotdSPHesTRokS5EKMnEIGA839I7sjZEZA1JkttIjTUT+A4XVb/mmXrRn4hECy6pmeWEd5LbUUmy0IdHGjsBZjSY2jcY8qGe1P/QM7sXk7h6W0r+0E29F940rJA3Ot9c9iPVr9DG3CVORVDaz+nV/lN4LjDDZY29nxRweGiFEYvofCUy+p0dA9zBI5gSY5r8wEO+i2hTSEq0jVNgxpHqaAB1tah9fXZRg1cmdwT0Ki6SkSM/UTIYJthFHqBt9HKVs9ve4vYKriKR5pELYpDW8gdsSH/G/wXmip4Xm8yz9TDHuklEgEqqJo+APXlluxRD7uLycDxx9qLJsZ3SNAo9a0MkyznO1Yr8nzTejQ8gt56Eb8uquBsDT2WEg0kGlm56KaclGBkHfnpHWdDN8mtw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad1ff7-6523-415a-8a5e-08dd88b0164b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:00:02.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c+k2OGUVugDZwg6Cj9NkupQuhmD0YNsv6r+HvmXs920BlIsICArOhLw8wQFFmVq2z2fact2xbeB1y2yRFWKvoR4ZTWm/+knxu21Fca3K1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BC420A1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010097
X-Proofpoint-GUID: mhEJDtmfXBOZ8bDLJBtPApTljXXHa5PA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA5NyBTYWx0ZWRfXzn9CimiseBsE u2R7j2VWesFJhX6PqvCs/L+DBCAjYW5usWmt298/BEV4aIaHVwbOo3rPHiUKw4xgfi9JG4/QSsv mveMwxX7PM/z+y4krXPwbTmrmmzOFS8lNhUik9yO2SBpueKnEBPGIgSGug3MO4OLeOg0/f4h8YY
 7vp1YuVo0FJt4EAZruzKblezUZi/mERKC6by40ZsfeROtI12/LH9N1WLjuCQivYfin0TP3gdpt4 r7ydTvwlxXBDy32W/3EvcutTO311IeCrvVN4IYtAImWxEjCwIIe75m55ZDEMc4AJoAVwCeAOENF uN57Rk36mmEMhE32ZqtsCeFoIak9W/Ycml8pjNn2gaHGUbqnFGCHMo5uvjrYjQpcpGYqfgB3GXr
 FiCOm7E73ivPlVyKLc/gE/bilIk4H2L8mybhc7ttLWLQNWbP4K0QAchxTWnSwlRsCe1ZkUS4
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68137057 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=o5jfhA_OkbfByLcLUc0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: mhEJDtmfXBOZ8bDLJBtPApTljXXHa5PA

On Thu, May 01, 2025 at 03:17:07PM +0300, Mike Rapoport wrote:
> On Thu, May 01, 2025 at 11:23:32AM +0100, Lorenzo Stoakes wrote:
> > On Wed, Apr 30, 2025 at 11:58:14PM +0200, David Hildenbrand wrote:
> > > On 30.04.25 21:54, Lorenzo Stoakes wrote:
> > > > Provide a means by which drivers can specify which fields of those
> > > > permitted to be changed should be altered to prior to mmap()'ing a
> > > > range (which may either result from a merge or from mapping an entirely new
> > > > VMA).
> > > >
> > > > Doing so is substantially safer than the existing .mmap() calback which
> > > > provides unrestricted access to the part-constructed VMA and permits
> > > > drivers and file systems to do 'creative' things which makes it hard to
> > > > reason about the state of the VMA after the function returns.
> > > >
> > > > The existing .mmap() callback's freedom has caused a great deal of issues,
> > > > especially in error handling, as unwinding the mmap() state has proven to
> > > > be non-trivial and caused significant issues in the past, for instance
> > > > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > > error path behaviour").
> > > >
> > > > It also necessitates a second attempt at merge once the .mmap() callback
> > > > has completed, which has caused issues in the past, is awkward, adds
> > > > overhead and is difficult to reason about.
> > > >
> > > > The .mmap_proto() callback eliminates this requirement, as we can update
> > > > fields prior to even attempting the first merge. It is safer, as we heavily
> > > > restrict what can actually be modified, and being invoked very early in the
> > > > mmap() process, error handling can be performed safely with very little
> > > > unwinding of state required.
> > > >
> > > > Update vma userland test stubs to account for changes.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > >
> > >
> > > I really don't like the "proto" terminology. :)
> > >
> > > [yes, David and his naming :P ]
> > >
> > > No, the problem is that it is fairly unintuitive what is happening here.
> > >
> > > Coming from a different direction, the callback is trigger after
> > > __mmap_prepare() ... could we call it "->mmap_prepare" or something like
> > > that? (mmap_setup, whatever)
> > >
> > > Maybe mmap_setup and vma_setup_param? Just a thought ...
> >
> > Haha that's fine, I'm not sure I love 'proto' either to be honest, naming is
> > hard...
> >
> > I would rather not refer to VMA's at all to be honest, if I had my way, no
> > driver would ever have access to a VMA at all...
> >
> > But mmap_setup() or mmap_prepare() sound good!
>
> +1
>
> and struct vm_area_desc maybe?

That's nice actually thanks, will do!

>
> > >
> > >
> > > In general (although it's late in Germany), it does sound like an
> > > interesting approach.
> >
> > Thanks! Appreciate it :) I really want to attack this, as I _hate_ how we
> > effectively allow drivers to do _anything_ with VMAs like this.
> >
> > Yes, hate-driven development...
>
> Just move vm_area_struct to mm/internal.h and let them cope :-D

Haha oh man the dream. Though it'd be vma.h of course :P

>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo

