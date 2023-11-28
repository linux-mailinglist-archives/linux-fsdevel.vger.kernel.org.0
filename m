Return-Path: <linux-fsdevel+bounces-4045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58C7FBE04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AAFB21B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E85D4A9;
	Tue, 28 Nov 2023 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N/0ZH3pw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPgEdMbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7961710D7;
	Tue, 28 Nov 2023 07:22:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEhijN029073;
	Tue, 28 Nov 2023 15:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=msw9Q0UsdpcozBA+nbVAwsfxHmHY8IgGDVeBUUIlHqc=;
 b=N/0ZH3pwZ22mghc8h8jNiLKEoJeG6jalo/4kx+wiQYmIShU0eU5qcH8gPo3A0QmLYY4S
 mWeHjLEtDYThj6rNbAA1oKbDCvBzxROvve0gN/416LsjQmmDzyu5hJryeyZl/rmUgE8O
 zXcYe6AFsj2kxXQF0WIi7FnF8js+yLVLOfUVYpb4SRlVoQUbMqWyYIM0zjGYu9wi0MSQ
 wA3am546LRyAy5QAuJ2FUsFj2xwblq1+AC0l5Xq9DybexSNzm0I0dcE1/IqCLjGkJ3SS
 +BFzKNdkSIcwOfvaKgHXPH0Gc1/KY3zR1VB8rnmeJTdYB6Yf5OD65Yxss2ahNjwFXun9 kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd65pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 15:22:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFCw7g012599;
	Tue, 28 Nov 2023 15:22:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c7acqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 15:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8gst92TMTA3XPBPdhwgHIQgezl9Jk4HTcJj7ZIbOQKAlwb+e7uctYDMnIy/WOPPDSbBCaEYcNHDhdvTlJuQ92t0fA2w8T+aMyPVD2SXt8pYMsV3k2byNH84lMlNqH++pY8pqR0B6jwYDiNIpBmLxlO8h7QSE1MKe3oHPzZ5BOluS35tEbBCvB0eDuq626DYvaxiGFzNWGe/Z58TXhSBTJ9sSgb9FCkTBNtFpX2c0ClW7+EDHWZZCiM/yM/+cluQw+0B4smKaSYr/1vldZ/0/2wE/7LMsasJHu2O+K5fzHX1TDVLl9hr3OLRm125WeOOls37dKconC5+u8BM9BJdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQyK7/u0gJDdF8mHb9crTI4vh69Hw3Q2YIGMSj84yvw=;
 b=oWiJBm65Kz3BFQVNlX8NqXCVbladG6+abkvRYt3Nxcj23jtLFDWBvWkiwoIp5b5gWVha73Hu9rMELICvfsUP2X96S87XPC/0cZQrVOC+zqnvzsRwVz0GTWDs2ytXljD/1maHNn8nZZFfHTkrCmfH2wHDyRkElC5NM9dq7iB46LXO57HdiPMV1r6vQIse/bOnHl/DpkuEeug+pNBn2YTgJMbE3UBaARTjMQbVC3UwjXSAQrSOKXrV6eRyUOy1N8t1aGKaovzOBg25rIHgwsu0GSFSO3zDmadicwRyEYYFWMA9FgE1EPpT/sh2+/dQed5641iCKfbX/e8XY0zdGg9s4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQyK7/u0gJDdF8mHb9crTI4vh69Hw3Q2YIGMSj84yvw=;
 b=YPgEdMbpkEELrn7uVAdUmbXCCpcozw8nCanirjB+8T4Yd0z+hEZUfY6x2laXd4lF554cL4UwVMfC1nxkwhhX+iBnuWRmmeyPTgqxUB2LUNdzm8bVs2IQAZtgKjdQhpi2gE+hjuD4QhG61CbG6yG/nB9s+4Y5roY3lTgoZ+gxvHw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:22:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 15:22:37 +0000
Date: Tue, 28 Nov 2023 10:22:33 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWYFuWqCmX87C0ve@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
 <518775f9f9bd3ad1afec0bde4d0a6bee3370bdd4.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <518775f9f9bd3ad1afec0bde4d0a6bee3370bdd4.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0406.namprd03.prod.outlook.com
 (2603:10b6:610:11b::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 4845fec4-01f4-4f49-4ae4-08dbf025d9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i9bOJkKyE+eLVRXMIKs9rS7eEyIMTMD07CVN2rbAyD65KTDkW+qz4lrvyydEru8kuGy5U3nf8luXSO+hSGLn3gdPkzVdoznLEIn0xJy/AiQ6jEoqzQDkYPg4P33sodR14EioaAI+evg36wib9VGVmsVHgfymDWVXPZI7FiWugtB7ZHvHA/irUqIeILtf3QhieO/YOkZShae3KEPxU2e1+LwoTtmZBsUWv1eQFQlKTEnu4nPWk0F7A4pPIUw4SU0flByQeYiHIaBTnSU9d60P5c8Q3BMA3qrMv0glVCH/TXEBVtMKk2FeH/d4gr6nsX8hF3QIC/6WW9h8h8QtFUJOFH/mAzdcPZq8XedH1HFeuAYa0YJq/VyNb6Lg5NlOa6z3/f6W4ySUlq3j0+l5NC3K6CS0AvehhlIX0b2fax/F/L0vb39wScJnRkbTww9z9yFn3VS21rbmlremywLqMnSuuYmfM2TOPha/E+sOmhAgS0oHiOVUTRmvLJeEG6A7JC3b3w3lnAPOZAOsEEeBmd0b6ZEcRlU3C4pJ995d6a6GnjU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(6486002)(6666004)(9686003)(6506007)(478600001)(966005)(6512007)(38100700002)(86362001)(41300700001)(5660300002)(2906002)(4001150100001)(44832011)(66946007)(83380400001)(66556008)(54906003)(316002)(4326008)(6916009)(8676002)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?R/etda6N+UbEIuVS3Lrs+Y9qRfYK0f1ePl7dJ+wYZBJ2sm9kpPcsnkPqOh?=
 =?iso-8859-1?Q?VKtgqQ4iELlBN64JujeBxZQrvoHoNN41X4mEnkKrEWutTp+FQIIzBx60m1?=
 =?iso-8859-1?Q?WC/SOxwDrThzoNHdqV1/31pGaKpGenFq0BFKDYayOaJPhfB3w05kepRmJC?=
 =?iso-8859-1?Q?CnlK7KOtVrGPsFKIawIwtW9NG1wdeF+u9YE++Iv874i6FxmDSk8iRvCpT9?=
 =?iso-8859-1?Q?bjbarlW5c3jGtm/8iI7iLVL2tRQi8R2HOEE2KBM8FmtINox6CWUhQcAP6+?=
 =?iso-8859-1?Q?gFLJJK47vQnV4DICKwbJ8+zqaEvFKGd02vWbeIwOAKWyRQQltb24RobU6c?=
 =?iso-8859-1?Q?yEcAL4yej/eJhlkYiJtpQGwAJbs+w4LFpuTOxHqG8UbFGuyZOgKEMvUsgA?=
 =?iso-8859-1?Q?SQL+XonSsV8qEV3DaF19odfQ5a3FeNyRNBBIColZIO4L1/wa2o2t/shvD6?=
 =?iso-8859-1?Q?JPts7jMbB4g33sh7Uqwxzh8tcXfSLZVceaPJ3YhN8ZpI+bupnYz2OExy2j?=
 =?iso-8859-1?Q?VNATkJgEuNZJ506JEFd8F7OmydHcK7H52SR9NgYFi4/nY4ygse/Phv28kM?=
 =?iso-8859-1?Q?iiyaZe2oxT/XakIpcLpA+l2DOcVgzxEQjjvJFbVnwuaDPa7pIWDw6a5ZxO?=
 =?iso-8859-1?Q?739Tm64qOuFPRsehkle+BrA4/yfYsHkOgwW/angzKfnu8bJE80BWgClS5U?=
 =?iso-8859-1?Q?vLFrEQhExoU8k9+Eh9AmAB/2uwkw9Awc85YVa7bTM+WV+ffSnUOEbcrSPk?=
 =?iso-8859-1?Q?TRacx7zT94Xmtn36bptQSYONNxqMkf9i0KTU+4AJzR/8XAswiavSOMb5vz?=
 =?iso-8859-1?Q?3uz6+iTGnReiHMh3q5G85vfo7R6+Xec+gIf5gmunVrSgsmfjzUQgvP6IJl?=
 =?iso-8859-1?Q?czL48R2ScqUZ5ffhDNIFxnQwxcflEutMwpVMu1O973UG1lOgBQ7t0/Gydd?=
 =?iso-8859-1?Q?4fEW8Ttpt1O3fZDGv5UxQD1uB9Pa99jRpwZJ82NvZJ6zXjrXvsxH4K4N6u?=
 =?iso-8859-1?Q?yRceErqtgUbbLxg9sRppoAk68jL0PTsLObRGsRqxeqUhOVYvXeAn4KT3ce?=
 =?iso-8859-1?Q?pcxJ56zYXeEsXM/4YF8KMetyANbqUXvXbYGTd0I4ZbuAmk9AbZPgVHC/BB?=
 =?iso-8859-1?Q?sTRoqwmofKp2zbIKpnRHch87l1WJVUzEovYeRYIsFM9J1RlBzXDtypRQkW?=
 =?iso-8859-1?Q?qyS0fLdi4LCFheNu9zQm0KE4rZkmEZhMEC0rG/fPSJFzew5HffrJTZhfTm?=
 =?iso-8859-1?Q?iRrOhB39Awr8koURSmSGvwy6w5EDH1kqw75Ab58NbAV6gxS3h0USp30Cck?=
 =?iso-8859-1?Q?0L49DzzCDcvbpi/clE3EUw89ZOiqAZJ5MeH6rzcCFuawalr+oZtHHrryNI?=
 =?iso-8859-1?Q?lUXPC/wCxHerRfAqcg2QdtXXN/5988t8qyRXnLV7/2HqILBmMNs0jDGGKL?=
 =?iso-8859-1?Q?M1sj0CXDCPhj6Z4D5PFvWeTcXsgeyipQuZZa0UU47Z3lE9Lnkw3HZXWkvy?=
 =?iso-8859-1?Q?Cz+/pt06INwhZrEuGHdiDyGwA6tPynSL1eIXj+PWX4/6xtkXBiMjhyq9d+?=
 =?iso-8859-1?Q?n8jgYbt++H1gOmg6Sjw6Sdk6cww5RPwnr3oOvWPe9zwmnTN7cLaDrHEd3T?=
 =?iso-8859-1?Q?XEcMSj2XMJI8sbCtc3qe4JIsSy6lh+4UxUCE3WKGAS/vv/0xzOJX1JnA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BOqKuQBhpyhON4qwsCnpiSTsF0L8xgrjeqdzP/VPbJBbAKBWhUyxo/LcIHg2pKD5zHh5SkuHszqxgyYlgS20wl7yp7sUlHK7ZH7EqstWhuxnrwZr/5eFVdxhhekpL4A+sPU1u7KEpf9RB0pshuAE0tLDfqaS1esV1GIPUPNQoj35ibU7heMR5hJ/6WtyRfzGdEfFwP+H2hNN0vDzAJRvOMBvVm6XLF5g3YgB4gRZEz2SpjWFQMduH1Xr+DbBObihYAyGqZgujvFPm8b/1SnZHC8y1lgBkH1gaXA0fbq9pDArmyuVBSrFtGlgn/NhlAgSqEmE0ilAeUMhkcWmuzTSBoByRMS6enzCzNBgonAu5PDvq8cVJjGKNnIZTLtK+wIP2iIXCraWyqjx2Qa2AgBzBdYEbizTxkyNxIIXnTARiZUsEB9QWoC9JlfKJa9CheIn4ttELydcRO3GIE+tFIjYs7Xujy6LIJ+D2d2pwEOElHxWzBpvw90wbX9mzX060NwAYNA2TVecEiwwDe1wIaAt5eGv5+dHck0K3W3MxJEj5uP4jXCSWexDjUN8xtb/OH3acKQyzTUsdQ0qMTl13XQH/uqV4K4uWa5f56ILCch58UmRCSTKgFH3yQa58DXyCN3HyfltSP44Hc25hkHHHKYuQ23ogupJeBY+TPf3FfIT7bqYlKwibXNrDaQsEYnnSQSkSe9BPQA0hVRJ4mQyzsW4QVKQrrqsjSVY4xr/M1ma8kxWwdgHOdMNrlQKfMSH8dQMAdbzXosEBDr8ykfiegA3orLfj+cvRkMp3ipQmkBRhmG4ZuFi9P82WmM3tCGKwAzqGWlA9l/gQWG/C2nWVK0A+NuNiPhMnqoK23MR1ukH1Fk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4845fec4-01f4-4f49-4ae4-08dbf025d9e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:22:37.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GHgyxvrD6NyHCuSc5govD21huiRmKyvSKOsp/Q/bCOLa5r+QechRPUcqec1xBeOTVVlVhGF4vppcvn0Fiok4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280122
X-Proofpoint-ORIG-GUID: cr2kLcjeIDUdKO1i22TRQ1hEn6Y2FKZI
X-Proofpoint-GUID: cr2kLcjeIDUdKO1i22TRQ1hEn6Y2FKZI

On Tue, Nov 28, 2023 at 09:15:39AM -0500, Jeff Layton wrote:
> On Tue, 2023-11-28 at 14:51 +0100, Christian Brauner wrote:
> > [Reusing the trimmed Cc]
> > 
> > On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > > > 
> > > > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > > > work-queue thread running delayed_fput().  As you might imagine this
> > > > > does not end well (20 million files in the queue at the time a snapshot
> > > > > was taken for analysis).
> > > > > 
> > > > > While this might point to a problem with the filesystem not handling the
> > > > > final close efficiently, such problems should only hurt throughput, not
> > > > > lead to memory exhaustion.
> > > > 
> > > > I have this patch queued for v6.8:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > > > 
> > > 
> > > Thanks....
> > > I think that change is good, but I don't think it addresses the problem
> > > mentioned in the description, and it is not directly relevant to the
> > > problem I saw ... though it is complicated.
> > > 
> > > The problem "workqueue ...  hogged cpu..." probably means that
> > > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > > That will stop it from hogging the CPU whether it is tied to one CPU or
> > > free to roam.
> > > 
> > > Also that work is calling filp_close() which primarily calls
> > > filp_flush().
> > > It also calls fput() but that does minimal work.  If there is much work
> > > to do then that is offloaded to another work-item.  *That* is the
> > > workitem that I had problems with.
> > > 
> > > The problem I saw was with an older kernel which didn't have the nfsd
> > > file cache and so probably is calling filp_close more often.  So maybe
> > > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > > most files in-task but instead offloads that to another task.  So the
> > > final fput will not be handled by the nfsd task either.
> > > 
> > > But I think there is room for improvement.  Gathering lots of files
> > > together into a list and closing them sequentially is not going to be as
> > > efficient as closing them in parallel.
> > > 
> > > > 
> > > > > For normal threads, the thread that closes the file also calls the
> > > > > final fput so there is natural rate limiting preventing excessive growth
> > > > > in the list of delayed fputs.  For kernel threads, and particularly for
> > > > > nfsd, delayed in the final fput do not impose any throttling to prevent
> > > > > the thread from closing more files.
> > > > 
> > > > I don't think we want to block nfsd threads waiting for files to
> > > > close. Won't that be a potential denial of service?
> > > 
> > > Not as much as the denial of service caused by memory exhaustion due to
> > > an indefinitely growing list of files waiting to be closed by a single
> > > thread of workqueue.
> > 
> > It seems less likely that you run into memory exhausting than a DOS
> > because nfsd() is busy closing fds. Especially because you default to
> > single nfsd thread afaict.

I would expect a DoS too: the system should start pushing out dirty
file data itself well before exhausting memory.


> The default is currently 8 threads (which is ridiculously low for most
> uses, but that's another discussion). That policy is usually set by
> userland nfs-utils though.

With only 8 threads, it might be /more/ difficult for clients to
generate enough workload to cause an overwhelming flood of closes.
As Neil said in the cover letter text, he observed this issue with
256 nfsd threads.


> This is another place where we might want to reserve a "rescuer" thread
> that avoids doing work that can end up blocked. Maybe we could switch
> back to queuing them to the list when we're below a certain threshold of
> available threads (1? 2? 4?).
> 
> > > I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> > > the nfsd thread should completely handle that request including all the
> > > flush and ->release etc.  If that causes any denial of service, then
> > > simple increase the number of nfsd threads.
> > 
> > But isn't that a significant behavioral change? So I would expect to
> > make this at configurable via a module- or Kconfig option?
> 
> I struggle to think about how we would document a new option like this. 

I think NFSv4 CLOSE can close files synchronously without an
observable behavior change. NFSv4 clients almost always COMMIT dirty
data before they CLOSE, so there should only rarely be a significant
flush component to an fput done here.

The problem is the garbage-collected (NFSv3) case, where the server
frequently closes files well before a client might have COMMITted
its dirty data.


> > > For NFSv3 it is more complex.  On the kernel where I saw a problem the
> > > filp_close happen after each READ or WRITE (though I think the customer
> > > was using NFSv4...).  With the file cache there is no thread that is
> > > obviously responsible for the close.
> > > To get the sort of throttling that I think is need, we could possibly
> > > have each "nfsd_open" check if there are pending closes, and to wait for
> > > some small amount of progress.
> > > 
> > > But don't think it is reasonable for the nfsd threads to take none of
> > > the burden of closing files as that can result in imbalance.
> > 
> > It feels that this really needs to be tested under a similar workload in
> > question to see whether this is a viable solution.
> 
> Definitely. I'd also like to see how this behaves with NFS or Ceph
> reexport. Closing can be quite slow on those filesystems, so that might
> be a good place to try and break this.

-- 
Chuck Lever

