Return-Path: <linux-fsdevel+bounces-19386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3C8C455F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D51C21325
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E121104;
	Mon, 13 May 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I62n3SNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3F20DCB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619240; cv=fail; b=mHLv4oTLxX2cbC8DjVPRSjLIIdAzsfD2SyqC0/nKoDXAD2BgTkBUD4jJA4ZM3gBh+BRjLq6UlIRWjHSsMRa8F3QXFq169/GaF+OMoTdP5LMsSNeGlpQRM5c4/uNdXdOzNmJ3igas7Cp3A0MhS+IAae3S80vqHoKND74MwBHGS70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619240; c=relaxed/simple;
	bh=RdKuunlrirZnIOyjihWw/yPCVKi1VWTU4LHn0A+vfkU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ci4yiZinh/mCJhKemKO7kxPsgCGujLcud3pXDghy3QDWkQUIa2LMQVJ+C8mWoaYAG8WCdH2URHC4JZm/lkHN3bbaSCfNgSfd4Uouv3+NNAUuGGJ0EjppHg5T0jHS/0iQYdNsQ5PayqT8BqF3DTWLIFHCsAg5Rz/+uMrI+aCb/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I62n3SNU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715619238; x=1747155238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RdKuunlrirZnIOyjihWw/yPCVKi1VWTU4LHn0A+vfkU=;
  b=I62n3SNUr5QseLQjicF30XJziSAqIjWqJqdDyajTHmA64cJuC1rIuSN4
   c8Qeq5egvOU9zs60zID4kUtM2GcSc0k4FU0R5+9u0yeo3iGSW0bY2vk65
   RDfdLwxFtkNqw/Qn/U52fbYq+MT4hQAv6lGHfEf1ehQUYBrMLWdZVvv9u
   fOl848VnZ4A01NR8mWJEbrTS49xEYNpP5QVDqUoj7XIQfF0ZtSftOjCMx
   EgT3lBV3+e/ZOUrA6Mh4sU2H63itUQ11CkpQXv9jsHGDiWAzXDOVXa9jS
   Z4bTJRH7p/s5iiU/v/++8tOcm8ZwOhgElIHgR4nI9m9ZtD8UrErsJ03ti
   A==;
X-CSE-ConnectionGUID: WSaXKj3wR8i1UL/MNiQq/A==
X-CSE-MsgGUID: x0vpa1yeRkSW8pN1yt0a5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="15386446"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="15386446"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 09:53:57 -0700
X-CSE-ConnectionGUID: 2SUNUnfNQk21EeUNtRzB4A==
X-CSE-MsgGUID: bitLoKNpQvuQEtNSXlrzTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30431551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 09:53:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 09:53:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 09:53:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 09:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+cOAy/W6it3ziIxQbEMyJG9suLvuhTQNIF0sZxSZVoDf8Ym1frZl13o1mvm2sglqim5yCYqy3ggacOxMabwUzXy0JW8UMgNttGozFFhFikLEU/7xy4qioeVg1214oka8Y02cokp1dRm58LfuVhnAsLNA3e2ZSnLauIPekHS882voBM+4UH6Lxl5LWiA4fzzehVKZV/YcuCqxHH6pRX0gzOnbCT9lR/FZgD7MlK8mCPIZuh9cX6U0iGfiBPwXO1aWjyVriJLgp07ow2Lpu/cScpobkC4SXawc9JAQQSWYoQr3xPLiPBRsxCyL4LLN6oQORSDPQUrGO0UduiiY3nbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljbZjHpaMhbZxIq498tLNsct6nZXQApdsn2iaoQhHZc=;
 b=lwrAEpZwwMPxSojFGNjIjEfXUcwiOuHYGWKo4DiBPXVy96nvOc+cmSQFy2FcxFJtzVwjlEdwOlY3vtURu65RCrzX+7wt/mZ3prAU0nIr+Apha50QPV27nW9wdooHGhjcc/MyWPelpeadZkfFKcmvmejMNyKuBMWHsc3m87pUqTtV4S5vuj0eiX1cGePBbJQDxjHSEh+Pwc6SZ5aZlak6Dlb+FW9luV6WGiLIiKIHYQRWPMqQ7o6HrblQkcJCAXQ/CBd81bcCPcaUv/0ORBkwDL02N7L6/Fpc7dIY/dhdu44++0iduIV2KzdOHn8nJiRdJO794/cO3S+OO9NkkA8HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 16:53:24 +0000
Received: from CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550]) by CH3PR11MB8441.namprd11.prod.outlook.com
 ([fe80::bc66:f083:da56:8550%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 16:53:23 +0000
Message-ID: <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
Date: Mon, 13 May 2024 09:53:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20240512153606.1996-5-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To CH3PR11MB8441.namprd11.prod.outlook.com
 (2603:10b6:610:1bc::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8441:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: e13b3b31-d1de-4ab7-2412-08dc736d33bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDJSaXNxUkkvUlRXNUtyeGdGa3R5YlEyYWVoT2NqMjF0U0d1TVFKODJ6SlUv?=
 =?utf-8?B?dWFTcDFtbEhCMTZtQzBSQ3IwczRPbTZiMWEzYWljaDkvZlViMGVFcHR6TEp6?=
 =?utf-8?B?d0Z0UHBDZjB2VE9UOWg2OUk5anBuSStMSm53UzQ0Y1FtL1hVcTFkT3FrVFFQ?=
 =?utf-8?B?dXh3Z3hWOFJtRVpRSWV6Y1dmVjYxd3kzbkpjdUdNUGMzS3l4enlGL05qdC9V?=
 =?utf-8?B?aXZ4Vi85QkZHWTF0TlRCbHRRQmJuTFVaSzVocWJoVkJDUTlhcHZidERIWTNN?=
 =?utf-8?B?dG1NdzNkcCsrRGtLSHNsYzZSL0ladktaUEVqVmszRThzWEdiTUVleEhxZ1Uz?=
 =?utf-8?B?Y1EyNXdNb3I4Y29qbzRaM0Z4ZGlTMDV0eUdYNHNMQ2VTWmp1bEdZTmdjMFpK?=
 =?utf-8?B?dCtlbno2OUtyUk1WNXhZRitid2V4Z1JMUkpHcUpSZUFPMkNNcjdWR0QxNTVk?=
 =?utf-8?B?OGhSYVI0R3JmSjBuQ2FOeEJiRVh6cE11ZGdwTjEwNGlHdmpXZUFyYWtmc3FI?=
 =?utf-8?B?YXN6Z25HbjU5SDRPaG90dk5xUnB3TUR1Z0Vzdi9KWHZ4akVka3NRNHExSklS?=
 =?utf-8?B?K3dXTlg4YlN3bUdpWUdEelBteW4rZGJBYUdVdC9JM2lCa29GTEVxTU1NRDJU?=
 =?utf-8?B?eHAxL1M0L3E2M1hpUWJ0RWYyeGRsUGliSTNzcCtFL0FvL0E5WllRVVBHejVn?=
 =?utf-8?B?WHhIT1FNMUwrUFBDMit1ZDBUTU5VY0lNSDhqdmtlOXZ1MjcxL1krelpzREdD?=
 =?utf-8?B?TUZxY2hlUlQ5YnBWQ1hFWjlqUFBJQiswY2ZYNlYzVnAwdkZGaTNualBjM0Y2?=
 =?utf-8?B?UCs1aTY3ZVZ1OHVNMnRqQjlmaG1lT0czWDd0dENpc25JU0VUcjR1cFhXWlcr?=
 =?utf-8?B?RjdWeTNSZlhtRHhDNjY3a01wUjBDY2VzWmVmajlDa1JmYlVDVVFOR0o2ZzY1?=
 =?utf-8?B?VHJPeXpORnVqaWxjYW1lSlM4VlBNUktTSlZObDJpQzRZM0dXVEdIcE8zcFBW?=
 =?utf-8?B?dkRCVUUvSDlaaDB6MFVwTFZHNElJczRMQVJrOFFEanVlUFVpRThxNm9YY09Z?=
 =?utf-8?B?TXd2NURkRyt3eGo5cW5FN3FscXNUclZrTnpGSU9WK1N1c0trcS91d0xwdnMw?=
 =?utf-8?B?d3V4OWMramlZREs5U0V3L09CeE5ZK3lCTzVaK1JwZ09raDFMYnRNQk1ubkFy?=
 =?utf-8?B?a1c0NnB4bDdMQ0F5TWpYcHVTQzg2RXpJNSt4R0NGNnoyMmwvMjVueHZnNzNw?=
 =?utf-8?B?OVVzVjh6MTJKcE5McjlEeXcydzVwUE82N0JyT2h6dDN4UVZMaUZhWlZ0UzNr?=
 =?utf-8?B?dG4wdWF5dUhrQmtIMGpoRmpTaWx3Umx1SGZaOXlkb05pNWhWdGZ3cldFUGtl?=
 =?utf-8?B?ZTVqWW8wYTUxbHBqS21KSTdhMDV6anBzcEdxT2pKeVcyTDFWYnJIS0R6VzNX?=
 =?utf-8?B?Z0cxcnBFa24raTczbVpucDhGeUlQekMvNEVBWlpDbXg0Y2tha2Fta0pRR2RB?=
 =?utf-8?B?aklVZWFzNGo2RXltU3UrSVlxS1hTNERoNGhEY2Y4aGZLek41amdWYWJhdDFq?=
 =?utf-8?B?eEFMckIwSGZqM0tsdmFKZXhPM0tFWlVhV1N4a0poYjRCZE9GelJmeVhYMHFl?=
 =?utf-8?B?R040V052Uk4xeXZOSzlYTUVZbmJoVUNRSjRBV01xMVp6TTFLOUJpUXVPODFR?=
 =?utf-8?B?TkRBbW0rdVNnZXFFZzEyOXQ4K2NFRnRueXB6WXdUSG84SjNmRlhwalhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8441.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3djLzQ4ZTVWVkNhd2hLazQvcjFObDBzclBVNmdNdXoyTzVzR002eDhVUGYr?=
 =?utf-8?B?SWJpaFE3cU5lWkVtWnkzT2w4djc4MnJ0SkFxc2Foejh3d2djVU1kU285bkxy?=
 =?utf-8?B?OHQ0UzJjWW5QTmNvZDFGZitwb3VkQlR0NElGTk0vc1kyWHFrYWdMQ1ZIYmE0?=
 =?utf-8?B?blMwOEJUSVYyYW9oRWRFQ1VYTU1qYyt4YzRKK3JOckpOUm5rb3JmakRRUmNJ?=
 =?utf-8?B?VzZ3d1IzdloybThFS2RpRHhROWwwUEwrMXRYd3lvSm4wQTdUK29pSTJ0MUxK?=
 =?utf-8?B?NWVobmFnRU1wNVU1QXdrUGZ5SzBEaFFuK2tNb2x6S1AyUE5BYVB5ci9lOXpn?=
 =?utf-8?B?bGdJMkwyMU5ndHEwbkx4KzZ6Y2JMVElwWVZnWmN3T2xrMVVCaEN0eVZmL2Vl?=
 =?utf-8?B?UXBBTE52REJ0V05oV2xMZDRrTmwrcmErVTFnKzhnWUNmSU9EOUNJc092d2E0?=
 =?utf-8?B?b0tIV0V1cDZtcU90blZYaGpKeVBJNHBiR3hNY2swWkxLSHdyUVo1RmpjNU5s?=
 =?utf-8?B?UFdneGNyMXU0WllRek92SlQxUW1CK0NNR25VUUcwRCtlRmQ4NW1EZDVOaDdx?=
 =?utf-8?B?Q0gzbVpSVzlRb3FpNVNHUU40Nm5paUpPaUxmRHF1RzFwRnYzTDdkNzc0VWFD?=
 =?utf-8?B?WWVSbjcxWWhHeUxzam42S2tUbEpydmFLQm9oRE84ZndYaUNoaWJMZURuRDFM?=
 =?utf-8?B?VXcxa2k2NEhzRTkwS1RNb0JpWEJrMDQvUndNTmg3cDBEQ3NPeG5JdytXQzhh?=
 =?utf-8?B?R0dhLzBjVlhVWG9kQjAxWHRMMWpOeDkyZTVIOUZsRWdtVVNONVN3dEJnMmd3?=
 =?utf-8?B?dEpyS2xqdkdvQXRVdEM2eGQ3KzErNTlDczFWSVYrTjhIcURNdnZqMVpoVDh3?=
 =?utf-8?B?SHRNYjhyNmdCRHE1NzdLSDNBV2NFc3NScVZpdGVPcmRrQjJKNVRiYlk3SEs5?=
 =?utf-8?B?QnVmUkd5TTNYSXRrczF3YXJ3ZUNXaEhybVlKNmJsT2V6K1FOOFZDa2h6SmU4?=
 =?utf-8?B?bXZRb2FrS005R3oxY3dNTmJ6MmVHeGhaMno0Nk9TRk8rUWdDNzJPUEJ4Um1B?=
 =?utf-8?B?VCt5VFVZNEdRZktZQkNvazFsem1ubWk3T2NXRWU0SHZFTVVsRnhITG5UMXc1?=
 =?utf-8?B?UXFLQnN0RG5EZmtoc1ZQZ2ZhSks4NjlSSFJ4NVdXeXZRYmVYZTFzMmVWS2Q5?=
 =?utf-8?B?SHl1dGJsblpwMkgxQU4yRFZ5VHB4YUppeXB4dHl4QmY3dS9Fa05STVhsbTlK?=
 =?utf-8?B?c0tYeE5zRVR0bmE2aEg3ckpRa2YrOS96N3U1b3NuNHJ5U1B3WGd6TzNUV3hn?=
 =?utf-8?B?dGlGcVRSdVU5U01FbnNoeW9xK3ZRRFQ1QlRMVWwxYmtJOWlBd3AvQlNBSHRl?=
 =?utf-8?B?Z0YxeDJLNWhmdDVid3J1RkVVUEwvMmFQalBEUEwwVDRVWEFZUTRxWXZtd3Ru?=
 =?utf-8?B?aFFIdjlUMW5FUUVuSFA4TWV3QnJYVFBVc0drMXVCTWtUV1pBODVvYmx4V3Rn?=
 =?utf-8?B?R3d0cnF5ZDlMdlZjRTkrY3BGbVUwOVVCR1pFUzVJbmwyTmU4UEZTVWZsQkRj?=
 =?utf-8?B?MUMrWXNoc3VncnBIQi9tQXZ4SnFybzVpMmxBeVc2RGwrZkRQRTJ0R1pnell0?=
 =?utf-8?B?c3ZTR1dFNWtmU2o1dzNRQlBCMWUzMnBFMXNueVNBTVJEaTNnb2c4SGIzRDBs?=
 =?utf-8?B?bDVUUDVrSVRLVHA2Yzk2VEJ3M21SUks2bTNPbGFMVXBNRFRqeTdOM0FnaFdw?=
 =?utf-8?B?ZVIySjJuaGNWcFRJQVZTREcxTlF5N0dxVW5RZS96bS85aW5ReGI2amg3MThJ?=
 =?utf-8?B?Qmc4NWtXdTg0SDgwTFUxenRCNCtDdlh2bW1VaW9TUC81R2FqN2JKa2Nybldy?=
 =?utf-8?B?WHcvbFZub2JvSWx0dmxPenZ2WWFmelZCQTFLaDNSM0gyVldpaFEzWDVOS1Fx?=
 =?utf-8?B?dXpqMlg3RDBJWWhwYmgvaEdFdXg5Nko3VElrelE1dGUra3dUaWdjYzhGU2ps?=
 =?utf-8?B?bVVlR1NUQ3dOR1AxcHVZVXZFMUUwMGxsU0hKRUw3RmMwc21LaERNYkYyN09D?=
 =?utf-8?B?TlhVR3hLYzZ2ejlvZDB4SVBsd3B4YU1YV3FrajlqRHhwcWJnWnprc2JtVG1o?=
 =?utf-8?B?TURjY1RBem8wV1hLdS8rajJmWWEzbVluYlUvV3VaV3h4Y1NQa3RIKzlObjMr?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e13b3b31-d1de-4ab7-2412-08dc736d33bb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8441.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 16:53:23.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZV0xxuv1lSHtExFNvhYsSAuNIKHcxUp1njioyegWT187lm+LOZeLad8HEE39sGjuJfo1CvjImUlhbmRFyDeOZg8HVEYcN2pS+M0zYlNdtzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com

On 5/12/2024 08:36, Michal Wajdeczko wrote:
> We already provide the content of the GuC log in debugsfs, but it
> is in a text format where each log dword is printed as hexadecimal
> number, which does not scale well with large GuC log buffers.
>
> To allow more efficient access to the GuC log, which could benefit
> our CI systems, expose raw binary log data.  In addition to less
> overhead in preparing text based GuC log file, the new GuC log file
> in binary format is also almost 3x smaller.
>
> Any existing script that expects the GuC log buffer in text format
> can use command like below to convert from new binary format:
>
> 	hexdump -e '4/4 "0x%08x " "\n"'
>
> but this shouldn't be the case as most decoders expect GuC log data
> in binary format.
I strongly disagree with this.

Efficiency and file size is not an issue when accessing the GuC log via 
debugfs on actual hardware. It is an issue when dumping via dmesg but 
you definitely should not be dumping binary data to dmesg. Whereas, 
dumping in binary data is much more dangerous and liable to corruption 
because some tool along the way tries to convert to ASCII, or truncates 
at the first zero, etc. We request GuC logs be sent by end users, 
customer bug reports, etc. all doing things that we have no control over.

Converting the hexdump back to binary is trivial for those tools which 
require it. If you follow the acquisition and decoding instructions on 
the wiki page then it is all done for you automatically.

These patches are trying to solve a problem which does not exist and are 
going to make working with GuC logs harder and more error prone.

On the other hand, there are many other issues with GuC logs that it 
would be useful to solves - including extra meta data, reliable output 
via dmesg, continuous streaming, pre-sizing the debugfs file to not have 
to generate it ~12 times for a single read, etc.

Hmm. Actually, is this interface allowing the filesystem layers to issue 
multiple read calls to read the buffer out in small chunks? That is also 
going to break things. If the GuC is still writing to the log as the 
user is reading from it, there is the opportunity for each chunk to not 
follow on from the previous chunk because the data has just been 
overwritten. This is already a problem at the moment that causes issues 
when decoding the logs, even with an almost atomic copy of the log into 
a temporary buffer before reading it out. Doing the read in separate 
chunks is only going to make that problem even worse.

John.

> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> ---
> Cc: linux-fsdevel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>   drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> index d3822cbea273..53fea952344d 100644
> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
> @@ -8,6 +8,7 @@
>   #include <drm/drm_debugfs.h>
>   #include <drm/drm_managed.h>
>   
> +#include "xe_bo.h"
>   #include "xe_device.h"
>   #include "xe_gt.h"
>   #include "xe_guc.h"
> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>   	{"guc_log", guc_log, 0},
>   };
>   
> +static ssize_t guc_log_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
> +{
> +	struct dentry *dent = file_dentry(file);
> +	struct dentry *uc_dent = dent->d_parent;
> +	struct dentry *gt_dent = uc_dent->d_parent;
> +	struct xe_gt *gt = gt_dent->d_inode->i_private;
> +	struct xe_guc_log *log = &gt->uc.guc.log;
> +	struct xe_device *xe = gt_to_xe(gt);
> +	ssize_t ret;
> +
> +	xe_pm_runtime_get(xe);
> +	ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap, log->bo->size);
> +	xe_pm_runtime_put(xe);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations guc_log_ops = {
> +	.owner		= THIS_MODULE,
> +	.read		= guc_log_read,
> +	.llseek		= default_llseek,
> +};
> +
>   void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>   {
>   	struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>   	drm_debugfs_create_files(local,
>   				 ARRAY_SIZE(debugfs_list),
>   				 parent, minor);
> +
> +	debugfs_create_file("guc_log_raw", 0600, parent, NULL, &guc_log_ops);
>   }


