Return-Path: <linux-fsdevel+bounces-7468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D848254C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A90E1C22CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246D2D7B0;
	Fri,  5 Jan 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pl9vER+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iYR+HsGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFC2D781;
	Fri,  5 Jan 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405DoONe004605;
	Fri, 5 Jan 2024 14:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=2dOTfAijZD+wAQqRKhELVjiJvKWuuhXc5XkpXOlmSMc=;
 b=Pl9vER+On9uhtx0Xy3klEjqEY3Kf0v+0tFiiKuw6uU1XceznenUo66DlJ3VhNh+78U7u
 yUjSWVx3wKYCl4bHi8RdFRJ0BK4p/BhzyNdvgFn7mcN4+4Z76qAPDtEBAR9uahmtm65u
 wkL5m29vBX9qVVijYP8+DZmkwuyoUjLQK2SXJz6lD4iMjJbzpH744wQeaMcUTdNR4Xee
 29YVyo4ohs5dOkAnVrEgMYPtDZ97Wh+152toRicfID0YpTx6wZ6zGnKLS8dks+vUv31I
 ZDlrZyxfBwf7bCzXecHk1YgYQLcdVnFhylICGDUrQUSJMHGw+eFq+s35kaCj5oL9+HvM qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vek06r10u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 14:02:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405CPYEq009306;
	Fri, 5 Jan 2024 14:02:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve12hqjma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 14:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhUPO+uTmIkCEXA7aQfCBluY5j7HB85ryiYf+BMPM4yDB5NseI4e4MrrNJG0U7/Dtrfz4aC/XBBLysQ7f9B9ZDYdNjzmpAANvNTMoPag0Tby4vDG5BnTGAqZ1ySHtLyhS1nJEn6jJSEB6aAxLYPX3mfUo2mn7R+lV6+bmz+J7yo5GtC9kmJwBnAnXRLVgEMg8Tkh8+9bEtVpX9EQjEXUOBtKfpNmgBu25l2ymhnnWBZ6RRIm4K/QJ1sROT6idwSFDPxuISQpO2dpyhXo61KA4Y5yYVJw/+bQe2K3EuMCrBaLY3inlzTbyCFpoYGB9DguOyypMR2Qn+Zp2spXiaJ/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dOTfAijZD+wAQqRKhELVjiJvKWuuhXc5XkpXOlmSMc=;
 b=FDxYW8xr9eFSYiUG0nPwWKYfQoi8IRZapHAqG41MPbo7xTSRlavluTT7r8PlCcQ0B0zK6v20KVUR4uhPpYFpAkhhRpz0KlHEw3S7OGio/7UXJlAAL5vRbJ3XiSrH0NERk0irhrZNGWcDdO8mtjhkGoSznXguh1awXYtwp59FDgNeXD1pzfUWNwQuLZJulFO0brTtFq3zNkZfHvhhtCwXbR1oBI6JFMPAFesLCsIiTKBxshYg/RmoDzBV2GAbSdP+UWGUZf0GH9DcyAF+USNpaM4p27R6VmeLQoE8BDG1OBPD7OXOix+3JxN+BvQDm4fANzVoT8iZyy72kGyVFdiNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dOTfAijZD+wAQqRKhELVjiJvKWuuhXc5XkpXOlmSMc=;
 b=iYR+HsGb2ECNXQV8e25luNW/Swrbtk3Rix6qPH0kKK5YFHr156zbCHmYINePrVLFYZAyl51h8QanQ5y5LRHjY4fT5CwslPtvxv4+ZRYOHjIfYF2w1NeiqkiGQr+4+tHYQ8bA3X+omgTXqAZbgoB3UAnqdbqr3R0a5CDi0xz5UJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6407.namprd10.prod.outlook.com (2603:10b6:806:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:02:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:02:55 +0000
Date: Fri, 5 Jan 2024 09:02:51 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk, jlayton@redhat.com,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, trondmy@hammerspace.com, brauner@kernel.org
Subject: Re: [PATCH v4 2/2] fs: Create a generic is_dot_dotdot() utility
Message-ID: <ZZgMC2Zl19w1NnU7@tissot.1015granger.net>
References: <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
 <170440173389.204613.14502976575665083984.stgit@bazille.1015granger.net>
 <CAOQ4uxhCQ2UrMJZCCTdn5=HtEDPV=ibP4XvGgbwVroepFbLk4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhCQ2UrMJZCCTdn5=HtEDPV=ibP4XvGgbwVroepFbLk4g@mail.gmail.com>
X-ClientProxiedBy: CH2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:59::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a9927a-77f4-4e1b-f7e1-08dc0df703c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sKazPRe7y/Et9O3ftF3NTr0iQNH/r1G+dNgt+/VTfjeSh63Tq/etLJJx8CR/8BRll5R9MQ3EWgFCVlhA2V+lTlUUy5HZwl0iBggVtfwXZ7f2QRP7udICtpza8nHJsBp/pYQrLYPPn2y77eZJnXkL91hNAt657+e2KbudtuoOFREYVPabXixFP2zzR3hngG8K8hKQB5ihTpgAf6G9/v9bS2cAgvfybIiHYovN6o7YOmGBKRUDHKYNTvznap6oQuDd8LQ3N+pcvHfn2tcDYGulHxP/SxvsWHwhDJAVU4zsUdgi3L7y5DmJmIyqLcKaGMiZDAYo1OBlAg2N1l3SEr91iW9uxNv2Thfa9zQCz/GGd63r3Hm7VNRjhGsGi6gKc97fz/qBnMRwWDHAtaFFa5vt20i6B3gYp3Wzr0ih8V7XXVpVT9M00jEbAow52O8cu2plRbsqLHxquOxZIQ/zhpWUUkMWKCuPbW+sZXdUp1Px0O5BfbWxiilX2KrqSkggkTZA0BSO0e6ueLDMHodWxYdgCHTorDl1AkY9HW4klIyTWAdU5aMZrcdniZm6IZ/4LChArKO+pAYl2vz0JlRsAmsh9vxDj3hb7B1yoUkQ+rjKm+E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(9686003)(53546011)(38100700002)(26005)(316002)(5660300002)(44832011)(8936002)(8676002)(4326008)(2906002)(66556008)(6666004)(6486002)(6506007)(54906003)(6916009)(66476007)(478600001)(41300700001)(66946007)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzBMTTV0Y1dWK1JLZW15cWVhbHJZdTZQd2psMmRtQXR3NnFPdGNGd2xXNnVs?=
 =?utf-8?B?WDEwVGFLYThCcEh5U3IxNFluOFY0SmV0enZTc2I0Vm05WXgvSWxtRm40MVJn?=
 =?utf-8?B?RlZsdkF4SVNPY3BHK254VmFpL0NpbG1SbHhTTXYxUEM1Wll1UEwyVHRCZE5E?=
 =?utf-8?B?bXVMRnFnTFpCM256N1h4Nkh3cVNXdFU4dUo5ZWxEOGZiYmREMk5yU2J5bnor?=
 =?utf-8?B?R3c2bWJSRmFnT3JqdEdoYURXUE9QNVluQ3dJR3JxYkNRR2Z1ZHlsTmdhOExB?=
 =?utf-8?B?T2gxeXU0T2krcVI3bnVFR3kxb0ZyUTZ1OXJSZ2NlQkhtS1Z1b2Z5SFk0Ulo2?=
 =?utf-8?B?dFhMUWdpbHBXSGxZYkV2YWIvRDBaTnB6aW9kd2J6YXQzalp3UHVLWHJWUVNh?=
 =?utf-8?B?b283OTZmNEgrQUZHa05UbmZKVlNLT2xIZlNSTklUMGk0SnVLN24vaVRxbXBC?=
 =?utf-8?B?aVJ6T0xCc09GdktPYk94dldjOEdSS2FOc2s1OVZaT1gxYmh4Z1BmRnVibFNJ?=
 =?utf-8?B?QlVxdlVUaEQwTyt2eXJrUGxvTWhxdVhSM0RYZHE2RlRUUUVCd0M4ZDFzcGpH?=
 =?utf-8?B?T2pQaUIxV2VucVhFcmFHdDliOUZQU2xlL1NBaUxLbHdMVzRUZnEzUHJJZ0Ix?=
 =?utf-8?B?cjBGN1dKV2crTzhCR213aFBrWGkzcFcvaVdEWVpFZU1wZGRGd3NGUjhLUmxk?=
 =?utf-8?B?Y1dWOWhpOTEvN3lGdy9MYXJFRWw4a2J2ak41N0RMQXgrb00wZ3Z0bG0wcFBS?=
 =?utf-8?B?K2xHdGJZYmxHQW9oVkMzbnZaUXR4QjdVVENlYktPczhFRkhDSTJ3K3lLWjN1?=
 =?utf-8?B?L0Q0YWVaVjZuY20rUHZxSHhVSzgvZUJVYkdiOEl5SnBhbW9LcWpWYWtuYi9Z?=
 =?utf-8?B?amlIalN2bXFhVnkxeWdnUkJIYVhYL2FQVThHdUFKTXJpNk9QVkdML0s4eWdB?=
 =?utf-8?B?cUJUNlF4NURRR1Q3ek54clB6d04xUC94cUF1YjRUMjgydGxlblNSaGVlNDNJ?=
 =?utf-8?B?UkVzVXkvL29zWmJud2dENUZoR09ZMG1lSGorTTV5a2ZTY3hZSVZKbXBSZE9k?=
 =?utf-8?B?Qk9DK25ZYlg2cC9PeXlaZGdTL0lkWTlTMG0rZlp2U0ZoQ2o2SUdKNnVqY2d2?=
 =?utf-8?B?T285MDkwV3REYXVqOCs5UlRBWnBjVms1S0hQenlkd21vNEhmcllWUm1XcVpt?=
 =?utf-8?B?YXRNRUdEcy9sUXV2VUEwaXZrVC8ydHFXakprUFdtbmNuOXIxbkdnbE5hd1dX?=
 =?utf-8?B?L2JIZTBvWGtkOHVSMm9NTGEzK29ab1VBSHk4RkErdy9vTkx0Z1pzRVc4dFJ4?=
 =?utf-8?B?Z0RZbG5pa2lKRDRMYklsRG45OGhIeS9sVkdnS2RDbXFNUTNwUStwYWhrRHpn?=
 =?utf-8?B?NGx4RE1ER2x0U3NuSkZaM2xHM3RoSmsrTDdIOTlwNWRwWjNRZkszRUR0SkdB?=
 =?utf-8?B?Q01uLzF3TUJrRUJqc095TUtDaWN5WGhBcFlHNEVWa3BmUVdrOUpTVWdwUXBH?=
 =?utf-8?B?emZsdktCYUxRRXNDOGRGT0Jyb3prTEp4K1hJQTFpRlFoWnFwT0RlbTRtQysy?=
 =?utf-8?B?LzJkaDNpSWs5NmRhTEczWjRLNUUxdG0yTFdqVWRSQjIzMVBESytza0NNLzJi?=
 =?utf-8?B?K01Jczd1NUJJQTNzMzBNWEFCK2sxMUhoTzlvd3V1N2srTHBBTXJCbzluZ3pX?=
 =?utf-8?B?UngvK0tYR1lZVUxzTGxvc01HdWs3ejNNaTNCTWIzRlZ1Ung5bE0xSTAyWDM4?=
 =?utf-8?B?OGNDZFJOZVZINmVrU3Q3WW53Mk55N0VvYVdIT2t6VGhpd2ZHY0t0cU1nbVZB?=
 =?utf-8?B?aXBzbFByc0dYVVFjeEU2S2RxdWdmZlRpWVF0QUt1cHNvTFQ4MVV0Qy8ya2lK?=
 =?utf-8?B?bGhpczVzL1FFSytrV0FDbEhzci9QT2NqNnFod1RqWE1KMTNyc2szODdlMnFl?=
 =?utf-8?B?bFZWQ3hjRXZZS1BnN1IzVWFpS0hvSEhZN0ZYK0xCdEt5TVBteFJQaVU2enJ1?=
 =?utf-8?B?Tzk1R0tNbFJTMVA0Mk9xcHVMZlRRV1FvQ09RMDVuZDh6dGJjRGRhdTRGSkNs?=
 =?utf-8?B?UGVMbmNQWlFwdm5kNG9GcUFGUnBsWDFzcFFpOUZYN2lmWUh1WUNVb05ST0Np?=
 =?utf-8?B?cll6UUF1bmI5K0lEcHkyQ0RZZWJJLzNIMUZoalVHbU83SjlMbEIzMHBXdmMx?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xiBq0lExkdybInaS1znjfTIYuPKyXZe1/bYY0OuEGnDeVkidinRsrk6FKTByGyHk6a+tAwVJHnFLFbt9Nim5nNSvOWPmnekdQ1FQ4uE1pUskBXPX6o/aonMrb2hnRrvoqLyG+n+jm2nfADBhHWafkFop2vgKAuuvn7MhgNIrdBoDSmrZhHGHPpC8dDeZV9DP2ILYrrM8oM0z3dIxBAIsn/a0zpoceiBq4zQKEaitZdwQ3umd8AjbCtAS4fHUiBr5+YAB4kls1JFPrj8bBYmmpkkr2F+nGsvCgGExvwww02MhePgl6aAkfIIjGUpOkk6a3O+zRNNDtGvpJuWshVt5mhT6bH0KfwBkgltzpyJrz28Jy32Nhm3AJlIL17cilWdUUIWNspcGRukXHHJGkMrtmGgRGSWGUMWOf460tNeIdKmaTJLStcbhNdjGBAzpgWbnW/V5qY2Z7ZLA2i+E7tpJjKK5vJ/Wbal3FE5FZ8wPY7dlZZtQtcYZMA6iY56EE5OjS19NHN+MWxjbM+rIo9Jf6rc3JKVk+wul3sqeO5XrJLUIpr1nzXZxgjn1NM0TyBbM5PFD8JK83G0NtNLyGs8tOUAQ45CaBXO95rslzQ2CS7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9927a-77f4-4e1b-f7e1-08dc0df703c8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:02:55.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F115kfrSo6Sw9BOYyNCKgx3lYdoQl0tKWW50zMJTKSGBIxuNJZdKwqalY6WOaR52m0yETUkVZQVFpiV9jOlwZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_06,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=886 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050119
X-Proofpoint-GUID: av3qByWNJGslv7LOIvqrQiUxMnkpuEUD
X-Proofpoint-ORIG-GUID: av3qByWNJGslv7LOIvqrQiUxMnkpuEUD

On Fri, Jan 05, 2024 at 09:36:51AM +0200, Amir Goldstein wrote:
> On Thu, Jan 4, 2024 at 10:55 PM Chuck Lever <cel@kernel.org> wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..53dd58a907e0 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2846,6 +2846,19 @@ extern bool path_is_under(const struct path *, const struct path *);
> >
> >  extern char *file_path(struct file *, char *, int);
> >
> > +/**
> > + * is_dot_dotdot - returns true only if @name is "." or ".."
> > + * @name: file name to check
> > + * @len: length of file name, in bytes
> > + *
> > + * Coded for efficiency.
> > + */
> > +static inline bool is_dot_dotdot(const char *name, size_t len)
> > +{
> > +       return len && unlikely(name[0] == '.') &&
> > +               (len < 2 || (len == 2 && name[1] == '.'));
> > +}
> > +
> 
> Looking back at the version that I suggested, (len < 2
> here is silly and should be (len == 1 || ...

Yeah, probably. I'm trying to stick to copying code without changing
it at the same time; that's the usual guideline.


> But let's wait for inputs from other developers on this helper,
> especially Al.

Fair, will do.


-- 
Chuck Lever

