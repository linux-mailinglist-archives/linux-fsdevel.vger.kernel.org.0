Return-Path: <linux-fsdevel+bounces-2712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC127E7A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE8CB20F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F361097A;
	Fri, 10 Nov 2023 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AoWtWcEb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6tT+ppP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B9D533;
	Fri, 10 Nov 2023 09:04:28 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8129AD33;
	Fri, 10 Nov 2023 01:04:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZHVQ016141;
	Fri, 10 Nov 2023 09:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Kg+ZdlVfxTS56FHohNuREyR2kuL6Vr+mXjneCxw4F/4=;
 b=AoWtWcEb5yotULRPS/f8sr3LjP3IaoUI/6hK9Y9aaHWweT1y7RqL+tpPk3GW7RRDBq7J
 xUZ9OCALUbk2LuS7uGfVEue2Y8hYvtJnS2RYSUvM2m97l4KNYjmjwh63Q6fIIltfBMYI
 0yHhA3Z+aS08nSaO3DKatMRYxmJ3g5KMvlkrSGje0JbZpteGBff9pdoB6ZWQKfq2/B8Y
 F8jsyTy0mkWXA/xpjUJdno0vLperrb0ow+yM03a6uYcYgIVD9Il44NyZLwsol4CihZMG
 uezEcknMrGZeacixTG3S341BDKvYU9dbpq9+y0jLGahrDrH5qQ285OoP3EmjZ2VbVPwt 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26wrsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 09:04:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA80jKn003937;
	Fri, 10 Nov 2023 09:04:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w20mfqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 09:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQUJD3Eh48KMKZOkcx858Jtgv90EdSCvqIG4HkGUXmw47jUbrSLDqiGU339jjMy5sUeUKfepX89zLJmHorkYtpwpMHdt7GPdAqNPgF8U/GJIRRBCGzdf+NjyG7bQZWaB/GknxmYY7bM41N/2i6sypYTc8eNWKbSds3irsymijOoGEUohjFEzaJ/k1aIE2nIjga8eSm1a4w/5353Ti23BKHDakDqDd6Xu5aKvLUbBDpH4vHWapdSGwjws151erUIYkOEFKnm5LiD+HsXS22Srfiy0SJqMXzi6c+3a0kMWjCaDgyiOBLWAA57EQN8nkkZGssc2FTOmuFM/vgTqdEapPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg+ZdlVfxTS56FHohNuREyR2kuL6Vr+mXjneCxw4F/4=;
 b=m0G5bO3eNO5Rak1jIr1yV4Ji7PLRpa5a39b7BuvMRN82Ijcw/IovAryQLG/j0OrVMW223Hbpkxzyft+8Bh6hZzRfV6zBTjEBPvr0P482Ftx9Xniv+34ek20kTyaZ/S38WNRkGGX6fxptSdOhGHHIlzaG6HwuJ1/8qg4U7gDC/zxK2ix8HE9tNI6Ssygrn77Cvzp/XuwwwOQrZLebpzt6vKBLdb8oM2YhQ4cVCkTxTJzR6eBzxgq6PUy3m0OyRItlzlf48Sx4ReQiXMijergrI6HvTh/JM3UFwAFm5qaBNNBPPGYx3+XAXGKkYFpG7qn93ARLs6uOwgz7E4h4PQcdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg+ZdlVfxTS56FHohNuREyR2kuL6Vr+mXjneCxw4F/4=;
 b=m6tT+ppPaVlRs89ico6R60OUK5CBlsHRHDX2dEh/frD3Y1KP+m5EioxJKgCtrEsQ8IZ9rbOsZv1fqsJTd6W0zTJCg604dP0cUTYGNnDmlSmKLA6xti5K9FZy1gGOa//P0lDkjp6QBH9l3aWmB5W/Gct9H9GhSxRt26Js5yfrB+k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5272.namprd10.prod.outlook.com (2603:10b6:408:124::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 09:04:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 09:04:10 +0000
Message-ID: <52001b8d-9109-2119-a29b-01ee2d4706be@oracle.com>
Date: Fri, 10 Nov 2023 09:04:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <20231109151013.GA32432@lst.de>
 <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
 <20231110062325.GB26516@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231110062325.GB26516@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 43421ad7-919d-4b40-a0e7-08dbe1cc007c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j4UggNLQZfkoP8G6gDTKaeRjo+wW8erf6beDTPKEd3iXUlE/dGZWk5lVN2n/uCPbkj/zxl/leQx93/kL0gDf6eg16Gm7OM9a00rtEd682XfJiq58BP+o6uu+XqOEnr3aKsnEN/zckHlJHNXlpdoo1i2DmEkoXgdsDnzIBDgIjzCrw+79EC40GzLQZA7veZYf/AphJK3SpnNOVCWTDQUNzQAF0/8qqGQWvQPaxf5jphbBJntdjTERTeZbjBZ+JeJea8S903vYWCYt9cq6aItanQmk3+scrJ4BrqkqvNqQ/FtvPqE+iMS7A1PBQSJQBcs5EeAi3wNvE0gTwyzJ3Ug7iwxowdavgc69yTNUSRsdWrNAP7PweHhz3RFg2q5yMhGC5mVs5Q8wOxJxlyepZj5GIgWKbj2/evQhiED3F6RmKGyX1Ugqr3q1Pj+58pPV6HIESFH6O9LKwFZry8D9Bfex/bQtFt++CXr+ezNgNaCw6NvRyDGH8arX1gICfv/mlqfmMwEEi+M7yc3dW8GfRojwsMrv0Dt1AIaV7tFGUqfJ+wvvCE5vt+UhuihjtbG5JLXXN3iDMb8xs3xmQN4+oRlR8UoA54aA8VAfORihiQdw1ziWVU0bGz4MwrWwOle6gdLk16Mml3OLyXeyc728/uR3u/cCIT036Nqa7rypQ2fP1vI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(8676002)(4326008)(8936002)(2906002)(7416002)(5660300002)(86362001)(31696002)(41300700001)(26005)(6512007)(31686004)(6666004)(36916002)(6506007)(53546011)(478600001)(6486002)(2616005)(107886003)(83380400001)(66476007)(66946007)(66556008)(316002)(38100700002)(6916009)(60764002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTNzMmRVc1FRQXJvR1FjYnJzZ1ZmcmZ2QS90bUVUZkIzcGlLUWplVGRRbElI?=
 =?utf-8?B?Y2JDL3FmWUV5REI3ZGp1UGpST0I0T1RqNVRhTzAva1pYYzBQY1hLL3dxVVVO?=
 =?utf-8?B?MFM5QWhDTEhCR21UQjFwY1gwd0loMjJlZE5JWWVGYm5kclUwY29ZMnoxLzJG?=
 =?utf-8?B?RGZsMEh2eGlCNnB5ZUJwZ2N6cFJSdzVUZVV6KzYrTDJiYnd3cHFYa01mWDZr?=
 =?utf-8?B?S1hLcFptNXBadG5OQ2FZNU5menh5TU56WXRtTUNwSGxuT2tyL21yQ3RjN2gx?=
 =?utf-8?B?WjdidVVobjFicFcyTVJoVnBxUkZsL2VBbG1NKzZ6bkhZTUs1WWpWc1YwU2JO?=
 =?utf-8?B?eFY4aGlYOGphMGFocnZTd3BWbE9DRnZCQytOTnFBOUU2NnA3L3ljQkxaMEdG?=
 =?utf-8?B?SVZqS0RPRnNQTEJJbmtrSis4Uitld250dXJVNXhjenVMbEI0dlNuTlhqbEwv?=
 =?utf-8?B?Wm5ZUm1qaEVqdVNUbVdrQXgrVDNPVmJVNGhsRytnQTV0SGhZaVJYa3RFL3dw?=
 =?utf-8?B?MEdQSXRKbEhVK0cyaGdFbHprdWh6TW5qbVFiN1NLN2xiSmNXZlUrWUQzWnVR?=
 =?utf-8?B?SStHd3ZZSDNsUDRYa0hwRzhEejE3OFl6ZkpWZHNCSmZobUtrNVh1TlhkTzZ1?=
 =?utf-8?B?RXJ2NEkrOGJHcUdnMDUvYjdWdW42ZTRpOXI4T1RkeVcwaXQ5Vk5DbVVLUzc4?=
 =?utf-8?B?cndOU083ZXdpbGNRUVpBZFVLT0lUUXhpaWlFdnFEMHg1SUo1S0xuVHkyQjNq?=
 =?utf-8?B?dTcwMlBBalJVVkxnYnkydlpsWWNwKzZlNWowRVRleTFobFg4OTBIejVqS2VJ?=
 =?utf-8?B?WDk0cW13OHRUa05QMzgzampVTkF3N2FSN3R1ajZGSGZTdk8vOHExa1FhZ0Ez?=
 =?utf-8?B?UTl4UXB5OTFkMHp4Mm1TMTQ5Y2ZtOUxJdTVJK0lUL0hWWW05R2ZVbVhRMWQ3?=
 =?utf-8?B?ZGsrSXNtT2kwUHRLUjBSNmNsaG51WUp6THlXRGNiS1lsVnVzNVQyS2wwb1hH?=
 =?utf-8?B?d200czR4Y3hBL2xDb1NEYWErNjE2WXdPY2ttdlprUjRhZHVXSHp2UitCSlRP?=
 =?utf-8?B?a2ZMUGZ5S3J3SW5LSTNGTXFWQW5xck4wcllJa2hXbG12THNMcnBnZnFPMmhY?=
 =?utf-8?B?Z3ZjU3ZndEZtU3F0SDBtZkhaQnpFMzdPcWFyb0JtTElEUTRGQ2hMTnNUNmQ3?=
 =?utf-8?B?Nmhvb1NaeldKMDV4bFRacHB0SWhFT0Iybk9mQzczN3hYaFlINFJ0WGhkQXJk?=
 =?utf-8?B?ZC9VUWVtRzUvNG9sYUNCWlg1SjdsbjhjMzBOMjR5WmVneC9PZ1VOaHBqcXVs?=
 =?utf-8?B?RHFGME5qNmc5ZXE5S0tmSnZQZ1pHaXNsMTU0bGtkbmh0MTJOSC9xNWhqQnZT?=
 =?utf-8?B?b1IyUllBMlgydkJHV1E4ZzFJT3phelVkOGs3N1NuaVhaS3ZLWFNLN0RBMTEw?=
 =?utf-8?B?NkdTNFBEVUVyd0JGcy9jV2JaWjlIZ0hXS1llYkF2RExNcC9NZGo3d3VJdlRS?=
 =?utf-8?B?WkJrNmc5aHlmcC82S2hwd09SSWtqWnBXekkxUWlFMlhoQVNjRzRWNUxDWDJF?=
 =?utf-8?B?K1g1dDVRUG02WTBOTmZlV25wTDNLMm41cFhRVENseThEQUdib2xSeGY0WjBz?=
 =?utf-8?B?azZNNFNlTThjZzcvUDJJUEtKMmt4aFk4aWEzTEkrZHdOUlJjcENaampGZmJT?=
 =?utf-8?B?dTV0Zkc4bWZnNm53a24zK21FMFNZdGV6eUhmRlNZUnhad3RXT0NzYzE5dGcz?=
 =?utf-8?B?czQxSEM2QmVrRXhpSTdJWXZFc2dnRXhpZzFYb1ZIQTQrUHlPY1pxT21sTWpp?=
 =?utf-8?B?c3d4Lzhhb21OTmZuR1ZqRnppMEVJYzViSnNnY0NOelNGM1c0a2M4R21ZNExk?=
 =?utf-8?B?eHR6RmZvaHQ3b3U1dG9adFhkRU1ydmdXTWVVNHRPMmNuVWxOblFRdzVCUERk?=
 =?utf-8?B?T1l0aExVaXl4d1BndmYwM0c3VnRZWURLMWdjdFMrU2ozcnRYV3VwMkJEejVQ?=
 =?utf-8?B?OWhQWS9paWh2WnlEcHQxb3h2OEwzcXY3RWdyaVJOdDQ4UFBOUzNzdW0wR2h6?=
 =?utf-8?B?UlFBdXY0ZGl3S0d5eTQ4UUR3OUQwcnhHVU9zQ1U4R2hrV25OSVUwMUhocTRY?=
 =?utf-8?Q?g1HcMQOYaMdV3iIyJ9JpJ1cYN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?UDNPWFZYWXNqVWY2eStLcHU3Vy9LcVV1d25sR1ZrSEpUOFNOVWhOY2d0c2pu?=
 =?utf-8?B?K0tvcEdoMFpCOS92NDB1RE0wWWdGVlFPM1dOekFSK1dQQnVueDRNaWFUbGZs?=
 =?utf-8?B?NkRQN3ZneEdJU2lnSmJaWEJsS3hCS25jUVB1aEdUVlJ5ejlSMm5pSXRpYU1M?=
 =?utf-8?B?N3BSaDNJUmpZUnBheW5nT01taG0rQ2FDRW5TckxnVFhOWHphM1pBMStoRlFF?=
 =?utf-8?B?QXBWczltVnBHd2JZTis4OWtnajVTN0Z4SU1ralI5NWZud2lIRXNobUNaSW52?=
 =?utf-8?B?dGgzZDJTMmxETW1GZ080NEw0N2JzaytCakJiRDZydzM0dGN2ZlZVbU4vaWdw?=
 =?utf-8?B?VDBYWTg3OGJacnkvcjdUaDhYc01TWlBreHVENkJXQm0yeTE3cFgxZzlPdG1i?=
 =?utf-8?B?SFNJKzRYSU04dG84RGV4Zmp3dzZYSGREazJEVkJYa0xTdjAwVThHSlpRV1hQ?=
 =?utf-8?B?WTFma2ljR2ZZcG1mRjF0NGFnY3ZvcFd1cmNTL3RiNGwzZWhvZ3ZjR1ROR0pH?=
 =?utf-8?B?aXY1YUZnbkYyWkFTdXpoZzhEN21kUmNWSk94NzNXZUlndnFnQkNPY0xiWk1F?=
 =?utf-8?B?Nk01R05MOE9GR0dtSHRQZ21YNWE2dXcxSFdBZUFNVHlhVVFZK3lNakROSmlW?=
 =?utf-8?B?WjljYXRua041VXNpQ1E4ZXJNa0xaeFJRYUZDL1F0L3hJUnhTd1dRTzlJbnJt?=
 =?utf-8?B?YjkvbXpSdWlRa1lNUFJKUGNULzNRajlZYk15ejRSZktFdkZ2OHAwNU0vZVNV?=
 =?utf-8?B?S3JzVHplL3AvVElsWXpUdFpLeGRCWlFiaFUzb2pkbDNVR3MxOW9NVExVRUh0?=
 =?utf-8?B?WU9ZRUIwOWRTajdHb0djbms4NFAzS2dUVXROMGw0UUc2N2FCMCtqRjR2cTBI?=
 =?utf-8?B?YlF3RERCbUlFbCtZQUhvSHJLVHB6M3hmcGl5UGxCVWZ3V2NYQlpvZ2E3WTNr?=
 =?utf-8?B?QUgyZnhidW5lOENUUUxOdGF0MVpqUDRmNElNSytMTkcwS0YzM1AvdHpiNTRH?=
 =?utf-8?B?RkhxQ1V4dyt3QjB4MElPaUQrWTlTNVlNK3gyZUo4VVl2Q2ZpOXRTRWpaWk0z?=
 =?utf-8?B?Mk00Q1lIcEJKc290cjJRZ0RrMzg2SFJUaEFuRTFUS2xkSGJnMkF2TUJYRThD?=
 =?utf-8?B?WXRmL05vQms5RmlsSWhGZmdZeldVM1ZkVGw2cU5TRXhpK1pDMHFkZU5ES3BH?=
 =?utf-8?B?bVAwMHJyVkxydzAwejZUZHpsOVlHN2tXMzdrV01DcWxTRmh4bVNQSkJrR01v?=
 =?utf-8?B?L3FMZGFEeU51ZGlnVm1qWXRBUVhkcnV2R1UvOWZaUW03R1RrL2V5YzR0TGFM?=
 =?utf-8?B?UEorODNVQ1FINkpuVUJHMDVqYXkvMm05RVBMZEZKR2NyanduMUhwUFdYRHVS?=
 =?utf-8?B?RWxXWnp1bFZqV3lmcVVGWk1Ea1JGYm5kMXJNUXYwQk9sQnlQd3pwaEhFbzhM?=
 =?utf-8?B?Tk9jbnFyQkpFWTYzT2xqaDdIZGJqVkdDNVUrWmVBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43421ad7-919d-4b40-a0e7-08dbe1cc007c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:04:10.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcBFhR2/YZwRdGAfCtsad3HzNO7HW6kyiWt/vpmAN3ofVYxCjCpKZy5OTDpPnpdfKSmDSIMmXOIp34kVEqvi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100075
X-Proofpoint-GUID: R5iOP_6LOtGC-a-fQdP7857J7b-TZ1dj
X-Proofpoint-ORIG-GUID: R5iOP_6LOtGC-a-fQdP7857J7b-TZ1dj

On 10/11/2023 06:23, Christoph Hellwig wrote:
> On Thu, Nov 09, 2023 at 05:01:10PM +0000, John Garry wrote:
>> Generally they come from the same device property. Then since
>> atomic_write_unit_max_bytes must be a power-of-2 (and
>> atomic_write_max_bytes may not be), they may be different.
> How much do we care about supporting the additional slack over the
> power of two version?

I'm not sure yet. It depends on any merging support and splitting 
safeguards introduced.

> 
>> In addition,
>> atomic_write_unit_max_bytes is required to be limited by whatever is
>> guaranteed to be able to fit in a bio.
> The limit what fits into a bio is UINT_MAX, not sure that matters 😄

I am talking about what we guarantee that we can always fit in a bio 
according to request queue limits and bio vector count, e.g. if the 
request queue limits us to 8 segments only, then we can't guarantee to 
fit much in (without splitting) and need to limit atomic_write_unit_max 
accordingly.

> 
>> atomic_write_max_bytes is really only relevant for merging writes. Maybe we
>> should not even expose via sysfs.
> Or we need to have a good separate discussion on even supporting any
> merges.  Willy chimed in that supporting merges was intentional,
> but I'd really like to see numbers justifying it.
> 

So far I have tested on an environment where the datarates are not high 
and any merging benefit was minimal to non-existent. But that is not to 
say it could help elsewhere.

Thanks,
John

