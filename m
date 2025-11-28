Return-Path: <linux-fsdevel+bounces-70132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B88CEC91C27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F400C34A6EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D330C610;
	Fri, 28 Nov 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="o6YuER2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A62D7DF2;
	Fri, 28 Nov 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328205; cv=fail; b=rm7o9yobBuldhwN0fwUTvD7cf3BYuSTTmK33BaCLpgZer/6dSt/3/3a2BI/8LdV8350AvTvkgr1MP0qX+6887yBl3FQW13HU0qFWlOQzuXkyIuCNPf3ZpAm/mDVGJKEI1fy+/jRSCot68vzsKPbE2IqRNl6t44AFyLB5ywZXI4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328205; c=relaxed/simple;
	bh=MAoerDo1VpfB6xOXPm00qdd4picGTPiMNwc5bTKlOwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3xKigHcHqM8r4Nh/4Msl9/OoGIUQL4mHkY6KmE2o1O+QzZTKOM8xpI28WdLxhcgl9E1DFk+dO3vruDGTs4bX6JHNLKuh+kCK3e7iCZvsp6ed2m0FeRsG95Io61DuYdjvAQVcE5bOMlCzE9KKAOaYM9BiATkSCNY/VxzpQfSxzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=o6YuER2y; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARMuKBZ003235;
	Fri, 28 Nov 2025 11:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=RL6EOHu
	ww+FJ1DK/sH/z+576rUhM0FO0hKRE+o8nXys=; b=o6YuER2yHg35gwgT15SDmJB
	Cr+6/Eqp+pbs3cB3RMdjCRInRMaqhUPyvExudmBQ3Vj0KwsZlyYBWPYafquUhxqu
	xxOpg2+M4otfOVMRuNHst0pW3HJJTApp4h1+tgHAx6KEDzDq+//tBWSCqiXGc15M
	mbNq75pSUapmjtMnZJuQ1wrBdpv6XOM9I1XjYi+3cHR10ZMRNNE8VqsM1vlSi6PO
	FHcfiI+jxm+IA45Ke2pOrkIJNFMBzi1gtZ4D2dDIm3O24DmxgCx3iKpQUlNuohM1
	YOzZu/bavJKYonxu9d0y1/aRucO/1MHOm6MMCnb1j4TBDD8JOSjIOXHFeMWgPlA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012033.outbound.protection.outlook.com [40.107.75.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4ak3y781gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 11:09:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDZ+o2AzIZoswJIAVlZx3sSTcJ4joSHh2dDrL9SDuS7bmzOchrREyjN2+69NeeMRKBYTizgaCQNIFs1vQ1eqYrucZvqhgxh80zPoulWyU3xElJH5SGjnLW3ww18NF0HIypo5YTLA5JtAaHaXbsmOIKsqQLCeG+tCHi4XbWerzEpYvfwLSqPMoRvZZu70QN6SOdqrd0XaoIax1rz/qbHm+VV9tvOnDrt6PloUxoTHyX8eMZ6rVl9hD48UQ87C+slNoy7ijKu/NYU+Xz2QCNN7CB4RUPUCeLDU3LoePJPnjhZsNMeIjEsLPbh4BTaVRg8o4aQO0S+o9dCUgX8DFcBm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL6EOHuww+FJ1DK/sH/z+576rUhM0FO0hKRE+o8nXys=;
 b=tk1Cq97hhM2lc4LdOcQHflAOqgsmMMZEJjZsopMzUSjzIM0zxfkcjBi2bdZPwFTTw6IOrl/CzQARqrJMfgxET+8EcpT7Wc8PbWWR86GExJvAiyqNvo8uOFk8QUiV6y5OkAB1TTvLTuDIGfaW4seBhZtjyu+Mh7AqRKKog3J00YT7b6hYhQlNB/mpRB6Jq6LI7oc04PnAiRfno25ESjR93VZ+t5Cw4HL4WsEnSfPH5wY8i9NezVo/F03RH7meAbrYYlxkyaj0nFib596Vj4pvc4SECL7NV4K7uyMb6PafWIYmRjgi8ik8TQ6ErZu8WllR2NES0j1KfGxxlCh7L9qEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7064.apcprd04.prod.outlook.com (2603:1096:101:172::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 11:09:02 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9343.009; Fri, 28 Nov 2025
 11:09:01 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox
	<willy@infradead.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>,
        Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [RFC PATCH 6/7] exfat: introduce exfat_count_contig_clusters
Thread-Topic: [RFC PATCH 6/7] exfat: introduce exfat_count_contig_clusters
Thread-Index: AQHcWGUPJWESmtvg1U2EQn8s7QC1mbUH9Vbr
Date: Fri, 28 Nov 2025 11:09:01 +0000
Message-ID:
 <PUZPR04MB6316A47C9E593BCF7EB550B881DCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
 <20251118082208.1034186-7-chizhiling@163.com>
In-Reply-To: <20251118082208.1034186-7-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7064:EE_
x-ms-office365-filtering-correlation-id: 285aa81b-2be1-401c-665c-08de2e6e8914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TUn5P4gVhfv0cAm+vBtf69d/pR8Et4YHW8YKqEwfwvpUru7wlpBFUzXoAA?=
 =?iso-8859-1?Q?gDZ2lcWIozvLXE+LWu5GsL2TVuuRswv4VXIpXVpodw351+a5N2886tW2/F?=
 =?iso-8859-1?Q?QMk/T9LM9PmJo2M4ibRhqnkXgxj7gxoU0rCTlrSShrSrBnTPYbgfkQf4p4?=
 =?iso-8859-1?Q?U70K5OTm4xXZQtZPCYgaX+vhSeYh4dMcMZV1JjH8vaHpnRMKEr+R+rYT59?=
 =?iso-8859-1?Q?CCqC0rVGLkZBZLjb2jgNF7qqLGtnxA1deYJpWaBBPNIZUpkuMxlc3DsI7f?=
 =?iso-8859-1?Q?5ZorXpZj/sSXbDpgafcU5pUHQL8yQ0d0lcg38p7pdGZvMUx64psFLsBJsf?=
 =?iso-8859-1?Q?N1OYMJgJAN6Gh/2tmk7aQQSrba6hUbBtsMrXy1VtfFfVUgcqlpolkh0i8z?=
 =?iso-8859-1?Q?KKzXa9SCCAagb68f6m5gaav1DethP3T7ibGREgEdjjgjJoN9FnLXeK4xr0?=
 =?iso-8859-1?Q?zrfWt1cP9b6jbhR6FhQ56n2HyASmDo4FouKzDLUcoft3FmrMrT5WD38P9H?=
 =?iso-8859-1?Q?07mejDEnvu2msG1glJPZrU9RdRi/avqp5fy7YFm1MW817OsbfkumuwL7BS?=
 =?iso-8859-1?Q?U0TnZhqgZ9VYd/KCNRHXqKVCVKn7mgt+QbNM75nq4zC7RANkIKM41zRP3I?=
 =?iso-8859-1?Q?jA75yi5b4Fjnph4lQMz18DWnbcmkoRc6lVXA0eA5lF18aI10fEcdQDnz7k?=
 =?iso-8859-1?Q?vf4obt3gdZL+68VTwldeP23LviDAhrS2+/AVQ3r2bA+/GSqFikUSLUcvbn?=
 =?iso-8859-1?Q?DewzZ7D7W0JPvMotwnEW9KY2+09PHMljC4U6wgT55fBWJ9dqSYd3v6fcKP?=
 =?iso-8859-1?Q?bIHrR7NrszH4gG14gXKMwO2wal24hYkgH14Y5lL/b/NTtIUiPreF/IHftw?=
 =?iso-8859-1?Q?gv1b7xDpgN/7nwfcSIEZcaP0GloHOB7MHaceQH1Om1OeL0PZrgq398xzSl?=
 =?iso-8859-1?Q?Z1m+QNaxJzTymm859ppzsU3UyavhtaYKrnuefAJqfNCNtFTfwSlGur1cz8?=
 =?iso-8859-1?Q?w3XddDgXMcn4n54LlkMCuSXdKZN3k7PaYVvz+JEN8MW3IAWFnKOQUhplOs?=
 =?iso-8859-1?Q?4SL4tVbxJdMhaCGo9DCIxH88SiDKUMBl83nU4Uy2WN9/vtaYe/7r+alGg3?=
 =?iso-8859-1?Q?OqEwOzMuXkM7wuSBvG/bOUPBAotY3asH/7GRKnV7e1Yis/ixA/syQeryEq?=
 =?iso-8859-1?Q?qzHS/1+2ZbukQv9oE96K+AfiRrbd/q4Z2vi9ptL6Ii0uHjr1NefD+znCZ9?=
 =?iso-8859-1?Q?qEfjDbfAVwKTh9neCNYLdnXHT2gkacdGAzAaN0XYQbHHzuJ6dRpr8rTGLz?=
 =?iso-8859-1?Q?Eg5B3n+ZhmdB5TxQh9aGhe0wwo3T7iPGYbxb/ATp5+QBAAgJme4nkgYnqI?=
 =?iso-8859-1?Q?P3CBxJ1uQxY4TnFEEl3wHa7/kC6wf85l803ULEo4yJL4J0ntggeGLMptHX?=
 =?iso-8859-1?Q?DLE3+iW5USAl3MDwq1ahAXFEp+tHcLf5YOa2KFpg0RVcHXw73fG7SdemzD?=
 =?iso-8859-1?Q?RW4NaSrZw4oX0w3Wy+vOhrVOyCSqHlUFgL5ANz5kdqZ0MFXaiLmWa7d3Xn?=
 =?iso-8859-1?Q?oUmFsa1efNJWxm/2CeZgy77TFVyB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gYDgNCp3qEA1ilvyzVZ3r0ncCFsSePLf9PeuJRc0CO8pGjh4vggtxLKwBM?=
 =?iso-8859-1?Q?45tB0ZrlBxUept72KgClcv3PAKqvGYNksxVUug8Phuv2RshBFA86R+CyCn?=
 =?iso-8859-1?Q?Nv8/TBbMlbzfuzUl7Gwk5AqcwIvR3tnIfMTDBkdvynx5keMdwetDTjW3Vp?=
 =?iso-8859-1?Q?IjX4u8dqhhWXsth+2s5MH3JQ7FjbBeokZt8cChElyytlmxDBBEIw4/HkiE?=
 =?iso-8859-1?Q?pdZJeC6nnZ1ZGVIzzAcH1Vk/vOUPuHJsIpkCZnflctcrSzvBfkkNuM1Rso?=
 =?iso-8859-1?Q?tusLkvc0RzKbE2Sr/byiBS7Djstt14z+QIlu5FbuEgMUQZKvSuPYdK2zav?=
 =?iso-8859-1?Q?m6GSVRG2SeakR8enWpbU7I894pwd+8OFDlEJ52U8ueA5u2ZpaI9hdb7HdD?=
 =?iso-8859-1?Q?JoyKejQ22jDxpNxxd4Ta1pUQD9FDR0swT/UpwalSEDOqJVTPwMTl301Ll7?=
 =?iso-8859-1?Q?xqhU63IwehcT6rQnPpLUffb5clNl9dk6OiPStMWMht22QEANMNCNdcXBJp?=
 =?iso-8859-1?Q?yvHRG1N8NbQziWyUidtKLZN7J4dfA+umITydjaPrzwXiB7O9/Lpaiwma3O?=
 =?iso-8859-1?Q?cxgrjW8XSTvQCs3LEgoSIb6j+UwTkdoScuJ/Y/wzeRCYpt05Lf9IzBGvpd?=
 =?iso-8859-1?Q?NNRN3c5Ud64ujYkE2jvikpjYcLuKw+u7N5Mw2YIKpqghwQSzqSer1ZosVh?=
 =?iso-8859-1?Q?e8yGGaaZ0JYln3xCZTv7Wa4SWfkJR+j+mXeWMzuU8ipk9SzvJkVmQniqJ6?=
 =?iso-8859-1?Q?n/TJAYN6hLLcDNPxY0ojlc9agxoxCuX5Wus5KG6bPeb1SJ7p+71NU+cYub?=
 =?iso-8859-1?Q?id4+qZ3V1DYBoEem//BqHB2NvkQNkD9F9yIE5P0D0cA+6MsRT7b2bYemho?=
 =?iso-8859-1?Q?YuHMn2bcZU2i5BJHjqR8HBdewQxSYnCQDTiYdsQypqF5fJ65BTVAdTPCmd?=
 =?iso-8859-1?Q?2gPea+DvAkhkhvkVEPvJwDuAzSjUfKTb3Vpn406DHbEexnoHeKlXJhIDRq?=
 =?iso-8859-1?Q?1zRaMMXJxt6G421T0M/y6ai1CEEQIBrA/FbASzdNOmiq2CTeBYK4NfKoao?=
 =?iso-8859-1?Q?HDTMn1bB4YdaHbkBoHc6U7aMUAywF+87iRbj8Esp2yfHZVdRIzBKVSNcb2?=
 =?iso-8859-1?Q?SSmalSiFEoyp/HDKbe5a6HfWwvA6LyjPhW0limr5U5HkdpBkgg9CWnQaW8?=
 =?iso-8859-1?Q?PyqIWbIgr2ECbCVnxFBK1mtYEb2CZ8gefoUvKPK0psZhRSUwwMCXwM4SFM?=
 =?iso-8859-1?Q?mmB0J2FBYd1DZeFdbQFzJ3Dcqu8teONRB/cjgEZ28EFidEcTOHFPJ67kaw?=
 =?iso-8859-1?Q?CHC58wsLET+d/nEGeOLnElkIuAyZdngHlIUNJF3Hr/f53FfvgIs4DuYGq/?=
 =?iso-8859-1?Q?l5P9NQJh72Uepqlakb+MM1uZzLEnbvdr+lR7LXs98qGzk6q/aBb5kLG7N2?=
 =?iso-8859-1?Q?TiXJj/bvjN7Jm6Mj6OqdBKvkzAaobCx2zZPwddWTTV7exhxpiwFnO+U5oy?=
 =?iso-8859-1?Q?+kUN6+9suJZEZ9Ax5YoRX7Y4W6uiG8ipoOb0kEj4iYVj5IM1iMstRUQVDh?=
 =?iso-8859-1?Q?cz6EM/AYXblJ5Zb/NS5RR2jjHKINixsMYwZti+Y+xI9G+X+S4+G8MBlGwE?=
 =?iso-8859-1?Q?BuhtxFet9BUVddrHo+FwCuFX+S20Nj9wbVRKcHzrs/u5njUBRaoHW4/w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SgOEm0eULdze2AWHYJ5dJRCzOKKR60U3ltAJ9K3ypZkUR6fE6OHnRLeGk9OkjVWDR/pe86FNESzDLm0pQQNG8lOPnw65db8F7jucAqY84HHd0HFybyGD/mSu0AlZoDlGyDYJM05OtGNUJJxZdLcYXUoBgzEqKfvs362Jvxm3c/RpXnIsgq4lPHafrH/kscNDo9YCpw+I3WkSg8BmCczYsYQKHUz5Jj/sJBQXC5oTduJ4yrXJmRYxv2RWoCpe5/lsOsZS0BOfW2CVzn2dz1f7DN5/r553PWwPMzmAm4xC8kX3Hnh/pzqXyM1fNp8FscP29Eu794mbX0K7J0Z33AGY6CgjlTiItRQPyfBDwSaaWIeZf9gJ5y+g77IffxjI/oKVMODWbOVlagY95dLcnFHhMbRcbDGxSHZUbQD5J6rHMfu9/gVhyG+TEjPL0vrJm+vB/tURGQdX6dLmIbXVni7uELJp0f3qmGjH7kGgAx/C5PzGgopQySSuuesJuuXHOKYvUHcmuKI1+ayCnwNNNnNdcJOpzfzbNEI9bLIzsrMorr59hWJlozoBmW/zvwykBIP9uLj+QS5ljJUtQlDwcxwdLKpJloOMBSTMN0ky6dxbahtdom5B7eyjff0aw82st13N
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285aa81b-2be1-401c-665c-08de2e6e8914
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 11:09:01.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twrEoBq6+PEg2o3UCfxvc3vrYG4y/oopoc00oK8NZaRfLNSLqNO2xcYYLxwC308NYlG8DxvGVDK0VBXm0UKLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNCBTYWx0ZWRfX9nSmX4RtwPA/ wvmzOUUiB683fOuVaGC2ypEprGC0h4+a3+OcCmfdkJa/GcxZ9tBzuxYWQU3JKQ57ZH5VXcg6bYz GdF5u0pbx3t9qeahPcy5vZuu2qumBcC8v3TWxj33dzyZiF7A7PeLylD3Op8SZ8bVpyJz6INpsKo
 0DWAHg/BDcwfO1IKbuoP6xY++aesBm+ZCQi++oQN271DMTdhinhKdMQBVSF3fTD4ZcJvXACkAQ7 Hm0pt/HArWYnJdxtCVeYgDIrXJ0sdIuAjylfGn4Qyfc2mIhSaZ3+DHi+4DiiWkUOIH+i3kGmVRg M+l86Vo7g2+aUfa3L0Z6+0sfhwrg+ejUKCangg2lLdrL3jBNWkjR0wc/djQ5ylZmWJetyTrrZ2k
 fdmIdJn/fg3bQmcnbqbKLxOEKmVzBQ==
X-Proofpoint-GUID: xuEU0ufYG01uIkeQepNiBkS-4Yv70wjI
X-Authority-Analysis: v=2.4 cv=O9g0fR9W c=1 sm=1 tr=0 ts=692982d9 cx=c_pps a=gFJVHZCVAhmtLL1cVVoHwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WFrTRzzkaIbLXfjVCzsA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: xuEU0ufYG01uIkeQepNiBkS-4Yv70wjI
X-Sony-Outbound-GUID: xuEU0ufYG01uIkeQepNiBkS-4Yv70wjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01

> From: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> =0A=
> This patch introduces exfat_count_contig_clusters to obtain batch entries=
,=0A=
> which is an infrastructure used to support iomap.=0A=
> =0A=
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>=0A=
> ---=0A=
>  fs/exfat/exfat_fs.h |  2 ++=0A=
>  fs/exfat/fatent.c   | 33 +++++++++++++++++++++++++++++++++=0A=
>  2 files changed, 35 insertions(+)=0A=
> =0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index d52893276e9a..421dd7c61cca 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -449,6 +449,8 @@ int exfat_find_last_cluster(struct super_block *sb, s=
truct exfat_chain *p_chain,=0A=
>                 unsigned int *ret_clu);=0A=
>  int exfat_count_num_clusters(struct super_block *sb,=0A=
>                 struct exfat_chain *p_chain, unsigned int *ret_count);=0A=
> +int exfat_count_contig_clusters(struct super_block *sb,=0A=
> +               struct exfat_chain *p_chain, unsigned int *ret_count);=0A=
> =0A=
>  /* balloc.c */=0A=
>  int exfat_load_bitmap(struct super_block *sb);=0A=
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c=0A=
> index d980d17176c2..9dcee9524155 100644=0A=
> --- a/fs/exfat/fatent.c=0A=
> +++ b/fs/exfat/fatent.c=0A=
> @@ -524,3 +524,36 @@ int exfat_count_num_clusters(struct super_block *sb,=
=0A=
> =0A=
>         return 0;=0A=
>  }=0A=
> +=0A=
> +int exfat_count_contig_clusters(struct super_block *sb,=0A=
> +               struct exfat_chain *p_chain, unsigned int *ret_count)=0A=
> +{=0A=
> +       struct buffer_head *bh =3D NULL;=0A=
> +       unsigned int clu, next_clu;=0A=
> +       unsigned int count;=0A=
> +=0A=
> +       if (!p_chain->dir || p_chain->dir =3D=3D EXFAT_EOF_CLUSTER) {=0A=
> +               *ret_count =3D 0;=0A=
> +               return 0;=0A=
> +       }=0A=
> +=0A=
> +       if (p_chain->flags =3D=3D ALLOC_NO_FAT_CHAIN) {=0A=
> +               *ret_count =3D p_chain->size;=0A=
> +               return 0;=0A=
> +       }=0A=
> +=0A=
> +       clu =3D p_chain->dir;=0A=
> +       for (count =3D 1; count < p_chain->size; count++) {=0A=
> +               if (exfat_ent_get(sb, clu, &next_clu, &bh))=0A=
> +                       return -EIO;=0A=
> +               if (++clu !=3D next_clu)=0A=
> +                       break;=0A=
> +       }=0A=
> +=0A=
> +       /* TODO: Update p_claim to help caller read ahead the next block =
*/=0A=
> +=0A=
> +       brelse(bh);=0A=
> +       *ret_count =3D count;=0A=
> +=0A=
> +       return 0;=0A=
> +}=0A=
=0A=
Hi Chi,=0A=
=0A=
The clusters traversed in exfat_get_cluster() are cached to=0A=
->cache_lru, but the clusters traversed in this function are=0A=
not.=0A=
=0A=
I think we can implement this functionality in exfat_get_cluster()=0A=
and cache the clusters.=0A=
=0A=
> --=0A=
> 2.43.0=0A=

