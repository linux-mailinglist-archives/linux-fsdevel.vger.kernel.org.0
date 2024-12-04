Return-Path: <linux-fsdevel+bounces-36397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B219E34FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FB41648A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE09187858;
	Wed,  4 Dec 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="FDJTN19W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E31FA4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299653; cv=fail; b=REsWNiv4qmKVaWdcvGZuZAcEifpfeuu/YXRkyvwJU0lYZ1qktKqaUCzpvKqYSKNPKb3YiWZfYVvmeTTZWAJc30b8KgYeh2NqpcLyTegbfdFwn0PmZaW9hKxGMMfZruLQcopDLIQq3ksed0eCk240kWw7iOamC7rQ4trUvXvKr+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299653; c=relaxed/simple;
	bh=+87nQ8sQqt8E41rbLjwcQDToTDezStj9pUxGUG8BJUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgJxMoV8NUzzDMIKTpUB8bJY6qnnjrIHmmvIyjCZ9xeAbSuIeB0fJFQzXil9XiCsPKC4g09kayU3NWh452g/1zGk+NoM/h6Xag/Hx2Gz7qliKQHWkXplOCLutOJFUTVfdAAnT9mg9urok6EsSLTEdnd2enzi68Ek0kgIXD5xj1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=FDJTN19W; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47UlOc000608;
	Wed, 4 Dec 2024 08:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=UKJ4IVf
	TmYqC9L6CejGQrnR+MgTm+PsEyhz6tEMOWaM=; b=FDJTN19WuCaafOYOxCZ2aNi
	U5dYSwZcTEm0U7SUkQqwr8D6Pk+pDD+XXnmecULdfKfejN04nYVhB+MILstRsvN8
	0gtJ7KWQaWbJaadTQ1Ss1vJAvJ8463g0nL/Su9H+WaF8U2RwGDPb4XNPZlwgF/9W
	kT+GBgV2DxfdGqRR8DJFg8ixmceJIx7lCO1rcAc1zjtpEXhsLK0q22aCwc6M83GN
	1DIGxsnUb5UzVwerzU064j24cIiFfZOwZtDhgr2scglcZtNOsSFHSCIGafzZ/7fp
	TwbwEIMhFARvyyFgFx3DGMgBZ/xCUkGK5b8SthjHNOsW6/REg9hrP9annC4/C4Q=
	=
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 437sbwbqqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 08:07:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVOi+ERtLFwXhokCMTqrHx41qt12+i8nj2Mk31avfY5dGulc+IiaAQfxYOoeqefvQ3hS5VWKkH+zkcAN58Y3YVdMntJIR+QdHqpp1RTKYmr+FMQgsNfT9uh89xyIZLKuhZJ5PbQ29jaf5mxuJe4oJi+VCuQL6LJnolqvybFRo/M3PY6E9sltsZCQ475Xha/28pUL4L1Z9CZFML6Rg6Rjc5Gos0BJ567v4UDL4ri6HL2EIAwjszAp2AG1juVveah85dIo2426tdpW1prwGGZnUHFUlHNQ0D1k+Sna6mp7S5AmaX0BCOuNRtl3rvSMd7DRBSBZKrPxEH35nR8qey5DEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKJ4IVfTmYqC9L6CejGQrnR+MgTm+PsEyhz6tEMOWaM=;
 b=ib2LQidO8jxxKwo0Do5qx/XOGJGexCEmlHa3CNc4kKIXbC5Qp7GKGk1wzolO73/PO1to/YrHCoQaoH7uXC+uCiy2rlFFhBMIatxlE/0Z1T6RzKb00JfJtjaeCt+MDyim9Ql1Ka4h4BKlNXjSQDL6S7T+gCRCExBQ7nXT5dciex6LPHG+vo/svoJRVRxDCdVhqXEwRn0wHc32NWxTBegSIeXAMY/1d/34GzpPB5+TYJ4zQDskYafrfEKksQXPIlX21UMjUa0vqIoytbZwMo9bDw1kXp8YpvrHBXsBs/ueSuARYUPipztZ4Q8LA0g3Pk0qxdexXNJFL5kggdZw5Xx1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7210.apcprd04.prod.outlook.com (2603:1096:820:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 08:06:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 08:06:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning
 error on failure
Thread-Topic: [PATCH v1] exfat: fix exfat_find_empty_entry() not returning
 error on failure
Thread-Index: AQHbRUQhePgXuMCkxkOuqdd6gcFPTLLVfKsAgAA2cTg=
Date: Wed, 4 Dec 2024 08:06:59 +0000
Message-ID:
 <PUZPR04MB6316BB0EDB3A2E06486CBC7381372@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB63164E8CDD8EF7E1F5638C1F81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd88mcrcLuMsMJ4VfQqod9MFo=fR8863mPv2EBZxzj2HvQ@mail.gmail.com>
In-Reply-To:
 <CAKYAXd88mcrcLuMsMJ4VfQqod9MFo=fR8863mPv2EBZxzj2HvQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7210:EE_
x-ms-office365-filtering-correlation-id: c4ba536d-e2e6-4880-640b-08dd143aa0bd
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vx2mFMdJK+vawSqVk8iEN5QcSuyWVGQWOcXa/sp6Ab+QnEuWmMRW5ZErPI?=
 =?iso-8859-1?Q?KtUJvIdUmiv4WLRO0QTGnvRigTmnGgSU0pqwVG63U8yl/h8kUW8DDBv8HJ?=
 =?iso-8859-1?Q?sCJr9H1ELvwoB8/3iatEd6Q8QIqrhgwNYxW0/qCUDi2Yz1pB/huvzjNx5+?=
 =?iso-8859-1?Q?RrVtN/oiN113dlA9VJ+tb4b/egIrXzew/sR9RC0sIQ7/9xc1/kD9ZQCQ6B?=
 =?iso-8859-1?Q?/opWAF8Evx0znd2zdd6EqFmuKXK/1mBuFqEKfoN00Y2JSndYWrGxFq/u03?=
 =?iso-8859-1?Q?8QpngJ1/oj0NUIr8SH17E1+dB1msdM95XYi3zBULogNIRFMYuZHjk+uBZh?=
 =?iso-8859-1?Q?XfCiaTwGnZz0DwQJLbRzvo8Nc2lySyctsx92xjCA3Jq1Ob507396We7UGB?=
 =?iso-8859-1?Q?0HM3fGev4/4S1OezuPXxpdnOOx6SklCCeZ2Ni4LFBpxHduOc+CSfb0AUgm?=
 =?iso-8859-1?Q?GRK3mJdbL+HLFc9enJ+bVwmoBDZJz9JYv2GTnCpf9LmHGk5tdukBH9Xs+F?=
 =?iso-8859-1?Q?if6WO8X71F+bUrOYR3iQaSsfA21cIG28xVVw2lh7sC39m5pQrMmz81260A?=
 =?iso-8859-1?Q?Q0ZXUpJLzlLvkEXw0w4stlGZqQn04RmprALaBY3OqqBW5FQztnm/CcTeTr?=
 =?iso-8859-1?Q?j0z0rCwd0i7jTgopJyT4jGn40ofPJ634Keb9t7VPK+n1ObD4TVKThlvzBL?=
 =?iso-8859-1?Q?F3NIN3XZtpev8XOTj5Cd7HeFjIyqzhFmcuYA+w26uf4kGBYmveI7AmZ2AC?=
 =?iso-8859-1?Q?Y3yS/x1kcwsWwOGr/QEKXPscBXBmopXkyeBkM3uCkObRgFwSXng0gLw/bp?=
 =?iso-8859-1?Q?+3DF8M8rKnG3dqVQ9k7fpylQ0jf6yc6gCW/skT08ndEonXQodKjbLOpOjr?=
 =?iso-8859-1?Q?OOxpW/RWkEzU6RHWaO7cwj41fiMwMlkgErjk5ernsMX+NCtJ93Tr1Ehcpr?=
 =?iso-8859-1?Q?QGawbJJNI4n5uyv2qC7SS6D1WV++KG92P6BpYMNFLV4TdUnRgewQ0Nz6RF?=
 =?iso-8859-1?Q?4aKC49W5E6oMCWWJIOxKX9ph6sZ4rd616tVL/Dpd3hmV2XHjjXHJGewx3O?=
 =?iso-8859-1?Q?wm/l4OARCP4gt5vSOuRhksywR+/8nIhVLQqp8/eRIK9gQ14KQ95JRecwBL?=
 =?iso-8859-1?Q?mp5ic2pfl4DY5n4dZjIW7Ci4jwdE1y+tV9u+h2hHD0jEC0wB3hX/mUvxCY?=
 =?iso-8859-1?Q?f2QVCGVa4BFU+GGPxXxq0nUOjMYRwL0Qz9JFoMQVMvE6VFU/z7wUMsQXbV?=
 =?iso-8859-1?Q?VxwRuSmejT0Psd5a4BI7y/BLFO23NihBYj2JcY6q6p8kg9OsqERpodz+GX?=
 =?iso-8859-1?Q?I32o7xGw1dqIFcZJ0benvWWrbPkWEzPdYXoumhUx/fccQTWiQ8WlE1DwlO?=
 =?iso-8859-1?Q?Xmt+1uDYxf+KI9BWLa3FJYocwCGqFWK8SJwD+gDjZe5w+uPRPeXPQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?B+KbZKEIB2loml8xQTLtaP5uihy1qYUgJ30782TMHsxM9MSI5IqLqknPk6?=
 =?iso-8859-1?Q?HK8Yx6VQIdTjDn1nBswdb2f8huVdzZf4kjXzdyflI0a+l8WzycOpk92qF/?=
 =?iso-8859-1?Q?Jbo+SwuJLoVoYHiZHT3a/n6GDalSwgkLZ1HvvIKL0tMk0Uz873q0zwMuu5?=
 =?iso-8859-1?Q?AecFLpCC3hHm3F8VKkCkkrG2lrEo//d9tMKDdIKaEflr5R+3beJAlVe+xj?=
 =?iso-8859-1?Q?RQdnQHdY0e1NomD4htvnlSYcRXr+Ad+wyvY/s6MH+0+ZW3p0Hl6/A4+H99?=
 =?iso-8859-1?Q?QGZTkgfKwfHkwSVDnBfRArgZugAqwUyM6BVmKBWgICoOzrHJ7SPPlzLaST?=
 =?iso-8859-1?Q?fV13fEJeUlKEMP2BRKGlmtWqzBBuya274bikCa64y/NJ5ithlU6Bb2i06J?=
 =?iso-8859-1?Q?qrDWEYrDR9ei9BcFzzEq3azLDP/ixPWJBvcMBuXf3ffGb6a07DZyuNOiy2?=
 =?iso-8859-1?Q?bPgFrvwY6v5vGDmwrkk4uXH6HWAjuT6PvOV73V0DqRTIbOYSk43pK2jG5O?=
 =?iso-8859-1?Q?Ygj6r9zJrozYiN90ptZwiiXWyuiTAvr/gcK6Ie6sgYDLkX75EXLZOX1nrP?=
 =?iso-8859-1?Q?ZmEOk/ICmoQblpl7sKF435z0zzYlW44lF2PQNPBXnH/gCSwtueoqhEx61v?=
 =?iso-8859-1?Q?VvIZo4qqcCEo/jhdmQaBi5QZei+E2F4pT+7p0OBZtVVbNc5OOpwvyTWjAi?=
 =?iso-8859-1?Q?o3IGuGWWaE5hU0+iptLdRMX+ppXqy1cYAPYa2jgYAJvmT7xME8RevRHIxe?=
 =?iso-8859-1?Q?Es6jcx88khoMKnXYxP642EFoizRm8gGEfl54Vesrk1z8UyRoAUHMRmjTRm?=
 =?iso-8859-1?Q?y2/tB7F2DN+yQyChPSpt6Go6ba3HO0/COB2tNUnpDdhdlc5XPCRFNqWNgi?=
 =?iso-8859-1?Q?wRIbJpISvVYsNIJZi+eouaPA0xpPmPCuhHCE8dqxPRSLJ1U2ME76JQggzI?=
 =?iso-8859-1?Q?2B/U6gFy8xcxdkGDjL9COrcr2TGHGiE7RX6tYNih68WuL21DBxWC8HijM9?=
 =?iso-8859-1?Q?9+LoWTkwoXWm6TCdhpJcWdwnnqArmvLawbimtms/rUqldWqc+n0esPDvSR?=
 =?iso-8859-1?Q?N3zrFYSrTKC7JMIkpMGVBRGXy0juAf934WsGjrFn7r0uNPXniiD4zUCxeL?=
 =?iso-8859-1?Q?sx1OtF7W7bojBQDBNPqnjXS3RVEqxIo0Wljxljw0w0tyxflJQZKf4Yy7OU?=
 =?iso-8859-1?Q?ST3VkHL4eSYmof3SrRogYPpkvTyoEfzvPnkiTCj3wx6GKZaeQgeyoWbgXl?=
 =?iso-8859-1?Q?HDnfSo5ktYK6JxrtR8MfDTJIIyYx9701QWFVTV8XPJjnuHA00ZGh/sLKfx?=
 =?iso-8859-1?Q?PBUQlX/+jLc3FKM66PWz7LRHGAJd4rXmsjncQynqKY64FljE7ik7Hq1bcc?=
 =?iso-8859-1?Q?1tjfLdK5GhoB+2b9q4p2I4cjlxgjOqnNRET2BfFYZFwajptflvEPsYjXXK?=
 =?iso-8859-1?Q?wHRD3XBK/PVgfJToumy6Qzud/hHU2hxv8Y6txFsyNdOoW+HRKwAFiO6cgG?=
 =?iso-8859-1?Q?1lPbVpKH+O7omStwRt6iIrhBN2gSlPbap1Hz9toULYUvPsRnOF9KjYqG0x?=
 =?iso-8859-1?Q?5Uc9f05Nff/xMs4WrKz8GGGXeA8MLvY0SXYyonidwOYFyE7fYo2BiA1560?=
 =?iso-8859-1?Q?7WuPt+YfJXbKCDuLHWP2iqenVyWrYQYQk/dAQ6Qh6ZGoWc7Wffs7aldUTQ?=
 =?iso-8859-1?Q?qUaOZSO8vqV5esh4gno=3D?=
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
	5krwjoU+Iwc40JLikO9KSdrw8jact7nVYPXTunnBdI65vYwnBLf43f2m4r0AKeK7opi+pAaWs7Rl59BKrBIY/2vp6B6ovwPCzXJNllMNi8UCU42TNa+toBbdzPXldAZmPEuCJTABVH6rE0cJSYID+qr995wP43m+ByO2utfGIBQVMJcZEAZJXtSOpvYST8kAqqUzEhRxb+tXcLdaPtkrsa9vdVpMUxEZ/Ty39SrfCf4ELbC4SzbMPcQYV04qQyVJxXxAOEuYa0UcubVncXn3JXEEySABY+tp6JDVycuLmS2V4LaaEvfDd6Vj9atbNXB+g90n+uaMTCcES6XtzBwAjOo64PpCWlFNZ8AENLIll/aqkYuoTPHYj0Z/wk0ZbYvSpXIqHYA2qSdG8tSA1a6dPviS+DFhMCkK8skCEe/vZXP7izLRzcKjnJhVpNMl7nYZL50Ediuf71qDXLn/MiSGZHW6OoSKuPgrN1W/F7xcFGCU2wrameLcCIlycF+0E2bZpuH/MFzoifwD+fyP64G+8TSqrdBdZPg4UQ7vD0uXWP173GXSqWqHozKi/Jz/cJ0BpS82aPHJT0Scl+1H8TIwTGSdgTbS3RnNI0wF3Xfjwx7KMbSWAID07GnVMeGNc0kn
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ba536d-e2e6-4880-640b-08dd143aa0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 08:06:59.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+ZIi0KUBnWPgpzdOg20QucoWI4MJx73s4ASWY5pUjAl7M+ur7IHhE87iwd8i72XaF3PiHejpqKBB5sSHAIv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7210
X-Proofpoint-GUID: Ifo80h9mh4wDwG9rdl4GkRQyVoE-w_ay
X-Proofpoint-ORIG-GUID: Ifo80h9mh4wDwG9rdl4GkRQyVoE-w_ay
X-Sony-Outbound-GUID: Ifo80h9mh4wDwG9rdl4GkRQyVoE-w_ay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_05,2024-12-03_03,2024-11-22_01

>> Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")=0A=
> This issue caused by this patch ? If yes, Could you elaborate how this=0A=
patch make this issue ?=0A=
=0A=
Yes.=0A=
=0A=
This issue caused by the change in this patch.=0A=
=0A=
-       return dentry;=0A=
+       p_dir->dir =3D exfat_sector_to_cluster(sbi, es->bh[0]->b_blocknr);=
=0A=
+       p_dir->size -=3D dentry / sbi->dentries_per_clu;=0A=
+=0A=
+       return dentry & (sbi->dentries_per_clu - 1);=0A=
 }=0A=
=0A=
'dentry' is -EIO or -ENOMEM when reading directory entries fails.=0A=
=0A=
"dentry & (sbi->dentries_per_clu - 1)" makes the return value a positive va=
lue,=0A=
so that exfat_add_entry() always thinks that the directory entry is read su=
ccessfully.=0A=
=0A=
> I can not reproduce it using C-reproducer. Have you reproduced it ?=0A=
=0A=
This issue occurs when reading directory entries fails(this can be confirme=
d by=0A=
https://syzkaller.appspot.com/text?tag=3DPatch&x=3D1068bd30580000). =0A=
Reproducing it requires a disk with bad blocks, I can not reproduce it too.=

