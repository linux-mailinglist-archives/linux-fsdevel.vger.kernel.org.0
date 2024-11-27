Return-Path: <linux-fsdevel+bounces-35969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9319DA60D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AA7B2B9B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA47719884B;
	Wed, 27 Nov 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJr97yDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79337155389;
	Wed, 27 Nov 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703845; cv=fail; b=l2MIvCZAUD7vSX84y3l0j4DR7Nb9m4CN6wnuVOBE/nKrvs0WiyeusThzYpGY1ssZIqaYTdOpZPinxX1RfUTAY6RwuN1sTpnOaMiP/yGy7gOaiN0SFkOWKucTYQeSP6egA2fD8xtbXLqVeV4biZ5ePSY7jYLvTSupYceiHS5Egnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703845; c=relaxed/simple;
	bh=CvMygROOHKEw5eLrVIyqgJavpVjU3B/NsKY3CoD7CzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHUrp/ZHIift4lhmIFnLZrDe7fcLqVmZAJyyGQKBo8toVDFrD4+SnXBnI7OMkmxG6MI+ap3NELxJL5mu6+nkNaNVyN7g0uieehbDCQBGfhEHkhB7VdaT2N0pSeqj0fiN5zLYBq0Y7cvE61QDcLBWfvvpEcop93OMsxh1sf6Ixxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJr97yDq; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atu0cY94GLgYZhlMGDaVBLUPuzeH0f6NmyTe2ncVIJ+NyvLfmqE+rcNdD9wW0eYc9I1TK0Xw93bwolVW1BSGeFMWekBsrWvvVSUt2YsfHRo6dU/cfo55u8Bh5mOMI9dMnbztCw2YEGztWUfvOio0bSWg3YtneA8fENkwISzoB+KhTHK5EtrtED+w/Bdax/tBnLPYYSet34sGbLSfPfEwdloHrs3L7V1UNxuA/jlE9PwOenxN0eDsiQqVpGP7H0Z91StaZyu396wA5kx5soomjXrofWJc6o539ku1Xh4ky9S6Hl4RraUpwxuIDeCArLmbRQ9AQSl8S00COlW24kXHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjZN7fXNgu7eP1Rxk98TcL78zw0qaZC7VU5wY6xAwFg=;
 b=RTJbn1r0kIhm48nAJJFMKjqLi7jcdrkrmppUGBpe4xXtXUuR2P0CBKyZ6xi2WSH9iPNoeKvE7/6WmAM1Qyx7IWASI5uovT8I4hrFS8uf6ui1aXeFveBpbK7uBudjlRj+AWELEurfUVUmw5UnHg5mT2jEO+qU+7qcAKTQ1WVznJo43U7XqpawScBF1sXxHAWYTBPY7BPYokjD1rdHYxfYki68pu3Sl0zEyMg8kUAjhRopqJj60q/8MNc+dYRjAGJdKggNFB+NgaaTKSrpIJ/cTfwcMyeeMQFaAjW9NPdscSa6PrfwaztfZ5vneIiJcbb8m//kShlKuxy74fKQq9wn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjZN7fXNgu7eP1Rxk98TcL78zw0qaZC7VU5wY6xAwFg=;
 b=mJr97yDqCM7WgGoqUHq+QmtMEDxlF+CeKMh28JSShwoz6wrO2fCeNnG5aFhvzPFfbuWTwm6xp/gS4D0aLGr644z+uKtavaNxXXwb3+l74gjTdK4gJpYjjxuF9kisNbYQ/1U2gA49IeOyIp6rxDgrDe+aUgkduD8c1VTmom5LHvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 10:37:11 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 10:37:11 +0000
Message-ID: <c3b1b233-841f-482b-b269-7445d9f541c2@amd.com>
Date: Wed, 27 Nov 2024 16:07:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] block/ioctl: Add an ioctl to enable large folios
 for block buffered IO path
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com,
 willy@infradead.org, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, mjguzik@gmail.com,
 axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <20241127054737.33351-2-bharata@amd.com> <Z0a7f9T5lRPO_sEC@infradead.org>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <Z0a7f9T5lRPO_sEC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d38613e-65d3-4ea1-ef46-08dd0ecf7344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTVNSS84TnBSNUZjUStoanB3WGl3bHFTRnBBc0s5VHhZQkVxWFFPcGRlVk9a?=
 =?utf-8?B?TWhzaGFOLzVMeFFPWVNORDE5d3JwYVp5Wk5GK29QOGxsQ3ZTdEhvUzNiZzl1?=
 =?utf-8?B?S0Zlem1BeFNsQTBQZ3NNRk43a1RKeTdydnpVenRqS2l6NTJRQmpRRHFoUUtG?=
 =?utf-8?B?UWd3Mm9RWDJtZlRuSVVVMDlPQ0JxeGwzenNObnNaSVF0NGg0dXR2d1NCZHA5?=
 =?utf-8?B?b2FuZ3FPUEZob0dSdlg1cklIT0FPZG51d1lVUXZBdGVSTXFjVE9lQ1ZoQXdQ?=
 =?utf-8?B?N25CeHV2WUFhRXZpcG0wbmc2SmgzVnZuV3dwM1kzajhmTjc2c3A5akdLSDFV?=
 =?utf-8?B?cEh4anM2NEZGNDQ3c0NkS29wc3FLVS8rVjMwOUNGQ3YzQU8yaFpqQ1RsRElp?=
 =?utf-8?B?WFQ4a1cvSGIxTVN3SllNRDVBK01kUjR5VzVGU2NRMm9GM0lxNjZVOGxNWkN5?=
 =?utf-8?B?bkRmUjNIZVVPTGxGbmJsR1dBd1p2NkUvaWdrekl0cFJiRkczektGbXhTY1lt?=
 =?utf-8?B?cW5OQnZxMTdhNWJGL1ZsdDFhZHhqaVdoS2NGVGhvNmdKenQ4WXNjTSsyQmpF?=
 =?utf-8?B?cnJxNUVBTWRKRjlmMDQxanJyT0wxNW1peFlZNmN3MHhVWElHTjJkbHpxYWI2?=
 =?utf-8?B?bGJrNlcxVllaVlkvUzUvaEZGUDdKZVVtOHE2RkU5ZzhyMTRMaUdaRXJMQ0JD?=
 =?utf-8?B?dXdGSWFOQkpkeVVobHU2WHIyekxxbGwvS3VzMUV4NmZFYzhZRiticC9SNUM1?=
 =?utf-8?B?TThvbzZSQzdFV29jMkY5Q3RYcHRnYjV2em5hcTVNck9WWmlXWVN4aFdUMmNw?=
 =?utf-8?B?dkxaY1UzdDhJdUZQS3FlWmxhVUpLZ1FIdmJWUWFyK1dmTDVDK1NyeURaRkZp?=
 =?utf-8?B?Tm1MUEhIZ1UrUGJCam1NYzVBYThka3hrWUp2RHdlZ1dZWWtKVWpPTTRPZmxp?=
 =?utf-8?B?SVU5aE1EMGVnQk50TmlCLzcrUkltQUl6bDhzTWhqVS81REJ4anVweWxvMHI2?=
 =?utf-8?B?M2psNUhOc0JZY201WHR5TlBQdzZpQjlCVjMzYW5tUDk2RmxPTmJuOUl0bTRT?=
 =?utf-8?B?OVZ3QjVqMlc4UHZkWUk4TnVzQTZIczBnZFdKY3JnUG1wTnREZ1MrQ3R5SlFE?=
 =?utf-8?B?Y3ZiY3d6blB0dnJ4V1IvN1Y0TmZYTmtSRXBEOWZabm4zU3JnaGg0Z1dkYzJD?=
 =?utf-8?B?ZXFNTVRUNVcybit0d1EvNWR0Q1pua2VoWDcwZmhGb2RQZ1FHamNQYTY3YmRX?=
 =?utf-8?B?WlBISHFsZjdFZ3NKUGNtSCttWXFQdnJwSm5DZ1pjcFNpTWw0YXF3N2svdk5r?=
 =?utf-8?B?TkNWMUNPVjJXY3FQMit0aE0ydG1MNExRRy9hZlFjNWV0ZVBkS3NINmNyek1J?=
 =?utf-8?B?bTQ3UEp0VFpTajNzN2xUKzBWa3N4YTFTWEk1V2EzL2UxYUJuTVRka2sySGVS?=
 =?utf-8?B?QWFQZWNLTVNRbWVrbVJ0ZUxwMjNra0ZkdkpBTm0zclNJYkFLZEFFOXRWM1d5?=
 =?utf-8?B?cy9SWmM4ZXFJOS84cVpFaGFlWkJIZUdJY1BHakswc3V2dktyc0NaUzdnMTNG?=
 =?utf-8?B?L29MOTE1Qmd0SmlqNjVRSmt2TkJic1A1VStiODVYZ3RwYmM3RWxMNTdWSXJL?=
 =?utf-8?B?SjB4NXBSY09LM01IblZGSkRsTjE4bTc1OHVrSlUrK2RGTGxQekJ3RFY4cXBj?=
 =?utf-8?B?WWZqN1JLa1FoTzZoS1BSUzdndEVLdzkyVDBRTzhBa203S3lGSGFQbnVLR1RO?=
 =?utf-8?B?bjA4MEJWWjVFNmh3SmlhRGVyVFkrVXNnbCtGdG1yUzF5WE85TDJvU1NXa2sz?=
 =?utf-8?Q?sLnYYFN6+29rZtjQHEf6h62zPCQpuU0zEwFo4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEVPcjRLOTlldEpTN0IyeXp4Wm5MMkREZVM1aTRiYTM4QTNpRWRtRUVFSmlY?=
 =?utf-8?B?NTNCRXUzR1MxN0U4YVlvMHRKUXkvSU4xZU53TjY2RnV5aXVJU1JBTW9OYUtK?=
 =?utf-8?B?bjNOc2h2L3VIYmp4OXpuUGJGYWtkd3RGWkZhcmVtbnF3NVk1RHhBWjJyRnMv?=
 =?utf-8?B?b3IxdG1wMitRSmV0dTZseENtakJNUFYrZVd5MmQ2Sm41T0c3eGtFZ2tiZHEr?=
 =?utf-8?B?c2xsbVl0ZklQRjkvRzA2MHpLR0paaVJzaXM2TW1DYWtaRjc2Sm41b05HQW1m?=
 =?utf-8?B?YlBxcE8rUXBtbE9pVlFrSkwzejJPRG9WcjFrcWpjQnJtZm8vS2ZzVndqSVFN?=
 =?utf-8?B?cmw5ZGhVUDdMUkhweWhDa0x6R2FuN2tRMkpVMXFLbHgvUytzUk9ySlczaVNj?=
 =?utf-8?B?eVgwV01SYjlxcEtBU09ZWDRaOS8wd1B4TjJ3OThuaEw1aVpEQ09jZXJHZ0lB?=
 =?utf-8?B?R052bzBNYUszZ3dQQ0NLMWE2MksvMEVvWUc5NC9lVURSVkdMQWk0ZHZvb0xU?=
 =?utf-8?B?SUZLSDV3WjJrTitjcEN2UDhYQ3pLVnJEdzdHZ1p2ZXRrb3l6N1lxdm9mb0JS?=
 =?utf-8?B?eVBMM1haY3A1RU1CL2hYZHBKQkpvMFh2WDRoVE0vb3JMelRpUVRlS3lhT2FN?=
 =?utf-8?B?UFBCL3lkT2oyU2gvSFlrRWl4V044RW1RWFVUSEszRWZPQVk3RVRBYnM0WFRZ?=
 =?utf-8?B?cVRjaW9ldXkrUXZrdm93elp4aG9zdC9IckdhT01rV0FNZzdNSjJTcHV1NUhn?=
 =?utf-8?B?UFE1NXd0VFNqSk1BRnNaQ2crc0ZxNmxYSjJENHEwNUY3My9RYk04ellEemxi?=
 =?utf-8?B?UkZ6eUdTRTRIenlOaVpUMVR0NnNJeDU3cUNjU215SWxIbU44K1lvMjF5aUVz?=
 =?utf-8?B?RGVneG4wY05MWjJlalkyR1JaUnlWTW9KZEN3M044a3FmMWdFSENEVnNzeGx0?=
 =?utf-8?B?eTZsNTdUY0Z6a2loUGhzdW9rUXlnUVhYUFZzd2QwUE5sU3J1Qm5Ed3BIa2JC?=
 =?utf-8?B?UDNXMDJYd3plS3VPODFoYW9iYnZOb0o3dFRCNjlTOU5lT29Udmtzc3A4b0RJ?=
 =?utf-8?B?NTkvYmYySnFZdmZNUzFJdWk5Q252aGZEZGF1RzlvZE5pK0hoTDZiRk9zTm45?=
 =?utf-8?B?RzlmTjdqRHN5Y1dIQTBkaUNGZ1NYTGIzSk53MTVRWDFFTXVXbHZjMGNhdW8w?=
 =?utf-8?B?NVg0Ymx5Mm1uaUo5NWc5TG1lRmY2WlFQbHhQazZPWE03YXQ4d0VBaEd4Nk1O?=
 =?utf-8?B?QzlPYTREbGVOdHRRa2tTc0xPaEU5SE93RFR4RzhNcG5TclBJRERyVHFhNE84?=
 =?utf-8?B?em1odUF0bkVvTHdSNWRLRGM1cGh4bHljVjI0TmxTQXovS2toSkNNbEs3ZE10?=
 =?utf-8?B?NUtNbUxYVnB1Y1NhZWZ2NmhmekR0REZuOHhxSXBzZEJmeDFzQTU3bStJTDRS?=
 =?utf-8?B?cTBKNEhqV3V1SmxzU2NmdUUyeDVocGhWU3UyVHZSOUIzOTNHcjA2bWFiRGNN?=
 =?utf-8?B?MnB1NHlnWEhmbUdNakhMRWJEZFRvNkpHKzYvUHoyOEUveG54RVMwRnRmelpU?=
 =?utf-8?B?aWdmMkt4cEVZSlhkdzRGek1MZGlYNFRST1hCY1d1YjVtUzNxSGNnaXYwL3Fr?=
 =?utf-8?B?ckIybG8zeksxUys4Y0ljWm5tTXMwYmxxYktyWTVNRDJ6YUpHZEN1UTRQY2VB?=
 =?utf-8?B?bC9SZEZsNWhEampPcis5MVJiRU15a2RFVTRHcGpvSWJoOENSM0xIQi9CQ3BC?=
 =?utf-8?B?bnI4UnU5RHVONVJCOUpKbjRHU1FVNHdJaXI4d3hKemFpTmE5U2kvY3hMRE5G?=
 =?utf-8?B?MFp1bUFGMFV5Q3FldytNcWJmNkJlWDc1TlhySFBtWlUwNFpOQzFPMVRvcTI1?=
 =?utf-8?B?RnllaDM0b0ZPUDBjWk1NVW8rakVMSmVLdDMwZWYwTGF1c0YzNFRuRm9naURh?=
 =?utf-8?B?ZzZzWG1NckpDK2tNS0V2VzJGZlQyS0wwZHRDV3lQWG5tdE1RZzZFa2RhT0JP?=
 =?utf-8?B?UFVCVkljVS9UVWl3amNZUDBSOUw0QWhpMU5td0c1bnE0c0g2VVZTVzBJS3cz?=
 =?utf-8?B?NzZhNEd0VlpqN1VoUjRxeTFWZWJXL3V3M2dxUmU4dGZVZWp2eC8zUXdhNUta?=
 =?utf-8?Q?CLi13VcD0wSMz6WCXxDpGi66O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38613e-65d3-4ea1-ef46-08dd0ecf7344
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:37:11.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWHMbplqM/vlCjEiEIigzaEnDMwDA+sr2JsAgeOaliy5v2fKFQ5lkS3+//2UB5VU48Ti5fioLS6mTut5nrtNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

On 27-Nov-24 11:56 AM, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 11:17:37AM +0530, Bharata B Rao wrote:
>> In order to experiment using large folios for block devices read/write
>> operations, expose an ioctl that userspace can selectively use on the
>> raw block devices.
>>
>> For the write path, this forces iomap layer to provision large
>> folios (via iomap_file_buffered_write()).
> 
> Well, unless CONFIG_BUFFER_HEAD is disabled, the block device uses
> the buffer head based write path, which currently doesn't fully
> support large folios (although there is series out to do so on
> fsdevel right now), so I don't think this will fully work.

I believe you are referring to the patchset that enables bs > ps for 
block devices - 
https://lore.kernel.org/linux-fsdevel/20241113094727.1497722-1-mcgrof@kernel.org/

With the above patchset, block device can use buffer head based write 
path without disabling CONFIG_BUFFER_HEAD and that is a pre-requisite 
for buffered IO path in the block layer (blkdev_buffered_write()) to 
correctly/fully use large folios. Did I get that right?

> 
> But the more important problem, and the reason why we don't use
> the non-buffer_head path by default is that the block device mapping
> is reused by a lot of file systems, which are not aware of large
> folios, and will get utterly confused.  So if we want to do anything
> smart on the block device mapping, we'll have to ensure we're back
> to state compatible with these file systems before calling into
> their mount code, and stick to the old code while file systems are
> mounted.

In fact I was trying to see if it is possible to advertise large folio 
support in bdev mapping only for those block devices which don't have FS 
mounted on them. But apparently it was not so straight forward and my 
initial attempt at this resulted in FS corruption. Hence I resorted to 
the current ioctl approach as a way to showcase the problem and the 
potential benefit.

> 
> Of course the real question is:  why do you care about buffered
> I/O performance on the block device node?
> 

Various combinations of FIO options 
(direct/buffered/blocksizes/readwrite ratios etc) was part of a customer 
test/regression suite and we found this particular case of FIO with 
buffered IO on NVME block devices to have a lot of scalability issues. 
Hence checking if there are ways to mitigate those.

Thanks for your reply.

Regards,
Bharata.

