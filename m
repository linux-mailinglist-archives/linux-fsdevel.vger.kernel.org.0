Return-Path: <linux-fsdevel+bounces-65048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD9BFA01B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A243B1100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9882D9481;
	Wed, 22 Oct 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Y+/Q1io/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDF1F099C;
	Wed, 22 Oct 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108948; cv=fail; b=M2gFgmiyvaantv7X5EuQVNvatIpLIX9NeT9XjFLqN/EbabeP1PKA0T4j1emutvUEPPHN9kfD/cNlQ5+X67n1vpTLQirIR/zwO6Sc17pilNHtoEpffy2PPrQbjl3sPBQswSQTGUpNQ75/JDFajjCrNpBZZyNsRENNufARmpWgoo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108948; c=relaxed/simple;
	bh=RYDSQPQQPP3qRwzayVims8HW6ZqtnAwCGRLV1XEN1ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVMZ1UqAaTbRztPyiRvulfNLjWLQAMRmRWLpKh8E23r91vU4HS6VTDXK1t/v4mPgdPuUpPz+Y+Ih9X/pN2QoAYZC9MGKsyzgvTV2Kvwak+fizyiwdFHMVhIFq5+tUeyOnXT50O4Mpw8PEzbUFxMLhZBufE2q0zT4Q0Dwwn/zVco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Y+/Q1io/; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2v4rq023829;
	Wed, 22 Oct 2025 04:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=3q6ujlu
	WsVHdcGMHGLs2WbxC3ACWn0CICP5knu87Zgk=; b=Y+/Q1io/fKsMWTvL+mEwvTp
	FP1bZCky2xrA30htbcjQtfzn7cLuLOwarrLcruPouOUGBBNXf2W4um5DyBLNi83L
	s9+3sdnqlRdY08Kqy/G5Z6CvSMOFV2bcM4i59hs4xziWFJJA1Ci2+WnjHm/zgb/a
	xd1Ntz1ERgP1kvfNKHY5TVMj4Yudy7uDde70YQ5yHdCg73obobnz7yBdVimshVJd
	J1GItrh84aTF05VaQjy95FL8ePyko4r1iTw89X6jvHUREsoUJA3JtLrGrpl3ldpT
	Hk0atcA/43VjPvd2Ki2BS4FW3mKQz8zx9/4TQlXiGNvU9H3E5lD45SSl3VQ0xtg=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013034.outbound.protection.outlook.com [52.101.127.34])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 49v1s0cj3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 04:55:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rP/atQz/EC8V2RdH2PEhPUB+DEIXCmGMClhozLaO2jOHiMoukqBG2SG1DP2hFlnlTzETBNmMptZAXMOoFcipBylOJqiWNqDGp5tjS37CldGhDbMWOSZn7PxRz8YcpB1JjBoVdr70/tOJfITTgPyekQsAnvDSpU9L0r+rxarDmkR8k0D/BhmHqDK5ZfkoXEUOndq5wOLxfGIGlj2CH4PzVNSwZ8z+QC93QrfroeIQuI1wuHDITzrJ17kyB0ByxypUN7iDEd9AUhiuEoQhESdmC7+t3SM6YQfnGggL5lELs7x5TW4zGc6/G6knlYkPwj32u/0+EexlD5u5scq6/y3xBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q6ujluWsVHdcGMHGLs2WbxC3ACWn0CICP5knu87Zgk=;
 b=Lxzfv/kskx0QO/rO7ECAlrrpPPyLJheHHvf7XiY7CAOF33S7pvlJpuDfh6wO1wyE96i50SHdA8MBgjVxnm8gzwV7loo1uPtft9onNpV+T9p82YRDJ/QnjHLmYEbqHhrD1YJmQvo4eywcJ1J4o8sBXOpDr5o80OIzKJCFFffXxDKN9FtDvSB5hEP+u7YXMWCMyHbKOau5AYzQI5wmfxIivCItpkc2Jqx4GQDnKH3UT5lfOT1ktCkCN5ZQJBaPjaxmaPKBHNp9c5sSc5gad43IWGY8pd1VfdqzsZ/WoLQQvVqJDtWqIUMHlxCBLPSIojd6942uxd/w8dzmsgd1k/wKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7107.apcprd04.prod.outlook.com (2603:1096:820:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 04:55:03 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 04:55:03 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Shuhao Fu <sfual@cse.ust.hk>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] exfat: fix refcount leak in exfat_find
Thread-Topic: [PATCH v2] exfat: fix refcount leak in exfat_find
Thread-Index: AQHcQma1UxU46e9pak6N7Q08PkJFlbTNmYQn
Date: Wed, 22 Oct 2025 04:55:02 +0000
Message-ID:
 <PUZPR04MB63160FD802F4A0D9050EF49981F3A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <aPdHWFiCupwDRiFM@osx.local>
In-Reply-To: <aPdHWFiCupwDRiFM@osx.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7107:EE_
x-ms-office365-filtering-correlation-id: f55740d0-c133-4176-3413-08de11272969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VK8OlW55TKDmDebdSVqGjL94cgr7T+wgGDgc43siqqzFl6x2an+HbmGzHL?=
 =?iso-8859-1?Q?6FYYvaSZruTEJvmPu2IWd8n/VYcD2ClXLLPfYKk+uS61MCjv2ocr4FXTqH?=
 =?iso-8859-1?Q?eruEQ+5Nv7K76582q2T2EbuEZCEvLpWd8+y7YzXR8MNOjnZvq72431CM/W?=
 =?iso-8859-1?Q?yQaHQ2O9qP6EvqJdhciErGa6HjpYNbtoBU0kko7uxHbEJfUhvxkAsLHvf8?=
 =?iso-8859-1?Q?vRlNaRfh0zxXIZliwuitmdlhLwfgYuMOBSe80CYzqgptDlQuIkFdeSyKOx?=
 =?iso-8859-1?Q?Cqx9uMZYpLuAMKgQuaAN5UM5tWGbzKXMl9TJdl+kzG5R8ujtVdRSEgtsCa?=
 =?iso-8859-1?Q?87h3V5M8lrGYxyyM3Bqxkdld0rnxZrCWICLR4YS6Vb6uSkvBG2qWC8Vrhk?=
 =?iso-8859-1?Q?s1H/11nan6oA63P/RiVVcfYlCRf66T5iC2gBg14G6xOs8JDZXtxbH+hnF8?=
 =?iso-8859-1?Q?dzBQ4wuaiW1NL/G5LzIi91kq6e6qG+aMLERQul8q6cxCyZjHDBG04G9hMD?=
 =?iso-8859-1?Q?rUv9CM9O8/j7mBT5Ivbdtly2OQ+m6/2fEGq/0fee2pkisDyRLlj0DKcwg1?=
 =?iso-8859-1?Q?2OPi8lXLgTRHb1xDuY9lkVrS3tTCqGcQUygLhnXmVHNqqbPHVTRNGMOXwS?=
 =?iso-8859-1?Q?v+BFRVFbCBDtju2eA1HC3cdNf5LqA8bJDZk5XrENb8Y7JIPn6h23cqE6cj?=
 =?iso-8859-1?Q?oKupEhcu1ZBlJx2dWzuan4hNLaKRzGNUi7LSSFJ2+dd1Okb2Z9eK2OCBOR?=
 =?iso-8859-1?Q?1U+wuBrbt2x6VNBe5nzExIIzJ4lBI32O4Ksad4i40iHPugAshhJehKQbUi?=
 =?iso-8859-1?Q?r1gpiDo1ZoRZVt5Q7qzRQ33myf0pWhfO7L1jxFVNc/vJ3iBePsvpWRbe08?=
 =?iso-8859-1?Q?YPZ8000+Hj9aO3/apUYEyUo/xZwZdQBfY0c4kF630FiooeiAsHtzuVVt3T?=
 =?iso-8859-1?Q?0ku2e3UnX6lhj0J4LkfYOWbsV5wztHHSBjS6hc/w/ZJpIwqAMKlYAhvNXU?=
 =?iso-8859-1?Q?mUmGnIGJDztILHuyYxULfSwT/ZXAd46KxWGbvI/Rm9l9Nixg+lreH9T2X+?=
 =?iso-8859-1?Q?ArrwZHtOJS71xWRhGp515SvYSkKiKXBg9tQ9oKaQieRm1NOqVOFnUwLOCg?=
 =?iso-8859-1?Q?piQySnMMyIO92CWpM4/M+1MY9RqmAlKT9fhurhjAg33y0vGtJV4CI9VbSv?=
 =?iso-8859-1?Q?x/3Cz1eiUXQtD/EKsXC0FOal7zgwuOMASILpsDnMUFyIY6uzP2icBqaayC?=
 =?iso-8859-1?Q?TW4OIiXjp0L3LlIooImG417XG6Goz0nj67a4x5LF06kk+SoMbGGm/scQhU?=
 =?iso-8859-1?Q?Q3aJUIi5yikTjUcB6v2pmahcegpcgtM7pnanOudC4PoYesp70F7JmJo7nV?=
 =?iso-8859-1?Q?9boxGUlD/MI6h3Wtn2aifeopC0/7F053My/41HxQR/MdEw+X2i4nwCrkcz?=
 =?iso-8859-1?Q?6QNeiw46Ad81bjjLNbyZfHREISCoGdEbX/khoBmlG9p7UlzUk2vOgC4AsY?=
 =?iso-8859-1?Q?Zrp3LWoL5JOfFT4KQN3X8mOAf3fhcT2LD4TchUpmFOdlNZbrE3tzINz1bA?=
 =?iso-8859-1?Q?DuLWvQYy2GzsN/lvsWAcepqv9YbA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vYj5w5K6LsdlD+lDeYW2n3+N5tWH+JJA2m/ha2XFyN6hgp2rUr/MDwwOor?=
 =?iso-8859-1?Q?GdGq27tmFs6esrCf2ptzsDEgoCwDH3fvnfTpiDsKYSI6pSDVJOiIsWtyRO?=
 =?iso-8859-1?Q?LhhdU4BrmtZwWoyj1T47/ul4DxjgllnIcAbwrIIhZxuDMYCE2twWuUe4rG?=
 =?iso-8859-1?Q?J7ISO5D6iCPk/mqp2Y1RFoC7EvGIeVu+PPSFOBY8sR4VO+RjDexR8B+2Q+?=
 =?iso-8859-1?Q?9dPa55gKCUsjkZY3u2sYMDtAzcOo8/gclfIqa6Ufko/UL5ns5ea3pdJPiJ?=
 =?iso-8859-1?Q?FS8zUGUlGp/cJ2L67cHJ1ghjNoax3Z8eVMfwdBKwJTeU39FzOgwNOVKXSf?=
 =?iso-8859-1?Q?gX4bMvf4GVBtoY/ddHNG+8M1qTsCWbUOM5VAS/UGFy7F7SVXq9kZAOpLxH?=
 =?iso-8859-1?Q?neoxaBHFQSVDLqQskKxEB5MPcbwA/PrwUcVhlSnTY5sBjiDvvLxRYe9B1c?=
 =?iso-8859-1?Q?SAZ/RTIBFOKKxFNLcN+OPtsAzQUSL+o9vbBm2JlbgKkd9M+3oMQ7NbCv6g?=
 =?iso-8859-1?Q?kWLCcVThhsHBvMbMAam+6uW+gQ4Xu+DvdMg56U6iqhlVQ0WtO24tTireko?=
 =?iso-8859-1?Q?/9C3la81IgNdpjeBpleBRjfmyeX1kUA84lK8Y21vNj5PrOT4oaeXk4rXCF?=
 =?iso-8859-1?Q?GhjGWTbmAPZBXCsczuQkFuSElZW/YfsuPbifPq7kx8YaikIH9iKq5PUKei?=
 =?iso-8859-1?Q?UHVrxht/qxEvt9dk7HqjzpYzPxagNgHYJsIpQC1uuaGsW2Dr9iGH1bH527?=
 =?iso-8859-1?Q?cCCwuTOHvdmzjwt+KQHSUwAbVfTOtqPmCPG6fcIrkMa9UnLNjP1tZU/YV/?=
 =?iso-8859-1?Q?irj2dvRmjYFhS7mBWbbXHEpGjJqI2t4b8DqXEhbxOWYD0c7/sW+LNeHwgQ?=
 =?iso-8859-1?Q?w7g8o/Wei9J4vD3gFoiiMvGSjmLHq1b2Yns0zJeZvsmuQIQETx46eStLSB?=
 =?iso-8859-1?Q?s3IZXAjayp42R8aAUg3hzwitD4F8gf5FbaOEgijcl5V8ft8xrtn4gFVgll?=
 =?iso-8859-1?Q?7tDZhB9UNSeHGg3d3zOQ+yJ38SJhxAVTniFbipdXDUBPQu/X6IG6r8RIwj?=
 =?iso-8859-1?Q?qcZtNtsii27lJmPnKjOwW5GbH04YHkR3Lz+TukrtVyE1u9Q+pQklaR9Or0?=
 =?iso-8859-1?Q?WCRpkLwcGKQjak/D1U/u2D+ix2FF65MkXyeuT6Jemv5IYTKYa3vpIi5L86?=
 =?iso-8859-1?Q?bn8jzn9mQjaUdXtrTzLCKMjZ3JyUk5/PFUZZ+nLyGsasEZMpsKIQfmm/0X?=
 =?iso-8859-1?Q?2CAD4b/Gbuh7+NVy4UxG6bRpA9mngxmIQLjhRl04mwuipHdojwPecahs6Y?=
 =?iso-8859-1?Q?aojzVk5LpyQzOPP/Ka/lN4BxUvWI80AeisTFL4kYOQk6tgmRxWNerSNnd0?=
 =?iso-8859-1?Q?H6+D8rGT+fryhGnNIGFc9ErB6BQiHpqw9aAvpm+ShSyu/NDsjnA8rlk/Xe?=
 =?iso-8859-1?Q?BBPHZ8arUcdepsVvtFK1E4E+nwzBIORRCcKQiiQY5WO5vXS/VNQ0fThPjA?=
 =?iso-8859-1?Q?01cg8p5rmMY1vNFEr1VbVC+9foaffPzrvXhubARHjSdQ1DJeQ2oL+UN6Hw?=
 =?iso-8859-1?Q?tNYCsFYLoVwWqhREZj8qmlukmNpScvKs+dfIO299+c2qWkOvOiNs2Tl4Xu?=
 =?iso-8859-1?Q?Z6eyKwqvNmXaRP2xr8fFF+jCVqS5WTSRbd4fe9yKGxXVXk1nY1FBw5Cg?=
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
	zqkGuQj28D/HQTUN4jFKYREyRAL34rC+5rSsE+uKFvTbsDGQGbPXx2laEc7uyeBhBacWfrQZC1/1nCmtk+s9T3IsheGmldWZWbj51PSB1cqJWVZdhDDL4wAxIkwxATxBNoiCSglbgmeUmvPTT6gttuFzZVWm8MPI663dP6xzFZTer5jDLg0LjnhjHGupvH0HXOh5EflcnOOYyzyp4Boy1SJKk2hi+Sfqv6qhShHoSGJYTxmd+bGQQZhheG3rtOBmb7+4EuG03/IchrmgS9sow+nZFdHaf0j8TFe9LvPMIWqfxHhg1lE0j96UFMR0qzczLy5TuSKEBnAbnXMsVpXIXQ7DH35NhYsOTsjZA52oWOsAMSiKQZ+qhCiDRIKjbEIn2oiztOZuAqMnAS7sBf7+egrdAXTj9RnWOsTjKkq8irBQ2lI3lJlsielewF/obmjXVaUqz+RZvXycbraSfOAaBH8jx9ASZSEq6PJjU4m5GozxQNZtC21CvSMIwNk5mqYqfx8FyAvq95hYyp88AiVZnPipFE0ySktYq6zob6SnGTOtdgVCwlptVXdinKB/nbWuE4uLwfxPRMHGcac1x/ujlAhMoGvPOYTlHyz+OPwdsi2AyTBETwH9dxQL64QmDHu9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55740d0-c133-4176-3413-08de11272969
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 04:55:02.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx4Sm2gOXIRElIymYMz321xatj1/ltv6L9D4Uum3e/hWPTZNVvivfaEj8YXwaWu2YdnJIwROoomZbq9Op3gkWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxMyBTYWx0ZWRfXzgvcTmd02vIu mKfg9Px3fvaCoW3xdukCm5pKVCekMEi/Lt0lhHUNY6Q12T4CbcSoIz1NVXHpbOBV2u5byArM1Lb Min//x7h+algBqTRu1uICb7Vlp75nkLslczLseaSCmyMcWcIIZxiIc7Iygkd9nJf+cwJGtPCHQF
 Ijn0RGnnCa/DIbE2g6DBhaswBw+5jWgNQyXuNyGofJRKJNyoH9uTVZyiP0EovLy4SiSamHe7UDh m2i3uUhCUJV2C+XSjPbxuSRz7Eya/75hbHtL4A0UrDLgl+z1hUVeWSWCdOn+rx0ZBYyh9zBkj9B SgRYWP/EmAD0nPlUjlGvE/iTyNwk8dd23oHGCEgW9kkpgKHBzHvRuPyV/4mOfnYUkz9VwklyyNh
 MEvxqyRUiqPVxsKP1tJWhAcJnYy/KQ==
X-Proofpoint-ORIG-GUID: _Vrm1o9U5ofIKcj6SATDNuBe9D4yQrfG
X-Authority-Analysis: v=2.4 cv=KOtXzVFo c=1 sm=1 tr=0 ts=68f863b5 cx=c_pps a=8nJjTn7gZLVrTAxzR7G9jQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=z6gsHLkEAAAA:8 a=osMNzxOEC1P48qwaC3wA:9 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: _Vrm1o9U5ofIKcj6SATDNuBe9D4yQrfG
X-Sony-Outbound-GUID: _Vrm1o9U5ofIKcj6SATDNuBe9D4yQrfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01

On Tue, Oct 21, 2025 16:42 Shuhao Fu <sfual@cse.ust.hk> wrote:=0A=
> Fix refcount leaks in `exfat_find` related to `exfat_get_dentry_set`.=0A=
> =0A=
> Function `exfat_get_dentry_set` would increase the reference counter of=
=0A=
> `es->bh` on success. Therefore, `exfat_put_dentry_set` must be called=0A=
> after `exfat_get_dentry_set` to ensure refcount consistency. This patch=
=0A=
> relocate two checks to avoid possible leaks.=0A=
> =0A=
> Fixes: 82ebecdc74ff ("exfat: fix improper check of dentry.stream.valid_si=
ze")=0A=
> Fixes: 13940cef9549 ("exfat: add a check for invalid data size")=0A=
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>=0A=
> ---=0A=
> Change to v1: [1]=0A=
> - relocate two checks=0A=
> =0A=
> [1] https://lore.kernel.org/linux-fsdevel/aPZOpRfVPZCP8vPw@chcpu18/=0A=
> ---=0A=
>  fs/exfat/namei.c | 20 ++++++++++----------=0A=
>  1 file changed, 10 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
> index 745dce29d..dfe957493 100644=0A=
> --- a/fs/exfat/namei.c=0A=
> +++ b/fs/exfat/namei.c=0A=
> @@ -645,16 +645,6 @@ static int exfat_find(struct inode *dir, const struc=
t qstr *qname,=0A=
>         info->valid_size =3D le64_to_cpu(ep2->dentry.stream.valid_size);=
=0A=
>         info->size =3D le64_to_cpu(ep2->dentry.stream.size);=0A=
> =0A=
> -       if (info->valid_size < 0) {=0A=
> -               exfat_fs_error(sb, "data valid size is invalid(%lld)", in=
fo->valid_size);=0A=
> -               return -EIO;=0A=
> -       }=0A=
> -=0A=
> -       if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used=
_clusters)) {=0A=
> -               exfat_fs_error(sb, "data size is invalid(%lld)", info->si=
ze);=0A=
> -               return -EIO;=0A=
> -       }=0A=
> -=0A=
>         info->start_clu =3D le32_to_cpu(ep2->dentry.stream.start_clu);=0A=
>         if (!is_valid_cluster(sbi, info->start_clu) && info->size) {=0A=
>                 exfat_warn(sb, "start_clu is invalid cluster(0x%x)",=0A=
> @@ -692,6 +682,16 @@ static int exfat_find(struct inode *dir, const struc=
t qstr *qname,=0A=
>                              0);=0A=
>         exfat_put_dentry_set(&es, false);=0A=
> =0A=
> +       if (info->valid_size < 0) {=0A=
> +               exfat_fs_error(sb, "data valid size is invalid(%lld)", in=
fo->valid_size);=0A=
> +               return -EIO;=0A=
> +       }=0A=
> +=0A=
> +       if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used=
_clusters)) {=0A=
> +               exfat_fs_error(sb, "data size is invalid(%lld)", info->si=
ze);=0A=
> +               return -EIO;=0A=
> +       }=0A=
> +=0A=
>         if (ei->start_clu =3D=3D EXFAT_FREE_CLUSTER) {=0A=
>                 exfat_fs_error(sb,=0A=
>                                "non-zero size file starts with zero clust=
er (size : %llu, p_dir : %u, entry : 0x%08x)",=0A=
=0A=
Looks good to me.=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
=0A=
> --=0A=
> 2.39.5 (Apple Git-154)=

