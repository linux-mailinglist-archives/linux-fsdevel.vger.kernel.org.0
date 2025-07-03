Return-Path: <linux-fsdevel+bounces-53812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E152AAF7AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6F1CA5D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596DF2F1983;
	Thu,  3 Jul 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXCsj1p8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDF2EE97A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555489; cv=fail; b=UQq5sxaFB7PuiaVMRNZnGvB2p2EPkikdVfSCQhhjtpUBjXBq4saRJloLHiIGKunGWvyHD6OskWzuAxZxRZe3VdrSHwGz5ZZAAfNuozNfMXFWOBvxVIdF4nlmmYyj2zxJS7MmPOn+23cm4vJDsPkeLPJTW+AaDsXtTINNljVlByA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555489; c=relaxed/simple;
	bh=JO5qUrVOfIjyLhGFXuUxGPU+Kg3k+917fSRdjeoIut8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/uveTdEkaWYBRKAWrxSCFZ67c8JcdnQ1ZuSWvqmN9Y/tkQ4NnRD4KQuxXRrXD+F1IRC2AguJM1eeXCVERaRhx+QMuAE8qbFQn+WkvWywqYVHD/puAtlvwkJVCF7QJbqqeKZDh3s4UFIimXSZOe57xHPLxz72Twy1s6ZkcxrMfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXCsj1p8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751555488; x=1783091488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JO5qUrVOfIjyLhGFXuUxGPU+Kg3k+917fSRdjeoIut8=;
  b=FXCsj1p837NQAJgHL8i6QIb4ASS8FaKxQDgnRduhev96hLbgIA2wOpx5
   M3Mnqy4YdODH7xq1ndP15DccNrNdg6sVHosy8F5IABUznSxWky0aA480J
   DNV5rx6Z5YrQj7lbHvmDUeYaQMIgK7AjAkEqpCegjwAa9vDYZuCkO1EWk
   D2QVi7QPrfvwgbvLIsXDF7HLH/fYdikN+oqyaEz1V37wOXSPOxSpo/uOQ
   6i4s6xqgOc9kZc3TXd6Nj9Z9J204cy9VVopiNtM7cNfWPfctDQgaDz8eB
   EtncZ9hqJcM9cOHU2Wswflxl7Ffs5ifYdR+KE7xr0/zBuAWyFwElOvavR
   g==;
X-CSE-ConnectionGUID: XWOqFuXuT3yl0NLbRtrbBA==
X-CSE-MsgGUID: VNKzm0rvTTCLfIuWnEyUBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53753512"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53753512"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:11:27 -0700
X-CSE-ConnectionGUID: XTQWHhBxQNa271t4QsAc3A==
X-CSE-MsgGUID: qDS77K3qSIi4OM3Nf3s2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154964765"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:11:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:11:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:11:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym94h+lWOp1sCobxTpveW9Qdc0okkHXFyf/XnnkxTuM8pUnFE3sE6A21DuJ4bTVEf/iVrNpJDESd+tnlalpsszf4aBEhZZMSW8KXKe2awm9zaazNTYBO/sLCESnuC6dDIqK6llbPjKZTjDx7omDxTjPAe4UJKHRYfSAe5IfViLR+loWY9KzFeo+gPffzYMGlxpFt3nGArzW5O7wquiCSRrdbkfMUtwAkmidWsmSIvPts7NQewRSUcfv2msRcHyAVjdxX1U5gPwO++3koaqoXgi19WIVTm8VGGBR4Soh6S4dd1zfuyn+HQ7x5U/A5Ng5pq8lGD1TEeDn6WplJu5jqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN4u6qmOJ6kxYAYkTRQfyfTGS67Jv00dCOsKRWh41bo=;
 b=bB3kPDmMX90igyNvfe2reqpujFGqxW2TcmHy/M5qWS7rDGpp53cBhXPpIqn5UcnFwfDinwCHScnUvFR9U4ysMFFYQxt3A4iyjRimcNc2xbho+tQF/+6s6/4gHDF7ya8xmSolWZPiymh6SRLzcLJjQ8iugX0caQg2F0hDFhxsEBAWmfMMYADb/FyZ2QWbJAGVenDAVZHOfoR1KjNf0Z98OPpNr2ZUHBYqIURiFxYO0pYEj96gwO0OlgLkI6QTgaheof1CppHPZc1613z8/wy8dbThA7YnBd26Mg2cGHhV8H5fkXYq4h5e4J7RvewzeLa1IxDscOTgpGHJyPVRUG/DUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 15:10:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:10:42 +0000
Message-ID: <493611d8-70be-4e75-bfdb-34af57fdb2fc@intel.com>
Date: Thu, 3 Jul 2025 08:10:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] resctrl: get rid of pointless
 debugfs_file_{get,put}()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro
	<viro@zeniv.linux.org.uk>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-fsdevel@vger.kernel.org>
References: <20250702211305.GE1880847@ZenIV> <20250702211408.GA3406663@ZenIV>
 <20250702211650.GD3406663@ZenIV> <aGWjig2vNfmtl-FZ@agluck-desk3>
 <36094bb2-5982-472b-b379-76986e0c159c@intel.com>
 <20250703002419.GG1880847@ZenIV> <2025070323-siding-nearly-8a15@gregkh>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2025070323-siding-nearly-8a15@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:303:8f::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c6ea37-9404-4d02-338c-08ddba43c752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmZyMVk0SEFCeHorSFV3TGNtR0JyVjJtNTFPMUgzVmM5RVVLdSsvM3JjL3p3?=
 =?utf-8?B?eW92dDYxMllvbENjRm9ZbGI0OVNOUDMxbGRMRjgvNjBJRXR1TW1yVFJjTE9B?=
 =?utf-8?B?MHhMRjN2cndOUzdrdGdQYWVNREtNNHVWN0FMRUxZempRQnRneHBhankwaG81?=
 =?utf-8?B?QXpyWGtRRFB3elVUZFhCdldRWjM5QXMxWTZIZzZhKzBqQXZGajB0ZW1YSkcx?=
 =?utf-8?B?L1JHdVlHeHRlSGNuK1FWOXpCRzAzWFVLNjVoMzRrUVFDQkhMUWtiUHBZS01V?=
 =?utf-8?B?WnhOYlIvL0FObDB2ajFiT1BXajZQcS80NFZPbEhpVzhFWllMaUt1Z0ZLZWg5?=
 =?utf-8?B?N3ZkNXdCTVlFeHFjTlZoZGJ4WTlKNHdhcHMwSlpXdEhweHZYdTZpTlNOSUZV?=
 =?utf-8?B?eWx6K0RHZStveW0vMVNIcFE4c0toT29TRXJKSnEwK2JSSVlqMUNWbEgxRU5U?=
 =?utf-8?B?NU9veXZGajNtakhQM05ISHVyeGFSMjByb0pveW9MWHF3bllvSWlYQXF0Zmc2?=
 =?utf-8?B?YUZoY2xUMDM1WWNIRDIyQ1hsUkhCZGM5NlJreXEzaGRPS3hTeElaRlI4eEpi?=
 =?utf-8?B?L01RNjFWbU9HTE96N0NSemRvQ2hxTzZRc2ZTUkhlWllWeTd2ZUxhM1lFZ2dp?=
 =?utf-8?B?R1gra0FOYXF0TmFrQkJORFBYZzJNa2ZrZGJvcmxGYnltcDJWRGUzcTRSTTBW?=
 =?utf-8?B?NzJjZ0FrK3J1dWsvS0NsRjBOeDFhWXV6dE9oeTczSGV1MGJsc0ErRlZKUnhK?=
 =?utf-8?B?M1RhTWRaSGpIVkFqN25Jemc3U0pGNTc0NlVSSHoyaTFITGZ0M2dybjZ1ejFG?=
 =?utf-8?B?NzZma3pzeFphM2VvQVdGMWh0WDdlcUs5akREWjBrbkUzZVJPenJjcTh6eUFr?=
 =?utf-8?B?Nnp0c1kwbzJENCtCd0VOajd4bU9IUklUVmN4TnRkeFcrMUpsUVhwTnJLWVF0?=
 =?utf-8?B?eTkrM0wwTFB5c3FibGNRdmNENjFzZHFUOVM1WHkyWG0vSUZvRWxUNkQxTzFF?=
 =?utf-8?B?VE5PWmRsYTNOTFI1cVMrWFNCdEpMOW1MZFBsSTZ5N21zL2tIZFRPa1g5SkRn?=
 =?utf-8?B?Rit6cVkvVzZQV1Z4ZStPVXVVcUFFNW9HTzJIZ1NUR2RKeENLSk1VdldkbEgv?=
 =?utf-8?B?eWd0WE0yOENkdkNlWHpTVVVZUnRPVHkxOEpWb2IvTVZ0cDVUbCtBWlh0ZkF1?=
 =?utf-8?B?MVdyRHBtd3pqaEZzeVk0d0R3dzlRY051aytHZDVUS2JHS0QyUVlVK0lzSkJw?=
 =?utf-8?B?WXkwY2hIM2NYTHJTcU0veFpqYjVKVTZMRU5MNnZESmxwd0F4Y1hMQXhwRXRB?=
 =?utf-8?B?VUc0cUpSK1dTZ01KZTF2Q1d0UUlGVUkyUEJxSEtCcVRVQyttK0xGUEdlYnB3?=
 =?utf-8?B?a0tPSnhnMG8vUUIvUVN3TFdZSkUrcVlPYkNHS3p4SllDUUJ4Z0tuWUt0ei9x?=
 =?utf-8?B?N0s4RUV6YVFwMUlkdXk5Zm4wMXYwZTgyK2pnTSsxNnhDdDdycDlLZXo4d2hn?=
 =?utf-8?B?WmdHUXRCamMyOUdrU3FxREFTR0QzTlNKWW0zWUk5ZTdHdnpvQXNUaTZBNzBE?=
 =?utf-8?B?VExmYnVBT3JqcUFFVVZZTjRvNVZpU1h2NEFNUkNnOG94ZFNOdHdIdG1PaGt5?=
 =?utf-8?B?RFlWWmdQbGRpWFFBQ3RBelNhdlBFUWdyZjVCM3RDTDVVeGlPeS9UOUNZcHFw?=
 =?utf-8?B?QzdPbi9XZmo1SnFoZFM0OUNTa0p3V25QRDNxYU55bW4rdWQxZXlIQ2tCakp5?=
 =?utf-8?B?VU5DWkRONGVoZmk3REo0U0xadlZSRGZlbS8rekg4TnVvUTBmLzRTWkc1Nkxv?=
 =?utf-8?B?aGRvaWI5M29uZGErRi91WDZiOHY5N1BwV3k3dFVmcmZBYU9wd0FCY2pTL2s2?=
 =?utf-8?B?SmV1bG5iR25jcGh3K3hsZ0JIb1BLSmE5VzhBczM5akRWK2V0VURUWlg1dDlF?=
 =?utf-8?Q?s7qO/el/jn0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29iRTBTRkFjb09jaHJFMzlqSUQ5NDFYYitTU2lvcjE0N3lsUjdBdmtQdVhm?=
 =?utf-8?B?N00zUy96QmpVL0VsV01PS3c5UjJTYnowSkFLWjhtcGNxbkFldWlmYVI5M0py?=
 =?utf-8?B?OUEwdTFYVzB6Y0pncXNaV012MWpUcEh4OTdmUHNCOTlhTHV4RGg1dWlsNWxG?=
 =?utf-8?B?ejhhTC90OS83dllyODJvVlVKQjBYYXU4Vy8rQWo0dkZNSi9rOXo4Z0xMaEM5?=
 =?utf-8?B?c3luMDlpUGNINHVVaExUOExxQkZtcUZscmdjVkN0MWtidnJobW9DSFRaYWFD?=
 =?utf-8?B?MmQxUE1vK0xsTUVSTFJWQ2VUWU4rZXc1dU8rKzRLQ2VkN3RYUTFCTHBoSExV?=
 =?utf-8?B?MVBqR0U3cnMxSkxEY1VwVXBCajVlMEJFTjVqYWdaMm11OWZGSTdFRTJsNC80?=
 =?utf-8?B?aWJFTHFVTnFUVXM0YTNSMVBHUURPN2FWNjh4cFQ1cHgxbFg2R1o1TXo1QWV4?=
 =?utf-8?B?OU43OTJIcVovMVMxZnZlUldhRjQzRnRCemM1SlRPdzBXbXdqc0JVUlI3YnhU?=
 =?utf-8?B?NWRMSmhsS3J6UGI5Qmk0QTMvdFpGM2VVakJ6QmlIbks5ZngyV2NiY0V1R3hE?=
 =?utf-8?B?Y2RwT3djd05oeTJSMFN5c2FTWHZEOCtRUE5tRG5ORHdNQm9GVzNHZ3RXdjBx?=
 =?utf-8?B?WklCWmowTjYzdlRTYUlXcWxYSWI3UWpKZmtJbDVzV3llQWdOdUJVTUJJVUpR?=
 =?utf-8?B?QTk2L3JSaVk5WWJWc0U1VmtJQ2FWbitTZFdmQ0phN3hCRGQ5L3IyR0JiMXVl?=
 =?utf-8?B?VVk3VnNhZWo4cm4zKzdSU0Y1bXFuN0Q3djR1K1VpSTErcytXMm91SmMwdjB4?=
 =?utf-8?B?Q1M4VUdqci9SbnBPNzBxMUl0Qk5IMnYraDlVbFhrTklTdnVURDc4bUhhM280?=
 =?utf-8?B?OGMwdWlkMEp0L1V2L1dJNTUvNHdvTFVlMUNMSUxzN09JRHZwYWZWRjA2U3VJ?=
 =?utf-8?B?TDFFWDBQNmtJdWJpZ25PblZHLzA3eC9IbDlEQ2I2U2syd1B6eHFXQmJtWHpw?=
 =?utf-8?B?dEIrU2NsOTNBNEVXV2RkRGppVU9QajlWQU9jZHNiRC9ZM1BjRHRnQngrQ1ZN?=
 =?utf-8?B?ditGRVdUL01MVVN0OHBpcGVLTGxjQWlSTGFEL3lLWjcrMEd5T09CRS9iem16?=
 =?utf-8?B?bkNsNnpXaE1hdlIvL1ByNlpqeUw4K3hHSHVlYSt6ZEg3bys1VEM3RmxrbStU?=
 =?utf-8?B?U04yeHpUbDFiLzNJcHlqckNTZ05wMVRhUUNXUDVheTFqM0ZYVkxqVi9GMXlm?=
 =?utf-8?B?REpIUWJhOWxXRGkxeTBOd2NwQytnTDFHakM5Q2pVT0NQVU5FdHVEaENSUllm?=
 =?utf-8?B?SWVlSzAwdmxzNFVlM24zTTJUMkVHTlRqR28xWlhialpiUFVuaWc1MDMzZ0JN?=
 =?utf-8?B?RTAxZzdmaU1XUEdhdmNnZGhURDh5dmJuNjRtTEl5M2h0WjhTcUppcnZ6WDNF?=
 =?utf-8?B?SzRMVEEzaEdxNVB2bjNkTTNxaUxYMXBvTWhpcHNoM0pDWExrVUNFYmNGQXZO?=
 =?utf-8?B?Um5EQkh1TmFDdXFiQm95ZUE4MTZ5dFVlcEs2UERDYWZkZzFLNUZxK3hYTlZl?=
 =?utf-8?B?Ri9KdW1SVU0zdUZwN3d6TTdsTkNzMlpYTzQwUU9uSlFrK1BXc0NKSmpBN0tE?=
 =?utf-8?B?eStnN3ZOQ2IzY2IyYjdHRWp6S2J5ZzdXZVd6dGNvMmNTNXc1cXkzb0dDWlZY?=
 =?utf-8?B?VHZRbWZsMGp6SUo4M3dXb1NEV010dERpZWpWdlZyNjV2OEw4WjdUTE93dk9r?=
 =?utf-8?B?c2w3UTU2ZWgxZXlJVFI0QlVqbUp0OTlOVDQ5d3FsVGlUazcxdGJhOWx2MnVk?=
 =?utf-8?B?Z2xsaDR5eE82UjNscGtVNnZ0QXo1MHcyNm43TWhISHR2N0dBTTM1N1RJd2ht?=
 =?utf-8?B?emJMWHFKbk93QXNiWGNLU052SDhJTEtlK1Z1d01ZVkpJNDAzVjRld0FZQjB0?=
 =?utf-8?B?ZVVnNi9UdCtod0VLQ0hRMktib2xCMUJaaWZod0UrR2NaM1VHN3JoZExsaVNs?=
 =?utf-8?B?Z2tqa2FUaWRHbzNvcEVYMXc0bnRBei8rNnVxcDNIenVoK2Rtbmk0L0hDNG00?=
 =?utf-8?B?WTl5Zkh1aFZPY3BHdWU0aExZNWlCN2tJSmZmQ2E4Zml2ZGxlT1BZVEpjMENx?=
 =?utf-8?B?TDc5eG9SR1U1eVc4aDlhOXZ1STl5Z0lDUmIwdGNCR2tmOG5rN1kxSUtrdXVq?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c6ea37-9404-4d02-338c-08ddba43c752
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:10:42.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA5+rpSfONDfnffGwAhgMKi1C2TYs2DQm9jsd+9YyDIIKnNNEEnY3JRaZmyeWk1GkoLy9zt1maJvV+hb6HbdaFGvXi47R1UPxDQpI3yPb2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
X-OriginatorOrg: intel.com



On 7/2/25 10:40 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 03, 2025 at 01:24:19AM +0100, Al Viro wrote:
>> On Wed, Jul 02, 2025 at 04:45:36PM -0700, Reinette Chatre wrote:
>>
>>> Thank you very much for catching and fixing this Al.
>>>
>>> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
>>>
>>> How are the patches from this series expected to flow upstream?
>>> resctrl changes usually flow upstream via tip. Would you be ok if
>>> I pick just this patch and route it via tip or would you prefer to
>>> keep it with this series? At this time I do not anticipate
>>> any conflicts if this patch goes upstream via other FS changes during
>>> this cycle.
>>
>> Up to Greg, really...
> 
> I'll take them all, give me a day or so to catch up with pending
> reviews, thanks.
> 

Thank you very much Greg.

Reinette

