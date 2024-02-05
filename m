Return-Path: <linux-fsdevel+bounces-10317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EC849B96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666C3B266F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6532110E;
	Mon,  5 Feb 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SMdGN2mW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AhHAVD9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A720DF6;
	Mon,  5 Feb 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138710; cv=fail; b=Dt5tAiLRi6ulot5Y8pElSXCwlAkSAyYX9ob6xsGi+7Nn211RdfcCHjguC7SvZuUn+sw5+pdbODc1QJHLq4FHBFNSvLqHyrUX4kHYdBCmqCIoFT2lsova8Xm/pzQPG/zfDAWGAdqnNj0d2hYs+MJGeR3whS7CiSd5+os0shhbg6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138710; c=relaxed/simple;
	bh=/bzh9iEAZZjiM4uJg+8ViOv3ByBDJgTCCtzurY2af4Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gI+jJgWEJrHbiRPiPc7xCp/j0nx2V7w8F1J9CjYvz6FZmuddyfJF4YXZriW8kDhOuxYAZi2NjMp5QukjcBx3Xe/mmu6M/2YG51pdhWS/EHzBSi1yEGE4I9rNd9xnGhrTbQCFFSSDSre89lr6kEPibtKPPqI9H431hjCG7kHbFmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SMdGN2mW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AhHAVD9I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159P01E017964;
	Mon, 5 Feb 2024 13:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hObDq9H9pkg/BKWzqHO9oXb+wH9RPZyQTk/4+ADDrEc=;
 b=SMdGN2mWKJQRPV3MMczpkvM6tV/OI9w8LzhNyWDbyrHyULsOMPSSAJxBFfbh1dWrNsOj
 h4/BIY9dG2trIvqpPlsGnUpm9P5ROP90cSE8xtTICGpJFG7gkQYeDhtJHYHJFkX7om98
 wY6Fu0qoDaiCqvwlV62zc7Di6IhhtGDtrJRlgKVEf0Wz9UvSG3t3/9ddYNRJFEogIiRJ
 4Rx3gp2nUSXj8XROcNFmYCi41+Cx1deXCqPaQGkVx2TrAhS5zMZ7Ne+M4X8zS8+VPJBz
 Tnw1UOgGCjDr3vDRo7YZn6g7AdPdRnqsZX6c2/r5eQPsfHKjSlGu3FwhUU6CVnmxu8BW VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbbsfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 13:11:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415CZtoP019688;
	Mon, 5 Feb 2024 13:11:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbxaes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 13:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLcaLdqzoYsssVWTvnuRdy0ismVzp1Qdk5yTG0JxubkziMriMA090L8oF7YPzjmCXATu2s0vamN8vc/wy1HKHImzWVriTpvs8jgw59UHHPzb4f2VEzPUiV9C2IG1kyMenIaB71NP28J3suQ3YZ/Pbr35VeHtXbqs4yNyOBogKCPhV0ohgakEFk7bfeAlDaLVXwIq6fyfV2EYOAHr3RvJC6lcWw3nHflwuAj3UdFEWhG/AbUUqdg6m/tFZxnlFh6KPekDY5Q+L4t677mxhv9NpS8ZPk8wHt7QMDhpnXU5d3DSZNFsp1nO1lsuCwJmVhnP1kn49oSGzuif1tjwhXcDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hObDq9H9pkg/BKWzqHO9oXb+wH9RPZyQTk/4+ADDrEc=;
 b=mXjd/jmALWF3YvcawhTzrM+8cNEawiqyU+dycmqTvPvxkw5VQUpWFnw5RDgrvzx7fKwpGenc8UG7fGr7pYJtk9UE9v40uS/h7bKgTDB3KIMlswVMLOZBhGrsEMBEJHUY8xwHx01Br3SYb/Q+IZgyoaXzeUzG4SnrgELq8+az/fXSk5LKTinkT/n6ulfKySrdSJ4NhHdsthnBU5VxaoW1CZfmdOgpNuK+UDkJ5oskVrNT14VEt4fLCw0+PVtY9YaZuL54kqi1odcrZQzwevhivGtER4bdGQjLvi3umwOODFKtiToXpsqkK5iGuEcw5SB/k0NmgVG0RrzpdzDBSqAjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hObDq9H9pkg/BKWzqHO9oXb+wH9RPZyQTk/4+ADDrEc=;
 b=AhHAVD9IHpIAMTiuzyJc3X919A0exWDbhQAsidl7SEbvJEYsGJ3s3NPvNFxaS0tF8wHP34EX2esGRyJaBtv/WNtJJSpqgjllIVz5Siwd3JUG1wWvHtc+DHHa53OajNQW7mKc0TF4vUm0JulJmYEGlxA3T/Fch9hrorAjG7WuFfA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5952.namprd10.prod.outlook.com (2603:10b6:8:9f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Mon, 5 Feb 2024 13:10:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:10:57 +0000
Message-ID: <9b966c59-3b9f-4093-9913-c9b8a3469a8b@oracle.com>
Date: Mon, 5 Feb 2024 13:10:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <20240202180517.GJ6184@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202180517.GJ6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a65c5b-0e8b-46ca-4d5b-08dc264be478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V9h97wYTdfWyJvE5HC7UyhMcqdbwnzqnKSFO7PnstF/0ef+id/bkKIdESQfmNDzZQg9svJNekH9dQGXxy6E6rLRdft7jkmwIF5FF8bXfmPBchy6iNAyExXaT2YTvOFPyl56wpWpmpf6ZSuYoN8Rx/sfTlPKdzcptkZJueebG203+08ZdDISx6zxKW+Ix97mDCC4uAMoIkgTjqynij2JoMACrDOU5L+ovLZfHxlO1Zccsqxsl2JRxzBSWtZ/dLMovftWQHIyH5TNT0GtnvfFRM/q3kMwdS39/WUuEwcjEniVm0fcukirxkkgYN5VO4T+6h+S1UUr/mALzNugv60Eqoi7p4A7BGXGQRU0mTt+yvxaNOeCTvjRkfqjZLLUd+NCMWnni5O+VLDXmMT+nG3fC6NR3vrf94RceY0+g2zW+ENlYyuYZQqwLJBETnFoLehkekMYQhbDHbiksxNoiDQceEyPsZWOu/BIseB52ECL6CrzI3ickwXPrURiA1Mh7/nJZfutmHrQmQCl++Nb847hnlB8j3c12bvbCVF3xtmNQb+zkEmRa3b/D4bKP50Rux/9PRsN+9UM/y86d8D/QOC9u4t0MUnRsIIFkZvnMFEocgW4FEfQ+rH1Peow1w4hcti5ORRV2qfolTW+RKytdAnbhiQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(26005)(8936002)(8676002)(4326008)(2906002)(5660300002)(7416002)(6486002)(36756003)(478600001)(6512007)(6666004)(36916002)(53546011)(6506007)(66946007)(66556008)(66476007)(2616005)(6916009)(316002)(83380400001)(86362001)(31696002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUg0c1JhT1lPQU5xa2VtbTA0RUlrK2RGWFJEMmlQWnkwVTJPS0M3ZXpTdGRX?=
 =?utf-8?B?L3NsZ0gzQkZCeWxRSVhoNnN4MGMvTis4am1kRWViTEN1UXdjYzRqaEFnNmls?=
 =?utf-8?B?bjNBaGJLZUxYcG9tRVp1VVJ4YmZydlZ3NncrUHl3eEtLR0FzMDdZN2JPRkZ5?=
 =?utf-8?B?Wmo5UVovVDUzeFBUVFJ1dStUS3pPQUNPTmZRYmVJa0xjMUpXZ3hubFJGRG53?=
 =?utf-8?B?YnBmQ1NYSTV5WUJUVTROMTUyaEN5Nk1JcWNzdENSN1RYcnVnUWw0d1RLdUk2?=
 =?utf-8?B?a1doQkllZk9oMG42T0J1WlViUUF5STBkT0JPZjg1VURacHlCRTZhaUI1Yjcw?=
 =?utf-8?B?K2tzZ3ZoTmdVaXRVejVHTzMweXNKc21JU3dDRGdINTFvYS9nMDhSZlVRYWFq?=
 =?utf-8?B?ajh1dEM1OE9BZHRHaUt2amRDY0xUVkFWUk9WMG12SktZQlZsMjRJdjh2MEdT?=
 =?utf-8?B?eUIxbmhCVC9lTTRic0RFRjdVcUN6aFlCUUM0YjFNd3pLclhBYzE0Y0EySmtX?=
 =?utf-8?B?U0lIdXBRWlUvRkxIMWdIOTJVaWNseTZCSWIyRFJtZ0lhaUxKZ0lJYndKZzJS?=
 =?utf-8?B?dDloejNmKzgzZ2tEOERVYUxFcG96SjVocFdpU0J6SW1LdkxLVkhhKzI0L0Nu?=
 =?utf-8?B?b1dVWjdGZTlveU4ySXpNTjZmaENTRGFtYmg5eXgvd01YMnYwd2lVWWVES0c4?=
 =?utf-8?B?UmsvdjlnaTE4U0UvRTN3cmRqaTV3U0FwOHFqb20vSGlnSnZta0NkOWR4S0hQ?=
 =?utf-8?B?alh0b0pnNEhVQnVHSDdqUmhpVlp2NDF0ckY0UDBmbW9oRkxLR0pVK1JabGR2?=
 =?utf-8?B?VkpEMjEyMVNxYkVEOVhCWGs2QjdsdjNtV2QrYmpvdmM2R2dHUFJJNlBkeStY?=
 =?utf-8?B?NVRYTUZqVzROME55K1RXNjVaWmRPVjd1Q1pPaDdueW16cFMycW9WdFdRVll2?=
 =?utf-8?B?dVZRRExyZTJ3VFVNUFFXYzI1MFNGTWgvMVNyWFVuT1ZxeVFMSnl2a0F0NWl3?=
 =?utf-8?B?U3hrbE9jOHRCOW1nc2l2T1dvOEtOQ2ljRFVXZmdZcTl4eUNRL1hGemEwVExH?=
 =?utf-8?B?UG04d05kaTVZMVQvekVmQTNrQVNiamtDYkEzdDRQeXNZQkpVdXB6b1lNNWNI?=
 =?utf-8?B?VXErWjA5YmJTb1dEYmNRcy94Y2F2dGpXMWhiTlJNQjJUL1ZXMWhFWU5RbjBO?=
 =?utf-8?B?TjFGR29KSksyQTA5NlV0c0ZIeVhKNEdGMFBMMTBUM1BQR1owTlVZOFRpN0hn?=
 =?utf-8?B?YTFOMHBtaVJXMDNtVkN6a1JudHdjZy9LNlozOSs4aURZUGdxKzNMNjhkOGpS?=
 =?utf-8?B?K3B0YWMxQzg1MmlMSW8rRTNrZkdNT3U1a3Y3WnR5SW9lZHJhakZPVStjWnpz?=
 =?utf-8?B?ZXIzREhlQVVIT1BKQjY4ajh5RDQyaGd0ZXlzdjdCRnh0ODEwZjhOUXhxMVVZ?=
 =?utf-8?B?NTVROXppYmpjZDBraUl3QXVBY1pmOFV3enA3dUNUZzNjNDZDVGRsTkJRWWl6?=
 =?utf-8?B?MHN0R3BmUmxXa3pMNlRTN3REU3pPeEVaaUZwbDJRRjZDZHdNa1l2VnJLRTF1?=
 =?utf-8?B?YzVva29LMTBhQ2RtNFBnV0V1MGlnVVVERG5zaDk1ZlgwOXVWczdQVzBTcXIw?=
 =?utf-8?B?ajZRU0tJZ0lNOXZKY1ZoQ1lNTnZzUHVWbWxQV2c2aG9UM1l1VWc0eGNIVnZx?=
 =?utf-8?B?K044RHpWMGhtTjFickZXRVFocGFpTG9ndldxbXhrODZ1MVAwekNOb2drbmda?=
 =?utf-8?B?OUtaRWxzaC9BRVp2VXd3N21rVzM5aGlJbS9SMlBNeTdBTkw2aXJOMVFDc0dP?=
 =?utf-8?B?VkJGeGRmN2VWZ2kzQXc0TXVWeExXNFdaMDVXajhFd0Q0dDIyR2JUN1ZDRW1O?=
 =?utf-8?B?elE0NExsY2xvaUMwNkVNOUtoS0pSdHdiOVlrK1B1eHJ0UE9SMDNyWEltTXAv?=
 =?utf-8?B?blhyQzdBeklZRGdyb2xPUCtaUWs5QVgra3pQZDlzdFdZS1p2Yk1lVXV0YUZN?=
 =?utf-8?B?MkpRcStiSzFUaG12b3NBU2JLVkRLZjk3N2dVNXVkak9ta3Zpckh1cDZHZWVQ?=
 =?utf-8?B?ODY3NGNyb2d3bG5FQjRlL1YwYVE4VXdBY2hMaDFlR214NzNLQ2phRzFyY2I1?=
 =?utf-8?Q?g2PIgaswjzrkURpdz6MyGkI9m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3biBj+xapbrIcgw5GKUdLKq7UfpId3shMEQvE2mU2CyQLpnZsl0AuwgIeeNrzQPzIK/Q0QRJ+/egfd2iugbZglVREkv6jR7WZTjIjxOnxm1Ujzjeg+W9ggunKiEJzyYrVHfbJdbDcIVdZHbW6oFQn5YJm/TpBgAAD8X8zcZixsQ/hhnAwGaIw7alHhyPNcRZunF7pk8ISnJ1NilrnMdf7qXoCI26CT3uioWINPoeS8G5LIhMkay3aUQxOkXTixh0eJSM5US6FE/EDCMV/pskJCDepCRHyt745xuk3eIZ6m8BwOoVNzBvqj3C3WyIRdwmUIx+EpPThuZBMaIPLs58PIi+iaCmRUMIUKtmZXQKyHWWamJJTWr+7Sg3NtwcE3I+UKDO1P0xXI42m0/LAr6TIz26Jp1C45t/LNnZBdRGOo3L1N4Z8Fl9qDAd0jiUkKUCfzcjbOXg/ZwvKngafsi8i4rSGHqH9sOFu+Rezowpkr4a9AxZ14RyJnlcSS2YHSBg9PxeTuOqxzJSbdnZoku5dsnmgRxhNR33vwY4yWZ4V0Ci0Z+gjjsEC7qdc9gDYbGsd9uqYglZOqnrLlH4/TJ9X2/0VTuARuZHg5sx5UO7S4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a65c5b-0e8b-46ca-4d5b-08dc264be478
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:10:57.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppwULJEwArYMkyGowTw53V/F581HibszTHomKjJTvb/NaEBb7fhic0GXF7dsztTZNVlkBJYxQuHTOYP8reKqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050098
X-Proofpoint-GUID: nqlTARE1y-6DsPOH0Y4ba9dCqYaguwnc
X-Proofpoint-ORIG-GUID: nqlTARE1y-6DsPOH0Y4ba9dCqYaguwnc

On 02/02/2024 18:05, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:43PM +0000, John Garry wrote:
>> Support providing info on atomic write unit min and max for an inode.
>>
>> For simplicity, currently we limit the min at the FS block size, but a
>> lower limit could be supported in future.
>>
>> The atomic write unit min and max is limited by the guaranteed extent
>> alignment for the inode.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iops.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_iops.h |  4 ++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index a0d77f5f512e..0890d2f70f4d 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -546,6 +546,44 @@ xfs_stat_blksize(
>>   	return PAGE_SIZE;
>>   }
>>   
>> +void xfs_get_atomic_write_attr(
> 
> static void?

We use this in the iomap and statx code

> 
>> +	struct xfs_inode *ip,
>> +	unsigned int *unit_min,
>> +	unsigned int *unit_max)
> 
> Weird indenting here.

hmmm... I thought that this was the XFS style

Can you show how it should look?

> 
>> +{
>> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +	struct block_device	*bdev = target->bt_bdev;
>> +	unsigned int		awu_min, awu_max, align;
>> +	struct request_queue	*q = bdev->bd_queue;
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +
>> +	/*
>> +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
>> +	 * atomic write unit of BLOCKSIZE).
>> +	 */
>> +	awu_min = queue_atomic_write_unit_min_bytes(q);
>> +	awu_max = queue_atomic_write_unit_max_bytes(q);
>> +
>> +	awu_min &= ~mp->m_blockmask;
> 
> Why do you round /down/ the awu_min value here?

This is just to ensure that we returning *unit_min >= BLOCKSIZE

For example, if awu_min, max 1K, 64K from the bdev, we now have 0 and 
64K. And below this gives us awu_min, max of 4k, 64k.

Maybe there is a more logical way of doing this.

> 
>> +	awu_max &= ~mp->m_blockmask;
> 
> Actually -- since the atomic write units have to be powers of 2, why is
> rounding needed here at all?

Sure, but the bdev can report a awu_min < BLOCKSIZE

> 
>> +
>> +	align = XFS_FSB_TO_B(mp, extsz);
>> +
>> +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
>> +	    !is_power_of_2(align)) {
> 
> ...and if you take my suggestion to make a common helper to validate the
> atomic write unit parameters, this can collapse into:
> 
> 	alloc_unit_bytes = xfs_inode_alloc_unitsize(ip);
> 	if (!xfs_inode_has_atomicwrites(ip) ||
> 	    !bdev_validate_atomic_write(bdev, alloc_unit_bytes))  > 		/* not supported, return zeroes */
> 		*unit_min = 0;
> 		*unit_max = 0;
> 		return;
> 	}
> 
> 	*unit_min = max(alloc_unit_bytes, awu_min);
> 	*unit_max = min(alloc_unit_bytes, awu_max);

Again, we need to ensure that *unit_min >= BLOCKSIZE

Thanks,
John


