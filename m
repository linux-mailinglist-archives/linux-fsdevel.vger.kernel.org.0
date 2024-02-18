Return-Path: <linux-fsdevel+bounces-11956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74AE8597B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8301F213DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA436D1B5;
	Sun, 18 Feb 2024 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U+fYLf/Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lyziksOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4912E61;
	Sun, 18 Feb 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708271857; cv=fail; b=A1EY6H4KhL0aTO4x/A5Q6nC2030Xa9SvGH6JZ1F8jH9lpaWnAIGww7MxNfdE+yNzz0tsH15Ar7yNkOqMggK51KKeCaN0ZtkygQLLssZDWI+LNRxYoH+ZQqDiYVffBg8aaMcgO9oZtTsucUbmLB3B0VQies3fiPnAC2ZqdNc4xJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708271857; c=relaxed/simple;
	bh=eIyZiHcDEC6iDzcGR6cA9berH/wq5T22XxT06REE5pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UIl4et0/jvo2bUYPjVmKDYosumoZdx6zkjbADtTc1YUP8DD/Pwi+knBHos7bHed6QPZzf+Pk0OgXqzOSdfniJOvO6mo2xW93qPh6M+IeXIrltkDu6NP3ILEzaGPGZpyMZdTQjFw4sj3AjIxoqjzkmKGS8r279HCIeK8AOFP7EfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U+fYLf/Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lyziksOj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41IBmg3U026561;
	Sun, 18 Feb 2024 15:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=V0OdHrbDm6Jg2G1vrWWD7Js4fMnggFo+9ZrYeXp57yM=;
 b=U+fYLf/ZjHKeCVENCPUUU0gnDIUzAjCFwb4du/nnmtsd1819En7IgERrHZkkvl9Qivxi
 9tu9ZWLbR1+s8cqj0H3NsbbI9a8vx3Ni+C0Vy3gq3VL/6AT3bby+LYh7OfxrmDiy1cHM
 e4XLdNwGQAfU0d3d/xQ2Dqpc03Q+xpy65A7h7eH8dg+x4BzP7WrLKHGg4IQ0+EODyJHL
 GomM+1RmYYfKpE2lXfrMjQJT/Nz2dz89VgyFit7vObtetQ0WRkPZ3cG7exDg6L6ZpIMy
 bgeEqsdnIEdT4Oo4QAsMh+FrRImELTaeS+Tx97Pk3hmHHAmtLDLoZpn+WfIhrwpZG+6w Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd22chp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Feb 2024 15:57:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41IE9c45008483;
	Sun, 18 Feb 2024 15:57:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak84wrdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Feb 2024 15:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWBLAIqXRDSmAyvtbJMyeddsWXUV3kAhVUYy9K6UJo5DaxARy1NTAArXwBhdsIflGfZthAagEquRkjFrNuxZQWRsBjnf4uSX4arKNtJ4HinYtLGdD5wna1n70YsMGz3DvOSyzXAA30/HoqlVi+MgjBLpctZftzZKK8In/i2EA4WR1Tms8vT9F3r0lXJsvguyFPC3zVxEbfVwlkhUKfTAgLyepOd/0X6+WQ4iOaMAyn8dKOWgZE53TjK/6nL50iTFe1CaG6mBGhmi1pz6ZdJZHrJspMW+RrLCh2vwta4XlGhKL0izxU/k13Vz5wDKN5Fejk2UvCO0ZPXS0SCqk5jj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0OdHrbDm6Jg2G1vrWWD7Js4fMnggFo+9ZrYeXp57yM=;
 b=QGRSZaguyIq1IzYOGtzq8vXGLD2DHt0GAHKCFio8vmzUhTqwOyI1B7Hiem+D3UnM+puizTlU+n/TsHjvsw2GkrN67G2JAHCahnjeUZBOWtZ0kuKgI8LpAgvAwJMhHS4RALGa+JpLj0y3NC9+JJ0cb//7FSM7vDcPBiA0+gBT0hBuYEYqDGlaoKPCKCo4p1icCUqIaUik/9jAz8CV7zcCtsQmEdbGz8pQ4BNJ65i6tAlYfAcdtVfQif0D6m/breqSLc1BZfcFjbXL9f3Xe1Fqzh3rjWVe58SYNYDuom0fXWqkBGKfcHh010BZcQFdgp2qJgOEKdDxqA++otfqQvbgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0OdHrbDm6Jg2G1vrWWD7Js4fMnggFo+9ZrYeXp57yM=;
 b=lyziksOjKpD06QWKn0sasQ92BgUa0TcEXrjoooyHWT2bhU7w76Q0cG7RD8Lcg/L370p0g0e/1UB+Xx2AtIr/4xTEO4brqz6vFl6eHpJYUkdibJInSea3MufqX78+LTup8ijrCDG0JYaGjYdTq+y2RYne6FxKOdp3eHS6NlEcbHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 15:57:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 15:57:10 +0000
Date: Sun, 18 Feb 2024 10:57:07 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        feng.tang@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
Message-ID: <ZdIo0yNCFpkN_zBH@manet.1015granger.net>
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
 <20240215130601.vmafdab57mqbaxrf@quack3>
 <Zc4VfZ4/ejBEOt6s@tissot.1015granger.net>
 <ZdFlPbvexMir0WZO@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdFlPbvexMir0WZO@xsang-OptiPlex-9020>
X-ClientProxiedBy: CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7442ef19-c18b-4dfa-fbec-08dc309a43eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HSuhSkcCD5WTYBIDvGHVRhPN6wRiIYqIOhlbG8RujPwzVicOJ7kriUcfQpY87wJERR00uwfKx4G0HdSCXpe/DLydlFMLer3EZBgGo+4I12jyqfObfopSIbtLcBLpUwpub3BBF//KVGEUWgdKVD4mHtOA5XS9Am9AQ0g3s2GR0Jn1m83GMcB5DMhN0QcrrkmZRCky5BpKcFVPM2PHsqSfW4KohEUjCjyepjQ0RAyGMajujBkgcMGsA3VdraolqOB83iov2nETSHzBZhO64icTl4LduXyk4F2IZVfO3PE7cFDua1vfzVaKNljgpZMqjhsexlj1rK3su92B/kyUP+6nkk3EN73P2WAOYZcfzYtalp9eiHriEVZlAypkHJH49mJZib6RCuah+xaKYPG/wrP7+UOyA6uxKdf3KtTlpIAlxh8kLe8CemHYEap31U+4aksCfUzw8BkE7LzQMcP3LZNbNOcKiDJmDaieoRJ9tXoH1PyrBSBNsAAUQo8oZVXFUoQMnRVHOIZ71pJx0IalYTauJqMBiY5UttsxPgIKoJ5zTa8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(26005)(54906003)(316002)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(86362001)(2906002)(8936002)(7416002)(5660300002)(83380400001)(41300700001)(44832011)(6512007)(966005)(6486002)(6506007)(9686003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?80WkNWdzckhtz/X8E1MU/AFAnjao17Mz8Uq6B8W5dLvwN/kT7a4XJ3rK+IcE?=
 =?us-ascii?Q?SKtmnsbuPuaoGHnaCjZS/QO+PQKSKt5sZB+IdY5zwbdW4y61sclZ/cMV5qDd?=
 =?us-ascii?Q?5vsWJKvC47llZYgZ6w5v1Sg9brpmzInaA0uTQUk3OwHRq7N6vj2ega9BIvB/?=
 =?us-ascii?Q?3TLwqWgKLNbY53VoWV6voNtM9JAr/td+h3kjXZQoYeo5L3Hz3ke4AeXInaRl?=
 =?us-ascii?Q?TycOJo8YU3YGN7a+vyX1piBb8kVvhzAvhbzjQdPlGDBrOXHumcX++6rXtHxL?=
 =?us-ascii?Q?n6vlpVelWUcxZNG3CNaBH7o+9QnVUgu0EpgrS6spQrzew17B0AC0eIzpM0RH?=
 =?us-ascii?Q?ZPfxFE5Ky2VpYEjJwAPHjavgEy6zI6m/Jy0OH2o8WPDlSYI3I+T4AeC3Bi/3?=
 =?us-ascii?Q?pzt8v65X4PAJ5lo8z6Ifhr5HNBTXwrs25UTCtJbLZGRly0bV1p1w/NlbTBLd?=
 =?us-ascii?Q?QxqUGu7tB8EyMjV3nAyKJeb7FD8XZw52HTgYIs/HzRKFfMEhveRoQ5n3nk+l?=
 =?us-ascii?Q?1oBTepx4s1Bi2Wm5s4/OYGncs/3IR5EK+PirGm/nG+fDHvuNPPGNBcxhs/Zx?=
 =?us-ascii?Q?ZmB0vL4NegK6WfgfXla/El5AY5OflrmIB5czOO1KXRFkNu8JrMMwIaC20/fj?=
 =?us-ascii?Q?Ep989U5VFYDnSgMz6BJcwTdhR0bwRpWBw5oUjLauKjvUz5uq4/s/5H9RnYcK?=
 =?us-ascii?Q?JKIKA8NJm5SGFczdc2Hm+nBKFDrNQBJ8Of8/ZUkO5qPE7oeh4nf6SL3Vrsnz?=
 =?us-ascii?Q?9k1OrfeQQjurN+qS+yflpXWf/poWVdmixnKlsMq10wOMxRtzj0+3Vq5DYGm2?=
 =?us-ascii?Q?OMGTGNOdtRwmLV+7cFAexUmmQsWCeF80uYEW6ulsIZqHFcXPUEeD4Exnb31r?=
 =?us-ascii?Q?xsChKrUYs1jfkI5i6pd5HW6tMMFzVVt5t1Zy76RGMzLOoWMc7KdA3icsaY1r?=
 =?us-ascii?Q?cr6zeitKVJO48u8dxpUcqBmc71DFAH5VQJ1A9qGyYflkEAhZm4gYFjVwAU95?=
 =?us-ascii?Q?TEKKpNnNOY+aJB9jTBCpXxEQhKgm72VRe7sOJFNgLnEoyjeOyA7aBllYpx7z?=
 =?us-ascii?Q?nQmaf+vYF/x+bIXM97YemriPOO8l8TDSrhekSt6KfgQTPjT8GKwaSPzWTZsw?=
 =?us-ascii?Q?OWQpuNtteLTE27xsWXCqVoEEjsyGp2lUSGKrCFVR2vJ2CjKCj/LfjLy/Mns2?=
 =?us-ascii?Q?hLt4qDCTITMl4jPNd9jA0PTfrc9NdiglJAyMfkyTLZv8QXUi+IT6I91JwFRa?=
 =?us-ascii?Q?x1onpRLxQs5W1id+naMOORFVJrRg5TE3b3JuZ1UzDjzU3irWInMZjAViyxxo?=
 =?us-ascii?Q?SQx4LxaQrUJ1g+NYJR0hShMPXfAsq5VMmtUVT1l2R72AqQfR+5AI4ofDLgnx?=
 =?us-ascii?Q?fUkOJWtXGKV+fWFD2lOrGQh2EM2nD0HCzFe6cvSK1RbZWTQ/7gpbLZ59JWbj?=
 =?us-ascii?Q?Su9MeH1hE157BnsTKk6h0SvZSRYpO3ho5vkLKO+NffmLlH4aPH/hAgHvzNF5?=
 =?us-ascii?Q?mSjoS/q7PfUOLyaWYxzr3aa1CIMShOgM3JvxHKMeksrRVq6k2WUrYSfO7MlQ?=
 =?us-ascii?Q?HHD+ErDJx3XVuE3VRu5PSLP7ml7N0SFVKDllrkZ29tBGqBxXwXMRHK8QsPXq?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wDi5UfDrtaAiK3HntmRF6yM3DlSwzQY5lHXUIFdAgMkxmbr5QvcWeNrLJiWE/OuvOaVcIVCSE5W5c/h/9w8FA2T0pJDoh6ZASK37/bDpduHAtSMx3dEUv5WwKOcJiSaRz41gWMkYlFEx8PGhE9FkYKT3ayNRHp9nQODyM0ksT++gGw9XodH7OdJQAfkW1FQ4F0ns/qQYotKKrxn9qO9hHFzeMzuBYyHvDpjUyATB7fMwatCXkb6+2CG1PLNXIwb8DN0e4cz+fUoMfcqtEHbJRl4eQinUXDVdp4fSPT5KNIvNM/Z5hu7XJtcwz4pvQKWr4n8TOCt8raxAlT6U8Iv1EKuqCL80G9w/0vXWtF/zEk0fVTYL/10RF7lP9Rn2kZeJ3zp/SnuvOlDI1s6wWJrT4T66G8vVTw5NP5BlXB+EP2H9MTGZipdwn2Ae4rfEk/pirGxVIqxqpxbAS92kbbXyt2B8K+6/tvWewEKniwYuI5dQjp7MGWk49cLdxE97J04mYPuOWEEW3gJ+sEVHaAi8RGRuIT/1lOHpPCbE7ALkUAbZ2ueJpGzKBVDsB2YX+rWSoDkiT0pKYG4YHRKJWxP3FXBoP+tAEZWuZJextyZ9tIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442ef19-c18b-4dfa-fbec-08dc309a43eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 15:57:10.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxhYx64y2HHMi+rpqyTYBBNowfWnu4FtEgiysDVZ6MFR+oZ9846Of3LuuInDvDbxocPPNQOZ7SoWJ9Gp2qqa5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_14,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402180123
X-Proofpoint-GUID: 23nk_ALCNJqC23VkyRU0mk_6bJcyOBzc
X-Proofpoint-ORIG-GUID: 23nk_ALCNJqC23VkyRU0mk_6bJcyOBzc

On Sun, Feb 18, 2024 at 10:02:37AM +0800, Oliver Sang wrote:
> hi, Chuck Lever,
> 
> On Thu, Feb 15, 2024 at 08:45:33AM -0500, Chuck Lever wrote:
> > On Thu, Feb 15, 2024 at 02:06:01PM +0100, Jan Kara wrote:
> > > On Tue 13-02-24 16:38:01, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > Test robot reports:
> > > > > kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
> > > > >
> > > > > commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > Feng Tang further clarifies that:
> > > > > ... the new simple_offset_add()
> > > > > called by shmem_mknod() brings extra cost related with slab,
> > > > > specifically the 'radix_tree_node', which cause the regression.
> > > > 
> > > > Willy's analysis is that, over time, the test workload causes
> > > > xa_alloc_cyclic() to fragment the underlying SLAB cache.
> > > > 
> > > > This patch replaces the offset_ctx's xarray with a Maple Tree in the
> > > > hope that Maple Tree's dense node mode will handle this scenario
> > > > more scalably.
> > > > 
> > > > In addition, we can widen the directory offset to an unsigned long
> > > > everywhere.
> > > > 
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > 
> > > OK, but this will need the performance numbers.
> > 
> > Yes, I totally concur. The point of this posting was to get some
> > early review and start the ball rolling.
> > 
> > Actually we expect roughly the same performance numbers now. "Dense
> > node" support in Maple Tree is supposed to be the real win, but
> > I'm not sure it's ready yet.
> > 
> > 
> > > Otherwise we have no idea
> > > whether this is worth it or not. Maybe you can ask Oliver Sang? Usually
> > > 0-day guys are quite helpful.
> > 
> > Oliver and Feng were copied on this series.
> 
> we are in holidays last week, now we are back.
> 
> I noticed there is v2 for this patch set
> https://lore.kernel.org/all/170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net/
> 
> and you also put it in a branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> "simple-offset-maple" branch.
> 
> we will test aim9 performance based on this branch. Thanks

Very much appreciated!


> > > > @@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
> > > >  	if (!inode || !S_ISDIR(inode->i_mode))
> > > >  		return ret;
> > > >  
> > > > -	index = 2;
> > > > +	index = DIR_OFFSET_MIN;
> > > 
> > > This bit should go into the simple_offset_empty() patch...
> > > 
> > > > @@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> > > >  
> > > >  	/* In this case, ->private_data is protected by f_pos_lock */
> > > >  	file->private_data = NULL;
> > > > -	return vfs_setpos(file, offset, U32_MAX);
> > > > +	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
> > > 					^^^
> > > Why this? It is ULONG_MAX << PAGE_SHIFT on 32-bit so that doesn't seem
> > > quite right? Why not use ULONG_MAX here directly?
> > 
> > I initially changed U32_MAX to ULONG_MAX, but for some reason, the
> > length checking in vfs_setpos() fails. There is probably a sign
> > extension thing happening here that I don't understand.
> > 
> > 
> > > Otherwise the patch looks good to me.
> > 
> > As always, thank you for your review.
> > 
> > 
> > -- 
> > Chuck Lever

-- 
Chuck Lever

