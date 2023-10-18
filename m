Return-Path: <linux-fsdevel+bounces-665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFD7CE12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59300281D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ECB3AC0E;
	Wed, 18 Oct 2023 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yTfBdaeQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T/tavJcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091015AE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:28:31 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D994;
	Wed, 18 Oct 2023 08:28:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFKh1W021312;
	Wed, 18 Oct 2023 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=AaKvkoy9Dv+c8+qR0peK4uV6GA9LUKFHCVfYH2y+hAE=;
 b=yTfBdaeQKlYyl91VFiRiI5PsOkwj/SQtbV0u6HMJn7SObb+cJXsjpQYg9RDrm2zWt3pr
 IiM1TVbXYWdiiWpKAzYaMSYHsntrKIkyc+oHk2+En4La60BjzvY39+CBSQ0JjwCjRG/D
 mFkciNZRzPxepvEOo6KpraJMIrGh8QePec2AAC2Cp/QzKwHMTPG51RHNLow/EVr7xGEO
 9n2WtwURhzAiKJdGMaOQKFZznut46yXCNBNsbyzY1bOWVUsX1PD06yXnCNo7VXT/P0MI
 Umk3m3EYjDQ1QqwSp11fHrlVj56ojUkj0awyKdE3eNXeoS/g9uFkP2JTWiZYnklKAAHC rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jqvg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:28:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IF07QV015251;
	Wed, 18 Oct 2023 15:28:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1gn6vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch9Dk6zspxO6vW2Gx7gVhD1diIRl2p7CgoqYYEiNeAZ6HDtCY+B7YQqGDXjzeenFyxLlHEH68BRZ2vuuidGvN2yzLNRGzicY0/d38j1JMCOo8ivdiI+ydxZWa2bdUFdhIBk/jMhwF4rw0qwHrwMCjFnmBk367l3QZ5DjVyM1jKva+IUET1NmD1398FGEVyD+DJ0tQeTXmciyVI5fuAsmeFKFjPRjo0otMAChpAUleNcpzci/QPjg+hbJv7MjVQ6xpfrb6oS0FB7bzgW1gTLybLGbNXTAr9lInRUV4v1ODLouocan0sltydj958xd5Eh7CvVadcxe+ATMzIc2gEnOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaKvkoy9Dv+c8+qR0peK4uV6GA9LUKFHCVfYH2y+hAE=;
 b=Gr+jMx8qPRqNlxCqegFcH1baWJeRwSZf2OFE/VbwyMWb1QqPu6Ehejb62lWVC0Uf4vgKT4lcuBOC66ohQId51j8BXJaWDUW+t4uqjGA0muVRNMHPAiPThiH0yPnd3w98nSJ+hzIBGVTk9Kdp5LPSigDBpSYGFT8qCU8+kScBc1THIi3GCjFzy9aTTKt+QFZtsxX7FwONHEob0ZfLzvj84sUIQNlaPnWlTjg8DguUcT4c9QlJ3aHBgwFWZVuOc6mtWir/5+M5Sm8DzPdR0SL0c+7v0dEcNZtgQwwHQUuEZ+p6kAAyYS0ZusA8c5Z/vjT8I5GiEdzpKU+KIsGuYCYivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaKvkoy9Dv+c8+qR0peK4uV6GA9LUKFHCVfYH2y+hAE=;
 b=T/tavJcBOCQdVyDxFcEY+m+zZtNCIGPju5YL1DOOKDJH6sFrS+KpH9t6iE9VD4ykV0f11/lZAX/G79ygTTwwOSPJU1dUFXg+aozncsakeZ4Mzfw2WPBJm5sZCOSzr8JHiSj0jopzCp6OlEUS9msywBmlidLmrlwUAB8pEBEiIHk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7071.namprd10.prod.outlook.com (2603:10b6:806:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:28:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 15:28:01 +0000
Date: Wed, 18 Oct 2023 11:27:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
Message-ID: <ZS/5fp4XL4D49q9T@tissot.1015granger.net>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-6-amir73il@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-6-amir73il@gmail.com>
X-ClientProxiedBy: CH2PR18CA0033.namprd18.prod.outlook.com
 (2603:10b6:610:55::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b06a6b-5c6f-4702-fa47-08dbcfeed099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i7BwGkQjmn3oQYJNiJvDh5VNihHo7+UWpOZeO1A2abOoK67cHjYHu/R2Zr8EWBa8vKXRFt0qzD9DbdYqToDiewK/WqdtF+ahPE3HE+KXwNbJnUxtsdj3lvZAGOVhvdyZIURISN95du+1vcu0eXdyDSLhDsxmlX8gG3zE/N2mE5d7fD9F6xM2PV5sgelnRSwl6rOc/2eU4wdpMw1c0ZxS5yDpFxq5Y1p8w7CwojZuIS5KvSL7oxuR2vWwZNBaVAYQUnlL1ZOqKKXUPTjJCSfN9POdpT7W3iyuXEyqbcoHJ59bPV4YE+9x9bV7e6u+4l/BXXIkylmlD01ydJ7uWMRMKBeR5wU1oxjXQSFjuBCNBDWg8cx7v4T4ZkK9Au7VBisScFN3BhmRQMb2a/rcTPSdsV8O4H4NiJKp4i3wwWjpzPF/tyyV68cmaNQGDo5AeUSSwBMTjhIDxjLhYvnnPtyZuYfXPowSZUzUNbL2U3tN1EqhrxoqqZWr04BfM4w37fYNv+kVxF0rlgl9IHWS7twHoD9FkRTvX3kPt71MA7VROXDClVcvmk8yRo8Bg0Aq3fSf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(9686003)(66946007)(66556008)(316002)(54906003)(6916009)(38100700002)(66476007)(86362001)(83380400001)(26005)(6666004)(8936002)(6506007)(6486002)(8676002)(2906002)(478600001)(44832011)(41300700001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zhm12OPfc0yLde+n0l7UFanmEdv4o8ByHDorEIglywIwlzPv66kU9NkeQUYw?=
 =?us-ascii?Q?JUd6u9wxTvnQNQWvsL/7iL6LGzKrU/E2RV0v4dzCNVOik2rNmzcFrcjaeFHh?=
 =?us-ascii?Q?KZumv3x/6pRimoy0j2wjP/rDHEVbyTPqEMD4PvY/uArexpL/hbLJI3HnE/Ws?=
 =?us-ascii?Q?awdditMw4KJ+KDFpGdzaTN5UCLC1dzGeaa89s2vxO0ouSYZgo/JhmoR2QHq9?=
 =?us-ascii?Q?hVjcF/mVidBQJLDrJFBPm9mPXk4Wlz4IVgo2o3Uo1jQBSflk971M8mN1U3Tr?=
 =?us-ascii?Q?DeGhPSYemTCcmPzWeAFvW5+RV90R6hcOmqbBqHmqGXEzYpywKoONGUQ+e+s+?=
 =?us-ascii?Q?jYEkwRVCYBVaPSoifLaAalB3yQdWoQFGRZVI1sA6tpBvWrApPUsE32Of0B4/?=
 =?us-ascii?Q?/OE/+ggtkrUmQ1MR+ny9ByBRbmM2oTp4kca2/g6fgynlw+KGWl9l6RJJ63Np?=
 =?us-ascii?Q?gUAabUZjmh7wbGHFDo4HXBrud9JCqAJOwN8oFrV24DLr337phz70oW4YitC7?=
 =?us-ascii?Q?oqiQUQ/sSd8ae8qu1TwaA0Frli3i8DkalozMCu2qC9MTKa9SQ3qLl6Yr9Rmm?=
 =?us-ascii?Q?CkRymRRt+EYrJfmQqMdTm4LTpPlNRyQjzUlAIabXM3BGUJ4J/CR1Bf3ui4nW?=
 =?us-ascii?Q?P3WWcNp2tMGh5SMrIdeV/v8YuIrsDVD9qA8YLoVeFag10ZcmYAPDgXPSy5pO?=
 =?us-ascii?Q?np3eYGep/XM3X7N8S8BEU22O0PHmhN2nyBaLd1uNXiFycU3IWiZ003aAFYdK?=
 =?us-ascii?Q?wmCcH/yf/mnAmbcnJ0CXycQYnGVXKyMbBnsw0nEkAZjvN5B8yv3OqI/XtPNa?=
 =?us-ascii?Q?G/YkwGP6W2xDUJuKWFisnam8nYO+cbG3l/nMMt+zsEAk+E5Uqc+dITNPkJi1?=
 =?us-ascii?Q?gAAPe2jbA9gFngIU8MP/HzoufEyM/LBARrtu6YMxxInpmZoqeXE5x5lBbOua?=
 =?us-ascii?Q?+3DwogIC2gKVs35jcFXoFmjQc02hZOJjV3G0Mb7ZOpLd2EQPu05Us5tXvRQx?=
 =?us-ascii?Q?Q2foBfyT3Pgm+TBuqy42xWXKntJHjBEYuJwMfPHIKGNGfejoErriMMd6vQOg?=
 =?us-ascii?Q?rROMaUpXsIXhSDcHMNspaFRSR+ChD5FfU2+Gcbj9km6obNx0f6XaE8xObuFu?=
 =?us-ascii?Q?S/f3iK2OGOp9c+gA2FhSPaoLlmsW6/PJ3UnvKs2iF8dPvlydBpYa9AqvisO5?=
 =?us-ascii?Q?UZJL+4UWxYUXFxZ5v20fDAAzyiQouZoxXQJ0Ed3ci19gRIhKeucgSgMisdxB?=
 =?us-ascii?Q?y0eR7Xzi4OvfR7MYfLv1xVyuJLxLaPrVKc4/u/GeBw6AhuxcJ8JuT/tm8fAa?=
 =?us-ascii?Q?rHNVXAnj+0PL84Q2hErO/dxt1AM/xcLoMWb3qcrTszlRzz0r80ZeOUdsMFFx?=
 =?us-ascii?Q?cWuPSxWRuCzNEWrgCfKJjKHwI+OK7MxZ284FCJC9I2lRgiLV9w5JjWqlyo8u?=
 =?us-ascii?Q?HSX3Id/oG+jIxd8ZjNFDGObYZ+UVNgjKnIuT9A6BAND4v9xQ5RyN0sqEezDY?=
 =?us-ascii?Q?ZZp8+zJfz0y4UJZzrHOC4yP0KK5hSsWfInsMrD0BXxou+2eEr7iwO09DUR6h?=
 =?us-ascii?Q?bTZxyYAhHwCut0QYCDCr4xbBymWW1xTBYNFeAe0BMY7kTaf/+8+BkwfyAuS7?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7UMq5FxkTmFXrpsZMFrnJdzlsKwQiOO8Hx83lIG0iBPFn+6fLzFVUV+yIP/2uJooFbeCH59sVQqyK3/+7mJXH/GVTvdNARpxZxchxou0n2gyQr+qjav4DirV5KJGFGbEWMMI+C9mBw0HkOsC2xEZlA62/tBsgUVCb41QuQp0mZvS8yuYHrr66DuGcR5s/QY2I7yf2x5BP4uYg4wssm3sdhDaCypXP80YzxK0QkVZcO8xzd8E/yIUajunfes4qQHKa6YU2BXEX5pac1X3WARX+HgGvU0WzKJUXjle93x0/03EKvvvnc4g91FZpSOLIl7k/TWf2c/662LyCGtOyhwHUpZEFjcVx2kTO3BYojGKZzi25Q7yYf8/Kzzn6d7Hkqcd4l4pFE3DZAkyudYNgWx6AovebXbBlTXE77hCRhBxOx6EIFVxSOum3IFMJqe+6P9OthFv/xPiDWf/JOohjO2LKSnXpEdwLCQ7bs6MboBTMaSXTvvIQJhhxlMRdp3RmrUMhi1ZWhcaDVZRe07jlEQ7eSto8sMQNiVr4HbudZl3CHM8/Mx5QRZ0VSAPxeUGZxQPhfJ78ubc4h1s5+fTP6QZb1CJ0c8ux6WtGnNQeVtTTDqckB3tllqq6k1W6n2v4LyEOvFUzQTDUKle/aI/TdrtvEvvQ+JJ7My0To6uaIHdKXr056KP3Ni/AGy0zIzLjDCjZog+7b+O12kEG/KUrvsLaI/adrxqx0Ujk6M9dMMsy9dsAlHBpZNpmwZvx6hGyhJXyA/1LKqTAbn8b8s4qn/no3tvGC+Wvl5Er8WIbIIiD5LCFTUH5Y6672FBGkhIC955bUK2YmqUgRJJAm+0kGhapQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b06a6b-5c6f-4702-fa47-08dbcfeed099
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:28:01.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9yWRFRYucpqlkru1IgrTARBTa8LAm3OhSUquHnnKY+Xcz4xmUIfEJnIThKG85KPmJpn2fc0pdtfz2kQYb5ioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=920 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180125
X-Proofpoint-GUID: 2Zx2RuHeIO2nq3LjtnpBK2sLYwYPr9aF
X-Proofpoint-ORIG-GUID: 2Zx2RuHeIO2nq3LjtnpBK2sLYwYPr9aF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 01:00:00PM +0300, Amir Goldstein wrote:
> AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> the encoding of a file id, which is not intended to be decoded.
> 
> This file id is used by fanotify to describe objects in events.
> 
> So far, overlayfs is the only filesystem that supports encoding
> non-decodeable file ids, by providing export_operations with an
> ->encode_fh() method and without a ->decode_fh() method.
> 
> Add support for encoding non-decodeable file ids to all the filesystems
> that do not provide export_operations, by encoding a file id of type
> FILEID_INO64_GEN from { i_ino, i_generation }.
> 
> A filesystem may that does not support NFS export, can opt-out of
> encoding non-decodeable file ids for fanotify by defining an empty
> export_operations struct (i.e. with a NULL ->encode_fh() method).
> 
> This allows the use of fanotify events with file ids on filesystems
> like 9p which do not support NFS export to bring fanotify in feature
> parity with inotify on those filesystems.
> 
> Note that fanotify also requires that the filesystems report a non-null
> fsid.  Currently, many simple filesystems that have support for inotify
> (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> used with fanotify in file id reporting mode.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
>  include/linux/exportfs.h | 10 +++++++---
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 30da4539e257..34e7d835d4ef 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
>  }
>  EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
>  
> +/**
> + * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
> + * @inode:   the object to encode
> + * @fid:     where to store the file handle fragment
> + * @max_len: maximum length to store there

Length in what units? Is the 3 below in units of bytes or
sizeof(__be32) ? I'm guessing it's the latter; if so, it should
be mentioned here. (We have XDR_UNIT for this purpose, btw).

export_encode_fh() isn't exactly clear about that either, sadly.


> + *
> + * This generic function is used to encode a non-decodeable file id for
> + * fanotify for filesystems that do not support NFS export.
> + */
> +static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *fid,
> +				     int *max_len)
> +{
> +	if (*max_len < 3) {
> +		*max_len = 3;

Let's make this a symbolic constant rather than a naked integer.


> +		return FILEID_INVALID;
> +	}
> +
> +	fid->i64.ino = inode->i_ino;
> +	fid->i64.gen = inode->i_generation;
> +	*max_len = 3;
> +
> +	return FILEID_INO64_GEN;
> +}
> +
>  /**
>   * exportfs_encode_inode_fh - encode a file handle from inode
>   * @inode:   the object to encode
> @@ -401,10 +425,10 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
>  
> -	if (nop && nop->encode_fh)
> -		return nop->encode_fh(inode, fid->raw, max_len, parent);
> +	if (!nop && (flags & EXPORT_FH_FID))
> +		return exportfs_encode_ino64_fid(inode, fid, max_len);
>  
> -	return -EOPNOTSUPP;
> +	return nop->encode_fh(inode, fid->raw, max_len, parent);
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>  
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 21eeb9f6bdbd..6688e457da64 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -134,7 +134,11 @@ struct fid {
>  			u32 parent_ino;
>  			u32 parent_gen;
>  		} i32;
> - 		struct {
> +		struct {
> +			u64 ino;
> +			u32 gen;
> +		} __packed i64;
> +		struct {
>   			u32 block;
>   			u16 partref;
>   			u16 parent_partref;
> @@ -246,7 +250,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  
>  static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
>  {
> -	return nop && nop->encode_fh;
> +	return !nop || nop->encode_fh;
>  }
>  
>  static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
> @@ -259,7 +263,7 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
>  {
>  	/*
>  	 * If a non-decodeable file handle was requested, we only need to make
> -	 * sure that filesystem can encode file handles.
> +	 * sure that filesystem did not opt-out of encoding fid.
>  	 */
>  	if (fh_flags & EXPORT_FH_FID)
>  		return exportfs_can_encode_fid(nop);
> -- 
> 2.34.1
> 
> 

-- 
Chuck Lever

