Return-Path: <linux-fsdevel+bounces-72412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D89CF610E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74B73303369D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 00:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF95464D;
	Tue,  6 Jan 2026 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="miNwb+md"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCE3A1E86
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658590; cv=fail; b=jQbish/Ob66ph65zbUY9uD2ULRmZmd5k0HNsfeTzqD3wFZ1rfhBPyTg/L8gq4zShCas4Jq0IXeOxy0UwgXbigapm2cxeOzJ7dO6b91jeL2gfROiFxLoW4x+2mfFxJ9emMNRRG3wwPXsLUHG+M1xE6kM6gyniPX+GRSInAYSB8ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658590; c=relaxed/simple;
	bh=jjR7Dwo+J1cipVcpiecY1G/WoCzyLZ7+c1+f+YwuskA=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tNOKuyRvI71y6T31PqwC8JUISv54mZVAtLgt0A2cu9DtpCobEv8LEJCI+5O/CEBAyullRVP8ALU5Q3JbLioRGmBawiMjutWlUqULdPGaD9O51QSulSoUDFl9xoGF7dPUNx9LiSFkMvPfYz7mrAusOgCRnrEdJh8lWD8jc08wJgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=miNwb+md; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605JCt1S002516
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Jan 2026 00:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lgAbysg091+/dcPWD57hWj1CZKDgwtrODVEHcrsUGSw=; b=miNwb+md
	bbIuwpDT8k7Tt5gJw687AC7X/Zvm0DbERnpRmGDqAdlI8XMxozvDYyjZnsBFZp+x
	qCFowTpLkqeAaV2a02mGjHsabJ1tzknEg6tzAmk4cIimuoI8ryg1ppxL4YuWJ7eX
	bmC/f/BGzZtqrZ8Xo3rK/f1bj9sIn1Zsjo6L3InC9x2UH6y3Rjb1bh1pFQg6r2fN
	X/Ee1Lh9u/48WiikOSFoxmCmcq7TfnZegEInKfdCXraJJZ+yrw3J2FdNUpuAjcXn
	KGuLPzdlUG00hwOb9UN2K7KZNy8VLvMBlwTx5bSVG6WSv9c9o1o3kWGUYees+iqs
	vQpgHvVJydr07w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshes2cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 00:16:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6060GQWX029483
	for <linux-fsdevel@vger.kernel.org>; Tue, 6 Jan 2026 00:16:26 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshes2ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 00:16:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK+RVND0ykug424dSybe+cFYGhYV0bLbqNICy3KTwHSPc8gn6s1PIuZv8Z6dZx7+kdrg4YzVoqJGiSdMgM5CgwXE5jth2aZAB2fwslfxIOWlTPxlaALBTbU83RjGJeKwJmFtT5L6cLmptZFd2N9vA39YG8EtlN/V/WzYrYEtuj+DswdXmXwvLI3LR8tUvkNoFj1DA2YCG5V+ihfzKzDG+2deIJ8TbMKuXL1jg/X/y5bUQaIUrWUYtICFGqvwH6aqjoyz1RhcsKwLUW6xI+FUost9c2bj5RsmMySIJqlfpCMTtrtp3TRk+el/3uYdpx7mPrSzjGM7B0DTuW+r/vQr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZgHeU1F7Md9fwPn+dWTIHVw3Oou7xjbG6Y8WwTRW+I=;
 b=Q+ZwayHsMZkLAaFoG9Yx23Au+FAHFlfzqTiHgfHCzznEBrZxmKU5ukR2YKS+kMYpaS6oqPo6RG8ZCFc39EvNCmD8xSZyMv1SQGop787s2uRfxn1uSExVkVN3QNLK3rdYBh00Cvp+ywvY9azZjchtcxr0OOy3H+kypoPs9gSc/v9G67dDUeBkVOxNrAVAO5m9hHzR0iwJhkkzmFXGeEzNjfd1xkDrVWYtBfJ7sY0GcLSWM9t+eH4p3vcE1SOpntE3bUZTw4Vzy3S+xZHXAlzaJ8xBt8YtcOu5FtnTxUz9Eo4sYW02txHjFpqfju8ve4V4Bu6Z+HiIxpdcwheG+9YK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5706.namprd15.prod.outlook.com (2603:10b6:806:34c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 00:16:21 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 00:16:21 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: pretend special inodes as regular
 files
Thread-Index: AQHce9D2kdIkTHV0tE2sDEAHzoxWx7VES7sA
Date: Tue, 6 Jan 2026 00:16:21 +0000
Message-ID: <443c081b0d0d116827adfc3eed5bc5cba4cf7f30.camel@ibm.com>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
	 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
	 <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
	 <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
In-Reply-To: <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5706:EE_
x-ms-office365-filtering-correlation-id: ec17f4af-83d0-40a3-3376-08de4cb8d24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVo5R083VzhyRDFlL3NFQ01PSUtlSm5mbktXUmJ0Sm05SXpoellIQjhsM0Rp?=
 =?utf-8?B?Q3EzUE9ERGZTdm16RWJHemZtQ1BSYXNicnZldlpMQXo5S1RNYnNvY3FPV0NE?=
 =?utf-8?B?NHlNYml3em1PTTV5RXJnUFBHbzJqaGhKT0lBK0Z2K3JsTFp4WkZ3YkI4TXdU?=
 =?utf-8?B?bnpXMmErR2x3TVZJT09IdGxwbVFJVUF0Yy9URXdPdzZmeWVFU2ludUdFS1hk?=
 =?utf-8?B?UG5PNWhtK04vQzE3VGRabHhKTmZpMVhqVzgzeGlCQUcwSkhBbkM0clFtOTZV?=
 =?utf-8?B?dVBhclRBNEpOUk5xWGJNdXFRSGhDZXd0WnBzenJvZnFrM0hEOU9yVmpDSUJs?=
 =?utf-8?B?d0s4MWx5WC9VR1IxSVNPRkNzT1AvTDEvMkdCQnNJVW9pUkRXNkI2Skd6WkNp?=
 =?utf-8?B?UXE4MitsZnVURkMrZzRVUEpFY2s0dFRkeFVTMUs2dlpVUHRuaDFFUG9LZkx0?=
 =?utf-8?B?Z3NOR05KVFVFeTVmMVRNV3Y3NzY3TmZ3eldMT0k0MCtkb3VzOVRBZDlvZUJU?=
 =?utf-8?B?OG52NWhNaWFUM0xRcHFpT1REMkpwUjNpbDRxbjhUa2x5azQ2S1JEUWpHTUNk?=
 =?utf-8?B?Sm5oSWZBQm9oTGJEeWVwbDkrYmFtdHZleTVDc24wQm4rVTFUSE1PbngrdVZk?=
 =?utf-8?B?dzduYUtDaUpzZkhjcURNUWhiOTFkVlh6eWJwVW1zVHpQcXh2czFnU0dHa3Fk?=
 =?utf-8?B?MiswdjdmNytjUXlLTTdHeDBXT0h1eXUxejNCWlR3V3JPVzViLzZKdVZFbXpW?=
 =?utf-8?B?MUNwUDNnSndZZWFwaGNlMUY1cHl3YmMxUlFjcWlUZy9JRkRwOXlORkRGb08y?=
 =?utf-8?B?U3p3TXF1ZmQwdzJxdkJqcXhNYW5va3lzekZYejF2cmcrd3Z4WjlrelFqR0Fy?=
 =?utf-8?B?cS9NRWMvQ29DbXZoQlk4S3F4OEJ1U2NYc1g1OFppZVdZaVZNbVRhTkF3QW1a?=
 =?utf-8?B?Ui9JREExZmtqZGJCYVUzVXQ1cFhnR2ZFMEsxZ2tmZnh2NjhUdFFLOGJJY3Fs?=
 =?utf-8?B?RkVTcTNNREVJUHE3MXpuNExRc1hhZ0kwNHdTZFF4Q3lOOGFJVHN2NkgyYUZB?=
 =?utf-8?B?aGl4K1VzcVVja0E4bTIwZ0RhZk5Ob3paeEo4ZThmWllUN3RFNlgwWFlxT1FW?=
 =?utf-8?B?ZzVnTWRIZlhvbWlKSTRNWlQvUDd5UFRXVUxPT3dnVnIzcUpWQmtVbWI0V2Vq?=
 =?utf-8?B?aG1LcC9XUExNVkoyR05XNloxNjhid2w2aitHUmIvTitSbTZ5cG4vUWJwZ3dI?=
 =?utf-8?B?M3RjZ1lBU29kZ3pJamY5cVk3WDgra3gzeGJzMnM2U2I5MEViemR6WDlFWVFR?=
 =?utf-8?B?SFdGblppczQ0MUlFeEdxc2FKaHJsRnlnNE9QSnphcFV6NHZmelJHM2c5eTM3?=
 =?utf-8?B?TXRFWkkyaVI4Q0hueEtaU0hrelAwd3lESFFSeFpPeWxzWFdqSWRXTTdZYzd1?=
 =?utf-8?B?SzFlNytFWUhmeThNd0VVbUlzNlNxNC9lSkNkd2pndXRwNEhCN1NxeU43cytv?=
 =?utf-8?B?ZXlHQXczekJxL0dWU3c3b0ZvbmpVdUVwUkk3eDhMOXZvZ0xqZ3JFcHBEZUc5?=
 =?utf-8?B?bzk3QWU3TEZONVpGSlZ5NzI3SnpJQkhGalloRGN2bi9mV05rOFhpMXEwME9M?=
 =?utf-8?B?UFVnVXVPSW45b0xLdk9VQ0VxN2FNRkVLWGRMYnI4Nk90RnhqUUV3ZWhDVENx?=
 =?utf-8?B?R0ZDN0hIMHRmYWo2T0JaeU13cVBmT2VObU16TDN3bHVkZTVXd0VzVG5PclpZ?=
 =?utf-8?B?QkFaTWhLVGxrRVY2eGI5N0lmLytpaE15a2NtUkxWcFBuaTV1ZXZMMjNjZXVF?=
 =?utf-8?B?R1Z2TGYyL213dTkzeEJpSkF1cC9ZQnlBU2FZbmxZalNXbnRkbTMwUGYyUEY3?=
 =?utf-8?B?WlQ0UmEyelZGcCsxVEYwVFU2YU1WTS9lZHhwell6alVpc3VlbVcxcG5Kbkxn?=
 =?utf-8?B?WlV1UzEvSFFDc0o1UkJ1Ymd4ZFR2VFE0K2pFS1NSeXFTWFk0czJWWVgxdzk1?=
 =?utf-8?B?cFMzZTd3NlpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE1DN0VYZENpeVhDd0VRZ1dMd3VrOXRzYUhoY3JaV1NsNElZazF3c2pZSk5M?=
 =?utf-8?B?dFYvZ1IxMGRNNUNMcmEzYlBiMVY0SnJxNnRkQjhhMVE2NUdxYzc5MEVLaDdy?=
 =?utf-8?B?V2dSdE9iOW41S2NDZlpFM1BOK1IxMDcwMVJqSzdhM1dncHdBK3ZZcG1NQUto?=
 =?utf-8?B?ZzdRd2t6UUdpK1lOaHZCWGdrYlBGMXF1ZlNkWmdCbDdlb0h3MXNZYUx3SHZF?=
 =?utf-8?B?L2NqMmlPMGZFVmFwWDFWc3N1TUlwK1BsZDg4SUl5S0JEaVZYamlDR1ZmN2Jt?=
 =?utf-8?B?b1gzTWQ0NU9MbklZendXUlFRSytNZXorTmdsNW9QZmFrVEo5VGN6bWx4VFBD?=
 =?utf-8?B?RGRXK045YkN6cVlGS0VJNW83bFJQNDJ5TXp5QWdQWnhaUDR6d2xDNVoxSDJH?=
 =?utf-8?B?a2xqQzdMV0tnbE9qZ0hYeWRlUklvZVRONHo2ZFdRZVdZc3JGcmQyYStoTFFk?=
 =?utf-8?B?U0ZDVTJsUGllUVZ3N0VWRkloVUI3U3hhcXJHVC9QUWFOUGFGWDhWL2l4QUNz?=
 =?utf-8?B?N3RyNDMyWUcveEd5a0xDbEo0NC9jdHQwdUs0d3BwcDNzNkRIcVZFZHo1ZGpH?=
 =?utf-8?B?MG5Pd2cwQVI1WXIxMUVCdXlZTGhWTExDb2xSN3M1UGZNbU5PUlRjalp2Q0dp?=
 =?utf-8?B?UTVkbkJueFFDVXUzMUFhVzNmNDc2K29PSWt0VkJxM2FOMVUyS0FTUWY5dyt2?=
 =?utf-8?B?ZzY0WDV6d3E2VDA2M083T3BHQUNXNllHSytIQU41bGVEZWNMZFNRc205Sks2?=
 =?utf-8?B?YUl0eWVTU0VUV1pLTEsyaWVMUUsyWFkvMlU4TXRzZWllZkFya2hueVY5Y3lU?=
 =?utf-8?B?cEp0d0JSc3JjSTJ1SEpkZitQWWZxQjA5b09RZDJWajdBK1BETmFiaDViWnBh?=
 =?utf-8?B?WmlHWXVuZFhQY1JlclhBQ3FBTkV3WW84eWtKVXV0YUNwVWhhYzFWQU5PdUt2?=
 =?utf-8?B?MU5Mck9nekVWR29vYjBSMzRFT0kycEFNRUhwTFlyUW1BN3RITVRtTnVRUi9z?=
 =?utf-8?B?OXJwamhxNFFGZ3VZckJ2dnJjeS9pMVVNS2owQ0kvVGcvK1FUOXRPekUvcWR6?=
 =?utf-8?B?V2lTcjdHZHJ4MWlaWE02QTFqWDZBT1VnUCtZWTluam5ma2JnZVYwV3IzTFBD?=
 =?utf-8?B?cXpQMDByYVo2a3lrVVp5bWZ6Zml3Z3ZzQkUxc21lYWpRZGx0SmtCV2lrOHFI?=
 =?utf-8?B?TjM4REx5UlFlSnMxd04yRVJDVFlUS3lvWHNPWFNjakQ0MnU1Wm05TlFQbmt2?=
 =?utf-8?B?RTh5WXZid2VobEQzQ0lQVnpsTXJyckROVnZkRUhSODNsTThzN2pUd3FET3Z6?=
 =?utf-8?B?TFhTSTg5N3I4aUF3MWV3RGxvdVRKdGFNS0d6MDJ3NzVrRHhleVo2Q0t1dy95?=
 =?utf-8?B?SktlOVF3TDU4R0hpSXNtQkVLZ0hYYitiK3NBOHNTaERscGZpZm9tOVVFb09p?=
 =?utf-8?B?YWd3bkpEWDUyWGRtSFI5MjA1WlNPeUYxdWhrR2xtRXE2U01VdHhIRCtPKzN4?=
 =?utf-8?B?aysrWWhTeVhjTG9mcHNYdjZSVVZnR3BWbkl5M294Vys2RTUvUDU5MmM4OEZU?=
 =?utf-8?B?ZTJxWjFVQ1JPNVBWcHpiQ1U5OGlLbTJzd3FjYWZ6cGdMTkgzaWxZSjc2c3pt?=
 =?utf-8?B?VzAyYmcveWFjOGR4bVlCY3pYVmxHZ1Jzb3pUTGk1N2lUakdIaFJSRVZVdHJE?=
 =?utf-8?B?Ykl2UGtDSWpTOTF5dXVEeXFJb25tVEtYYy9GM0dLNjNoeWNGN3pCL1dtUmly?=
 =?utf-8?B?WWJ2NnBmWUZHZ0RaUkVUUTB6UjBsMGtUeXBTQ2FYN085SWNiSjgrQTNBbktx?=
 =?utf-8?B?LzRXek5OUk94cVR4a0MyczN4ckFTUjVhUUZONDVlZVJHWFdIUlJjSGRWNnM3?=
 =?utf-8?B?bmxobndyQ0lwL1RuOWdzV2xUY1JyQ0JYQUdGc01MekpjQ1lnVkM5VDlWYTRE?=
 =?utf-8?B?MVpiMGljRExLTElQQ0packpYeWVKWWtmdDZNcVFVM05qUnRpdjhaTzE2OUl4?=
 =?utf-8?B?YkQ1cHFad3JDMk9qcDVaR0E0RWM2Tkdmd3U1K3lOWSswZkswUG1ZeDExNG1F?=
 =?utf-8?B?T0dnc3ZvMkMyT0d2RVF6KzZaOERiRmgzSFBxMHNZaUhRaFRka3FFZ05KWXM3?=
 =?utf-8?B?M3RzTzdBZmEzWWRpNE9BRTc0NnFoeE1ENXl1S04vWWh1amVkRi9wVERxbGVz?=
 =?utf-8?B?ek9FaEVJOHBPZE93TDlpTEVMbll2VHdweFp2YjV2dkpVUEgzU0JmS3NzRkNa?=
 =?utf-8?B?V1U1OXhRcTA3MFBvdmdvaFFaS1pTSjZuQmRSRGJaQldHWEtJR25weEcyWWxt?=
 =?utf-8?B?TWNTVkJTQU0rSWpFVGx5TFNzVS9Pc3J5OFJiOTBmcklLeEhHdUd2UmNDV2V4?=
 =?utf-8?Q?e+RRK02mXsfgx0xC6VEQ34fGIEbc689tkKe7c?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec17f4af-83d0-40a3-3376-08de4cb8d24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 00:16:21.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZagjhP7/nt/RStH5m1Wfy/JXcVSKMoDLPCydcglhrgcdoTBrLVeSdY9JUzSMz+ZUhv+SLZ6cDAFkIFLVdo9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5706
X-Proofpoint-GUID: 1xz_sXEv9PKDm4lppy4MYUpaxSJLVW5T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDIwNSBTYWx0ZWRfX0ATGOpEwYp6A
 wy5McsFVsEHGc8l7NR0/8iACWr7IM2WNhTwowGje+TsbTP6UJLd5GtB9VB9yM1xBKD5XwXIlTcM
 +HAkaDXYVtb4WDAncGF8BaD5zofPMNl3TGtfXRrKcb5Uk3G1aRlMn+hRCndUgTqctG/R+vIROmI
 Jl+j6X2si1pXyJoCROfuQtqQRs5XfkhLK6ITZ1TcJsClaQOKudr+bEPYA/+Rb35uDqyEDWeaYT8
 AeFLMcXIsrY0rdEZMuiHBUkoOxMLrEA/H4qyqfguXnEfMeeDiTnyl9fdAQHYnYsf1wo/4yTUytz
 okWBcnZmtfi4lacf1pZ8r6pxTENa7VRpyMaG2mcZqvhMAFC1uD7Lw26Jg4yEsOMBoKRgDWruvs/
 W1Q3kGQsCVCOrLyKAIM5YR5FA8q1GAV8I5WRtxoQTVoiKR24W14s2jyaMu5J86ga2QDU1KP+YkH
 kDqOGX5gOZo/i5PggZg==
X-Proofpoint-ORIG-GUID: 1xz_sXEv9PKDm4lppy4MYUpaxSJLVW5T
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695c545a cx=c_pps
 a=EUTAWq9+kh0QDJjqgNTvsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=E3x-2L7OUUt2cCDIQa0A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15B0F1A884A1C4591EFB361CB1402B5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: pretend special inodes as regular files
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2512120000 definitions=main-2601050205

On Fri, 2026-01-02 at 19:17 +0900, Tetsuo Handa wrote:
> Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
> requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
> S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.
>=20

I assume that we have the same issue for HFS special files too.

> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfsplus/super.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index aaffa9e060a0..82e0bf066e3b 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -52,6 +52,7 @@ static int hfsplus_system_read_inode(struct inode *inod=
e)
>  	default:
>  		return -EIO;
>  	}

Could we add some empty line here?

I think it will be great to have some comment here about why i_mode should =
be
set for special file. Could you please add this comment here?

Thanks,
Slava.

> +	inode->i_mode =3D S_IFREG;
> =20
>  	return 0;
>  }

