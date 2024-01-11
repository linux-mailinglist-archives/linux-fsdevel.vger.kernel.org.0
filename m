Return-Path: <linux-fsdevel+bounces-7783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7519F82AB67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ABD1C22C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E83812B76;
	Thu, 11 Jan 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OejyZpJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K7p/2x8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC211722;
	Thu, 11 Jan 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40B7sxJa012110;
	Thu, 11 Jan 2024 09:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9YowBoR5m0Cl0ufllpoPiYsh08NuXiehx5jx6EaG9QU=;
 b=OejyZpJL0r6rsyWKsyGy5en7W8RiCKVZ29y8nqk+lzAs6h6LGc46eZPeSjre6f5so9uJ
 jPkNMag+r3kz7Xo7nIHmAOtzIyP95qb3/QXxjsew5NMSyZO9SNvgEORTsvG6JGGbIq8K
 J+slIaIMIl0wiVk3jbD0bZEB7vV67GJTAhjEXTwHJlCBarcKxnGmyZDR0544ymNjOXVY
 Nqb9T4QUpZ+Rl73uvCt2EW2QhCQikijyIFL3nA2uprSaZXqWMkratwaDSK7MVRBP++jE
 3Y1eduKAv67SovTSlXY5KnOl9oAi2/ZNH/Pqf64Ayos17+lPmPUadogTA4xVdWBlhcdC LA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcbrg9p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 09:55:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40B8ti81008684;
	Thu, 11 Jan 2024 09:55:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuumvp0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 09:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clYua+80WVwW9UExe01ihJfp/jcnp9PUc/mAYaMGatqg6xvgxjqjH35UEZBU0qPL0yheKGPgZTGYytF7eza7e1E/sZgwpBTAubWE8VtTDu19J1k847uaD66xvjhGUQeRC9gtnLtH7uaauiPflCEj+Y+L4/1PNa3eEwg/hFav7bQM0+tVTWBYyfrh+z+Z2HeQYX/eb0JEFdGSzXDKdiXWbjDYR5yJg6VncJ9ExIwmJVTWEnyXDg4WAh4k7VkWAhThCPkIa+Ggj3AzHZ+zhC9lDLOyruc2Gb1Fqkl+4TPT/dcaGyZ6whOBvFw92JFald59NqUh72xMkAqVckSfh8+L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YowBoR5m0Cl0ufllpoPiYsh08NuXiehx5jx6EaG9QU=;
 b=Xk9+eDzP86NURv7cX57wsAcVRGUNFzm6bCr38weeCvbylQG7fe6VcYNw7Vi95KVpmaJn4yKlT4BnJ47vqpQnE8TK0zMHl0v1xbPtgbMoSn5qN/pLZI1poXU7VrpIko2qAuqCUZ0akUyqzJb96MDDeIUO0Alc5JGqiMSQjWFxBBAIyHfDFI9A5BTcquy9VZH1yl1Y9OIbAvTvft47ZEQUJ4piaZ/GrIFj8+8VK8YbiVgZp0Rs3xXNbjtx9ibea9ulEY3OqaT9p9X5740x8Ok2XsmdGhn4NOiyMPH3FYdh5W5AfJDyHlWtYE5WHQ8tbWJlE09C5hbbFtjIJoh8mEdV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YowBoR5m0Cl0ufllpoPiYsh08NuXiehx5jx6EaG9QU=;
 b=K7p/2x8kSa6P3gCd1ZcHpRpoGfBYFL/6BMBkxRlLiYYJHWqyTK+/qxV0Kchg5AoTEPNiZbeLxo7B7h0U+suZxjQy3uKoc+0Rx13rEvocb7hKbZXY2jjN6V7qiUrfF3eSbGbUQ5IF6xcfGgJGD+D8NDlSg0M4B/8X0S4MrzgircI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 09:55:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 09:55:41 +0000
Message-ID: <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
Date: Thu, 11 Jan 2024 09:55:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
References: <20231219051456.GB3964019@frogsfrogsfrogs>
 <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
 <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de>
 <20240111014056.GL722975@frogsfrogsfrogs> <20240111050257.GA4457@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240111050257.GA4457@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: f7178c92-a918-4b66-b69e-08dc128b78b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NXxtJhUBRc9dQAkpjUJLkM0TNi1Jzy5jxh+sIFxaRzZ+SG3RMXEiEW8m8/P2unm2uH2yV7ncDLZLQoOTKYw5ByAQXpAZlhswtCEugPwPgonmM+ciYQ1o0R7CC5OH0LjabVm5K/QPxh3bMuV6/exUYf8fEvBxEU4FKXHkvKYUO6LJ50eJOENWWSUqOt/uA1vHEfk3OkyaZ2XcGRZroDjrGV5p2x6XI0sE65b/UOa6XOp9HrY0mdFa8V7TkKzxAH4MR2R0amAID8A0U6ZPcQX3AvzHeoGD6BzrSL/auqGqbAAXuKUMVbRUU55Ju/rvXQXvsHglb0OgHLYRcTEvRV4EfyxqrXzE3UYX2hS1aeYGVH+ETXBekLFYvOXSUbAD1uY+/gmdRiNePEm9mQSc2X+YxMKcAuntJLPBAwseLNhQfQ2v9Lqip8I9g9zZFqhdy1kScLS09jLkWROUrelUBLDWC7Fvtu7D01WpLxe1dP6flNyGu+d75CGgGcZPQQnUwqRSPwLtLDuDYKQoDNedlmPiNERvN9FVzvKZdXIhwcu4iWWjR6/sdvVMcpGgt0Z6mvGc4ooU81gusQEDCvIrROVuOf8MKXUKvTfgTfR8RHWy/Uev170+gQT8TAHdKN/ZWKbpj5ktjNpmb9R762fkCNsapA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(6512007)(6506007)(53546011)(36916002)(26005)(2616005)(36756003)(38100700002)(86362001)(31696002)(83380400001)(41300700001)(478600001)(8676002)(8936002)(4326008)(5660300002)(66946007)(66476007)(66556008)(110136005)(31686004)(316002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDJmQVNjMW9sSGI0ZHZuM3FPbWpmbmxXWS9ycEtJQndLU2VrUHNGK0tEamRB?=
 =?utf-8?B?ZERyaUprQzk2OWduRzlHSW53RzJxK0ZiOUVpWjhveHhHdXdGYXNrbkJXR3FH?=
 =?utf-8?B?S3duNGlZS0FZdEI4QStHQ3RnWDN3dzcyWXlucnlvS1FkQVNvN1NXTndsUGxR?=
 =?utf-8?B?N3ZweVFybVJuOGF6ZXYzNjd2dHE4b0xybkNlVmppT3Z5YS8xMFl5NXZ4b3pp?=
 =?utf-8?B?bVNlbk12dmJBK2ZpOE5qa2pOSHN3OGkwenArTFpPMkMvZzAzWFhkN2dSQlBP?=
 =?utf-8?B?bkFrU2tseW5ISy83eURCRlZZcWhIR0l5V3h2RzhxTTNZdU84ODJSRXFVOXV6?=
 =?utf-8?B?cGp3QWx1MFBjVFR0WkE0SEZlUTI5NUZKZGpPOERzOTNrZXF5eElLQXBDTERu?=
 =?utf-8?B?UTVpQUtZK1l2STdaKy9GOEV5UHpac3ZONk9GdjlZQjM0MTl1RURqSlVJRWZl?=
 =?utf-8?B?Vk1DTVZkd1grRTRHUEU0YUtlQ0IrcVJSMVFCUGYxOUJaMUVZZ3ZFUDZETTI3?=
 =?utf-8?B?R3cyVUFacWUvQjRObGJ0NjdRa0pBRlB1THp6V0pXYmpidDhjNlY4WFoyMXdK?=
 =?utf-8?B?dzljQXhtNG5RbGFhdlJLQWZJRjlYRFdLSmdMUjV0ekpxTlRzd0pzSjRVK2pF?=
 =?utf-8?B?Qlllb2NMa2NYWmVBaU5mQzgwL1kxT1U1ZVR0Qk96V01neWpQSUhZaXN0UkZ5?=
 =?utf-8?B?L0J6VFl5VkJoV0I1Ymc1TSsxZ25xQ3RaUlE5Ynduc1NxQlVrakpzNVltS0d5?=
 =?utf-8?B?azlDV0xqSC94Y0JLK005bFhGRnJTb1NXeUk2NEMxZUFKaEVyaDZRc0FUYWpj?=
 =?utf-8?B?QmgvTFlvSTlqLzBzSS91NzQya20vWXJHQ3VJdFVsSnZBMGs4RTk4TEI4TGU5?=
 =?utf-8?B?N3RuV3QzdDVBUU1xMFpoVUFTZTNkajEvU253a2sydWtCZWJ6YWdNQmQzTG5V?=
 =?utf-8?B?ZjRDb0lERkkvbEtRMkUzaTVmSEdCMGI4a2R1TWFOWVdyWlE0TUo3V0F3OUhl?=
 =?utf-8?B?NktzWGczUW1Cd0JsSElackl6Uis5b2ZzUERVeDRBcHZCRmJENUR4RGdSbThB?=
 =?utf-8?B?enYyZXFvSG9lNjdSKzNBaUFHSkRBV3gwZ2RCR0tqOXNobTBmemdmT2tZMS9S?=
 =?utf-8?B?OWF1emdDdnFHUGJXOTY1cHFGa1Q5d2dEMG40encvWERHRnZLL3ZocksraTRB?=
 =?utf-8?B?ektxUnZMak5XcHdma2IvdlhFTnYzWjVEZlBTUUhTYjQrRnVtaVJYRnE5aFdQ?=
 =?utf-8?B?cERHU1NHU0pmL1kvbVRRa09hY0NJQWlXdHRvK0NWTDNCU2xKVjJLUUJVeEV4?=
 =?utf-8?B?K3N2YlJNTjJxT202Um9QR0Yxc3BoUnJ4N3pYRVMvS0xZMDFMMVlGUit4eXkr?=
 =?utf-8?B?NysvOVdPUFdYS2FadU9nQkxFNW1PcWpLMVhQTzRxNzV6amF0SG9OQ1pBb1gy?=
 =?utf-8?B?di9YVXplSWhyL1FORlJCZzA1Ym1uUEw0bmhKdXlEcHBvdXI5UUNBNjFuWU1E?=
 =?utf-8?B?clMrZ2ZjYVlaOUpIY1FGaFZVazZIakpQR3d3Zjl0TnAzWW03NXdmc3RmbW5U?=
 =?utf-8?B?azZhcE5XZWVzN0JwTE5PeitkUVZEN1BodHBZazBwbVEvZ3JxNHhteUtudjlE?=
 =?utf-8?B?OXBkeWcyK053dElzWkNoUTlrS1dLaCtrQTIyZ0tuam9BSys3VDVZL0tWaWlu?=
 =?utf-8?B?aXE5dDBXSmFXeXNiTzFYaXR5S2FJOEU0VVZtY1pkSDlCMmh3eGN5ak1PU2c1?=
 =?utf-8?B?cGR2T0dlYy9LN0g2U3RWSGFBREtIb2k5L2U4VDRKVVp2UmdRNWVsYmZhNk1k?=
 =?utf-8?B?aUt1bmRpTGNXYUFrNmVIZVAwaVpIcmxCMjVLaHZVaHFiUzF6bWJlZ2NkcTFs?=
 =?utf-8?B?d2hSRGYvRVdtL00rSHJ0YUYzL09nNUFDbjVRcUpqdldlUStKK091MWJ1ZjJl?=
 =?utf-8?B?Ym9TbjBZK0lnN01lWjNKZFRJS0ZIWHduTkFySk1zSnF1UGJoMGV2NGdYWDB5?=
 =?utf-8?B?Z0c4OHFDemVHQmc2R0tCNUFvNzlablpyejFTWS9QUCsvbVM5TW90N0dWT3Bs?=
 =?utf-8?B?UHJkdUZVenBVaUxnMS9vUUFKQkVMeXVuTGRBeVFmSjBFRUcrUUlRUmRjeXRu?=
 =?utf-8?B?T1VDQjZwbGZmMUdXVmdmN2FEMHNxdW1Lc2I4UC9LTG1JS0tFam5SL3F4dkRV?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Fbr+MlMuTM5ntF/XLqUEivgkSQ8aPzLLzxB5hmHiO5l8cLeTAKayOLfMmRG9Nh2rfPoYoFq+TX+vK/krPJRNhEIRzJw9/+ignQdfrqBh35bKcftIvDqlv9zI9ACf4fFJeQA30rUvN6iqgdxKRsWqyrRi6Pyvk3jDOIAoBBjYxho8UAK92sn+He+1zXq0qdVc/JECVbjpW6sGH8R2cwmUUnGNsN6zw/kwDD8ltwv0O1WB/LvAKh9Xkuu9TloC9NRAEFa/H1qdVx7WiDeZr5n+CWg+pS8d4mkr5nPrMhdw9zfEPGNVSjFwpsFxukej4FrhtPZNMW1LL4d0OA17OxHNyigXbzO8HcAhaeAz1SyfUVya2Tc4qXno59DBLW93eXyoUsGTRKqtzUa/wAoIubj+Vam5GHcBAS2HCoCEZBzzOsXBv1TtLwxj1yKaOKT84vmEAqGzEagU2mvaYPlAUeVC0wNZQbsX12ApItYK/V370zbxc90eQhUivyMqvmxfzdRiQDKySPKExFpt03ZdD/9uTS6jnjCkGcrk1qEBlJwppVzihVQI13S5OhoiWKECMIukF83QfhY0CywF5a6IsFTmc11tzUVOBXwnGTbmuXWYIjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7178c92-a918-4b66-b69e-08dc128b78b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 09:55:41.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG+meC1/UBfV3oNkMVmDQYXzGXjhJpwjJYhrpt5+xb+Y7xgQmIdcKxhsWmWXJxOSGy6OGW2MHvtaTHVvc7jD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_04,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110080
X-Proofpoint-ORIG-GUID: B_SuVf59B1vph9Vcaz_ljiE6Zf39TVJS
X-Proofpoint-GUID: B_SuVf59B1vph9Vcaz_ljiE6Zf39TVJS

On 11/01/2024 05:02, Christoph Hellwig wrote:
> On Wed, Jan 10, 2024 at 05:40:56PM -0800, Darrick J. Wong wrote:
>> struct statx statx;
>> struct fsxattr fsxattr;
>> int fd = open('/foofile', O_RDWR | O_DIRECT);

I'm assuming O_CREAT also.

>>
>> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
>>
>> fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN | FS_XFLAG_WRITE_ATOMIC;
>> fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */
>>
>> ioctl(fd, FS_IOC_SETXATTR, &fsxattr);
>>
>> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
>>
>> if (statx.stx_atomic_write_unit_max >= 16384) {
>> 	pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
>> 	printf("HAPPY DANCE\n");
>> }
> 
> I think this still needs a check if the fs needs alignment for
> atomic writes at all. i.e.
> 
> struct statx statx;
> struct fsxattr fsxattr;
> int fd = open('/foofile', O_RDWR | O_DIRECT);
> 
> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
> if (statx.stx_atomic_write_unit_max < 16384) {
> 	bailout();
> }

How could this value be >= 16384 initially? Would it be from 
pre-configured FS alignment, like XFS RT extsize? Or is this from some 
special CoW-based atomic write support? Or FS block size of 16384?

Incidentally, for consistency only setting FS_XFLAG_WRITE_ATOMIC will 
lead to FMODE_CAN_ATOMIC_WRITE being set. So until FS_XFLAG_WRITE_ATOMIC 
is set would it make sense to have statx return 0 for 
STATX_WRITE_ATOMIC. Otherwise the user may be misled to think that it is 
ok to issue an atomic write (when it isn’t).

Thanks,
John

> 
> fsxattr.fsx_xflags |= FS_XFLAG_WRITE_ATOMIC;
> if (statx.stx_atomic_write_alignment) {
> 	fsxattr.fsx_xflags |= FS_XFLAG_FORCEALIGN;
> 	fsxattr.fsx_extsize = 16384; /* only for hardware no-tears writes */
> }
> if (ioctl(fd, FS_IOC_SETXATTR, &fsxattr) < 1) {
> 	bailout();
> }
> 
> pwrite(fd, &iov, 1, 0, RWF_SYNC | RWF_ATOMIC);
> printf("HAPPY DANCE\n");
> 



