Return-Path: <linux-fsdevel+bounces-1026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E37D508D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0A91C20F9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FDA27EC0;
	Tue, 24 Oct 2023 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wvOqXB1c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rZ+qrFxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241E273D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:00:59 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F66610D3;
	Tue, 24 Oct 2023 06:00:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCJPpA003626;
	Tue, 24 Oct 2023 12:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2nrFUVAjIJDqM6i33IqHSsMD74cXNOTDqpL/IuRzyLE=;
 b=wvOqXB1czDIpELjk2LIgMOIuld/zIIk08XRdbUtjF8A7MKanzWkI9n4VV9Di4KYiFaMq
 mrhggEKRheAfGw50fmVyn4C1ygP40Q98NF6rpXlBYnbPorGO0X2/bNx6YFX9bTN2ZlIe
 oJ72r6xetPCoZlIQSE/uW1F2tWrIahk7/f6d/ENs7HO94CbFFGsVkBBx9od1a9nWCotA
 vms3+8tg7BTo3nm/M2rCT35gMibc3lL5IxtgIYLBs53Qs9moifAApedp9IWkVLOHWLSh
 x8dQHbtNZILQaHO1ao+/A1zyVOvEgUjUPRhDqA71rG1p9AtYXnPP0aa9oYpNGdEpNve2 ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dwcns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 12:59:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OBGHVJ014244;
	Tue, 24 Oct 2023 12:59:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfjg4tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 12:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCH3L4NcTuXVn3b1atEDyzefmwW0oypSLZMhd0msPhjanT0LMpKD1VsnS4FP44oaFwpXXOBc/Fsm5I77SESvJWeBfMF6ZKxtU0dSbBXxKaUc88MlWHrIelgLDLcL+iiRpN7ZPszwlJQIBpEwhXJXnYiU3vx46y5wAuRY52ocb5k617tO1tTskI/bNoOFTeDwfXBV8Fp7iTu8FGurN5byLzC19EAlANiseJqNJXNN2aeo4ZIGuvsTYeDbhbvKtC/YhJZyxYsxaGoKckUOAxN3W29rDuHG0pZfjdFoHnC9XG3lq0U7St49cqGKssYJSaEqwtjZOQt96z3Eouh5Rf1R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nrFUVAjIJDqM6i33IqHSsMD74cXNOTDqpL/IuRzyLE=;
 b=ThwCUXGbnOqyRw2j5DRdTGtyz1aX3YlkRtWPibXWuos/dclLgpuAYtEUrj/nQ+hklHgCYWMFM6fLeTwSzPJP8VeDnIjKb2bT/PDsNdkp6i5pll5I0T1/FMceDHcqLLeO+s8I4C9awEJpR5IpESwuak0JTV6w2Kb6cTyW3JnX8Qy66gUqmpLjpj+IdZbKxgHHJgRQcfjp+YQn07WgV1vRzqWQ2ZcEoSkRakje1co75W4Ofoutd+paouFcm2GLeMYxM+TGNbEg/y87t1QuXxqGLwNLsDEE+uBYjFK3eLKLoDUA3VegU/iv5udT3MsUKgUr3OQaqi6/UQYweVnOm1is9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nrFUVAjIJDqM6i33IqHSsMD74cXNOTDqpL/IuRzyLE=;
 b=rZ+qrFxL1iyfEaasJPB0WtqyQmQQgT11rbbKIrRMniBFNr2kQAKIDstrqkKdnaHi4sicVxBB8PpGxEfwo7qMWIqFos7Wkl2r+NBKmChfNRjpKT+Z1WPb4yps79c/b4H/OFtyHMscaYvmxftuKY5PlevclYl4IjIquPDAbQl3itg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 12:59:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 12:59:46 +0000
Message-ID: <b50b7972-4990-9bc7-2f5f-4475011272d5@oracle.com>
Date: Tue, 24 Oct 2023 13:59:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/21] fs: iomap: Atomic write support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, chandan.babu@oracle.com,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-17-john.g.garry@oracle.com>
 <ZRuXd/iG1kyeFQDh@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZRuXd/iG1kyeFQDh@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d5d8e9-f407-4368-2a09-08dbd4911971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xCQYOLVmGJ+dPriZJUp4QmVeaGuXp4CYYiBewmepaVF2i1qLXekEAneFzGcTFzwjR59u3p5nY8Z1KCOgUVZmKeMHbApFFYII0edORn+yB+Nh4KS5kFGbEs/bp0b5nTUlVaTVDmJFjq0fKDi5gGdWrVJv5x9Pl2ZjXct+Ce0odoQtbdN1qXYQ43iRe+4O8SHtthSoX3u7IOgFYlNm0N1Qv3kv6sLB6161EkCi3gkePb47qkhvcPMUTvTYLP29zOZlCmq4teyKtCjgaaxeqe+5u9n1hFFvBtCZhob4jIAJJtTrA6+209rikqY1a3Bv/LC/tLLyV7he6MQco62v3OivyvQZIlVEbqMNbfRrzo2036M34pIVwVxYL9s1LN2lrdBm9FxyCldsfm58X9V1DbrblDajMHxGzo7PWpX+mL25c5ZFOcRJZMjPcFwmEWfkDujSVHfyl6I40GYAPz43crSolXJopvWqyy/QWx99MnS3salfWqOPlOQpSuI1w+pYHE46oZJRksVnrYK/cTluPIrzchxjnK6RkFM/pbCJRXe+1wQcNLyvCpjupJWPOsZn7oGaPlBFRsmT0HSbmnSXIG98Epk2LUHrsDKT5r9A/mxhDcbHPQpaYCeUnnCtYCFsIVtK95iY5j+xqhTHHdaxvmfkOw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(6916009)(38100700002)(66556008)(66946007)(66476007)(316002)(6506007)(478600001)(2616005)(6666004)(53546011)(966005)(6512007)(6486002)(83380400001)(86362001)(5660300002)(31696002)(7416002)(36756003)(4326008)(8676002)(41300700001)(8936002)(36916002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1crU3M0bFpvR0RrZTMvRTBpbTZZNkpIckdqWGVaTkc3V0daRGdUUVg4K3M1?=
 =?utf-8?B?YzZrZGlXQVlENHE1S0xaTFJHekVNZktpTm9YOFlpYmQwL2NNVjNRd3VZY29J?=
 =?utf-8?B?cjUwcWt5dkhnckwzUS9vcXZIZDZHc2I3MTBrMnJmcmZ3WTFlNWdxNWdaeE4r?=
 =?utf-8?B?ckxoaWFSMGRsWS8zbUtLekVHNkJwOG9zY282UkpaM0NXeVpGRmZTaTFZRWZw?=
 =?utf-8?B?NjBJdC9nR1VXamhlKzhVV2ozNVB2YXlyL2FzSlVKNXpGcThVeC9SSUxVeDUr?=
 =?utf-8?B?KzRoaTdhUS9uTGFUNUF2dGtkRUlBRk5XY2ZlZTRNOS8rRGE0dVpFazJuLyt2?=
 =?utf-8?B?cEVUc25EZmJuUWFGZTVLRWtLZlp1NHJPQ05rdCtKWDVLeHYvRTZJZVBEUFVx?=
 =?utf-8?B?aGxndk9OWG9SWGdKVFIrNnltVjJsQ3A5cW11MzRWWGV4MzFHS2hCS3h0c1NR?=
 =?utf-8?B?dlN5NkswRTRlWVVEV1hNSWFFTTdpdmg0S2tYK1A0aDhpNW1Da1RkRElieFVY?=
 =?utf-8?B?dzVNZnl4RGk5bzh4c3Z0cUd4T1RoVjNjOEg0ZDZwdHpoV1dySmVVNEdvVjQz?=
 =?utf-8?B?MWIyV2F0MVNMUjBpNlU3WFdCVWFIekpIZVhSQVYvNDQxOTZGeVlSZHArNCt3?=
 =?utf-8?B?UXBQeHRCaEgwbVpGbHk4alNibGFOYUVJOXdTRlJZUmRNYlNXTE1jVjg4MnFo?=
 =?utf-8?B?bjY3b2diYVF5cEFGU3FhUnBSeXpzU21UWXZMNFdlZ1cweFkvRlpwVHRpSVFo?=
 =?utf-8?B?cWZmZDFPV3g5OFlxSEU5MmllTVNBblgvNUFoRzNuckNzUzF1SjFQYnlyS1Y4?=
 =?utf-8?B?Zi9XbEVIRWFwa2g3QWJvSUFvS1BCVU5sem1sUVk2Tk51Y0UwMlFaQVNYaXpW?=
 =?utf-8?B?ejdBNmJ1WTV1dFJxVUw0R3lsWGIrVExYSWtmSTY5VzdxOHBSUHNCcmVZeTRs?=
 =?utf-8?B?NHQybmQ1aWthQ0RieHNuVGpsWE9lMSt2QWJGenNKMXN4b1NaQzE5MWZkenor?=
 =?utf-8?B?R0cyVUtGY0NINTdiUzA5WkowOVQwd0R3MG9BMHgzUUdFQ3RQbUxQeG5Ua2Fv?=
 =?utf-8?B?VGxNUEVySjROZURHcEhqc0phTStnRFhWWCs4bXJnNmtlNmMxVDVOVE1uMFJL?=
 =?utf-8?B?eVpWYUdJYzBsVGxXUGRoakZoVzRscWRWTGgvekdPaW1jdDFjM2VNcCs0VTZW?=
 =?utf-8?B?Vms5Qm9EcCtnUU9FNGhjQnNmTTZ5bzJ4R2lvK1cyTk1MQ0JxRWVOL1A3K01H?=
 =?utf-8?B?L3lQdGk2NDhsK0VXQUkzR0JieExEUjBSbEJBMDFoRzEyek45bEdHUTdMN1Nt?=
 =?utf-8?B?NkkyWW14MWpzR3Njc0l4RDc4UWZ1UDdBWGhGb3A1SFVwV21CNHNpU09FbXQ1?=
 =?utf-8?B?S2YvWTVSaXo1blNXU1BkUmovVzh0czU2YXowOS9jZGZtSUpUMjIvWmFlS3N0?=
 =?utf-8?B?TXdPTFhUcUpCZ1pFT2xyeEdwd1pZYzBQejBnQTFCQWI1MlByb2FxQ2VGdk8z?=
 =?utf-8?B?UHV0Y1RDem5DNXFhZFIybk90UGsrWDZGaWpzeVgwRXpmOXJXQU1MN25DSjJW?=
 =?utf-8?B?N1pHblJFRDgzK1ltdnVXN0hqeTVJTXpDQzVZU1VZV2Zub3NjNVZqVVd3UnJI?=
 =?utf-8?B?Y2VnY1lFdGlRdFpsSGY3Vm9GdWZteitNbER1SWtkWVp2cG0rNXRrK1Z1TmdF?=
 =?utf-8?B?MXVZdjB2NGg2RE5HdGo5d3U2RWNWT3JSclRPL1I4SWVNN0ZqaGdadk1LVTF5?=
 =?utf-8?B?cHZIbUs1VXkzV3d1UThDQktjUHFaWXZhR3hWeE5TMXBTaWtNRkJ6NzBQa1pn?=
 =?utf-8?B?MDFJRVZqb1lHTldRTHJwdVVkQW5oeW9lRUNoenJaS3pQNnVkb3AxN1l3STc0?=
 =?utf-8?B?L2RCQ3BBandhcytxckRNYVREZWR0elp3TGZZY25RVFJXKzNuWjNlcHA3Rkxt?=
 =?utf-8?B?aVkwV0JsM2hGS25hN2ZOaVZLd3ZWMmV0TWlkTHlsamdNUFRZa0pDYUdUbW1H?=
 =?utf-8?B?Rk81SzRoanV5MEJUOEE4TGZQYWJXdnk0c3lkbVlnN2RzN1B3a01YZVlzQWtw?=
 =?utf-8?B?a0NLSDFrbXlWZGpPcUlmd1NFTmZLbmdFa1NsN3BHZUtZd2V4RzRobVB3Nmlh?=
 =?utf-8?B?RXdWK1BYWmNXV0lGSFdWU1E4a2JrWDBzOEZDdEpYbzVRVlR0bGw2YjAvN3Ns?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?SEg4SGpDM29JbHBSdll5TCtEVXZSWERmWVpMNlI4MkJGQmQ0Qzg5b1psVTho?=
 =?utf-8?B?MXdJbVVMaXV2eU1adXkwZjVxT0RDV2tCeEhZdnhIekFYajRJVUFzSGRkUzk0?=
 =?utf-8?B?VngvZnp6cnRscU0zS2pRcTg3TmRhbVVCUm5iTFFWT0RHQmFHTWpmZkJhejJH?=
 =?utf-8?B?RzgxczJOcFhMNHplY3dQV2N3TVVLMGJvR2t2VEhoY055YUU0Zk9IaFVSc2Fx?=
 =?utf-8?B?cm1JcFowdDNzU3N0eTl6VXV0RmZzc3ZuZUNXMnNva2VZOWorbkJuemZXaWhV?=
 =?utf-8?B?ODdiS2VTTTNaOWlFQTNoVmVCUnkrQlZHbW5EMWxNU1V0cG9Ya3VaRUMyaEp5?=
 =?utf-8?B?YVNSbVFVcUNPdXI1YW0xZ2prR0hxUlZCWlpXZCtwMG0xeVBYNmZVcXNYOU5u?=
 =?utf-8?B?RFVlQ3E0alFNUmpsellkQjAyaDIwZjhzVWhNcTcwRVBuUGUyL1dMcHFScTZT?=
 =?utf-8?B?NXlCVzJvVFFTZWEwWk5OTXJleGM5VFZZbGN1TjBDWjVtSGR2UDF5enB5Tzl4?=
 =?utf-8?B?UTNCMXhpdHJ2TWJ3b0hOcFdzUkt3NFRxNWdNdm5sTXJBQ0VGYTBVTFB1RFBN?=
 =?utf-8?B?TDdENkMzejl2N3NZU1M0MjhnUE0yMjA4UmNuOVJjdDNJa2M3ai80UUpXUmcw?=
 =?utf-8?B?T2hSS0xmV2hwK1hONUI4TENoOUFoTkd4MFJkUEZUZi9XTmQ5TmM0QVRlT0tL?=
 =?utf-8?B?aUo3bHdZTDZVYythYURtL2hneHlpajdXYUNCdG8xTW9RNkNxb1JiSVVYRGxx?=
 =?utf-8?B?SUN5QjRtNFBtMzFqRzNsU3FVTmgvVmpTTWJ3amNXSnN4OEZzVUs0NnRhNVp2?=
 =?utf-8?B?ejdpaEwzRWJobHFvelhJYXNGRUVrT3E2elZ3dU9LOGUrTnNucXNtcDdsejN4?=
 =?utf-8?B?SXY3bXhzekNMQ2lyRUxRRWoxRm9iWm9aZFV4NW12UmticjJVbHp1NXZxU1VK?=
 =?utf-8?B?QjRwZ28zRi9uY2gzMGtQNFZlWFE2OFFUaXhYd2VVVEhEVmVZU3VrekVpVEs1?=
 =?utf-8?B?ZjUrQmxVM2pyK09Gc2ZLb0QrNGp4bFRYZjJuMUNKems1N1hod2ZZQ2NDT2N1?=
 =?utf-8?B?SHVzbnQrYk9jUERTak9MajNJbys1REJjQmM3bnZHWWRWcHNlYWdHbG52WmNT?=
 =?utf-8?B?dFN1bUZvbVBCMjhOSWhyYTVQUFZYaSt0dCs1S3BwdVg3eUxSWVVBL2YzTEZT?=
 =?utf-8?B?ck5kSDB6b2kxemZIdzdpUkVzRUlxb2dEcE9zdXpORmhSL2FmSHRwWHRXKy9y?=
 =?utf-8?B?bzVuYjA2aG1UV2REMThaT29HZ21WODRuQVBHN254OVhoMnVDNytVRkM1RVMz?=
 =?utf-8?B?OWtDemFZenU0dDBvQ1BSQ2RNVnJDUGlGTUlEUDlZTW0rdGdhOG1PbUxuVGNG?=
 =?utf-8?B?dC9nZ3FJSXIrSEhaQy9ycWtldkNBYkVmRDBENEdxNFUyMGNDWjY1anF6eG9E?=
 =?utf-8?B?YklhQzNmT0pOTDJ4MHlyZXkyUEtKcGVDSmNYLzgrbUpPYXdqVUlUSE5CMzdC?=
 =?utf-8?Q?IQovb50adD7wHDv/az8p8kWQNTo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d5d8e9-f407-4368-2a09-08dbd4911971
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:59:46.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLlX1OxzaZdRExeoimQR4/L8ZJWiFvFr97QLTsSt/ytKQqjHsZzKIkJhjDHHdqyEvB7zzCL440aiQiHe5yws8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_13,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240111
X-Proofpoint-ORIG-GUID: 2WbGwI1wS6xt-XVE8a6-U0RV5DQ8uRBi
X-Proofpoint-GUID: 2WbGwI1wS6xt-XVE8a6-U0RV5DQ8uRBi

On 03/10/2023 05:24, Dave Chinner wrote:

I don't think that this was ever responded to - apologies for that.

>> 		n = bio->bi_iter.bi_size;
>> +		if (atomic_write && n != length) {
>> +			/* This bio should have covered the complete length */
>> +			ret = -EINVAL;
>> +			bio_put(bio);
>> +			goto out;
> Why? The actual bio can be any length that meets the aligned
> criteria between min and max, yes?
> So it's valid to split a
> RWF_ATOMIC write request up into multiple min unit sized bios, is it
> not?

It is not.

> I mean, that's the whole point of the min/max unit setup, isn't
> it?

atomic write unit min/max are lower and upper limits for the atomic 
write length only.

> That the max sized write only guarantees that it will tear at
> min unit boundaries, not within those min unit boundaries?

We will never split an atomic write nor create multiple bios for an 
atomic write. unit min is the minimum size supported for an atomic write 
length. It is not also a boundary size which we may split a write. An 
atomic write will only ever produce a maximum for a single IO operation. 
We do support merging of atomic writes in the block layer, but this is 
transparent to the user.

Please let me know if 
https://lore.kernel.org/linux-api/20230929093717.2972367-1-john.g.garry@oracle.com/T/#mb48328cf84b1643b651b5f1293f443e26f18fbb5 
needs to be improved to make this clear.

> If
> I've understood this correctly, then why does this "single bio for
> large atomic write" constraint need to exist?
> 
> 

Thanks,
John

