Return-Path: <linux-fsdevel+bounces-21636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D88C906ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843D91C231DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DED14374D;
	Thu, 13 Jun 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLOYgMW5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="njTYj5jK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DB142649;
	Thu, 13 Jun 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277267; cv=fail; b=jaIYYRJ4WfBb0fOo6JrLFI7ks/sq187GKzsTJHhCKiBMiqcGNRF4goiNv5uvxNs1h4R+N6bKWkdrGywumE5uN/IDPLwMDbjEL575hRuD8FqHZRGQxV01jPoex15QbSa6+a904KXKPopgvYMrB3ZqN/Oppzz5w/v8ruU/Sl0dhl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277267; c=relaxed/simple;
	bh=LhYS0p0hoKPnLrDZD/fIOIk1LUy84b9T9iytlklonts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPWy0V3weFvhm9TgNjqDJyIVurOEzEkFxmI/D2ZyHbUm8YdEiQgInXH2QCXrOC1EVq6MbnTUEf6TWQUWLObmjMB1ZHqYuxY5EwF/8foaMd1vM46jwlRfzLuMR3w8Lozw6H7MwZ/ZVteKAgId0h8E32hAMQbUhJfJp3GU53GlBUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLOYgMW5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=njTYj5jK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tQwv017478;
	Thu, 13 Jun 2024 11:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ftJiQrMllmcbn9kxivav4B6Je9boWQ1vWAeJ5Ji4tmI=; b=
	lLOYgMW5Fp6+YBtrLcoTCUSh84w5b696XBrF90aaIqEa8VSEPPSbCE4rDOmUOW96
	dxaQJ16GDkU1Me5l0Z0syCsuS4BQ6eqYcercFC0OK+g/Yk7r2DQDohhtJUJ69Cg7
	Is03yYZhbvsP/72dW1G9F5+zB/v1j9G+XnwhyEHJuqtSoHkxoXMZQPSyrFj8AQw7
	7KYrjDmcElMuG4X7C3IfIKGIwvM3UtmQeNRSwLUzbFqEuSrC8Yzc3AZqDD40rTx1
	DojlFNsSsy2N5IxMvBt/Hh/onaFLvzSJTau3DnEhiMSa2goxf2K0Mu2+TEOxwLrw
	aC01XegWUQ6CmxL2wXwMpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj9abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:13:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DA53CR020035;
	Thu, 13 Jun 2024 11:13:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9108aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSewSqzebT8ItMdzWJZtWkFIvM6T1M3ik3qDdy65/LEt1i+MAMDV2V0Fj8XaPEZlRIQV4sIRWYSfFRxeGJZ8bK+29GKxyuB5BEawhvy8YDWIDR0wMmAijkrh++eoh5QuaexYgRHK9EBemAO4cyZD2e+QNueN5h75W8IfMOch2EBVAZEVliXpvf+y+Ru2LeGzE+2lHSSTgQSA25lVetil93Civfwb1lxuBQOZmDneGTv7YW4RPWzLLL/VU1/5GayRiF3SpRNaxly8x+I5h79aktEzSLDyKc3o528OfBZCDCxIxIghGxsnHC4tEVXsk5qb5TR8dsZD2dGancqO144gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftJiQrMllmcbn9kxivav4B6Je9boWQ1vWAeJ5Ji4tmI=;
 b=nl6KnAYLNrh5f6CcQCNnSDiixJOkgzpER4EqE/AZvUqWc8leQy+xNQ0MJ6k3ppnjXTdOfNoKuQvBh6ooA9o01sYKN1KE/Yvv/z7dPpNiuCyzk8BexmhPshMJm/PdOLmeb+6tbViGMPAWxlLWSAOHImGkmLFmnryAH8xk8Qt12sd1VGGjY3ljpsbMGZfotKxQB1x4Gwz+mqAonQRBLhTFdxPvQoZUlt7JuceU3lp331Y+HMfo9ORw7Nhl+8VFbuYKR4TzdDlVYzItorqZsni4a1rml9/i4Vr7LLZFVoB2TIgd0I/o64dKTZQ7AjlFEhpOlQvWa0255jPHFNOEmWSfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftJiQrMllmcbn9kxivav4B6Je9boWQ1vWAeJ5Ji4tmI=;
 b=njTYj5jKE3Frs/JXqvFlLHGFb0BSjxcozDNUNyIgXghuAsKgzy70gdnjnBjS9evlDmUy2AJY46p3WluJTj0h/GCNEa9gGtTBlx8H5hrOWCT46KW6ylG7MSVE9RCi0DOrGPStfLUaIpRz+DqAGAOJkyK+1pEYd3THk+Xdx/0Xyfo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 11:13:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 11:13:51 +0000
Message-ID: <a7caf7f2-837d-4cfd-afd0-123a99f6fee5@oracle.com>
Date: Thu, 13 Jun 2024 12:13:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/22] xfs: Use extent size granularity for
 iomap->io_block_size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.com,
        chandan.babu@oracle.com, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        gfs2@lists.linux.dev, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-4-john.g.garry@oracle.com>
 <20240612214729.GL2764752@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240612214729.GL2764752@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0469.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dc1245-8032-4102-f242-08dc8b99e7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V09MYzJoVDhpYkVlM2ZUbTR0bEM0Q1FIRElVblgyNjcyd3VaalBLWVVKTlZh?=
 =?utf-8?B?UnBZMkpOUzVCNUh1bFJLRXNiN0NVSHhETmh4eUZseElvZ0RIcmsyWHhsQm90?=
 =?utf-8?B?NDZFeVZXTytYUEQ1THZSVkJ2VnJGUVpiZWlBQjc2YzRDY0x1cU5PTm0vdzFW?=
 =?utf-8?B?aytVa0hZc0VnQlF5QzVQYWhRMVRxSVk4aVl2TTZsdkxvVC9YNzJmc1NlM3Nl?=
 =?utf-8?B?MnVXU3dtajhaRlI5bythMjZ5OU05dWEzU25aVlJENXNCVUNxa08vaCszUklY?=
 =?utf-8?B?YUV4QmhjL0lUdzd0TldRcVpENytTdHIxdjlMY3gvdDFXa25IWGpVSktDanZ0?=
 =?utf-8?B?ODZCaEZMS3RZcHNGVVYvV3BMT0NGd1ZrZm9IWXFiT0hIc2crU3hOQVZiMnMv?=
 =?utf-8?B?Vk5VU0xaOHU4aWxhMmVHUTVXVER5L0RtL1R6bElKMmRINW55aThrN2Zha1pi?=
 =?utf-8?B?WEdwcFRvbzloK3lFTGRYa0R6U211NjZXeTAyU1NjYmRHRGJqSUhBUmQxcWlr?=
 =?utf-8?B?bE44SDNWZjVrNmIzNEdDVzIrL3VSQUIxbzFHc3BIRXU4c3luV2Q2Unl3cTRE?=
 =?utf-8?B?dm9rUVMvREJBVjRSTDRTNW1WejVpOEZGREcrbnFScFYzK3JRbmRiRHFpQXNX?=
 =?utf-8?B?dUxpWDlTbk5iaXJvUFFENVF6WW9rZ0lDeWlXdjNPWXlMZzNtaVJjbWhQTVNR?=
 =?utf-8?B?dm1JOUN4WUtEZzlCK1BlOGc0OUc3WkdhMFUwd2FKbmxxY2ZaR2dQK0FyUXp0?=
 =?utf-8?B?ejVCMXhMRGY2VFI2VW5hbWRmT2Nrc3JwK3VHVC9ibS9ISnVhNUhPeUlJUnIx?=
 =?utf-8?B?T2lWc1RlMVMySjc4OFZib3dTbHlhUksrdDJ2QzNZbm5wZWh3cTRsMFZqNlZD?=
 =?utf-8?B?ZHFraFRSZnExTlZRQkkzNmE5OXpTN08ydCt6S0wzTnozS1B1b0ZBRU5SM3gw?=
 =?utf-8?B?aTlBRlZWZlRYQlpvUU4vUGV4U1JmSTBXY3pHREh6SDdoS1lPN1hSNTA4TWZj?=
 =?utf-8?B?cEl6RzNFeFpWR0hIbUlnWFVWOTBuVmJPQ3haMFRGa2VlcmNDYklhVE1pVk4x?=
 =?utf-8?B?TERXZzdCTTlkekVHS0JlNm96VExicTdVSDdhcGlWdHlNdmxlK3VyZVFmVlM5?=
 =?utf-8?B?ZU1rcSs5N3F1UVUzMGtYS2NqOTJZaXNKam8veG13bVhxalVPemtrVTRFU3dF?=
 =?utf-8?B?QWdQb1ZyLzEvWjA0c0h2UFVnaHR3TTV5ZENjdWpWUnZOTW5vbVNuby9mdTRS?=
 =?utf-8?B?UTJMaXN2V0dOUnJyQXpuVm9lTUY3V3I2b3V0QnpMZVNST2pRdWJEMEpFVFJS?=
 =?utf-8?B?dWdFWmhBYXBXMDRYYmNYZEtiTXlBUW1JbjArNkQrbWV6TEtIL1JuanU0NFA3?=
 =?utf-8?B?TGNoRnMrN3JNY0w4OVpDcm9HdXNhQ0JUTGd4WjlDVjVDNjVUeGZXbG1hUjhT?=
 =?utf-8?B?WUs0UmdTNmczdmxQTFk0VTkzbURYemgxa1l2Y1A4TFJvblduY2htZzBLVU5w?=
 =?utf-8?B?Si9kYzVMa2RLTnRYOWUrY3pmUEpwVGVKRjdBdW5NbXQzWWwzVkxyWnNram9w?=
 =?utf-8?B?bGttQVlveHd1MUJtN2dUVERrb3FIRVBpRzArVTFiU0JzUExISVRoWjY1QmN0?=
 =?utf-8?B?MFRsOGlWYlN3bTNSUXFIcHhFV1p6OWtvTFAzMy9QVGt5amxseitBN2o1clc1?=
 =?utf-8?B?RmdtYUV6SEt2K1dqdnBzWHkrMm1UcEFYSTVnd3VLQnlmQVp2NXF6Mmhtb2ZI?=
 =?utf-8?Q?c3+R02zaXDp7uh5il000vsL6j+fgNdwI0u0aUAD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEo4ZUlHeEpKU2F4dHZ0TEFmeDFxM1gzTkRUVXZYRkVOLyt4dkxUejE2cUdk?=
 =?utf-8?B?S21wYk81WG8xb0tGTFJzTmhkTWt1R2tLdnIrSFVmQ1BjRk5UOU5TZE95bGYv?=
 =?utf-8?B?bnljWnl3ZVkzRjlBUFZqcjZlUy9OUERQZFJwSzRoMWF6TmcrWHVLeEVaeUV4?=
 =?utf-8?B?Mjh4SXJubGl5WEVrUHc4UFNXdzU1VVpITm1qZGF3OVl6cjZxWWxwYkc1S3NG?=
 =?utf-8?B?YnVTWkJOYW9FazVvbXVkU3pmUFh6ZjRkWU1nZWpMSVVaWWJlR3N5OG84REhT?=
 =?utf-8?B?b0Ewa0tKWGU2Qm9COE9mcEY4ZWowelM1Q3NRVm9CYXdFSTZZaVl3T0t3SW5t?=
 =?utf-8?B?TngvZmY0ZVRSZUF6NzRnWlRoTHFqSmV4b0lucXJ2aFN6eWNEVVdqTk1Lb0Fr?=
 =?utf-8?B?N2M2UGRWRUpvbllGSzNQWTJwRGw5ZTNCYjJCemlmRnhRR0dBYVBGTnhRQS9h?=
 =?utf-8?B?N2lLRTZyT0pBL3JmWGZaTnVOMXZ6amZPYVhWUUJCVUt5YlBuTWVEbWtxZVJ4?=
 =?utf-8?B?T2J1WWpEWE9qYUROWWlNMGFZcmVVWTFrZmt3REtaUSt1dW56bGxaVHZjWWdw?=
 =?utf-8?B?Wk81QzBZbEpYM3ZocVJBV2s1Z2ErbTZudlNQZU8wNGpFMm82NUJsKzRvQnp2?=
 =?utf-8?B?RnFpbmEyeWxjUGRGMzV4SHFzY2FkeU14cWU3MWlSL1pOc1VjNGlzQWRVQ1hC?=
 =?utf-8?B?Zk9VUmEwVmRQMDkyU3MyQ1ZkTHNiZUpKYmdRUERnOUNMYlB4ZTRRWnVicTZQ?=
 =?utf-8?B?OWt6eFB2bDZjak5VSWcxWjE3Mm5Cckd4N2pKOWZFQXFuWHE2TjRZRzF6Titi?=
 =?utf-8?B?SnFnZzNkTzhURlR3Z01QNkhMQ2xNOTdud0xvV3dGeGZ5cDFsbmZMSUtRMFhY?=
 =?utf-8?B?cXNuQi93aVcyR0x2NE1hNXArMmFObHpuUytCbU53V0d5dFY1ZTFCcEhkeTc3?=
 =?utf-8?B?N2l4cTNEVlJpS3FkMlM5ZXhld0Z4MzlvckdaU1Y1RFJPalBEU0RrcFlJcHVP?=
 =?utf-8?B?RGZOMU9XdGFMTk5CalR3WmlQbGxWNFh5ZURSTXhGRU8ycTFUdDhtWXprUTdC?=
 =?utf-8?B?eVp5eFBPaks5SVJxNWtZbmt2QVE2aFM3VjlKYm4yZzM0cElBWXh0ZlgzRElU?=
 =?utf-8?B?QVc3TEVQak42RHpKVnpOVXZ4MSs3RnJ2UkczU0Y0OGo1d2t4MDEwcWlpKzNH?=
 =?utf-8?B?THg1V2F3SXYwbXRKa3JNdnQ2NUhCQUsyN0NIK2c4MGpxM2dqd3V2dHlpTEZM?=
 =?utf-8?B?VlljU3FBTzRuWHh5bEJGQ2psQjF2TzNVTC85cFpCVEw5aDRSVU5waklHN04x?=
 =?utf-8?B?SFpZOElJUWpCdjZlUlJhUGVLbTdXS1RIeVV2VUUzY2dqcVhqN0hlU29nai85?=
 =?utf-8?B?b0hLYWk4NWNOcHN2NjNGZDRvWmVTQ1FmQ3VYUEcvdjlQODdzTUxjRkxxNHJh?=
 =?utf-8?B?eWw1SHNIL0NMZXZLMHZzUzBkbTVCQ3ExQnVjem9mb2JhM0NMdmQzb3l4eEI0?=
 =?utf-8?B?bGNvMTAxTVRFV2U4RXlISmVVYUs2bENZU21uN0dwSXdVMU1zMUd0L29HMzg3?=
 =?utf-8?B?ZFlOZk1iTC9JNWpkMXpkeGlSakEwMUNxcnkxQU4zVXVFOFVRamhsTWlPVkdD?=
 =?utf-8?B?L1lKdzhXam5PUFVFWXJvVG16ZldaYTZQcFI3VVQ2dGpwUjZEdGhZRWVTSGVD?=
 =?utf-8?B?dmtFWGJzVldwajJUMGJHdTRSaXVlRFNodUcrUDg4ZElhZnlMS1RoNDJGanlW?=
 =?utf-8?B?QmF0bklFaGRWdDlnTm1obHlIZElLSFFsaHRuNTFLRFNwY2xmSFpqQm1xVE5x?=
 =?utf-8?B?S09EVTMvRnlUL1JaZHp4V1V0MkdBWGl5cHgxbVdxVVMwZjl6Q2tTa0FFUWdR?=
 =?utf-8?B?bDRtWi9Vb1J6ODI2RXAyejFOa2IxLzFHNW5TdHh6NXVUaks1ckpaV1dySVV6?=
 =?utf-8?B?MHJrNGtpMFRDS0wyeExSb29iczEzOG52blVmaWxWeFlBU1lsUGNsaVFXSXFE?=
 =?utf-8?B?YjdZZDhENWhha2taNFovMnFuYmRjQ2FVYWw3MUw4U0dKV3JZZFNYSWMwRWRH?=
 =?utf-8?B?Yko4b0s1QlBVdGV4bEhPQ3RyaDNraGV2S0daclJEVy9FUk1EU0xvWVpNODVK?=
 =?utf-8?B?a0ZUdEVQQXFlbklsbzBuczJLUE5ML2NvRDdyN0QxaTRPZVg5YzcrK2JsM0U4?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0/qrisWI/NDarmQWFmDWQYbWDEc4RiO3Ye+NBzQYtgixAb0IBjHvgiqg20yLcjH4zq6+UhAM20RYuVvkuYqocTbfpnns04fOxERLs2VN4cZ7kZJD6rIY4vAC6L/I3cIgObtL3f5vh2+pWMgCvMredYhb6K+ZWogszOZ3U76J3/1RYy2Acnomc9RKb69UC0bwMWflxABfQMB6g1fJU6C7n7mJeGreOn/7dqJuxebJncJo4ksLAyb2g8Q9E60sgsmTgxGKencP9AxzOL4qTsERdAiSAAYQP8leE3W5Zq6NBg2J10R4W97IG3R3ClBVT4uNbjPTjW1S6X4JZQ0sFSe2RGJvCKWA/jt00DDlbGjo1vYwadEZaD26t0/hUV/2WWcPVZrdSOsBhxY58WeN3qRPymIRR4JWF3O3gxUNoh/o+FujaC0CFLB5OmTeIxpbg+J69kwEbjjQV3aYdVkKY5BZI8z0UcEhUJe454q4KBynZPTC6GS0zO/OIdbqmIG3hgEFdo0t4CUyoKsKOtEVSNji07I3dStN0pLimixMxna2a6MjM6yAiWOJmNu2nvgTT++caLBFSfUt7TPJlkBzkS3+5q3ykf9akEyb/Uj1X2suJo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dc1245-8032-4102-f242-08dc8b99e7e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:13:51.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv5/2oJbva/50Bi5HFdAYAR5ybmdn1FUIljEH3caXEj+Dx38cWoSXGh2rzanb5v2HlPm9S4U/Zkh9jZtf9st7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_03,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130081
X-Proofpoint-GUID: JyFrl4dpQG0o0TFf4LlRANQtmzxKdCbV
X-Proofpoint-ORIG-GUID: JyFrl4dpQG0o0TFf4LlRANQtmzxKdCbV

On 12/06/2024 22:47, Darrick J. Wong wrote:
> On Fri, Jun 07, 2024 at 02:39:00PM +0000, John Garry wrote:
>> Currently iomap->io_block_size is set to the i_blocksize() value for the
>> inode.
>>
>> Expand the sub-fs block size zeroing to now cover RT extents, by calling
>> setting iomap->io_block_size as xfs_inode_alloc_unitsize().
>>
>> In xfs_iomap_write_unwritten(), update the unwritten range fsb to cover
>> this extent granularity.
>>
>> In xfs_file_dio_write(), handle a write which is not aligned to extent
>> size granularity as unaligned. Since the extent size granularity need not
>> be a power-of-2, handle this also.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c  | 24 +++++++++++++++++++-----
>>   fs/xfs/xfs_inode.c | 17 +++++++++++------
>>   fs/xfs/xfs_inode.h |  1 +
>>   fs/xfs/xfs_iomap.c |  8 +++++++-
>>   4 files changed, 38 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index b240ea5241dc..24fe3c2e03da 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -601,7 +601,7 @@ xfs_file_dio_write_aligned(
>>   }
>>   
>>   /*
>> - * Handle block unaligned direct I/O writes
>> + * Handle unaligned direct IO writes.
>>    *
>>    * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
>>    * them to be done in parallel with reads and other direct I/O writes.  However,
>> @@ -630,9 +630,9 @@ xfs_file_dio_write_unaligned(
>>   	ssize_t			ret;
>>   
>>   	/*
>> -	 * Extending writes need exclusivity because of the sub-block zeroing
>> -	 * that the DIO code always does for partial tail blocks beyond EOF, so
>> -	 * don't even bother trying the fast path in this case.
>> +	 * Extending writes need exclusivity because of the sub-block/extent
>> +	 * zeroing that the DIO code always does for partial tail blocks
>> +	 * beyond EOF, so don't even bother trying the fast path in this case.
> 
> Hummm.  So let's say the fsblock size is 4k, the rt extent size is 16k,
> and you want to write bytes 8192-12287 of a file.  Currently we'd use
> xfs_file_dio_write_aligned for that, but now we'd use
> xfs_file_dio_write_unaligned?  Even though we don't need zeroing or any
> of that stuff?

Right, this is something which I mentioned in response to the previous 
patch.

I doubt whether we should only do this for atomic writes inodes, or also 
RT and forcealign-only inodes.

I got the impression from Dave in review of the previous version of this 
series that it should include RT and forcealign-only.

> 
>>   	 */
>>   	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
>>   		if (iocb->ki_flags & IOCB_NOWAIT)
>> @@ -698,11 +698,25 @@ xfs_file_dio_write(
>>   	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>>   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>>   	size_t			count = iov_iter_count(from);
>> +	bool			unaligned;
>> +	u64			unitsize;
>>   
>>   	/* direct I/O must be aligned to device logical sector size */
>>   	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>>   		return -EINVAL;
>> -	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>> +
>> +	unitsize = xfs_inode_alloc_unitsize(ip);
>> +	if (!is_power_of_2(unitsize)) {
>> +		if (isaligned_64(iocb->ki_pos, unitsize) &&
>> +		    isaligned_64(count, unitsize))
>> +			unaligned = false;
>> +		else
>> +			unaligned = true;
>> +	} else {
>> +		unaligned = (iocb->ki_pos | count) & (unitsize - 1);
>> +	}
> 
> Didn't I already write this?

It's from xfs_is_falloc_aligned(). Let's reuse that fully here. I did 
look at doing that before, though...

> 
>> +	if (unaligned)
> 
> 	if (!xfs_is_falloc_aligned(ip, iocb->ki_pos, count))
> 
>>   		return xfs_file_dio_write_unaligned(ip, iocb, from);
>>   	return xfs_file_dio_write_aligned(ip, iocb, from);
>>   }
>> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> index 58fb7a5062e1..93ad442f399b 100644
>> --- a/fs/xfs/xfs_inode.c
>> +++ b/fs/xfs/xfs_inode.c
>> @@ -4264,15 +4264,20 @@ xfs_break_layouts(
>>   	return error;
>>   }
>>   
>> -/* Returns the size of fundamental allocation unit for a file, in bytes. */
> 
> Don't delete the comment, it has useful return type information.

It wasn't deleted, it is still below.

> 
> /*
>   * Returns the size of fundamental allocation unit for a file, in
>   * fsblocks.
>   */
> 
>>   unsigned int
>> -xfs_inode_alloc_unitsize(
>> +xfs_inode_alloc_unitsize_fsb(
>>   	struct xfs_inode	*ip)
>>   {
>> -	unsigned int		blocks = 1;
>> -
>>   	if (XFS_IS_REALTIME_INODE(ip))
>> -		blocks = ip->i_mount->m_sb.sb_rextsize;
>> +		return ip->i_mount->m_sb.sb_rextsize;
>> +
>> +	return 1;
>> +}
>>   
>> -	return XFS_FSB_TO_B(ip->i_mount, blocks);
>> +/* Returns the size of fundamental allocation unit for a file, in bytes. */
>> +unsigned int
>> +xfs_inode_alloc_unitsize(
>> +	struct xfs_inode	*ip)
>> +{
>> +	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_unitsize_fsb(ip));
>>   }
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index 292b90b5f2ac..90d2fa837117 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -643,6 +643,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
>>   bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
>>   void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
>>   		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
>> +unsigned int xfs_inode_alloc_unitsize_fsb(struct xfs_inode *ip);
>>   unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
>>   
>>   struct xfs_dir_update_params {
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index ecb4cae88248..fbe69f747e30 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -127,7 +127,7 @@ xfs_bmbt_to_iomap(
>>   	}
>>   	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>>   	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
>> -	iomap->io_block_size = i_blocksize(VFS_I(ip));
>> +	iomap->io_block_size = xfs_inode_alloc_unitsize(ip);
> 
> Oh, I see.  So io_block_size causes iomap to write zeroes to the storage
> backing surrounding areas of the file range. 
Yes

> In this case, for direct
> writes to the unwritten middle 4k of an otherwise written 16k extent,
> we'll write zeroes to 0-4k and 8k-16k even though that wasn't what the
> caller asked for?

We would only do that for a newly allocated extent. We should not 
overwrite existing data.

> 
> IOWs, if you start with:
> 
> WWuW
> 
> write to the "U", then it'll write zeroes to the "W" areas?  That
> doesn't sound good...

No, that definitely should not happen.

We only would zero once when do a sub-extent granule write to an 
unallocated extent.

In iomap_dio_bio_iter(), we only zero for IOMAP_UNWRITTEN or IOMAP_F_NEW.

> 
>>   	if (mapping_flags & IOMAP_DAX)
>>   		iomap->dax_dev = target->bt_daxdev;
>>   	else
>> @@ -577,11 +577,17 @@ xfs_iomap_write_unwritten(
>>   	xfs_fsize_t	i_size;
>>   	uint		resblks;
>>   	int		error;
>> +	unsigned int	rounding;
>>   
>>   	trace_xfs_unwritten_convert(ip, offset, count);
>>   
>>   	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>   	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
>> +	rounding = xfs_inode_alloc_unitsize_fsb(ip);
>> +	if (rounding > 1) {
>> +		offset_fsb = rounddown_64(offset_fsb, rounding);
>> +		count_fsb = roundup_64(count_fsb, rounding);
>> +	}
> 
> ...and then the ioend handler is supposed to be smart enough to know
> that iomap quietly wrote to other parts of the disk.

iomap_io_complete() only knows about the non-zeroing written data. I am 
not changing that really.

> 
> Um, does this cause unwritten extent conversion for entire rtextents
> after writeback to a rtextsize > 1fsb file?

Yes.

> 
> Or am I really misunderstanding what's going on here with the io paths?

Thanks,
John

