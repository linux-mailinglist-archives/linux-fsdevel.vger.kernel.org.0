Return-Path: <linux-fsdevel+bounces-26084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F765953990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BD71F24706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D154BD4;
	Thu, 15 Aug 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkyuAzVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919F1388;
	Thu, 15 Aug 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744850; cv=fail; b=srhEfbGdjOCE8cfkDRS8ngidiBgjMP3p0/s7s8WpDXrlPWCBWFqZURm1V+uc3WtuwGT2r0n/bJVlGMjgNxegq3A8qwv9b/EvVb/9ep8NKcPUDR317fGwb2J/InfrCugc+sJvCZ9XKP+nE/vzBZDdsyhnkrVIA8yIVBFLvRfCYzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744850; c=relaxed/simple;
	bh=uFmKFbbIIINqISMiZtSm6LBK4ft3l8tAdvyQjCasIm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0JMFVYQzeJ+EtA3Z/Hqf3jPF7f+CvJ3i9XF1bCDxwCVDSNtHmYhE+HOMHQtPezUcXVmu2GGnIYGRXeEPKDkHzYvsEHXsH5lK0YJBlPC/K/yLU5KV+c2fJNfVG6x3i+YMKkcIsJcb41Z8MYXX+CLHet1wmwoBgFR9KQV4an9MR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkyuAzVO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723744847; x=1755280847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uFmKFbbIIINqISMiZtSm6LBK4ft3l8tAdvyQjCasIm8=;
  b=lkyuAzVOyzPaMtij9pskyV3Wa0AlV1rJc1keEzpvrn8/txVr9EKpEcAP
   YOEad0MyUFeKJSIM7Oc0oSGycdsjKcjoEhpLq3P2cES2sr71s6PJrfA6V
   CDDjmXxTwXwsnngd9Bfev/ba3yj2VFF0xL6BOthB6DVyQVsfpHPdFhDsY
   k4EafvIuo/yRHCRh4GD/i3XAto5SamLkteo9MNixKjOx1oFJNgr/vfb4b
   vC4VFMwUv4YvsVebQH5M6XFxrz9HjmTtohGxy1pp5y43X7MIgeSyM1c2U
   EWFkixhB1wJaqsC/5h1D6NEeurwjWB5Qwy7S3/WkKz1qEgUxpHD9+r+31
   A==;
X-CSE-ConnectionGUID: D9m6duytTTiI36mAlBROYg==
X-CSE-MsgGUID: XwXmjiIeTfOnzV2EDiZp1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33408986"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="33408986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 10:53:24 -0700
X-CSE-ConnectionGUID: LkjLj3ltRL6SbOj9NYN0Gg==
X-CSE-MsgGUID: 2UrRMFOZSe+Nt7eTE6yYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="64369895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 10:53:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 10:53:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 10:53:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 10:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHD3bjWa1nnVkUEf3XGwKcVOz8pSnnnu8poPRdAXM0ZcIy37+NX3JiqEamcOWGX740urcrJwpTepqY6mw/UWIJzQNg4lT4eZJEQJiN/ytuRGaEOWcugbmQs7rjNtV8e5a2KjyGk37sCGUmzanip2jjVXRcO3NChuQHm0aPnAt/LsmtD/SHv4BdzxBV5wmppYlcsoNcrEvnzxp1t2dm6bMul6NN6+QfyJ5YdmNZNQhopsElbciKNkIGZgxYuJRf8/1rAnmlN0bkYsZ9XqFa/qEMqRvmyl5Gaem9PXpcXRwspk5784paoxqP+7jH5rVY+NGLwCIWQ7xk2OYbjwsVEk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFmKFbbIIINqISMiZtSm6LBK4ft3l8tAdvyQjCasIm8=;
 b=KoKS0mK9aMJdmcZv3fFqfZJRZJRSVpmbVTkbAAdbZIr2CQj3qsck07tTCLnQW4gtMm8FQK0gLf0RzHMgdlQnLB66mmSjCofZa6CI7fHQQr8caZibQXhUuu3j6ulyqfxocHQRjqnyIxiiDxdu7Oqn4KdnxQ3pAMpJh1QtxJXIYBozuASfoOIz+mK4Oe9V7VihgHYSQyHUZTQm8IokNAWYLLplrJSbdjLrC7dyOb++1zU993+pW7XkiusKjQ/iWloT9/C9++GUsZYpzZrWbmtwbSTAmXKLXn8/thX4a/DhdXeSyZUuYuC1Ls0S09gLJsYuZT4gKoIQ7YD+RT58Tm9vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 17:53:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 17:53:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "kees@kernel.org" <kees@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "shuah@kernel.org"
	<shuah@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org"
	<maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "thiago.bauermann@linaro.org"
	<thiago.bauermann@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Topic: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Thread-Index: AQHa5BKUVD7wI5NTNUm62iFzIM90d7IohUeAgAABngCAABRGAIAAFLaA
Date: Thu, 15 Aug 2024 17:53:19 +0000
Message-ID: <e6c8618a1585006dde44c17192a3bb7ae8ec5c0b.camel@intel.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
	 <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
	 <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
	 <68ec09da-fb4a-4d59-9c8c-6fae4c48ea68@sirena.org.uk>
In-Reply-To: <68ec09da-fb4a-4d59-9c8c-6fae4c48ea68@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB6891:EE_
x-ms-office365-filtering-correlation-id: 50a0f592-0d14-4bb2-4717-08dcbd532609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkF0SlcraS9pS3FGRWRrT0hFN2ZLcUxCSzFJU0tmbXdTUVRPRG0zZDlDdm90?=
 =?utf-8?B?UUpxdjhwY0xrNVpqc1BwbzFJWmxIMkVVbGRJKzZMdnN5SmNTOFowdyt1c0Q4?=
 =?utf-8?B?bEV2Y3JabEtsczQ5ZDdqeXdoVi92NjJPQTFYeCtNK2x5cWxMUVliV2JpS2Nw?=
 =?utf-8?B?c0JURDBneEhzU09zck1lR3hTWXJvK1BxcnY3cERPN0huWldaK0JGdVNleEZh?=
 =?utf-8?B?S2treTVwbnZGeUZ1UkgveTZhU1Q1dDM3cHY0TFMyUC9pcVFiSGVlTWVxUHdy?=
 =?utf-8?B?ME84UXM1aDQ5b2RpOStNYmxZdWcvSG0wTHV0S1V4M0cyc2NicUxka1J0Szl5?=
 =?utf-8?B?N2xiU1RuaVE4Q1FlekZ1ZVIzZTNIRmxYaThRMEhNNFhTNHF5ZnNJV2lYa0JT?=
 =?utf-8?B?OEpMc3RFbW00b21FMnB0VW5wVS9NNjZjOC9FWkdqMXhOenJyY1V3Qi96U1dv?=
 =?utf-8?B?eWRLWk51eWhKQmdmMk9wbXVQcUlGTnd3a08vTmlzbmpwbWl2ak8vaFlKNDdu?=
 =?utf-8?B?UkZGTTJRVzB0cGsrWk9DL2FpQUY1UkxsNEZtblVka3lCRUU4RjN6ZGtmOUgv?=
 =?utf-8?B?ak9RK2RXektoTE8vL2Z0TEtKcmRZamxiR0hSbUJ3dXBmdkFZcnEyQTg1M2Y1?=
 =?utf-8?B?ektIeTNDY0M5T1hLd1pVSVlRSEZXbkRYSVBZVXFGTTJHcWV5NWtVTnJ5N3kr?=
 =?utf-8?B?UWdSWEVWWlM2VVlqdk5udXBJMUtENmJpaENzbUJnb2hnbDNuOC9KQWpaOEcx?=
 =?utf-8?B?T284U00vbzRKTWFyem9rUTdXbDZkamxUN1VNUEN1ZVRSaFplb1pKS3pwaTRx?=
 =?utf-8?B?TS84bXFGZTBPWWhFY3lQeVVRMWNvL2tLVWd1ZTR4WlVDYmgyQU5FOFdrWEFq?=
 =?utf-8?B?L3hRWkxLbDZYVjhhM0xQMlpaK2szTlFPc1BqMVlTLzNYbXM2dDYwNEVpM2J5?=
 =?utf-8?B?Rzd4d2o1ampUQllBb3dwWlFkVFIzVUZiREY0K0xBOUdISXRkTDBrUkh4OEJV?=
 =?utf-8?B?ZERmM3RXdVprT3FFQ3RmSU1jcTJhdlVwczBDNHBMZHEyTDA1cXFLMVM1bUxz?=
 =?utf-8?B?cTI4dTlmT0ppV2x4dW1hTkZPeXAvbjNMbFdwN2Zhc2xKZTc5Uit4dUNBdnl4?=
 =?utf-8?B?V2xUdlV5WDM2RllyOUZrbkFkMFRFcTlYNFFYY0o0K2tjSTkya1lRWVRRb09w?=
 =?utf-8?B?WjZ2MzNTNkFMWEJ3bGhqaTNSb3o1Q0NQbms2SnlkVDJ5c0pGdnpWTUFpV0lU?=
 =?utf-8?B?M0pacVpFNHR1bFNZbUl6Z1NaU0NoUXh4aVBJanFkRktyTEpLNTlncHJ4eTFX?=
 =?utf-8?B?Wmo3V0FHRlpZbmRUWStNY1Y5c3RrWFJzaDU0RzNzN1o1OStIRld5MW9uNFAv?=
 =?utf-8?B?ZGxWaktUQkFwaWl5ODJvWVg1d2x0QWxnYVdnT2ZIazVMRGRacDlGQzdiSDZx?=
 =?utf-8?B?UjczQ3F5eWtDUUdnSnJMWkxUYUFSZldKeEk2OU5Jamp1T0pHSGJVSjhJdE9n?=
 =?utf-8?B?NUVCaTA3NHQvWThaL0llYVo0V2VMN3pyVFBYVmNQZEpuOStPV2RuK0lZejcv?=
 =?utf-8?B?OGpNa05VWmd0L0puS2RZWW1qQkJnQXFUY3VlSHBnWXNFZ0VLbVRTYW5RSW9F?=
 =?utf-8?B?ZDRKTVNhWVNBZWJMRjJFdEY1S2wvMjlVZ2hVSGgvUmNsQjVXQ2lTb0hobGtx?=
 =?utf-8?B?dnkzd0Mwc2N5M2d4dVNqbTQyZ2VaT0xhVUdreFpVRWs0YWZGdFg1cExWNUFE?=
 =?utf-8?B?YllFM0M5akdZZlF4MUhMRmRGNktIcS8ySUJ3Wjk4UUJLaGl6Q3RQemQ3UGlH?=
 =?utf-8?B?Smp4RlByRGh0eUQ4M0N0ZW9BUlRyZEtoQ1ZPN3JaN1Z6TFJ1UlRnWkMreWRh?=
 =?utf-8?B?bm9SVEhYcmFJQy9tOG9KUGJvdFo4aGFWeWQ1MVBudlFHbVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlFFSXVUSG1GK3c1cHJOZjU0UGZDclN4QWtZUys4aGZ5cjhHYnM0aHpSQnhx?=
 =?utf-8?B?dDZIeVh3eTcvTnRDVVZYVk1XdGo3eEl5bUVkV0t1QVdMZzRYbDZ4Q1pDb3ox?=
 =?utf-8?B?c2oyZDhuY0thbllsMXBwNkhQMXltWVJlZVpTOTAzS3gyT2dQRmVUS0ZITVdL?=
 =?utf-8?B?VDJWSHcyaDRPRTNWeGs4ZHVNY2hIdzN1c3JudENseDZmVitjVmp4bEZxTCt5?=
 =?utf-8?B?NTZTeVRKZFdtZGliTXFueWZjN0RqOFY1UUI0M3haWm0vdjZHVldaVExPK21H?=
 =?utf-8?B?NFQwb002WDVCZ1J1RzE3cXE2YjI5ZFRXdWYzN3hBbzhVVDlyei9LUzJMUWU1?=
 =?utf-8?B?eVp5QWFMZ2RSQ1AzZHZrcmxLWTBRSXdsSFVzNFU1NytpZCt6Zzc4eEx2L1pF?=
 =?utf-8?B?THg3OUZDZE1Gb21EVVlpcDVIb0RZWnM1TXhtK2xXaytPb2E5QVBKM3lIa0lK?=
 =?utf-8?B?VXJkZDEyL0MwU3BoV2RKMDV5SUdyUDEvSXNSZENpQUNtcXBBKzF1dUQwUldS?=
 =?utf-8?B?WU1tUTJEQ2ZhL1pRbVhCeTlKOFJzU0hwTEljQVFVc0JFR1BSS1d2Mm5RTXJ1?=
 =?utf-8?B?dHVrdFNlTDFqU0VNMlA0VVl5R0VQSGRCZjZGajRkRktuK0VneVRMVmZsTjZ2?=
 =?utf-8?B?K1QwNjVWbUE4RkNSWjl0WHRNbGZ1YUVwTk80RGhyS0R2YldaNXZPQlNBRkZn?=
 =?utf-8?B?SDRHaEhFSVEzU2RNbG9kSlNNUmpLcGg5Z2pEOU9RSWZwcm9BbURVQTdmSGFa?=
 =?utf-8?B?SVBOSXRxYnFVc0gvWGxCTjlDSTFwN0hFWTJDT25Yb1NZTlM2SVhINDFLTjNT?=
 =?utf-8?B?MkpCOC9wd2dLMXNHNE1qVzB2WGtyUGhmV29HRFc2cXZrem03WlZYSnN5SHVG?=
 =?utf-8?B?YnQzQmx4SlZnOXBpQmVjNmVMcko5THZhcnk1RDQ4M2JOdG9Bc1haRlYzVDhZ?=
 =?utf-8?B?QmRNUHpuUDQ4bUpUQ21QbnlmOHh1VEhhZVhhVFJpSnFzdEZCakJrRUxUSmFV?=
 =?utf-8?B?eitYY3NtVC9URkpmNzZ4RWZYeEk1TDAwWG1lL3o4TjZVNTZneW1yNlN1RHYx?=
 =?utf-8?B?cjhUcW1jVW0zZnZEQnBnWmt1T2M5TXRWZzZJMFNZREljRVNyblFYNmVsb2tX?=
 =?utf-8?B?T2x2aVVUSHF2THBXTVVDbDhXTXV0b3lrOG03YnNhN2kxZnpRYmNqdEd3WUl1?=
 =?utf-8?B?NmRRWVFzOTZLUldkRXNlck00eXpja2RpSkpiZFM5cUozenE4NTBKQTlrMklF?=
 =?utf-8?B?cElOMDI2K3dMZUxiMVhwYWtjcFFSV0lmMGhDRUtIU0hmRndHMkh5VWp3MzF4?=
 =?utf-8?B?ZUI3MHpjNHpxUlZ2MWwwNnF0d3R0VWZDb0w3NkQ0ODJ3MmI2WnRjS2dBaGMr?=
 =?utf-8?B?Wi9FbHlPaE1LOFQwTVRrMEdIOWN2MGNyaWJpVStnbThDNkxnWm56Q2tZVWpZ?=
 =?utf-8?B?TG5mUlZ4d1FDWGxmamVIZjRoSFo1RTg2RXVOUkVnTHpnSW9ONDU1a0h4UEJQ?=
 =?utf-8?B?R0UvNWNmRGtJMjN3ZDBPUHJweGNUR0xlUzF5WkozV0tRM2h6Skl1bVFrU2Fz?=
 =?utf-8?B?SDBVWkNFeUxDUi92ZVhFYnhjN3RZYk5OdmlnZFN6aDRnV0RMdFVKSjJUVHJO?=
 =?utf-8?B?L1FUV1BqOWdzekduTTdMenhWM1FMMUJmbGllL3ZaS1RienpEd002YlJ2d09Q?=
 =?utf-8?B?OWZOS2dDbC9WbUVwZE55a1U1cVVkeit6TXJRVnZBUDMvQ2pveGVqcy9oZUdU?=
 =?utf-8?B?YnNkVDd5TkVSb1d5bUJqTmtLNytEZEFacEE0RnpzT1o1VVI3RXlOa0pWREps?=
 =?utf-8?B?S1l1dllHMmVEaUZZczRXNTE4T3drYUJUYzNQQVVvR0tMbklQckxjL2dvRjBj?=
 =?utf-8?B?WEgvNnJQOGZHWVJjdGtiZlFxM1VWMW5zK29UYk1wVkVEUUxBWFBpeTBES0ZH?=
 =?utf-8?B?N1lKZW5oMmxHWVhQU1orTFJYZkRLcUlKT1N0dGwxT0Z0QTJIbnhRZ1ZwVUdL?=
 =?utf-8?B?Ykt6WGlsSldhMEwwOHYxNFF1cjZNVFEvZS9pSjlZUUxVcnZ4ZEtuWXZYQXJC?=
 =?utf-8?B?SDl2c2hMeEoyYk5LZ0J3cStvZHo4TkNwOCtJSHVZdWdZZ3RmaGFPSXA5ZWo2?=
 =?utf-8?B?Kzl6U1JmRTBCNlVuZDFYU3oyTENyQjdTWFdtK2s3bGszaWhCcFFhMkZIWnVq?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E050566AAE5624390CF5D6F0DC7E050@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a0f592-0d14-4bb2-4717-08dcbd532609
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 17:53:19.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol6eEm8WvwStJ1whi5/IATzKvTmDEPXVJrntVt6crUnE9aSUZguymqQsr82MB2hRRrx7W27AhabfW2TBipfs3x5GOz9C2BXqbYaGGtUXSjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTE1IGF0IDE3OjM5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IE9oLCB0aGFua3MgZm9yIHRoZSBoZWFkcyB1cCAtIEknZCBtaXNzZWQgdGhhdC4NCj4gDQo+IExv
b2tpbmcgYXQgdGhpcyBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGRvIGFzIHdhcyBkb25lIGZv
ciB4ODYgYW5kDQo+IHNwbGl0IHRoaXMgb3V0IGludG8gYSBzZXBhcmF0ZSBzZXJpZXMgKHBhcnQg
b2Ygd2h5IEknZCBtaXNzZWQgaXQpLA0KPiB1cGRhdGluZyB0aGUgZ2VuZXJpYyBpbXBsZW1lbnRh
dGlvbiB0byBkbyB0aGlzIGJ5IGRlZmF1bHQuwqAgVGhhdCdsbA0KPiB0b3VjaCBhIGJ1bmNoIG9m
IGFyY2hpdGVjdHVyZXMgYW5kIHRoZSBzZXJpZXMgaXMgYWxyZWFkeSBxdWl0ZSBiaWcsDQo+IGl0
J3Mgbm90IHJlYWxseSBhbiBBQkkgaW1wYWN0Lg0KDQpUaGUgc2VyaWVzIGlzIGFscmVhZHkgdXBz
dHJlYW0uIFlvdSBqdXN0IG5lZWQgdG8gYWRkIGFuIGFybSB2ZXJzaW9uIG9mIHRoYXQNCmxpbmtl
ZCBwYXRjaC4gQnV0IHVwIHRvIHlvdS4NCg==

