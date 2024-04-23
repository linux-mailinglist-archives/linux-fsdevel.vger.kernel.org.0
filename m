Return-Path: <linux-fsdevel+bounces-17451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE528ADC33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A016282F69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E418E1F;
	Tue, 23 Apr 2024 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Ui7d7zYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B418032
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842502; cv=fail; b=nflTQdDBQiP4t9o7Gagv4nyIiuN3B12hdcMtzdfmBG+NpF8OJmYwNcpjMHneO66lu9mKVN0UpiEFrsW/cVM8tmTXXU97fyqYCRTqh1JPXjPZZuaYW7nV5YRRbMI5ZCVccQlPj2XHDVyBtGDBUXT451+/bitQZ5G+veiJbM1VLvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842502; c=relaxed/simple;
	bh=8ssvk9RmfOtqbliVFTCCLHyGSV5bVHvc7dtGVQHNtXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mn8OJvjz1Max1MJ1shAMEwmtrCqN06iEA5worMsONzQS8UusX2cmbw4/Xo3gU+xyjGqJ2Ux3yXySjjMNtLUIHjIlCGyIkiD+IQEMaHFcMD9IXk0XtaxBp0MUo7Isfo+G/NOQxm+ZqsMw9TL7DcmrN/EcU5hENdLmpR7qL8eziok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Ui7d7zYJ; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N29ILc032613;
	Tue, 23 Apr 2024 02:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=S1;
 bh=dHarffTyXCPEunQhmR88YDVsATcnpVaBh1Kgys9sDMM=;
 b=Ui7d7zYJ87BBYhmAH3KdvuhWADSFqrFdmbHuGN/EL27fZnuVfmaBKziYtExp3FXD2825
 I6WL4V8bxTrcGH/7pHfpqib9mCiBy6+H5weRI9Zwi8bcYkpxNrN7OKo3yowCUNy31n8x
 zfEs+TlIydaJiQXE+8RsgeCDD0/BS2QViH79RduQgrLofEamUZQio6T0sgyXliAzark6
 3BMDcjsMeRMYmJTbCuQRZJFu8a6R6wDuXzI0TJsieDDjQmA4kK9sxVF+982+L9FJQvtJ
 q40px2cAe2UjsF3reKIAr4qYmkhnOmoXuu4vqhpVPGe5Dq4iyHRo9P/TQSe5Vmo0/x9B mA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xm521jhkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 02:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmX76cz2jTV8/cLdjAbcPBsAquY5W6jL9ynRH+MhpTWp6Ju9cyDUOAWHVQ0EQGulRa/V5hwa7Po9gJgX8egcqt5ySo8DORggyz2D0A1249rVM2x/v5OXvaWvoGLJ8DXqEMPe8vGLksH974XMJzc1Eizrhmn6Qg5LchE5RD0Sv/xmSL9Mus3SCwXhcFYNEZqrqombYkLn5uWvM0JJSqXMjSbpA5Un36Psv9cqn5ecHlfZI7wdEAy6nrutnpsQL6e8KuTG+sf2TE58aFLopAEvUMwBUKIUy+bK9Ty73SuExqfjLDMBdsBPTIHJEsWy7D2HseNgPdstSQL6Cvgbkzn0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHarffTyXCPEunQhmR88YDVsATcnpVaBh1Kgys9sDMM=;
 b=dE0YK65bPVhzPn2OBnp3qTCwZyjvlQ/VL7z8outiyc3jj2ohOu4ovBkGd0sdoFr9J3vd34JdlihUceBA5QfL9Y0Xhkh9AoiYoLGOMLq2vGNt1WX4xDSH0ZLw/QFexaOfNsiA9LV8hx498OsFVq3ksXWwQQqL4H2NcxKlRqWGmUP8ibsbpiiz4fvYR9XxDJ2N3+JItLbhxsiG39nLqJCPOr03Y7CKpdog/3LHA0zK/dplcSijkK9aJz1iJUESZ4/OsT1/4ww8ai/Ga82q8HaaQ9tiK6zYA21tk6RRc8xim5ok49q/UAC8rpB3AvZgxFGlS4PxyyC8/GNF9uO20s9S6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB7106.apcprd04.prod.outlook.com (2603:1096:820:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:28:40 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%2]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:28:40 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Topic: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Index: AQHalSVihLmFn4H720eTr8GfTnzOoA==
Date: Tue, 23 Apr 2024 02:28:40 +0000
Message-ID: 
 <PUZPR04MB63168EFB1C670A913C42E80981112@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB7106:EE_
x-ms-office365-filtering-correlation-id: 68d0fc46-7dc0-44dc-003a-08dc633d16c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?XLcQ9gvJgk93QcxXG8jtx9I8q9ULwS1VTiSVPLp/tQyx3pkuK8OiDWVs6J?=
 =?iso-8859-1?Q?Wu4zrj6zmwln+1xCRR+hZdCTKcpEL0x9YyD8mW5BfwkBEIKOwvZmaGsaKT?=
 =?iso-8859-1?Q?6C8Fg8vqqPVeIzPt+/59f7Urx2hrjrl3egDP4pd9JBdrVuHm/xS7foU8rA?=
 =?iso-8859-1?Q?c3EJz86rNyRRv0ZyflBUHwgaD4c0wexxvON03ctDiF7nDF5BGkIdfFRcqE?=
 =?iso-8859-1?Q?2Er3Ss58t6/nCOniTds4J/uIMeRL1kCRH8xVeXpMks+RXXJroGjYgW4AvZ?=
 =?iso-8859-1?Q?z6mw0oYNDve7pv8nMFNifvwWsSbi1hGZNRMLPGjFzEtbIvW9KtrgDiXqvV?=
 =?iso-8859-1?Q?k1zcf1EPkGtEJLrBOogda7uJo61I5w7EcTN9vT7CGwgOZ8BSs/NbMWIkkx?=
 =?iso-8859-1?Q?UJjIP3NVC7KtaKZ2py5JtkxM/SZgdXHhgLZIKJCuQ5E+LEJHksj4eFzIV0?=
 =?iso-8859-1?Q?zQnQbzce0OTGV+b9bVSw09sTPTKbCqrlFH0d/3NAEBr/5yCg1Xw+dJKOqi?=
 =?iso-8859-1?Q?W3u+HNhZKrLM/VWp5iDedFVapompDgiriJ8Libt05ioLrzUY6Qbz6S7AUQ?=
 =?iso-8859-1?Q?uRjAkHPJ1eZ3174x5OQtCWJ1fcOV8Oi6dCwUKV05pNx/t+7WAALLANIY6x?=
 =?iso-8859-1?Q?8sbM9AmIWiDM3aKZm2QJuaIOsyYxJnob3wsdsnI9qk+zXaKV+nB5iVn410?=
 =?iso-8859-1?Q?vXvfDvJCtc2o7zpyHrcRNjC/6i3bpSFUPvssFEgD1G/22Y+Pth0QvkMaJH?=
 =?iso-8859-1?Q?4p7Kl03JMBT6d/GvM6hPjHRDK0atvY8GzzJtK7eBzOTxU3IO8Rowu1QVWX?=
 =?iso-8859-1?Q?oI85cYd/qAjq+ogIS4RRYLel+5fPgx9cexxZLlGKrQMoo5aFUFZRTH0Okk?=
 =?iso-8859-1?Q?tQ2hDvFxFPvVCZyzwUsZb1qe3bek2D/3U718KzUDhVchg/QFYqPLsd7FGL?=
 =?iso-8859-1?Q?UdxplTl1BErvRua3mdSs1iB5NQgv3TADeVB4Zfcg/18csesJbEInUNfofb?=
 =?iso-8859-1?Q?1L+YlZYpbFjjKj+PnXnKw4AZtE+vqHfJWiSPBVR9oRHA6OvdXiDrOAig1t?=
 =?iso-8859-1?Q?gxdzZx3/Hjp0VfDZR4OfN/hxCTciNONj+vh88cXUwoXQ3l9Y+jukVJtQsj?=
 =?iso-8859-1?Q?4JJRd2wASqM/WG6yHf/0f58KxY01ZYPYrnuzmJedqiU/s3jVzMvA65HMIo?=
 =?iso-8859-1?Q?cPplOiz1cSx1R3JLDm6O1h4Bu4NKXZdl6Njzo1opfV9wLTxGVT6tn2vfql?=
 =?iso-8859-1?Q?KiXOeGtI023DaEddyAGCIZ8EgrObYvRCIWQ2LUWMhMfpmbVcQjnyDeQrXs?=
 =?iso-8859-1?Q?VB6raTehb82QOpqwsuI8g81vN9kYGnZjTc3wdbVK9DMkzbDpXt3yrXTMWL?=
 =?iso-8859-1?Q?iQja7hbKE9OyWI/KjK5RWqGW5UwlwLnw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?5jNpDMb0SKhck05LjPBxxjNsYcnp3q2tAoyoCdPNVkCV+23j28jEWpksgF?=
 =?iso-8859-1?Q?tMd/NyQARI1NcKWXh+xPXP9bDv20eVUg/r898drgoM2bHzLI+61dvx/C/E?=
 =?iso-8859-1?Q?SWo/GpXXwd5bn7WIEFpjjVwuMLr3ll3RK64jxInuAGzC8MIlmMkLfFM6kK?=
 =?iso-8859-1?Q?b2M0cw5+vqhi1B2BFOCMSbntu1qyR0SMw2vNHTgm89IIpPFuSg9KrmtmB6?=
 =?iso-8859-1?Q?Usf2eB3N80bXUlnj2Ft+rNB+EaNJFJtGNdvY+KECN2eh8O58UpT5CLi8nI?=
 =?iso-8859-1?Q?NLiRH6pqMaK+XmrtNnOjojWw/EvTSnxi+UykAG1eSO8EJcCPod1lVmkWc0?=
 =?iso-8859-1?Q?Er2f8SqNv9oh1CguzPgW9I1QV4TQLQeGATpGrhWe+qcO7neFZUH1Qustav?=
 =?iso-8859-1?Q?GHxRGRc0mn236spf94lWpG8cXFuOsCv+z4IcS/IveYAI9ZHDQbJEfKiKlm?=
 =?iso-8859-1?Q?iQ52k4JeojVtQI8wpO3gqlbKrB7mmJUuOgFR1iMN9k8KoThkJQTRBw+pgQ?=
 =?iso-8859-1?Q?yovj78wk4jrAdVdcyocH9tZals778I+BMDzfCgzU7Q+QAv58D9mG/eYlXN?=
 =?iso-8859-1?Q?/JOQgcIm+t3YphtECDdPaya1F/8x8Xh1dVIooKTJMh4VSvKfRyEiqG8+a7?=
 =?iso-8859-1?Q?fh0xJpv61LrGB9uPLwN5APD0tloVDy1d7BqLY6Ct6boXTSnJnmq3Pxj6ju?=
 =?iso-8859-1?Q?Mt2LGj97lSWIi6xpcpUdT8pXrePFhyBMd81ToVM3gURVKrJPSbcFwEI+JH?=
 =?iso-8859-1?Q?1HzLmpaP4Oyn05K5jJJpDcEXNzBppZvCbPwLoLZZX6hGgHzM4KckIoZLvs?=
 =?iso-8859-1?Q?gTgFs1W40xLWTijBPgHd2r/m4IdtncAG9Hc/UA7K3SnKXAsgNwp5SluDY5?=
 =?iso-8859-1?Q?AcHBIPm+2ryRYEL/RvOMNl6Ic6I9we7ZZAqDLBRBHaH+HT7rprf8qwinYL?=
 =?iso-8859-1?Q?RZ9lMwccVavXrNjJT9auJfiZqboQMeOmaUMIlsbszNkomz6vfmsaujeLnf?=
 =?iso-8859-1?Q?21xLiMufAbdtMizYPjooUqdvFEYnbnIlKZelhsXsxGyZBrehSK/DYjmb/E?=
 =?iso-8859-1?Q?FAnH6XmfryW6YNGZ0DQe5xND+6Z5V7lgVMJVs5oBaleu+4Hy+g86UKAYTz?=
 =?iso-8859-1?Q?0XBWxHd5FO/VTsnfC4hkRJJGY3W+sj1CDNMj71j4jxd4oriExwGtFARiEw?=
 =?iso-8859-1?Q?omEhVUSDX0iZq2kd2fXmwZoWpN2/YCP0w7ur8PgVn7jV/VnWVS5jKiWVL4?=
 =?iso-8859-1?Q?+G/+JZYh4RJl+aPeXBq+ZFvSpiv+94+tT4rLD4J93P9sTQ4HQuhLbD1kmH?=
 =?iso-8859-1?Q?ZL9pC8S2ft57NeqdvWXuSSYjGQh5mMNKsuGKZxbw3/BMC0U6rtV4xqMsjt?=
 =?iso-8859-1?Q?U/kzsSnyCMey1hnc/k87tHwtsO9cjB7PEQxp5HiBORnGUOkdbsXwnvoOYd?=
 =?iso-8859-1?Q?6I+Tnub4W5QNwdSiRLbBoowC+Pz5b/zfrIvAntt6E5ENPilXF6SwbFxg+0?=
 =?iso-8859-1?Q?SI9HYVZG0VjaInjruKjC1pNEU4Jj3OnIovWIk7zeKNsd8K5AZY7VrNOe32?=
 =?iso-8859-1?Q?70YywTqkuYjGa+s9DYERRiglHktf/NZAZH7QguoG1fUrlECDhsNALJSLNu?=
 =?iso-8859-1?Q?4XBnXUP1/uAZKIMK70Lzn179wbmj7Yzka1jaNKK26CyxLzNuXScFuv1zYq?=
 =?iso-8859-1?Q?mXGt0MCIpAaa6/uhClE=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q0VAuagEryTap9/BSmVdRuHTQ22t8MXtilLMHRwbOrzXcg5CHI5/Th4GixcLJj7jrrknNavFBlIKWHoxjlO0c7Qfay8uVtriC6R/WXcnRPUXft8oi/MOGZWfJMah6m/9D6kFp6FKBsTrhKY4NwyKwG3FJZZAWgg8AYVVLO8VBgUadVmG3zZFGHRLTZhqGLAJ4TPAH7YLyDLRQTTIgTxd6uzY4ATYubXex8oqyUheivRfopsGS4f7RTbIXdIU9rZ/LFRT5nYP6bD5eEWKsGEFKXL9e1wIg4ZFEN8WQDi0gdy8tuCQGTkg6N00PiTxPSXtugRSMDvJ3hWHgBcqbcPo/XJdRTCIBK4yDx1I9zYqoKBvIDXLLI3ureZ8KhFvPiOgZgyxnS52+0OQMSmJ3MSWXmkwjcivgvL0iyq+enTFw3nwf823evjfHTTI1zdzlQ6l862ULWEykdNtl8R8b1A4LJLpstGQ1+1Y74MPmpyadJk2+fk5l/c9asmpM/xVotYc84lEfQH6l4p5T5PqCr9C/kzh3etp2zqqcdwxneBICUwRWrdRe9oHqUyNpziPI7bkzZZGDd4l+ZGuHYPS22uRXDypV6g96ci2LO+fW+7875gg8bow1zOqgN8gAeXiJYI7
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0fc46-7dc0-44dc-003a-08dc633d16c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 02:28:40.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO1xDMhWMPDBkvNjb1Dchri5tF/YU4gnJCPdEd0+Epoo381le/ePIKbsx6zzGwNN1LiG4dhdl4ovoiklu9ORhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7106
X-Proofpoint-GUID: YmiWecWgK4fDuK44TfLDoJNCTphg9M2F
X-Proofpoint-ORIG-GUID: YmiWecWgK4fDuK44TfLDoJNCTphg9M2F
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB63168EFB1C670A913C42E80981112PUZPR04MB6316apcp_"
X-Sony-Outbound-GUID: YmiWecWgK4fDuK44TfLDoJNCTphg9M2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02

--_002_PUZPR04MB63168EFB1C670A913C42E80981112PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From exFAT specification, the reserved fields should initialize=0A=
to zero and should not use for any purpose.=0A=
=0A=
If create a new dentry set in the UNUSED dentries, all fields=0A=
had been zeroed when allocating cluster to parent directory.=0A=
=0A=
But if create a new dentry set in the DELETED dentries, the=0A=
reserved fields in file and stream extension dentries may be=0A=
non-zero. Because only the valid bit of the type field of the=0A=
dentry is cleared in exfat_remove_entries(), if the type of=0A=
dentry is different from the original(For example, a dentry that=0A=
was originally a file name dentry, then set to deleted dentry,=0A=
and then set as a file dentry), the reserved fields is non-zero.=0A=
=0A=
So this commit zeroes the reserved fields when createing file=0A=
dentry and stream extension dentry.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
Reviewed-by: Andy Wu <Andy.Wu@sony.com>=0A=
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>=0A=
---=0A=
 fs/exfat/dir.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c=0A=
index 077944d3c2c0..cbdd9b59053d 100644=0A=
--- a/fs/exfat/dir.c=0A=
+++ b/fs/exfat/dir.c=0A=
@@ -428,6 +428,10 @@ static void exfat_init_stream_entry(struct exfat_dentr=
y *ep,=0A=
 	ep->dentry.stream.start_clu =3D cpu_to_le32(start_clu);=0A=
 	ep->dentry.stream.valid_size =3D cpu_to_le64(size);=0A=
 	ep->dentry.stream.size =3D cpu_to_le64(size);=0A=
+=0A=
+	ep->dentry.stream.reserved1 =3D 0;=0A=
+	ep->dentry.stream.reserved2 =3D 0;=0A=
+	ep->dentry.stream.reserved3 =3D 0;=0A=
 }=0A=
 =0A=
 static void exfat_init_name_entry(struct exfat_dentry *ep,=0A=
@@ -474,6 +478,9 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache =
*es,=0A=
 			&ep->dentry.file.access_date,=0A=
 			NULL);=0A=
 =0A=
+	ep->dentry.file.reserved1 =3D 0;=0A=
+	memset(ep->dentry.file.reserved2, 0, sizeof(ep->dentry.file.reserved2));=
=0A=
+=0A=
 	ep =3D exfat_get_dentry_cached(es, ES_IDX_STREAM);=0A=
 	exfat_init_stream_entry(ep, start_clu, size);=0A=
 }=0A=
-- =0A=
2.34.1=0A=

--_002_PUZPR04MB63168EFB1C670A913C42E80981112PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-zero-the-reserved-fields-of-file-and-stream.patch"
Content-Description: 
 v1-0001-exfat-zero-the-reserved-fields-of-file-and-stream.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-zero-the-reserved-fields-of-file-and-stream.patch";
	size=2105; creation-date="Tue, 23 Apr 2024 02:27:11 GMT";
	modification-date="Tue, 23 Apr 2024 02:27:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNDQxMTc4NjIzNjE4NzBmOTk0MDI5ZjhhODQyNDkwNWZlM2NjMGYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMTIgSmFuIDIwMjQgMTQ6NDg6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogemVybyB0aGUgcmVzZXJ2ZWQgZmllbGRzIG9mIGZpbGUgYW5kIHN0cmVhbQogZXh0ZW5z
aW9uIGRlbnRyaWVzCgpGcm9tIGV4RkFUIHNwZWNpZmljYXRpb24sIHRoZSByZXNlcnZlZCBmaWVs
ZHMgc2hvdWxkIGluaXRpYWxpemUKdG8gemVybyBhbmQgc2hvdWxkIG5vdCB1c2UgZm9yIGFueSBw
dXJwb3NlLgoKSWYgY3JlYXRlIGEgbmV3IGRlbnRyeSBzZXQgaW4gdGhlIFVOVVNFRCBkZW50cmll
cywgYWxsIGZpZWxkcwpoYWQgYmVlbiB6ZXJvZWQgd2hlbiBhbGxvY2F0aW5nIGNsdXN0ZXIgdG8g
cGFyZW50IGRpcmVjdG9yeS4KCkJ1dCBpZiBjcmVhdGUgYSBuZXcgZGVudHJ5IHNldCBpbiB0aGUg
REVMRVRFRCBkZW50cmllcywgdGhlCnJlc2VydmVkIGZpZWxkcyBpbiBmaWxlIGFuZCBzdHJlYW0g
ZXh0ZW5zaW9uIGRlbnRyaWVzIG1heSBiZQpub24temVyby4gQmVjYXVzZSBvbmx5IHRoZSB2YWxp
ZCBiaXQgb2YgdGhlIHR5cGUgZmllbGQgb2YgdGhlCmRlbnRyeSBpcyBjbGVhcmVkIGluIGV4ZmF0
X3JlbW92ZV9lbnRyaWVzKCksIGlmIHRoZSB0eXBlIG9mCmRlbnRyeSBpcyBkaWZmZXJlbnQgZnJv
bSB0aGUgb3JpZ2luYWwoRm9yIGV4YW1wbGUsIGEgZGVudHJ5IHRoYXQKd2FzIG9yaWdpbmFsbHkg
YSBmaWxlIG5hbWUgZGVudHJ5LCB0aGVuIHNldCB0byBkZWxldGVkIGRlbnRyeSwKYW5kIHRoZW4g
c2V0IGFzIGEgZmlsZSBkZW50cnkpLCB0aGUgcmVzZXJ2ZWQgZmllbGRzIGlzIG5vbi16ZXJvLgoK
U28gdGhpcyBjb21taXQgemVyb2VzIHRoZSByZXNlcnZlZCBmaWVsZHMgd2hlbiBjcmVhdGVpbmcg
ZmlsZQpkZW50cnkgYW5kIHN0cmVhbSBleHRlbnNpb24gZGVudHJ5LgoKU2lnbmVkLW9mZi1ieTog
WXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPgpSZXZpZXdlZC1ieTogQW5keSBXdSA8
QW5keS5XdUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lh
bWFAc29ueS5jb20+Ci0tLQogZnMvZXhmYXQvZGlyLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4
ZmF0L2Rpci5jCmluZGV4IDA3Nzk0NGQzYzJjMC4uY2JkZDliNTkwNTNkIDEwMDY0NAotLS0gYS9m
cy9leGZhdC9kaXIuYworKysgYi9mcy9leGZhdC9kaXIuYwpAQCAtNDI4LDYgKzQyOCwxMCBAQCBz
dGF0aWMgdm9pZCBleGZhdF9pbml0X3N0cmVhbV9lbnRyeShzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpl
cCwKIAllcC0+ZGVudHJ5LnN0cmVhbS5zdGFydF9jbHUgPSBjcHVfdG9fbGUzMihzdGFydF9jbHUp
OwogCWVwLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9fbGU2NChzaXplKTsKIAll
cC0+ZGVudHJ5LnN0cmVhbS5zaXplID0gY3B1X3RvX2xlNjQoc2l6ZSk7CisKKwllcC0+ZGVudHJ5
LnN0cmVhbS5yZXNlcnZlZDEgPSAwOworCWVwLT5kZW50cnkuc3RyZWFtLnJlc2VydmVkMiA9IDA7
CisJZXAtPmRlbnRyeS5zdHJlYW0ucmVzZXJ2ZWQzID0gMDsKIH0KIAogc3RhdGljIHZvaWQgZXhm
YXRfaW5pdF9uYW1lX2VudHJ5KHN0cnVjdCBleGZhdF9kZW50cnkgKmVwLApAQCAtNDc0LDYgKzQ3
OCw5IEBAIHZvaWQgZXhmYXRfaW5pdF9kaXJfZW50cnkoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9j
YWNoZSAqZXMsCiAJCQkmZXAtPmRlbnRyeS5maWxlLmFjY2Vzc19kYXRlLAogCQkJTlVMTCk7CiAK
KwllcC0+ZGVudHJ5LmZpbGUucmVzZXJ2ZWQxID0gMDsKKwltZW1zZXQoZXAtPmRlbnRyeS5maWxl
LnJlc2VydmVkMiwgMCwgc2l6ZW9mKGVwLT5kZW50cnkuZmlsZS5yZXNlcnZlZDIpKTsKKwogCWVw
ID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9TVFJFQU0pOwogCWV4ZmF0X2lu
aXRfc3RyZWFtX2VudHJ5KGVwLCBzdGFydF9jbHUsIHNpemUpOwogfQotLSAKMi4zNC4xCgo=

--_002_PUZPR04MB63168EFB1C670A913C42E80981112PUZPR04MB6316apcp_--

