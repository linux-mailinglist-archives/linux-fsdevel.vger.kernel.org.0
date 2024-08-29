Return-Path: <linux-fsdevel+bounces-27959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8119652AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C6928567F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ECA1BAEDE;
	Thu, 29 Aug 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fchfWzmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21C1B81C4;
	Thu, 29 Aug 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969557; cv=fail; b=heIL6IlLEekg4zRaH4v/KaRompcDn5zjGHTpgzq+U4993yOhWf0voeIgAs0mymeFcnpPJYFuSaSZc48oqrs1qNpoGHE4H7LphxYPJWc98B4tPNXhJMQBoUrEmK91l7KdHhsJbGXx5LCltDjemliNsZUHJunLHrv1LTk3fe1CF24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969557; c=relaxed/simple;
	bh=FOQasYtYRKy8wNp48AYC7O6BEh18fvNSrqKKnIeZwT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxsUvMUFcJGsRnKEQZhAPpFebGc98gbSQjTfCx9nxT7ZUhVu77JsNEi2K1R3Z+WEFYf4wTzhcWy3z7/qq59iDdsoFzN/mkzLzezIkaQZepbfHPY8lCKX6nVmCkeXhjTqCPWBlVqo2D4DvS/BfxoUUme3l8tL4yJajnzqVOah1Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fchfWzmq; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXpWGpjOw0cHaye3Zabrz2cK0mkdnzg1PEzrSbVc353m+TdlL6PN1X+NsG68/BN+Yya4QfgP74Kea/Yem+MfgdGWwMMSSTnG2+4baJBuim+0sJ2fqg5w5ZyZE6w4Iqd0beOKVO/eEc30TNYR0et49BuJsMwiNeV7Ia5j9CS6ANFB9MuWx6v53+BdDUHINAXxcaXCKedYp3eyHScg4PWqwqr9z68qiKmVWNIIePzmMqfmRSt6LOQeGTYhogMw/N3cr7JbX8H+ifV5sRpv1ZIfbirzaObrwpGBlTtE+HKiNDgZNBMP1wWN754yItGnaoXSE4OPltJeMlj810HdZsJ5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1DBFbnjay5tuHp59TdpHSLujQIcTprgWf1MSXJfXWY=;
 b=JxLuq17b1onRrj0OaJ67SznZJobmMzYTuw0ZhOvOd7ETG0m+QhKEejgLquARvdhjymM/ZVxSgWW7vT65TowIaS78SL1IF7AXiIy8XGGc5wNTE7mi5Y8KxL2mXJFTXUh8XB99NHG0JdbUmD9yVl7m3xfrm22yttm9REWQrY3frw69oqxPnqjf1GCV8NhyuzG2cQfoG16vjd4+hnb6BLP8Wxe2nHpv6hYCzNPEDeWQHqFyELnC/QB8YRmMJI3DVNGILAPzAL34zUy5XRuhirDwqoFxjHoMtDuf1wIR6MF7aaABZHNtFiqLjvP47nhDgT9hpRZTkwtmC3eWkySn4tRw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1DBFbnjay5tuHp59TdpHSLujQIcTprgWf1MSXJfXWY=;
 b=fchfWzmqhxh1CIaWrZM6mXaOIO2ZBtJFDY/34lfhaawx7deba27JZauBmTaLrBM6Q1Zpc86XLsZ/JR2ebx7YohmCcAuQxAHhiHROkL+ldGys2dTS2pjxr6Lmsk9T+gvNzciL3akvmGCLf60uuSN2cJNsuHDm5gsaHtEbqSF+Z0dOm8AkkWplSdi1bFOJhF7OTs7CdELldt2pkLNHk6HGJR449LpEL3H+RoJ3yFlSinbhlbuwrhugAdWFj1LakjW4IcqkG6VlP1F4uCwiFnk8/Ye6xp6amtr96tKkVtWU4qVbvsQaZEf1KRGzTBfEk3087q3L7qCZrY/HZ2MxH0ZQBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 22:12:31 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 22:12:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, brauner@kernel.org,
 akpm@linux-foundation.org, chandan.babu@oracle.com,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
 gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
 david@fromorbit.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, john.g.garry@oracle.com,
 cl@os.amperecomputing.com, p.raghav@samsung.com, ryan.roberts@arm.com,
 David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Date: Thu, 29 Aug 2024 18:12:26 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
In-Reply-To: <ZtDSJuI2hYniMAzv@casper.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com> <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9F69CAA1-B0E2-45C5-B30E-FD98B79017FB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a3f527-60c6-43bf-676f-08dcc877ad3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alI0SUcweEhmVDJpNyt2ZFdBVTZUS0c2RHVxUmh4N0sxVGptK1VwYjBKNjVP?=
 =?utf-8?B?aHpsS3J3UkVtWjF2QlBwNldzYTZyVUx4eEZybkp4cHdQbzdMSFp4Z3ZyNEo1?=
 =?utf-8?B?ZUZhN1AvTmV0NEhUMzBBdkZwVjR5eDd3OSs1STBnMU1tZWE2TVhqYnd2eThs?=
 =?utf-8?B?OUdNTk80aU9OTXRoSExwU2hLN0dTRVl3RGJ2ekxhYk1HenNWUXVZSW80eW5s?=
 =?utf-8?B?SEhlbkloNldXRElNcWNaamhua2pFSVpIemNKemZTd0FBZzRmWmZpdmpwakRQ?=
 =?utf-8?B?L0xsb3J1QnFXQ2FzYWdCWjlTK2VYSHNibUpESk1TU3lPVGc5b0VkMlhZUisv?=
 =?utf-8?B?SnpoeHp3c3MzaDJFdXJNQ3duekhIU0dVRkJkblpIUDBqZm9ISk5PQk05UzVZ?=
 =?utf-8?B?WWdCeGM4TlNOdGdFeHVONWNsaTZ3MmJDRFlmcEhKa085TFhvNUVOaTl3d1px?=
 =?utf-8?B?Vi9MQ21YdVA4RVVzaHlhaUpJQnJqN1doTjQ3NzAwZy9GOFNvaEZCQiszUWo0?=
 =?utf-8?B?RjNlMDlOMHYzK1pTanZaUHFEQ0dEWlBURWZrOExxeis0dDJqU0JKWWZhUEVG?=
 =?utf-8?B?SkFNODZKbllqdGYxemlZL3FoNHV1RTc1MUlIT1o5aXNwa0F4b0E3MmJERVd6?=
 =?utf-8?B?VlJjL1lBTnNkUlRQZnpiODZpQ2gwbDJXY1JHYVI2OWVpdTZFMXpSbVQ0YzMx?=
 =?utf-8?B?L2kwSEtWTGcxQ1dUSjFBT0V2VzdtMURUemErb1BNN0hNNDBzT2V0TXNWcUZa?=
 =?utf-8?B?aldLYk0weDNEZ0NqM1l3RW82TmJtYlRHcndzbklvWWRhT3V3TzhXRzdISk9J?=
 =?utf-8?B?K0pHTzJmQ0dqc2hwbEl0ZDlFNGFCaEFoZjlWWXZuZHNtM25ISHRzVzhqS0xV?=
 =?utf-8?B?c3JzMjNBOGxKSEtSbzRYTkhFWWRqeElMY1E5bTVRRWlNZkZCdE1QRWNtN0NS?=
 =?utf-8?B?cVZ6U3B5MkU1b3U5U1ZuVm4vVCtoVlBlcHFCaUdUaklJTE11V3hRQmYyZ29B?=
 =?utf-8?B?UURTRVJoNUpLT25FS0s0UGtwdkdDanRTUGhST0hvQmtwbW9rQ0xtWDJwTnUy?=
 =?utf-8?B?eG9sQWIyZTB1aFJDWXJ3eDVEOXAyTU54WlE5UitOSi95ZXhKWnBOa0ZyaWo3?=
 =?utf-8?B?VXlUM204anRjb0pFT0lYNUZnR0NQVDZXbThaMzBZWDczN1U0am1JYjNkaWdu?=
 =?utf-8?B?UmNuMFBscXd5T05jRnFTN1ZWdjB0eXpXa2VYVnVPbFdMU1BQVmdXeWhab1Fm?=
 =?utf-8?B?UzZiYzA0L05nYWJlN1U0TUtjU2NtR0h6U3M0bHRhb2t1aUQrUEYzaHhoSFVH?=
 =?utf-8?B?NW1FUW9aaFVUVFA5NFpuTXVnWXk3K0JsOHhVdGhpSThQOWg2MEc5NGQ4MzZk?=
 =?utf-8?B?b3BXR2dKdzVEWHRxMmhoVm5nZmVkZFAyTjlKa0RZT0tkNUVnOTJENDFqSVlj?=
 =?utf-8?B?Sm9uREgrallkQk1ZaW01SWlKbmZLSHYwbm9vL0hnU0xQY252dElBZFNQZ1ky?=
 =?utf-8?B?RWkwVjJFQWpoLzlOQTUwSHR5U0Eyc2NwbXlqZGN3czg0My9pM1k0MXhTNmJR?=
 =?utf-8?B?Z1QvZHk3cVU1NTlRTkdDdmdqVnd5Q3pZSmJ5WWpqUGc0Z2cvMTRVQjJpeUxB?=
 =?utf-8?B?anVSZ0RvUkxTK2l3Zkx0TzZRR1g5TlIzZWZ0MWxEd1lENTJuU3Ivb0pvZitR?=
 =?utf-8?B?WHpuNUpsZ2VOc1ZHdmE0L3YyNHNEM2tYcU8zZDNYeFVUcXR3T1BqZjEzdWdH?=
 =?utf-8?B?S2ZUaXdlUnMxUHpjNTlmUTlCU2RwWDE2OWk4Qjd0aGZRMlEwMmF4YmJERmcx?=
 =?utf-8?B?MjlzSm9CTUc0dHFxRWNydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVCUVpqSnV0U2NWRGdoT09Ld1lBeXF1SDE5S1V5T0NzZStwSWJpS1VXR3VU?=
 =?utf-8?B?NjA0Y1czaWQ3WTlUUkUreFM0RFNWUW9peUJpcndaVFN2QUYzam50SGl1VWdk?=
 =?utf-8?B?Y3lCbnRDa3NmY25zb2VHNFI3SUFqanE4MnBYQjBmNk0vdEFrSi9qWjJHNXNp?=
 =?utf-8?B?TUFVTFdnMjB4T0dvOUJXeGZjU2l5OGxzYWc0VkZkbFZKV29ZamJ3aGxNV1ZB?=
 =?utf-8?B?MzBKREluQi9oR1UwT0dVOERwbW1iREhPVzkyL1FudS9tSjNQNU9TMy94c0FW?=
 =?utf-8?B?YWhZVHJwK1ZaWSttZDBtMDJzSFIwRXNrZ2I5cU5YaGppMFVIQ0w0Zi9pNnJI?=
 =?utf-8?B?aVMzTGFNWjhEQm5ybFJHMzg3QUZSbUhXWTdYa3JKWmRsanlJT1gwanJCYmhy?=
 =?utf-8?B?WjZ2elhZT1I1ZlY4TzRVTGdsNy9CSEhmUmhKaElya1RZZmN1TkMyQU5OQnRr?=
 =?utf-8?B?T0s5NFNMYzEyYkE5b0V6YVkxOCtzVjFNYVBUaXZ1eW11UHhwSURTWjlvSitV?=
 =?utf-8?B?TzZkRGFsdWpDRUtaSE1INGpYT0ZyY0YxZTZkb0JHTm0vbkxBajZwL0F4SjlK?=
 =?utf-8?B?L25Lc1FPajRuOW1hYUFjdHlQRVg1dDlKSkl1ZTNIQU1ucktrR1ZBNkJad0Ni?=
 =?utf-8?B?dVZEVDVFeDk1Z1hPb1pTbDB3YXpDZ2gwOEVLWVJnMXR5RVFnVlFxUk1HVENT?=
 =?utf-8?B?aHFhSFIrekFJWUlERmlpZ0lsTTZyRENHNldiejFWYTBmcjlLRWcxK3lsdWZu?=
 =?utf-8?B?T1JMalZjUTd2cGZrKzNFeXRrM1NHRHlod085b09FdklYdDJRTmxDSlhHbHFa?=
 =?utf-8?B?WDFnbmFnOUJuZlZBbCtrTTRVWEtiYzRvYzhQc1hxWlk3ZUQ4SDNrNE5FbE1q?=
 =?utf-8?B?UGxpWUZZVXBzYWZ4dFN4d09EaWNBTUZLVTl0b0JLaHB0YlluQW9XTGFsd01O?=
 =?utf-8?B?a1dtUmFnR1Z6dEJFbVRmWmFMT1VnSXM1SVo3UjJsLzJPdFNxdXppUlRadTR5?=
 =?utf-8?B?UWRGQUV5ajJxeCtUSmFJZHJ0VHVZTDc2a2dPdzEyYSs3RmIrTU12Y2hGZThm?=
 =?utf-8?B?UjArV01uN2JRS2xWN3dJSnU5YUM1clpEbDFqKzVhODY5dHQzTFJ6Z0wyenJ5?=
 =?utf-8?B?czdCUXFpWFlBeko1aHU2MFhSV2Z4MDMzSlBrQkRxc0M2RFhXRUxueG82czB4?=
 =?utf-8?B?YzdTNlJ6clp5d1ZHYVI1cFlwY09zNXN3YlAreXFrbXRGWDluWmxEMkU3N3J4?=
 =?utf-8?B?SHpDeHZPajArMFA1TVRnSTRNei81aDM4TlgvTW1wYmwyU1FlS1BvM1ZTWUJH?=
 =?utf-8?B?ejBYT2FMK1JKN1FMTG5BeGdTYnl1TVdZVEVBQmpkUkM4WHZMMUg5NE5yNTJ4?=
 =?utf-8?B?emwvb2dxbktVSUFyVjVQenVrUVVUYkw3RytySk5CMDVSbldHWm9oK3Zkdit0?=
 =?utf-8?B?alhScDlvVjhGY1BsVXRMcE1rRHE3OG1uZnVoWktiRmxvcHE4WnEvampHZG1J?=
 =?utf-8?B?dStBUUNvM0wxZXppTWdwSG1pUlFUQ2c3bE1FbTBzTjJSQW84QlNWV1BzeGJu?=
 =?utf-8?B?K3VkYzJNNjZGYmlzVEVUVCswYm1xem84TTE4Q24zeTU5U1RMUUZJOVZkM1dZ?=
 =?utf-8?B?akQvblQyaWprQkJtTWliVmJRek9rUnhnWmxGRHNsYk5FWG1HS2pQNVZnb0M2?=
 =?utf-8?B?Z0FZTENQZGZUMXdyZG1yd01MRHZLbkwvTEZONTk5Smlha1B5SzcrOW96U3ZP?=
 =?utf-8?B?M0ZPMFVPQnB1dlJjcmIvWFo5WUR5WCtpandtWGE4VEQ0QVJZUDRSdUdlTnlM?=
 =?utf-8?B?ZVFVRDFJQWFTaWxWMGgvVG5LWDN1RTllZHdkUExlcndtaG9PZ2lxZXd2NXFz?=
 =?utf-8?B?YmphaWZDTjBoVDQvbUFMbWkwbHI3V2VEVHlBN2F5Z3dONmluQm43aEI1Znd3?=
 =?utf-8?B?ZGREZXlRcGJTY0hvT2VNOXpDZVVwUjl5RUNDZUtxM2p0YTk0VEh0R2ZBbUYr?=
 =?utf-8?B?NElHTDFQWTA2TjlidG5QZGVvd0sxZ2g2Qlg1cXlUcktyYzhOUUJ4VXVqTDVw?=
 =?utf-8?B?U2NEazR2dFFvaUQycnBrZFJ2NFVHNnBpRVA3RDRCeVpHTEgwUlh4dWxILzYr?=
 =?utf-8?Q?wq6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3f527-60c6-43bf-676f-08dcc877ad3a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:12:31.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neW2AMzSGzAFwKT33Hu9kRxGbn+KYrUsodeH6x+EMLlGjmrc/BhDn4XCE5TzXI/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

--=_MailMate_9F69CAA1-B0E2-45C5-B30E-FD98B79017FB_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29 Aug 2024, at 15:55, Matthew Wilcox wrote:

> On Thu, Aug 29, 2024 at 11:46:42AM -0700, Luis Chamberlain wrote:
>> With vm debugging however I get more information about the issue:
>>
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page: refcount:1 mapcount:=
1 mapping:0000000000000000 index:0x7f589dd7f pfn:0x211d7f
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: memcg:ffff93ba245b8800
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: anon flags: 0x17fffe000020=
838(uptodate|dirty|lru|owner_2|swapbacked|node=3D0|zone=3D2|lastcpupid=3D=
0x1ffff)
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 017fffe000020838 ffff=
e59008475f88 ffffe59008476008 ffff93ba2abca5b1
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 00000007f589dd7f 0000=
000000000000 0000000100000000 ffff93ba245b8800
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page dumped because: VM_BU=
G_ON_FOLIO(!folio_test_locked(folio))
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: ------------[ cut here ]--=
----------
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: kernel BUG at mm/filemap.c=
:1509!
>
> This is in folio_unlock().  We're trying to unlock a folio which isn't
> locked!
>
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Oops: invalid opcode: 0000=
 [#1] PREEMPT SMP NOPTI
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CPU: 2 UID: 0 PID: 74 Comm=
: ksmd Not tainted 6.11.0-rc5-next-20240827 #56
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Hardware name: QEMU Standa=
rd PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RIP: 0010:folio_unlock+0x4=
3/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Code: 93 fc ff ff f0 80 30=
 01 78 06 5b c3 cc cc cc cc 48 89 df 31 f6 5b e9 dc fc ff ff 48 c7 c6 a0 =
56 49 89 48 89 df e8 2d 03 05 00 <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 00=
 90 90 90 90 90 90 90 90 90
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RSP: 0018:ffffbb1dc02afe38=
 EFLAGS: 00010246
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RAX: 000000000000003f RBX:=
 ffffe59008475fc0 RCX: 0000000000000000
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI:=
 0000000000000027 RDI: 00000000ffffffff
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RBP: 0000000000000001 R08:=
 0000000000000000 R09: 0000000000000003
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R10: ffffbb1dc02afce0 R11:=
 ffffffff896c3608 R12: ffffe59008475fc0
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R13: 0000000000000000 R14:=
 ffffe59008470000 R15: ffffffff89f88060
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: FS:  0000000000000000(0000=
) GS:ffff93c15fc80000(0000) knlGS:0000000000000000
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 000=
0 CR0: 0000000080050033
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CR2: 0000558e368d9c48 CR3:=
 000000010ca66004 CR4: 0000000000770ef0
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1:=
 0000000000000000 DR2: 0000000000000000
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6:=
 00000000fffe0ff0 DR7: 0000000000000400
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: PKRU: 55555554
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Call Trace:
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  <TASK>
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? die+0x32/0x80
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_trap+0xd9/0x100
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_error_trap+0x6a/0x90=

>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? exc_invalid_op+0x4c/0x6=
0
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? asm_exc_invalid_op+0x16=
/0x20
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ksm_scan_thread+0x175b/0x=
1d30
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_ksm_scan_thread+0=
x10/0x10
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  kthread+0xda/0x110
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10=

>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork+0x2d/0x50
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10=

>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork_asm+0x1a/0x=
30
>> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  </TASK>
> [...]
>> Looking at the KSM code in context ksm_scan_thread+0x175 is mm/ksm.c r=
outine
>> cmp_and_merge_page() on the split case:
>>
>>                 } else if (split) {
>>                         /*
>>                          * We are here if we tried to merge two pages =
and
>>                          * failed because they both belonged to the sa=
me
>>                          * compound page. We will split the page now, =
but no
>>                          * merging will take place.
>>                          * We do not want to add the cost of a full lo=
ck; if
>>                          * the page is locked, it is better to skip it=
 and
>>                          * perhaps try again later.
>>                          */
>>                         if (!trylock_page(page))
>>                                 return;
>>                         split_huge_page(page);
>>                         unlock_page(page);
>
> Obviously the page is locked when we call split_huge_page().  There's
> an assert inside it.  And the lock bit is _supposed_ to be transferred
> to the head page of the page which is being split.  My guess is that
> this is messed up somehow; we're perhaps transferring the lock bit to
> the wrong page?

The issue is that the change to split_huge_page() makes split_huge_page_t=
o_list_to_order()
unlocks the wrong subpage. split_huge_page() used to pass the =E2=80=9Cpa=
ge=E2=80=9D pointer
to split_huge_page_to_list_to_order(), which keeps that =E2=80=9Cpage=E2=80=
=9D still locked.
But this patch changes the =E2=80=9Cpage=E2=80=9D passed into split_huge_=
page_to_list_to_order()
always to the head page.

This fixes the crash on my x86 VM, but it can be improved:

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7c50aeed0522..eff5d2fb5d4e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -320,10 +320,7 @@ bool can_split_folio(struct folio *folio, int *pextr=
a_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head=
 *list,
                unsigned int new_order);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
-static inline int split_huge_page(struct page *page)
-{
-       return split_folio(page_folio(page));
-}
+int split_huge_page(struct page *page);
 void deferred_split_folio(struct folio *folio);

 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c29af9451d92..4d723dab4336 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3297,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct page *=
page, struct list_head *list,
        return ret;
 }

+int split_huge_page(struct page *page)
+{
+       unsigned int min_order =3D 0;
+       struct folio *folio =3D page_folio(page);
+
+       if (folio_test_anon(folio))
+               goto out;
+
+       if (!folio->mapping) {
+               if (folio_test_pmd_mappable(folio))
+                       count_vm_event(THP_SPLIT_PAGE_FAILED);
+               return -EBUSY;
+       }
+
+       min_order =3D mapping_min_folio_order(folio->mapping);
+out:
+       return split_huge_page_to_list_to_order(page, NULL, min_order);
+}
+
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
        unsigned int min_order =3D 0;
--=_MailMate_9F69CAA1-B0E2-45C5-B30E-FD98B79017FB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmbQ8koPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKx4wP+wWAD+EmhcgJyx8+/t97yDe+LhnUVQa0mAQw
+MTqUvK7vPqhsZTLZUsCqNeJTVJKj1jp/LTZ9fkhOcc6tECR3WCDRHWdsurbPSsn
nIW4dWlkxSH22ZZwycOLePCBS03A5V4ya8o4OuKzaosqBIs1PAXVLaAeqDGhCgAx
K0yP+q0bF3RcyS9Q2uYK9haFWE9m85EV7oF3uuNuOFdapmq7aSafVZyZV4DJryTw
JY7W9G6Uqr9DA23qUYftTGioM71MRu30GwP/Ltq4GwZvgJLdtsflQYZjEIS1UyM5
PWrVKiWpCc+l4zjGswC9yvKrDYBsuJzKYQwzj3NLHD6rhEbW3aHI23MJrSDJt9y6
k1Va1KB3PzWyT1UuHW4TDj4PCiKOhQzAOrih4KVMlNLfgYvG5ieRbzfMt4wB+fU3
gPIml96SSIL8FbPfaQXLTFIf6WVFUQDBTNoDvKBtjvEaOoL6b27zzAwot96fivHt
4E6WyK3k8EC7321ILj5juKjd6BI2LyfFXv0KPDiRbc7r2BzNk87iiJ1tiVJQ3zGB
TthGNL1t2NQumpUml4zXXYyoHrYW1nS/Zsl/2kD9lhYh9ogP2ilUENDgk4ZPA8fH
qZJizmm3sXmI32xJDSMJjHTxFfURgxZjznFFGcWdXeVSoA7vpjXiPx+JinsXUSeg
U0ikvtVP
=mYNy
-----END PGP SIGNATURE-----

--=_MailMate_9F69CAA1-B0E2-45C5-B30E-FD98B79017FB_=--

