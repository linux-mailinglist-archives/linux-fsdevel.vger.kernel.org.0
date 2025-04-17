Return-Path: <linux-fsdevel+bounces-46614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CDA91660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA719E1441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126A22E015;
	Thu, 17 Apr 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxuNhqlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A91E32C6;
	Thu, 17 Apr 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878253; cv=fail; b=RxcXljIZBuHTuYO2BWYblZT1hmBspFHAwUEgKrt791szEYuuu8YVKlpxD4Pwf+/1wFig2jKhiidEi6StbNlk8ZK+vMmkZOtynzIdCR5QjUNY/VHD9JujDHDEz07inSwU6dVRllLsZ2fM8/gXm0hKeYS40Ezt78WDqSeY5vMCuJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878253; c=relaxed/simple;
	bh=mTnkqluN3rP2+6zxrsBeevcYqlFGjyhqOOdUNRbKVdc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YxJL8jEUJ+COPCl8Tnejx2OlCGlmy8UxI5xBOLaN6HNj5+ri4p2bSMPhbLe+4fRfUvBckxTYZMdhJjMkgxLXkGmBt6HkhUxkvVZpVB/2pq2TyKIaPwU4x/nQom7s9WMKK0Xpmqj4+Y8HN77XOtP0DNor//EklEfzox+fvn3bRas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxuNhqlG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744878250; x=1776414250;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=mTnkqluN3rP2+6zxrsBeevcYqlFGjyhqOOdUNRbKVdc=;
  b=dxuNhqlG+M6aZygplXNTaYAVDqUfdQOoKxWcSroqelC0IY8kGb5FKjmx
   /oDuu9ADkMiJtgzSiEqBtMNXZMJ0Hz+P1xR+LE3LZp0lr+MSqMSqlambk
   CyJoD4sePLkao0IaFUOq8s1cqYOCCyDL+n4LDa/1eNYE27GSeiDiRHDhl
   vpLw3rBrCAHfQ0ocsnBWVem8gx3ok12UMGUV6R3FbvMRgPIBhkYtKqT7D
   lMi8w5iX958DLbk75eW5Bbu8P0ghIDgHg9mqXFQ1qnUl4ymQLmeYRE730
   SqcCvEYib18HlnIRXwncqD3fVNnMiPkRDDgGwSTfB0AhqzgCb9nMCQosv
   A==;
X-CSE-ConnectionGUID: w4E2/uA2R0mDTnL2fMPXFw==
X-CSE-MsgGUID: FJAuxFy+RVKOuR6xf7shfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50276717"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="50276717"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:24:09 -0700
X-CSE-ConnectionGUID: 4F/eZY6yTSKW+oVnU5TC/g==
X-CSE-MsgGUID: npEOeO+QQ32gcsYZV7MqhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="134833843"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:24:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 01:24:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 01:24:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 01:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stin7vcKublrjxikVFHnvBBcwvJxJ7KYH7Xuk1kmk9gd91oh7STwEuMm80siOJwKXJUJD12k1hlKnNUNcXyCe7+38jZdOGRgxQ2mmDK0fonNneIqOReKGxMDlzhLKzrJPHVjFPE4JZ7wL1SjFwNsr38kzWk/2QuaE0r8RqGrKK5iBj6WCxHYnPMF1NL1HjZAQBxKraouBra+01F6tPaqjPdaObsghLmJM5vtZ4qhyjax8Xm2Qx1pq+/nYOEsrQUCsiBvhrtRVC7RyenBiQfj0So/e6lJrw5ouxpZf4Jy2T5EeuhlRSmDh340KKJ02R3FGScW8udGfQEPTsJD1jo3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+N6XfjvoR29UluiaDfDVHuGpsroewtReyvLqozLXkY=;
 b=JH+gHZXY0RfMClZ1CezyqJY0IyXg9Kh0WAPV0Tf0ynJlIKi2o26w7UzR9CrU4HPz8XpsYI813bjwyR1OASW5MCAxciAIfOoZ7tRS7Ce+2iP3KUNlgTUkAaUwoLtOsYfl5YxntUByz9EJ9RE02Srql+HVshJhP/xp5n2/cW7JaNXb4j00t+LJz7WKFUB2q0yjJBiaDjjSO0Ckz6nv+bfheq8mQVtu4HlHvo44hcJtUpKHbCy65fmo4A+Thz7F45Q2gTKCHQT3QtSS6/6AO2vhZW3eE9RmJOjrhCACI5GNZAJhpal6iZnh56QBjyGqz0C1Pz2YmbOoFJzOMp540Krmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 08:23:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 08:23:46 +0000
Date: Thu, 17 Apr 2025 16:23:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  a914bd93f3: stress-ng.close.close_calls_per_sec
 52.2% regression
Message-ID: <202504171513.6d6f8a16-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: b56b3e6b-a4d1-4107-09cd-08dd7d892c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?A5SmnNJK7IenCf5jravJz684eXAC1RldycT8GRKMt8pgpllM7v8NoZ2EKN?=
 =?iso-8859-1?Q?Y3F/RVoh3/g816HKqVv8j6pl54yuHIC7ipuybDDmkrdKz4HDPR0Gte9y5v?=
 =?iso-8859-1?Q?SWSyMQWvLBLJyIGVMWLbWJDoHPNgWqjy9WCnVcHD3FLfsbLiZI4UncPol1?=
 =?iso-8859-1?Q?p3w7Bd2K+tnXt4mF85C1oxYZMCvzJq0I+iabKiMrv698PfMnqi4RuZ719N?=
 =?iso-8859-1?Q?nTsWeruz7zkKrYzPG23npNWOy8QnNT2N4Y9MHp01GRFkgra3989idWtyLO?=
 =?iso-8859-1?Q?7AZQTWioz6lFX4j4e0Tw7DgTaGUiNTSz5OVY2S+5rrUIf1z5PdT9zk7XNe?=
 =?iso-8859-1?Q?lVmno9OWrOvAByg2rtZG9dvi/7N87InvFBeCrNn+IYVP21iBzxcRIy+mvu?=
 =?iso-8859-1?Q?s6qODCjNA9x5WGXeXvNclME9MMW/IQeNUTfnoiCM9HWZyzrVXAtDqw7P15?=
 =?iso-8859-1?Q?OfN9kIoaLIWybg62bcL0bZ9zrgckoT70I/+rk/afsbh6HOCXnsrb5OocQi?=
 =?iso-8859-1?Q?E7CnQXPIAXyEdamiQRrmpCXzmjq1AuMGcJV8HSRJPtZ9ySH8JoxcGrNsN8?=
 =?iso-8859-1?Q?9smxKkEY1DjSSD45FjgjJGTU+H1/NWr+q6zOE8SvNeqvIzzaPzWPIme5cx?=
 =?iso-8859-1?Q?C7xFck0wQqqunGFzoeAY2sOS/IYTCwkjksc7jHsiRzqcYaJU76DSmjM0fB?=
 =?iso-8859-1?Q?rO292W6fu4pY+BwJQb6VHRbURjkrrgB1w1gP+AFldRZjV25jReplvy7jKD?=
 =?iso-8859-1?Q?pT1EYIU6Q+IZHZ+WkcEqhadIHZdo/RlczXMiTEel2s+zcUCbgs1vky3B1v?=
 =?iso-8859-1?Q?zkMq65WU966TnriOPpCMJ5Hwf/6DhZXUssnrWk3JzJrW2/1cn4MjCEiOTE?=
 =?iso-8859-1?Q?FiEc62+z9HGcnI+lbMW8NsfrwyxNYjor6zFMZ/jABf9kLGQX90oqw3yASD?=
 =?iso-8859-1?Q?P+21+jbLJKIj8t0TfCWW7Ui6AtqkJM7Y/b1N0jNMfyRmuRIz1ksyJzoPk2?=
 =?iso-8859-1?Q?mvuR/bOumhqi+Jc95CVeLG6WR6ZZXKNSW6maYPq1P2n+b1ETTaMVfoviIb?=
 =?iso-8859-1?Q?aylN6O8EoWL1NhC7zxfWITPB3sM9Mdcj81zPgtixdP3FVWuWL96BJWOavs?=
 =?iso-8859-1?Q?jwGMAVyO7N49nr0fPmOw3O4QXPXmux5S2WjAvbuOqEh6vJlAd9eEHk3LtS?=
 =?iso-8859-1?Q?ttwbYJZhk6s3N4/rwZfJ1KL8kqq2bDGxqjmSSDAcRBCFLlBFP6hSF2MbcH?=
 =?iso-8859-1?Q?8kPNbZECGZsxnSTwMDuZ71+YFNEu7gAl8KXo88oQExpGFDyGZcoiQsFJXq?=
 =?iso-8859-1?Q?x4DliMaMheB9Qy+q7SXNIVaJPJlFLP/1BIgFXzZXfRCV+eqeFyrt5T+Bhd?=
 =?iso-8859-1?Q?nTSJvuSnXOwWzbNf8RCX7YFjR+sAZWg4JgegUqOXzjrqItgCaPwUiCVRrN?=
 =?iso-8859-1?Q?R9Jf68zthASFbly2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?l3Firr6SG8Zy/ShiioEmxHbpGbyOFmgINWd6GrZX4kWV2COPxuzJhjJTdr?=
 =?iso-8859-1?Q?xwPNSMwsU8xOtxEoOkZ6IRlEIIxPgjIr1QKZD0GtQXgXdGzYVs314LIOOg?=
 =?iso-8859-1?Q?a8TuUHFbbY7WsU+WOZLgSq9GSiWnU6KRu4lZuhhNfbYMEQb7/egzBvlomH?=
 =?iso-8859-1?Q?7eiISvaI3P4XYf8/iYAEEdFHsf7r+3V/6iwig8yPaTC9MYq1Ff2h6ojsrr?=
 =?iso-8859-1?Q?HrDDgCHXRoSboIxAUPuS1343dDR8hyp7bfX3hzWhIAW2JRsyeziuiKFCzo?=
 =?iso-8859-1?Q?d6lggQ4ylrxHp2PwRLeIlNco0gnr4aZhYKusKtdY0lO0FugIO6fESdAZ0W?=
 =?iso-8859-1?Q?9RBVcwZHpcNN80T4B5If3wcvU8jFt29lZ0Td1rNjjBJ5qttax2gmk8FcUz?=
 =?iso-8859-1?Q?rKDiBmKvWcBrh8wrcBKdzYsni2ZGTSADRjbM/IsYOS8EK/H/k2gMaQE+id?=
 =?iso-8859-1?Q?ZKAa5fsE9TCPhkNKcF+tEuSvis814iNaGNf5yiJ/WzyC6nhdvtBzpHWY8I?=
 =?iso-8859-1?Q?hQnjeCeRCOOuwtmSRAFA8/GTqQ3XhUdAQW1O0g1oXhNO41/Zmiwe0C5uoG?=
 =?iso-8859-1?Q?ATl8QgND68Qh7c6zXDaNjiW1PHGw5otQyCke572ppIDPMaoDtK9xfznGSZ?=
 =?iso-8859-1?Q?iRSxNbSGJjECmiDwwYlJdoLsEFHezIZC4TUdlK22oV/jW2Uk1qh2kW9B3N?=
 =?iso-8859-1?Q?a47/yj/KCQ6xjNybtQdajVoMMMWO/LI/40Rp//tTKiKWaj8idcmppCL6V0?=
 =?iso-8859-1?Q?4G+M1YZuiFaR38z1WNUceu2ZFGtrDp8qjbCKygkCx50CkpWOg4SZAYZE+W?=
 =?iso-8859-1?Q?eR8Or2GY/glUhxDqtlVah4AqmlkKlHcmGh9ZqwO6Eun/c9sGi29EnaEpAl?=
 =?iso-8859-1?Q?VtCn5/xqWDihNCy4Gzx801XK8WpgMctWY9ib77inHeaDfSIoTDYKBODD1Y?=
 =?iso-8859-1?Q?k6FswQCuIIudFXgpGfMFvPXOhbi86OtJll2ylBkFGvFMeG7FYZ1KnSmtoS?=
 =?iso-8859-1?Q?iquM9+AEmpmCvoNRnR58vdFflwuwvDblUkPC0hXLYAXVdMvPLLLX3Iu/3Z?=
 =?iso-8859-1?Q?LFWt4ty45oeVO2eppyhpCvaXVUXc9nMm1FAnWViRL/DOQh2reYJkbvAHPQ?=
 =?iso-8859-1?Q?ET6D/oRIrVO9xgsTIcUucS6/m7Aw678ohCZc4c8YUAA3LPi0A3EyqBok2B?=
 =?iso-8859-1?Q?L4pXdidM14JH7VYNYTSI6KsLA7+B4Lg2RcbF9xeOWiUn14TKoFl/2wapUR?=
 =?iso-8859-1?Q?90+VCKh6iy+ArwV923Rb7WHn5pAHjtjIM9Xsh5M+jnapmEeWTbd94rb6L5?=
 =?iso-8859-1?Q?owKTzl0raqqaEo3zAgsFNOpnTejGI0KB1hq+KD0dHxMY1TP+O/YSciAWce?=
 =?iso-8859-1?Q?Aqm5J/1TYtOXkFyxiie5Gu9ugNbqRwkBkpDMf+bnSiYwCR4lMx51JysTgw?=
 =?iso-8859-1?Q?UQRX4WIrk4xIvAE3PJ/rcVFA4kLH/+WvmrA8XwLKMqe+toaJtfKLhkZsHY?=
 =?iso-8859-1?Q?Xj0XFhOsonbrQCx62SUmoDloI49bW+cZnByjxuyBeB2Vnw0cGfyrqOC8Fx?=
 =?iso-8859-1?Q?sKdxDtXVRSoKhEI4Q5vkmrI3Inv/7UZBDWu8TOyksqI9ZVfpSyMURuLhHI?=
 =?iso-8859-1?Q?qCv1UFSO7T1BFFyPqMRBbFYog2En12qGdN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b56b3e6b-a4d1-4107-09cd-08dd7d892c2e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:23:46.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srKI2cgeZ3gjjIhL0hq6d7v+qi+Hu31NLo9LYSbGpL3xBG0fhvAbVvgfsryg5H6zzldGAE39QlKcOk4v7kuiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 52.2% regression of stress-ng.close.close_calls_per_sec on:


commit: a914bd93f3edfedcdd59deb615e8dd1b3643cac5 ("fs: use fput_close() in filp_close()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      7cdabafc001202de9984f22c973305f424e0a8b7]
[still regression on linux-next/master 01c6df60d5d4ae00cd5c1648818744838bba7763]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: close
	cpufreq_governor: performance


the data is not very stable, but the regression trend seems clear.

a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json:  "stress-ng.close.close_calls_per_sec": [
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    193538.65,
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    232133.85,
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    276146.66,
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    193345.38,
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    209411.34,
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    254782.41
a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-  ],

3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json:  "stress-ng.close.close_calls_per_sec": [
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    427893.13,
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    456267.6,
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    509121.02,
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    544289.08,
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    354004.06,
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    552310.73
3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-  ],


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504171513.6d6f8a16-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250417/202504171513.6d6f8a16-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp1/close/stress-ng/60s

commit: 
  3e46a92a27 ("fs: use fput_close_sync() in close()")
  a914bd93f3 ("fs: use fput_close() in filp_close()")

3e46a92a27c2927f a914bd93f3edfedcdd59deb615e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    355470 ± 14%     -17.6%     292767 ±  7%  cpuidle..usage
      5.19            -0.6        4.61 ±  3%  mpstat.cpu.all.usr%
    495615 ±  7%     -38.5%     304839 ±  8%  vmstat.system.cs
    780096 ±  5%     -23.5%     596446 ±  3%  vmstat.system.in
   2512168 ± 17%     -45.8%    1361659 ± 71%  sched_debug.cfs_rq:/.avg_vruntime.min
   2512168 ± 17%     -45.8%    1361659 ± 71%  sched_debug.cfs_rq:/.min_vruntime.min
    700402 ±  2%     +19.8%     838744 ± 10%  sched_debug.cpu.avg_idle.avg
     81230 ±  6%     -59.6%      32788 ± 69%  sched_debug.cpu.nr_switches.avg
     27992 ± 20%     -70.2%       8345 ± 74%  sched_debug.cpu.nr_switches.min
    473980 ± 14%     -52.2%     226559 ± 13%  stress-ng.close.close_calls_per_sec
   4004843 ±  8%     -21.1%    3161813 ±  8%  stress-ng.time.involuntary_context_switches
      9475            +1.1%       9582        stress-ng.time.system_time
    183.50 ±  2%     -37.8%     114.20 ±  3%  stress-ng.time.user_time
  25637892 ±  6%     -42.6%   14725385 ±  9%  stress-ng.time.voluntary_context_switches
     23.01 ±  2%      -1.4       21.61 ±  3%  perf-stat.i.cache-miss-rate%
  17981659           -10.8%   16035508 ±  4%  perf-stat.i.cache-misses
  77288888 ±  2%      -6.5%   72260357 ±  4%  perf-stat.i.cache-references
    504949 ±  6%     -38.1%     312536 ±  8%  perf-stat.i.context-switches
     33030           +15.7%      38205 ±  4%  perf-stat.i.cycles-between-cache-misses
      4.34 ± 10%     -38.3%       2.68 ± 20%  perf-stat.i.metric.K/sec
     26229 ± 44%     +37.8%      36145 ±  4%  perf-stat.overall.cycles-between-cache-misses
     30.09           -12.8       17.32        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.32            -9.3        0.00        perf-profile.calltrace.cycles-pp.fput.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.15            -5.9       35.26        perf-profile.calltrace.cycles-pp.__dup2
     41.02            -5.9       35.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
     41.03            -5.8       35.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__dup2
     13.86            -5.5        8.35        perf-profile.calltrace.cycles-pp.filp_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
     40.21            -5.5       34.71        perf-profile.calltrace.cycles-pp.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
     38.01            -4.9       33.10        perf-profile.calltrace.cycles-pp.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
      4.90 ±  2%      -1.9        2.96 ±  3%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      2.63 ±  9%      -1.9        0.76 ± 18%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      4.44            -1.7        2.76 ±  2%  perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.__do_sys_close_range.do_syscall_64
      2.50 ±  2%      -0.9        1.56 ±  3%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.do_dup2.__x64_sys_dup2
      2.22            -0.8        1.42 ±  2%  perf-profile.calltrace.cycles-pp.dnotify_flush.filp_flush.filp_close.do_dup2.__x64_sys_dup2
      1.66 ±  5%      -0.3        1.37 ±  5%  perf-profile.calltrace.cycles-pp.ksys_dup3.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
      1.60 ±  5%      -0.3        1.32 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ksys_dup3.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ±  2%      +0.0        0.62 ±  2%  perf-profile.calltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.54 ±  2%      +0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      0.72 ±  4%      +0.1        0.79 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.8        1.79 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.fput_close.filp_close.__do_sys_close_range.do_syscall_64
     19.11            +4.4       23.49        perf-profile.calltrace.cycles-pp.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.94            +6.5       47.46        perf-profile.calltrace.cycles-pp.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     42.24            +6.6       48.79        perf-profile.calltrace.cycles-pp.syscall
     42.14            +6.6       48.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     42.14            +6.6       48.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     41.86            +6.6       48.46        perf-profile.calltrace.cycles-pp.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00           +14.6       14.60 ±  2%  perf-profile.calltrace.cycles-pp.fput_close.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
      0.00           +29.0       28.95 ±  2%  perf-profile.calltrace.cycles-pp.fput_close.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.76           -19.0       26.72        perf-profile.children.cycles-pp.filp_flush
     14.67           -14.7        0.00        perf-profile.children.cycles-pp.fput
     41.20            -5.9       35.30        perf-profile.children.cycles-pp.__dup2
     40.21            -5.5       34.71        perf-profile.children.cycles-pp.__x64_sys_dup2
     38.53            -5.2       33.33        perf-profile.children.cycles-pp.do_dup2
      7.81 ±  2%      -3.1        4.74 ±  3%  perf-profile.children.cycles-pp.locks_remove_posix
      7.03            -2.6        4.40 ±  2%  perf-profile.children.cycles-pp.dnotify_flush
      1.24 ±  3%      -0.4        0.86 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.67 ±  5%      -0.3        1.37 ±  5%  perf-profile.children.cycles-pp.ksys_dup3
      0.29            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.10 ± 10%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.17 ±  7%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.15 ±  3%      -0.0        0.10 ± 18%  perf-profile.children.cycles-pp.clockevents_program_event
      0.06 ± 11%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.stress_close_func
      0.13 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.06 ±  7%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      0.26 ±  2%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.08 ±  4%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.set_pte_range
      0.45 ±  2%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.zap_present_ptes
      0.18 ±  3%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.folios_put_refs
      0.29 ±  3%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.29 ±  3%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.34 ±  4%      +0.0        0.38 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.24 ±  3%      +0.0        0.27 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.73 ±  2%      +0.0        0.78 ±  2%  perf-profile.children.cycles-pp.do_read_fault
      0.69 ±  2%      +0.0        0.74 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
     42.26            +6.5       48.80        perf-profile.children.cycles-pp.syscall
     41.86            +6.6       48.46        perf-profile.children.cycles-pp.__do_sys_close_range
     60.05           +10.9       70.95        perf-profile.children.cycles-pp.filp_close
      0.00           +44.5       44.55 ±  2%  perf-profile.children.cycles-pp.fput_close
     14.31 ±  2%     -14.3        0.00        perf-profile.self.cycles-pp.fput
     30.12 ±  2%     -13.0       17.09        perf-profile.self.cycles-pp.filp_flush
     19.17 ±  2%      -9.5        9.68 ±  3%  perf-profile.self.cycles-pp.do_dup2
      7.63 ±  3%      -3.0        4.62 ±  4%  perf-profile.self.cycles-pp.locks_remove_posix
      6.86 ±  3%      -2.6        4.28 ±  3%  perf-profile.self.cycles-pp.dnotify_flush
      0.64 ±  4%      -0.4        0.26 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.22 ± 10%      -0.1        0.15 ± 11%  perf-profile.self.cycles-pp.x64_sys_call
      0.23 ±  3%      -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.pick_eevdf
      0.06 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.13 ±  7%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.__switch_to
      0.09 ±  8%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.08 ±  9%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.filemap_map_pages
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.folios_put_refs
      0.25 ±  2%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.17 ±  5%      +0.0        0.20 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.do_nanosleep
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.filp_close
      0.00           +43.9       43.86 ±  2%  perf-profile.self.cycles-pp.fput_close
      2.12 ± 47%    +151.1%       5.32 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.28 ± 60%    +990.5%       3.08 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
      0.96 ± 28%     +35.5%       1.30 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.exec_binprm
      2.56 ± 43%    +964.0%      27.27 ±161%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     12.80 ±139%    +366.1%      59.66 ±107%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      2.78 ± 25%     +50.0%       4.17 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_cursor.dcache_dir_open
      0.78 ± 18%     +39.3%       1.09 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_shrink
      2.63 ± 10%     +16.7%       3.07 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.04 ±223%   +3483.1%       1.38 ± 67%  perf-sched.sch_delay.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.72 ± 17%     +42.5%       1.02 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.35 ±134%    +457.7%       1.94 ± 61%  perf-sched.sch_delay.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      1.88 ± 34%    +574.9%      12.69 ±115%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.41 ± 10%     +18.0%       2.84 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.85 ± 36%    +155.6%       4.73 ± 50%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
     28.94 ± 26%     -52.4%      13.78 ± 36%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.24 ±  9%     +22.1%       2.74 ±  8%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      2.19 ±  7%     +17.3%       2.57 ±  6%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_link_file
      2.39 ±  6%     +16.4%       2.79 ±  9%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.34 ± 77%   +1931.5%       6.95 ± 99%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eventfd2.do_syscall_64
     29.69 ± 28%    +129.5%      68.12 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      1.48 ± 96%    +284.6%       5.68 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.copy_strings_kernel.kernel_execve.call_usermodehelper_exec_async.ret_from_fork
      3.59 ± 57%    +124.5%       8.06 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.mmap_read_lock_maybe_expand.get_arg_page.copy_string_kernel
      3.39 ± 91%    +112.0%       7.19 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
     22.16 ± 77%    +117.4%      48.17 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      8.72 ± 17%    +358.5%      39.98 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__mmap_new_vma
      0.04 ±223%   +3484.4%       1.38 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.53 ±154%    +676.1%       4.12 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     25.76 ± 70%   +9588.9%       2496 ±127%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.53 ± 26%     -58.8%      21.22 ±106%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.97 ± 48%    +154.8%      12.66 ± 75%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      4.36 ± 48%    +147.7%      10.81 ± 29%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    108632 ±  4%     +23.9%     134575 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    572.67 ±  6%     +37.3%     786.17 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    596.67 ± 12%     +43.9%     858.50 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec.__request_module
    294.83 ±  9%     +31.1%     386.50 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
   1223275 ±  2%     -17.7%    1006293 ±  6%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2772 ± 11%     +43.6%       3980 ± 11%  perf-sched.wait_and_delay.count.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
     11690 ±  7%     +29.8%      15173 ± 10%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      4072 ±100%    +163.7%      10737 ±  7%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      8811 ±  6%     +26.2%      11117 ±  9%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    662.17 ± 29%    +187.8%       1905 ± 29%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     15.50 ± 11%     +48.4%      23.00 ± 16%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    167.67 ± 20%     +48.0%     248.17 ± 26%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      2680 ± 12%     +42.5%       3820 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down_timeout.down_timeout
    137.17 ± 13%     +31.8%     180.83 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      2636 ± 12%     +43.1%       3772 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
     10.50 ± 11%     +74.6%      18.33 ± 23%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      5619 ±  5%     +38.8%       7797 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     70455 ±  4%     +32.3%      93197 ±  6%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6990 ±  4%     +37.4%       9603 ±  9%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    191.28 ±124%   +1455.2%       2974 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      2.24 ± 48%    +144.6%       5.48 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8.06 ±101%    +618.7%      57.94 ± 68%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±146%    +370.9%       1.30 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      3.86 ±  5%     +86.0%       7.18 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      2.54 ± 29%     +51.6%       3.85 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11 ± 39%    +201.6%       3.36 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      3.60 ± 68%   +1630.2%      62.29 ±153%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.20 ± 64%    +115.4%       0.42 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.exec_binprm
     55.51 ± 53%    +218.0%     176.54 ± 83%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      3.22 ±  3%     +15.4%       3.72 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.04 ±223%  +37562.8%      14.50 ±198%  perf-sched.wait_time.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      1.19 ± 30%     +59.3%       1.90 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.36 ±133%    +447.8%       1.97 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
      1.73 ± 47%    +165.0%       4.58 ± 51%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
      1.10 ± 21%    +693.9%       8.70 ± 70%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     54.56 ± 32%    +400.2%     272.90 ± 67%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     10.87 ± 18%    +151.7%      27.36 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
    123.35 ±181%   +1219.3%       1627 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.68 ±108%   +5490.2%     541.19 ±185%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.do_epoll_create.__x64_sys_epoll_create.do_syscall_64
      3.39 ± 91%    +112.0%       7.19 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
      1.12 ±128%    +407.4%       5.67 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     30.58 ± 29%   +1741.1%     563.04 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      3.82 ±114%    +232.1%      12.70 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.__mmap_prepare.__mmap_region
      7.75 ± 46%     +72.4%      13.36 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.39 ± 48%    +259.7%      48.17 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     12.46 ± 30%     +90.5%      23.73 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
    479.90 ± 78%    +496.9%       2864 ±141%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
    185.75 ±116%    +875.0%       1811 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      2.52 ± 44%    +105.2%       5.18 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.alloc_bprm.kernel_execve
      0.04 ±223%  +37564.1%      14.50 ±198%  perf-sched.wait_time.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fput
      0.54 ±153%    +669.7%       4.15 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     28.22 ± 14%     +41.2%      39.84 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      4.90 ± 51%    +158.2%      12.66 ± 75%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
     26.54 ± 66%   +5220.1%       1411 ± 84%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1262 ±  9%    +434.3%       6744 ± 60%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


