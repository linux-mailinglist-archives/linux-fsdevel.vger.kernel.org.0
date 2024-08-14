Return-Path: <linux-fsdevel+bounces-25988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DC952425
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF74B20AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F31D362F;
	Wed, 14 Aug 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="ITMNvnld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA41C8228;
	Wed, 14 Aug 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668156; cv=fail; b=jXLQc4EE2kUoejd1aOXoDY3ygM0MeLQ7HmPYEJ3KOZIiKzcl7F4VwPVQJzj9yPIVW+n768rhcTI7Sckb8UcDYwcErXphCZAXHUIwPKNA6Q+tI5ZqF17/PyrKlRSJAxP2lzk7vnzRo0KFqd5nizZKfzWW3wGKxmyDP5/GFkd73Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668156; c=relaxed/simple;
	bh=Px53Jnlp4D9sezUSUHp3tfVbsPlE6ZfPM8IVXV0yy34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IoL4s1drZ0xrGbjw7KagfDE/53P6QuC+QSMaxOCjWkxLDfWzEhcYxDlzvhsq0fureqPJ86qDZsTlDpOutAN1ZRjPputUVqlGfX0bAvFOAtlivKsuE0it1Kl/j0kC9dgHTT0zirVEn3rosIENFFyzoeuXfBuxyDKilgOzKAqFKfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=ITMNvnld; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723668153; x=1755204153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Px53Jnlp4D9sezUSUHp3tfVbsPlE6ZfPM8IVXV0yy34=;
  b=ITMNvnld+qN7Fg2+u88hA0mrWkUw5aG2+3RCt4YxInFjPpwJ4t2yimrZ
   wdYdV4bxFvSahZdbujer6IdHm0Gih6uSarvyqMikFqrv+lt6fROHZ12Db
   fxYduhD/3/xUvKkKMncEB996Wuhb1JHKBa5UaeiMIzCQiecLzV14/5Nau
   c=;
X-CSE-ConnectionGUID: p1G9LWK0QkOfXPOJ/Z9jxQ==
X-CSE-MsgGUID: PEQUArxPTZ6uaC3kxKRtzQ==
X-Talos-CUID: 9a23:SXIkBmGbjOmHKyY+qmJ/rWFFPv8GKkTe63ngG2iaTlQ4Sq2sHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AV7zNBQ0ocZv0aHKG5pcGWHqG8jUj24mXNWkXga0?=
 =?us-ascii?q?6iZeZPAcrOCe+tiile9py?=
Received: from mail-canadacentralazlp17010005.outbound.protection.outlook.com (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.5])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 16:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEa+DKTgihWeeMcep2dWYZjgzE/yEfyErrTr9vLTAG4yLYUhH624ASjyRqHt7oj4IgNCedvdFiwidTItI75fNwnr7vrZ7a9+IU3Sz5LSrFFjkgC/5hHRE1h+XIJQeI1eH4+ty8kVDSfbOa7e8vpGUMFb0nmgZi18lnKizGPCLnMFCDLinTKBendI9+W6geMvOCxLcopCSecy/5TVRfXraKcTRFvnFgCPrHjuchoCb8pWPcLG5j41HL5SMc2cSWA1mfphuhqMqynVg4KspE25EsJ9cnVa5YZHoFwp22TvtO2p7BhIgfGc5RnIbOsy1f8MSwZ3IL1U3ADcmPn8igCwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPGmXJvZNO4Sz1YiAUVKoykRt+mSnPmP/VCEqsjw3AU=;
 b=A8DmDwdc4IQhaZzMS8aZooHSmE1oCDmWZOvEpCefSVryxKDhcaJyEP9XGQNg+Wi/qH2pJkn2NNN5hCOoS7b4hHrveH94PkueMZ79m5P2oLYdRCAkO5ttauMBJRbEB+2ojxikapDh0jz23YcjKFwqmv7lP8ceeElIWdQHrYLF9Mnmgap6MPyV1AnLVJvSAj8NZ2BXqfeEqTIwbnpkvrHtXA9NKRRjcH42Y59n7Klix4P+GSGZgtAE2KIoKww+Uwdgb9IPUop+2PRFHviS0YhY5qQv/vbo8YlUKYF+lfoQoT5rMRrx26D3AN3H5d9/ngXhjgsQjm4I0vQt4nz1o6uxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YQXPR01MB6480.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 20:42:29 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 20:42:29 +0000
Message-ID: <d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
Date: Wed, 14 Aug 2024 16:42:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
 Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::7) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YQXPR01MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf72fdf-ba55-4660-9c83-08dcbca19cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNkakRLMGpQNWphc1FQdEx6a0FtQ3pwMTRxTHREeHpncFVTUk1hZWtYd0E1?=
 =?utf-8?B?NGsrcUY3cjdLSkp6VlhJbllmbkdPUHFqc1hMemVJV3YwNlRwR1Z0VFlNZW54?=
 =?utf-8?B?SlBIRFVwSzFCQittU1JaNGhYN0tnSDV6b09mbTdSeXpvUDI1dXhJeCtqdG1Q?=
 =?utf-8?B?UUhWV01XeUZoekowMmdORyt5dnZNeGo5SDh0aFV0ODl2SUlBek5BbEZ6VzU2?=
 =?utf-8?B?a09saXRGeGZVenRlN0NXdzBVRHR6Uzd2TUNjU3RDc1ZaOW5nbzdoNmIxaWRn?=
 =?utf-8?B?RVJQWnlaSS92N1dEYnVhNmZFTHNNQnJ3UVNNZllsMXhsN0FsRXdMcENuR0sz?=
 =?utf-8?B?ekZpYkFoRUp3MU44RUY1dnlwTTdjejBKWEZBZ3JrVXRYQXNDMEZmTzhyQjRQ?=
 =?utf-8?B?OFVqQ0FHU3BJUXZ5eXhDNDZucmZoU1h6SGFVUUdLMkU0OVczbDVGNnpOSkxl?=
 =?utf-8?B?UjFiOUs4NXJHUDFPaDBlZVRlaDNWeklLZ3hHTit3TXh2M29PdkF3YUU5Umtt?=
 =?utf-8?B?NEVOaU4wOXlNQk4rY1RaUEpWVWs3blhxTm1ZblVxa01JL1JKRm05VCtYSGpu?=
 =?utf-8?B?T2xkYW5tRHJ2QTcxNjlWSUw3YzlEb1ZvOTdyczNDTmRyRHhnTU9IeDBwck9u?=
 =?utf-8?B?cWVlQWRoamxxSjZQVElFay9JZlJ5T1A3Lzhqeks0VDlyMVIyZ0haS3dCQmVj?=
 =?utf-8?B?dFVWUHBjeHJzbG1GOEd6ZU9vR3ZMQ2JPOTdJY0VHY0JHNVRMN3NQUEIxU0N0?=
 =?utf-8?B?NWpzWHY4eDhBdVdpd3JHbFlIVDVzcWEvTUp3QzdoV3dOZW5OUGhoZlV2Ry8x?=
 =?utf-8?B?VUdDZ045V3JBNUhMcTc5QXVUemVpbEtqNnJLcDVBcWpqeGE0cWQ1NGhlbXVz?=
 =?utf-8?B?YVhvMndYWi9lTjM3MDRCTStSZGdzSDhDcFRKRWg5R0ZqTmJ6Rko5bFRUaW9z?=
 =?utf-8?B?RkVJWjZrbHl1K0U1RFlCMTA1THlOZ0ZBVTJJdjZDVHZ1dTljM0ZNNUNiZGNh?=
 =?utf-8?B?bU9JNldIWEtIejMySFdrWlhPckFRemNjaS9lejJ6OXhXQ0lpcnFqSHBPVmlw?=
 =?utf-8?B?a2VGUHdlUFhFMVJKWkJaaTAzMnB5ZFFLdHZ6N1lPVUdvWjBEZVlyQjgwRnFx?=
 =?utf-8?B?a29GaVd3VnA5WFNwVmlpNjdmNVErNitPLzFkQVliSkdxY2xXRkdSZHdlVlRs?=
 =?utf-8?B?RE55UjZqcXRiWXJ1eUg4S3h0Ky8rSzRkYXhEUHE5RUlUUldJQnMzRFpna0oy?=
 =?utf-8?B?dTFOa01TTmVtOXYzTnZRT1FzRTk1cVh0WEF4NDhNWnJlcC83UWxXRWdmVXVX?=
 =?utf-8?B?ZHRtc2h5SEkvRDBidlJkWXFPT2RybnhmOUhvYmg5L2t3Tm5WSDVWZjhpcTA1?=
 =?utf-8?B?c0owcTVxYjdvcFhIMzVLZDdJT3JibmZPVEo0ZTcyeFYzdjhINTdrcUZhYXo5?=
 =?utf-8?B?Mi90d2hNN3FscFE3Ui94ODhodnRSTFlFaVRIVDBzSkl3bkt1OG5CN1dHa2o0?=
 =?utf-8?B?dmdRVks5eFVYdDBIazF2STRsaC84ejRkTmROWVZSZW5FYXNiWHYxVzZzREhv?=
 =?utf-8?B?SWVGV2M1bEdWMmU0SW1wZzRzZXBJcE8rTDVTUkIraDNNSjd3d0gyVG82Qzl4?=
 =?utf-8?B?K09wY0h1WWp2aEVBWTA4Z1RaMEs5MFBVNUlPdGdQdmsxTFdJN0ZSRDVOamVj?=
 =?utf-8?B?a1hib2xTaXE3WHVCdFJIOGRNZVkyOXZlN25Za0MyVkI2NUF1YXk5NDhicy9k?=
 =?utf-8?B?MXFmNi95b0wzeGlOTS9GVkZ3bncvTE42VGZvaGVjYXRISFRZSXNKcFVRcTFM?=
 =?utf-8?B?bWhDT0t5TFdpQVdhVmNMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmplaklheVgzdDJVZWNQNW5OZHhsRDE4T3FMdnpmOHpjQk0rQlh1ZEhFamx6?=
 =?utf-8?B?ZmU5TmJOWmxQcnVWYW5tRU9Iai9DL1Q4eFp4UVQzYVQwelBkZ0ZqdmVNOWxO?=
 =?utf-8?B?dHdFOHNFdWhVL2E1YTFzeUFYdHB5YkNTV3ZMTVIrV1NoaXJvY3g5WnRocE56?=
 =?utf-8?B?SFZMNllsWUF1OTVIMHFUcURZakVFOTBrcGx1YVhvTHpFbEd6VllqMzNsQkY4?=
 =?utf-8?B?Y1g1bCt5UE81REcyNDVnUUtDYjA4YXVOdW9lTVFXZWFaSHRJNjRreHR1N3hI?=
 =?utf-8?B?TkEycS9kOVk0N04wb1B1bmJONEJqUlVTaGtETUpCMlppL1NuSUw3NldvWDlx?=
 =?utf-8?B?NFVoSEVZUnJ2T1dJNDg5MDhkU1kwWHpvNG1jQm9WdXVnOXRJS2JMRFFvYzJT?=
 =?utf-8?B?cWpDUDh1WVIyeVhIdld2RWJDeGFKNUdBazNSVzBXWmdudXp6ZUN0S2k3K3g2?=
 =?utf-8?B?T0V0bFVvbmpXZWhlanlJRUE4a1VMVWlPR1ZNc0QrajdZTG84enVuMmxxSk5C?=
 =?utf-8?B?ZUZhQWYxRUduQzNzajBwNkl1ODhIcHIrdlF4cGMramp5S0VkYmNyaHZWV2Uv?=
 =?utf-8?B?M3pNRHVZNzE0YmJKYy9qbURiaVk3WE9FNlpTVjc2V2ErekpIZnk0QzhVTDlx?=
 =?utf-8?B?OWcvT1oxckI3TkVuL2hzK2NyRnVQTllUclFtejNYV0lXcGFwTlJsdlRIWklj?=
 =?utf-8?B?d3JmaVFOWmtPb2NsVWVPWGtIelozUXdYMi9qL01FN1lMdmZYMVZvVmN5RmJw?=
 =?utf-8?B?Y3B2aVpwUjlzY1ZJUUhaek9NUzVsMlQ4UUJuaEFYYXFQelhuRUxPNVlzQ0VY?=
 =?utf-8?B?RWs4Zk5VYzV4bU1nYitydFBDRThKRy9GUnJxMTg2SkN0cUd4dEg3cll3UTZK?=
 =?utf-8?B?NmMyMmRHMEZlT2s3anhQWnRLd0dkeDhrM3R2ejNIVC9XemoxKzdLQ1RiNng0?=
 =?utf-8?B?czRodkF2VkthM1RvLzR2Y1BDazlTUG9sNmduQ3I4czFMeWFXc0N4SGZVU0N4?=
 =?utf-8?B?dFNwM0krV0plSlhvNDNiMHdaTVNHZ0FMQWRYWk5uMUlZbG00RTlWMnBLa0Zj?=
 =?utf-8?B?Z0pEM0NRSDI3a2NIWHVSNjdCVDhGaEFsRlI3eWpCSU8xNXJwVWYrZmJrTUpJ?=
 =?utf-8?B?bEtvTGRSN0FuZDR3eXM1bUZwM1ZrMjlpaWtqbnZzS2RiclZVMlFBVVpZZ0RC?=
 =?utf-8?B?aDZoQnBrbjZrSWFIQXRBNzRDR0lHUk8xQVNXSWViakxVZDFvT3Z5NWhKRkxn?=
 =?utf-8?B?ZWpjbmNGZ3FCcU1CZ3U0cFpsdlhDM2pKSUdJNXFmTnBoZVRvTTJHNityRDJZ?=
 =?utf-8?B?Yi9rb204RU5aTjkvRTBheHBBdE1xSWt0dzg5Zk14dGJMU0dPUXNMNmJwajZO?=
 =?utf-8?B?bjc2QkM3aC9lbVZibmpxRmJFMWZJcEJ0UnhGUWN2SGtQUCtENUh5Z25kOXpU?=
 =?utf-8?B?cENtMUFnZWlxLzM1SEp4VlN4aXVmQUdTYU1Xb0F0aGVwaWxwWTBNWGhwaEk0?=
 =?utf-8?B?SGFteWo1N2x1T3JGNWZ6czVxbUhBZERCVXJuaTdoSnRPRHpseTlFYW90ZndF?=
 =?utf-8?B?Mkp6dzR3M2NnRVgrZmhDY05TdE5mSEFuei94cnRBNVQ1YzVFandEM0NWWVdy?=
 =?utf-8?B?b0dzMEljbXBVRlUwVlNZaUVVcGFzcnpDbHJmb00xSXF2dWdyVlBOK09iSmF6?=
 =?utf-8?B?YkhaRE5jQktpTW1tSGU4SHlSWmtINHdlR1BXV0JiNkFlWk9OYUpVMndXaVYv?=
 =?utf-8?B?cFN0bnlQVjRTZ1FZSjBsV3o1YzhHUlN3RVdNdjlobTNuL3BRcnI1NmpKNUhR?=
 =?utf-8?B?aFh1WTIxWENacUlOZjJKTVZJUitDekRqRE1mK3NHOUx6NnJJeVg3SjM4ODRp?=
 =?utf-8?B?ZEV2YlB4THhyQkcyT25OQmJ3UzkzSkRtRHpwMzBvNnN4Y1BLRlJBcTh1bVQ3?=
 =?utf-8?B?eHdNRFZKUmtUKy9IVEVFK1hhSm9QQUZtWExLSHVvL0xOR0lIaktDTFRlT3ZU?=
 =?utf-8?B?SFNEYUdEdm1mRmt5WE82ZHRXRWZJNzd0Unllc21Eb2ZxT1FRSE9oQlFHRWxM?=
 =?utf-8?B?ajFnKzB4M0xsbkFnN2pWcHpPYTRHUmZ1MEFXY0hCd0Zsc3NRTEhLV0huVDZp?=
 =?utf-8?Q?MYgg7q/R8n6p/k8k/qokDukRS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L8L+JkMEanXzrjSiaSeYBeTXtYJB9YZFn/w4vTsHnYsJ8/zMIQjRHqpAbgwG8ZDv08R9nvxpG1RFTjTPlTVQTqaQRK+NOh8xM8OZlnzvDXKhttHveluFpuYHAPp7MRO2DSFukiB1aHtBoAyU4++t7HSGiXQw/ZPA3XIYlFlr63TLbfKHjbPeCKivo9/n2ZIE5Btp+CWNsrhWC2ilhXc67zVm70HL1XZb9iS28suwXMAlFMTaRK12pfhdc3Tsu1VoKlvkFXz67zSawhsSCih3jNriMIU0dobtAQW6XwDIikCeTqDKZoGmozrrvv7AL9vovGRplk6EDXAGwcAL+DFPB+sH8qkvs787S7Qf1Qp1OG0ztfkkzU7Ps5b7EPTPR+z6YU7wgmg4ff5UL1I25GqxfTxbq/O1BAcEKIO1pTjtG/ldL5PyHoPjF8RCoJscBQOKfe49vB8n6rmPLG8GSGSE9+08C4DzxNhzI/QkFZEIhxiFTh5bc6H/3e6Xdaw60nsoHYybRQTSK1gKXlbLWNZqFuAmSBqfd2EnANCEiAaVIpHO3OATb+cjH/OgcEPqCjFWZzMjU2i7+Aus0fNdhro8sBod3T8LikUIATz+MMeN7UjAhWqm3SRSMfn+R/TYw2yu
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf72fdf-ba55-4660-9c83-08dcbca19cf8
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 20:42:28.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9NJ4ds6gxcpb5g7hekqqpSgYAvhMZ4x8VxcRhYxvGQr/ykyYhgBa5O32nv90fG5RR1ASZb3YUGBhlqHLCMwKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6480

On 2024-08-14 15:53, Samiullah Khawaja wrote:
> On Tue, Aug 13, 2024 at 6:19 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2024-08-13 00:07, Stanislav Fomichev wrote:
>>> On 08/12, Martin Karsten wrote:
>>>> On 2024-08-12 21:54, Stanislav Fomichev wrote:
>>>>> On 08/12, Martin Karsten wrote:
>>>>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
>>>>>>> On 08/12, Martin Karsten wrote:
>>>>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
>>>>>>>>> On 08/12, Joe Damato wrote:
>>>>>>>>>> Greetings:

[snip]

>>>>>> Note that napi_suspend_irqs/napi_resume_irqs is needed even for the sake of
>>>>>> an individual queue or application to make sure that IRQ suspension is
>>>>>> enabled/disabled right away when the state of the system changes from busy
>>>>>> to idle and back.
>>>>>
>>>>> Can we not handle everything in napi_busy_loop? If we can mark some napi
>>>>> contexts as "explicitly polled by userspace with a larger defer timeout",
>>>>> we should be able to do better compared to current NAPI_F_PREFER_BUSY_POLL
>>>>> which is more like "this particular napi_poll call is user busy polling".
>>>>
>>>> Then either the application needs to be polling all the time (wasting cpu
>>>> cycles) or latencies will be determined by the timeout.
> But if I understand correctly, this means that if the application
> thread that is supposed
> to do napi busy polling gets busy doing work on the new data/events in
> userspace, napi polling
> will not be done until the suspend_timeout triggers? Do you dispatch
> work to a separate worker
> threads, in userspace, from the thread that is doing epoll_wait?

Yes, napi polling is suspended while the application is busy between 
epoll_wait calls. That's where the benefits are coming from.

The consequences depend on the nature of the application and overall 
preferences for the system. If there's a "dominant" application for a 
number of queues and cores, the resulting latency for other background 
applications using the same queues might not be a problem at all.

One other simple mitigation is limiting the number of events that each 
epoll_wait call accepts. Note that this batch size also determines the 
worst-case latency for the application in question, so there is a 
natural incentive to keep it limited.

A more complex application design, like you suggest, might also be an 
option.

>>>> Only when switching back and forth between polling and interrupts is it
>>>> possible to get low latencies across a large spectrum of offered loads
>>>> without burning cpu cycles at 100%.
>>>
>>> Ah, I see what you're saying, yes, you're right. In this case ignore my comment
>>> about ep_suspend_napi_irqs/napi_resume_irqs.
>>
>> Thanks for probing and double-checking everything! Feedback is important
>> for us to properly document our proposal.
>>
>>> Let's see how other people feel about per-dev irq_suspend_timeout. Properly
>>> disabling napi during busy polling is super useful, but it would still
>>> be nice to plumb irq_suspend_timeout via epoll context or have it set on
>>> a per-napi basis imho.
> I agree, this would allow each napi queue to tune itself based on
> heuristics. But I think
> doing it through epoll independent interface makes more sense as Stan
> suggested earlier.

The question is whether to add a useful mechanism (one sysfs parameter 
and a few lines of code) that is optional, but with demonstrable and 
significant performance/efficiency improvements for an important class 
of applications - or wait for an uncertain future?

Note that adding our mechanism in no way precludes switching the control 
parameters from per-device to per-napi as Joe alluded to earlier. In 
fact, it increases the incentive for doing so.

After working on this for quite a while, I am skeptical that anything 
fundamentally different could be done without re-architecting the entire 
napi control flow.

Thanks,
Martin


