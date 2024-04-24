Return-Path: <linux-fsdevel+bounces-17649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F628B0DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D551C229D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E1815EFDC;
	Wed, 24 Apr 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CdAicjp6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v82hPeCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2E535A8;
	Wed, 24 Apr 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971443; cv=fail; b=nE+fvRyoC8kCBcD+9uc9EYzMDt9XO5NJP3InofOazwFudlC5Xlmykqy+rXHSCXvaxp/Q3qSHpe7j5FPIlHVS6HN17zZYW7SNXL/BbEZ1wcelgA4jsRzaI6KES5vvUHNgvrhgWrFgHP0tL3dhw+YgLXckKVxhJx4KN1KsvF6itfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971443; c=relaxed/simple;
	bh=o58BsAIAmwZ7T3m5IuaE13AwSQMlooGtMQzvk65Enkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wbyxd87qUmS4CM1PkakDCaca8AiEfO65o7hjG4knK641uDULJ09Ek0dwRoi+QMy+Ff3PKJWUtat6/BMjFl1EvrvFTqCc0Tq3/wZD1YmviCEGPOVTKOGM7okHkpfSAzkfEs6DlP11NMGXz2rNbkshJyTzcpAalucrRqduqUrApWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CdAicjp6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v82hPeCw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEb2XM018864;
	Wed, 24 Apr 2024 15:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=qoPEXiOJfBw5IcZRQjwDo+IoXNtFrL73Sfi5GSqymBA=;
 b=CdAicjp6T6mnrvnidqUnf0+ygbKESSO6GXIT2me7Jr3cDGd3r+tSL3nrn+4zgx80akyg
 UFi84Ct74/ju0kVYcgXMAdfI1T/ly0fNTIIlD1s5hl1vCqryTdKrkJH3KFqzZ86s9H4g
 Q+0NbuvRvwgnaqw6SgNjToSzq4n9oPM2DZzaTg+ACVvJaNewcQIsSLI/5V8aHNo1Zj4J
 qUXp/brRVv7Fct68rt2lSpuDZUIe8VTFmDMIKfx7MhXPg8fgwufIbi7TSKb8XmmmVQUX
 xVtVM6939IbqsHrOoTWFW2x2gWOnbjfN9pQ5qfl5CkknTaiGWoQl5XbYEUF03nXEdgoC Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re0c8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:10:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODvLIT035774;
	Wed, 24 Apr 2024 15:10:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458yw7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjGmjWX2rUEidY3whBpM3mBJOqi6nkioQHqKNom2nxzRDf5EJOm3uuiEmsUARAm6ObxhSlCFr/zMiPbA1LxpVAoCvQyw1ghp5a4+lcwVP+GrPai06LvK+ZlQv45NNGnj7FVB7QO+WeJqntdB3bvW6IGda27m0UkpmHpOQNSo+5YOTJN5gwLoT01XA456XrzN0lNfhboDu5D47rsdjuWm+c3066F2nw01BPPMQnMjaiSJxotSV4HqhylPnfN9NGfv12+MRXl3DwVq5YLRWRnIvH6KVW5lGk04KQzQE+IJRReCNAMbvRcwg5AVEHmBhMWAbN5W8bfW+6+PmpiRuTELnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoPEXiOJfBw5IcZRQjwDo+IoXNtFrL73Sfi5GSqymBA=;
 b=G1HHgFjLECUvwFFCgZhZXVGjfUjtyzCe1ZKvYBN5laPgiLMsswT/lOQ11VDSr0le40rHjB+gwHst3E7uN+bN1U2fL+LA5QpgKD+KT+Iev9EfzlXRHPbNTHQ1SFMOmDXsrqIalyYu935BEBpyjaH5YmbK0NYejn9qezDP6cvErFgJTodfHgJ7tteBI4NoCXGYdT8yXmhxM6o5Uln3HxNtKcjzqUjDcjMeGwlAxu7OiKGW65AW4NGEoeutmB4yOgKtlFofkPE3fWJzjIvLqSs4XF3Sz31qOoHD4FusEgSE+TzwczP4y22On0ktqiqOAgovw5O8M42+sO+mxGHKTwtWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoPEXiOJfBw5IcZRQjwDo+IoXNtFrL73Sfi5GSqymBA=;
 b=v82hPeCwPhW4jk+uqgBDBwdedoPTaxwx4MbGDkj0HohtP/t0pwEiaMaRd3XaxlU+hwCozdqKzJI1uoJrAWmTF4gs/YPlqqcNwuY1rVf1zKRFV470k/RhZNjUq95QrarS+2Yt9ZM1ziDaaOVtkYioOEkwno1Q441sa6IOuZdrZBU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:10:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:10:17 +0000
Date: Wed, 24 Apr 2024 11:10:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, djwong@kernel.org, david@fromorbit.com,
        gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 1/2] tools: fix userspace compilation with new
 test_xarray changes
Message-ID: <zzm3kdg3va37sspgea5uzzbr6agr5qq3kurtpwudpqrjltg47l@byvboxllxfsh>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org, david@fromorbit.com, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com
References: <20240423180517.256812-1-mcgrof@kernel.org>
 <20240423180517.256812-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423180517.256812-2-mcgrof@kernel.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: f485eba3-1cc9-4834-c462-08dc6470a672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k8TzkZzqsXrdFIvGJx+k3j7FQkOB8t1QPYbzVOJP0JJlhXJ2pJm2CIozy3pt?=
 =?us-ascii?Q?TwL+M2l3/8+2Ld4yPppV++XXRLTWJQj4H2Ce6tOhMiEr+csoTRBtHiTu5scs?=
 =?us-ascii?Q?nteHrDmGVPUW90Iap0rOumPGHI2vjgvjMeUCEBxbU7erKzaitqy+Vd4Zg1W8?=
 =?us-ascii?Q?Oa/Tli2l23kI3KbAz8ANPi//Mhx1Ake4oDOyT0IrnncIIOdIhMSu8e37gGu1?=
 =?us-ascii?Q?srkaYUZws9z5MjLCFllHCLCSGZfnaWUILs12n3Nid5oTvbTKv5c94wBVhXF4?=
 =?us-ascii?Q?SHqwYhUNmpwUYj7oJSRfk7/dKSoxQG0HJlKbBuM/4wdYny0zPHP8i56ZJon+?=
 =?us-ascii?Q?4AdVVhAi+1Um/m5XrrG3TPKBqimQ9lqUGMhqwcB31wZ/8qmB4ijvIPQMt43c?=
 =?us-ascii?Q?4g7yTkW8hSbQrXFbxqztoDWEUa3jGsLBJqkQrYNHdrL5PGV0pbZRslH5elXC?=
 =?us-ascii?Q?chTCNJqy+2LzK3PIgLhZr5uDqtsudcgoLlSu2K6OoAXfYglwZKDeDuCoghEe?=
 =?us-ascii?Q?kFKRjqJNfvd928aIzASRShxRmUF1LWcNimn8qFqis/UFPG27nwhLgspPd8bf?=
 =?us-ascii?Q?beNvlcNc41vy2GJCrpBX74QkteJEcV155kKWMmR0ifmhTGAlaF8rcvWdExk3?=
 =?us-ascii?Q?uYDRqvrQqnoaAxLbvhN+2AP3Y/Yk6pNPbAPkGs4NDUZRynle2UKFqHpuKMAR?=
 =?us-ascii?Q?cWop3aTbrG+BYjfBAorcdtRGpXRW9WSOrcvBpqc9gfu1NiLouh7CPrM/ha4B?=
 =?us-ascii?Q?Om/RZZdnIZvIvZ4wGHyY1zVyWEgd09cyUMfKJ63a0njkrWYaIPLoGKa/hv9E?=
 =?us-ascii?Q?5rY5HTlAn9SjuuXxMsX0ySTkxqZN3AjfWUHRvS+R/mZJMt0WFVUhRs1u9PJJ?=
 =?us-ascii?Q?Ce7xomaA0ZEC0vJ1dr8gAsNCwnifx5KaO1T+Y8wMx6YMivxneNdLWBm6ctty?=
 =?us-ascii?Q?dnh5dlvYNP5H1mxsbytSXfLAmGuOoLMlNZLS/BTsRY6KemUZEgtmwYqjy9rI?=
 =?us-ascii?Q?3015TN4j1XZeDo6KOurFlQKzNwGxNa2sdi3CSWi9srq+jkl3a6HQuXm4GPEv?=
 =?us-ascii?Q?LtlhGaweg3S9dhkl+bfOK6qqNIzyLxLPlpdGEduT3T6wg7rN0p12JibHk6uI?=
 =?us-ascii?Q?Xl42l1qHcPrroFk8cc3qqZM+rrMTjpdvVuRNZGDl9/2WP5SalbwONAmRVx0+?=
 =?us-ascii?Q?MbCdxwYzrQ99vcKCnwU+y7cRX54WXht4ijDQa2X/7xAIbwW66OBJoaBnmAL5?=
 =?us-ascii?Q?LdKd4nfcPAdjaUCAt1rCzPer/Pc24l3idCh4LbwjqcUwfSz2HCV3CNIqNfRE?=
 =?us-ascii?Q?+3sN4MSMG3i/RtzKQUXtr84v?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qQXFnLwU+KiTBH6TM3pMYSEqoVm69LAnYsiTzPZiV0G5u32/1JlnaG7gCSAV?=
 =?us-ascii?Q?A2O5+fVOf4Mb/SKpjGmvE7tKc7IUo5fWUPqW3v85kxyVIquskNeDJmTKLez9?=
 =?us-ascii?Q?SWXvkuXroFCJoWZVIZiPjJc9u7gUwO8Ks7umsEZMhVNk6cuVLBHg5BRHdrO4?=
 =?us-ascii?Q?SF+5PSUe9Hbyhn9wTXoDGkMDf1TAiIpm9nHXa7e6eZJIQExI6qgQzFbvegdY?=
 =?us-ascii?Q?E5glJb+I0rEDrYLOpidw27arY3JGv0KouLl38UbwZOWlwnhs7DZ4Dx79a0IG?=
 =?us-ascii?Q?0+Y6cmP56sik305yQKawGyktK+gDTDBdIThuZNfLuouOgeM8abuVmHlz2u2w?=
 =?us-ascii?Q?lK6UaD11H5U0GYwfd16pghE0I3FOiQZyTq57mddzPy6l86akOU+03gCfxNso?=
 =?us-ascii?Q?WJW6BFUUeaTtcjWXZSFqYkREsg76OK1AoPce6ECelVePO6MIGG0TW5lzGTry?=
 =?us-ascii?Q?rdHfHiliSYRNaqYZ54YnSiU2i9aHwaNUi8B4sHe5eSfwfcrSnC02+qHpI3aq?=
 =?us-ascii?Q?j76bvzHmtLzGrQg0aGTnRWyPrC8LjEDbSvFsSSMXv3JTNZS0+V6U2XzZDqI1?=
 =?us-ascii?Q?W7mnMuL7ExdG/UVVBr8BcSR3+4RA+qt9r/z7iv+zo3l22cIOvPfCKSS1D2Zm?=
 =?us-ascii?Q?fc/nLpP+TWZDLe71o712ZmoABVomynNSm5cGf/ozGpO3VhgdvdWSeO/DFJgs?=
 =?us-ascii?Q?Jdy0gDIO44HLlS8tM4Fq1ntJdybY4nuRnph0LvWBFa96icOcGjcNYqyH87XL?=
 =?us-ascii?Q?88NRXFIpKG+DMQlgsumumGMooKKEoZgxPzmFCqBzunyk8o7QmJffdbByaJFo?=
 =?us-ascii?Q?dYX7QbJNQO8p/icyylbCjPWph8HaoIoNXrCNkF/yyGgKWzMAWr5NBnlaNHIY?=
 =?us-ascii?Q?i8+VvaarXeXzHUqB9mhkMN1iAcb1eihjnNxa6LsqrZB2YbVLWX3VrRwYnJNG?=
 =?us-ascii?Q?gTwl7VOtZUy1uBHRj5Ecyc3v/MxjrMhR9ttVY9UNo5Q6fDYaj1Yu/SwUJcd1?=
 =?us-ascii?Q?ccH+oBaTrj5buPF79L0mSk8XOnCDmNBX2FRNjeANIH6sTG+TmZHjs34qef/8?=
 =?us-ascii?Q?HhpeOj/+B2PHhQ+ie2sRsqEjthAsuz+S3sd+pLhoKNLqG2nKtcm1Ka6oTKwe?=
 =?us-ascii?Q?2ZWmLAEYvvXJ8cZcWsuIkncy3JZe+bDJFmRdk2FBSde/VLye+JlBAOq4CbNV?=
 =?us-ascii?Q?TasDIPB2HbhwjZ5iuIUtAtIQqJxxBwA8MPTRJmcM8Vllk0q+p/q1N/tPqXOe?=
 =?us-ascii?Q?2H/oNRaMZwj2hb4xNmkFYXwCIFcIsK8BqfyeOuvta4IWhAewQXd6IkohPwLn?=
 =?us-ascii?Q?rBkmeKaNQCxsTx2707TMUnArSMBhjgQy+XwzVg+LpANAwempoZdjT2Whv/1/?=
 =?us-ascii?Q?Ztm8K5N9tUGpKvTghPr5S6cd7EEgUHh6odpdG3szDFTeWUzPGvUC4KtKaFcd?=
 =?us-ascii?Q?xt5+A6gUDodjPqNYTR2+h0FdF7KHPsiC/9l+0d3dTF4AMCNjhkh2CdnZqyF6?=
 =?us-ascii?Q?9kd2b8GsKw1ihssrX1x1QX7w2b+i1ZJ0rjHG+0+EilBvjL/OSCwv5dkVQvdj?=
 =?us-ascii?Q?dYymVIQxfKLkuojcaVhY7C/WavK0aQnm15VqjFHANCpue/It4A5TruQpZCa5?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ih/dDwJxD7XBBwpWWdmS4WYhXDrDP4x0akXRGbEW09yMYV5r4zgRVJNOFPo7fE/7CItn744K7qw/QLTQCAlANge4zLB6gB/L214bGScwQ/PTpzrNtfVGcVQ5cKMIL5r5e8nuThg29wnCcRi49GcTWfsZUBr42+ydMCMY/sDyqI3vbYcfhhHqhj3+g9/vi98CNE7SEefeygWIoBMsIjXIf9H1lRLgnJuvsEkp6748xT0fMNwcbZLmpcvQPhJFayt66SDQlzmk4bZ/QoqicfOADZOAUafbKEbhF/23aN5yy4oYcI02X0r6r/TptZbq8Hg6OuDQwRyq75E7Tvig/zBzldsFfWk1g/D/Kx1pgl3AeeHiU5nWImHclOGMlrIC/hzxUHYcv4EHTi/HMhQb3QioT0yAjrABRURmKPbDQ8hQfGF65Y7aoJPVvvtNPMEou9RArGP4PjrbqCY4pLDCudkVGhm07gQDMaMoOXpSnODyz/rXVgOcHtEgp+5kuNfNMIf5oTo9Wm6xWTRIJTcAl34A94ROr/rgjBmSwJDot459x61obSR2X7dB2iubYVy4w9XZJs8FxWqPMOw2zeyVx36UHYyRrxfDmT4raw95vZGHnjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f485eba3-1cc9-4834-c462-08dc6470a672
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:10:17.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSvzgPyJB3cawSKRDrbqcu3ufusgj4Wr26eWLKt3s3KDo4H18FlcOtvuPDipmH9eTC+2z9DvAFBCrMMMh8U7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240058
X-Proofpoint-ORIG-GUID: tcpMruRDu2MAw09WFG9fDaKaLek9abfB
X-Proofpoint-GUID: tcpMruRDu2MAw09WFG9fDaKaLek9abfB

* Luis Chamberlain <mcgrof@kernel.org> [240423 14:05]:
> Liam reported that compiling the test_xarray on userspace was broken.
> I was not even aware that was possible but you can via and you can
> run these tests in userspace with:
> 
> make -C tools/testing/radix-tree
> ./tools/testing/radix-tree/xarray
> 
> Add the two helpers we need to fix compilation. We don't need a
> userspace schedule() so just make it do nothing.
> 
> Reported-by: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Tested-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/radix-tree/linux/kernel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
> index c5c9d05f29da..c0a2bb785b92 100644
> --- a/tools/testing/radix-tree/linux/kernel.h
> +++ b/tools/testing/radix-tree/linux/kernel.h
> @@ -18,6 +18,8 @@
>  #define pr_info printk
>  #define pr_debug printk
>  #define pr_cont printk
> +#define schedule()
> +#define PAGE_SHIFT	12
>  
>  #define __acquires(x)
>  #define __releases(x)
> -- 
> 2.43.0
> 

