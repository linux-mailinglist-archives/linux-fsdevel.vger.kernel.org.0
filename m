Return-Path: <linux-fsdevel+bounces-20232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1F8D0071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FC1F23B4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3ED15E5D6;
	Mon, 27 May 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fvc9bvyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A84D5A2;
	Mon, 27 May 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814300; cv=fail; b=AA1nY2Bhgo1Z5jnhqwD/mjFKL8Le6ofYYTyAcQUB5ML6Gc0DByCiiAgmMTiRGb8W/+i1svlR7KvcjIqtXJCa7PCvjwGM9nXKRU5kfY/jafwvWARNSJQXQsLNmy3rFs8sVIOpRKruvgfLkxRGp2RtFtb9sURu4PHRkwTibbq2sAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814300; c=relaxed/simple;
	bh=fOitD6dwkZ+N3YkDa0wSo0+E4c2nfzuZNS955u4I+mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bYWFmjf2y3U+stmmnwei/zc3SJ/3tBAq8xJvyn3gna+0Z03qbXcCXB4Z5pX//ve2Gq1o5SG458hq2WFhL9qg2KKP2WzWJ2v0UjF/IFuWSoU6GoluXOlRCsmmha6/t+7zh2t2r5jUbOqjnHbPiaxQO9W07MSkN5DV7byf8mykt2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fvc9bvyx; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RBuDg7005094;
	Mon, 27 May 2024 12:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=2
	/LalhRg18o+bupGGfNZkYFnUt8ixgujf3eFoxnIofo=; b=fvc9bvyx84m8cSM9h
	4CsVRbbNcJfEYLPk9LoO7zoWKn57hVtYAGwTPE8t90Bfo3ffUZFF1RZkecaxIpaR
	grB9qo+4mkB2lzVxRwXn3bv7Xt/yGj/ExQzSW/07/A6CEvCBo844u+VSqjYwHuis
	U90YGQcdOijQ/7Hdx+WQGq64k6Y8na7Ojb27RVr9uA6VS0jC5bq/z6BVHVV1zmQt
	iO2EMqqQgwh7mseLEjIKzgYt8o3ZD3NdJipWjxmJejfe3YSHNEOJ06GNVqCS3Dkb
	Vhj8LYQIQmGz7e48lgaeU2ELyfWL90Ya+osL/GzEdoJHnILFtu6Rf24cRSfkqUFH
	ZxFDw==
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb871skjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 12:51:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4hmAfnnxK9SErcVKo19mVXbZxYOu16gEEJo0Eg7IObvQ8QnW2vEqOyLSWEhmbTWa5UfRtQ0sqOHJW6Pxxbxwj2BxZk5Zoxwh4U79xiS98+SY6XdgAduUvojDgRUinW9Puffnu0cEZ98GRaEoYkU1FInXjnrnHJpx5NyypXUvflQjD0Emw53Y/hcmdC+rLUwyiloT/d502KsLq98dWmnGAngPVvYBk3R3c2cZA1GsAJneECGYpCN9QxFcyIe4HGsGvewMvbWLxYohsfA+yZR7xq4U4A0NwA/7OlVNLsI/5nUdd3GhU18j2nme1EE0qTJzounQnkFUqrRFkl4+sM+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/LalhRg18o+bupGGfNZkYFnUt8ixgujf3eFoxnIofo=;
 b=Ns5Y4xL2PI1vt4I/cH/gb7Wp4ugQCly6DpvymnRzP0diN7DBoXXvemGwD+PkR1r26Uugp1wJt4YKqjaiSAmFH3zuhN1pr6whhpEN0dUMbgTFwwXHXnHvev384YIOJYvzZIYlah2bCt3Ghe+oEnlf6E3Uwli4KjjezIlhOPApsLAf+MPOnvF3+aRNY8qexNIsXs9Lh0yIAZcQJr7t5X489jZ6GYr1XYyn1a7Ej9Bk5A5erFSuLO1a3cWg18XP8D3mu5HiQDQ1KTMluobzJka0O+fFb+lO8N5p+3UMb6QncV33AfUcLNnTGdwjUKx7O0L6m9/CkpffNOtBzWLgFMK37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by TYWPR01MB9308.jpnprd01.prod.outlook.com (2603:1096:400:1a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 12:51:07 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 12:51:07 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
	<djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Topic: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Index: AQHarBuqqIQ7Mttzp0e7Oah3njC7eLGlO2CAgAW3O9CAAATqAIAABjfQ
Date: Mon, 27 May 2024 12:51:07 +0000
Message-ID: 
 <TYAPR01MB40481A5A5DC3FA97917404E2F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <Zk+c532nfSCcjx+u@duo.ucw.cz>
 <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
 <ZlRseMV1HgI4zXNJ@infradead.org>
In-Reply-To: <ZlRseMV1HgI4zXNJ@infradead.org>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|TYWPR01MB9308:EE_
x-ms-office365-filtering-correlation-id: ea657b5d-be93-4782-a4c4-08dc7e4bad12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?hNMHKViV7oJUJGGIDxB/PaZMoYJ3n/w2NeWxE+E6hZK7rlAaLkn3l9Pa61U+?=
 =?us-ascii?Q?5gMdT1ldNhnosxkUMaGJ+aKLKWKpd2nHbUWfnJw0pLgFwS6rOAm8oHv/C4f4?=
 =?us-ascii?Q?1krqni7+Z9K5dQIfM0Rd3A32X9xIcccgBW4Xn16aDFHJ4y9wRTMVNcHQWdIf?=
 =?us-ascii?Q?Yx11Q4A6xgVrNFX60Hx905CZyLuKvuEDJFIjD4cgoK6oa39vDdvfvqVTrrbR?=
 =?us-ascii?Q?6azZKokSTMV3SDtoi5WfVlbIiEfY09i92vp09Ayc8WzpsOj8vnVOm0w8O0UE?=
 =?us-ascii?Q?BtDXJ79qr/mtSYXRZU71ysGWNI8tYb3t5BZJbLVJprUD3UcusrQGO7S15+9X?=
 =?us-ascii?Q?IuYnhVvB3BAt33+tVuix4DlNVWW4665BrcQP6S7YwYSU/ckHgBqm9gSXix83?=
 =?us-ascii?Q?2I2Ezl06dWJ4tyT32XwhNDGRLWRzDKH0/hVBNUGmpU0SaBPQ0HAyUx/uKJTu?=
 =?us-ascii?Q?Ds3t755oVcoWY9YGTbHenq1NmCeOqCbC+3dd4T1Mu5iny10PL1dDO0C9gabl?=
 =?us-ascii?Q?K/5GX+FUPqI6fov8dp6YfMqF8PVsCBmLa5IV0jkuUBDTsT9uIHQQIbfFPjvN?=
 =?us-ascii?Q?4K4SiJVZlexliZOeQ8ZfE+KleOrgnyXJ6XXrkz0kHabW23y+8kPuWvQi+fWJ?=
 =?us-ascii?Q?BtDiZumIa8H0xVldMb1TTMgNqkI/XLDVfznJPvaHT2co4T9EPWqQcgwD4UZW?=
 =?us-ascii?Q?Tv+yIaR2KB84DHKKBjrE9Fbo0fBAabIyOtoXXZBdXO3QGyuyldryLD5k4xiF?=
 =?us-ascii?Q?0Csr7duwosDZtBDeQh+mpq6pCc9kA7q6+3IFX3bEqMZ9ChtzFOj1mccoKKcg?=
 =?us-ascii?Q?HvqSBkjHQhbCz9Av0aOc2Wq08zzbBF0GW5cQ6ykAntnG1vBaI2Qqf8KO7ja9?=
 =?us-ascii?Q?zE/rQZDqWCQ9e5YTGMAQKboJusYEIikiU+rUJiXI8IRnJsMH2pcF6M9SmnlR?=
 =?us-ascii?Q?W0AyHbZyw0oBZzcbqR0Ulx0g5A20YigVxPEtW8PjLZM8LtWo1oqvbtET/kW8?=
 =?us-ascii?Q?FCB+qWlQ+aaF3k1QFwl6sHmQTW77lZEjzznH8slnrzATkPaeiFbFjA32INu7?=
 =?us-ascii?Q?atRA1y8+kn/y9oNxbaB9O+Uj4Lw2b4np8NyTjttTOavDLV7QpS/bhM4nuv/E?=
 =?us-ascii?Q?1yfRZK34zJazT+ulvoSq6YygH/AZBr5BIiCAk1TcM0YRdMjqrYSCS9mzPpMo?=
 =?us-ascii?Q?tNX4FDeRLUH33mRKmReI3EcoBVdRZUIjkgtgUZ87SOzEtsg3YOoDC0NnZdY8?=
 =?us-ascii?Q?B5S14pBonsDx4oQgrMQJkcRH7JFWzaZcfLxnQIEQkhfxzrXND14txlCxy5ac?=
 =?us-ascii?Q?xfYv5ikupy+G4u7jp2aN+g5wz2EdVTQ/bmBBDj/GW445Fg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Nml9l4MzJhpIK7T7d2zXvBLkIxDrM0Onjcl9OzxSPhdnVTQ8iJEHaJFe+v+r?=
 =?us-ascii?Q?6JETqzEEjj7FTE6S8ZeVA3JJH2tmslM8RRG8yMDesY1Z1/OMhVsq8A2hKZgT?=
 =?us-ascii?Q?7GreRcZJ9gGVuN0BbklZHt5TSCeIiDgNftlTuJzjUMls9x81/6pk8tB5DRBo?=
 =?us-ascii?Q?OkUh3cWUcXldDoZagj5WhqciAdhuyTLLAtowJTMEEPCZT1X6zFeuew6yTPiT?=
 =?us-ascii?Q?JZiKqFwWYSYAFmy5Qpooo86Pu5UsZOSySes5GoxgK0DnNs4AWqoQwybnX23k?=
 =?us-ascii?Q?+tFL7yW1dvYhjcxjKtpL9OPJ5wmiF82wVXtHXwUPavS/0KWWLbLXr9mJMryO?=
 =?us-ascii?Q?7dtZn7XvdOoJcqG2ozTzrxKkndF0e2b4YPUhaxd5kY/gNIFvIxEYEyNxb0Xp?=
 =?us-ascii?Q?LKSqmcwcBOzYQ2ouinabLEfE+O/nhqqqmCWjddWCY2ipsgNUNhJM+T8lkQgg?=
 =?us-ascii?Q?yxzGeKVh9qwWXNBh3u1iMdr/i0D5rK+2tcQxhUtg5CYmrtqjYZdhgi3gs6Ee?=
 =?us-ascii?Q?FhhhdDGu8l31oQ3AXu4kOOH1shOtfqsvZLl+11QiCuP1H09FawKsn19TL59Q?=
 =?us-ascii?Q?IIGwY5j3MjeaSzpgwcS6A0m/IE8t97EccF0yYy7IwgDT/X5i0uFKqezk7xkk?=
 =?us-ascii?Q?dPmFps2R+PodC+geXUZ4lOd1DKkn24zVUSeT537vB9TMcNp6aTjEjVE6OYyX?=
 =?us-ascii?Q?WaDVkSMbMVCssCU16JKWTafCj1Xmqgm7GzT+IJ3rAWDt4YNPB0LI8ikpGaa7?=
 =?us-ascii?Q?cjSKN1ZD9gqaElB7cAs6tTJ3YTo7IJ7JE/bWoMkuMiv46xBieVwcDBiXk8nf?=
 =?us-ascii?Q?+37cbIiM/7GTI1LmSSSSJRWLulAgfOeEfWRot1Oz9fhE99RvdootLvfel6GD?=
 =?us-ascii?Q?/4t16eegc6fwJof5DyCR+i2RrwCD2584ylo6bMzztZnpDW4WC5hXRYjVvlG3?=
 =?us-ascii?Q?fS7YL0b6VsLSnHQFsHL71kzT1MYe4uajixzRisSAf5KhwQobmGu5igjoY6s2?=
 =?us-ascii?Q?J+PjfVJwkHMOQH9nMOj8/DeFcN07NSZB8pqnUOIMcYfm/rU2pKC117pvb5bg?=
 =?us-ascii?Q?DoQrpZXtP3FQl6OtYnAH1qN8B2pljuYV8PMrSRTM/Hl1XscSb2HBaZgNziLT?=
 =?us-ascii?Q?zWilh2xiH0K6ENy8CyaswleEwKf6pQwit4SeTxtBbOyihYrBhbFaqRr+I1a2?=
 =?us-ascii?Q?vG0zU4SGMNxUKLjQiOJWFzX8LaWhQv/KEVRX9KO4Q00Ymqft4phYm70hDkKf?=
 =?us-ascii?Q?1xBUcaNDk/hGcwNolu7zlEDOJHJqkDLgNzCDL5Te+GLbhikTeSbwtDs7kbol?=
 =?us-ascii?Q?9J+GEhD3uNEK03J5LUYgFN9rCW/9An3j8ykGuA/Sis78zHGlMF4l2nQO1bXW?=
 =?us-ascii?Q?0AFkKvh3NdCBndjiwoqnNsE+a2gclWYrccTdd4MbGi+yl2CatovHW08ueVjO?=
 =?us-ascii?Q?cUj4s8AlTostuGfzsBtqwUVRGE72+CU0E0jNC5829y7WdhoVh2AoLePrwkjM?=
 =?us-ascii?Q?TOIlWkA20Hfn/+0wScQP9iLZiT8TzbNpRuCRdBHZ1tPB1aZb4FDjrgZyp0Cr?=
 =?us-ascii?Q?gYQ3o0P0mMVmLh61E9HaZT5ve9BlJuFNEmZSTkttbYzNUyfRHW+G7HmRcZlB?=
 =?us-ascii?Q?PE5B4a24QNLu9o4c37D967NfHhdPEnz/fBn0wMd+ffZg?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hvmsTXZ2Vun+VSg31JEChK+tDhPj9/lOPKFs6mCYVTgGS5+abEXPvBMIblKPYpcWtJymy1bWn/C6JVRPqYLKjLX1GMQwpOTRP7P33gfsc03GolNPQtGupaTGj/POr3Upjw50oD7f9m6FmV3mfkkYRIAoxvgU89WyOFaba9DDZcNZCVuF3oYYAZyvjyfJOMlHrMWiV+NSbv2E6a/rUWWGsxK9B3W6fjip/49lBFIvJcJ/5K648iUw2SAd91LLlLfp1SPgfHE+jXeFK0QQWHutnUnhEb2PRgqmdn0qY0nwW14HZKLyMAAESuoXg6jYjTusasl/ZbTK2qDv85uzlnNFf8vsk3riIaCdOFc/jsUDP5T3ezdjyPVGZq5ebn0zihTsQHO9IpgRHtqC8f4xMZ3nyZLlh0D9/19dEbO5csJ6yMN1T8Wl00ulQBCy0Cd4CkSOkm5QOz4L2qOxclR0V3Fu3nT0ZiO+v+qmxUoyOX5dcWcJuoOF2U4SNLATzOFXiclnxzfCniHHg+57qsDe+pyoVxqP4CiTQofHTrc6Eeg7zy0aXEiZ+YI4ZORZOHzCSBjXyzBKf8IIiNyUKnQQwqzkeZFSkNVVManZSdDTUzlbdnJRwuWisLJczEUxd7b713sJ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea657b5d-be93-4782-a4c4-08dc7e4bad12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 12:51:07.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FV3Y+G5u6rgARZUfE4JVrWi3BipxdeI8nYDTRzcEB+NAcV7YZ2Res+Ixhb6SDB8eJbZU62llEJ1DsUVGZTfoXV0YHFquWwcgIyiCKY5WxXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9308
X-Proofpoint-GUID: IfdeQyA8BGmzp-krjflx-Yf6utxDA6Mg
X-Proofpoint-ORIG-GUID: IfdeQyA8BGmzp-krjflx-Yf6utxDA6Mg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: IfdeQyA8BGmzp-krjflx-Yf6utxDA6Mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_02,2024-05-24_01,2024-05-17_01

Hi Christoph,

On 2024-05-27 20:20, Christoph Hellwig wrote:
> On Mon, May 27, 2024 at 11:06:11AM +0000, Sukrit.Bhatnagar@sony.com wrote=
:
>> We can pass the starting physical block offset of a swapfile into
>> /sys/power/resume_offset, and hibernate can directly read/write
>> into it using the swap extents information created by iomap during
>> swapon. On resume, the kernel would read this offset value from
>> the commandline parameters, and then access the swapfile.
>=20
> Reading a physical address from userspace is not a proper interface.
> What is this code even trying to do with it?

I understand your point. Ideally, the low-level stuff such as finding
the physical block offset should not be handled in the userspace.

In my understanding, the resume offset in hibernate is used as follows.

Suspend
- Hibernate looks up the swap/swapfile using the details we pass in the
  sysfs entries, in the function swsusp_swap_check():
  * /sys/power/resume - path/uuid/major:minor of the swap partition (or
                        non-swap partition for swapfile)
  * /sys/power/resume_offset - physical offset of the swapfile in that
                               partition
  * If no resume device is specified, it just uses the first available swap=
!
- It then proceeds to write the image to the specified swap.
  (The allocation of swap pages is done by the swapfile code internally.)
- When writing is finished, the swap header needs to be updated with some
  metadata, in the function mark_swapfiles().
  * Hibernate creates bio requests to read/write the header (which is the
    first page of swap) using that physical block offset.

Resume
- Hibernate gets the partition and offset values from kernel command-line
  parameters "resume" and "resume_offset" (which must be set from
  userspace, not ideal).
- It checks for valid hibernate swap signature by reading the swap header.
  * Hibernate creates bio requests again, using the physical block offset,
    but the one from kernel command-line this time.
- Then it restores image and resumes into the previously saved kernel.

--
Sukrit

