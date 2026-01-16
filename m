Return-Path: <linux-fsdevel+bounces-74038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C7D2A547
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF4B301EC44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CB2EDD78;
	Fri, 16 Jan 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="JMbUpWjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FE1D54FA;
	Fri, 16 Jan 2026 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531727; cv=fail; b=PQW9C865HEtuquTH70fOLR/BiIOnemfiwNu6r7a+5HeLX3W4CwAVmtGAvyC5Zvyjaw31vWtF/RWxdJitt0vlFpA6by6X5IMMlHktjFmyVE+NA5E4vfwnDADBu5Xkw2R521LTPZICVQ3KkuymQ4u0X4vt5rr2WpAunMCBLqBLYiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531727; c=relaxed/simple;
	bh=LfccPNqCuJzU6S3GATikBUaZqiiTipnyJKb0Z4QfcyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Je1H/sk1VXtjDe6OMWRREjqVfOBV837fhZ8wmLDxL67aW+HfEaci3HefzDldArXm0q6E5klsokbiMrymo91xzW50BwvPNAoWZHiBxBw+y1Lcs8BLdAQOpDO3fylBXGKCHwfhk5b+BTtS1Ea64g+Tm0MZoc/m4eIrDbGxSIH33bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=JMbUpWjD; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60FLUJ3S013683;
	Fri, 16 Jan 2026 02:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=LfccPNq
	CuJzU6S3GATikBUaZqiiTipnyJKb0Z4QfcyM=; b=JMbUpWjDXqLSyL/s6yPcIhr
	zW5HhDwbbaOTc1MuJbhYmJ8Gjd+RfGcpGHlpyzCQzqQv0bayI0jkmLUW/PoWZ70W
	wB3hgLlHbGrVLkSe767Nuoy+QT0DCu2oZCkoAfC0eJ7a0lFsAw3cSBWH5YTwlqc7
	NZ4G3X1LfvEcKHrvSxAIuXEn+25jX+rJ5PCrHLyPNiojNH8N3NTzWV+Y2iAWTmH+
	ULypB6PcIbFp89eUeS31UE+moEA06YYCINxpD2+BvJdScVio2w6k5QC+xMybIDpM
	ebeTXAiCs5loLZnKr0M8/XAFQaPCnyHYecoEHr2W0emcLvxp1TZyAhK0lTAGM5w=
	=
Received: from seypr02cu001.outbound.protection.outlook.com (mail-koreacentralazon11013001.outbound.protection.outlook.com [40.107.44.1])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bkvsh6j0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 02:47:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du+6lw+93vYN7y7KLPlUMvAI4QsGuOyMU06EsCEnpVtqXkdykkvjUVLak3PwcfaROGndsWMpCHhjXhioWm4gjmoHKHYlyaB4a5P2p7SuRiqLLnxYP6feMx+G6pIH5a+pMpAHuCnNNEThaf2OgKgqt+RJrY0OtlQKfsZd+k0Xfovv8RyUwEnLJmUJQWkSNVSKkqrTGj5jK6wNRyzphq2zJ/8S6ntG02gJ11S4LY8rcdHL4VrN2PBFmGK1GGpmm5t9pL60zb0FD5jmvm6qQpFokcLKlHQBuw5GG6RnGpndeskv3jN1GV0HosC/H/rVgtFOLdDng+mhk8DHCEzZI8yBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfccPNqCuJzU6S3GATikBUaZqiiTipnyJKb0Z4QfcyM=;
 b=eCWUpjqHBGAKEKW3lb0bmf2IbzPXlbduUtEv0d7MO5cTIwYCdDeKPLRtZLzdJdPKEI7Q8PTpRRXOkWhEmqDEH0qliKAeCB2RvM5VY3E7ulqgewujTYQAXuiEfs0NK+CnWrruAINkD8Ac8OBv0Ol+SQvhUv/ZJ4qLklotbykCXHSmQ+s5oRxAT1tghGWiLZHVQAqzMqPGEeVP7uFqNcB/nGKfUZW7xfT8Hg018xu9q8qWH2qHYmytxe2J7J7EEqDF8FCCCx6564nj/4m65lNzAEicZIQ1SzaBSUvxNzQPbOFUvvT47US+hJ7svBgSbIwXucBRydTtylYIyzw8vu8Sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7963.apcprd04.prod.outlook.com (2603:1096:990:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 02:46:57 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 02:46:57 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>,
        Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v3 00/13] Enable multi-cluster fetching for
 exfat_get_block.
Thread-Topic: [PATCH v3 00/13] Enable multi-cluster fetching for
 exfat_get_block.
Thread-Index: AQHchU87h/L+Jy9A1U+4v/SYg+iEirVUGXbt
Date: Fri, 16 Jan 2026 02:46:57 +0000
Message-ID:
 <PUZPR04MB631672ED193FCDD8675AEC29818DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260114121250.615064-1-chizhiling@163.com>
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7963:EE_
x-ms-office365-filtering-correlation-id: 3be294ff-2799-4867-628a-08de54a983e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VmRQhv7gEAEkoMp7yOtC6zF9MCzjM+G802ZclaAXf5SAhesYIF7NiK7mvs?=
 =?iso-8859-1?Q?mpNZcx30GZw+08jd19Fu23ZWL8qG4cegbLolC/RrDCq9Z5GTC81QuJAJH2?=
 =?iso-8859-1?Q?/40EGqSmcs3TIve/lHDMz2VEIKqn4kKID1ZbtsZFvyQZFTA79mIrQeobwu?=
 =?iso-8859-1?Q?4hNEXB2tAnkWfJKZTc9kNTgae84j91bxYwWnQ0faMg87paA+KWv/OTcIdu?=
 =?iso-8859-1?Q?aNJQYR64Vx/YLUmeG/DVZikuiz3JADj7XQOBses4pZQG4uB3Oa9u1XObq2?=
 =?iso-8859-1?Q?G6wt9P2OPtLFxkyI2HuEAGxkXIV4j3B/DUVugMfglaMMpwgjC+nQ3QoKcE?=
 =?iso-8859-1?Q?XhppyuI4WZXBRY06pNHyDqkiMY4L+pAgGoqhBIj+KXMQI7QjPDg0e+zgMA?=
 =?iso-8859-1?Q?4fgj1deLiRUmDA7J128AlGL74VE6Oh9RZnDQHwuyltQs1TXv2t/K8PSoeC?=
 =?iso-8859-1?Q?mMJLEWgWHLt2/yZ75F6wLCVz4n9Tmqf5vIk50lTn9ZvTh/5NGJKU9qUFV9?=
 =?iso-8859-1?Q?aRbWKLEmalSQwEih0PcIBjLLreVGkWaMkW4RE1Sc8gjnir+q8lx0WyqDmk?=
 =?iso-8859-1?Q?aFNIVAuS8nPk9uC7mINwJmVAMYJ/YiiplBTChWLNULIuXN1noRFCw1a7S1?=
 =?iso-8859-1?Q?c2DrQxB4jnrpwbtGA/eU5QhD1wNwwBLzVr2Hel6TIH2Gt9DJ/dl2YcZE6M?=
 =?iso-8859-1?Q?0AKGDKPehKY+/zqH4sfzUnulwDmKOt35EMUQ6wJOBuZe9ZEwda6qShrvKr?=
 =?iso-8859-1?Q?1gw7EHd5Zrn1h+Kw9OrAXgbslkA86qgRdoESiQSwMXbLb/EqsLDPNjDKfi?=
 =?iso-8859-1?Q?GVg9KowYkTPmGMaHwNpBEChtZHgL6hpGRbNSzghSk0w0UUEcKgbkDkCi/0?=
 =?iso-8859-1?Q?cOwlvVk0djXSI8+q+5zFn37lz16oTEEi2UaOCSDI9Ws7IxI7ZJmXmH+8kp?=
 =?iso-8859-1?Q?tgiPlh3do5Vt0i0dUuYK7Mp6yrX2GURUn5Y7Ce03dB9MTR8JWxsFlfj2fj?=
 =?iso-8859-1?Q?mnJz6eIOZ+IzNa/Ew+NSvsRFwX0OVqBEb0FLyaq0tg0bbJSuyX+iidsM3E?=
 =?iso-8859-1?Q?z57TZzDkTT0OO0tNKbgnpSwuyGZxfYZeybbI1raruFkP3ZS4JS2DXvMBOM?=
 =?iso-8859-1?Q?z5QNCO5UUYdxq/aaSQqGspMIxIJiz6rDFfrSzop4IqnkJkdSqA5zJsl1+x?=
 =?iso-8859-1?Q?eySZE8mpD089lLjaOv3bHMDSON3rtpSLtWZGYXZfyVjRKARtbK8HHFmUUS?=
 =?iso-8859-1?Q?tA+Rjqww2cjgLxLOcS9PySyXmNGtLlJfIdqs7+3uq0t21SIconbMhS2IdW?=
 =?iso-8859-1?Q?O50M7CC+WCl6zHqCskbx35g5ZdEFMWzbwnH3/T8kQ0yg7cW6brJ/AF4NWu?=
 =?iso-8859-1?Q?7SwwsYvt28mgVJwbuVgJQ3t/ZLMYWnShwm59sTJEnf/NHTWSJWppFFI7Yz?=
 =?iso-8859-1?Q?+dDJ3jhz1/vB0/iaTgWZmC5T2sp02T+vsepo15+kWy0opfqFchwHKYcb0F?=
 =?iso-8859-1?Q?Lm7N0zYcDSHZebSnYUVoI8yNC0ynB11UkPg+a6VPGOQt5qH7zRvw9idHMD?=
 =?iso-8859-1?Q?MuVrBDyjspfGOGxhLFbIWvA5WDusMIV7C+5QzPiSViX2ZxbF2jymB0iUfS?=
 =?iso-8859-1?Q?blJQkjGpsNKQM3ESf7BtR+1oAq3iVUt9+/cfPpHssQlKdy2mFFv28g2yEm?=
 =?iso-8859-1?Q?4lvA0C7wDPCu448H4/I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ottEi8UqEpXNvq/17g7NBrIyAgDAM4kC3539Y69De7lJtbG71kaENsIZ8z?=
 =?iso-8859-1?Q?kvv+HSc2GnMJt/9lOoryRETxSm4ymLxSJd3ivjWkPB3E4lyjTIjCKbv4J6?=
 =?iso-8859-1?Q?igrpRVldcEYCupC6Aowv2YkBM4JXckFUSsBzfJp1Zt34ocy43ju9FjdfW/?=
 =?iso-8859-1?Q?dBaRh5DQDtyqtzIWko4n98Lco3UuMhAbHuxoie9x+4r+ihee6o1tMnDbRj?=
 =?iso-8859-1?Q?d57C+bPOWLDRPi2Jb86Iewy8zgDUF4hpECnUa7EhvrXkHK0EUxt4sLCv0D?=
 =?iso-8859-1?Q?7dUpZY/qmUOUU4hmOWu2PGaDZcY5BRwAp4d/zxV03uoOA33dovjZlQH7oh?=
 =?iso-8859-1?Q?YTQ74V73fpJb3slFb9fnOAG6lZEq1G7+iD28rYYw8VY8Be/IcTAV6DFkH8?=
 =?iso-8859-1?Q?NzdeKGUFTAZQdiVWplgGf13dLMRcS41eTjEZdn1QyKpA3EexK2insecsxG?=
 =?iso-8859-1?Q?1w52H4rir/QiOnBviTBlzzVdvEb188YPzBoY4ZNkXVqzejxyPvpdZ/6jq1?=
 =?iso-8859-1?Q?LMLA+4oHrojE1GWtFd+4Q1dmTTNBTH+KUrt8P8zU6IQ0jD3+KIIJPXq6Ku?=
 =?iso-8859-1?Q?xKsdJ4RdkcDgRyWoFam9NgIN3i+/q0ZIC9vMG5LInNM82JU1AS6V1g6k+H?=
 =?iso-8859-1?Q?ma1J1rG5NZBrn8CGpBuqeG5OyEdN4wT7CLUj2nLzLd0tgAg2OjyrabvKd2?=
 =?iso-8859-1?Q?AgiYvDMdecRl96fDdQZjZW5+Pora2p+/C3bZQl0/AX55cu5NujSG/kIWLb?=
 =?iso-8859-1?Q?63y9cy/ClldphcQpMtHE4T7Ypqb7qq+AzlVLfAsxAZC53lrI2UptP4jQrQ?=
 =?iso-8859-1?Q?3clOoY/UiFkIfzZiEzLakoFh76ZhW9ULT+71BGcBCUETmRKwRGVVU3eMDZ?=
 =?iso-8859-1?Q?1n1soVQUxBZVKDL9vtq/mifoFP04gYhyS2cF646sqsJpw/Lvp9iD3iqWQK?=
 =?iso-8859-1?Q?kUwGn1kYYjOBbdPjWoDKk2o66ozqYlK2qt9Sw1rGXw9IFfTlI5vgCPDg4d?=
 =?iso-8859-1?Q?N/Ek0KLVC2ooXghOUraS7iF38/K7QxRZ2sciCYCY8w2IfZizelVCKM/Sp7?=
 =?iso-8859-1?Q?NwbIm6tC5DoMUtgdg9I//dVsTopxLNlboRKHx8T8fvkYsFtRpz+M8eBJI8?=
 =?iso-8859-1?Q?1sxEyinmWE6LtMZc58yJSupHyUQG388poJi2ujbmgBbxhvmUHuixDTnIQv?=
 =?iso-8859-1?Q?xsZJc4tBvRZSPZYB3McboCGHX6iUOWLZlL4qvO5oAOScbuNVVnTekDDjn4?=
 =?iso-8859-1?Q?vJXwvYwL1TDYglXZfTcM46yUT4DOEA1uE0gal7XK70zcz1LdrT9FzYkMX1?=
 =?iso-8859-1?Q?vTMS7G5VCOSvCDO0Xlvq8+aPRMa/tEZLGzKa5ZLrKUHTyceM2IZLFYqbJb?=
 =?iso-8859-1?Q?fKroD38OK1Cmo78xFkhVGX8q/IGJRVjoJajph0krCNZ6oVOqBSkwnVtXnr?=
 =?iso-8859-1?Q?lGHzjGyzsnFP2/USP51pHdAdS9YOvL/NJ8EDc0kgT6nxKmFqbOs6PDeCFp?=
 =?iso-8859-1?Q?NYgdCUt4rDXg3dMHeKGbwsEcoD6AfZVbGBg4w3ADPFgyUzPnq1gfOZCzfe?=
 =?iso-8859-1?Q?XCusa6rEuY3JMQ/33HIvz6erOzKkZlqftAC5AI9hUcbVf9CtBXY0/3r/mL?=
 =?iso-8859-1?Q?3PYlF9FCCeqwj/4ubHuYj9BOD6lws4VFPGXpqC9OYoVx+F9OK1+Rn+4H5n?=
 =?iso-8859-1?Q?34Mhr3kuIOdKqnRat57AbtdcnH9D5k39IVhbs75XsrVsVQg7sMWGhIlwEa?=
 =?iso-8859-1?Q?3nZQuOYgAwi0ttW3BElEjKHeCoSV1Nn0ljF9y6wrCMpXfaQcRkBi3JjNpr?=
 =?iso-8859-1?Q?hW8io6xfCw=3D=3D?=
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
	xuwwAb3dcXRTH6eomeMxTmj29A7fzr7Rj9zxuo5aUMZ8tT+HYV1/kvvTKf4Fnjo50rxDe2hs0mkmnoo5DxDAauu57m9rDLOW47yykU7AcVhgVhOGNW3I5gw+RdF/9WDu1ihuOfWSwhmfEvzJuhcV6tCXtlterTrurxvkGX9lAvEqJ1d3zR3HT/S8R4YrQgjSRBq65qJI2wRLYbpIkhoVVrBH0vGrbDybX4bjsuLYXz0JNZIFbpjnCxEe72l8J/zXz+U6EvI0T8miyi0EMis2vPY8xM4AowoVkPe5e25rSgx74EZWThrnTNFzmboQh3io+v4yQkRCDCqAEePUycWW+a7tjdStmcXJ29izkcD83TPmonnugGcEC8YObkDnIJte19eKMl55joDi7y/CczDUHTscLpOgbzXZ6z5zGsXQWWUfl28jrZq/TRBW0EgwfDjxi92IVcv0eE1BFU5fUVITMlIARF+yZL0T43mXdLLv1iKY3xadj0jcveZn4TxnFyDVsNC70KBLgIeOoazsNpL2s0uDm5qh3lufyIchu64hAAR0fSKVhPvijVD3lisu2DvenlYfZCpEEcx+1jMQhHguskcMnoyiiKKSYuAVCjgYf+wcWUL5JCE/kqu+pCc0UqyD
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be294ff-2799-4867-628a-08de54a983e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 02:46:57.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRHpqv7lyXkPUMlRFRXh9Tnm87JdjOmUUf5FBHQUdYZeGhRCOPc9sPSaB5p32rnyeElGKGkHnyLWi8jtCuoSsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7963
X-Authority-Analysis: v=2.4 cv=BdDVE7t2 c=1 sm=1 tr=0 ts=6969a6a6 cx=c_pps a=HTpkYgdmRHmM3zEy0r+iTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=TSVp5swo6LpNLtneyT4A:9 a=wPNLvfGTeEIA:10 a=hjbc2OpvlusA:10
X-Proofpoint-GUID: _-bkTZTNlaQoCmmykp7kXSh4tFkiIs0N
X-Proofpoint-ORIG-GUID: _-bkTZTNlaQoCmmykp7kXSh4tFkiIs0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAyMiBTYWx0ZWRfX59ioSb6nOq/H WQ0uLhZs9ZS7XxFCRbxca7z38uPfHgKnLocIcfsc7Zt6nnUTgeQ6lE3kqhPauHpCRrwkDMpkfgO +xmvEM1D/0ItIrF/4ug7Cv8ZeFgkdvwsHI00MGBVRNb7jfX7r/2e13ClMXgsMT7btygd/cN+rn2
 kCANqZxSlMcozvj8R3vrKahxi4xU8N5u05S9r+HDbNg4OYX+Tqo9trIvyUrUEj+sbB17vfTQvrY SEx7R+nTQx0qFXHQ5d0m7ZHm+qQJwcQ0SrMZJEBjCeB+rYt3bX5L6I/BoY8YJ4jZtsN1WR+1daK A1vWNiqpnkefEv3PFE4xUxP51kqKi3wyTu8IfaheB/dTqLpFuZRuiF41zzkR8XC9pzpnOtU8phb
 4CCdVnqyN6OcRvhoZWCQfeXsJmKtBjKU0WMpf/g/3Sf1RdVBPMuPVlmncfYJMMP6q0jVefI4wjJ tshPmSrue+REJNv3drQ==
X-Sony-Outbound-GUID: _-bkTZTNlaQoCmmykp7kXSh4tFkiIs0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01

> Changes in v3:=0A=
> - fix overflow in exfat_get_block, only patch 10 and 13 changed=0A=
> - add review tag for all patches except patch 10 and 13=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

