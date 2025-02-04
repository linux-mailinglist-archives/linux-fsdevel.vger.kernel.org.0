Return-Path: <linux-fsdevel+bounces-40790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B7A27B11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DE162E98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4602165E8;
	Tue,  4 Feb 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUH1UGeU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB378F40;
	Tue,  4 Feb 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696960; cv=fail; b=h74wfWZnUg4rGWy2iVeyt1IEwUquqjp41jqNGy307ojM5TJTJCGv1wgq4TyAOEZyNJNCA8jVBE2vAXMDzv4zSstN+quJ+wDsUJMSguVTi6cIRghsdmpjZ6DgieCneVsKXYgNIcdtUgT+OmtjfQ0gqMO9e/vsA8b3oPneMonr+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696960; c=relaxed/simple;
	bh=PG0fOuwGu9s1KB9nS682b0TdFro3YmZvT4nuf9QITUg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OvEqHKTrvqOam9S+bUKmMIYvkz58pt47ZczxQFdG9kY+vfo0D5Z4XNDws7kItL0X3cuErdEU/TN1gN4LTpshgzt13s4mduVS2/YuDHfJoqerKMW2aMC/8vszSFcyEcsx73O7kA0gaO301YBe3c0+/2kR8QepPrj4hwAaecn3HV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUH1UGeU; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTyPWT2cH6CQo+TpEcykztVEqO0vpesY2hnQpYRwkCTsgGXKDyvuXvc2WOaGLwn7uF/JCfyuJHcb27af6zCJwP7k+dFj3m1Sxh3gYKXuB9h/xM7j+qP+KFyYiAFf+/cCI3sHN4ICyei6HoBlQUhFvsFXc5Y98t7ojuNk/4yH7avXMkzs3Y+iiSHElMVo7Mn05DTgt9BoExJVmqqx857cAKWoVOjAsxtc2BtXv0chWoWX1MoXxhdVxVV6OhbXFVe9yh8mipbzhPwBOtAcoFGg1nplmHe+Q5ALGBSs53LWiJBFtwPc72/imIE+cnrqm7lwSQqVoHnci1JB7ory0O0Vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG0fOuwGu9s1KB9nS682b0TdFro3YmZvT4nuf9QITUg=;
 b=ev7I7doYoP1cyMAgUfOqb7OQp/dz8lFgPDuIivz6GIgLUEcXreIT708CsJV/Z4gCLFf30E3NmHASMnRK5xjKiygCcisCWq/z91cSnNzm6XW0iD7jt5oxt0B6R4BR9gGma0eQ8drF96re++KqTYwSMGY4N/gi48ZOtfdQ2kh2wM4fooTNNh8jyeULMllLHE+XNPcexrwI0oTPweNYfDek56aLynNQG0FhpJoQF3YIk/9Km8E5o9aHwHCR/oXwG9bQeY3rQKiGyp9YjfNLkXGcabg4FSDh/tKfP3iQzUjUewnk7687XnaerX3EUINuHneLKSWyqvOTvlX1AbIFwEbU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG0fOuwGu9s1KB9nS682b0TdFro3YmZvT4nuf9QITUg=;
 b=kUH1UGeUb7T+B73pUfJG3Xq4Zv+LWqW6PxDV69oCm6B3aJZwhrxZw8NGi81zIJBPM4mBHYp/rg1OfMIKw0PTClzAjH6iE/X5b8fzifIVdec20kI9Gh0Ttw3+W8d2oTUXcxRaFZTKI4j0rFhmPRgGFZO6R4wHH66VPpqKnhCSF3q0V6FXrKV/1nyX631nVNpda7KeUHqLNOV1Ja8maEydbUbJg9ZkkDrOh68VTJTxOuk3DiR+OGocJ5dj0tejaPiNu2bJJOIGIX/B0xbqd+ElrvCexDxs7qCysTawEgLpOira0g+SZu7sI4/8aC9GeocgJuroz8vCGzUqAiDLsMy+iw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 19:22:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 19:22:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
CC: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	"javier@javigon.com" <javier@javigon.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>, "jack@suse.com"
	<jack@suse.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>, Sagi Grimberg
	<sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, Daniel Wagner <dwagner@suse.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "mhocko@suse.com"
	<mhocko@suse.com>
Subject: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] blktests: status and
 improvement plan of the storage stack test framework
Thread-Topic: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] blktests: status and
 improvement plan of the storage stack test framework
Thread-Index: AQHbdzol36IDltcr206UdnVhXgiNHg==
Date: Tue, 4 Feb 2025 19:22:35 +0000
Message-ID: <4808049f-6b8f-49ae-93d9-38f05cb54edc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4219:EE_
x-ms-office365-filtering-correlation-id: 0691aaf7-c633-443a-566b-08dd455147c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXdST3BIVmxIUHNUSnZWeks4Tmt0RnlwaWlIWWpydmc5aXNUbEhqSkVrZDdD?=
 =?utf-8?B?b0VROHVsN2wrWUNNQngwVjQwN3ozYWhMNmFva21HclpWNFByMmt1SnRNVEJx?=
 =?utf-8?B?cDNDTCtmVENjZjhOV2pTT1ZZRmZlbWE2ZFFzSXI0ZUxyR3FEQ0RzSjc2Uko4?=
 =?utf-8?B?Q0FZd1IvR05RZmkxbFk4UmRlZ2dxVGRCRTVGQm5aRktMajA4TFJpYkQwYnN2?=
 =?utf-8?B?ZVpKVEl3cGdvUTdRMjZaY3drNGxmOVZlSlVYU2xFUXF2RzF5UFBveXdxdU9Y?=
 =?utf-8?B?YTBLaUZXWGE1QXlTT1A4WkNYYkxCOWx6K1BlVEhQNGwvZ3Q0YUJza0tzTTgw?=
 =?utf-8?B?Zzc2VG1rdk4rM1ZYK2htdUVwUEQ2eEM1d2RuandzU0VqZldFaHlIYnU5R2pY?=
 =?utf-8?B?VDlOR0pUclZpd3NJQ1g4Mm0xMjlZMVRXaUdhZG1Vemk5aHlzQVNtcEMvRytV?=
 =?utf-8?B?bmtVcS9TWEJUcGdKN2NySjdhZWZGTTlXaldoQkx4TDVrUmlQNEh0clQ3VGZx?=
 =?utf-8?B?NFcxczJNeHRxc3UzYUtibFdoZWE5YWxaYVh6MjRtcmw3ODU5RjR2LzB3YXlC?=
 =?utf-8?B?YmNXbUZzQm84cnpSWkhwZ1UydkVKUUN6RHNiTVhIcmVDWVJUb090ZDdwTUFj?=
 =?utf-8?B?OVdtc0FBRFQxT0E1WGY3bjF1WXI1TnlCbW8yckVNWG5vVk1YckQ3VmtqbEpZ?=
 =?utf-8?B?SXdNSzhDU2YydGtQN1MwQkp4NjYxeFNhcmJYMWpjakpxcVJoOVY4bUhCclhU?=
 =?utf-8?B?R3ZBQWppMHM5VVFRdWlmbFVpanM5OEpNWWhoczJ2dFF5bkVoU3BPTUNOZE5q?=
 =?utf-8?B?SkJWdTFCVml4WDh6ZjNhcXliZWhZSjB0UlZ1bk8xZFFrQU8rRHdhVDFnZjRN?=
 =?utf-8?B?SGUwZ1hWSjZkSjE1THhISi9qUVRUY1A3UUQzV0paUHhOK0VvWHZRd1QwTHJO?=
 =?utf-8?B?TzVTRFlLRy93TUtoV2E3SG15SlE5YXBNN3BrL1VWalZ5N3VUNjJhSXhvbDFW?=
 =?utf-8?B?Z1FVU2t0cU13OWV0V3EyS0daemkrWUx3dm1xcnJsa3VPa0wrZ2hVb1pPaDk2?=
 =?utf-8?B?NWtxcEJhTUlyLzBpVGRTWStBNkxtdUVLVmNPSVg1dzc0V29neWk0dCtBbkty?=
 =?utf-8?B?V2NxNFFWa0cyYVpLcHRIK1UrRVhzUy9JeVp1VDFvMFVzK21xYUtDNCsxS0t5?=
 =?utf-8?B?RlI3YzJ6SWFOZzJNZUhIMWs5anAvUXdabWRkOWFoZnZPTFFSM3pudDVSZlh4?=
 =?utf-8?B?dVJNQms5Qy85Y0F5bC9TM2ZURklpTU1LRWxMMGx1U2VmVDhhcEN0WUUrbi9R?=
 =?utf-8?B?Sis1aU9FbXc3bjdQeTBpWmtvWjN3NFRXYlBYN3dELzRnazVVUXNaMFg0eHBF?=
 =?utf-8?B?VW9iWDJvSDN0UlRPUlhVWVYwSEk4WVEzRnNpSFhyN1NuYnE0N09xaVYzVE5F?=
 =?utf-8?B?QTFQSURpMzk0ZjRMYXBOdVBEMStZRS9ocHBDU3IyaGtVUDdhbnZTQ25QQXcz?=
 =?utf-8?B?WDFXNTEzZ0NlNXVFcFBXV3pRNFhVd1pjQmErUGUvK1VodVFIMXVqc3hNUHVZ?=
 =?utf-8?B?WGxnaW91VGdPS1VwU3RJbEJDdkV4SWdHd2lqZnAvQ292SmY4QXZIUnptSEV4?=
 =?utf-8?B?V2lSSDk4U2ZoVFNZR2FDT2djOG4xbjlNMkdFcSt3cUdUbWw0elNWb1RBa25Y?=
 =?utf-8?B?US8yb1hlNkdQV2h3OEpMTmlKQmNZL3EweVJtWWNiVVA1QXpPd3lkV0JKbEp0?=
 =?utf-8?B?RnhPRi8xeU9Kamx5N3FuRk1xWTFqMm5Gc3ozY0JtU2NwTURkU1NrUXVXQjRu?=
 =?utf-8?B?TXVDZ0dWSmRsV1lIcHVOZzlEN3B1SWFqeUl6RllLcmxtdE9pTENQY2ZQenFK?=
 =?utf-8?B?elRUQkJsQzhCWFVYbkpzUGlwMS9XbnFTOHR6ZkVqL1NZdXA1MEZvbTBqQzFm?=
 =?utf-8?Q?wZf8MeHnVkqjH+BdXOAXOas0fPt83kRE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWhoaHFGdUFFU1lGd2srYWUzTXowUjVxYnpIRGw4ZWFGenBleEc3Nm5acGZN?=
 =?utf-8?B?YWNXeFNZZDlYdFNKWEJUblVQblFHSFRpekpDSmxZL2hXN1dBMUY0RFoyVzFF?=
 =?utf-8?B?RWxPYXE2dWpyVzhxaFdKRGtlT0dOb2dHbzJ2ZWlQL0hwVUd0UGJJcUZWSFd5?=
 =?utf-8?B?N3NBRTFPZUJJcWlrWTc3RysrNkJENElybkxKQzIvaE5SejBnMzNqVGIrN2lS?=
 =?utf-8?B?cElCdmMrL2llcWJHWUdWaWdPRkdKMHhEaWNQSFFEaXZzNklKY3JnaHpsZHV1?=
 =?utf-8?B?cDcwMzhwUnQrTnNQZ0hvMW1BTDhuay84MVhpRDlYbm11dGRzVkNYWGU4RmIx?=
 =?utf-8?B?WGE2Ni9DRXp0QklOME16NmZPQVRCTHR3YmxEcDJGcmZhYS9pUjRabGExUmp2?=
 =?utf-8?B?eHpvU1I4R1daY2VuSjYzOUtVdHhjMlczTVFGYS9xY3JJWGJoZm9UVHEvT1VY?=
 =?utf-8?B?S3NpMGJ5Mk1jWjJ3YnhBd3ViSGQ5aGVCSC9oZUtiUjJ5OFF6NUl4YnFWNld2?=
 =?utf-8?B?SEpiT2Z2V1dUY3QyOE9CR3dYN3J0MXBvcXUvVWVkRXNSWk9ZemFLTUx1cGFM?=
 =?utf-8?B?RTBvSTl1YmRQRTFhZTA2dnVNK3M3M2tlNXhEVjhvKzlVVmprbHpmUDk5MTRo?=
 =?utf-8?B?Uk9EVGVRaTNJZmZ5cTd1RElzcVRNUmV4NzcraWdFQSt3OWJRdDM2ZEl1QmlK?=
 =?utf-8?B?YUsyYjh1N0N0U1l0MGRYYUJsTmlDenpWVC90NFpFQ2tyenBPM3dRM1pyMkpW?=
 =?utf-8?B?TGpVb0xHeVhNT3A1czhVRWIweCtrSjJFOWROd0hqOXIrVzNwb2xHK2UrY1I2?=
 =?utf-8?B?VEdNZmh1Nyt2a3dJWTdiMjg4dUkzK25CR3hCSGZkSk9ac2VTUFVlN1QzOHhV?=
 =?utf-8?B?c2RUQWwyUGxWcytpdE8vdy84aFgrOFVjSUVrR1hReDFnWU11bWxMVnFpaU5u?=
 =?utf-8?B?UWpPaDY0RStzZjJWYThESzNNTFd4T0ZVTkVZUmNWSDUvSHEzS2QzK0dMa0R5?=
 =?utf-8?B?QkY4RDVlOGY1TlFZSm95NmVPOGFhZWU4YUxvTFNPL0VZeFFmeEIzdWpmNFlW?=
 =?utf-8?B?KzZmdnNmU0xkT1RHY2pEa0hvWU1wQ0RmaTZWSkM2L3dBSStKd2hGdlJjRTRq?=
 =?utf-8?B?K2dvZzlWRkxKbW5SenhXZTYrU09QbTlxbUhvZm03eFZnbmNPUGd1Zy9QRTUx?=
 =?utf-8?B?Uy8zNE1XZmRjM3dUN0cwSmE2dTd1VStwT1NVa0tvd0ZSNk1UYndtRzlXN0Jn?=
 =?utf-8?B?U0NHUTZFSFV4dHVDVmNyNnU1cFU0N3VwdzZKS25tblJsL21UNU1PRkZyTXll?=
 =?utf-8?B?VjhxaEdTa3ZCOXBsNmMwUnhmeThqNkRBZFhnTHZ6WTg5MnEyQXcwZElZckRQ?=
 =?utf-8?B?QnhKbEkxNHBEVDRPNWYrTlF1QVAvSjNnZlhsNUVQZUxJVkZwTTJlcWEybmFS?=
 =?utf-8?B?VUx3RlhrSllEdEhvY2hTQWhiWjljOGpqTnp5b0dvY1V5ZFVNQVJVME95a1RF?=
 =?utf-8?B?NEEyanE2U2FDaE5kRHkxSDMzNnJzL2hNU2xxMlppWUtZK2s0QSt1WlNJZ0xi?=
 =?utf-8?B?cG5YUkNEYVd0QldlSVlheFk0TkJQbFdabkR2S3lkZHNHcUhPbXEweG5IRTdB?=
 =?utf-8?B?dHR0aVBUd2VzdXppdkhsUElKQ2dQY1BHTGh4bzM3THkvTXQvamtBSjZrN1Vy?=
 =?utf-8?B?aTZ6VXRncTRVeldDNG56NGtVb0M0TUZDS0R3RFB0WVRxcktzSGtsTnhIVElD?=
 =?utf-8?B?UWN4dFEyLzdPekhtZHg2Z1Z4MlpZenFwNDQ0SzBDYjVEYXlDSlR2blBOUzFu?=
 =?utf-8?B?VTA0M1JOb2RTeVF6MHhGRG9Jci9JdkRuclplNzdrenY0UVY4MDZ5Yno0eW40?=
 =?utf-8?B?c3BKZ3YyUTRqWEZGV1JOeEdNb2JXc2NRYnVNM3VObmpnakVUSCtrcVlpMUFU?=
 =?utf-8?B?dnJ1cXpPbGVISDNRcjYrdW1KU0xRdzd5blJzRmR1MVBQclVMeWFWUE5MdHBx?=
 =?utf-8?B?NUh0VThWYi9QckhZRzZ4SVk4ZEV1Qk9aWnpVdUthNnFEVnVOYVpxdUo0SGNK?=
 =?utf-8?B?QU11QlFsTEJLTUxJYS8vWE9ZUmhQYjMxVlBNWmtDZ05yOXF1dzVOajlnOXp4?=
 =?utf-8?B?VGFhWm94MU1XdkpMWXRNZU5rNWpMYkNYZWwxMHE1c1RUSTZJSzBUMktlRS9L?=
 =?utf-8?Q?7doqq4F98gkIl18AAGoAzkCdXE+XU7HwOhymRON8EQmj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BA1C4ED8DC51F41A978E8E930E57F51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0691aaf7-c633-443a-566b-08dd455147c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 19:22:35.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reW9Yk/l/lEiAPc/sel2XfRjylScmcOS7C8Fer8Tp5azRfBkHrPGwRRnNqq4z8J+X/COwZCwAGfLa8j0WfPaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219

SGkgYWxsLA0KDQpTaW5jZSB0aGUgZGlzY3Vzc2lvbiBhdCB0aGUgTFNGTU0gMjAxNyBbMV0sIE9t
YXIgU2FuZG92YWwgaW50cm9kdWNlZCB0aGUgDQpuZXcNCmZyYW1ld29yayAiYmxrdGVzdHMiIGRl
ZGljYXRlZCBmb3IgTGludXggS2VybmVsIEJsb2NrIGxheWVyIHRlc3RpbmcgWzJdLg0KQmxrdGVz
dHMgc2VydmVzIGFzIHRoZSBjZW50cmFsaXplZCB0ZXN0aW5nIGZyYW1ld29yay4gSXQgaGFzIGdy
b3duIHdpdGggdGhlDQpsYXRlc3QgYmxvY2sgbGF5ZXIgY2hhbmdlcyBhbmQgc3VjY2Vzc2Z1bGx5
IGludGVncmF0ZWQgdmFyaW91cyBzdGFuZC1hbG9uZQ0KdGVzdCBzdWl0ZXMgbGlrZSBTUlAtdGVz
dHMsIE5WTUZURVNUUywgTlZNZSBNdWx0aXBhdGggdGVzdHMsIHpvbmUgYmxvY2sgDQpkZXZpY2UN
CnRlc3RzLiBUaGlzIGludGVncmF0aW9uIGhhcyBzaWduaWZpY2FudGx5IHNpbXBsaWZpZWQgdGhl
IHByb2Nlc3Mgb2YgDQpibG9jayBsYXllcg0KdGVzdGluZyBhbmQgZGV2ZWxvcG1lbnQsIGVsaW1p
bmF0aW5nIHRoZSBuZWVkIHRvIGNvbmZpZ3VyZSBhbmQgZXhlY3V0ZSB0ZXN0DQpjYXNlcyBmb3Ig
ZWFjaCBrZXJuZWwgcmVsZWFzZS4NCg0KVGhlIHN0b3JhZ2Ugc3RhY2sgY29tbXVuaXR5IGlzIGFj
dGl2ZWx5IGVuZ2FnZWQsIGNvbnRyaWJ1dGluZyBhbmQgYWRkaW5nIA0KbmV3DQp0ZXN0IGNhc2Vz
IGFjcm9zcyBkaXZlcnNlIGNhdGVnb3JpZXMgdG8gdGhlIGZyYW1ld29yay4gU2luY2UgdGhlIA0K
YmVnaW5uaW5nLCB3ZQ0KYXJlIGNvbnNpc3RlbnRseSBmaW5kaW5nIGJ1Z3MgcHJvYWN0aXZlbHkg
d2l0aCB0aGUgaGVscCBvZiBibGt0ZXN0cyANCnRlc3RjYXNlcy4NCkJlbG93IGlzIGEgc3VtbWFy
eSBvZiB0aGUgZXhpc3RpbmcgdGVzdCBjYXRlZ29yaWVzIGFuZCB0aGVpciB0ZXN0IGNhc2VzIA0K
YXMgb2YNCkphbnVhcnkgMjksIDIwMjUuDQoNCiDCoMKgwqAgYmxvY2vCoMKgwqDCoMKgwqDCoCA6
wqAgMzYNCiDCoMKgwqAgZG3CoMKgwqDCoMKgwqDCoMKgwqDCoCA6wqDCoCAyDQogwqDCoMKgIGxv
b3DCoMKgwqDCoMKgwqDCoMKgIDrCoCAxMQ0KIMKgwqDCoCBtZMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDrCoMKgIDENCiDCoMKgwqAgbmJkwqDCoMKgwqDCoMKgwqDCoMKgIDrCoMKgIDQNCiDCoMKgwqAg
bnZtZcKgwqDCoMKgwqDCoMKgwqAgOsKgIDUwDQogwqDCoMKgIHJuYmTCoMKgwqDCoMKgwqDCoMKg
IDrCoMKgIDINCiDCoMKgwqAgc2NzacKgwqDCoMKgwqDCoMKgwqAgOsKgwqAgNw0KIMKgwqDCoCBz
cnDCoMKgwqDCoMKgwqDCoMKgwqAgOsKgIDE1DQogwqDCoMKgIHRocm90bMKgwqDCoMKgwqDCoCA6
wqDCoCA1DQogwqDCoMKgIHVibGvCoMKgwqDCoMKgwqDCoMKgIDrCoMKgIDYNCiDCoMKgwqAgemJk
wqDCoMKgwqDCoMKgwqDCoMKgIDrCoCAxMg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiDCoDEyIENhdGVnb3JpZXPCoMKgIDogMTUxIFRlc3RzDQoNCg0KRm9yIHRoZSBzdG9yYWdlIHRy
YWNrIGF0IExTRk1NQlBGMjAyNSwgSSBwcm9wb3NlIGEgc2Vzc2lvbiBkZWRpY2F0ZWQgdG8NCmJs
a3Rlc3RzLiBUaGlzIHNlc3Npb24gcHJvbWlzZXMgdG8gYmUgYSBncmVhdCBvcHBvcnR1bml0eSB0
byBjb2xsZWN0DQpmZWVkYmFja3MgZnJvbSBzdG9yYWdlIGRldmVsb3BlcnMuIFRoZSBzZXNzaW9u
IHdpbGwgY292ZXIgZm9sbG93aW5nIHRvcGljczoNCg0KMS4gQmxrdGVzdHMgYXMgQ0kNCg0KIMKg
wqAgQmFzZWQgb24gZGlzY3Vzc2lvbnMgaW4gTFNGTU1CUEYgMjAyNCwgdGhlIHByaW1hcnkgZm9j
dXMgd2lsbCBiZSBvbg0KIMKgwqAgYWRvcHRpbmcgYmxrdGVzdHMgYXMgYSBjb250aW51b3VzIGlu
dGVncmF0aW9uIChDSSkgdG9vbC4gV2hpbGUgc29tZQ0KIMKgwqAga2VybmVsIENJIHByb2plY3Rz
IGFscmVhZHkgZXhlY3V0ZSBibGt0ZXN0cyBmb3IgdGhlIGxhdGVzdCBrZXJuZWwgdGFncywNCiDC
oMKgIHRoZXJlIGlzIGN1cnJlbnRseSBubyBhdXRvbWF0ZWQgYmxrdGVzdHMgcnVuIGZvciBlYWNo
IGtlcm5lbCBwYXRjaC4NCg0KIMKgwqAgU2hpbmljaGlybyBpcyB3b3JraW5nIG9uIHNldHRpbmcg
dXAgYSBibGt0ZXN0cyBDSSBlbnZpcm9ubWVudCwNCiDCoMKgIGluc3BpcmVkIGJ5IHRoZSBhcHBy
b2FjaCB1c2VkIGJ5IGxpbnV4LXJhaWQgWzNdLCBsZXZlcmFnaW5nIEtQRCBbNF0NCiDCoMKgIGFu
ZCBQYXRjaHdvcmsgWzVdLiBUaGUgZ29hbCBpcyB0byBzaGFyZSB0aGVzZSBmaW5kaW5ncywgZ2F0
aGVyDQogwqDCoCBmZWVkYmFjaywgYW5kIHJlZmluZSB0aGUgc2V0dXAgZnVydGhlci4NCg0KIMKg
wqAgQWRkaXRpb25hbGx5LCBJIGhhdmUgYmVlbiBhY3RpdmVseSBsb29raW5nIGludG8gb24gYmxr
dGVzdHMgQ0kgc2luY2UgDQpsYXRlDQogwqDCoCBsYXN0IHllYXIuIFdlIHdvdWxkIGxpa2UgdG8g
cHJlc2VudCBvdXIgcHJvZ3Jlc3MsIGRpc2N1c3MgY2hhbGxlbmdlcywNCiDCoMKgIGFuZCBzZWVr
IGlucHV0IGZyb20gdGhlIGNvbW11bml0eSB0byBoZWxwIGJ1aWxkIGEgcm9idXN0IGJsa3Rlc3Rz
IENJLg0KDQoyLiBBbnkgbmV3L21pc3NpbmcgZmVhdHVyZXMgdGhhdCB3ZSB3YW50IHRvIGFkZCBp
biB0aGUgYmxrdGVzdHM/DQoNCiDCoMKgIEZvciBpbnN0YW5jZSwgbGFzdCB5ZWFyIHNhdyB0aGUg
YWRkaXRpb24gb2YgcmVtb3RlIHRhcmdldCBzdXBwb3J0IHRvIHRoZQ0KIMKgwqAgbm12ZSB0ZXN0
IGNhdGVnb3J5LCBhbmQgaXQgd2FzIHVzZWQgZm9yIHRoZSB0ZXN0IGNhc2UgbnZtZS8wNTYgKG52
bWUtdGNwDQogwqDCoCB6ZXJvIGNvcHkgb2ZmbG9hZCB0ZXN0KS4NCg0KMy4gUG90ZW50aWFsIGFy
ZWEgdG8gZXhwYW5kIHRoZSB0ZXN0IGNvdmVyYWdlPw0KDQogwqDCoCBGb3IgaW5zdGFuY2UsIGxh
c3QgeWVhciBzYXcgdGhlIGFkZGl0aW9uIG9mIHRoZSBuZXcgdGVzdCBjYXRlZ29yaWVzIHN1Y2gN
CiDCoMKgIGFzICJ0aHJvdGwiLCAibWQiLCBhbmQgInJuYmQiLg0KDQo0LiBBbnkgbmV3IGtlcm5l
bCBmZWF0dXJlcyB0aGF0IGNvdWxkIGJlIHVzZWQgdG8gbWFrZSB0ZXN0aW5nIGVhc2llcj8NCg0K
VGhlIHNlc3Npb24gYWxzbyBhaW1zIHRvIGNvdmVyIG90aGVyIHRvcGljcyByZWxldmFudCB0byBi
bGt0ZXN0cyBhbmQgdGhlDQpicm9hZGVyIHNjb3BlIG9mIHN0b3JhZ2Ugc3RhY2sgdGVzdGluZy4g
VG9waWMgc3VnZ2VzdGlvbnMgd2lsbCBiZSB3ZWxjb21lZC4NCg0KLWNrDQoNClsxXSBodHRwczov
L2x3bi5uZXQvQXJ0aWNsZXMvNzE3Njk5Lw0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92
L2Jsa3Rlc3RzDQpbM10gUHJlc2VudGVkIGJ5IFBhdWwgTHVzZSBhbmQgU29uZyBMaXUgYXQgTFNG
TU1CUEYgMjAyNCwNCiDCoMKgwqAgaW4gdGhlIHNlc3Npb24gIlByb2plY3QgcGVyIHBhdGNoIENJ
IHRlc3RpbmciLg0KWzRdIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9va2luY3ViYXRvci9rZXJu
ZWwtcGF0Y2hlcy1kYWVtb24NCls1XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtYmxvY2svbGlzdC8NCg==

