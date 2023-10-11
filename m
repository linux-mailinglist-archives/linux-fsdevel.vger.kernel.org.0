Return-Path: <linux-fsdevel+bounces-74-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503737C57A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303D2823C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF0E200BB;
	Wed, 11 Oct 2023 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gv8dj55C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A1cbBGIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457F1EA93;
	Wed, 11 Oct 2023 15:00:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AFB6;
	Wed, 11 Oct 2023 08:00:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEd2sB006050;
	Wed, 11 Oct 2023 14:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=WIGYjJQ1MhXb7driI4EKm4nRsaeEzDcFW9nQfNUEZ6o=;
 b=gv8dj55CYZva5HLZdR8rxJ7x85N/OO2nGXzBOfVWTQCGYzygB8YcvjVriPv1rIfzqFRR
 jWp8zaZNtVwThw1b+K++o2iRId/PfNQvZZmabsNK9jU4ajxgskbGXD/Tp0XeJoPmooL/
 xz9C6YNfTJ0rFN50Dl1Q48xjkgfBG2U7wu2iZRokXNa8Va8AyfyCOAemVfsgT4VTfFTP
 k8DgVOXhzYfewusiLsmnb9Ub0hUpcBHk4WEFAkJ37RZ7cvWEoANQYL9koyCsdttzaUCj
 r1d3Lx2GEa9mMX0TiuhtMgb+XhbtbaMi0FTWkAe6KzPhPNBT4/fS0zobI7obOFlvJ4M2 Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89wd6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 14:59:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEBTSw004744;
	Wed, 11 Oct 2023 14:59:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8hfby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 14:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxCNLl+8ewk5a2G0rX6a1VB/ZueJORal9XUivCfYN6DrkctJHRWh2YZtDygDXQI0Kht7hrhsg59grvkdD5BfjQtmiW5ZPbyCNzR2Kgb1ZMhpOpf2TZSSBXuKlxEtwn4zuejWkbvN6wSXG3aDMiFv9EJF86JVQiewZUQTJnk1yq4WuFmoCnwyj9SyWHvDWVp/5EwU55rFiY+xk+wGK5/qryOBD8NPvwuUXChqbjFeNzIRUaZ7Z7rrDBSzfVXxJkLdN3eqXYkctG9oPwKH9+iLD+fXr977lmAAKYNvBk0eD+Fx0eqTL67VQzlUo2sPD5mFGmk+XzuLXSaJVCBohuc3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIGYjJQ1MhXb7driI4EKm4nRsaeEzDcFW9nQfNUEZ6o=;
 b=gdgvsHXMVTbWWpaKx2kFyOamEQ2FVButHJO3f36mvL8gqyYzAbojt+wHQivMDFYCPYX5NsiEaE8ZIqvzsziCFeocnrQ0ST4++h4uuWWc/GSpZSCCEsjNqUB0+fl0UKA//Ar6swCnB2t8FjWaHamoah0glIfGMEys8Z1RzqQHhyew8o1sIBrySCbuGRDjmEPkgFs+WSR94jjhRWFGQuCkABMjBYespe6pgej2YLTAsbJZr64uxo1cm68tuYcOA8oyeR9fqm/n9TsgyLDS1/P0sozo7wHKTCIyNYFUmMOSUxXE3sFbm1Ecf6vuZZTy6TLUfOc5PRFcd/aJaHMSqgRJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIGYjJQ1MhXb7driI4EKm4nRsaeEzDcFW9nQfNUEZ6o=;
 b=A1cbBGISl30J9b2ODE12Jb4OPMTW/VXBTpEIUZnED0wlsiHftvQoVlGUgMcNHWQhiGSg0jwSU3ltqWqvKDv3NnaAQE2k3HG9ySpSOR8UsG0w1LUXs0RTeZSOAyQnbNF9/BzRUWoc1sW5JKFQQS2cz8FWBVMsvdEbZ9zKWa6ONkw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5259.namprd10.prod.outlook.com (2603:10b6:610:c2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 14:59:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:59:54 +0000
Date: Wed, 11 Oct 2023 10:59:50 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231011145950.6ypjrfgkngukbjyr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
 <20231009090320.64565-11-zhangpeng.00@bytedance.com>
 <20231011012849.3awzg5sfdk3sqmvo@revolver>
 <9eb93423-a2ee-4b9c-be8c-108915eb7e0f@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9eb93423-a2ee-4b9c-be8c-108915eb7e0f@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b225e23-2215-453a-13e9-08dbca6aba40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rIAO5NPxaqfyvDfwLgtqhKATuTnUFie32bilITnZBjESseJLIvD6JEd5utUZrsG+OuNA8exDSQ1TSMcA/cQh/HM1uw38WwTuWkGK4JP0CvK7T843fnvn+8VqJyUMwvouiPM+V6mI7bOy8o4eehpugHDOA4S3kkHnKmLoehYdV/CsCLqvsO6oNSjg6TLRgyrNrP9aiCgc/1IHDAaywTTNROkhzVQbtWqHf5lwH0ttvqAuIA2puBlYc3wBp2mnb+8WXuNhRFeCx4F6PTvdq3Nh8M5jY8j1JTfKpha+JnTh+uCeAqE6x3JKvwE5z53X8URoyd0HIDNt3pOJaQICqhBrQVQy/Sj6mDYhH7LUeId/zzvmDb0Q2hkMKZ6z4dMSZZ20aD0i/3PYKZ9QkelvzuBYd0LUct/oB/PeZwbnoIjoCJPgrFmQbZYIav4LZpWM1uQrlCGabT8FgRMQGNPAbwLJAAsc55ldLEUHXrQpX8HWk0+NKSDBny38uFeKIBwQg7quRKsQ1ajny/MLHXM8zl22RkQtTp2UO4jcEfDWRSUJ160=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6916009)(66946007)(66556008)(66476007)(316002)(83380400001)(1076003)(5660300002)(478600001)(86362001)(6506007)(6666004)(8936002)(8676002)(4326008)(7416002)(6486002)(966005)(2906002)(38100700002)(9686003)(6512007)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0Y5ZWJuNGdueDhBMHByaU9wWHc3b2JKWERsNW5uaUxYdVRnQ2REZGY1eEJh?=
 =?utf-8?B?bUNpeWttZGpxOWN2OXhUcjFhVUZuMWQ4cXk4N1U5dWsvSURzWjVvNTE5ZG1J?=
 =?utf-8?B?OE9XRFdLa0JYY3dBSUFOOEZSNkpiMFlkUm1tMzV0Vkg4QXB0NDVXclAwTm8w?=
 =?utf-8?B?V1grWGNVSmRnOWRsendBazAvZGduMHQvVGpmdGgwSDlqeTFyT2ZVbzJHOFRU?=
 =?utf-8?B?QXVXTTZLdzB5NEJYK0hWOUtYcUZkS2RTY1VKa0dqZFhIaXhUNm5TcitMRWVR?=
 =?utf-8?B?ZU1ESWVJTDd4RUFvNG4ra3BhNDVhK2dXRHlqVnp1czZzVUhxWXZiREpuNXBw?=
 =?utf-8?B?d1RpblBSby84YnA0N3BISGhhSnRSdXppc2YrQXUzcEx1MVl2K21hQ0llQjVS?=
 =?utf-8?B?bUMvYmlibXFjUUJXcWtpVVN4WDJJMmxVd2hucVR6aDNTV052aGVRSnpyZDM0?=
 =?utf-8?B?WEszRmFmN2tvWlBoaldxemZ5RHNTWThYNmNYUUloeGJCRmJkalNnZGpXQWJu?=
 =?utf-8?B?dHduMklTTDRDczNsS0lOOVY3SldyWmQwOHRvUi81Y0F1TTRxc0RNd2I1WGJn?=
 =?utf-8?B?YnBYTTFtTUo1YWNET2pNNHQwOVRIL09IZWlNczlLV2EzNVNEbEduMVNxTStJ?=
 =?utf-8?B?TlFLVGdDTitKdTVEZjQ2djN3WXpSeVdUb1N3ZGUwVUd1ZmpzTXErY2pWNXZv?=
 =?utf-8?B?d1dOQkJFbEZJUmNwaThFYXFhamZkekpZdTRGRHc2NkJ1aW9JRVVldXVkY3hV?=
 =?utf-8?B?NzI2aHpYQmdIQmpDVSt4UnB1L1NFZGcyT29lRjFzWnQ1c056Q0pLSzQ3T2lC?=
 =?utf-8?B?N3Q4TStIbDVkcmN2bHZFYmZMc3pSK0Y0RENHWnp0NTFsc29Zc2RDbGdvdmpu?=
 =?utf-8?B?Y21xOUVSOENFWVkrbm1NWlRSbHFnL2wxNE9Bb09Wd1NibHYzQlozVnRoUUtH?=
 =?utf-8?B?SlJtdko4ZGUwazdRcDJQTDg5VHdSSzZaSHBhWWozZ3RtVzhWRCtpczFHeVZ1?=
 =?utf-8?B?ZlFXemtjUFFiVW01RjREN3hjMWY0cURmcGxMWXJUVWFnK3A1dEN5cUdPZEJ4?=
 =?utf-8?B?VWZ2K3lQQ0FTM0l6Tk52S0NsdUpuOVRtWWo2TGtpWnV1Smc4UmsyMFllZGls?=
 =?utf-8?B?cTJUdEFiZzBuZGZHQmlrdm1zbEFZbExCa2I5eVFyenRYdXVUaFZ2QnN2OWVB?=
 =?utf-8?B?Zjd0a3NMMm42ZDc3ekdsbldjQVBYVUhaZXlkNmFSbGo1aGVMN1JOQkRqNlVi?=
 =?utf-8?B?RXJHQW9RU0V6djJmeDRMMmhVejFIWlp5TThWRThPb241blBDRzVwUlBRTDFh?=
 =?utf-8?B?N1BzQlVkR2o2dDFMT1hIZ1NtYUFRWjRwcWQ3LzdYNWdUNnRlM0tCNERpMjhk?=
 =?utf-8?B?TTF4Unh4YVVtckhsSHJ1M0lpVFdiZ0szODFLNWNycjZhMjB3WDFQQWN6NWVI?=
 =?utf-8?B?cllJaUR0bUpjbmo2eEU2ZFpIT0RJVE1JcVpTUUhHZUZXWUpKNXI3aC9ZL1or?=
 =?utf-8?B?T09mYXBaajNvd25NYlE4Tm1IMEhQVFhKemVXMUhWMmVZTU9ma0FpR2U1dTFk?=
 =?utf-8?B?QUszZ0IvME1vZ1N5Y1dqNEUrWXZUZ2xGM1ZuVG1vS3YwVXRSTnlGYzl3SVhs?=
 =?utf-8?B?TFkwT0R6SkgzSTBpcVFEcGhRL2kvMGVEcXJUcW9scm9wdHROSTFFakw4MUtC?=
 =?utf-8?B?ZFZmMUg4Tzh3Sk9nekJjMWJtSitRNHhnUUJCL1psR0hWRUxldmVLZTdENVM2?=
 =?utf-8?B?S0FmRytPQVcyYUFJR0k0OWY2RHI0bDZ0aitKUGpSR3Q0NyswUXAzYklIWHd4?=
 =?utf-8?B?cERYUFRGN0NxWlpTODBVakliQXlsN2JreWpFUmoxd0VSeHJWeERYVnRIc1p6?=
 =?utf-8?B?YUFENk9sV2VUbjQxS042TlVlOHlHai9TbGRsS0JEZ2FCak8zMmdEb1ozc1dR?=
 =?utf-8?B?Q3pIK0hCM1hjT0x6MmtEMTVNVnUrdUFUditxOHVEeHFlWWdjODRwQjBJVmlo?=
 =?utf-8?B?NFFEWnpUdWQ3eXJMVHJvZlBjaTV2M3pHdVJQQUthU3J0c1h0SnZUMjV1WlJP?=
 =?utf-8?B?SmNwWlhYNnQwUlFMbS9INTlqZ1NwaW9LZzNkNFBqUFZSam9WMzlGSjByTzRI?=
 =?utf-8?Q?9/HHzEV9qMiKTJaJz/tKAIxLJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?dEtlQTRYa0dxK2ZRYVg3bzRjUkgzMGNoNjh3akdUeGVVeHNLYjhhQzBBdlF5?=
 =?utf-8?B?NVlSdHFPcWlOdFZta0FiMzlkemZvaCs4ZmNONERsRXoxWU1PQjFvS1UzcEsw?=
 =?utf-8?B?bG53ajJKbGlEMEtPcnVEYmZXVHo0WFQrR2I1LzNZNnVoNE9WNUtLakhPWnc4?=
 =?utf-8?B?QmFycTh4dWQ4VTdCbFppWXpqaW1oMUlzd09rbWhoL0N3ZmNpK0RMUHQ0S3Yx?=
 =?utf-8?B?Ky9LZXlHWVcxQTZtaUlOWDZrc3FjY3RJNzFSTjFTMjNiNlVoZkFTNGVXdzRT?=
 =?utf-8?B?S0NuRUNWdnN6Y1hxOXI5Ti9VK1dQVlE4ZkpNUmsxemg3S1FIdjdqanRGQloy?=
 =?utf-8?B?RVJRN0dDT0xRN1BhQXpEYUFldkpmTGV2bkxpMTczYlVZYnd6M3g3YXAxYWZS?=
 =?utf-8?B?ZlM3cFFhUU9nakNwY1VzYU5pQk9zRzNmWnlIMGFUaERkOTJ5OERQbW4wK3BO?=
 =?utf-8?B?RVI0NDNiUFpTL1VjYW0yQnJXWWNtUXpxUkRiYkZFQzd2dEVjUlBSMm1reE9G?=
 =?utf-8?B?LzJnK285UlVYODlEQW1MUnBFMEgydzU2a29uS29JdlBnSEdrcE5SMHhzajdU?=
 =?utf-8?B?YU5KWW45SC9VenVvVjYxTHN1MmtBRXNWWHFuZldIU3JYQVkvRVBuR09keHAz?=
 =?utf-8?B?N3EvY05ZUTRINkNmYTBWeVVhSWQxbmltdENiNFh5cWZZdkdTQTk1TDJKcFZE?=
 =?utf-8?B?NUYxWjEzSTlkR2tlRWpGSCtjTnpOUmg0R3ZkYmhsYjhYMTZOSVdTZGJlK2Y2?=
 =?utf-8?B?UU9CNmNKMWJsbTV2cE95dVdVRTBGKzBZWUoxcmsvUFJxZEdlL3pOSkkrdlh5?=
 =?utf-8?B?UHNRVGhIWGJPU0FZd1Rvejk2dklOL0IveGtpS1hjQ01RdmNiQUZnU1NIQU85?=
 =?utf-8?B?aDluY0F0Q3hWa25nRUZxNC9TTWU0QStzS25IU2N3SHBFU0Mra0Qyb3Jxak4w?=
 =?utf-8?B?SXMyTWt6RStaSElFZ05aendheU9FQkhPaHVZeGtiZHdKU2ZyS29GWWkvK29V?=
 =?utf-8?B?UlJlajBqc2xieHZsa2E0YUs3NUFJZEFiKzlRK2FsMi9ncGVIdUtFaU4yL2M2?=
 =?utf-8?B?ODRTV1psSGtOUWlHelczRnUxS0FRSmhwamc5L09VeTBHcEhtdFV1aUMwZWFa?=
 =?utf-8?B?dk1wMW9wMUhZT1hTZSthaHU1eGZ4S245bEUvNlkycmhtUExCS0ZsTDZQUTRB?=
 =?utf-8?B?TW1tdjZYNWhXUk5Dd3F0YVZrbWRMdWwvM3NRbStuS2lndHJpR1dYM0lpWWdy?=
 =?utf-8?B?LzkxSW54ZlFZbllOaXBGRTYwU3o2dUNpNW8wb1RpRTRUL3pnd21jKzlkSDdu?=
 =?utf-8?B?aS82U2R4eFhRaFVTcUo4TjNOR0pOOG5TQzY0Q05qZjl6bmVoUnRQMzFRNkVq?=
 =?utf-8?B?N1lVUDBzQkt4NHdLZU9DdmxBcmcyV3lkaHZ3Y3g1bWQxcmc1MDRhOUlWWXlp?=
 =?utf-8?B?a010QU9QRGwwU3Z1WmRHOUltdlRJWUVNU2ZuYVJDbWE0TkFVRysvdXByV2w0?=
 =?utf-8?B?b0hnVTB2ZDQ1akVJbzlua1Roa3J3V0t0bG9wQzdxYWllOGdqbUxTd0NMS0Ew?=
 =?utf-8?Q?BPgdi6Skj2EC+8ryJ0xvi4Efc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b225e23-2215-453a-13e9-08dbca6aba40
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:59:54.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3102G0+7IrslwoVFbWI5k3cK+oLyy9ZGAo4O2wVfoIOjK0tLFc1hR+Uw8fcZfyCTgzIk01cp9htT8DWbF/ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110132
X-Proofpoint-GUID: uEthcw_PXY-sNNAxPhJNNHKgpSPsZ15a
X-Proofpoint-ORIG-GUID: uEthcw_PXY-sNNAxPhJNNHKgpSPsZ15a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Peng Zhang <zhangpeng.00@bytedance.com> [231011 03:00]:
>=20
>=20
> =E5=9C=A8 2023/10/11 09:28, Liam R. Howlett =E5=86=99=E9=81=93:
...
> >=20
> > > +	unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end, tree_end, =
true);
> > > +
> >=20
> > I really don't like having to modify unmap_region() and free_pgtables()
> > for a rare error case.  Looking into the issue, you are correct in the
> > rounding that is happening in free_pgd_range() and this alignment to
> > avoid "unnecessary work" is causing us issues.  However, if we open cod=
e
> > it a lot like what exit_mmap() does, we can avoid changing these
> > functions:
> >=20
> > +       lru_add_drain();
> > +       tlb_gather_mmu(&tlb, mm);
> > +       update_hiwater_rss(mm);
> > +       unmap_vmas(&tlb, &vmi.mas, vma, 0, tree_end, tree_end, true);
> > +       vma_iter_set(&vmi, vma->vm_end);
> > +       free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS, vma_end-=
>vm_start,
> > +                     true);
> > +       free_pgd_range(&tlb, vma->vm_start, vma_end->vm_start,
> > +                      FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> I think both approaches are valid. If you feel that this method is better=
,
> I can make the necessary changes accordingly. However, take a look at the
> following code:
>=20
> if (is_vm_hugetlb_page(vma)) {
> 	hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
> 		floor, next ? next->vm_start : ceiling);
> }
>=20
> In free_pgtables(), there is also a possibility of using
> hugetlb_free_pgd_range() to free the page tables. By adding an
> additional call to free_pgd_range() instead of hugetlb_free_pgd_range(),
> I'm not sure if it would cause any potential issues.

Okay.  It is safe for the general case, but I've no idea about powerpc
and other variants.  After looking at the ppc stuff, I don't think it's
safe (for our sanity) to proceed with my plan.

I think we go back to your v2 attempt at this and store XA_ZERO, then
modify unmap_vmas(), free_pgtables(), and the (already done in v2) exit
path loop.  Then we just let the normal failure path be taken in
exit_mmap().  Sorry for going back on this, but there's no tidy way to
proceed.


From your v2 [1]:
+			if (unlikely(mas_is_err(&vmi.mas))) {
+				retval =3D xa_err(vmi.mas.node);
+				mas_reset(&vmi.mas);
+				if (mas_find(&vmi.mas, ULONG_MAX))
+					mas_store(&vmi.mas, XA_ZERO_ENTRY);
+				goto loop_out;
+			}

You can do this instead:
+			if (unlikely(mas_is_err(&vmi.mas))) {
+				retval =3D xa_err(vmi.mas.node);
+				mas_set_range(&vim.mas, mntp->vm_start,
mntp->vm_end -1);
+				mas_store(&vmi.mas, XA_ZERO_ENTRY);
+				goto loop_out;
+			}

We'll have to be careful that the first VMA isn't XA_ZERO in the two
functions as well, but I think it will be better than having 7 arguments
to the free_pgtables() with the last two being the same for all but one
case, and/or our own clean up for exit.  Even with a wrapping function,
this is too messy.

[1]. https://lore.kernel.org/lkml/20230830125654.21257-7-zhangpeng.00@byted=
ance.com/

Thanks,
Liam

