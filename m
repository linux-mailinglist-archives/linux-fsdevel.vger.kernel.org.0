Return-Path: <linux-fsdevel+bounces-42121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06174A3CA10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 21:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C702C3BA1BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4B23C8D6;
	Wed, 19 Feb 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1HcE8Kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DB22CBF3;
	Wed, 19 Feb 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997367; cv=fail; b=p0IwXa0K9hPuMFegrCdvtmg78rUBIDDGdeGraYtxpUmwtLHLaTN6FxBZU2aZy9739OPpg1us81XnBLOOeIxFvYUDEnR4Fo6gh0O4ceuZtY6/oEaHJ+y+4svYnUavx+0ARNo4EP88gp4kAmeq3lSTJ8IcZZgKV3Nx6qqdLkcXsH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997367; c=relaxed/simple;
	bh=kcpXWfYjY0q/IqiLSQHptqtMEDAaj3WD0GKARjH5TOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YA1vJiWmNUBQCVg6JguWYct6zBC2Cg7wHLOSKygl1aSMUHKD+tWvZNCTOJ7dOkFFaWXfAV7MESIE+MAIhLpUeJpAbyiB/+EBkV1PU9AEzbKt2G8g4RV6hRp+juWOFusLrlmcrP9xyXULlB/H+8Qsq1FdMthVMeBBQDj8xGRP2ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1HcE8Kr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739997366; x=1771533366;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kcpXWfYjY0q/IqiLSQHptqtMEDAaj3WD0GKARjH5TOU=;
  b=M1HcE8KrzgJHf5s1BI+cc4m/2L/sTC3VVor130+lC+CMITfCcicLnjqR
   SLG6lEpaxpSt6wlBmcoAq1zgkRjgJGJU1OXJmsAYASDgDgAdCtfw5OJuJ
   JrqrW89R95V03qe6pB+f1qOC+6szhXeIhymzoMMW7QQYA2In+cA18N37y
   gHJkElMZ+FZgMxQCbodDziRWVe98OTxPym/RKQ6GhTBbGnTObcdUMxnEd
   +wl4E0lsfIhDfHh9RYEBVTmVowkNs+t8bLRlUUGG43tLPjk0L8u1vADga
   ZrIgHbAnPKeqrVMCb+ETbKISH6Tv9fPJ5uGmbuagjVP7JlGqPJ6Bx+6yJ
   w==;
X-CSE-ConnectionGUID: EZN/8X66QwKMvqno6zQFOQ==
X-CSE-MsgGUID: 4j10CexXRlikc2/AaQGBFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40875178"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40875178"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:36:05 -0800
X-CSE-ConnectionGUID: T4yWiLPaQ1+pmn6zh4suMg==
X-CSE-MsgGUID: tOz/xLN+QSCHrArKF5AwZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119809473"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 12:36:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 12:36:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 12:36:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 12:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3amWRbTUOISq+5dbXvu9lMYdIUN3IsnY9FH2hZ+C+iZnAqItfpliYmKopXqvIvy595Whv3zqMDXvQnax13rDbm4rwudydWgQwTs/G6ys8oToEWjVYSbjQppo/UjXt+YtSldVRnH2/v4A8TObC6VrVi6iJ5SJKe6oGfOAZbu3DDWPOvmTV0MxtYu3XUzawhnJDLD8ViRdSheGwf9X8tFz+zHtVzaxDIk1BS/SSQQ6f5BoKgE1CDXQUP+h0AR+Ol6ncJGYPV/euEpc4g/EkTrKtJpJ+e/5Mtku5M2mmKbgS2m/OBwSh/jVH+OZMzMzx0ND3OpbvHQf/EOKVKcIM+POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU/E1iA6T/rO5sGiUpYSnolgh5nVeqwMqQkh1frMLuo=;
 b=KTlJIZG3Ig6r3sAFeph2Uzmh6ZV8P7TCq5SA4DcLd3Ni04eFRSewEGGqBb/sbbJ6bwIb/rsyV8a6e1ZCByIt+QiDznpnFj1yJG9WygJD8kXDkvFn1xRBP4y2sgQWNrpjaf6ZvQa8ML2QURenD9l7KRAp5oeO1uNLEt7xVnuT5QaIVYby2gcjj3O2vq4f2UviLuugdbiSxeJbFo1jZgtNTfYKHJyYNL3zFKrLMu9bFDGFWu+QFSYVt+FkOQZd+FRUEEsl8ivYcXcJOv4AGSKQiKBvqw7uuKQ4/yivTtB4Dv1xwj68oJmZCBIKUpqOdiie0cqmGwdaw+OP/8xn2orwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 20:36:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 20:36:02 +0000
Date: Wed, 19 Feb 2025 14:35:59 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, <akpm@linux-foundation.org>,
	<linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <vqeq3ioklrgrf227zgdfho4virh74qrt5reoyptmzgktyronbr@c2mw32pqikft>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 257c8594-ab90-443e-e79f-08dd51250648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXpFYTNTWGFuRmt4bk1aMkRSY1lwU1dKdS9Eem5WRGRuUFlrOE9DQzVhcHo4?=
 =?utf-8?B?TUZYbzdQNytIZzIzQXM4UTIxenNxa09nZll0MkJQN250ZnhmWnpxbmp5TnFJ?=
 =?utf-8?B?ajFoQk95SUh4L2hzbjM3dWIwR2xxZHJxMEw3SUFkT0tiNytJOFZ2VFZ6bXVW?=
 =?utf-8?B?aWlaa1BHY1JaK3oxb3lzZW41RmNzdXpoZFpzVE4yamlwalFYUFl6Wms4c0p6?=
 =?utf-8?B?ODNkeDNrSGJzNFB2RHNEN0VxZmI0ZTFGM1BGelNpQTd1L21kWjZ3c3BFZ2c0?=
 =?utf-8?B?NnV1NTNlenVoZVYzVmRZdWRPQmJpcEdRd0RObUZvWFcyenhzaWROLzRNUjhU?=
 =?utf-8?B?ZmtoaDB1WVZ2MFk4dE51RGtIdW1CT0s3WC9LSkpidExhNDZrQ3ErcmRRNmZE?=
 =?utf-8?B?dnVDUlFqdjBPbjk1TlZZbkJOdXZLQXc0T0N0OFdsUldsVVViVW9wdXZ0RGda?=
 =?utf-8?B?cFB1VytYbWlLVHJkQktuRHpBenVJaVdHT3hEOG5LbXYwUlBBSkhCTGMzU1Ew?=
 =?utf-8?B?UnRIZE9wN0xXR1owTEh2RGFBVDhPbkpKZDBFcVZXN3dTck91NTJhSWw0SUVO?=
 =?utf-8?B?TUNuZ28rSVJGTFhNa2JjME1ETDJmamtxVkJBYVhJNWhxcHFSQitCaDFSL0NZ?=
 =?utf-8?B?OU1JbEErb2U1QkFZTWRPSzRjZ0RUdks1eXY1TDE4dkYwNW8rYm1TOUt3N1Va?=
 =?utf-8?B?cVV3RVREQnFFbm1EWGtSTURXSzFSbG9KbnRYUlBhUDZvSTFhUTlpVjBYZEdi?=
 =?utf-8?B?emlPdGtaMHVxMTVLaDU1ZEh5WVlCYjZJQ3doZWc3YmhUVk8vZUlvQVQ0WnhD?=
 =?utf-8?B?cVhMS2VGTmVyWUp0T2trektTZ0VMQzF5SmI2OWZXOVJEY09DblQ4RWhrbWNy?=
 =?utf-8?B?eHZtK0pPcGNvSzVLb3h1ZzIyRmVCUEd4cGk2R0RZK0VKMmRQemtidHJYbThV?=
 =?utf-8?B?SDV4TGN1LzdtOERCRW1FNnd5UXRoQmxCOWhmWUNWNVdZNTlheFRHTnpCa09X?=
 =?utf-8?B?UEFFeGtENkxtSXE4cEg4Q1NoWDZTa01ZajU3NkZYSVoyRXhrNlpwM1ZMcUda?=
 =?utf-8?B?QWhWdkxCVTNjRC9WV0lPYklYc3NHTW9RMkNCYmRLRVNjVzFtQ3VOcWVwSUx4?=
 =?utf-8?B?bGIrdU9NdGtPTUczY0k1SXo4U3AydGJ6dTJwVWwrc0lDTk8xdUF2c0dnY0Zw?=
 =?utf-8?B?M0FKQ2xObjBSNE44S0RONzNwY2xwUVFOZnVHRVpwMkZZaUdwS2FQVDMxKzdX?=
 =?utf-8?B?NG9wdmUzU2s4bGw2eFQ2WWh2RGJqNVlVYU9DUHNMajluRGxRV01UQ2lSSHho?=
 =?utf-8?B?eVkzclR2OVFUdW5VL25QUzhNckNpUWNBYjZnazcvZEpwQ3VnOTYycnpPckp4?=
 =?utf-8?B?Q0pmOHBOa1NUNFR6Y2UyUDFzMzhZZ2ZEMHF3WTlMWU50My9MSkdhcHQ0bm8r?=
 =?utf-8?B?OVArcHVSU25KVFBBSzBISmpoUW0rZTIvbmhLZ0w0VEFVeDVnQTAwWGpCenY0?=
 =?utf-8?B?NU1oNFZ1QzBldll2V3pyNG5TMmYrV2QwcEM3NXlPRnQzL3J0QzFiUXBiTk8x?=
 =?utf-8?B?OHNjSWFManZKMWpNdHNDanRhckRLNzh0eU04alpLT29JVXVES25ST1I2RDEy?=
 =?utf-8?B?M3BqV3I2dzBoOGMzeU1Dd2FqbVArTVFVMllJWmw3SHlXTmJpenVQUVdQMGRz?=
 =?utf-8?B?VnBpYlpMbkZJQ3Zxa1BwaXhscU5RK3FkUXhwdlNaQ3lKRXVCTkdPMXJCY2F6?=
 =?utf-8?B?ZEZ3ZWg1QmFWQVRCQnh1WlBWcTdmT0lnSEQ0NzZaTVE2aWE5WjY0ZlBUbVl0?=
 =?utf-8?B?NnA1TFFMTmdmdmZ5S1NQR1RWcldhUEJ2NGxqdHJxN1FXaHBndjhLZVd2WnFH?=
 =?utf-8?Q?CVPBPU4ntBbTG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlRqVnRIUENqWHJZZkhIRnljN2RmY1JNOW1adjhFL1FXK21IYnNpSWxocWdB?=
 =?utf-8?B?a2dDODlSR3B2NGpnczJseDVwcGpRYTRYQVB2Y3lkK3ErYWRZRkZ4OEVOcjFD?=
 =?utf-8?B?eXF6eU9QMi9wbVg2dWlKd0RsSGFXMy9RcUR5M0JwTlo0U2JXdlZXZ3dUSm5Z?=
 =?utf-8?B?L3JxU1REV0cwM3V1dWNQc0Y4N2h2YUsyVHdGRmE4Wms4RUZZSHRZQU1iS3Rx?=
 =?utf-8?B?bjg5WDdrQjI0QUZLV0NlR3NaQlhvUyt0T1lkWjY4R00yNEprdGQybFREMUlq?=
 =?utf-8?B?WmxhbStVTzVSSFpsd2YrUHlWaXE1ak84Uy9mRkk2SXNINmxETVB4dnIrbGNN?=
 =?utf-8?B?Y0FvS0JMMDA5WXJlWnNYOXU2U2RXc1JJT2xlNUNzcTcxUzFpaStvMDlFODhZ?=
 =?utf-8?B?Yzk5RVJmUUk4bEUxK1NNWkVVbVN3L2NURDlWREkyWTU4d21HN2J1V1BSakxB?=
 =?utf-8?B?REVobWhWSnVWbG12bVVyc0ZFOWZ1bGdhSnFJU0ZsejM5VFhpNi9UYTNKTGFp?=
 =?utf-8?B?Y3B2R29EUEFiWThlVFp3WC9vMzZZTG5iUlBIc2l3WGJVSm9hQmpYQXlRMTN3?=
 =?utf-8?B?bDJyTHp0S1U5V200amVkZlN6K3Rnb3ZzZ05BL0Z3WFVYWlFpM1E1cEFwQkNx?=
 =?utf-8?B?eCtPZ3lFOUZ6VW83RUtIRkZJYXRkT2p1MVg1YTdraXQ1SW5xc1FxSkZtU1RR?=
 =?utf-8?B?MnF6L1RKZUQ2cUp4aWNNT0g3dnpuMENpbGdVNi9TSjNvaTZiRzZ1b1hNSkll?=
 =?utf-8?B?N0k0MW1hMFMwR1BTc3IrMEFacmtvejJEcGk2VVl1VUN6ZGl1dlZSbUdxZHRM?=
 =?utf-8?B?RzhMVENtVndSWUl1WG13UUtuWDZRZWlsT1BRS1FQNGhoZUR0bW5SU2FUVGNl?=
 =?utf-8?B?SVh1MDVhb1hOYkdENjFwSjVFWk8zdmhoa0R3N2lQc3VudkhhbXVLVkVsa1kr?=
 =?utf-8?B?b2R4YW9wT3lOKzZsMTQ2T3hQY2lNSjFYbzZKVFl6MUdKbnRXb2NKNlhXTHp4?=
 =?utf-8?B?Um5iWWVEWUN4U21RMWdMMUJwbFkzMklqQnBleUJuUFkvdndrLzhMZEdZY3pR?=
 =?utf-8?B?ZWU0czl0VUlFTUV1QXdZbE9HVVRQTWxFMHNXWm0zRURwRjNPV1ZpUmtBd0hi?=
 =?utf-8?B?Vld1K1JNVkc2KytLMTNJMm44d0N2dktxcHBxMGR5QVBoVFdQTnhzbVdLQWF6?=
 =?utf-8?B?V3g0bG14bDNIZ1ZZUkNtYURDTzRrRlAxdFR3UXpPUHdFcENtTUVCcmp4TmJ6?=
 =?utf-8?B?dHVDU3lMb05zOTdjeXZVZFI0d3htTjQwbW9OVlYzUUdyN2NvU2Z5U3R1bGc2?=
 =?utf-8?B?MmpXSUtZbFVDR2RTeVRJQkZnMmFLRS9TNlBuM1lYcWRuZ0grR2d5dUM1Yyt6?=
 =?utf-8?B?ai9VUXNFVkk0TENweEtQY1M4QjFDb1hHakRIUHdRWURMQzBMcGdUMUV0OGk3?=
 =?utf-8?B?Sm01SWo2dkFnWEU4SWZRRVdYUFp6UWxJSUlodjB0Y0NoVGY4ZDRkL3pqTEhZ?=
 =?utf-8?B?Z2hlTllBcHh6djJ2VC9PQ1JHekhCNUxEK0pLdXVxQVNPYnlpbXpYYjZDbno2?=
 =?utf-8?B?SlQ3dFRPT1c1UkltOVdML3hveFh1aEV0K2pzejdPWnF2QXQ1My9GS1lIWFgy?=
 =?utf-8?B?WUVsdGFPMEJUM3prNDl5amlDYnR5bVFkSDJTQ2JWZi94Tk51dEd4OGtYS243?=
 =?utf-8?B?R0tYQml0WmZEVXZvbGF0UHhmdDEvWDZpTUJVc3JLM3htdHlwcG0xMi9nRGg5?=
 =?utf-8?B?cTlyV2lKdGMzRm8vZm4vbjkrU05aeEYrcUxNV0dZbmxMYUo0OVArZk9Yc0RL?=
 =?utf-8?B?MGU5dVJiMGdSUkRDeXhSb1VrSzIyenRENTc2QzhndjNHSHJsZVZwWENKMnR4?=
 =?utf-8?B?UGpRM2Q1RHlRc1dFNTJtVUhOK1ZTemU2a05OTUN5R0JLa0lpZUExcUtURnhC?=
 =?utf-8?B?RUNPcTJzTjRaQ2ppMSt4VzlTUGNGS0dBRCtXM0E5eDl2RjBiaTNnd0hCODNv?=
 =?utf-8?B?SFlnZVdaZkgxS3E0K2NNMjNBUlQ0U1EzckxaWllRQnBmd3RMdkdXaHRkUkR6?=
 =?utf-8?B?R1NzWngvZTk2N1ptVzM0VDhNSTVVZEhQa2xrUER5VUdVOHcza3o5T0FCVE1n?=
 =?utf-8?B?elFYZ1ZLMVQxM1VWWDR2MjU4bElHemtNNlUxL3FMQTRtUmp0N2ljeUFKYS8z?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 257c8594-ab90-443e-e79f-08dd51250648
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:36:02.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE9/Mze30jcz/U4oMuUzYFOTIyH0Az+mLK5zqKsfrs2ID2fd54oabFIXcWwmZ9haJ9v6f/LPCZPm7r26c2XSIRG9O6/sjiCsvrQwhKDuPRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
X-OriginatorOrg: intel.com

On Sun, Apr 14, 2024 at 10:05:05PM +0300, Alexey Dobriyan wrote:
>As the title says, ban
>
>	.
>	..
>
>and any name containing '/' as they show in sysfs as directory names:
>
>	/sys/module/${mod.name}
>
>sysfs tries to mangle the name and make '/' into '!' which kind of work
>but not really.
>
>Corrupting simple module to have name '/est' and loading it works:
>
>	# insmod xxx.ko
>
>	$ cat /proc/modules
>	/est 12288 0 - Live 0x0000000000000000 (P)
>
>/proc has no problems with it as it ends in data not pathname.
>
>sysfs mangles it to '/sys/module/!test'.

did you mean !est?

>
>lsmod is confused:
>
>	$ lsmod
>	Module                  Size  Used by
>	libkmod: ERROR ../libkmod/libkmod-module.c:1998 kmod_module_get_holders: could not open '/sys/module//est/holders': No such file or directory
>	/est                      -2  -2
>
>Size and refcount are bogus entirely.
>
>Apparently lsmod doesn't know about sysfs mangling scheme.

correct

>
>Worse, rmmod doesn't work too:
>
>	$ sudo rmmod '/est'
>	rmmod: ERROR: Module /est is not currently loaded
>
>I don't even want to know what it is doing.

because of the missing sysfs entry above... it first checks if the
module is loaded.

>
>Practically there is no nice way for the admin to get rid of the module,
>so we should just ban such names. Writing small program to just delete
>module by name could possibly work maybe.

--force drops the check for "is it loaded?" and should work

>
>Any other subsystem should use nice helper function aptly named
>
>	string_is_vfs_ready()
>
>and apply additional restrictions if necessary.
>
>/proc/modules hints that newlines should be banned too,
>and \x1f, and whitespace, and similar looking characters
>from different languages and emojis (except 🐧obviously).
>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

But I agree that it would be better to ban these chars from module
names. I don't think we'd ever merge such a module in tree neither.

Lucas De Marchi

>---
>
> include/linux/fs.h   |    8 ++++++++
> kernel/module/main.c |    5 +++++
> 2 files changed, 13 insertions(+)
>
>--- a/include/linux/fs.h
>+++ b/include/linux/fs.h
>@@ -3616,4 +3616,12 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
> extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
> 			   int advice);
>
>+/*
>+ * Use this if data from userspace end up as directory/filename on
>+ * some virtual filesystem.
>+ */
>+static inline bool string_is_vfs_ready(const char *s)
>+{
>+	return strcmp(s, ".") != 0 && strcmp(s, "..") != 0 && !strchr(s, '/');
>+}
> #endif /* _LINUX_FS_H */
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -2893,6 +2893,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
>
> 	audit_log_kern_module(mod->name);
>
>+	if (!string_is_vfs_ready(mod->name)) {
>+		err = -EINVAL;
>+		goto free_module;
>+	}
>+
> 	/* Reserve our place in the list. */
> 	err = add_unformed_module(mod);
> 	if (err)

