Return-Path: <linux-fsdevel+bounces-11323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A35852AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A062E28494A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23D1E88C;
	Tue, 13 Feb 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UN1WwJu4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBp26mLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF71B7F5;
	Tue, 13 Feb 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812195; cv=fail; b=Xjo1XYW/c3nhQtHFsRlt+J1zwr/VcSmXUa40jQQ8xiM4TNbWRImnC/mljUgK1Rktx4K9Te+d7B4q+orB3G4TsCi3fxDkt8vIUuhiMmifm8lgB90Y95q0QvwB0G3Rr6rluupVD5qWvQNSqUwJG7X3T9/12K5lCfoTZomFnfhfNJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812195; c=relaxed/simple;
	bh=3lkrZFqNrb/mVuZm4OFPBzIxyqLKCLCaRLuBTWBjBYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nc6Ev2+LNruDWlWMf8KIvpzvv+V9NUsJbnhCv1BWve8frwmFmscFOoN+Ocr0Ji7z37Ozypz4Kqi53W2mI8XLH1eFa8Cm7X8D0FRPkpW8ZZgwKsfpBv3pgt7Z8I2Ibv1PkZnZhe/0pGWGkcTioJSPBl6r65EO6XhJJD7fY4W/a1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UN1WwJu4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBp26mLl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D7xP7C006272;
	Tue, 13 Feb 2024 08:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9bKJtrA3WEdCoeoc5QQkcdmjeXLzXjNEkqTQY6iqXNQ=;
 b=UN1WwJu4KbAmV16gIQGyuT+CRWMp0n3t+g568z9Vnnu/RBNf5BW3aMNHClUa1bjutR+3
 4bu8Tfrn+UhnvRvi5v+N/fJgukU2HfPVBL+HxFl1ph1SUrr1cdHsCPoq8dI5vX7AsqMA
 6aCG5u38poaDG45yb+gH9S1NrAwS/DcOPkKL7GIdz1HJbG25oEoPEPWIkkp1HSmTUyyE
 0kefjIDKmtSjEbAi/6qX9PjVQeZbvCuoXWBH/wHppHsXx/Ie9hiu/JrQiztbVnNTsGt/
 +ERL3bivI59sGeoOf5Wm1FKeeV/k+um4RJhjcSZGhzWy69e6Icvv64/E59KT0FamkNMQ nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w84gx80x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:16:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D845Fr015414;
	Tue, 13 Feb 2024 08:16:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk709xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:15:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9qlyoo0nG2ouxUnAjjUGYRjKnl3kYjpqho3Tveq24cq0G1UZVd/7V8GuQP4qSdgIvPwyQlLON4YLNBodvQI2f4NpmoK5ED4zitpZ+wdk1CWUDMuiSh6hvytwIheVzggxA8gf3zRRRrvQnRJNZ3nxUx6JkJz7Rq594kpdbYUWJHbL+o39BOidBjZ8qWTIIjnkNN6h/aXGgfFHSR/65SzJpRo8TmhoBcJN/v7JvZRn+ivWsTqbdVWAJSKkAwIhZOgQwNsVzwtM364/gFk/34uagn7fH+dd8dxP3taSw+SoBo+GcfcFLjTCcCPALjn0xHR2IdyAHWJsHSt2goby+tDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bKJtrA3WEdCoeoc5QQkcdmjeXLzXjNEkqTQY6iqXNQ=;
 b=BYYW+FiKqsMFlOLrfGqIw2ji+HqQq/Zc2goRpFqU/HntQRgAh4yv8bKLv9+B/Orqx6ioA6UFmMtr8glfMxhvRbg2fVkbvj2p3N+A41L7n9KXv+WTkXNEIPg5NZD2NQONRoKmXhg519tviuGkIpA3+nHFoakEClZBSiJDS0+Vhe183GvaM5IrvLLfr6S9X0lz7oPddq5X1jSvkcFZJ4OD+8tgn9UwJy+hRZF036Mru2e174Ttzaa7sfs3sEs9QNJorTwZW+grLRuXnJdr/asvcil1CGSqt+GddpnT2y46iKo929vI2GZlzKGvEJGFVCuHDuGZntgeG6DvLxrict0UTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bKJtrA3WEdCoeoc5QQkcdmjeXLzXjNEkqTQY6iqXNQ=;
 b=qBp26mLlPKmb0DZM4Q4NulopQP15P4RsLhAbMabnZBu6tl/TCo8Ft+paI1n/bL2SEGLsEcXJEmz+EaXzAG3mw4RVKZ7uf48hmcosIvXuVhbksXz/dHFZyfc4JuLGz9+L9WlSSe7n1TOhNyTS0qM+jXuPeeXeH4kBazILr+yw5ss=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 08:15:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:15:57 +0000
Message-ID: <9578e413-5425-40f8-84d6-0f6876691e75@oracle.com>
Date: Tue, 13 Feb 2024 08:15:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] block: Pass blk_queue_get_max_sectors() a
 request pointer
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-7-john.g.garry@oracle.com>
 <20240213062339.GB23128@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213062339.GB23128@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0154.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9248bf-8478-4aa9-eb97-08dc2c6c0181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1PmFAL8djGykZFEellTT5wqK7DYuatHwBJtcC1ckZXi2y++HBLsX/FLvHzFKmwaKwh1s05s4RyP4Z4snKPDIdyItD50F6qh2IeDt6ZgXBBXG9cyo1QVwrR2tbxo/qFHOv8pHz8tu4Q5j/QOrg8JamOsLoenIuJIB709UHOfXaVesgFXtk3WVcTfsEbN3Qrm0nzr+t9Kj2Yo/AbBN5Q0Jon9ur1Q6sVOD4hv8w8i7Q/Vqxoz1TnhUfMPXjBSnRieeZwhm7EIQUYq5dZVgdZuMMMRO2tcihOmKPZ7vkubcGdtw2ZXQbsrKWGRbWUA/i2VP+eFHcEVTBgVaRb/RaOI0Wn7QT8MjK4kqgCFCaseuw5RhAIqyzXXJRBF81jtPl1fK3HmtlVNGUx9xLojnBAKYABRtbJJuyB0cQAJjv8B41MSODg0slozMiUiOaXVYdEB9+yAvd/xYZug0HtGB3UHuK8f0rQh1kdkMvbc1yciyyHKkkCsTQ6CndLaI8TVtnLwn58qKnh/EVDVYt1XFAM5/Fn0DWQD4JmWtUle/pag6/QyQh2yNiaY9K3Jpsp99YV47
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(558084003)(86362001)(66556008)(66476007)(6916009)(316002)(66946007)(7416002)(6486002)(478600001)(2906002)(6506007)(5660300002)(4326008)(8676002)(8936002)(31696002)(2616005)(36916002)(26005)(53546011)(6512007)(38100700002)(6666004)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGxMS240bTNhLzR0SG5zVlFlU1JweGI4S0ZVWjdiTXFZZnBvYlBSZzQ5OTZz?=
 =?utf-8?B?eVhLR1RDbEh0ZTlFaWkzcEhkbjdFZC9NcjNOZ1NLWWhPaTN1RUtGbzBTZUxa?=
 =?utf-8?B?bmRIRFMyV3Fqem9TbXdjQkt2RE5ZS3VHdWl4Tm00aHB4L3lXUm00THVTdkZo?=
 =?utf-8?B?MElIN3h3NEU2OU5UaXlKK3QvaytMVWxwenlWSytVUk1CZUljRThyVmt2VDFR?=
 =?utf-8?B?U2gySitzOXd5aWJzWTRFRnMrbmdXVlVqeldUeUw5aDJFMTZkQlFGNWJHSUZH?=
 =?utf-8?B?amZ0Zlk1UlUwRHJhMHg4UWlpQ2VBZlJZcjROaW8vQkRGa2VrRnFIR2tFeHdL?=
 =?utf-8?B?cVA2ZXlQYkdxVWlNb3ZhU2NodmllUTJ0RXBYVzR1Y3dFREU1WXh5ZW83K1hF?=
 =?utf-8?B?MEEyT3V0cnVad2hEWTNFRkVzUkxlK2EzV3FnUHY5cDkzKzQwVzJFV3QrNGpv?=
 =?utf-8?B?ZXB5ck40QlZLbFk4Z1RtRTVudzdmaW1GS2ptZnNkckVMN0Z6bUR1bUl3T2NQ?=
 =?utf-8?B?WFgycWFWQXpFaWFTU1p2Y1NueUs3WFQxdHJCWDNCcXppenliWFg4NTRkS1Fy?=
 =?utf-8?B?aTVlUHB6VG4rMTFOa0hGcWlKaC9qZlphaGFVVEd4OEY0bFNJYXBiODE2U25w?=
 =?utf-8?B?S0tXVHUwcFdXZ2NaeEJpdmdrZ0xYZG5QOHAxQXVaS0FyeUpSWWhGMnZ2M3hN?=
 =?utf-8?B?d0s2VDNQaFQ0QlNBTWlmTFAzcE5nN3NIbktmL2JsczRxVU5NTkR6eS9RczFv?=
 =?utf-8?B?SVo4OEp3WUZXMCtpakd0bFBvNC9UZzBWaHJkZmtZdWlRaFBGVUtERE9jRWhY?=
 =?utf-8?B?T1I1Y0Z0VEhyZDRjb3BlQ0lwekRBVzZUdUVnRzVveS9CSzJheGhNR1JzTGx2?=
 =?utf-8?B?Qkd6MWp5cVFxYVJ4OXhya1ZJTGZhKzkrWGlKSUFRZUxQd3JCUHRkWm1RR0pa?=
 =?utf-8?B?cTlKUmRXK204dXBGeXlKaUp3bnhuU3VoeDJlZ1ErVHQ4L1FFejNnT09NN201?=
 =?utf-8?B?a054S0RiSUxjTkhLKzNHdXY5YzN3SzlvTTNpRThQOXBYQzlXM3ZOWG5qbW1K?=
 =?utf-8?B?ZHoxc2x4WTc0SDZCdmxsak9YOHg4UVMwbGJVdThXL0tFdkM4WWF5KzBjUHFQ?=
 =?utf-8?B?Nk1PTE9qSXBCRVdoWUxXdzRtOGw1Rm9KaDFZTWpZMzVCejVZY0RmTWlSZXF4?=
 =?utf-8?B?RkNRcjRZOExkSW9oR3lKc0xvQzg5VXdCTUxYYzczOUhnUXNEbnR3OUl2eGpS?=
 =?utf-8?B?OCtQckV3cHVkU2VKUXVrS24zT1EvaXN1WnRpdTQ0RnRXWDdGZ3ZONm9PaEVi?=
 =?utf-8?B?TkVGTmZJajVkOVNhRGVhZmJBM2NFeTFqNmJXUStOdzRLbjNNbkJDa2pHTmJU?=
 =?utf-8?B?SEZhOFczbTI5VytJeGptbWFjQ0JHeWJjMm5uUDdySnZuMVhLc0UvcEcwU215?=
 =?utf-8?B?RlJVZGFEUzVmZ1M0UVZaaDUzQ05MTVBPTWU2bXUvNU8vemJDSE5iMlRGYzhW?=
 =?utf-8?B?SUZkWXd0clN4SFA3YUY1ZVR1M0ZwSlpvaGwwRS9NSEZkUzY3bmFCVklXRks0?=
 =?utf-8?B?VE5vUm5VNWV3QXBDQlJTQll2WW5hZ0lRYkM0ZGJRdC9UZnRSbHNuQUtEb0th?=
 =?utf-8?B?VXJpUG5obERNVFphRVo0U1IvNnhFcEFlMlBqVW41YjlqU2FNYWYvWUhodW9Y?=
 =?utf-8?B?OUJ3YXFTbjZsUk92cWFWaWtPRFFBc1NtS2ZJMkJFQkxVQ2tUcFlUd0dXK3Vt?=
 =?utf-8?B?aitzYTVKcURqRjUvTkdKQ0I1R3VOcERBbGgwV0kxS21jMlYwNWQ0K05NUEFi?=
 =?utf-8?B?dGpRQzlxN2lEbDUvcG5RVUl4OUMvTmR5dFNoZUQva0NKUXM5bm1LdzExUmJW?=
 =?utf-8?B?cUZQOHJMSEtZRDBJaWtFNU5NaitpVlhuZk90NGNmMkx0UENJbHczengxWXVB?=
 =?utf-8?B?R3RML01Pd05vMHN1b0FNazF6SUs2dko0dmhWTUFZZWdaSkRwSlN6bHR5dmN4?=
 =?utf-8?B?d1hFSDVyMlhMdzl6MGJXM0FzVFBEWHg1ZVRjdDN6TUEvRWZBMDMxaFVQOEhw?=
 =?utf-8?B?ck1NblpPMkNzY3Fvc3I3QS81SnZTSjFWZG8raWt2VHVlNWJkMW9RK1BZZ3Jm?=
 =?utf-8?Q?7+Rw6g70ZqMracVg0aGgeTVl0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dPc/YnJhOzz8D2poyNhYuvWeWjI5proml0Ll0Ns8G00idJO3HcfuzuH9D+qWzw6RNtl4L//XEcv+IhKVRtxr//7I9trbzpFIoimW7RRg7YtBrAXuZNS4Zm6OmACpc/IO1pcKH4/KMgaN7fklrVBG4GAZix6IOT4AqyWyqRvwxis2TkBveUbbjxBkLpPOn7JVMBViVL+Rz9VNXfyjWcWuqwLqOl0uxyX8AHLqLLZj8oVMKlyPfnfefIlKMYWorlqyvvLvYIQqKA8kHeafykt0qGQKqwHJ/l0gX/YyDnZHm5RC95ih+5g9mipRl2s1XD6ePmgq3jeANXEOSm86+7ZC58RR4pjnl9oKKwsv4WN7P6w+Sfryhu/kkv+qcYXfMEdv40Y0iC5dA2ekxin+IzETVAKU8RtdcoSyQCW/NVfyYRP7lSgv8DMCw91pY+hWEfRkAQ4tfxXsVxokgnJpEsXHlzEh9yDcummmO8+lMV7vvp76EHvWlkfagzAjgQ66kigFU+4DX3wdfaVg8l/GXY1ozshPQc0fPKEqekfxlXgvg/SsCiVMXKP2OjJZkCMpqa9OgB9H1P4zZAQO9oaUNOnAyqZkqChupzX+GjWNQjpysss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9248bf-8478-4aa9-eb97-08dc2c6c0181
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:15:57.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XpOxVHPbF6xhGflBAyx0tFMhCuLqN8+HWCzz62qnvyD6w8B1Hk4HLOZxroPo/2dvnwIK5593Vk3SXoZh4D64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130063
X-Proofpoint-GUID: HRa92vXzwMYoS0EGsJT270v5Yb5J_adn
X-Proofpoint-ORIG-GUID: HRa92vXzwMYoS0EGsJT270v5Yb5J_adn

On 13/02/2024 06:23, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you move pure prep patches like this one to the beginning of the
> series?

ok

