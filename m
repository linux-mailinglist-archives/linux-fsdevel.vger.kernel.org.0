Return-Path: <linux-fsdevel+bounces-42327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE02A4050F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EEF421BF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DAA1E7C1E;
	Sat, 22 Feb 2025 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="glDnKmka";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="b0/XtYW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFED42A94;
	Sat, 22 Feb 2025 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740190416; cv=fail; b=bGjf3P+aor4sERrUUyHRL1TjlxuLIQxQZ5on5fMHerkXz8ONHc4jgxnJa5AlUTKkudD113PSP898QFOY38J0sCHyx6zz0llURjyNk4VdISHcf13BDlL4Q8iF7WGqOYYXzojSa7URse+GYwdhGmCE9uFUShLWZI9HN1q7G05oH2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740190416; c=relaxed/simple;
	bh=RK6kEfq89yC4KhQguknLbLEZfyfvPK/Ft8xkmyaLXFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUA+vGpPvfCH3stgoJVa6ifgAZRd6rUCYOpsazT3/kWifrO0R28DNKDdk4mZNTPZ/8sJWz8Q8wepkaxwtoFrwHq6Estix5dRj78G7H07rE5JZ4Hzv9nc87vDUcY5E56wFP9/E4fvxJfCZv9tUOo6cGEKyoo998Azb/0Nf7K/SF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=glDnKmka; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=b0/XtYW2 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LGoI48015144;
	Fri, 21 Feb 2025 18:13:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=7DvCwLsHJd9pEhpsL6CVjCQis3hwKhZbAJAcUjg0ijs=; b=glDn
	KmkaUjA+CgX8/odo3qUMpaBIatV98b2CV1e3KmaoOcqZFgPHbw7z8uIX7s/1uQ7b
	n4cLcYvQXLRFsZ1aGzDxvr9Wcw9JAHWQGubRbu/VE6+oK4nx40KjwnIAmvhVEb5M
	1Ua9FECyyA8oQE6FFSyjWW7PSPAthDt5KpgKbes6bc66PQLQOC86uw72iWZ/X6+w
	aRbWPe77cj0zM/7H300WeJor2T9a/OGv69K1jqcr5g+uYZuClNWMS39tLPbbirwz
	Gttf+ddh1dtuBpCIixns6q6M//eUf7xDIRNR0YiL5CzaOShj8Eg2xqhJnl/q05z+
	YhtkJi1zaQOf+DYVZg==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.8])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 44xpw42420-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 18:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcbcVPrSVmDk1nPvh6pldkpSj4+e2UnVBgGNmqGAVZKwxygRySoTgMUBKqL9GASYGauYjQcufKZWVzzNwckYANvcM9veOCyzDJKK1F0Vk8QUKx5Aj/wVOddR5zfljOjyryJuAJdk9u3sXxedXX4a8HX/KSDTXw3JzG/AgQm6VO9nUrqFIG424ummati7ZWVjOkCFG1GpvY0Z4Ft34+QmGg8kI4Y+MK82lbibqquouA2tHm1fJdHTd0bXomyEX2k3QnWxI0zyuokXzxRjNN2NmXnUvEjIWKpGiVXm83DexMfwSXaRkYktqQ53UbaCPXgS2WvrWyJvU5NgS1IxisZnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DvCwLsHJd9pEhpsL6CVjCQis3hwKhZbAJAcUjg0ijs=;
 b=PA2A5+6Dg91OuP2pukj+Hx+wwo6GIbyH0Y38M5qqLSEkjGn2WND55pUBtjyKjwvZx4u/+XYrZU8WQD4WOKmnnlwzDf5kSpiu8Tnqso0eE+b+swIioWV6NGAJ8V+4QNZBhtmbloxgC8CIdeuHF5IPOjTnhFuvVQBaIVUZNN6nMcZ+bxm3iPpVG6Dc+iU/Xe/SeFb5XBNFirenRkEGlDA8cXs3zud+6h6N51ERjO/GE+fGapoSavhOBY/9rKxHg0TRvuFX2qeYqekq5ZP0cyx7itPbLXE9bWZ0nNifa35YnM7WRS7RTPHnitTG12Ofy+G1nP3wa8khJPA+zJ+GyFI0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DvCwLsHJd9pEhpsL6CVjCQis3hwKhZbAJAcUjg0ijs=;
 b=b0/XtYW20imEOxtjzv1Qms+OSjTaZD4OEP0a2obKf9EBido0d10IxtOhjuejjg4smy9B+ibKcNMk/0it+RH77mHIZ11TVUyB2UT1Jd8LwU4xoSeW5jflMtsqGoJUuHNL15Ta62dTfnrAHn8ZeDgGnlB7WuQJBWoN5PdI2bMphs0=
Received: from BYAPR05MB5799.namprd05.prod.outlook.com (2603:10b6:a03:c9::17)
 by SN7PR05MB7773.namprd05.prod.outlook.com (2603:10b6:806:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 02:13:07 +0000
Received: from BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2]) by BYAPR05MB5799.namprd05.prod.outlook.com
 ([fe80::e33:dc6a:8479:61e2%4]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 02:13:06 +0000
From: Brian Mak <makb@juniper.net>
To: Kees Cook <kees@kernel.org>
CC: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index:
 AQHa6Cyyr+Pv/zK/REOrOTMOkQf+lLNN9PkAgAC4SgCAAVa2gIAAOzWAgAAM/oCAA4INAA==
Date: Sat, 22 Feb 2025 02:13:06 +0000
Message-ID: <F9EA3BEC-4E23-4DBB-8CBC-08EEBB39D28F@juniper.net>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
 <F859FAC0-294F-4FA7-BAA1-6EBC373F035A@juniper.net>
In-Reply-To: <F859FAC0-294F-4FA7-BAA1-6EBC373F035A@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB5799:EE_|SN7PR05MB7773:EE_
x-ms-office365-filtering-correlation-id: d218fe13-dd1d-4db4-d923-08dd52e671db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PB1JQstnJ7Wzo2BHo6ddzzE5kv9cIjJ8gK6OQRsWpvJefvHW54BJmMo1+hOM?=
 =?us-ascii?Q?HbWUXpMO/1QREawS3NYfqbVKLVN+95caVgBd4In79GG6jZBesM1xax729ttx?=
 =?us-ascii?Q?m817piTaaER3Fln64p26Rnwc3HFjLUx/60VW5XA4cokkLe0S+AbHeXg+8EsE?=
 =?us-ascii?Q?6xBrHDdAm2QKO8XQhXHQUmxXKTSmAHtx145JWahyImpHOMTpgGuGkBxCcLBD?=
 =?us-ascii?Q?0LXg4ZJIuFArEsH/wdsrrgRFuBUVl00JpDorsWxNtsa5xKfcLxAUaSZIsy/c?=
 =?us-ascii?Q?NnPW4rhLvW/Fk0c4ebKiAOVaovgv8az4d8JiVvPXqzwELD1M8IcJwikLPN/r?=
 =?us-ascii?Q?KWdH7ak2kJ72vwMLzW3A6/EFRKHsoo66OfTOJg7HBJKICGD0Zn1DEBBPul0p?=
 =?us-ascii?Q?Vn34xQuLwBDOxOWrSWm6fyli5+3DMTSrJj7qxSd2fcDDfO/LVk8Ue8t052W4?=
 =?us-ascii?Q?kGYoqJhYCI+L8gt4OBBHafUDfN7ToBx7Gkyo5+yl/kUzAY+RQhOGCLdEm2Q2?=
 =?us-ascii?Q?SVH2GhLu+6qq1+u+L+9Ho2Gm/+oJCueE6YrXR9iwb7ODrSS/OPTn4n82+yXK?=
 =?us-ascii?Q?j4Clq4/M9OYIhvvngC3Y+MdI7BhVz8bsG8gUU/ajHYqAwLxOQBir7JrGlwXJ?=
 =?us-ascii?Q?EIxUubh5Ob0kZqEdHcDqnp4zY9kJBpSvsaEQs7M9udYbM41Ugevha9cG+mZY?=
 =?us-ascii?Q?+dmweWaps7CrlHW5dzqFW0ZWyLWXTU0JqZDC7z1v/UNTE1/qfaUqI9dCDYvV?=
 =?us-ascii?Q?Py6WX1qZNynJgIqby0dKLj2hSPduQFBY39rxPaE92G31bUJeUjiuD4TMEEFc?=
 =?us-ascii?Q?D1tsssy8YCfbYIfQtyS+o/lIa4q33NzqHT5EZ8yJHuKnOwTWq2o2aw1pZ77F?=
 =?us-ascii?Q?XV9b4Vt36/wyqB2IkF9x0zcQOukSKQkydPPs3XONscomD/0Z4QA6RYxiQnD/?=
 =?us-ascii?Q?vZie12PJV+exHpS/kNUHxPFMn5t1S/c3sVRfQ5vbIbPQc9VQ4xA+sCbcfqdH?=
 =?us-ascii?Q?Uqx3UF15UDsOHryqxBB9sbrjKXXfa0WW6VO4GS2uYt8aUm49KdZcZabHuLi2?=
 =?us-ascii?Q?7MdQcnM6yS9JSNaZ5YF+2UFUzay/mulYckqFW9OAEufA37bwiQyw9gcPCqkk?=
 =?us-ascii?Q?///mKH4eSGfMYs+gzJujCJ6oCHXue36v3YjH8Z5ahbsr4d5MWuwca5YxElxC?=
 =?us-ascii?Q?iLW9e6AkS6OD/6F2NNm0xYnujUA+VOiOYqIAtNuXkDt51mhrEUHwLSXCnj2X?=
 =?us-ascii?Q?q7PC5ykymJ5JEDptdze3EYxZXqKSUzgvaPDMh+DhKBcrRNUh0YIJJGxid8Xu?=
 =?us-ascii?Q?eUNkNHvAi7BF+VcdexmTKmWvDRjBAMWIz6iSCLXeGAb9POG7GCQJLpyPXIyb?=
 =?us-ascii?Q?0DffYBCRosjlpc1Jyents/8suK0FXDUceyTAKEvezXM+KQzq6vYrXEabm/0p?=
 =?us-ascii?Q?Eojojp58wpxfu/45dJ7eLcjrnZLnepJZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5799.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7UykFZqbHaDYp17Fug52kXrmGFK0pGdaGa/WNOg3DcPo2rtFmZMNfdB+aYIz?=
 =?us-ascii?Q?wjEifoS7ehWkQg6rMy/qhvfyMevt4NC92XA12KcDSoLfnk0GfLasorBYZa8l?=
 =?us-ascii?Q?2U7ldDHPtlboZmvuV3q9RC59tGb75K9V1KktZXE/mHNkauOyna/VwX6H2oa5?=
 =?us-ascii?Q?Q2ylUGaXX5fvPmp/Q3nkKfWruxoXSj/ro6QsG+eK+WGBfUjTiNlhhVks5iI5?=
 =?us-ascii?Q?cphLD/f9n0bXGi7Gpv16xePe8eIPfr2D/Z78+QqpYRz/Hs0O3cawziyfT9rJ?=
 =?us-ascii?Q?zifRzgkN0V0Y1yxNRaodgCA9GXioK5T1LnmBs47s9qJxbDYGc/iLWadnX1kl?=
 =?us-ascii?Q?h+RMC+3j3QbqqsqN4nRIfhCnM3MNnYgb4q2GwdCi9uogURjR+qgtDOEU4jWS?=
 =?us-ascii?Q?uk9V2MrS3ziKCvVFNFPrGYC9VgoAMWmm/805ZkLc1V9cDBSaxkweWKglRlb4?=
 =?us-ascii?Q?a77M1OgrU6ibqNu1qyNpAe3V3cWjweIGNty+mR5739FB0Ns6/VSYGp65eJms?=
 =?us-ascii?Q?wxL315gDIwue61QBaYenJGgHDUcHFTct36fnM2AlS2jzxnd4K+PamtDREuVU?=
 =?us-ascii?Q?ueiANPUpCpq4DxDdINgrBipQD4rq9XmCe3UfxmLvTW7yNzB5IGnMGCck0e8u?=
 =?us-ascii?Q?+cFuY14ngYlgKklHSAQCRhmH+FQFteYnXBDlt2eLXcHnco6zL4+Za3WEjNcj?=
 =?us-ascii?Q?TIbngauZ/Deu+Hhm6OgPdUosivaGMmnrkdEXB2hNOjU2q5Q/RYe6UfhU1wQe?=
 =?us-ascii?Q?U3GAeI9I3kj/6PRYFfDHje/ee3diFCeCPkStZgFMzxtVfE66LEgmWRokomcp?=
 =?us-ascii?Q?45OwBLPzq/pM5vq4TE138xnz/8eB/HJyu12sVG9O6tvVvG0tK02igkcrhAgy?=
 =?us-ascii?Q?R0dXIqRdlyIcqL1b5qKg8r/By6pcEAkZo+Q9LTyZfBfx8PLQjcj0Crt1qFDH?=
 =?us-ascii?Q?+9bAB4eSKP/7qMMDOl8MSPXX8rWYwm4m79mVst/TmzDhSPZUBZN7Ag0F0kbJ?=
 =?us-ascii?Q?baHDT4C8jdFfPwTsqsgoMj2HhGTvEaSABMgsMXC1gmdRtcCZBi4qSJdzaV2n?=
 =?us-ascii?Q?CM0oBA6UlKcC0ScoWwjL5prOyEkwwmfzmKgvQ2UPCnb+VBgPCx7qex2LY5f8?=
 =?us-ascii?Q?LOUKeGxHhwzeeNu11DLCiEhTEI2ujTNk0WmQlVf1HVtmKI8Tj8jbojXe1QVh?=
 =?us-ascii?Q?fNAuf8EeTrVYY9tEZpzt2j+Fs6kXCLf0ShKYWOBs1eMhViuNzE7hDHTXdyJu?=
 =?us-ascii?Q?/LTXAY+Da6KFQyRNpqJEyEG5xTKbt+rwIiEcjEcOywLoNkb3RJzZQ+uc0ck5?=
 =?us-ascii?Q?7qMJeeKNHTJ+EreAWBDukyWoGoQ4bbOGGvBbksbkWrOkGTZTQVOAa+GTIJSV?=
 =?us-ascii?Q?RZY+2lWTU6UJO9Ko36Y8T3/NTLDIWKLSKLX00sfmej2vPwfnxYGSCrcOAsoH?=
 =?us-ascii?Q?PHWogZRac83XJ/3XcjZpYEy2UEsoFKVS2kTLEQc9GqcXRKJX3fHIuWt3cDS0?=
 =?us-ascii?Q?u7EuGoff8pO/KWsuCBCLckH6c7PFdhoWLOJvwYLV+jLX6kpnMNk1Ul3TqJbA?=
 =?us-ascii?Q?3j4QcwSYZMtd9Qm7eWqmNNILofihvyseMHPyGLnn?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB31DAF1F5A5174FB4335A4385A1B2D2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5799.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d218fe13-dd1d-4db4-d923-08dd52e671db
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 02:13:06.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1xc3tDsnHPR2nQaPjAiYR70VzoLcvsfchigg8j1L3YCsJaE+uPLc11LquE4xa1tFHROM9OMnjdK//HY8yMKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7773
X-Proofpoint-GUID: krXbY35ndpPazK4nmsOJd-6zMCklIury
X-Authority-Analysis: v=2.4 cv=EtworTcA c=1 sm=1 tr=0 ts=67b932b5 cx=c_pps a=Kq952KYlFoMAqHE57MuLQQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=rhJc5-LppCAA:10
 a=OUXY8nFuAAAA:8 a=7EkP3G8SuLa-og-nzGMA:9 a=CjuIK1q_8ugA:10 a=iFS0Xi_KNk6JYoBecTCZ:22 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: krXbY35ndpPazK4nmsOJd-6zMCklIury
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502220015

On Feb 19, 2025, at 12:38 PM, Brian Mak <makb@juniper.net> wrote

> I will also scratch up a patch to bring us back into compliance with the
> ELF specifications, and see if that fixes the userspace breakage with
> elfutils, while not breaking gdb or rr.

I did scratch up something for this to fix up the program header
ordering, but it seems eu-stack is still broken, even with the fix. GDB
continues to work fine with the fix.

Given that there's no known utilities that get fixed as a result of the
program header sorting, I'm not sure if it's worth taking the patch.
Maybe we can just proceed with the sysctl + sorting if the core dump
size limit is hit, and leave it at that. Thoughts?

The program header ordering fix is below if someone wants to peek at it.

Best,
Brian

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8054f44d39cf..8cf2bbc3cedf 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2021,6 +2021,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
 	struct elf_shdr *shdr4extnum =3D NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
+	struct elf_phdr *phdrs =3D NULL;
=20
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
@@ -2084,7 +2085,11 @@ static int elf_core_dump(struct coredump_params *cpr=
m)
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
 		goto end_coredump;
=20
-	/* Write program headers for segments dump */
+	phdrs =3D kvmalloc_array(cprm->vma_count, sizeof(*phdrs), GFP_KERNEL);
+	if (!phdrs)
+		goto end_coredump;
+
+	/* Construct sorted program headers for segments dump */
 	for (i =3D 0; i < cprm->vma_count; i++) {
 		struct core_vma_metadata *meta =3D cprm->vma_meta + i;
 		struct elf_phdr phdr;
@@ -2104,8 +2109,14 @@ static int elf_core_dump(struct coredump_params *cpr=
m)
 		if (meta->flags & VM_EXEC)
 			phdr.p_flags |=3D PF_X;
 		phdr.p_align =3D ELF_EXEC_PAGESIZE;
+		phdrs[meta->index] =3D phdr;
+	}
+
+	/* Write program headers for segments dump */
+	for (i =3D 0; i < cprm->vma_count; i++) {
+		struct elf_phdr *phdr =3D phdrs + i;
=20
-		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
+		if (!dump_emit(cprm, phdr, sizeof(*phdr)))
 			goto end_coredump;
 	}
=20
@@ -2140,6 +2151,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
=20
 end_coredump:
 	free_note_info(&info);
+	kvfree(phdrs);
 	kfree(shdr4extnum);
 	kfree(phdr4note);
 	return has_dumped;
diff --git a/fs/coredump.c b/fs/coredump.c
index 591700e1b2ce..0ddd75c3a914 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1226,6 +1226,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 	while ((vma =3D coredump_next_vma(&vmi, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
+		m->index =3D i;
 		m->start =3D vma->vm_start;
 		m->end =3D vma->vm_end;
 		m->flags =3D vma->vm_flags;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 77e6e195d1d6..cf1b9e53cd1e 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -9,6 +9,7 @@
=20
 #ifdef CONFIG_COREDUMP
 struct core_vma_metadata {
+	unsigned int  index;
 	unsigned long start, end;
 	unsigned long flags;
 	unsigned long dump_size;=

