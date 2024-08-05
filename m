Return-Path: <linux-fsdevel+bounces-25035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F29481E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3686F1F225F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DB1552FF;
	Mon,  5 Aug 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="AhtvbkHC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="I3AxHaeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B92AD13;
	Mon,  5 Aug 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883501; cv=fail; b=SUdZRY7jlYCbD85TR4vbutojAttQ5t7EHV8mysnPmSnSAO+3yQl7eEHMSWk9Zz/F6GdybVuqSHronumEBID4KmAlnIoV2IJM4MaUgxKUcL5DS4wkfQg6AFfO6b1CAenMh2251HeGSR9YwGx+w7V9p/4bopn5TsKR+mRuKKZk0Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883501; c=relaxed/simple;
	bh=UYj/jbb1yjJgtOj9f6jfyf8jUiLJ+M7UJHvnb3FsdeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WaqnRAzhEKoaBF/lT8OdHgg3qfl8n2nFd8CyOuDldcTPXGsCXxOLK10UfyjHCC/IL2znWXATvjfO9WB5d3/NT/nWsMigW5CcBwFCBAGjMIqcR1KeOggESWdmbQdi4YeVzr9zG7IZFS82T3juk3CVOjbFPxMdfdmtqaiHbt2oxIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=AhtvbkHC; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=I3AxHaeW reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BF5hp010502;
	Mon, 5 Aug 2024 11:44:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=eT7d0LBhV/2Ax0nvCi4m49OTDb4UgSalDBwceAOsKW4=; b=Ahtv
	bkHCsb/Sl68Ou5+I9m5en/MdhkUUo5yHzwx7jCiYTMenMbVrAJBLzRFedfz1Bikm
	fW9FGrCzuVVRHIlKSvX3y3SLbAybNe6DTrmqEdEqs5LVe8Kr3SImp+sRTHgBKQsB
	buqC16zDwCnBivzOFmFJl970vipFXqpQw22tyL6/YiqYJfChwqRSbkEtSXUOc9XP
	Ti1LcL76uO/cpQjIhZucVCl9fo99V5dMMahVc+JxyBzwxz5svtyAkml7vbwThMas
	NTtVNe6JRsi5ALbEvRPwGHMlRDr171IZMpbJYpB7cgaj3vbH+nAnwZ9055c5VeNq
	1Uk0jaiIdMNOG6c+Ag==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40sjfe4as5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 11:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZGN77dRUbNqBJVejMff19Bs1g4HqW4DyxngMP2mp9pNlVd3k2YWCpeMjZ1IXZ4OSEg9RbH5UcNLrlz9WUMLG8qX6rPFlxJrrPi0T6xmodKl6Z0i3l7P5Garwdu7y0KeXgiP5W2vsNRuHycElJvSQFar7efurpLEzJs+zAwdh83ZdtZ5II2yV+vgTlPz+K0gTraLM36ut/fBUofHR3eeAiOJy1ZGe0uFM4rN43bnFUjkRRAOJqGxa4Bs8f3zG69PSOQH7JTXuwwuPiWRbwNlPUQslq0bEgioZ6UWUAfVr/DU6uwjoit7bmZ6C3mK0SEpIrPP5wy3tAOYAapVPIhBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT7d0LBhV/2Ax0nvCi4m49OTDb4UgSalDBwceAOsKW4=;
 b=lmt1u8QhqBkqEduqLb+vfWR8TFZTVvAZNnDYKLcdJPad6tg6B2sq8j3PmLjHs0GGv16+J8DyUBtc05dGZpEQXZR8M9IXn3zaI5vbOEouOGi2sEtFFe3+u2NKluBvZZvPXM/9j/T94ATgDqQjZlVLx/Qsgy1VqK2Jr+mcGPkT+d/JfZqw/2JR/WP7GJY5tSZREi4Pto8tHeXSufLElYIDFBXaYJR/2QUN8kMiPuw4OgsYn0VlxcuBNkpJYDY/PlYfsSNdXKz6IFG1BSLpw+vvqEvlLS1ka6CuWz3u1qk7goNHPZz1WadhorjzMAaa7uu0prggyQ4aowgelg8/wypuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT7d0LBhV/2Ax0nvCi4m49OTDb4UgSalDBwceAOsKW4=;
 b=I3AxHaeWkYkNc77WgYi86mqQiD8wrzcjPVv7PAL9xwsr9BpLfCiP4QUQunZN0FEwA+ST6Dt0olz3fUZHASH83zsTn/OkigxytOIZWuj2Od2MITp9pQEYBpYaBRF5awdyaAvG4oftrMOFlH8aUCT5OcBy6BF0IdXDZaz0VSMMfy0=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by DS0PR05MB9568.namprd05.prod.outlook.com (2603:10b6:8:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 18:44:44 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 18:44:44 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov
	<oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa45b60I7pFn286ESFEzPKiZWp67IRtKgWgAD81YCABkAyAIAAFioA
Date: Mon, 5 Aug 2024 18:44:44 +0000
Message-ID: <230E81B0-A0BD-44B5-B354-3902DB50D3D0@juniper.net>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
 <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
 <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
 <202408051018.F7BA4C0A6@keescook>
In-Reply-To: <202408051018.F7BA4C0A6@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|DS0PR05MB9568:EE_
x-ms-office365-filtering-correlation-id: 73657cf7-b7c5-4fe5-0ba7-08dcb57eaca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?enDTPpRAP1as3WTJslZ8q/rKQWo8h6hrFTszn1L7vHTpf6E+3yPS5c+JPjlf?=
 =?us-ascii?Q?BZhiXRoLUiPPhkYnFD6OUX835NjCaLF1Y+ENLOqIjqQyJtQ0NzTMGgvxRLV2?=
 =?us-ascii?Q?e+L4KRmHX8GPZONaU2jJsW3jVzhhqnkJNJYL6Iy8vorEPFdYiUpbF2Befudu?=
 =?us-ascii?Q?X0M/9HqubaBU/NM/gnmpUZvy+qdjV+yJU/WUMbvdp81TuquWaXdauVsk1d5E?=
 =?us-ascii?Q?Q9Yp5YG6DYcKBeEO7OPEsbIITAwEK7aQLzB1+TqS0vC21n98bDcBEQbfHFsm?=
 =?us-ascii?Q?NrMiCExrh/xYbYUIIxH0ManqHQthpAy5upoARc6ZylGnW8jo2CEJOTU/r+8e?=
 =?us-ascii?Q?C5zGK9+K3emsjr9tkHdZD9qZRipy8AJV6I1xFrNbKDpElJHzIhWssVI2q8A6?=
 =?us-ascii?Q?3iFFJsJG7QBpLVW3jHZMKC8uX7daPE1QwbzG8fk5yxv+mVY9Pq2/KqSm4YZU?=
 =?us-ascii?Q?imaTkM1gdfE1KQtH9+WCod/Q2gQKjInl+23lCSHrVPTtSL97VMmmb6WsWDr9?=
 =?us-ascii?Q?gau70Kpts5W7NkhWIvpX/pTgcZ9TkRF/b7miwv5p4Eckzo1SL782kRI64cM8?=
 =?us-ascii?Q?XmGTOzn8HMqhelKZrTUR8L59nLZ4KTtRp5efcKfnf4y3/kkgkx1WRrGQEfzY?=
 =?us-ascii?Q?/m5uPMj9jVXZg3OZ+21aUhmt+z7bj2LZ96cp4we5pUGN3CHIyZPGbfW/RbJe?=
 =?us-ascii?Q?ShNi17wr8XIkMRHXMlKkcEfILx0MYuvFuEKumAd2cVSxA3JR73v3nIzKVndu?=
 =?us-ascii?Q?kU6lP3FW/MGOuVcBnG2gEte67vaPmNempgzq0QmwZ0KpVfFJHwrcIdbe7S05?=
 =?us-ascii?Q?i9WKvmsqLMKqOrXE0S3z9NaYwpfJZi+TQQdUk5HKvJKGmHabh5m7pp4zEv47?=
 =?us-ascii?Q?5bGu0aMr1w/4kVAcul87VS4vHSF8uT5WaY95++ss5CyFldRUHv77WHLtDZwL?=
 =?us-ascii?Q?rrBYMPIUNr1Pi5hw8ros4W2Xo04xd1uWw9q1oEqd3KicIXf3r47R7rxRWIm3?=
 =?us-ascii?Q?1FotUYy1gy0fg9IEQw1uFaR70PMSyDshc5I103Q63LOfc94Yq1OTdMbFYpX3?=
 =?us-ascii?Q?rkO43DKB0kLGoNyVuHR/KgLJqU/VnxAg2y3ViOEiZIWrCogMtEBG4dMJzPXY?=
 =?us-ascii?Q?6MOS+3TVpXUfE1uy1a/+rwt5WNFMJvOgy2f9vdEIsZMJMY3a8cXZZx9zv5Wv?=
 =?us-ascii?Q?zObIjwlajEOyykSnBaokvBWLgTJfY6YcVNA/lGqvzvsjN/f+erPS1kHn7IQi?=
 =?us-ascii?Q?K6SI40TXSBXOf486/lzut+reTFA0KzdlyqrSJZgouv/gppmrHeSVY4+Y5vGR?=
 =?us-ascii?Q?WEIWLOLcUywyZicWD6ggL1mwdRjBExQO4xkijWikduIOSHHgW4dhpFwlHdpI?=
 =?us-ascii?Q?g0FuCyBTuedtd39cJw7UM3mTcG0dyGKgQV2kJekTU/ByAqPX2A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yQZ+NmtoLtUguI9YoWDczSR5UeKFyGhKHDGUFUl6q5RqIPoQBBHNO5VYs6OT?=
 =?us-ascii?Q?oA9RCqYgYBcSSjoKgxoPQ/QTkAbY/rWVWaO4vqIOTHYJ7qybDemV0Kt+Y6Fm?=
 =?us-ascii?Q?D91U0mSkLtWOsRTTnmvYP3zyrJNdF2DMfrtj04Wa74SCBRx99n8SghWJiXoH?=
 =?us-ascii?Q?ooJyP2dhN0rfQChnlQpUOKI/qXnKIiVY50HBD2evcdjbJWtu8fd3HhnoCuhW?=
 =?us-ascii?Q?PUaQoDiD81VSLXoqspaGDS8PmC4k/f9YcRbGzh6W4z0WyXp+55fmhkgcFDPh?=
 =?us-ascii?Q?iu9g1pu6FEeLQoLD2l6hzCl1hVJ/G6xxZi8D5i6X+H3cWqNfPZEeHqwFlEyh?=
 =?us-ascii?Q?QY5ohNnIBwabWx4Zk3ZdLQBYJKVmloRkIviv0m6TRqTZIvqvqnYfqtRqfOZV?=
 =?us-ascii?Q?DLqmELLonT49OjKsuQqZvixJACRFVb96k84xfmr2ywa9Eo9ypfULJoMeU8Cd?=
 =?us-ascii?Q?6ItUi/IWt+yy1mGYG4gWnjEWkcFI+rKXXYFY6qumkibLcwsaqktQSZWaj58l?=
 =?us-ascii?Q?fvUCrSpe4rgLKh+Ys31wdzvKTrBUcLvqDt9gqDVh5elqLZ3/BKyuF7K+Yk1d?=
 =?us-ascii?Q?X9W6UoI3l1697cw/r9cY8Jo9u3MqfdvYq21vKuOIsKAcy3WopNcUXiQI1KsT?=
 =?us-ascii?Q?XvjQ4oyWDT2oD9lsHlRTMfVC0DjHJfa+rQxM0Wfqzff1wfDVE9y/WN8KcMq8?=
 =?us-ascii?Q?tXUks099+Cr4m/ORs1RS3v54GqmXWkwaXDRSs4cAypiUe5sS6BHUrCoWbAzE?=
 =?us-ascii?Q?FVVv3Mb+VpmDlq9gNOfk3vFVwy41G0mvp7hd9iJlNAbSDMUtj+3XyNYko8ur?=
 =?us-ascii?Q?t8DLewL2u5ioI4CP053VopLz5UQk5ms/4psfO9LAwejMueY0EziE5v2MT1f7?=
 =?us-ascii?Q?y40g1xCiZernKzy96/gQ4nbwd8ea5HRo016ZKYjXWKxCVR8S6lTDYCBtxrms?=
 =?us-ascii?Q?j3x3F4t69xowgCD2ln8NmZCM7kgkQJXnF4loUUFfMP2IyYgFOLKS9zlxEHIw?=
 =?us-ascii?Q?WVIKxU0Ymkz9LyaDammIPxDzJPD7jUG2SnaqEmnqoLQ0XjhOAfuq//oDsukL?=
 =?us-ascii?Q?kOqX1/4vhwTjPTx942JVMmpmc0OCo0lZmPvtDmlkZSPBqK48rU2iRtcAKhX0?=
 =?us-ascii?Q?d5Qh852CY8nXWu170eAcnLyL6TD2GrMQExd/1TF547KuOgZVxcLmr42nGKj9?=
 =?us-ascii?Q?ys1/ESsPYboi6mT3aHCh9XpBpI1jc2bx1QR3tiVzh4aBuVqxn5GYBvYrHyDF?=
 =?us-ascii?Q?NFjUFwmGSdxxmYkU4o6LARpQJstvzhes2vnHxNt7Q8V275PT2jTGgd6k7m8e?=
 =?us-ascii?Q?FHR4pr1PTVHdcpXjS6e+A7csXpNNT3BQNWQQfG2Qtx3VXBC6xoClsMIe+si7?=
 =?us-ascii?Q?ybJ1uzUkXEjwEarCdyH5dKht6Ezre6gIGjIcCAyC4zFqcHYmhkOGfv/6y9Fd?=
 =?us-ascii?Q?DZwIk4uiYsUSOHIs+qrIzJhdqXxXksRrEdgLnr9rngslX+oChurji3cqDjtU?=
 =?us-ascii?Q?xsUBJRUxfyUARjKSbsPv+VSpl0LcCjCm40aMCf0/VLzuC+UlI0xvrZk4oqt2?=
 =?us-ascii?Q?3kvJasq2fJLz4KE0HkZ/TyPlS32+Z0xVj4YtI6aU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0D2F287DD4B7B4AAA4CE5BA52E2B91A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73657cf7-b7c5-4fe5-0ba7-08dcb57eaca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 18:44:44.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/MN+W98ln4hNIASsFvSTI1RpggOaXH0he32PouWjFDgDOP/KbXe4GFLXYEeLvFCy4NykzwajjZOqi5KMY5kOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9568
X-Proofpoint-GUID: 8iTSXFLpXCrtTbOYq2-bMmYK_-TMJLH-
X-Proofpoint-ORIG-GUID: 8iTSXFLpXCrtTbOYq2-bMmYK_-TMJLH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050134

On Aug 5, 2024, at 10:25 AM, Kees Cook <kees@kernel.org> wrote:

> On Thu, Aug 01, 2024 at 05:58:06PM +0000, Brian Mak wrote:
>> On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>>> One practical concern with this approach is that I think the ELF
>>> specification says that program headers should be written in memory
>>> order.  So a comment on your testing to see if gdb or rr or any of
>>> the other debuggers that read core dumps cares would be appreciated.
>>=20
>> I've already tested readelf and gdb on core dumps (truncated and whole)
>> with this patch and it is able to read/use these core dumps in these
>> scenarios with a proper backtrace.
>=20
> Can you compare the "rr" selftest before/after the patch? They have been
> the most sensitive to changes to ELF, ptrace, seccomp, etc, so I've
> tried to double-check "user visible" changes with their tree. :)

Hi Kees,

Thanks for your reply!

Can you please give me some more information on these self tests?
What/where are they? I'm not too familiar with rr.

>>> Since your concern is about stacks, and the kernel has information abou=
t
>>> stacks it might be worth using that information explicitly when sorting
>>> vmas, instead of just assuming stacks will be small.
>>=20
>> This was originally the approach that we explored, but ultimately moved
>> away from. We need more than just stacks to form a proper backtrace. I
>> didn't narrow down exactly what it was that we needed because the sortin=
g
>> solution seemed to be cleaner than trying to narrow down each of these
>> pieces that we'd need. At the very least, we need information about shar=
ed
>> libraries (.dynamic, etc.) and stacks, but my testing showed that we nee=
d a
>> third piece sitting in an anonymous R/W VMA, which is the point that I
>> stopped exploring this path. I was having a difficult time narrowing dow=
n
>> what this last piece was.
>=20
> And those VMAs weren't thread stacks?

Admittedly, I did do all of this exploration months ago, and only have
my notes to go off of here, but no, they should not have been thread
stacks since I had pulled all of them in during a "first pass".

>> Please let me know your thoughts!
>=20
> I echo all of Eric's comments, especially the "let's make this the
> default if we can". My only bit of discomfort is with making this change
> is that it falls into the "it happens to work" case, and we don't really
> understand _why_ it works for you. :)

Yep, the "let's make this the default" change is already in v2. v3 will
be out shortly with the change to sort in place rather than in a second
copy of the VMA list.

> It does also feel like part of the overall problem is that systemd
> doesn't have a way to know the process is crashing, and then creates the
> truncation problem. (i.e. we're trying to use the kernel to work around
> a visibility issue in userspace.)

Even if systemd had visibility into the fact that a crash is happening,
there's not much systemd can do in some circumstances. In applications
with strict time to recovery limits, the process needs to restart within
a certain time limit. We run into a similar issue as the issue I raised
in my last reply on this thread: to keep the core dump intact and
recover, we either need to start up a new process while the old one is
core dumping, or wait until core dumping is complete to restart.

If we start up a new process while the old one is core dumping, we risk
system stability in applications with a large memory footprint since we
could run out of memory from the duplication of memory consumption. If
we wait until core dumping is complete to restart, we're in the same
scenario as before with the core being truncated or we miss recovery
time objectives by waiting too long.

For this reason, I wouldn't say we're using the kernel to work around a
visibility issue or that systemd is creating the truncation problem, but
rather that the issue exists due to limitations in how we're truncating
cores. That being said, there might be some use in this type of
visibility for others with less strict recovery time objectives or
applications with a lower memory footprint.

Best,
Brian Mak

> All this said, if it doesn't create problems for gdb and rr, I would be
> fine to give a shot.
>=20
> -Kees
>=20
> --
> Kees Cook


