Return-Path: <linux-fsdevel+bounces-36608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664179E67E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 08:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AA618859DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941CD1D9A7D;
	Fri,  6 Dec 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzillDN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADB3D6B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469834; cv=fail; b=KUhw8LMuZiFfTwUbM8nrGmC7hqS5tvMmsreQWDLLBRFcsJskGZoB1QipnpWV+5ZF/eDA2ac+3NCWUTG6nNcAsYWtz6ybB4/SmnsI69n8TcXC2TeZvd349hCIO5ot3cD+AbUR/v496hnvUAVFgl1w1/x2ibvl5eBKUltoPySFONk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469834; c=relaxed/simple;
	bh=yYS5Quw8u8zMIlWHURqDjuSj9j+sAEdwmLQ3PuvQOrM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TZd3K3hIAvjfHlbcUX8ZdZL7M6OpeNfz3aDHfVDOViDdGUZtWMmvrUuXlBwAJe2xfxYAW7jzWTlPMwM+JZpcRYvZlHS1YzW3/1NqxYXlwGo4N7IB2WiAguhCRwc2XNT8OG6o+nuwyldM82wVsl8a6yNG9LtjYJljYku2izvRc/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzillDN6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733469832; x=1765005832;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yYS5Quw8u8zMIlWHURqDjuSj9j+sAEdwmLQ3PuvQOrM=;
  b=nzillDN65yD7BpHP8VjYK1dkYTd7T+jhX6gjvEMIHA57vIe/Te95HX8Q
   HzWu5uwTkOP1dR6FRvhTITlcwA4xsdKTHxopvNUiOEmTNYO2WkGP5PyKv
   XvoT6ID2VN1hz2gFLZsvciJI3xW7IpXRI8X/acY+MoW9cIvqoxxwOXTC3
   VSseOkWXQUSxyO+ay/5ylugrb2yvSjp2bCXxoCtbGKPGWF9HHao9UiHWI
   RSRgrLaAMsbjOdPIimmheQOBKFCpNhEAGcJQ0qrvjfn0HF3V2miunQqGe
   LwOlQ8udD3/ny9GpoR+RGEVD7zNlc8LBmgdMgzPXqodap80reIYjNrzx5
   g==;
X-CSE-ConnectionGUID: EiAo6Q2ZQcSV7Xqt3kI3wA==
X-CSE-MsgGUID: pCJ30UVASXGdrPRB6m009w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="37747526"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="37747526"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 23:23:51 -0800
X-CSE-ConnectionGUID: PrpSks3wRimhNTl95rrDfA==
X-CSE-MsgGUID: yKJjAv55Tw2K8URbugbarw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="125236348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 23:23:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 23:23:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 23:23:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 23:23:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti71ZEiZWOdrJowafdrBT1ppI3OWYMf7IMUD9S1IPwZMrj9wf8qHzkeJBQkEGJYzk/AFX3lV//LMCc54+PHUMvbJp0Qip6+C1upSFeHsiF46apfSTnx00XfnK/rP8vx7bBIzkPxHHL0eJjRWiqi3tKs0MJiqXWlsuyo6on8K7wjy+cYVG2IfpP20u6y+5PgilgEefvBoF+b+/sYj7auO6wUd+uHPbwbM1BjhgHrOridoAxz85wzaZziMGfD4T5niYFbC7unHMibcoMtTo0EJ9L8dKJMmxzzT+fL2alH4N2FWJ1evO0kZH19qsvc1NnhhU3bCqNaTUg99o4W39Hz2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYS5Quw8u8zMIlWHURqDjuSj9j+sAEdwmLQ3PuvQOrM=;
 b=RzGueO7Zq2+pIvLDJgPeK1kfE9zQe9iTOkKl2b1/5FrTby+TX7bZ1NkijN6rOoraYHUSx/fdcT04tAFLLrqbSdhBwPVhTCx1lktoAop5AejyY8UpZHHDj1B7P1dnl3Fg0Bcd0fBqkFHY4EeXBVjusbEBkCD2IsZblaoOcc67JNCOnsB18IF3a4mpuLqfxHTXq7QBg9LUtBWEAmDgTmbfNczFC3u+RdWewLpD43T6MSf0e14EbkWjdBWqgE/T3PtHbA9h3W8wAJKdJ79xjubjpB57zvtU9xrd3w68mOo+rwYsS9XROu+avB3zVGIeHTNhdyAWHwFhxgUWiNTSSSNL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by DS7PR11MB6197.namprd11.prod.outlook.com (2603:10b6:8:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 07:23:46 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 07:23:46 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "tamird@gmail.com" <tamird@gmail.com>
CC: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Regression on linux-next (next-20241203)
Thread-Topic: Regression on linux-next (next-20241203)
Thread-Index: AdtHr8d4DbPslOm6TUe2WzevjG+vYA==
Date: Fri, 6 Dec 2024 07:23:46 +0000
Message-ID: <SJ1PR11MB6129DFD4D1E8805D9EC930BDB9312@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|DS7PR11MB6197:EE_
x-ms-office365-filtering-correlation-id: d0778137-87aa-41d8-5373-08dd15c6ebd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DmxI6hgvU8vxFaN2Do9t9pQUA0jIL3VbmeDSskYcitCOXZ2NCAlJskn7J2?=
 =?iso-8859-1?Q?xv9LQrs+uJ0/yyrUvFQEJ2ydDUnrXIN5UoLDxjmA6jfJ3g5qPyZ19BMOi1?=
 =?iso-8859-1?Q?2QnNGDW+HsgyEoRqwZQRRwombuOpzxlTi1uwB9hft5nAkTA3v7dqt9H3s8?=
 =?iso-8859-1?Q?RPCQme6hccQhTjYOhor6nkl1MoVqXVH0Hk4LAreZ3BbSMbkY5nKYWlLuIg?=
 =?iso-8859-1?Q?+Ha8YYpiL8EhT6FKurY1LEj7w/77jSoWWk9lIGvnOi6G9FzsLNopLorc6U?=
 =?iso-8859-1?Q?emEqFgKeitf7w+O/jQ7bev4Mo/fAPIfPjkDsTKwGy2/T65nnZrTIVAGrlC?=
 =?iso-8859-1?Q?Wt2VEWvtBFhwfio/9N153jcs7+DJ/9C7YiODXub2+2MTNC7U4LbH8nioVl?=
 =?iso-8859-1?Q?3ZWIpDXE6OUQTR6K5Kv8XWOH95XolvbwQRRbcRG6Y81zeWlXFwfXEy3cdm?=
 =?iso-8859-1?Q?HM+hroBCiFtinyK4Wh2YziivOd/IesdiTgLzlM5/FVtlGm75qMVAIsK2f9?=
 =?iso-8859-1?Q?Ttmc1615bbPW0E2l3Dwf3Co3E4s02KNjHEUBltg//C3wFRzpWYw+E3bl2u?=
 =?iso-8859-1?Q?snecaiTrG8qwmS4Pxgu5Dat0fDVgPpWBixgTyDnLHZXlpOwko6gnrYgNAV?=
 =?iso-8859-1?Q?Yl4nJ+MCssFSO/dwkgo0iVm7Ubqfreks5xP5OOSbhe96wuzdeVMROpy98B?=
 =?iso-8859-1?Q?P76snoneisVXGw+GWhIFJhuBvZsn38W6keKd9BWNZoLZsbMTmETAwis4qJ?=
 =?iso-8859-1?Q?lHNvo5v9VJZvR2E3kiD79Ui1bTsYlXTpW9Rb7NT9ooHCafeMMDaE0L5/tV?=
 =?iso-8859-1?Q?tRJUD3uVZxEf6GZnw9gi55ziZ50HCAPqMHCOjtHQU8FjclWpaBpZWC/j6m?=
 =?iso-8859-1?Q?B3/xwlMJTOmESRnA8/o1s4fo4T51Ox1D8YKw+6sVw91/yfMF5vvqObFwkd?=
 =?iso-8859-1?Q?5CkltW0sU93F6DJxs7AdyTEzTISv5CG7vRFeUcwcXnxn0cYjbqRKqfd0LJ?=
 =?iso-8859-1?Q?ynhaBGnnmOK9SWOvmFb6gWsli3QQzoFMRqKz4Y1NPHXjTZxXfW7etRrQjg?=
 =?iso-8859-1?Q?SF1QB3a0TX2yw1/AXpd6XJoKmvcsLjxqVZ4SCKbQDfnHCrGZS1tX0MtaxV?=
 =?iso-8859-1?Q?oAupGDJD2wjAZHA2+88yb5oOvwFEZ404gdjKwg/bEZ/Y1zqANLK5iwpXDf?=
 =?iso-8859-1?Q?aF2u8/iG7iiWv04xJ1JSjEH07xOlNu9kce5kfxaP+FrVk7i9HFl0J5CP0E?=
 =?iso-8859-1?Q?tPmWKYhUzailTtusvNajuCWdv+cAIxssY5ndmFrqFrPOLhjmW6R+791Fny?=
 =?iso-8859-1?Q?1DF4jt2252EpCxqqR0h2MTBMU+vNEo6wgritZBKvb8UZq7oWEQGSN0XPsL?=
 =?iso-8859-1?Q?3OtAny1gXPOz2lQlNMB0ViYf0y7mIAFEUPWGLWfudVAZuZI+ySCaw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VvoPkQmqbeU2NggjSPQki3BaGzEG7SHuNNWv7fVAm6SQir3StJ5HS3u7uc?=
 =?iso-8859-1?Q?rdb2pod+r+tA/ZYvC523JPz5BDIbFlUQBulascLRov7+g0g3HRGfJWxMlF?=
 =?iso-8859-1?Q?ItasEUsF9r+Zt3W6D4WEUD6cjw7JvJvFsbMN0oXKK50lQSYFWvoO+tT31m?=
 =?iso-8859-1?Q?O7dvkDi3GJhtIhH6n2hoqmV0wpZYDfKTCuy3cd4RAmGA4AXMBbtGqZLpcp?=
 =?iso-8859-1?Q?wNfwtMXiZUGa48Xgdlf9Sn6kE8kNdOolu85W+gxzgW3bpwwp6UjHCvcaw0?=
 =?iso-8859-1?Q?+wh1cGqHGPplzZtYOCDwXIVW/wBx77BB7JlHR3t9n0AQTOTDDb+T6XImKS?=
 =?iso-8859-1?Q?jXA3XUNyh1cwRD1iX5aQYhz2sfPUDSDgROhbgDI7cYgZlEUz11+D2rUctv?=
 =?iso-8859-1?Q?yYgirob69DY2l1XJMwANuwOaBcxH22JhJjMZreXIYjfTeJPF6BpCQ4u1hN?=
 =?iso-8859-1?Q?MQMCYCIEEa33zpZg8uDgxd8Kdr/mYrs74MmQ+NsTA3UCGt1Oyvw7zPczn8?=
 =?iso-8859-1?Q?cpG35UxOQz0EXgXMo8TaLOf4Us20XXlCwhhAfSjHW8BGNjDGIhSdag2Brd?=
 =?iso-8859-1?Q?ueeChU46kkPo9vGoTLk9om9v+xAumbvoZjEr041Np6QJT4A0XhTVTCyQtw?=
 =?iso-8859-1?Q?2slWqsagHweHHHLNBm5kiXFvXMwcqmnsoDtv68a1fbFrTqxS6B1BXVfGAM?=
 =?iso-8859-1?Q?k5yYl/oHoOLGDlUwEiicfyt9qtlw36Wah90WjbYEm9h5Ihun0Cdfqk0VJU?=
 =?iso-8859-1?Q?swUTBOUPQf4lS/YdTHHwuDk5dmXFKYvUm6qD0yHpym/zNPqkGDhpMkswj0?=
 =?iso-8859-1?Q?kCOghLDTJNA0QiEACmFOCLmCe1aivlJmY7/4AgHNJrX1l8zPmFBjLEORyu?=
 =?iso-8859-1?Q?6mmbQJNzaU33YLF6fn8ipCCVGEnNppqnHEcA/rm2KPxB/ohEM8m/V1idP1?=
 =?iso-8859-1?Q?8qPytL/XExpgTYDzL0cL9WNBYX6uM3uwKt2wsZunPnxnMNBeFsnnQ6QnEP?=
 =?iso-8859-1?Q?vF/9QbX/pbp1yRN3JzMUEDeYq3L4Su0b0hi16Qr1685LQhXrTUlzmNotgx?=
 =?iso-8859-1?Q?Yii93YFpbvC5dudeuszNw0gQjjxL4y257FSrFBHJzoBU6zHDv/yaMEuBwn?=
 =?iso-8859-1?Q?9NV6Znpi0Iifa+b/ki4ryr1hV7WNGwmGzr4VmCbtC5oqsHP8VMG5sv9wtV?=
 =?iso-8859-1?Q?Egjoi1TCVgLDHuO0kYJBzkcMX7OY1KFTx1VrhYReZB2iAZJBA/TfmYSv/n?=
 =?iso-8859-1?Q?QF+d8PCKYdgn3oAKyQHqtH50H+3p7yq4hDZBzlKApvtqLF6XJmkaSMCv+x?=
 =?iso-8859-1?Q?rmaaTwTpctpQn/QIIiMqSON1BKhWFU7RrmQGJ4ASrf8ASdPkcD4/CZgyv1?=
 =?iso-8859-1?Q?S51TX0aKrsb2SOpaS+BUw9BzBSpeqeLIMymW+75XGdCK8s/c9a4SypHVDc?=
 =?iso-8859-1?Q?sp0BieCKt9in7pRXkquzbinxkW8/3aUaCZdWevn8L0W+WtI6MPKnuTb8Mr?=
 =?iso-8859-1?Q?uHdY/4L+vFSWhlmHSDyGmgiLRi/gjgOVycbg3BB87rBxcre82S9sz527Jj?=
 =?iso-8859-1?Q?db0g4werABcdb1LA+5LRRH5qd3c6Y09N9K1riTUaQcVwJ5HGK7ePkTH+c0?=
 =?iso-8859-1?Q?lZje6lN2YtK4HhcWAmyh8aYarUuFtBt/v4gPso4m6mP7mdEnV/iNeEVA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0778137-87aa-41d8-5373-08dd15c6ebd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 07:23:46.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfqgJF3sStVATme7cGV/M2Vj1u9+rcFke7ef+J2YhDpQ7w0qVnSMGClpAmPbKwUt3M8vS9CZL4xfmYf9jDbqbjvXsUahMOvA++eijMQD7c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6197
X-OriginatorOrg: intel.com

Hello Tamir,

Hope you are doing well. I am Chaitanya from the linux graphics team in Int=
el.

This mail is regarding a regression we are seeing in our CI runs[1] on linu=
x-next repository.

Since the version next-20241203 [2], we are seeing the following regression

```````````````````````````````````````````````````````````````````````````=
``````
<4>[=A0=A0 28.896758] WARNING: CPU: 10 PID: 1318 at drivers/gpu/drm/i915/ge=
m/i915_gem_context.c:2469 i915_gem_context_destroy_ioctl+0xae/0xd0 [i915]
<4>[=A0=A0 28.896937] Modules linked in: snd_hda_intel snd_intel_dspcfg snd=
_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore i915 prim=
e_numbers ttm drm_display_helper cec rc_core drm_kms_helper drm_buddy i2c_a=
lgo_bit cdc_mbim cdc_wdm cdc_ncm cdc_ether usbnet intel_rapl_msr intel_rapl=
_common intel_uncore_frequency intel_uncore_frequency_common intel_tcc_cool=
ing x86_pkg_temp_thermal intel_powerclamp hid_generic spd5118 coretemp cmdl=
inepart mei_pxp mei_hdcp spi_nor eeepc_wmi asus_nb_wmi mtd asus_wmi sparse_=
keymap platform_profile wmi_bmof kvm_intel kvm polyval_clmulni polyval_gene=
ric ghash_clmulni_intel sha256_ssse3 r8152 sha1_ssse3 usbhid mii aesni_inte=
l hid crypto_simd cryptd r8169 rapl intel_cstate video realtek i2c_i801 spi=
_intel_pci mei_me i2c_mux i2c_smbus idma64 mei spi_intel nls_iso8859_1 inte=
l_pmc_core intel_vsec pmt_telemetry acpi_tad pmt_class wmi pinctrl_alderlak=
e acpi_pad dm_multipath msr nvme_fabrics fuse efi_pstore nfnetlink ip_table=
s x_tables
<4>[=A0=A0 28.896999] CPU: 10 UID: 0 PID: 1318 Comm: i915_module_loa Not ta=
inted 6.13.0-rc1-next-20241203-next-20241203-gc245a7a79602+ #1
<4>[=A0=A0 28.897001] Hardware name: ASUS System Product Name/PRIME Z790-P =
WIFI, BIOS 0812 02/24/2023
<4>[=A0=A0 28.897002] RIP: 0010:i915_gem_context_destroy_ioctl+0xae/0xd0 [i=
915]

```````````````````````````````````````````````````````````````````````````=
``````
Details log can be found in [3].

After bisecting the tree, the following patch [4] seems to be the first "ba=
d"
commit

```````````````````````````````````````````````````````````````````````````=
``````````````````````````````
commit d2e88c71bdb07f1e5ccffbcc80d747ccd6144b75
Author: Tamir Duberstein mailto:tamird@gmail.com
Date:=A0=A0 Tue Nov 12 14:25:37 2024 -0500

=A0=A0=A0 xarray: extract helper from __xa_{insert,cmpxchg}
```````````````````````````````````````````````````````````````````````````=
``````````````````````````````

We also verified that if we revert the patch the issue is not seen.

Could you please check why the patch causes this regression and provide a f=
ix if necessary?

Thank you.

Regards

Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241203=20
[3] https://gfx-ci.igk.intel.com/tree/linux-next/next-20241203/bat-rpls-4/d=
mesg0.txt
[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20241203&id=3Dd2e88c71bdb07f1e5ccffbcc80d747ccd6144b75

