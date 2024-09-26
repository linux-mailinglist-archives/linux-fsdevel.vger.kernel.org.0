Return-Path: <linux-fsdevel+bounces-30159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1D9872AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE21C22515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00E18593D;
	Thu, 26 Sep 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b9zEWyYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25288136672
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349440; cv=fail; b=d+clFyLbeTrV2+1rc77EztqEDrJHDMG7P9jqE6XO6OaTy2/tCb7aUvfHms7Lk51czNKEMm1Jfl8rIqAPjwfPM1EDSkbC42wkfOnoH4uiDKO/V/hR2L+Q4t6OgR1no1bg9Y3Nob3R7SZuubiF+ONVMRfIpMtzGa2ZsgUBAAD0N8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349440; c=relaxed/simple;
	bh=jp7ZNJj7hmIbIAE2haV1eWBlBggQrK73QIrHwYKSyK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLHCzG6QPaAUPKkbAgJ5YnlS9YeV+ap+uTB2lC/6Qdnec4pnxfbqs2YO4bjlqa7vwQdqo5E+MYOjmAZT91oRQXlxK0BmnDBnUE4YtnyYZnI7M7+W/al7z3IW+5WUvWGzcEh5Icl8DFe+XcBSpY3pVE+1d5hSNRqB+o5gkpIudro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=b9zEWyYu; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhYpdeX+kWzaF4vQq+sE0GBlwppRp+8fvqVz8IIQ/E2yM6nEjnqabBlxwgTh8WnoOk9q23mGYHNjlwcxnPUyn1wKPOFtlJPdirLgv/uDzDn/+PhHe0MW1CxJ8iW361x+TZXqKHc9lTnVlcCyuTv7P4GG8aVVQDGJSf2W9KHXbeaUF9DR/IvqthqECJPlezVXHR9pliJLPsbjK1H0EDp5A5zvgIrRLPhUy+is1ShuHkWnOYwW6XjkD2LrQNx/mqN8L2FizLZjnMkKms7kCbGllwgvh0UR3QByrXIXAtFERC6Q3gmE4oH0D8Qiwps9PSt8Gfq09xzqecobJ3SoeBlVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp7ZNJj7hmIbIAE2haV1eWBlBggQrK73QIrHwYKSyK8=;
 b=fKaqBPdVblGnCXD8eRPUZThvHnW7YUsr8GWftHZwQue5vuB0ryjr+yUK4YP49XyrrRqnBALVDpfhTCgejjIzDLF0PTwXdvf+GI8kbD0D6swSJxJIJf6bbCPpTHnNruXCfyf664aTn8ktN+NEycb5g9V/PtlHUlN0LM2pGSgpyqTxXKscSWRS0FgFcwBMAgL4qTrQsyDLfxW/zfXWANv6m9Fmh3PgmYoCvOrueKblJiU/sxHko/+uKUIe/3ZW2M023xln1tj81b78/7bNGRYR1nuB5tzNXx0A8WSJgpo7wW6I6rLFonc/J0pDl2YaRaB4hPGztIXXnkssjCEmGs9jrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp7ZNJj7hmIbIAE2haV1eWBlBggQrK73QIrHwYKSyK8=;
 b=b9zEWyYuqKujhsExNiDaRmv4AWT4LMHxFF5LaQHkYo5gU9VEvoMnwnQruCYoktuLdy9O8LHMb31jkWHrnGPhyWw64rqDCP76pZWIuAGknsQIhnvZDNTFq+USW5EHKu9fMsuqJkLALi0k5INnzfDanB7/fSWITvFwxATlJ0zWLic=
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM (2603:1096:990:66::7) by
 TYSP153MB1058.APCP153.PROD.OUTLOOK.COM (2603:1096:405:12d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.8; Thu, 26 Sep 2024 11:17:13 +0000
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5]) by JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5%3]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 11:17:13 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Jan Kara <jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Subject: RE: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Topic: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Thread-Index:
 AdsMF7H2pA+A3TMFT7qIn4M6deqPigBk8OQAACP7Z1AACRNwgAABPHQwAAVRWhAAKioFAAAAOOwAAAVcZgAAAaOeAAAAm94AAAPF+pAAAR6dAAAAJY+wAAGPMoAAInJjcAAD3IQAAAO4VNA=
Date: Thu, 26 Sep 2024 11:17:13 +0000
Message-ID:
 <JH0P153MB09996860C90193AB4D293D84D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
References:
 <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3>
 <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3>
 <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=28722232-c1ad-4a44-a138-95f78046aabd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-26T11:08:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0P153MB0999:EE_|TYSP153MB1058:EE_
x-ms-office365-filtering-correlation-id: 78191906-5a33-4914-ba81-08dcde1cc562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bStRWlUvekF1cWJVNXYraFRUa1RkeWJmWkYzNDVJenhCa3d2dDNYSU9PRXNR?=
 =?utf-8?B?RDRZdHl0bTJ1Mmw3cFhEbzZjdVp1M3NJd3dOM2lUZUZKQVpKVkM1Y2JUNnpW?=
 =?utf-8?B?emtNY3NhcE16ZmsxWldMWEtzdlkwRFN0b2tUcUNEY2hBSW5sOVJKL2o3Yk1v?=
 =?utf-8?B?V3Nsa1lrQVpyRCt0ZGtFdC9DdytOUEpEaGZ6a0JEdFdNT1lTYnh1dk0xTTVO?=
 =?utf-8?B?R01xNTNiSVVBMTBlLzdKcGQwNTJwVjd5RWIxa3NiUUk3c2JrekJQcmNWUFV4?=
 =?utf-8?B?RDNDSHpWY216a3Jya0IxbXlBS043TXVjMWlLWUMxa21sZ3h5Rjk5WXhocElZ?=
 =?utf-8?B?MW4yRDNmWHNLUW5wQWxlYXduaEpRZWRObE5WTkdJQWRVc0thQmh1em9Rbk1x?=
 =?utf-8?B?WWczSDNtQWpZdkZDNW1HZFhsb084bituTjZjblpXMi8vUnVBUWIwakpLZXJV?=
 =?utf-8?B?V0hDYm80VlBubWV1RSsxcVhqdE5JYzBGQWJGMm1KRG9XZUlFUVJHUGtPWTFL?=
 =?utf-8?B?ZjdGSXhOSFhLREtSQkhQS3R4VXdyVUtQdFl6ZlZqbzd2WitQQTNkMHRMcmpS?=
 =?utf-8?B?Q3N0SENTTzhtQWZDVkw4RzE3MjJVMGZwKzFIcEsvRXg0VU01M0lvQlRiTzRD?=
 =?utf-8?B?QTlZd0tBSSsrK2ViNG1pcktvREJKQTRjbFpvTnRvdXN0bTlMN0trQ1ZJckNx?=
 =?utf-8?B?U2NnZXk3SHFGQ1lRTk5Kd01ZMXpIOFptaFVqUThvZ2llRTJwejMvVE1xS2po?=
 =?utf-8?B?QktKZkhGemZLbXo0L25VTkZRUzQ1R0l5RGpPSHZRdU5Fb3RkVWZuMFlWL3dB?=
 =?utf-8?B?UStiQm1mRHJMVDBSekNrZ2ZpbC9Wa2dyWWtEcHRjUW5OS2YvNzVoL05UM2U4?=
 =?utf-8?B?MnVISWoyd05JdzcyMUtMN0ZSTFlocm9EUGN4bDROY0o0anVzNFIvVlhPWDA3?=
 =?utf-8?B?NHFCbHBZTGt6YnhQZTdrQmNiNmdmUnRyYVJQUGZaRmNqZjd5R1UycjdQcGdB?=
 =?utf-8?B?VldBSXB3T3lMWHUxZ1k5YVdQUVRYYjZjVHJMMFpwYTV1T1loN09WZTZrd1dM?=
 =?utf-8?B?QjErQkNmc3BYMS9xOEJ3OHlwMUJlZTJFS3QzYjFwV3J1Q2p5MzZOK0xWdm5x?=
 =?utf-8?B?c0NBUUJsYVVBZlNZZDdDdmRTZ0tkRE9EemtHSC9NUHgxSzNYVWxOMnhTQWJS?=
 =?utf-8?B?UFplRDA4WWJFVHJNN2tCSXdEMk1NWDluMnZyZ1I0UzdLOVZWMGFUdnZIUXhY?=
 =?utf-8?B?MWZGN0EzUHg5T0t1QzlBUUlnUTNvMVZjeTJTTEhkRUVzWlVhU3VhSW94dk1r?=
 =?utf-8?B?VnBUemdWOWRQZmExeVcvV05hWU0yS054N2Z1ZCtjR2VUU0RCbyt3M2VaU04x?=
 =?utf-8?B?bE9hZ2JUU1E5NTF5bHNoNHhmUWIrSEVVcHdVdUl6clo4QmxvUnhrcWx4Vkhk?=
 =?utf-8?B?dklIVkkyT1VHa21lbUVVQXl5bnQ1SG16TTlpSDloN0hCeG1reHgvTU0yam5v?=
 =?utf-8?B?TkpkUmd5VmhnRDJuYkxORys2bE9wSUs0cXlBMGtUSnZUdVFDd1RzSFlKd21F?=
 =?utf-8?B?eGNNb29aMExvaG5kV2VqbEtpN25NeXE0cGx4bHY5alRFbEV1K3M4bms5aHIv?=
 =?utf-8?B?QUhWZWMrbE5odHFZUzJQS1d3OEwvZDRDbGgyQ2o0MFpYSllXNTFYM3NUZk9H?=
 =?utf-8?B?ZDJVMVM4VnZ0Ymh6eWEzaHZOb25HNllUcjVrU0orMlFBL2c0eUFJaWhNWSty?=
 =?utf-8?B?NlpSYUVVeS95Z2NMc0pKV2orL0Y0RFU4VXVlZkZ4emRZZkNlOXZOejNLbyt0?=
 =?utf-8?B?aWFBcmI4a3dMTmVJU0VsUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0P153MB0999.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXlGOFhPeCt0OWUwbmJNSTNqVzFyQmIySVZwbml2dmtPVk9aVTVoUmJyREtU?=
 =?utf-8?B?SDJpNjZLK296UC9RU3lzWFZDQzNkQXRTQW9RNTNIZkFCVkp2LzVEeisyZ1hF?=
 =?utf-8?B?d1g0YzhmTUVHY0pkYndmeDdOc3prTlJBbXFZYzFIeUU1eUZNdDdzWkl4T1pr?=
 =?utf-8?B?MXI2T0tSRmliVHJvd1U5T3FZRUVJU3ZqeTF1VzFuL2REd3lmMzJLaU45RUx5?=
 =?utf-8?B?dXRQait4dklWZWEzeWZMekU4UHpHbzlqZ0FDamlmeTY3a1BOU1ByUE5ZcHFT?=
 =?utf-8?B?VUpFS1AyeXp1cDVmaWdEaXp3a2JQMnF1OHgrTiszT1ZrTE5PVStDVkZmaEps?=
 =?utf-8?B?RFJxMmpUZFNZSENmR3g0NVpDUk9VeHd4UnI3VmpyWi94OXV5cW5ZMFFTVFNm?=
 =?utf-8?B?eFBlK3pZSndjaGJxV24wSmJTc0g1c3Zxdlp0MzQrUXNsRmIwQUk5bklYYzda?=
 =?utf-8?B?amRmeVhLaitwNnhxRWpUODh3NWkyd1JyR0F0RUUyRmR3bHBnUDA4bFhFWXZZ?=
 =?utf-8?B?QklFMlJMR2Z3V0NiR3BBS3dNN09FdEgxdmwxdGUxRHdqUTdkNXFnKzgyUkRB?=
 =?utf-8?B?Q1FkVG4yeTBWQlpHMDJDSTk4NUhWOUVFUW5WRnN2dHNaMmYrVE9Nb3pRRDJs?=
 =?utf-8?B?N3g4akkxRjdxVmh6VW9DMUxkYzlyNzlLV3JDcElDbUp1NVJhYmJvMmw3WWk5?=
 =?utf-8?B?bjB2dmlDNDNPdmxBZU92bUZHbDd1SEk0dmluMFJndkJXb2NWLzljcU9sY3pm?=
 =?utf-8?B?Ynh0aDJjQTcvMEQrbjl1RDN2TXJlaWNTakpicVhXL1VTS2tGaDRmaHBvcFhT?=
 =?utf-8?B?bUhYVk9TWnpyOTNoaE9FeDc0Q202N1FNZTJobnlLS1I0aTBpQmpDQzFRZEpY?=
 =?utf-8?B?Rk9nYzNiaXZBcUhaQjFrTWlDS2h2bVlsRk9kVkpSMHkyWldpTFllQnV0amRs?=
 =?utf-8?B?U0ZBS2tSMlVwUmpXQUJpKzR4eXYrZkZyMHpFWWNuWEZmaXV1bWROOHhvOUZr?=
 =?utf-8?B?eUxmSWZxZ3RkQjF0YWlMbzN0MU52STF6VnQzSDdhYVVTa0tmUWN3ZWw4RXRR?=
 =?utf-8?B?NVRLQnpPWWlpUW12K2VFcThwa1kwSlJibXcvMGdmbjFrVVpSeDU0RHRRdDZO?=
 =?utf-8?B?S2o2WGJvSVlrZ3FraERGaWRtN3g2NGNCTmtZUlJ2ckJSa0ZjK3dVbkkwbWV5?=
 =?utf-8?B?WDRXYkxNWUdSSUhpcThHYkJTaElJL3M4V05VUEY2a0FZckZsWCtmU3BrS1Ex?=
 =?utf-8?B?VTlHNzJQSFB6Y2l2TVVJMXJpRDYzQXZnYlBRMUR1c1MwQVBQNFNzeVVaRE42?=
 =?utf-8?B?SHNhb1NNTWg1ZkZSS3BscFY4ZFFpQ2RFSmFRSEhHRGJGUXFPalN6bnkrVllS?=
 =?utf-8?B?dHhkUmJzU0NXeHRta3BVaFBubStBeTU2UkhQZzIxdExIbDJXTW1MZWowRG0r?=
 =?utf-8?B?OVZMcmFRR3MwMExqdXVOdXh4WjJrb3g5Mk5uRndrb3VaZUZ5TjNSNnhMTnNY?=
 =?utf-8?B?S3FnMU52UlNob2FJMTVBYWpiYXpVTy9BWWVuN3MxR3RLeXRJRUdCbUtGNHZn?=
 =?utf-8?B?d2pJbEVwZzhlazFQcENGUGExcS9meldqTHV6RHVWTG85UURYcXlzU1VqK3d2?=
 =?utf-8?B?N3Y0V1duZUlMSDRNS2NoeWR3bGlIbC8zc0NUL3dKdEJUNjhYTnJpTzRPZ2Iy?=
 =?utf-8?B?N1pkUEx3dmV5OTF6SE9DbFR1VHNNZGR3MmFpSGZiVzRvNW43WHB0MEVnYmJR?=
 =?utf-8?B?YWdDbm9YMG82T291dDZVVGhsTVJNR2pQSjBEZXczLzJ0MHpCdDlvR0YrS1FY?=
 =?utf-8?B?L1Frc0M0YXFKMVdZcWltcTRTUm1MV09adE9sREN1MmpKNFdLL1ZLaCtpd09V?=
 =?utf-8?B?OUxQaURFZC9rRE1FZitWL2FQck5QaHkyVmxTZXFwQm1JV254elZNcTR3eFJR?=
 =?utf-8?B?QlRCNTd3OUVpSkNwM0dMZ1hGZThYTUlZRUpGb3FDUkJITk5ORzJTUlk0TGVN?=
 =?utf-8?Q?a2qM4ID4QhnPhXVNcRQfWEqbXRHJek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78191906-5a33-4914-ba81-08dcde1cc562
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 11:17:13.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvFLXx3nzS++OZ6m3TTWjBH6bOPhFksQXhBPwHdUIj3U4x+yTt3O5hRq6qwQd1dGVNjrw9Zynr9HKqhU7EfsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSP153MB1058

SGkgQW1pciwNCg0KWWVzLCBhbmQgbXkgZ3Vlc3MgaXMgdGhhdCB0aGUgTURFIHNvZnR3YXJlIHJ1
bm5pbmcgb24geW91ciBtYWNoaW5lIGhhZCByZWFjdGVkDQpmYW5vdGlmeV9yZWFkKCkgZXJyb3Ig
YXMgYSB0aHJlYXQgYW5kIHJlbW92ZWQgdGhlIC5jb25maWcgZmlsZSwgdGhhdCBpcyB3aHkgaXQg
Y291bGQgbm90IGJlIGZvdW5kIGJ5IHRoZSBvcGVuIHN5c2NhbGw/Pw0KPj4+Pk5vLCB0aGF0IGNh
bid0ICBiZSBiZWNhdXNlIEkgaGF2ZSBwZXJmb3JtZWQgdGhlIGV4ZXJjaXNlcyBieSB1bmluc3Rh
bGxpbmcgTURFIHNvZnR3YXJlIHJ1bm5pbmcgaW4gV1NMKDUuMTUgYW5kIDYuMykuDQoNCkdpdCBj
bG9uZSBzdWNjZWVkcywgYnV0IHRoZSBsaXN0ZW5lciB0ZXJtaW5hdGVzIGFzIHlvdSBzZWUgaW4g
eW91ciBtYWNoaW5lIGluIHN0YW5kYXJkIGxpbnV4LiBJdCBpcyB0aGUgc2FtZSBtYW5pZmVzdGF0
aW9uLg0KDQpJbiBNREUgc29mdHdhcmUsIEZhbm90aWZ5IG1hcmtpbmcgd2FzIGp1c3QgYmVpbmcg
ZG9uZSBvbmx5IHdpdGggQ0xPU0VfV1JJVEUgaW4gbWFzaywgd2hpbGUgdGhlIGV4YW1wbGUgY29k
ZShmYW5vdGlmeSBsaXN0ZW5lcikgd2FzIGhhdmluZyBtYXNrIE9QRU5fUEVSTSB8IENMT1NFX1dS
SVRFLg0KDQpJIHNoYWxsIGluY2x1ZGUgT1BFTl9QRVJNIGluIHRoZSBtYXNrIGluIE1ERSBhbmQg
dGhlbiBpbnZva2UgZ2l0IGNsb25lIGFuZCB0aGVuIHNlZSBpZiBpdCBzdWNjZWVkcy4NCg0KQ2Fu
IHlvdSBleHBsYWluIHRoZSBzaWduaWZpY2FuY2Ugb2YgT1BFTl9QRVJNIGFuZCBpdHMgcmVsYXRp
b24gd2l0aCBDTE9TRV9XUklURSA/DQoNCg0KVGhhbmsgeW91LA0KS3Jpc2huYSBWaXZlaw0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjQgMjo1MiBQTQ0K
VG86IEtyaXNobmEgVml2ZWsgVml0dGEgPGt2aXR0YUBtaWNyb3NvZnQuY29tPg0KQ2M6IEphbiBL
YXJhIDxqYWNrQHN1c2UuY3o+OyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgRXJpYyBW
YW4gSGVuc2JlcmdlbiA8ZXJpY3ZoQGtlcm5lbC5vcmc+OyBMYXRjaGVzYXIgSW9ua292IDxsdWNo
b0Bpb25rb3YubmV0PjsgRG9taW5pcXVlIE1hcnRpbmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3Jn
Pjsgdjlmc0BsaXN0cy5saW51eC5kZXYNClN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBHaXQg
Y2xvbmUgZmFpbHMgaW4gcDkgZmlsZSBzeXN0ZW0gbWFya2VkIHdpdGggRkFOT1RJRlkNCg0KT24g
VGh1LCBTZXAgMjYsIDIwMjQgYXQgOTo0NOKAr0FNIEtyaXNobmEgVml2ZWsgVml0dGEgPGt2aXR0
YUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4NCj4gSGkgQW1pcg0KPg0KPiBUaGFua3MgZm9yIHRo
ZSBvdXRwdXRzLiBGcm9tIHlvdXIgYW5hbHlzaXMsIGl0IGlzIGZvdW5kIHRoYXQgdGhlcmUgYXJl
IHNvbWUgZGVudHJ5IHJlZmVyZW5jZXMgdGhhdCBhcmUgY2F1c2luZyBpc3N1ZXMgaW4gcDkgdG8g
cmVwb3J0IEVOT0VOVCBlcnJvci4NCg0KWWVzLCBhbmQgbXkgZ3Vlc3MgaXMgdGhhdCB0aGUgTURF
IHNvZnR3YXJlIHJ1bm5pbmcgb24geW91ciBtYWNoaW5lIGhhZCByZWFjdGVkDQpmYW5vdGlmeV9y
ZWFkKCkgZXJyb3IgYXMgYSB0aHJlYXQgYW5kIHJlbW92ZWQgdGhlIC5jb25maWcgZmlsZSwgdGhh
dCBpcyB3aHkgaXQgY291bGQgbm90IGJlIGZvdW5kIGJ5IHRoZSBvcGVuIHN5c2NhbGw/Pw0KDQo+
DQo+IEZldyBxdWVzdGlvbnM6DQo+IDEuKSBXaGF0IGlzIHRoZSBrZXJuZWwgdmVyc2lvbiBvZiB5
b3VyIHNldHVwID8NCg0KTGF0ZXN0IHVwc3RyZWFtIG1hc3Rlci4NCg0KPiAyLikgSXMgdGhlcmUg
YW55IGNvbW1hbmQvdG9vbCB0byBjaGVjayB0aGUgbWFya2VkIG1vdW50IHBvaW50cyA/DQo+DQoN
ClllcyBhbmQgbm8uDQpObyAidG9vbCIgdGhhdCBJIGtub3cgb2YsIGJ1dCB0aGUgaW5mb3JtYXRp
b24gaXMgdXN1YWxseSBhdmFpbGFibGUuDQoNClRoZXJlIGlzIGEgd2F5IHRvIGxpc3QgYWxsIHRo
ZSBmYW5vdGlmeSBncm91cCBmZHMgb2YgYSBwcm9jZXNzIG9yIHByb2Nlc3NlczoNCg0Kcm9vdEBr
dm0teGZzdGVzdHM6fiMgbHMgLWwgL3Byb2MvKi9mZC8qIDI+L2Rldi9udWxsIHxncmVwIGZhbm90
aWZ5DQpscnd4LS0tLS0tIDEgcm9vdCByb290IDY0IFNlcCAyNiAwOTowMiAvcHJvYy8xOTI4L2Zk
LzMgLT4gYW5vbl9pbm9kZTpbZmFub3RpZnldDQoNCmFuZCB0aGVyZSBpcyBhIHdheSB0byBsaXN0
IHRoZSBtYXJrcyBzZXQgYnkgdGhpcyBncm91cDoNCg0Kcm9vdEBrdm0teGZzdGVzdHM6fiMgY2F0
IC9wcm9jLzE5MjgvZmRpbmZvLzMNCnBvczogMA0KZmxhZ3M6IDAyMDA0MDAyDQptbnRfaWQ6IDE2
DQppbm86IDIwNTgNCmZhbm90aWZ5IGZsYWdzOjcgZXZlbnQtZmxhZ3M6ODAwMA0KZmFub3RpZnkg
bW50X2lkOjU4IG1mbGFnczowIG1hc2s6NDAwMTAwMDggaWdub3JlZF9tYXNrOjANCg0KbW50X2lk
IGlzIGluIGhleCAoMHg1OCksIHNvIGl0IG5lZWRzIHRvIGJlIHRyYW5zbGF0ZWQgdG8gbW91bnQg
cG9pbnQgbGlrZSB0aGlzOg0KDQpyb290QGt2bS14ZnN0ZXN0czp+IyBjYXQgL3Byb2Mvc2VsZi9t
b3VudGluZm8gfGdyZXAgXiQoKDB4NTgpKQ0KODggMjEgMDozNCAvIC92dG1wIHJ3LHJlbGF0aW1l
IHNoYXJlZDo0NiAtIDlwIHZfdG1wIHJ3LGFjY2Vzcz1jbGllbnQsbXNpemU9MjYyMTQ0LHRyYW5z
PXZpcnRpbw0KDQpGb3IgaW5vZGUgYW5kIHN1cGVyX2Jsb2NrIG1hcmtzLCB0aGUgaWRlbnRpZmll
ciBpcyB0aGUgc3RfZGV2IChhbHNvIGluIGhleCkgc28gc29tZSBtb3JlIGNvbnZlcnNpb25zIGFy
ZSBuZWVkZWQgdG8gbWFwIGl0IHRvIGRldmljZSBudW1iZXIgYXMgMDozNC4NCg0KbHNvZiBkb2Vz
IGNvbWUgdG8gbWluZCBhcyBhIHRvb2wgdGhhdCBjb3VsZCBiZSBlbmhhbmNlZCB0byBwcm92aWRl
IHRoaXMgaW5mb3JtYXRpb24sIGJ1dCBwZXJoYXBzIGEgc3BlY2lhbGl6ZWQgZnNub3RpZnkgdG9v
bCBpcyBpbiBvcmRlci4NCg0KSSBjcmVhdGVkIGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9m
c25vdGlmeS11dGlscyBhIGxvbmcgdGltZSBhZ28gd2l0aCB0aGUgaW50ZW50aW9uIG9mIHdyaXRp
bmcgc29tZSB1c2VmdWwgdG9vbHMsIGJ1dCB0aGF0IG5ldmVyIGhhcHBlbmVkLi4uDQoNCj4gV2hh
dCB3b3VsZCBiZSB0aGUgbmV4dCBzdGVwcyBmb3IgdGhpcyBpbnZlc3RpZ2F0aW9uID8NCj4NCg0K
SSBuZWVkIHRvIGZpbmQgc29tZSB0aW1lIGFuZCB0byBkZWJ1ZyB0aGUgcmVhc29uIGZvciA5cCBv
cGVuIGZhaWx1cmUgc28gd2UgY2FuIG1ha2Ugc3VyZSB0aGUgcHJvYmxlbSBpcyBpbiA5cCBjb2Rl
IGFuZCByZXBvcnQgbW9yZSBkZXRhaWxzIG9mIHRoZSBidWcgdG8gOXAgbWFpbnRhaW5lcnMsIGJ1
dCBzaW5jZSBhIHNpbXBsZSByZXByb2R1Y2VyIGV4aXN0cywgdGhleSBjYW4gYWxzbyB0cnkgdG8g
cmVwcm9kdWNlIHRoZSBpc3N1ZSByaWdodCBub3cuDQoNClRoYW5rcywNCkFtaXIuDQo=

