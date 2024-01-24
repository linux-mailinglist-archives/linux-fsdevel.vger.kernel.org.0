Return-Path: <linux-fsdevel+bounces-8673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDD83A0D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70DB28CA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABABE549;
	Wed, 24 Jan 2024 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="V65D5pMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67EC131
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072469; cv=fail; b=IuB6JGXkii1okDlHx5UlBzgqxld/T1W1lhJlphojX0kehOUpSHCUEt6qFnoq+mqiWj7p8vgeOWFE8vx1t2DWbKioi0hZug3DIYfdIIFLrrv/nsiSWKr3iQ/iWJ2D62fAe73R+yOIi7Zo4ifAvro2om/hcORcMoIe0CoyN3trfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072469; c=relaxed/simple;
	bh=f37UhxOmVG2lDTUmYkxAzz7jKT9kBeZazb2JJK7MsGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeSgtM6GsL1RxsoD7qqRwOZP5Y1QK36HxeH/8TZ3WWPK3ldRWreXU/DzPTIswbygxLSIlxIBfPHRIbmoSeIFD/FtFPeUnO3jqGezF3MUIGxRw1GmAFuxFI/bl6NgFuQdNJV738SG/EBhIE1kOcFzSyooAqtUTrfRC62lKyHA6qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=V65D5pMz; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O4kJD5021607;
	Wed, 24 Jan 2024 05:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=S1;
 bh=sueIqtg6Edif6AzoNh8PLyWElLyuCzHkhAxkATRD83g=;
 b=V65D5pMzRw7H45HKLPnvRbE8ulsTNzerqbYFidwIURtBnemW2R8a8S3FdFQGdX0KHPwa
 VVJvpne+2gS1ySjBCxCs6eAOfJJ9FC2kCDA3Wb7wgRjUWoZcK6U+RE78L/TGXELtldLi
 SNpwI84mSG2vAuXesybXIjVeiMIT3fkU19buxAVq2MyHKxV6ulpmYIi3nPz9MUvQrxv0
 QbLlKZCAE1qm8Zh+gP9CSwcqUQZF9GlFTjRbjqe2ZYXzU53D4Jj8yc5yuTdEofYWwn7Q
 E3YeytouUKbpBS7Vn2EaFr0poLJJ2Ft+B0OHHstGFft/wVFgEhIfklOAKqryQAU6AsQy sg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vr7fb4057-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 05:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaphUYBFxYpzyQAtRBp8WExNhzDHjywXHynjEadakl1MA177BvOlcUl/h9IZDwCMaMh2Bf24eeOiiR9EXR436ds/NCnv2mKBNNLkvFQw9P/GsKYsHtb8u0AliP11YCgvMzSVSnnTr+8WcLBqGmnfYIZ0V3kciL2Hyi+nGFXBGfKx6DAQqxP3Ezo7rQSsZ+1AoS9lMnEZOCjVnqm0gc96WP7W6rIg6+NhszrYxpuH//UsnafKeRDb4cIO/RmmLWM/mcoRgv9Edi9vwGDMrBObrLAejYYinQXBM0iJUqDXs9YqqXZKujjik3R+uXrMziRhzf1R/vMnWZ76flchDawRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sueIqtg6Edif6AzoNh8PLyWElLyuCzHkhAxkATRD83g=;
 b=aixXZoY7OkYRNSGr6UySSpzNRI4bdMczT+6PIRclSjodutihacI34FWI4qN2Ovns8u3xQ3Ri5lcHSS/b6n7HlRY7RTKEKxAHRxkwubEgOCka6TkiGNd0ZmcTFExuir95ZaV2lYrQuwLD7qWxXhGc3HlUDwiDKctxf1dRtHWg/V53DQa/yuzNQFLqWVfv81FZjqOkbj5Y4ibX80gfdKdS60O1sa91sm46UT+ocFUvqkb5YPtsdO9kouNXnzi8QcjGDozVRipg0zci2LZAk4Qvciz+rqjdEz4H05ayb2H1EsB7wdKA0qilUE3b1JTzG6ZpMIvxcyuqBPC2LdTWhH+U2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OS8PR04MB8424.apcprd04.prod.outlook.com (2603:1096:604:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 05:00:37 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 05:00:37 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Thread-Topic: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Thread-Index: AdpN3FSy7vLvoUe1T5GfQPH9ulVGdwApZEFg
Date: Wed, 24 Jan 2024 05:00:37 +0000
Message-ID: 
 <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OS8PR04MB8424:EE_
x-ms-office365-filtering-correlation-id: 5e42e131-8868-4f2f-7814-08dc1c99676d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 52pR1cL09A2IWn5pB0sJCoQd5g3E6thrxUwCK2HW5R0cMAw9El+LEqFo7WuXTJzMa77t0Ov3tbgEEcfvL+5F9SNttcZFC10o3HhXVadrIu3WPmX5wbXkgBZPnARExqCHwxMgC+aGTRxTNdejunkn7Me0f7ctEEUZovwyb/ZoNyOvFvWdN+dmHZ9nvwUueGVgKdYQ6Tm33QlCpaVOXgi94Dp9oSghjQiTEojVPpjGcFdSFCG3LsjebF3A2YVXAGiiKirH/OyCo1fq+HdCERd5k4u/d7GBz/eSeBJJknbcoFGE6XIk1vfRSvg6jtz79+FbSpuotnDGVbcjRR4zFH/qgQe+cPFFyxpuYYvzUfUqmj/kYRzCTiw8dkkzWRV1w2Dck8Iwy30cgVhAOYDxH1aOKw3DysQwvu2k8MquiGXz7PkOU6v5qS4CfiY5fKPClMM8DoA9vf6gRNhZp8efyhfeAySKqEnM7UuZ3F6p6DETeFNwb8WLGBxjiixJuEPxehaOw+gvygxi8Myx28cZybhAnot6offVYpUPUMIPlBcg0EYveRoiyFmLxb/gZTalUBAvWhHqrgpHOIgLUODTKMcX2h57qkxldPTgx7f9S3AhVtgCdXQPKYYK3OLyc/OVBE9n
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33656002)(99936003)(4744005)(86362001)(2906002)(38070700009)(66476007)(64756008)(83380400001)(41300700001)(82960400001)(316002)(66556008)(76116006)(54906003)(110136005)(66446008)(66946007)(71200400001)(107886003)(7696005)(6506007)(26005)(55016003)(38100700002)(9686003)(122000001)(478600001)(52536014)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dm9aS0FkQ1VqVmZYVmkyUkJ3azA5cWp0OXZEa0lMajdMbGE3N1ZDWHE3U1Nv?=
 =?utf-8?B?c04rRGErcm8wRWY2SEl6QUZ0YVRxTmJweVYvV0ovdTJkZVRpY3l4WlJTMW83?=
 =?utf-8?B?Z3VOOGdEcEt1VXlDaGFaOWV2NSs4d2hvSC9aT1FlalhvNTEvU0VvdmM0VGQ4?=
 =?utf-8?B?Rld2ajhQeFViQU1tcWFvRFQ0MnRLcGZ0VDRpUGNhNHJvaU9kSUI5eEM5d0x4?=
 =?utf-8?B?RGpXUmkrN3ZUMkxQajJ6RFVicjQ3Uk1pNUlPZFpSQ1ZtamFnYWdVaFd5NFFD?=
 =?utf-8?B?M1NaQTRYN2FuQWJmYmo1UjQ3VnpzQ3Q1akV5aFZDblp2V1lNWStjczFISk95?=
 =?utf-8?B?UHV6VmF0bDRNa2kvNjI0VUJOa2tvRzJiYWxFcUN6MjRuTGx0S1g0QnRoVmxX?=
 =?utf-8?B?dkdxSHB0RFZnaG52citJUnlSanBOVmplY0kzdGdtVjZVTjZIUHJwVXBXUmJ2?=
 =?utf-8?B?cjJKejE4dnIvazMxWHdNQkJIYnVkZ1pJMm16RHFwUlhybzdCY2M2Wmhtc2VB?=
 =?utf-8?B?NTA4R1RmWEJGQW05UWFITFJMeFZQMUVkUDN5UHdSaVdjNmtwdjlQTEpHcCtn?=
 =?utf-8?B?TkRxWDgxMkFLM0VZWlFqdnVSNjlOZHVPdEUrTE5QMmxOSFIySzJVbzV3TzB3?=
 =?utf-8?B?cjJYNkJxWGJXbkFBbVl4dTQrb3JZM0NaeklxZGFSYW56NkV5QXczYklSSnNV?=
 =?utf-8?B?TVdUZnhRdzJKZ2M5MWNrdWUyUkJsQytDS1QzNHZuT1pXQzhrVlVGbVVQcFUx?=
 =?utf-8?B?Y0RxdWRZY2QxTnRsd1Q5aWtSZWFTK0s5M0VQRnBtMXJCVHFEZXNCQXFrWEhZ?=
 =?utf-8?B?elhMbW14MzlxeEVQUDBVcjFHWEx6Z2pBQW5pTVZqVThwbHl0d0pKVXhkQXpE?=
 =?utf-8?B?NXo3cE94UkNLRmFQSmQrODJTVlBjVkNjNjFSTHhrNkNnZEVqUjVmUmFpNmUr?=
 =?utf-8?B?TnM2TFBKbWN3Nnh3R2N0VmR5Z0dhMWFVczI4ZDBXeEo1SEJuVzRNUWliL01o?=
 =?utf-8?B?WGpzOWkwa2JGVzNHcW5vSWZrOG9PdWJYNWYzVGdtckM0aVZUUFNlN2s0NXM1?=
 =?utf-8?B?cWgydnV3dWtlT1hzMXZwVVltTjZTQTdIeWJkcjJFTmpBbHFRNmsyVE9WRVBq?=
 =?utf-8?B?MVVSZWRUZ3l0MDZkRGlCdU9Odlo4QXYvSFdTNnNTU09NbGgvNnNSa2gwbnp6?=
 =?utf-8?B?SzlZZ2duaFpJd0doR1RtR2FmaG5nS2h3R2lvSkVqYkQ1YzVSRTlrVlpWNVcr?=
 =?utf-8?B?YkNWcVovS2lFTk0wUVRyV1gzdUtveXFWU2VZVFVLekJZWExTeWVZVHJkTU9K?=
 =?utf-8?B?aStxNFJnVlBjSHdaZzRzUUFocDNQY25WSmlMVE4wbEhtSGpTbUg1V3c0aXBQ?=
 =?utf-8?B?bmszeDd3azR6Rmh5UzNlZTE2V0VnTkFHaDFLZHRYRGV2T093NkpVNmtkd3ND?=
 =?utf-8?B?Zml5UmVzREM2blhTQ1h3UjB1SlpKTmEwYkNiYW9JbVVBMXpBTjFnRW5lREw0?=
 =?utf-8?B?cmVwYVU5N3ZwdmszMjhTUDdCSGc2bmdvZk1lb2lsdytUQnJ4ZlV6M3pIQ3N4?=
 =?utf-8?B?ODRWd1RzM25oY1E3Q3NmUTZWaWRNbXBuNTJRT3htNFExVmpxejNORU1wVVpk?=
 =?utf-8?B?SnlISGwxSTNpNkxqT0EwQTVJZzBseTI2VDdrV0JadVpSVk5ybnEwU3ZqaTRW?=
 =?utf-8?B?ckptTHI4bzJGM0RacU1hLytVYUk4MkJhRkZHbU9KR0dCVWQrV0N4ZVlZcnJ2?=
 =?utf-8?B?UzZXbndQK285eUJBMTB0ODZGdmRCd0pRVG1lN0xGclVEWXpmY3d1VVdFdEJ1?=
 =?utf-8?B?VDZoS3FjRlNRcWRudHFaaGRzQ2NUSHJxanprcXFobVV6c2VFNDZucGZzVmR5?=
 =?utf-8?B?aFJ5OUxIS0I3NUJIWk45YitKeTlEN2dSR2VXVHVKd2RiaEJVR1dJcXdQZm5Y?=
 =?utf-8?B?Z1dSN0RiTXY3Vm1ZcVh5T3lDWUY4eXU3U1crMnVTaXg4Znc5ZjI3NGNPNVNx?=
 =?utf-8?B?ZEtYOTFuTFVwZmlUeWFEL2lkVUpzb05sS1RSbnVMWW4raW9xbmdLNG5xQjBG?=
 =?utf-8?B?UGRHdUhsby9UVlYvV2ExM0plQmRjM0pSNTlaN1FVL1RtY3Z3SFZ2ZDMwMVBa?=
 =?utf-8?Q?F+/DtdN2+JQjVubpz7st2I1W6?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	msch/QTkZXb6xmdtJheAyoTkwHteXu8fPQJ5PZKWy8DdwDZ68StF/Ng1h/oFbo6wmCz3KH3MUTgdOekFY7BfE5ac1T6nAVdNEly7/z8f5lEHWp8TbIhTkl96mSgCjEdj4kl76UshRHH16PcUq2N+h6GmCKGhtCOVRU5Bf9Ldf85/j6pktCWerGv6PxRaxDWVmwbwQdCIENzqYL+iQrYrgouCReUN4Mb/E75L7NDrJiuU2rEfiaOEYroNue/9sHrFxqYlckD50WJQLxukw4N0T2/UKOWxIX+6BCkS8185iY0H9vARUUHsSTo7AZl4WM0y7vBeP1MV9qolAWosPKuGk+fonarHLdL6+dtFySDNryKgAT/045jYIjyZgPaYrBYpvHZaQrz5TUo3YqZ8YaQeqrc8hpaHaVA5wYrE+IfwcbNemq2nxLDapc448jM9gQK0pGVrWJScoiVJ9ifmcS2rP2T/YxfObg1LARwukPzW2vRCAQHs6phZs0ScWWGhIwtzuLDRI+F60fbAD6kKCWZ7tEpgDi4xk9vKRXZSoJ25bjjW4RO2OluWMJCT9eISIGDsNT8LVsb00k2usFzc5w892NNpv+Yr9Z8disbU56mjZfyI8ogJxvg/8WYgy6j1kZ3+
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e42e131-8868-4f2f-7814-08dc1c99676d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 05:00:37.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuXheOv6iaii8yZTPoXri3McnZoLQRPL/ExxPum33fUpzn4ussiZAtWlap9FNeWXkdQ7e/3wEJ93gm81etzo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8424
X-Proofpoint-GUID: 1vz9Y3MM11a-6uiDvXGrZK7oeoAM-A9U
X-Proofpoint-ORIG-GUID: 1vz9Y3MM11a-6uiDvXGrZK7oeoAM-A9U
Content-Type: multipart/mixed;	boundary="_002_PUZPR04MB63168A32AB45E8924B52CBC2817B2PUZPR04MB6316apcp_"
X-Sony-Outbound-GUID: 1vz9Y3MM11a-6uiDvXGrZK7oeoAM-A9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

--_002_PUZPR04MB63168A32AB45E8924B52CBC2817B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

aW5vZGUtPmlfcndzZW0gc2hvdWxkIGJlIGxvY2tlZCB3aGVuIHdyaXRpbmcgZmlsZS4gQnV0IHRo
ZSBsb2NrDQppcyBtaXNzaW5nIHdoZW4gd3JpdGluZyB6ZXJvcyB0byB0aGUgZmlsZSBpbiBleGZh
dF9maWxlX21tYXAoKS4NCg0KRml4ZXM6IDExYTM0N2ZiNmNlZiAoImV4ZmF0OiBjaGFuZ2UgdG8g
Z2V0IGZpbGUgc2l6ZSBmcm9tIERhdGFMZW5ndGgiKQ0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcg
TW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZmlsZS5jIHwgNCArKysr
DQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCBkMjVhOTZhMTQ4YWYuLjQ3M2MxNjQx
ZDUwZCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KKysrIGIvZnMvZXhmYXQvZmlsZS5j
DQpAQCAtNjEzLDcgKzYxMywxMSBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbGVfbW1hcChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQogCQkJc3RhcnQgKyB2bWEt
PnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQpOw0KIA0KIAlpZiAoKHZtYS0+dm1fZmxhZ3MgJiBWTV9X
UklURSkgJiYgZWktPnZhbGlkX3NpemUgPCBlbmQpIHsNCisJCWlmICghaW5vZGVfdHJ5bG9jayhp
bm9kZSkpDQorCQkJcmV0dXJuIC1FQUdBSU47DQorDQogCQlyZXQgPSBleGZhdF9maWxlX3plcm9l
ZF9yYW5nZShmaWxlLCBlaS0+dmFsaWRfc2l6ZSwgZW5kKTsNCisJCWlub2RlX3VubG9jayhpbm9k
ZSk7DQogCQlpZiAocmV0IDwgMCkgew0KIAkJCWV4ZmF0X2Vycihpbm9kZS0+aV9zYiwNCiAJCQkJ
ICAibW1hcDogZmFpbCB0byB6ZXJvIGZyb20gJWxsdSB0byAlbGx1KCVkKSIsDQotLSANCjIuMzQu
MQ0KDQo=

--_002_PUZPR04MB63168A32AB45E8924B52CBC2817B2PUZPR04MB6316apcp_
Content-Type: application/octet-stream;
	name="0001-exfat-fix-file-not-locking-when-writing-zeros-in-exf.patch"
Content-Description: 
 0001-exfat-fix-file-not-locking-when-writing-zeros-in-exf.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-file-not-locking-when-writing-zeros-in-exf.patch";
	size=1126; creation-date="Wed, 24 Jan 2024 04:55:09 GMT";
	modification-date="Wed, 24 Jan 2024 05:00:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlN2Y1OGJhMDU3MmM0ODI3ODgxNmU0NDQ4YmJkYzdjMjVhNTdmMTg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFR1ZSwgMjMgSmFuIDIwMjQgMTc6MTI6NDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBleGZh
dDogZml4IGZpbGUgbm90IGxvY2tpbmcgd2hlbiB3cml0aW5nIHplcm9zIGluCiBleGZhdF9maWxl
X21tYXAoKQoKaW5vZGUtPmlfcndzZW0gc2hvdWxkIGJlIGxvY2tlZCB3aGVuIHdyaXRpbmcgZmls
ZS4gQnV0IHRoZSBsb2NrCmlzIG1pc3Npbmcgd2hlbiB3cml0aW5nIHplcm9zIHRvIHRoZSBmaWxl
IGluIGV4ZmF0X2ZpbGVfbW1hcCgpLgoKRml4ZXM6IDExYTM0N2ZiNmNlZiAoImV4ZmF0OiBjaGFu
Z2UgdG8gZ2V0IGZpbGUgc2l6ZSBmcm9tIERhdGFMZW5ndGgiKQpTaWduZWQtb2ZmLWJ5OiBZdWV6
aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+Ci0tLQogZnMvZXhmYXQvZmlsZS5jIHwgNCAr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jCmluZGV4IGQyNWE5NmExNDhhZi4uNDczYzE2NDFk
NTBkIDEwMDY0NAotLS0gYS9mcy9leGZhdC9maWxlLmMKKysrIGIvZnMvZXhmYXQvZmlsZS5jCkBA
IC02MTMsNyArNjEzLDExIEBAIHN0YXRpYyBpbnQgZXhmYXRfZmlsZV9tbWFwKHN0cnVjdCBmaWxl
ICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKIAkJCXN0YXJ0ICsgdm1hLT52bV9l
bmQgLSB2bWEtPnZtX3N0YXJ0KTsKIAogCWlmICgodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSAm
JiBlaS0+dmFsaWRfc2l6ZSA8IGVuZCkgeworCQlpZiAoIWlub2RlX3RyeWxvY2soaW5vZGUpKQor
CQkJcmV0dXJuIC1FQUdBSU47CisKIAkJcmV0ID0gZXhmYXRfZmlsZV96ZXJvZWRfcmFuZ2UoZmls
ZSwgZWktPnZhbGlkX3NpemUsIGVuZCk7CisJCWlub2RlX3VubG9jayhpbm9kZSk7CiAJCWlmIChy
ZXQgPCAwKSB7CiAJCQlleGZhdF9lcnIoaW5vZGUtPmlfc2IsCiAJCQkJICAibW1hcDogZmFpbCB0
byB6ZXJvIGZyb20gJWxsdSB0byAlbGx1KCVkKSIsCi0tIAoyLjM0LjEKCg==

--_002_PUZPR04MB63168A32AB45E8924B52CBC2817B2PUZPR04MB6316apcp_--

