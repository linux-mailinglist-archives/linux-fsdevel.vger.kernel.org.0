Return-Path: <linux-fsdevel+bounces-21599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEFA9063FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18531F21EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 06:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905031369AE;
	Thu, 13 Jun 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFXh3fRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838813698D;
	Thu, 13 Jun 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259787; cv=fail; b=My5G2pYQ5uuksT2plTMhqigN1s7ts2CYStBUyRFgJeKYOF0fvHmloiwE1Fp5t8Wpr+tF9MbURiI5LUAwIANHlbBwTc3y8ds60cV5dm3mtU8x0Sna4TGqthql+1fqTcNgikt9heNCESzJEQVOohfnGwiNIu8SLOAbisXZzAkF4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259787; c=relaxed/simple;
	bh=mGCOrA4/fZrmpIP0vYndRz/QsVIn0b0Bkk32X4zY+Hk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5HLG0K0trH0f27i5LEp5tx9vWR01pxbJfcV3DE4DWkOReCtvOZd9Qap6/kAQNpywVxJAUdM6sOAsHi2dOzxUPr1F12lduyBOjygY1R44hxikZVPtVcl7Ylo1AJ5DFvPvQCcvuDOMBqphh5vfs0kXkeZYG8F/s+eiBwWIWVjrWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFXh3fRv; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718259784; x=1749795784;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=mGCOrA4/fZrmpIP0vYndRz/QsVIn0b0Bkk32X4zY+Hk=;
  b=KFXh3fRv9XlyWC9hqx1MetdBkT9ueuY+vrFbsznXg3WlAe6DJ/aZk1pv
   ppiR+RMNw8rpqqhewJWXrcsDhNabakIZexFbZceK2RYmwnensp/SvwtVq
   S1YOfB6xu5wy7YYbAQ3ooorEckvcXcwtSdKkWAWNNw4fmP6RmTT6vrmEa
   aDXAM7+FmLWV7+fNgfx9g8PrVX4n9SSyhpAfxfiFwk3b2tjf3PI2pA4tU
   pUtnJnXNvQjnYijjxPXwg0xQml7sF9JD6laq9/UUHbdTpnr88JGQZ/yNQ
   AYZkhWAVlTnK8ts487wNuEqYC32Np54CpjmJoDux/krhgEbfRYqT5qtYE
   g==;
X-CSE-ConnectionGUID: 8mBhinrTTPO4vvIA/ZV5zg==
X-CSE-MsgGUID: BROriLUbTbiGU2Z5YBJGwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14896151"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14896151"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:23:04 -0700
X-CSE-ConnectionGUID: AzAMt/5QRpyPHmZzAWJqdA==
X-CSE-MsgGUID: Eb9wAFwdSWW539cIPiovgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40510930"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 23:23:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 23:23:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 23:23:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 23:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht4ie/STxaxJ5qUBcOiT9SyAU7vF1sxzNNI5SkcHbzmr0uuzxiMfA/o2g4MdBY59vsxdy3QzJJ08CKsxw7V70kIi4tmpDysP2uwv9ImXOelw2cXscHAr/BjnthTN5zy1EYCBQKENCdqJaEgh3/6soOv3Lffapt2cFmuxfcUZmObr6cJar8ATGZfdqMof4uv81bVL3wSO9JjrHLkUpiAxk/s3cEEfEigFnKfUSoCnWEtfJ4WiUV2EagjuGNXz1yyzQmgIWp4AS0YrsY+gIrEB0aHYNbrr/Mz7NzzQStqHFHEkZ3B///QcwAe9+963Otzn0Wu5hmyaPGnCePoJwZ4Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGCOrA4/fZrmpIP0vYndRz/QsVIn0b0Bkk32X4zY+Hk=;
 b=EXGk+iH26F7v4J2LyoZd48Adbo7x1xbZKhUHZ8lsxw/V0a74wrxL1/Pfe+zD+P8sFHFt9JBRkOtMmWpG/5ZET7NCnOiNhXfsY7cpHXFVB7KRjvOtIpBS994qy1CJg+wSASq+CK5MlWfwiJvXBNqcXY1X/WfgxI5YjJZm19K3pVWO84O1EgrtJuwjR2h+BuQbRBclAtUTh4pr4HIk1bePMJPH4fZA+6q/+OD6iNg6tlYHzJqXbm0In2oQJgG83gVw1Ba6N7wZOC22b+lSeDrO+O6B5vYBEvm3YuHOS7SyAeSc9shgNmpWdpfZ2gVuOWo3N7elHNhgQCd4ckLNefztVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB7006.namprd11.prod.outlook.com (2603:10b6:303:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 06:23:00 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 06:23:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: syzbot <syzbot+b2cfdac9ae5278d4b621@syzkaller.appspotmail.com>,
	"airlied@redhat.com" <airlied@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "kraxel@redhat.com" <kraxel@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"phillip@squashfs.org.uk" <phillip@squashfs.org.uk>,
	"squashfs-devel@lists.sourceforge.net"
	<squashfs-devel@lists.sourceforge.net>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>
Subject: RE: [syzbot] [squashfs?] VFS: Close: file count is zero
 (use-after-free)
Thread-Topic: [syzbot] [squashfs?] VFS: Close: file count is zero
 (use-after-free)
Thread-Index: AQHatQBrZn/RM3LpHE2RovnOtWJdCLHFSeGw
Date: Thu, 13 Jun 2024 06:23:00 +0000
Message-ID: <IA0PR11MB7185204ED80582B2C8D0D582F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <000000000000a82e6e0619e9c192@google.com>
In-Reply-To: <000000000000a82e6e0619e9c192@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB7006:EE_
x-ms-office365-filtering-correlation-id: 740cf81e-272a-436e-4551-08dc8b714646
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008|921014|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?S3V6QmprR3dScDUzTWdUOTExMzRGeWRZN0dqWjJEaVYwckFtWWIxOVVHVmpM?=
 =?utf-8?B?bXVZRWNyYzc3c2lCNjd6VnlwQWErVHpPRUJGclEzT0hNbUV6ajZpeC9pMmZ6?=
 =?utf-8?B?NWNhYUVOYm15QWNER0hhL0h6cmZDZUdyY0ZFQ1J4U0NpRVYvSTk5c05Nb0pZ?=
 =?utf-8?B?aXBmZnlKN2tqWTZVTEVwSldIaWF0Y2dBenEzUG5RVUZpRGNZbkNXb0ZiQjFq?=
 =?utf-8?B?VzlmVHh4REJHUlpIbWF5bXMweEJNTkNOeUFBczMrbkpGcTBQdi9YOFF6b0VH?=
 =?utf-8?B?anEwdXk3aC9xeitCNGNrd281bzhITHB2b3pBT3hpckRwR1J3b3A3WUtpK0lX?=
 =?utf-8?B?L2F2QkZVU1hodmM0ZFpTaHB3NTNOaTZNbXJPVnNMKzVIdHE1Rmx4NCtZT1JI?=
 =?utf-8?B?aFVVbDZxNU9KeDZoSHgrYXhiQm14V0puakMwRzVCL2FseGhvK2dhVmw2d2Iv?=
 =?utf-8?B?M0JtQXh2QSsxSVBZZVdBSFhlNHk2SlBhaHpSUzBkNG95UnNxcFFLQ2k4MHQ4?=
 =?utf-8?B?TlVPT1NhZnlqbVRZOFVKUzF5YlZ2c0FvcXdZSnNRN3p3SlZpcDZHWXJBcm9z?=
 =?utf-8?B?amMrZUV6OVNnMVR5ODQrcWd0VWxici81eDNvS0FZdnpLZEpsMHpHc2R3Titx?=
 =?utf-8?B?d1BDRHBnQU92QTVtRENUWHJ0L09XYzc4VmM1aDBwaWVYa3JweWFrUDlJUjZo?=
 =?utf-8?B?L29WcXN1RHZ2L2pQUmNISXNGVmlIaWQwbExoWngyQm8wUmxjUGdRMS93a1Jk?=
 =?utf-8?B?ZzJWYVRBYUFCbHNWZ2x2Qzl2dEs3aDAvL0FhUjhGR0pzOHFYVGtHL2dBVnpH?=
 =?utf-8?B?aHRJRUVuUEtkZ0p3YUxjUG9SaTFUeWJVMGlRTkFwcGZscVFsZVBxbTVpdmdL?=
 =?utf-8?B?RXNOWGZlc0RkSk5ZOEhvQlNML2RTRTQvVmFsUGhjNW9pbEFvSThka0N0Y3Ew?=
 =?utf-8?B?MHdHV0FnOXhFNHQwT3I2cmpRclNrd1kvbTBta0NOV3lNcko0UFVndmh6c2FL?=
 =?utf-8?B?NnFKckdkN0ZCZHhoUFY4L1FLQVVUMUZnS3k3TVRnUXJtY21ydk94RDhZREUx?=
 =?utf-8?B?eHFxeFkxN3BvYnp2OGREcnMyaTNUVkR1d3lHOVRpQTJuSXZvdlVBVW93WnJJ?=
 =?utf-8?B?a2h3Z0pBK2M3VTdyN0FGVFEvRGU4aHdoMEx4MkVaNENUYTcrays0U0IrclNK?=
 =?utf-8?B?OElYbXdLN2RTYnRBYngraTVVVURqMHpXYTZ3TUdjaVA0RTAvRkFaWTJSRU9U?=
 =?utf-8?B?cDVUZStBUE9KcDNwWEpTdm1mZXRyQ1l0Y2tIY09YQjRoYm1GSjNuY3ZIelJK?=
 =?utf-8?B?S280UTBmVUtVSnlHQklEYzF5Vk9HOHlyL1BXajJKYlVNK0tvK0JOSFFzbk5O?=
 =?utf-8?B?VG5FUzNDNDRjQXpFdGZzTVFzN0dKZTUveC9oSXdKMm1jZlRXSW1HZjRaT0JF?=
 =?utf-8?B?aDd0M3hGUDFXb3RITkZBanZGUmZxMnZQcU5LYldPc011b3NQd3l5U1dlOFUr?=
 =?utf-8?B?RlJZQ0Q4WVRxZEJ1SmJsL2s2STlsM0NSM1F3eEpqVzVBU2FwUEJYNFF3UWdY?=
 =?utf-8?B?NENqdHBPZVNPVVlmaTAyY3VLWTJPYm52TEh6aXpwbXRGeHJ6TllrSFQzNXpM?=
 =?utf-8?B?eFBoMkdPamNHbkxtNS9pdm1UYjF2ckFlVzBvTXlrUTlUMlhkMUJldUliUEo1?=
 =?utf-8?B?d0Vtdi8rT1NNbEhlL2pvTGNEN0NaUmJXSUtJd1JJclVILy91QUhObzJyZThn?=
 =?utf-8?B?NUtZdFpLSEFGcUVHMFloeDQ2RC9ZYTVDYlU1cjBxb0czL0xFUUlnL0hpWFEz?=
 =?utf-8?B?V2lodWxkZGlJYlRMcWZjdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(921014)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJrcEFBdW1vZ2htNWNyZDlEUmxNUS95RVd4Yll4bk5XNlZTVjQzSmxpdVda?=
 =?utf-8?B?alpHc2pyUkZpd1hBK0EwaXNicmFNK0Z0dUpFWGc3QmhMbDRBYksrelpzbFcv?=
 =?utf-8?B?YXZJWUZUa1BjczI5OS9jQTVwOVorV0lVcXpvTnpjRGM0ajlsT28vVlhOMzMy?=
 =?utf-8?B?RXhUaEh3WGpJVEx4SHpVR3pqNiswOXBqWEhQTjlhc2NCdmtxYWJMUkJ0MkFi?=
 =?utf-8?B?MXY1TUxWbmlWMXdCbUY0YkFZT2tUTHdZbHhxeGFQd1k3bXlLYlF5YVBhMVRs?=
 =?utf-8?B?dUk5Uy9NcnlXbnhmNi9OOG42NDhQRHdyUDlpN2RnNHpRTTRtM1hMRlR2V3VV?=
 =?utf-8?B?VGJ4ZDVRU3RKOGxWYVZHNVR1M3JFdjliODZQSnZXM1N6cU1SdFVWdkszckZ2?=
 =?utf-8?B?VDRjbWpheExjQUs3WVJKeXNCa3N2MzdOaDZpempDM0hZZFYzT2M3elQ0dHdu?=
 =?utf-8?B?ZXA1QjhuVmJHWEJkWmJuTHlwQStGbXIza0V2RThUZFBEWkpEbjQxR3hQdTUw?=
 =?utf-8?B?Z1ovRXViNXdObGhJVVRCdk41OHJtaGJhbGFEaGVuZ1NOZ0l5dUJ4Y0pEa2pB?=
 =?utf-8?B?dmlva0dmalBqb1VsTnpzY2RydUlKV2JPTVV2SkgvOHczRnhDeWZNSk52ZWpn?=
 =?utf-8?B?Qi82WkY3c21iRGQyUGtrRlM5T2VwdWpiY0srQlVvaitkbVBPamNybE5UVFYz?=
 =?utf-8?B?UFdxR01nc2V5b0tRaWNUcnQ3SXVEdGIvOEFRc0k1Rml3U2x6a3dPWGFFMm10?=
 =?utf-8?B?b0RPclhMRUYwelhkWTg5SVdsd3E2NGEvUVdTZklhaW9RaTB5VytxZkJ2UkxW?=
 =?utf-8?B?UTFNbW0zVFdHV3dYblQwbmpweUZyU05ZYzhiSWFMcmVpSEhNS1VrQnJYWVZs?=
 =?utf-8?B?QW9FN2VkQ3VNL3I4aXFUamphNDh1YnVJd0NFa2p0U25kUEExWW9GYmc0YUFL?=
 =?utf-8?B?QWRiWHI3N2hjclY3SXpBd1BwTkYrY0UzS1VkYTJtY1NmUVZTM0cwTzBMVVVN?=
 =?utf-8?B?WWhnYUVTOFFScCtER1VpR0d0RGRKUGpMMDMrNjNkbWlNaDBqWHllNks5Z3pk?=
 =?utf-8?B?WDlJdGhNWStTc2twWEE1ZXpmUkpJc2NpeUJLQ3ZlQllocnUwVjJlYW9kS0w0?=
 =?utf-8?B?czFXRkZRbmRMeFRuVzlGMmZqc2M1bTQrRmRLQUFnbFl0Y1I2MHc0S1BFMWVX?=
 =?utf-8?B?WE55SlhsbnZaUkZzUklCdjIyQ2dYMm1iUkgwWWpxYWExV1pvNjVmYk1WdndU?=
 =?utf-8?B?bGhudkFnbEJyTDQ0SDVNb2dPL1dNaVhWTUVQMDRFZ3gzWnNXcXZMNlY4RFF3?=
 =?utf-8?B?NExUN2dRVzhkeDg3WTUrd3hYVWswT2E0NlhSYk1OQ08ydWI2M2JVVTRqSzJz?=
 =?utf-8?B?cTRoa1JEVXVKWkd3U3ppT3c4VDM4ejVwNUg5aWlYMUtXcWZHN3U3aXcwSHQw?=
 =?utf-8?B?aWkxSmRiUlZieWVjVWd6ZWlGbGhTelM2ZVFpVlFLVFN0RlAzbkxlazBBMUw3?=
 =?utf-8?B?V05nK3pYQ2Z3cjI3bTRDaDYrMThKNW1pejg3RlNwTVNtMFQ2VWZ6M1hUekIz?=
 =?utf-8?B?S1BkZ0VqcURSYkFhVy9oWm1yaFo3d2x4cHp6bEdCOUlpR0xsTjlTd2J6SlRC?=
 =?utf-8?B?SC9GdGJxYkZyUGFWY3BqZW1FS1FEN2VUMWdjWHRuc0EwNWMxdjNINTJmQ1JC?=
 =?utf-8?B?eHN4U2I0M25yYmdZOUNSUGJERWVhUFVhNjdWRS9LMWtyQk1tMC93RUN0eEow?=
 =?utf-8?B?YXQwNzAwY21rYVRYeFBRR3Y5MDF4RkpRQm0zNFY5REZ6cURKTC96VGYxaEVx?=
 =?utf-8?B?cXNYSU00SkVqRkxJVGorR1BoTUxHaW5jcHA2bXlWRjdmZmdoV3ZnMG0wQjY3?=
 =?utf-8?B?dzRLdlkzK3pjdnFuWVU5em92dG90S0g4bFgrMEZleFpjLzA4UUxTbHNScENL?=
 =?utf-8?B?M25QbGRhanZjSDk3S09pSVFuSWN1SmRjNHhPSWZxYTc1dm16NlFJU1NYckl6?=
 =?utf-8?B?MGRrN080aThuSS8rb2FIcFZsMFZrUS9JeGNBV0RYbUd4NUR1aFZPSSt1RzFH?=
 =?utf-8?B?cmdUWjU5WUd4SWlvUkxZa1dYS0tzZjgwNEx2ZTlEcnl0T0RIVUxCdEI2OVlF?=
 =?utf-8?Q?eAtF6+ayHKXxHz2M1DLZ5M3y5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740cf81e-272a-436e-4551-08dc8b714646
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 06:23:00.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXF8/MfMpwSgvgY4Kt9srazzKFvFOmANFS6DWHUgGzHyATsTgCzsYHO2i6ulgH4fWu8Y4nrWLk879QiLaHvlJTZwPUoh1/ri7+tvCtSvyjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7006
X-OriginatorOrg: intel.com

PiBzeXpib3QgZm91bmQgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoNCj4gDQo+IEhFQUQgY29tbWl0
OiAgICAwZTE5ODBjNDBiNmUgQWRkIGxpbnV4LW5leHQgc3BlY2lmaWMgZmlsZXMgZm9yIDIwMjQw
NTMxDQo+IGdpdCB0cmVlOiAgICAgICBsaW51eC1uZXh0DQo+IGNvbnNvbGUrc3RyYWNlOiBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xM2FjNDYxNjk4MDAwMA0KPiBr
ZXJuZWwgY29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9
ZDljM2NhNGU1NDU3N2I4OA0KPiBkYXNoYm9hcmQgbGluazoNCj4gaHR0cHM6Ly9zeXprYWxsZXIu
YXBwc3BvdC5jb20vYnVnP2V4dGlkPWIyY2ZkYWM5YWU1Mjc4ZDRiNjIxDQo+IGNvbXBpbGVyOiAg
ICAgICBEZWJpYW4gY2xhbmcgdmVyc2lvbiAxNS4wLjYsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZv
ciBEZWJpYW4pDQo+IDIuNDANCj4gc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFw
cHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTdmMDE1NjQ5ODAwMDANCj4gQyByZXByb2R1Y2VyOiAg
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTE0NDg0YWJhOTgwMDAw
DQo+IA0KPiBEb3dubG9hZGFibGUgYXNzZXRzOg0KPiBkaXNrIGltYWdlOiBodHRwczovL3N0b3Jh
Z2UuZ29vZ2xlYXBpcy5jb20vc3l6Ym90LQ0KPiBhc3NldHMvNDRmYjFkOGI1OTc4L2Rpc2stMGUx
OTgwYzQucmF3Lnh6DQo+IHZtbGludXg6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9z
eXpib3QtDQo+IGFzc2V0cy9hNjZjZTVjYWYwYjIvdm1saW51eC0wZTE5ODBjNC54eg0KPiBrZXJu
ZWwgaW1hZ2U6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3QtDQo+IGFzc2V0
cy84OTkyZmM4ZmUwNDYvYnpJbWFnZS0wZTE5ODBjNC54eg0KPiBtb3VudGVkIGluIHJlcHJvOiBo
dHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vc3l6Ym90LQ0KPiBhc3NldHMvODUzMDQ4MGQ2
NGZiL21vdW50XzAuZ3oNCj4gDQo+IFRoZSBpc3N1ZSB3YXMgYmlzZWN0ZWQgdG86DQo+IA0KPiBj
b21taXQgMzQ0YTFkODU3NWIwNTI5OGQwNzAyYTlmOTIzMWU1N2RiODZhODU1ZQ0KPiBBdXRob3I6
IFZpdmVrIEthc2lyZWRkeSA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gRGF0ZTogICBU
aHUgQXByIDExIDA2OjU5OjQyIDIwMjQgKzAwMDANCj4gDQo+ICAgICB1ZG1hYnVmOiBjb252ZXJ0
IHVkbWFidWYgZHJpdmVyIHRvIHVzZSBmb2xpb3MNCj4gDQo+IGJpc2VjdGlvbiBsb2c6ICBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2Jpc2VjdC50eHQ/eD0xNTNhNzAyNjk4MDAwMA0K
PiBmaW5hbCBvb3BzOiAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXBvcnQu
dHh0P3g9MTczYTcwMjY5ODAwMDANCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVy
LmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEzM2E3MDI2OTgwMDAwDQo+IA0KPiBJTVBPUlRBTlQ6
IGlmIHlvdSBmaXggdGhlIGlzc3VlLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRo
ZSBjb21taXQ6DQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrYjJjZmRhYzlhZTUyNzhkNGI2MjFAc3l6
a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQ0KPiBGaXhlczogMzQ0YTFkODU3NWIwICgidWRtYWJ1Zjog
Y29udmVydCB1ZG1hYnVmIGRyaXZlciB0byB1c2UgZm9saW9zIikNCj4gDQo+IFZGUzogQ2xvc2U6
IGZpbGUgY291bnQgaXMgMCAoZl9vcD1zaG1lbV9maWxlX29wZXJhdGlvbnMpDQo+IC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBrZXJuZWwgQlVHIGF0IGZzL29wZW4uYzox
NTE0IQ0KPiBPb3BzOiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIEtBU0FO
IFBUSQ0KPiBDUFU6IDEgUElEOiA1MDg5IENvbW06IHN5ei1leGVjdXRvcjMxNyBOb3QgdGFpbnRl
ZCA2LjEwLjAtcmMxLW5leHQtDQo+IDIwMjQwNTMxLXN5emthbGxlciAjMA0KPiBIYXJkd2FyZSBu
YW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwN
Cj4gQklPUyBHb29nbGUgMDQvMDIvMjAyNA0KPiBSSVA6IDAwMTA6ZmlscF9mbHVzaCsweDE1Mi8w
eDE2MCBmcy9vcGVuLmM6MTUxMg0KPiBDb2RlOiBlOSA4MCBlMSAwNyA4MCBjMSAwMyAzOCBjMSA3
YyBhNiA0OCA4OSBlZiBlOCBjNSAwMyBmMCBmZiBlYiA5YyBlOCA2ZSAxNiA4YQ0KPiBmZiA0OCBj
NyBjNyAyMCA1OSBkOCA4YiA0OCA4OSBlZSBlOCA2ZiA4NCA3ZCAwOSA5MCA8MGY+IDBiIDY2IDJl
IDBmIDFmIDg0IDAwIDAwDQo+IDAwIDAwIDAwIDY2IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkw
DQo+IFJTUDogMDAxODpmZmZmYzkwMDAzM2JmYzgwIEVGTEFHUzogMDAwMTAyNDYNCj4gUkFYOiAw
MDAwMDAwMDAwMDAwMDM4IFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IGZlMGQ5NjI1NWY3Y2Rj
MDANCj4gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA4MDAwMDAwMCBSREk6IDAw
MDAwMDAwMDAwMDAwMDANCj4gUkJQOiBmZmZmZmZmZjhiZDQyZGMwIFIwODogZmZmZmZmZmY4MTc2
YjEyOSBSMDk6IDFmZmZmOTIwMDA2NzdmMmMNCj4gUjEwOiBkZmZmZmMwMDAwMDAwMDAwIFIxMTog
ZmZmZmY1MjAwMDY3N2YyZCBSMTI6IGZmZmY4ODgwNzg0ZDk2ODANCj4gUjEzOiBkZmZmZmMwMDAw
MDAwMDAwIFIxNDogZmZmZjg4ODA3YWE3NjFjMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDkNCj4gRlM6
ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgwYjk1MDAwMDAoMDAwMCkNCj4ga25s
R1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQo+IENSMjogMDAwMDAwMDAzZjNiZTUzOCBDUjM6IDAwMDAwMDAwN2Yw
NjIwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwNmYwDQo+IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6
IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwDQo+IERSMzogMDAwMDAwMDAw
MDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IENh
bGwgVHJhY2U6DQo+ICA8VEFTSz4NCj4gIGZpbHBfY2xvc2UrMHgxZS8weDQwIGZzL29wZW4uYzox
NTMyDQo+ICBjbG9zZV9maWxlcyBmcy9maWxlLmM6NDM3IFtpbmxpbmVdDQo+ICBwdXRfZmlsZXNf
c3RydWN0KzB4MWI2LzB4MzYwIGZzL2ZpbGUuYzo0NTINCj4gIGRvX2V4aXQrMHhhMDgvMHgyOGUw
IGtlcm5lbC9leGl0LmM6ODY5DQo+ICBkb19ncm91cF9leGl0KzB4MjA3LzB4MmMwIGtlcm5lbC9l
eGl0LmM6MTAyMw0KPiAgX19kb19zeXNfZXhpdF9ncm91cCBrZXJuZWwvZXhpdC5jOjEwMzQgW2lu
bGluZV0NCj4gIF9fc2Vfc3lzX2V4aXRfZ3JvdXAga2VybmVsL2V4aXQuYzoxMDMyIFtpbmxpbmVd
DQo+ICBfX3g2NF9zeXNfZXhpdF9ncm91cCsweDNmLzB4NDAga2VybmVsL2V4aXQuYzoxMDMyDQo+
ICB4NjRfc3lzX2NhbGwrMHgyNmE4LzB4MjZiMA0KPiBhcmNoL3g4Ni9pbmNsdWRlL2dlbmVyYXRl
ZC9hc20vc3lzY2FsbHNfNjQuaDoyMzINCj4gIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5
L2NvbW1vbi5jOjUyIFtpbmxpbmVdDQo+ICBkb19zeXNjYWxsXzY0KzB4ZjMvMHgyMzAgYXJjaC94
ODYvZW50cnkvY29tbW9uLmM6ODMNCj4gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDc3LzB4N2YNCj4gUklQOiAwMDMzOjB4N2ZjMzI0ZTBmZDA5DQo+IENvZGU6IFVuYWJsZSB0byBh
Y2Nlc3Mgb3Bjb2RlIGJ5dGVzIGF0IDB4N2ZjMzI0ZTBmY2RmLg0KPiBSU1A6IDAwMmI6MDAwMDdm
ZmZlOWE3MTFiOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOg0KPiAwMDAwMDAwMDAwMDAwMGU3
DQo+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAw
N2ZjMzI0ZTBmZDA5DQo+IFJEWDogMDAwMDAwMDAwMDAwMDAzYyBSU0k6IDAwMDAwMDAwMDAwMDAw
ZTcgUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFJCUDogMDAwMDdmYzMyNGU4YjJkMCBSMDg6IGZm
ZmZmZmZmZmZmZmZmYjggUjA5OiAwMDAwNTU1NTgwYzIwNGMwDQo+IFIxMDogMDAwMDU1NTU4MGMy
MDRjMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwN2ZjMzI0ZThiMmQwDQo+IFIxMzog
MDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDA3ZmMzMjRlOGMwNDAgUjE1OiAwMDAwN2ZjMzI0ZGRk
ZjAwDQo+ICA8L1RBU0s+DQo+IE1vZHVsZXMgbGlua2VkIGluOg0KPiAtLS1bIGVuZCB0cmFjZSAw
MDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gUklQOiAwMDEwOmZpbHBfZmx1c2grMHgxNTIvMHgxNjAg
ZnMvb3Blbi5jOjE1MTINCj4gQ29kZTogZTkgODAgZTEgMDcgODAgYzEgMDMgMzggYzEgN2MgYTYg
NDggODkgZWYgZTggYzUgMDMgZjAgZmYgZWIgOWMgZTggNmUgMTYgOGENCj4gZmYgNDggYzcgYzcg
MjAgNTkgZDggOGIgNDggODkgZWUgZTggNmYgODQgN2QgMDkgOTAgPDBmPiAwYiA2NiAyZSAwZiAx
ZiA4NCAwMCAwMA0KPiAwMCAwMCAwMCA2NiA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MA0KPiBS
U1A6IDAwMTg6ZmZmZmM5MDAwMzNiZmM4MCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFJBWDogMDAwMDAw
MDAwMDAwMDAzOCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiBmZTBkOTYyNTVmN2NkYzAwDQo+
IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwODAwMDAwMDAgUkRJOiAwMDAwMDAw
MDAwMDAwMDAwDQo+IFJCUDogZmZmZmZmZmY4YmQ0MmRjMCBSMDg6IGZmZmZmZmZmODE3NmIxMjkg
UjA5OiAxZmZmZjkyMDAwNjc3ZjJjDQo+IFIxMDogZGZmZmZjMDAwMDAwMDAwMCBSMTE6IGZmZmZm
NTIwMDA2NzdmMmQgUjEyOiBmZmZmODg4MDc4NGQ5NjgwDQo+IFIxMzogZGZmZmZjMDAwMDAwMDAw
MCBSMTQ6IGZmZmY4ODgwN2FhNzYxYzAgUjE1OiAwMDAwMDAwMDAwMDAwMDA5DQo+IEZTOiAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MGI5NTAwMDAwKDAwMDApDQo+IGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANCj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KPiBDUjI6IDAwMDAwMDAwM2YzYmU1MzggQ1IzOiAwMDAwMDAwMDdmMDYyMDAw
IENSNDogMDAwMDAwMDAwMDM1MDZmMA0KPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAw
MDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAw
MDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiANCj4gDQo+
IC0tLQ0KPiBUaGlzIHJlcG9ydCBpcyBnZW5lcmF0ZWQgYnkgYSBib3QuIEl0IG1heSBjb250YWlu
IGVycm9ycy4NCj4gU2VlIGh0dHBzOi8vZ29vLmdsL3Rwc21FSiBmb3IgbW9yZSBpbmZvcm1hdGlv
biBhYm91dCBzeXpib3QuDQo+IHN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6
a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uDQo+IA0KPiBzeXpib3Qgd2lsbCBrZWVwIHRyYWNrIG9m
IHRoaXMgaXNzdWUuIFNlZToNCj4gaHR0cHM6Ly9nb28uZ2wvdHBzbUVKI3N0YXR1cyBmb3IgaG93
IHRvIGNvbW11bmljYXRlIHdpdGggc3l6Ym90Lg0KPiBGb3IgaW5mb3JtYXRpb24gYWJvdXQgYmlz
ZWN0aW9uIHByb2Nlc3Mgc2VlOiBodHRwczovL2dvby5nbC90cHNtRUojYmlzZWN0aW9uDQo+IA0K
PiBJZiB0aGUgcmVwb3J0IGlzIGFscmVhZHkgYWRkcmVzc2VkLCBsZXQgc3l6Ym90IGtub3cgYnkg
cmVwbHlpbmcgd2l0aDoNCj4gI3N5eiBmaXg6IGV4YWN0LWNvbW1pdC10aXRsZQ0KPiANCj4gSWYg
eW91IHdhbnQgc3l6Ym90IHRvIHJ1biB0aGUgcmVwcm9kdWNlciwgcmVwbHkgd2l0aDoNCj4gI3N5
eiB0ZXN0OiBnaXQ6Ly9yZXBvL2FkZHJlc3MuZ2l0IGJyYW5jaC1vci1jb21taXQtaGFzaA0KPiBJ
ZiB5b3UgYXR0YWNoIG9yIHBhc3RlIGEgZ2l0IHBhdGNoLCBzeXpib3Qgd2lsbCBhcHBseSBpdCBi
ZWZvcmUgdGVzdGluZy4NCj4gDQo+IElmIHlvdSB3YW50IHRvIG92ZXJ3cml0ZSByZXBvcnQncyBz
dWJzeXN0ZW1zLCByZXBseSB3aXRoOg0KPiAjc3l6IHNldCBzdWJzeXN0ZW1zOiBuZXctc3Vic3lz
dGVtDQo+IChTZWUgdGhlIGxpc3Qgb2Ygc3Vic3lzdGVtIG5hbWVzIG9uIHRoZSB3ZWIgZGFzaGJv
YXJkKQ0KPiANCj4gSWYgdGhlIHJlcG9ydCBpcyBhIGR1cGxpY2F0ZSBvZiBhbm90aGVyIG9uZSwg
cmVwbHkgd2l0aDoNCj4gI3N5eiBkdXA6IGV4YWN0LXN1YmplY3Qtb2YtYW5vdGhlci1yZXBvcnQN
Cj4gDQo+IElmIHlvdSB3YW50IHRvIHVuZG8gZGVkdXBsaWNhdGlvbiwgcmVwbHkgd2l0aDoNCj4g
I3N5eiB1bmR1cA0KDQojc3l6IHRlc3Q6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9W
aXZlay9kcm0tdGlwLmdpdCBzeXpib3RfZml4ZXMNCg==

