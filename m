Return-Path: <linux-fsdevel+bounces-17610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2488B036C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB83BB26320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380A01581E4;
	Wed, 24 Apr 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="DEIWZAoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F19157E79
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944711; cv=fail; b=ly5jQb1orxip7IaMmmc5D/91IzoSV9R8DXxVl+a1lY28j5+J/H0UXJqwDgfeIz7u6Qu+rdkFndUKUntwqd2rqegzVIwsbiG1+Sh/lkv4tAw7sq8cn1OXkPtDUO68ArY58K53WmvzjLxQoCQEndRHfVACNLXHervJymoQX0Qb3Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944711; c=relaxed/simple;
	bh=FVcQ5cMLi6O1+N9d/Nqt1wR60cV4Qc4EJjKCXXivSnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FRipMA/KBp8t6ls71JuGHMUjp1MdyGlQyQtfgT3iFHmxk8jqo89/WPO5ZuALe0V+QuhopeLtDUN0DBrjjQGcX7MCBWJG0fN1Ilp1QVZzebZmdhQFAw2aJt9dWvcKvULSAlErsRzf85V1FctbAydQTqPClXqDqcGhS22qcmdhwb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=DEIWZAoA; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O4AOlm016847;
	Wed, 24 Apr 2024 07:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=FVcQ5cMLi6O1+N9d/Nqt1wR60cV4Qc4EJjKCXXivSnU=;
 b=DEIWZAoA5tVtPY28dnpJb0G5ceLIt4DrWdc/WTvluHqwy65LX6/ZxNVdkzAjIgOSmyxL
 Y1K6dxVedL8FrwSoheqcVCD1LFoa50uWG+8ybrfrqG6I/EQiWdlmZyVNSgk0+dbdE261
 tGFO4UwoxP3LbOf++glGbRTzOyzHKeqkoz92eG69fdaUqQ49DErF0K6RjvaVwpAXcKjJ
 8gsDKPPz45qttXPV+TD5BgybiyoEI3ErUJvDop34srduriwetd5Atu0IqOQF8aqbDaT7
 P1sCY6vWcCWuT9Bpg6H5j6/thF5PGYgY7dKiJNxcr+c8UCL/ZfRiQ2njcu4ivCv6Tsdj fQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xm496kxhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 07:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEJEcVuTPjWWHhkfzVwl6Qoo1nZ7mkhl+DJn/jYGv/YTh2mwLIE1iTFDDYfk+5TuSbSDyVg0dB5CoIZ1fTb7CgIe6wpALawi/kBTTk7Xefvn/CGBrj6lpgw3u1uHHT7FlUVXK0HC4UsCjJ2US5QlTSFs6W42bIsNY19qmcRsMVMXgF6nTutJZanPWOrnaZ+YX/QD8J6+6MzNnUKxcajDm/k+emMCHOBcc6QQuzcUTbRhC8A58+Ahc0nj1t6rTqW+qO+ca/D73y5oRtgaHMRXi3mrnVbcGHTFs2o0bO+IGTYD2JCZvRrH8qwbMMNHCu2JxZEKNYY/6vNbxkYa5NJWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVcQ5cMLi6O1+N9d/Nqt1wR60cV4Qc4EJjKCXXivSnU=;
 b=m5AVjZXhtuQwlNe/pDIStNf9zGKuAsghCbm7i6TF1zKqsYCzARwMraO2t+757Vm/Tl/7EsnxueJYnjZ8Rp4b/EPwDCV9zshHevmHyIarLaHwvUijrZMsjd8DmYcmUAcS0N6ufwnrlhDqZ7kRtEXV17E3DtefWRvWRUbIw4dQHLBT+oQMN2HMVDQc/DFwZncZ2Z5GvvfpfTKxRmc9DxpEYOdzDDpHvOhq1/TAH+NEjmMX2SZmqkLGBDpuqfFmfxDfVAxBJBoggFyIiz+S0YhczU5JUxBeZSjl4zkUt8NxqVFLp9RNHM0RhpowCKoeG58bJVPWkO3YE+34+XJ+0SyelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6868.apcprd04.prod.outlook.com (2603:1096:301:116::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 07:44:39 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%2]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:44:38 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Topic: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Index: AQHalSVihLmFn4H720eTr8GfTnzOoLF2snYAgABEMu4=
Date: Wed, 24 Apr 2024 07:44:38 +0000
Message-ID: 
 <PUZPR04MB6316B43EC39999D94F8F011E81102@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20240423022908epcas1p2e3f94bde4decfd8dca233031f0177f58@epcas1p2.samsung.com>
	<PUZPR04MB63168EFB1C670A913C42E80981112@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1891546521.01713933302009.JavaMail.epsvc@epcpadp3>
In-Reply-To: <1891546521.01713933302009.JavaMail.epsvc@epcpadp3>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6868:EE_
x-ms-office365-filtering-correlation-id: 1b548971-57ee-4ee2-1285-08dc6432653c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?rhnWGFgS17wEBfMcDKXKWfXJi1JvLdv9SYb9fUoelUkOwhU+upkDtuAji8?=
 =?iso-8859-1?Q?alMjHSFNk43WrSCra8apvBsDRaIsJNtvymmDMU9QTsTrxVCw2hzLQTfhZw?=
 =?iso-8859-1?Q?46VzFtjEoauTMmUnkkATgTQYFWksJzgOS2PgQz4vsBtX9zBmqshNaUDlmZ?=
 =?iso-8859-1?Q?CJ9i8/LjDQjt2WRbTvNHGs0cH6vMkgbOgrWX9EtK0bootl94BSxPxokAeD?=
 =?iso-8859-1?Q?T4U8LmzX+bSC2zqlEBnhrPfbfrIDYnnA8wswgd8gcBa1tKonNLMsFxAbbs?=
 =?iso-8859-1?Q?DWewwxPM4DlfajSBUFzPDgVCP1Gt1ucFZwZXuM6WJRPDxeDwBlG77TjwQk?=
 =?iso-8859-1?Q?ssFpU1TJFayFZdlxs2J+P/HF6Kv6nw14XchRgscsUhwpNd4pE0qtc09ssJ?=
 =?iso-8859-1?Q?iBCDmj206d/0X1QdTApJGoRwxEIVqsMWJ0hBSYnMSnKWkgcjufH3+KBQKX?=
 =?iso-8859-1?Q?eu1gbj8PAWontJQVYam2PZYp+kyIiR69LxOvOyJeHR4bqwQQdC5nVIdddh?=
 =?iso-8859-1?Q?A87z5daoCqch4U2L9ONFif/7a0HNIKjZNHsFgehK3GWqkMpzTl4JvQ8x5W?=
 =?iso-8859-1?Q?aZJ3BRg414BFIYFf+NHMua0ERAhu2/24wp1j8/dYiQxkb1LjsuZ0+7smQk?=
 =?iso-8859-1?Q?0eNJclk7q0cRqqH0FOYxCCwxXWyybdlSb8FengUuxCsGK0hsT/amKsabeh?=
 =?iso-8859-1?Q?FsCJ7DWPrUG3AJuAQhqup3EA1J/pqFvzneyjPr2hl6+xaadWSCfR4m44iI?=
 =?iso-8859-1?Q?sC/h/pKyKHZBe3TGKY9AsYe8XquqV6WxyXZvUxdqRXGZOtjY6xRQkJc/qB?=
 =?iso-8859-1?Q?Y7hJo3KKMz8z5gc6o1+tOp5qOc88GGB3bbBiLK3AVfCcWoZKKsXwhw52IW?=
 =?iso-8859-1?Q?E4JoinXZdCgwpwGnQPP0GRgHylTHPCvNXppIWESVkBhz71oWeiu6Dw+/2d?=
 =?iso-8859-1?Q?awHe+it6rTSapb1yaubcq1R66wDwh50FQYJQmW7y1Xt5JiJKiK0X+xB+DI?=
 =?iso-8859-1?Q?5S0XQPUz5beDr4u5tyksyb1USH8TWjrTp3/rSXc6gT0P6wWPXVMuceCekU?=
 =?iso-8859-1?Q?oGEoXdI01kdN9ELZC4kUr7i9mXgoZ9UXOGmT1BzzsTcuq6qndagHev4+mM?=
 =?iso-8859-1?Q?teddvLo+ko0AneQ7WCgQyF3e2MeRs4YyOQ7Zv/qeINEUbfe5iUZ0lQL3i0?=
 =?iso-8859-1?Q?M4hI2OqsTARoUY/IwCw8I8/v2bldwESyQi25Av9Vy9VERMir/wn5t2KOn4?=
 =?iso-8859-1?Q?zAcV67RACnrVvP10PjgSRcaE/ta7wesiOmJhIGcB+S0NH/wg3UUPcQb4yc?=
 =?iso-8859-1?Q?O68UHiFNwEJW7XyCdsrMF0WYI9YJmw4xX4zzl1HE2dQ20MCxKbdbo3Dzam?=
 =?iso-8859-1?Q?utKL/6Vwzj5fYYi7wAmNZ5pqqNhmwB9w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?HSuzcPqsIyKe+ptuMD+BQHZc6KfOVD+WQdDFcmLU4rT0tLFGY7n85nJP72?=
 =?iso-8859-1?Q?clbIAk6MJB+MscCM/yMEz3GVxA/az0rfPjf5Lk+Duc8LBJUN6Flkiqrc4/?=
 =?iso-8859-1?Q?a6SuoUbVKgIrXAyCfOpniyDJqzj5NeefdIxS5EwZEWNXG+tiJwAWitSobX?=
 =?iso-8859-1?Q?5+CVwv3BEV1+a6+isakuaym0j1wUBvtaSMjayixP2kxyVZwTZauGdhX8SI?=
 =?iso-8859-1?Q?qZR9YvsO8vVZa2TJ7ddXcOOuIWuaQSQxQ5/khxvaNsyc8nbeB/g3fHeecK?=
 =?iso-8859-1?Q?GluAFmE2Vv2xOo/mEPihMSB5kk9ZiilVtTodKS3dI2cSDUbpYFTkrODP5N?=
 =?iso-8859-1?Q?I1TFfHbi5N4PMylQoJln4T8kvGM4xVfKtb2IkacgwWJ/ypu20/IhqUT+oU?=
 =?iso-8859-1?Q?nHubkYKjW1XV4vJHzDunc6TxZXrFXyuuXifl7RdK6TweQNT5KZk6YDaBTz?=
 =?iso-8859-1?Q?dyrEuh/OIJBX7fN/cY8lCZ5m0HZIKBXlY6pSG0CnWKv9vmm1pzWpo9cT2g?=
 =?iso-8859-1?Q?dpW5YcWj+zEMKVfbYjTltFVYFotxjxa3eGTnm7zrufEdyXaGfDd3pOp3Cs?=
 =?iso-8859-1?Q?O5WjGZaCFvo56Mmw6cBD2tHCxN2M6TybhBOQQkz7/o3qjuDXAnaLbKXfvS?=
 =?iso-8859-1?Q?qBhGRDSqlg358e1QIwrl5yTFZZs/CYgC/OuHucB7BDDxr9OTnxKXhso5i/?=
 =?iso-8859-1?Q?eMXjOe1uqcctYHA7UWJi1vPEdfRl8w1Rj1tFg2Jb7DIa7HOeUGAbUgk46q?=
 =?iso-8859-1?Q?jIqogqR64+cjQYdwhulRr/EW3irwzmRXvjXolrimjzikvwUHbIbcEbEUfM?=
 =?iso-8859-1?Q?1jsQKRs0JgbbPFizybi7uBVrMIqJCB1+APfUKEbylH1e6hCshw86y3TJ2o?=
 =?iso-8859-1?Q?JSXf3PWJJjFiKGlgJWx74u2Xg49748P6KKGeJYqZMoRBOevuXPLV3NZDqB?=
 =?iso-8859-1?Q?Of0PJVhXrBE9Oje2cFzHy+KPEOQdHQrzPDJqObp+zm1oreTB1nf5NDz3Wo?=
 =?iso-8859-1?Q?0QCc/eW9eXEymy7GveOr4CNfI+pUUVFrCdVFjV0JW3RFuaaj7bsZ0vOAq+?=
 =?iso-8859-1?Q?rY3ooWU3UeZcEV4xc7sOmIslfkLfAg5EB5TTG05TM6zYLwLvtDH2+PdNQF?=
 =?iso-8859-1?Q?5TjrtWcahkkKaNgDMrKp8S6uVQ4ZBLtnodhEXfmO2/GKL2bb8lpZKohoHx?=
 =?iso-8859-1?Q?CZj++vafr4OiWiBc6vMMQqZuv0hge5i7Piroobqt/NeJYmJu6pkC+L9B62?=
 =?iso-8859-1?Q?0wVzgaYHdPLbQNH3zGGdVVbEyLn47G4M/+AnXHO/c5il40qK+F+unZFP5b?=
 =?iso-8859-1?Q?J7PgrcjTUZ/RspCLBbs1R+W8CNcyQ6fjOVQVmBCcyrF/JSD01vxEcTsfS1?=
 =?iso-8859-1?Q?5MmIMwdrXD9W8YJuxqhKoe1bxMvKYYe7rtANeu8UH5DmyiuJgjmsUX3PeG?=
 =?iso-8859-1?Q?MzKMSWtGLgCtzhekvCv79j0zgWYhqC6p0ascSO/Tc+pqE5MRHSFvOu05b3?=
 =?iso-8859-1?Q?0mUYUJYpBUsOOj5pX/b0unnuvuibS/5m7Ro9mTrN5TepjE3iLFsRr67El+?=
 =?iso-8859-1?Q?sQfjOXpgOYvrODva23HaEWTeTkaH9kEg1MSTIhQeMVBaqVhrs7Tz3yUEjD?=
 =?iso-8859-1?Q?b6qorsyDfH7J/eCjDEtnA1+DI3XpGdkb6rK1WraKyMtP5WvEB3CsSlQOp8?=
 =?iso-8859-1?Q?osCa61RFS7QbHdy2z5A=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xTwF24HdL2d6MK1JKuzcgye1CxpuyoG4+qiW1M5HwoR8986rzu+J3YfqJUur6BF7+cHfjunQa042jcxpYXgb+im6nUt4VRAe+AKIGCgvoaHNvRkiDBJa6mXTx5eGbIs1tORVZpjwlEZeJfeqgWlSu2Q3imSqKQUOsDoJRpnkWjALtf4iKlgg+UsZlK7PBkWHkcihSHAtZtvdCx1CNiff4nd8ry/C4t8zg69MmKTgcDNHWT/mjfUot1qhCj9TOl7TTyaB4k6BatYvz83XnNyOPiRUdyIU74f08C2ZaHZMBOVKFsxhadIVE3c7ErY4MigCpUdzlXlh61m/VzysY8CX36qAMzApHY65pcR4btD2097oK2wmaZ9+7+GLT3k3xPRIgF6O2nrKXpOBgbIgkKH2RGuxsrFXHxEDMcpBS3jLYth5ZIPDIcXHRXf9QSmgMvcDhe0c0pgcFdclIguDHV3IgTBUNUePe2Rs4RYw1afxYAAjW7qi2YSPQkAqtNL7FPYX8v4UkC8nXh6IvBP7oRXbc+nFPFhPuhUiPoH/ckpzwQOB6hb2wyzL0xpLUHeGfVl+4oh8v8r7+8bKbn8eqfQavcEmVVUCSg8W7Gd4T4V8T7CqyavtFlPYoQmf8yMuVXSv
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b548971-57ee-4ee2-1285-08dc6432653c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 07:44:38.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcPDTf96UiFl/yuUyNEpAxQPG1x7+mO6KQETUV3ahI7PMeJtcaAB7Gkvejuh+0VufiOjPt5Y4ZR+V/N3GTrufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6868
X-Proofpoint-ORIG-GUID: NzopdVUtdtxaB9Yr-zpAnu5tY2Mj3gsw
X-Proofpoint-GUID: NzopdVUtdtxaB9Yr-zpAnu5tY2Mj3gsw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: NzopdVUtdtxaB9Yr-zpAnu5tY2Mj3gsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_05,2024-04-23_02,2023-05-22_02

> BTW, what about initializing the entire ep (fixed size of 32 bytes)=0A=
> to 0 before setting the value of ep in each init function? This is the=0A=
> simplest way to ensure that all other values are zero except for the=0A=
> intentionally set value.=0A=
=0A=
Yes, initializing the entire directory entry to 0 is simplest way.=0A=
But 48 more bytes are set to 0 (the total size of the reserved fields is=0A=
16 bytes).=0A=
=0A=
I think both ways are acceptable. If you think initializing the entire ep t=
o=0A=
0 is better, I'll update this patch.=

