Return-Path: <linux-fsdevel+bounces-9035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9583D311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 04:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD391C234B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 03:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB71B662;
	Fri, 26 Jan 2024 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+ndfRQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A1B642;
	Fri, 26 Jan 2024 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241059; cv=fail; b=EK4lc6PjgUf4Kx/KNV16pyBN7y8VGwMu3zXvBpXyVb4lYikV48MKL9Lk0mbry6vOXMsuOlqjsCOfpTdcVOWyyVQvroeZZ57rM4UUeJS6Y6LVhu9vIqTFJ25dB0sQywufzmLcbcdAkCN5pKlFyhK7UoxG2KJ2D1ThIzcF2JF2wO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241059; c=relaxed/simple;
	bh=Ncng49pBbHfVWMJYb7yYzxSkPR7yvgTQGFJedIGBO0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1Du+h+eG2SN0RBvRDsH9YhEPLZLYqLZ0TMWSO29hxyNsmH96nqIKZxKSKy7VR7edr4NCJCQYp1kGET9fPU3U93iSIkg/jKPrkZYIiqeYMh3nMzsWgTeGHFqe74X7N+WSv6NEHqvtQ0gKVyY0caEDa4L1wkGCmbQeA9wYCP41y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+ndfRQi; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikKWMuKXerX0NDfd7+DM+arxUK4uQNygIT/RuJV7xsSobQhCbW9XStdiWuylHmS9iUU0w07hZ7nqlz7k3srNz6gIhS+vzlEYRLtI4m9bD4gFDebgPc/EOynIvkpwjnaPney2bsj0Bvbt+tl1HrRfkidbYA7zjwB6+T0mD5chH6MX3yuz9/8jqFHhibm1GngybT527YpjYeT1xnep/A4G8HStN1ANQsu0hD5zjazbDB35ZclxVudLulGxCASrRWFzfO0Ik6epr6bPnO6j3B5SDWKOA5IS3usSzdk1huO07RFJ+/PFLKenTswMUjvFJomSYKGcb5qz0kovhwHVb34oVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncng49pBbHfVWMJYb7yYzxSkPR7yvgTQGFJedIGBO0k=;
 b=AST4vDBJuvSt385v1yMaq5TLEFZ/Ax+H63YiUjU2ZgzdQxnakFBYclq9vGgDJ6juTOhqmP2no3/mIdj2X05Q1cqqYHyUmOrgdxsES2tkDEDf5SZ11QOjxXJLfkMYV8JaYsf3RJ+ks7vIn4Ba5pEsODrPGvPNsp80eIbO6D4cdNKgkfoyQ/VaWGFdbe4oKJdjGf+Ty2OxLfzpqpK8IODnYUAxz84CCT8AL9LavDJBceMAzSGxcfiBiMmpbpsOBDICEt6OBmuDhZxiYQOjvO74QdgPW2GgJLKHAaKnKLIvvk3bWiW4HQgaG4E9HmdjZezdTCn7LfEKpN3v2xcmPzqUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncng49pBbHfVWMJYb7yYzxSkPR7yvgTQGFJedIGBO0k=;
 b=X+ndfRQiOSnQkD5qyfbRyXVO/QfkgOQtm6Zl8ucQGS4QYzkvjQfT07IltIt5yq/T6DbYAgMrTw4+GSpouZhhxSVT3O5Ca26DsgP+VterOLT2qYPBnU5e2Qz5UqEWRVsQ9K5bdUgRNIcX3MqdBpaL64LzDRimumPxBHsYyAZ2QB7MNI1B+nwNn4QZ02V/W9K5aBcVH6MVuVLKel3V2zWNYCfe2yoB/kl2qtwd/XgHMeAxUHoa3H+qm+rxADFe9sJlFufHqLYh6zMR/fT5riTbF2GEqZOVFrE1ljz4BBmnvIng7My5RvyLiBOOHv2+XyRPQ1d64l+RVGWjhTsOGvrJ1w==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 03:50:54 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::604f:a803:b95d:4449]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::604f:a803:b95d:4449%4]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 03:50:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "djwong@kernel.org" <djwong@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "dchinner@redhat.com" <dchinner@redhat.com>,
	"jack@suse.cz" <jack@suse.cz>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
	"jbongio@google.com" <jbongio@google.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Thread-Topic: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Thread-Index: AQHaTrsZwQbPAbycQUSjjHLdlH3QJbDptAOAgAHEPwA=
Date: Fri, 26 Jan 2024 03:50:54 +0000
Message-ID: <22b297b5-99ec-4b75-b81a-6b603d1efef2@nvidia.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-16-john.g.garry@oracle.com>
 <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|BN9PR12MB5131:EE_
x-ms-office365-filtering-correlation-id: 02dabf6f-ef50-4f4c-a3be-08dc1e21ff12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HFYZfAy4qFghL+/mfSL/E4yH9PfPdNn7+emxLuCLI9UadtGXmWcprkaj5QMQ1LZISp+9pug9hdBzrMmi937GNaGUgYNxNaypgUinF4kG89nEorENVsiZAl+YKS/F5RNWURvDt1rDrwyGqik+WrjR2BJWi94EkEoz9VoIQE3op4pnm/yJ5kqNSVomod+/zwYO7K8ChxwrtkVBFozr7pgvcU3C4TCCiXlrPyGGlkhnOdecusVW1ObxAWNW8pT6p2tcs7xg9ug/kd+a+k3Vg2EA+cFzzSKstvo4e7EJ6/U687GoHqFwARfMVH1nZTbvUNpEA1OL1U1Tp1UJE8PTbMASHHizLJ/djdFjuMD/OdqWiVo20kXiuvN1wQr5uEBjafcIh6GedxV5/XtdmnIIa3fl0mWfCL+CZxrPWZWAYWIkxRvFjjtCGYiGTvlSqYxUuRJV615FybT7pEf8/at6cK7XqWJkNBSCi49wzhfQXiQFvhBg2ngYaf6x67UUhqOnSZvaCe9AeVTbsZQMyBNxo1h4k1NA2uwYozVFGtK096Woou6IOPDaE5b1c3x/EMw1wlROvt+xZ0OpxCMrbYuvhC86tf2PFmTD9eom/L6GmLMjjYMqzJGoYQ7LoG5b1Fru3mqEg1v9DJXyZZ5kx4US+dFtakKTmaerhj00eT29R5UFcVm7c+2qOvr80wKUJjXJdIyO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(7416002)(83380400001)(2906002)(122000001)(4326008)(5660300002)(38070700009)(36756003)(66556008)(8676002)(41300700001)(91956017)(76116006)(110136005)(6506007)(64756008)(38100700002)(54906003)(316002)(66476007)(31686004)(66946007)(53546011)(66446008)(478600001)(2616005)(6486002)(86362001)(71200400001)(31696002)(6512007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eml2S0tncFRjcmlCaEZ1UUZWWEVWa2J6TjE5bEdNYUY2aHo1ZjlJWXBOcjdu?=
 =?utf-8?B?VnFEcENVcXpzOC96R2pMYlpkUWlvOWVYVTVaUk9PTE41cGZGdnFHMGxadWt3?=
 =?utf-8?B?WTRROVpQN3hieEpsZFovVHFLWU9iNmJsSUlIL3VJN3NtWUVScEN2S290OHpa?=
 =?utf-8?B?cGh3R1NIQVFTY2JrQlQybUdxK1Q3OS9FQnNqS2t2Zm9IM2tzdEJJNjZFcVVQ?=
 =?utf-8?B?dXZpMnVaM05wSXZRb1B2Wm5rc1duMFRoQnJVcFZOaXRuTXBkQjRPQlpMbUFQ?=
 =?utf-8?B?WVdjcnRIdytWOFNtNVc4aUFmUHF1d3dEZlVmNGR5cTM5REVaUEw2TXhFZW9W?=
 =?utf-8?B?MG84MXEzZW5xd0ZjeXFpbHNqd3RFRStkUWVlS2RmQkl5Wk85K095bGNRTVdS?=
 =?utf-8?B?YVUxWTE4SC85VklNYmdWdGdBK3B5bDMyZSs0Nng4SGYvQUo2QVNqZWwwcXhT?=
 =?utf-8?B?OUEwSHVKTURXWWY1ZVE3RjZxSmNDV0w2OUlVOXdMdUdrZWhiRFBGZ1pXWEZW?=
 =?utf-8?B?bkVIbFJFaThXYjhTRmNzRDZoYllwQmlBUG1iTFg4aVB6Yk9aRG12S0dqdDBJ?=
 =?utf-8?B?SUFqeXRaQVB1dERjcTlDN3U4ZjZxNzNZN0dMTEdZa2tuVjZXQTJUZU9TRGdV?=
 =?utf-8?B?UkZnemVybDBKbGhsZitzcEN5TmRaR3hGYWhaSnVYNnVEWmhGcFhtTlgvRmFl?=
 =?utf-8?B?cHRnSWhzY2NJL2FFQisyWjRzYmJPbTJ1cnJMZWZFVW9qdTZxdTF3YWhEeVZR?=
 =?utf-8?B?dkRRUFE0QzNoL1N6dFJtbXpUK0ZVdTFVZUI1RFF5SktLa0lpRks0RndabW1J?=
 =?utf-8?B?ZHpnWjJrcVR4dGtVZVh5cW91TDJUQm1jRjlIVTYvdXgrc01NOG92eUZrQzFn?=
 =?utf-8?B?TEZIQVhYVnY4R21LSmx3Z3ArYzJhOFFXbm5JMnBWQ3BkZHo5dzZrZktPd3dq?=
 =?utf-8?B?Y3JMd2FWUzhTdUtPNiszVjVyYWszOGNOaUtFK0pQS0hidEg4RkJKbkExbUVn?=
 =?utf-8?B?UTNPUUt2OUtMallSTEgybVJMR2dFdWNJZDlMWnVGSHpCcFFFNlNnUTNxY1gw?=
 =?utf-8?B?NEx2WUhmMW9DZFNCNzRvZ2NXV0xDKzRWK0pSY2Znc2tBUWdFb2NEYWxScU5W?=
 =?utf-8?B?UFdMTVA0SDFrclM5ZTBLekRaWmNValZKN05aRW9pV2NXamVmaVFySHlLSlVk?=
 =?utf-8?B?R2hLSElBMXM2aWkxOHh2RUtETVN0LzA3OC9mTEFMRy9IUHlYbDlEVFBscFhF?=
 =?utf-8?B?VHpsWGoycWtqSlNNSDIya3R4ZTNnTWFER0Nyd1c5ckJCWTRhR0FaYm1DQVlZ?=
 =?utf-8?B?WjZEeHQyT0NYaC9qaS9QSVFHNlN5a1NuaWtnRUVLU21DRjRvMmU5Z01HeTJp?=
 =?utf-8?B?UllkRnFRTy9HUFArNVB3RTQvV2Z6VXBiMFJiaGlCSzVwdnZFNms3MEhDZm8y?=
 =?utf-8?B?dGlFcTN5d3M2cUdPckNrV2ppUnBuNnBhYS9HaHh4VHdTMFFnYkh5bFhHdWIy?=
 =?utf-8?B?cHJmQmpFbUNnNmdKdjk1TFlhaEphOUVGcGNYTXJGaklXYk9FREF2U1AyNEow?=
 =?utf-8?B?N3UxUDUybTVOTmxiSVR4YmdKQVFKSXlqem0vMC95blpJYzZoTVVheklLTGsv?=
 =?utf-8?B?Q2pMVGlPZm93Q3JybHlMbjdsNnBoVmF5a3l3dXdRTDIwNDlLZ0xpMzRiY1Zx?=
 =?utf-8?B?aGlLZzZCcVE5WDcvdUk3ckZWSWppakFCYmpHeW9tT2FMK3VWMFRpUmYxUytZ?=
 =?utf-8?B?eXprVnRrSC8yNmFJc2tOQmlpWnpLUmhqanhsTUxMUnBUQ0Q4dTg5eWZGVVVy?=
 =?utf-8?B?eWxqaHNDdUUzUS9KNVNDYjhPV1F6VGFscUt4dGtLcmpXTGJSYkNqaTNGUWh1?=
 =?utf-8?B?OWk3Vm14UExRQy9hNmxuSGF4VTgrUEZJcFVlWUc4R21CQ3lLSzRRUXhzQk9k?=
 =?utf-8?B?T2dPMzRhNlQrdWw1djloZGtueUlLbjA3dEJpazZGZnpRMmhtWUdZVFlITGxX?=
 =?utf-8?B?TExCT0ppc2RVUHhPQWdzVWxFenlWYUFaOW9LTmIwcnZEbURsYmpRN0I0K1pi?=
 =?utf-8?B?VndYL2VlTjBXY2hCOTQwZXdCU1MzQWJvd2svK3RhUm9CeldITnBKeXJyZk1n?=
 =?utf-8?B?dDk0YXNnQmUvV2Q1ZVY0cE5qS2pCd0dsZUVUdjdCcFZVVUNsMUNiMWRyOEtW?=
 =?utf-8?Q?dGHjuzXj7izOE2zHgFW1dpb/09nYf9VVEMu5o481SAYS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80D884E10929CC4A9DA7BBFB391F3F2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dabf6f-ef50-4f4c-a3be-08dc1e21ff12
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:50:54.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4jCqezDUDgkc/7OHykBXTjp0kyaxxcV/ObhCHqPyxvrGQDyVMbECJOrb8kM1mqeGQjla9LW6PuVbwtHYgPz6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131

T24gMS8yNC8yMDI0IDQ6NTIgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBXZWQsIEphbiAy
NCwgMjAyNCBhdCAxMTozODo0MUFNICswMDAwLCBKb2huIEdhcnJ5IHdyb3RlOg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPj4gaW5kZXggNTA0NWM4NGYyNTE2Li42YTM0YTVkOTIwODggMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPj4gQEAgLTkxMSw2ICs5MTEsMzIgQEAgc3RhdGljIGlubGluZSBibGtfc3RhdHVzX3QgbnZt
ZV9zZXR1cF9ydyhzdHJ1Y3QgbnZtZV9ucyAqbnMsDQo+PiAgIAlpZiAocmVxLT5jbWRfZmxhZ3Mg
JiBSRVFfUkFIRUFEKQ0KPj4gICAJCWRzbWdtdCB8PSBOVk1FX1JXX0RTTV9GUkVRX1BSRUZFVENI
Ow0KPj4gICANCj4+ICsJLyoNCj4+ICsJICogRW5zdXJlIHRoYXQgbm90aGluZyBoYXMgYmVlbiBz
ZW50IHdoaWNoIGNhbm5vdCBiZSBleGVjdXRlZA0KPj4gKwkgKiBhdG9taWNhbGx5Lg0KPj4gKwkg
Ki8NCj4+ICsJaWYgKHJlcS0+Y21kX2ZsYWdzICYgUkVRX0FUT01JQykgew0KPj4gKwkJc3RydWN0
IG52bWVfbnNfaGVhZCAqaGVhZCA9IG5zLT5oZWFkOw0KPj4gKwkJdTMyIGJvdW5kYXJ5X2J5dGVz
ID0gaGVhZC0+YXRvbWljX2JvdW5kYXJ5Ow0KPj4gKw0KPj4gKwkJaWYgKGJsa19ycV9ieXRlcyhy
ZXEpID4gbnMtPmhlYWQtPmF0b21pY19tYXgpDQo+PiArCQkJcmV0dXJuIEJMS19TVFNfSU9FUlI7
DQo+PiArDQo+PiArCQlpZiAoYm91bmRhcnlfYnl0ZXMpIHsNCj4+ICsJCQl1MzIgbWFzayA9IGJv
dW5kYXJ5X2J5dGVzIC0gMSwgaW1hc2sgPSB+bWFzazsNCj4+ICsJCQl1MzIgc3RhcnQgPSBibGtf
cnFfcG9zKHJlcSkgPDwgU0VDVE9SX1NISUZUOw0KPj4gKwkJCXUzMiBlbmQgPSBzdGFydCArIGJs
a19ycV9ieXRlcyhyZXEpOw0KPj4gKw0KPj4gKwkJCWlmIChibGtfcnFfYnl0ZXMocmVxKSA+IGJv
dW5kYXJ5X2J5dGVzKQ0KPj4gKwkJCQlyZXR1cm4gQkxLX1NUU19JT0VSUjsNCj4+ICsNCj4+ICsJ
CQlpZiAoKChzdGFydCAmIGltYXNrKSAhPSAoZW5kICYgaW1hc2spKSAmJg0KPj4gKwkJCSAgICAo
ZW5kICYgbWFzaykpIHsNCj4+ICsJCQkJcmV0dXJuIEJMS19TVFNfSU9FUlI7DQo+PiArCQkJfQ0K
Pj4gKwkJfQ0KPj4gKwl9DQo+IA0KPiBBcmVuJ3QgdGhlc2UgbmV3IGZpZWxkcywgYXRvbWljX21h
eCBhbmQgYXRvbWljX2JvdW5kYXJ5LCBkdXBsaWNhdGVzIG9mDQo+IHRoZSBlcXVpdmFsZW50IHF1
ZXVlIGxpbWl0cz8gTGV0J3MganVzdCB1c2UgdGhlIHF1ZXVlIGxpbWl0cyBpbnN0ZWFkLg0KPiAN
Cj4gQW5kIGNvdWxkbid0IHdlIGdlbmVyaWNhbGx5IHZhbGlkYXRlIHRoZSBjb25zdHJhaW50cyBh
cmUgbm90IHZpb2xhdGVkIGluDQo+IHN1Ym1pdF9iaW9fbm9hY2N0KCkgaW5zdGVhZCBvZiBkb2lu
ZyB0aGF0IGluIHRoZSBsb3cgbGV2ZWwgZHJpdmVyPyBUaGUNCj4gZHJpdmVyIGFzc3VtZXMgYWxs
IG90aGVyIHJlcXVlc3RzIGFyZSBhbHJlYWR5IHNhbml0eSBjaGVja2VkLCBzbyBJIGRvbid0DQo+
IHRoaW5rIHdlIHNob3VsZCBjaGFuZ2UgdGhlIHJlc3BvbnNpYmlsaXR5IGZvciB0aGF0IGp1c3Qg
Zm9yIHRoaXMgZmxhZy4NCj4gDQoNCmRvZXMgaXQgbWFrZXMgc2Vuc2UgdG8gbW92ZSBhYm91dCBj
b2RlIHRvIHRoZSBoZWxwZXIgPyBwZXJoYXBzIGlubGluZSA/DQoNCi1jaw0KDQoNCg==

