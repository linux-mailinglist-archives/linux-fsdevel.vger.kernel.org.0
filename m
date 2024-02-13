Return-Path: <linux-fsdevel+bounces-11322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C897852AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408732848CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE16182CC;
	Tue, 13 Feb 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JDQd6eDA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmdRxlhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511A1775E;
	Tue, 13 Feb 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812140; cv=fail; b=ALM+crSTt1NRSqKbGq1jgiAaHM9g6sOmb6glgQE8egJUmkX7b7ricWHA42dp1D5k8GBAMSAgJDdMxAzD4qGVwx2opf2ArUiD4Mwna7LEqQ8jeF3rzgfI7V4v8LpcEdq5y77cZpu+tFJA1mLkohFcdo1Q6GrK14jcILm42/+Tlrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812140; c=relaxed/simple;
	bh=P7SHyVenRA2LBCoxZ2xcCVzaag65EqzesKKFatARrbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X5y3jN2nEVmh6m9eDa/m6+tXrX5GYmpYu57B1lJfRN22kbDtQommB8HNPoBpbLTS5OQ2ze+qM1GxHbmAqXVq2ASO9MAFBsYWSGfM0ABCCpMR6bNCQr8D78tD+JHyf9nZfq+K/Ma08Md4Ir9xRbdbGkr0TAdalO5lPotkZFHjdU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JDQd6eDA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmdRxlhn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D7tJxW031362;
	Tue, 13 Feb 2024 08:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Gj3Kp8F7LWNydveKcegj1azg8Du3cLBx4pdBA3a/s5k=;
 b=JDQd6eDAFbpIblU03TC9m9RlqVu+nIBlbN3+dPtax/LtUF+SPV43Qj2hXr+lT2edl1g6
 e+DQBZEbewstWwnLIa4JrREL4sbW8jXdt8AgrNuqtLGYGx5hzEmewVd5EEr6J/GRGYck
 lP+7WkBOh+/9kdbfFyp2rDczvn/x998l6xQ8Trz2h6DY4qmLgTOjJTwl7v7T8de/6plj
 3WeI9Dv/mAu1bGxrUfuvYzvrsxJ00IXoj0p6Mb1biqdCgN05/GzRO+5+VL7u79DVr+56
 3xvOXCNe58+Cmnt7/bbFvtdcOJV/d0+hwIFDvazsIiuKujD2AHkvDFUXYve6IFiB7Rmz /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w84ey01f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:15:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D6oZSH031667;
	Tue, 13 Feb 2024 08:15:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6yh5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOzxvfJc3BXBgWp1+9b0h/Lt9JqenE63DLRiIGoCegZmyJw1ZZnraxGnQu7DxnwoZcDFvJZV5M68IjneuwUYwD4zui2eUaiv4AY22AFxzUUoV3sIUihq4Ls8E6VGGHsr6LIzmucn+6KYAjIgnJlJwjLOeqAEWFzN9FM+khEo4cBbFT7ZRM8EI771F/Wq5xb1KovHFgFG8tldMO9tqKWpdt5l0DPO1DuxXs+lyXj/lOc2N8FtKFKpiIO6c/EZUlPOOwyZXt+2ZRfXAq0znGecrUZOYsd3IxJb249tyaot220pSbOJsSAjO9gXmpWAeu99r30elHjy7oYodS8ym75epQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj3Kp8F7LWNydveKcegj1azg8Du3cLBx4pdBA3a/s5k=;
 b=Oaf2B9LGwIT8oTnPogCZypwIumlJbJDOCIptTuO2tFTG2rmPbVxm6QusEG2hjPHvRfiYyKdbwo/ThGgC9YtuqZODg7H+GTOu5imqJ8CXQnN3SrIsjwRwF0dfXKDIUVigDnGYE/WL8CIrGvzGg9N+oYY/4vgKG/aIXTl+43CG5lWDMD0ml6g4HWyb2vtY0Cb1Tsh4nF0KhGlbqEjB9I/vtfRa1e15b6LYAotPj96A/WipctHCx5JrJpvEsskv87dJNx76ySl7vYsBF3ib+Ojoqq1uoaGIZeYxYfBXi53hi0DAiICrxstKgK23PFA53yu/CgL3sUQFdAt+wIFUkH74hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj3Kp8F7LWNydveKcegj1azg8Du3cLBx4pdBA3a/s5k=;
 b=zmdRxlhnZ+p4k1KWLtSwhzFPnf+4BNLz7nkKsngXLjRpyMYTi0QCbmWkHSjET5O7eIUn89SE92OyrEXrIZO85BX3wcvGl0WE9ItaB9oTdmAop9oXnFud8aFUfCNnKrC5x+s+wbNKfFjAVkzx2cQsdl4CxNuHVI621ggvlL6plJI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 08:15:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:15:14 +0000
Message-ID: <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
Date: Tue, 13 Feb 2024 08:15:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according to
 atomic_write_max_sectors
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
 <20240124113841.31824-8-john.g.garry@oracle.com>
 <20240213062620.GD23128@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213062620.GD23128@lst.de>
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
X-MS-Office365-Filtering-Correlation-Id: 0d560572-76a9-4797-871e-08dc2c6be78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dzB+FrKBN4Q/mKp90IMayQrhkd1m5bFE/KqZbEHzMC6v8alyRkRvO2esoBMuH/qIaez1oxmfAfqV928aQweUDuGWHayfKNSYTveC/DPKP2P3C6qjaTrHqHRN0ld39Kakfjaf0l+3iKGhtqi9bbOu6UtbZMoBlidYn9LQ2WJwBjALGQzaEUvKEaLBIEPtY/RsshQWPceyRBfrvrpoZ3BYx1z7dTT8uyXkl0C7lvadlZlCIXy8wOKKNaqs/H4+1DvVU3Et8bpuld5Tis7CMxNba8rdJ0FDa6ScK4+oYn7UczRfpa2SwtjShwASrYDrnfmCLgT5tbQ2gWFaYlQKlLBP9Xm7USQY9us5cfUwsfW154KnZ1RWs99EYqcUTcKXvAqO7REt2WBq2Miiv008YtoV2sWDuQoi5y0fAYce25UcMwgSqNXH/SY/EbjbRDVCvEcEqKE71WGEuwzj0pJKFN+KRFb1VbQPalW575uPqPyPmb6/6VtBUuHN5BCpCcJQGwJucd85fK+WDhQRlUkly3QFvAcH4T6V9pByVRhuilghKd+PSpgSnCa2djP46rhcf558
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(66556008)(66476007)(6916009)(316002)(66946007)(7416002)(6486002)(478600001)(2906002)(6506007)(5660300002)(4326008)(8676002)(8936002)(31696002)(2616005)(83380400001)(36916002)(26005)(53546011)(6512007)(38100700002)(6666004)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUJRNHVRdlBueWFZU1ZjM3l0all5WjZEMEcrTXc5WEZnTWhwVjRtNWV6ZXVx?=
 =?utf-8?B?eE41TFoxaThDSmt0RjhiUW9VekRJWFJQMEU0RWdYMERkeXZocDU3TzdOWXJM?=
 =?utf-8?B?NUFSNnRVTk5Obi83d0JEUWdYRjZrbCt5M0ZndWtMLzlydXVVRlREbTF4QlNF?=
 =?utf-8?B?cVdYckgzbEc5akZlakthTGt5cU5VV0N0ekdHRHRJcGl6a3VKTUZIU3lPNnlB?=
 =?utf-8?B?MC8vU0dmNFhNOEQvUkwrOEhtZmhvYkU2SFdRZW9XMWlXZVZzZUp6YnNSYTJx?=
 =?utf-8?B?S1NpVXpNL21PNGJVQTNIc0U0cXM5Z3lEMFZLOE9Cck9Sc0ljSnRCZUdXWkRw?=
 =?utf-8?B?YnNJNythTi9lUFIwbTJCVmpQSTllT3NaUUZmcmRtRUxKTThtb1pJM0tPOGo5?=
 =?utf-8?B?TjllcTcwdGFVcHJnQTJDTlZsU1QvWGlRdlc0eUhFQ2tMNVh2M29RY2k0WEZU?=
 =?utf-8?B?WStCQUJiYlprdnB6ZE9rSU16andBUnhSeWJwWUVkV1J3d25EZjRnNFNMNGJ5?=
 =?utf-8?B?Q0g1QmtLeHJOb0R5WVQvbXpBWXdjY0c3dldJL0U0OEZlaStOWnZ0QWFnZ041?=
 =?utf-8?B?bDJOTzBQL29WcXgrS29TaHQ2elFDUHR3MUJKcVBZeG90R0ZBSlFaYVF0WXdy?=
 =?utf-8?B?aHdaRTRrUXVBYWtmampjSHNWYzQ3TDMwaXRNVlBXOTVtWW9Kd3pvTlEyWUFG?=
 =?utf-8?B?SncxZWN2RE15RGRNRnJ6SFRzOE1xRVBHM3NHNWhqT3h5SjZVcHRRbDhwZkc5?=
 =?utf-8?B?aEZSSnhuU0cwSHZuTmhLRkJLamNkNEMrRERvM3NZcU1ZTEgvOUoyWkl2UVB2?=
 =?utf-8?B?R0hqK1BlWmZIcUg2SVQ5eWFRSVVPSWNuMDNxT0ZwV3l0YlZtcUxEdjE2OEZK?=
 =?utf-8?B?enVOQndSVkVKeC9YSFJUL1FZdzZNU3YzOWl5b0RZUDNzY1pBSTVlZHl1dXBH?=
 =?utf-8?B?SVVJbDFITTFUL1d0Q3NrUlE1OE5vZnpDcEtKZ0I1WHNIaWZWYlBMUmx6cUE3?=
 =?utf-8?B?TCtlSFJjd1lLOC9vY25tYzMzOVRUTW1TMjVlakhHWm42eUVCQWhpY3pGUmRE?=
 =?utf-8?B?N1ZmN1Q4WCtYSTU0T1N3b2VYcnhTTkZMRjdaWGVINzY4Q1gxMHJXcnl3d3Ey?=
 =?utf-8?B?d1JFRjI5MTBSeHdPYXNFNlpkTllhalduZ29tK3k5SC9FZVdFaVZXU0dKWWda?=
 =?utf-8?B?R3dmcW9zaHl2M3FUODBBL1RiYU9BWEJqNXBqUHlsaGZuaWdUWVNlRjFSTWdo?=
 =?utf-8?B?dm1jeEtqcml5VDMvd1JMOC9EcVRqUkRwbTRiZFZhaG1lblVGMTFwY1I4QVN2?=
 =?utf-8?B?azB5aHhjcnpMcGxRQ3dYSFY5WTZlRjEzSmtNY1NTSFB0aXQ0YUJqOVkvUjdF?=
 =?utf-8?B?VXlGVU40R0RqQzZMWXdDcUN0bzNCYm1nanI4ZHVDZFp5TllwNGkweG9vcEhB?=
 =?utf-8?B?WTNOUyszbHZFTm10K1pvdFdiTlpTc2cwL2JZNCsvWWo4cUJuL1VqSWhENGV1?=
 =?utf-8?B?ak5ITU90dzJZUGtkQjVMTVViQU1xUnp4NDQ1RHJ1Sm9Nandqd0h5ZkV1bXBF?=
 =?utf-8?B?TFdWVHZ3VnV6SkdveXFtR3BSdG9ZVkxiNXZLVW5pcm5KZ2lkS0JOVXZPWEFs?=
 =?utf-8?B?S2YxK05LTHRjSFFydEd1cFh6ajBmeXhrdWozc2dReWQ5L0w5Qy9VZElMYkln?=
 =?utf-8?B?ZUhTNVRIdllqdTFlUzM3Y29NMjIrbHBNemNjcWNlMlRWT0g0eUNBV0xCUlpx?=
 =?utf-8?B?R3Q5MkdhSjJhYzRYUHBlQzc4em9PSWNMaHV5UHoyVUJKQUprQVYwQnJtbmlr?=
 =?utf-8?B?b2x0MDc0UmNZcVFadTBsMkUraURsNEVHYi9sSGo1ZzBwUE9wcTQ4ZStUdm5a?=
 =?utf-8?B?dldPcUJCWldVNzFVZnloU09ady9CL1NuRE05ZlcyVkx0TnBnSTZUWXYwVUV3?=
 =?utf-8?B?amdZa0hIT1l3bnVzNjlDSXZRTEFBV0NlZm5mQUVIbkRkMEFIa2UwTjlWRW95?=
 =?utf-8?B?LzVOT0V1YnV3TTlIQnZsSFJ6THFnRmVuR1luTjV4TjcybjVvcDhrc2NxK2hG?=
 =?utf-8?B?ai9MNFFQY0NjMW1GU3VmM1JHTjBITGlxay9oUU9wUENQd2JDWDlENjZha1ho?=
 =?utf-8?B?K3Y5cFBhR2pjbWV4MUJwQTh4d3lxOTc0WkhVdFBZRFFlSDhacW9wOVdkL2JM?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JAPdlaXQ25unKX3CM1Go4hgULVvwEeeRo4WKFkVwvL+VtkKoMV8bsg/N9g/CaPpDkijsS2eUw+FxTgBAhUegCNTlnrmoNsH0TWx2T5R0X7NE7Ev/sPySTpYZYcVzb8ggWe+/6RP+La2x2khyFrgJd7pmWte8tWs5319gkL2ELeLwWVa6NvfC85YXogD4Xr1w5q5NHKYPy/kdwgzQUQR7IeHafye6fzIEWqv9VBrede14jUDBCCNEaB6lkXpMMpBMmieyZjE87gOLbBX0sdMDiNH/OGOKvgUZihXkX0Xf3kcPT07T277ZrwwcTH5EV1aPDk59grnqrkmcHmaEVjXd1cGC4xev0XoKl8OAg2XCBP+XLjd5KT5og8kVqSKF07Lj1+6MWqbe2bJTqSW1VmmMltK8KaV4V4MUONNYOuUqxjIAIaCyBgZ6hVew2fKuu8LeUFMs9ULY5ZM2JKMukdAAFdrEOPCLZvifdcmp1yvqjCDYJnYHTg69wm9jypXtkj3zMucd9s1+9Ys0+3ggxUeoZ496Gx1GQGIRBuix/4AhZe/Vkfa8SjCkZJUk0Wgg1upIIuuoMRLDLBqP6jAgMDidc/9XtDVrNIUL5EFXOM1qkzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d560572-76a9-4797-871e-08dc2c6be78d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:15:13.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdVAPgc/MSu9AVFWuzACQq0sn3KDOPLnhw/P3eAAfMuTigkjUFN96Oqg9aNC9YSPMH0+pZVe7II3mgkg6KUdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130063
X-Proofpoint-ORIG-GUID: wHpBI4DeqhRvOWmtRgMYqxOFqxNaOpxv
X-Proofpoint-GUID: wHpBI4DeqhRvOWmtRgMYqxOFqxNaOpxv

On 13/02/2024 06:26, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 11:38:33AM +0000, John Garry wrote:
>> Currently an IO size is limited to the request_queue limits max_sectors.
>> Limit the size for an atomic write to queue limit atomic_write_max_sectors
>> value.
> 
> Same here.  Please have one patch that actually adds useful atomic write
> support to the block layer.  That doesn't include fs stuff like
> IOCB_ATOMIC or the block file operation support, but to have a reviewable
> chunk I'd really like to see the full block-layer support for the limits,
> enforcing them, the merge prevention in a single commit with an extensive
> commit log explaining the semantics.  That allows a useful review without
> looking at the full tree, and also will help with people reading history
> in the future.

Fine, so essentially merge 1, 2, 5, 7, 8, 9

BTW, I was also going to add this function which ensures that partitions 
are properly aligned:

bool bdev_can_atomic_write(struct block_device *bdev)
{
	struct request_queue *bd_queue = bdev->bd_queue;
	struct queue_limits *limits = &bd_queue->limits;

	if(!limits->atomic_write_unit_min_sectors)
		return false;

	if (bdev_is_partition(bdev)) {
		unsigned int granularity = max(limits->atomic_write_unit_min_sectors,
limits->atomic_write_hw_boundary_sectors);
		if (bdev->bd_start_sect % granularity)
			return false;
	}
	return true;
}

I'm note sure if that would be better in the fops.c patch (or not added)

Thanks,
John

