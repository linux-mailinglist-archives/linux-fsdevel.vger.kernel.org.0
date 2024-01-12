Return-Path: <linux-fsdevel+bounces-7878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712982C209
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C9A285B18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2BE6E2A0;
	Fri, 12 Jan 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSS+ZeHs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIw76NHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE46DCF0;
	Fri, 12 Jan 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CEY60m016754;
	Fri, 12 Jan 2024 14:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zBHq3PonqWz5QNaTH7QqMuEwVSvESwo7bpJK8m5QGD4=;
 b=YSS+ZeHsVGaydqe1v/DOjQoJsIbKf1ioiPSHONCQ58HNSxXL+K7veviOejGYc4MTB1h9
 GMNP0PMpxFUytZEfL5xnskNLEGU1gsux90D5AJuqQAnaB+aTe21ZJAuX/beA1oF//jnN
 TRmn9bYgg6mCh11nQhzWoxHo7eWIWxuxmH3PB6tkihKSiEAbydB8lv7BC9oO2QJ3JZ4U
 shciUZMIxkq4fVVfincbUqn0Ked70eWKgrH1qP6qRDyeKxksNdknPx7VNVMGG5mqImUP
 A6BcNyHIGH+BQOtGAWl2Ep/MCjrA7YaI9QCP5Ll4T7y2lViEuvC8S2Ng+UgPZTma352r 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk79c81rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:46:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40CDcuEp006721;
	Fri, 12 Jan 2024 14:46:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur8kwnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSgRxLhSsjUYRTlG4hR6eyrYkxu1UM7uFPxDf/4oPjWdmwVrtovzVNAQwt6Oje2is01VIaf/+8EMdYI5gwCH2DuB0AbhR7tEr5A3u6YUUutBfaP05lXE2qAiZa2otMFB0/w+dlQWbxO4DXT6wkVBAys2UAPzIp64YT3lWIVOIKvxBxdyf74+m+4uf9tq9pjFtYY6d1tqu/tkx+gan1uzXL3jnDavlZUdKzcftkAqXPNz9+RcZutn73R5TAi2oAuNzgM0jp2qkvTzPl52AfTbhgbWRoBIPtU+TxjiZGrhrOPOAE6Dh2EpUAFqWJTV+rJ/Bggm5vbnW+vN2pT3hxK8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBHq3PonqWz5QNaTH7QqMuEwVSvESwo7bpJK8m5QGD4=;
 b=dICOegI/VHGwc5o5/D6H8YAA+U+EWHsGRelcuGfvmbeTdfsrYpfZizaHRxfgAPgJX74uFIIu+jVYrGARw8Osfh9NV+qoriHbS1+obD9wJQHowLW5j4U5A3EsJW4ytvLwmCMJcERNNSmEc6TEg1QrzW4mhbUjyuwp9qQ+5DAdcnXYFFlWaxJFZuyg9YCkBH2voKdOboLWAzjAiQGbbGVJKWlZcIPt0CkV1hiD9jMIREww7btiX36HhMbQvwFq3oZtiu2kS2ZA/S/91P76GjeAkjP3uaCPVChGuQcv4OyFr9R1OjU9UEi4/YWQQrsgD6gj0OPJuw773Oh1DhCdPz6WhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBHq3PonqWz5QNaTH7QqMuEwVSvESwo7bpJK8m5QGD4=;
 b=XIw76NHT6gL/55hAdOFHbUtQB55msfoXY2XbQbbM1iYejRCcCcVVpjfr4a+jP6wG0iDCx8Dpv8nJdJPAa2hE00ZoL+Yap+j7yEnhSesurn7WXVkh48SHd1fCTmQdJriMVNWYBvhCHicxNACIdeDSnAsLfcs4mjj0g9JFPrPsi44=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 14:46:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4027:2de1:2be4:d12e%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 14:46:18 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@redhat.com>,
        Jeff
 Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir
 Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 2/2] Create a generic is_dot_dotdot() utility
Thread-Topic: [PATCH v4 2/2] Create a generic is_dot_dotdot() utility
Thread-Index: AQHaRWYaTzsd1+UJE0imqJT2l4RaAw==
Date: Fri, 12 Jan 2024 14:46:18 +0000
Message-ID: <0328112A-378A-4391-B0DD-5274E3AC17E8@oracle.com>
References: 
 <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
 <170440173389.204613.14502976575665083984.stgit@bazille.1015granger.net>
 <CAOQ4uxhCQ2UrMJZCCTdn5=HtEDPV=ibP4XvGgbwVroepFbLk4g@mail.gmail.com>
In-Reply-To: 
 <CAOQ4uxhCQ2UrMJZCCTdn5=HtEDPV=ibP4XvGgbwVroepFbLk4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4818:EE_
x-ms-office365-filtering-correlation-id: 8542ab36-00e8-4437-ed10-08dc137d3ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3M3NG06kKlbY14gUQWnmTqb5wfIUS/MwSpyoA6Y52amAhz9TtbrmA/+GW7ZscKJVCo2i4iL8qfgwDZEepPFAqoM8UCLh0cTzoAqLWTfTk/2AdjoBfGFcKS85Dp4DseIRKKe91tbTFJ+MmTM0RhgGCi41MfcXJalWU6JMT5L1iGZcwDQoSy90qBqVXEMDyPOlQjPR6/cSXguvsfI2xDS9AtOz/7wYSYsTScsBf2SR2lhNgAyPMp1sm/5Nmx+T7/h+jrnv5Foi1AvcdeQXsRSJVi8LZZaMYHfRbYWqiFLzWVNjL5YQXTxIV0CXq3daENph/iPEj2sc5JUdICtIpToZCnGTUYt7h2/x4wTij2MGgqYYIlpc7u+ACDvd8U6IeCuujVMivZgL/cHBrrtypElcoWZC2b7gkB1btnlDdNOz4V4BnZS+IwqxG3/8+/13+rXDM+yU3eIYB8QIC31adBmomln44Y8PvaP0jMW+Le3nMrnapRZ5WNIT4u8mUtyFu+/KRBXWzB+AL4zWXzDHUXQMja4AUmecdCWl5qOvCeHO0qt2TYJqPGQKTGa/XhHuNzS5pvslFC7LuMjSnTlq6M5iYAMhIdj8nLXLOJ5nFsWUFeDPZ+EQmaL+3EHShGKDbEoB9D9B0SlSNz4wk682jFIE7q65pkgF0TGZFwuSWmyOv3U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(6506007)(8676002)(478600001)(8936002)(6916009)(53546011)(91956017)(54906003)(64756008)(6486002)(66446008)(76116006)(66476007)(316002)(66946007)(66556008)(2616005)(26005)(83380400001)(6512007)(2906002)(4326008)(5660300002)(41300700001)(33656002)(38070700009)(36756003)(122000001)(38100700002)(86362001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z2hUY3B2Q3dFTDUvL0xaclZPTk4rY1lTZXcyK0Roa1hVaGVTeW80QkM5dTBl?=
 =?utf-8?B?NXFwK25VandiMzBMYkREOEcxWjlTbmNKVDdHQk9QbFlWM1pPSktZaFVoaGds?=
 =?utf-8?B?a0RsY3ZlWGRrZWQ0c1QwQ1h4ZVE1eGhGaktQOTVPdlg1cnptYnJNZFhhZDVN?=
 =?utf-8?B?YUF1VjRLMml5U0sxamQ5Vk9FT243S09MSEtPanJWL0NzY0U4MURDUDY5d3dY?=
 =?utf-8?B?V0p5S2JKYW8wMVhoV0FhL3YvOWdBd25YT0pWbjFNVTFvRHJSa09MVFJZbVlU?=
 =?utf-8?B?QUlZN1hQU3BaY3FkYkNpWWYwYldyUlhJUUM1bUI1bWN3RHRrSzY2QlBxaUpF?=
 =?utf-8?B?dW9nRFhISUpCenF6cDIvN0RDdnNOZCs3MGxkUVdGenRGMGRYYVNZYlFiODdI?=
 =?utf-8?B?bXBIcXdDTVVtS0JQYXhkTW9wUkQwZW9acktRbVJSUCt2VmRVTExPNkovRGZY?=
 =?utf-8?B?VW5KNDE0ZWM1aW85R21jaHZMMitMdzF6VG0yL2FRYWxYTGJiYkpLZitVY05M?=
 =?utf-8?B?OFZpWnJjZ3dUY0VRek0vQUp0Ymx3QlRyVlVTV0tqa2NRRlp5K1krelVOTTJz?=
 =?utf-8?B?ai95bmx4dEszNklQZm9SV2JSNWlla01qcSs1b28wZHFnays5R3V5YlkrM1JL?=
 =?utf-8?B?UEpRRTV1dFZ4TXZvQ0xVSnJlZzNaR2hBNkYyYnNEL0ZrM0crNzE2NDRLMlBS?=
 =?utf-8?B?U0ErZ05xcGdoSDNLcmNDTUVVNm9GSVR3b1JLTVRPb01VWDZQY21CZnZUSXM4?=
 =?utf-8?B?c2ZFeEovT0dzL2N6TnZpcGVvc3h0Y3FoSXZPVlgzSkhxUHgzREoxRTVsQWwy?=
 =?utf-8?B?SUlTeURFZHRwVEpuYWkyeGRqaS8yeEwwY2FkT2J5V2JXZm1vUkRyY3J6cmZZ?=
 =?utf-8?B?ajZmMkFYZnVaTGREemc3YUtyR2dmWW84djljc0VCWkNhUUU2eGhOanV0QlE2?=
 =?utf-8?B?K0lndWVHQk5mK0g4dFRIMXRZb1BXUzZON1R3TS9VK0l4aEhISDMyNGVXWE9k?=
 =?utf-8?B?NmtIcmJWYjMrcEVSaWJVaVMrRVp3UXVQR0V3em5tZDNoWi84OUtXeTlRMWI5?=
 =?utf-8?B?NDVSVFo1WFBOVUJxeTd2OE04SkJDSTJyVVAzQ1hRNy9DL013QStybkxoVzhj?=
 =?utf-8?B?NFFKODlLLzhZbVk1VlRwd2RkT0c2aFgydjBLR1cyb0Rnc0hkM3pkZThZOUkz?=
 =?utf-8?B?UENmSjVlRnFQZERFdlhMdnBscTZCOUpFMTNoMDQyc0J3WmNSNFA2aWh4VFJJ?=
 =?utf-8?B?OUF6c2dVbGFMSlg1Ri9aZHpoVVhEa3RJY1dxUkYvWFp1a1J5QWVYYkZMcnhs?=
 =?utf-8?B?UmpPN3NUb0pteXRRWkVGOHFqRU1qaGNkUlRxbEFYYUR1TkluZUdZZ1J1WG5u?=
 =?utf-8?B?Q08weEIrU1JCZXp2dlVLdi9CU296RFhRVHlTMmNpZ2RLUzRyRS9mRTFNaFNq?=
 =?utf-8?B?WmxibDk1TExoZHVDWG5aWDhZaHZ6eTVBeHQySFZIZWtGZUlIUmhaV25zUEI0?=
 =?utf-8?B?WlpFenVSWGk0VW01VkE3eEliM09oY2F1NnNmOGRQSXpZUjlhUm5XeTNjaXpx?=
 =?utf-8?B?ckdobU1vQXNqY0VSZnZKTkFWR1FBeko1TXh5MXZKMVlxMnlxbnVyb3FQS0FU?=
 =?utf-8?B?dCttNSt1WklwdkplZDJsZUxwd2FLdExTQmpzeFFibmtQZFdWRGhzRGlhaUF3?=
 =?utf-8?B?MzEvSlN5WXRoK05lZm1TZDUxWFB2OUtuN0szWEc4c09pUVRWMlkwRnA4TUZY?=
 =?utf-8?B?b0FHeUVLUklFeUtkK0tTajNwdzFPUFIxN3dSNkJLbVdNMjVPUFp4bDFVV1A1?=
 =?utf-8?B?MzZZUVZickNrLzJiaHJ0WnBBRzEyMzlUbitxOWhpRm1udyt5a0pQRHFMUXBU?=
 =?utf-8?B?MzZxSUh2Q3pteDhjRGp0TGJ5bDlhTVNUZ0FIYThVT1RZWlYxR0RTYUJma1pO?=
 =?utf-8?B?YzBWQW5iWU1peDhPdFZzOWhkUzROQ3l1T2xFcm82Ym9mYWlYbkdpelVYS2xF?=
 =?utf-8?B?aDRRMG5NZiswclpqaE9KSnROdGE0NDZWQjV3SUNRQ2ZPbXlGdEh6N3NYck44?=
 =?utf-8?B?VEp3TEdQWjJhbmNKUUp3N2diMnB2OEhaZ3ZZUzJlWnJmMlZhOFh1R0c3RVVZ?=
 =?utf-8?B?QWxNeGcxQVhEQ054VEJzZTJGbktzYzJjNkFJUVFJV2FKK1dmUzl5dWE5QXJM?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AD5370D83BDF94C9A0ADAB584FC4F7B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pmy2Mzv519s3UWpwJVcGiUpzfapculpBn+HuBUc0pJEqLuYdXfI0VzDL3TPIAW2GsimA5RQv6J0D5brJhmFFyGjbpKsqCT5f8MGCtXXd6ngAg0edbKYUUqfyHe4tmKvKCp9+FrrDmqZlBbxj8Qpk+/DbaINmx9lfvAaJ80b1xJhiDJ5ZtqCGKS268IS2J4UieHrdrB8XjXjkciMtEgMnQnph/zqEA/cT6X9fkgWh1cAqjYSFmPFlHcMq62UT9vUNYB8yVxrDarAXzjIK+JYJzsLaBryN/O4pRb1B/9J0Aet5KYwX4wuJlasDkqErk4522m0njahrsJsKuKm70ftjBuHFkOjf+qcpXHJUT5mF/os/unF6PZN/YDrEkl14O5t4IMFqe7FXmQmNzeg9T9rFuChIuRqkqcezieeE7UktKw1QO+kyTd2rBU5fuWcpgViHHplAli55Z2zFcTglpTMMGVn9J1U0n6r0bI2BExC61HHIKX1F6BjFYr8Gg5unVKqDgaOzBPHxMZXXuOh+giHhXmXq172ix06rm+B0sdjh76szKxZ+hHDTVAdsnTW8y+pwd8xl4JiIUOoQ7ImcHNKI8SzFoHzmqr9+vnOXXGbjErY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542ab36-00e8-4437-ed10-08dc137d3ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:46:18.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ublw54OETjhIC+0Oab3jLeIyWRZSdyMO1S9pqYOvkaJj4BJWeT9xBHSQoOywjKkbP5lx3sE5Kq+DBra55h4Chw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120115
X-Proofpoint-ORIG-GUID: EXD9jsZT1pwEwEVwWRK6dNCfWmpIUgT2
X-Proofpoint-GUID: EXD9jsZT1pwEwEVwWRK6dNCfWmpIUgT2

DQoNCj4gT24gSmFuIDUsIDIwMjQsIGF0IDI6MzbigK9BTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEphbiA0LCAyMDI0IGF0IDEwOjU1
4oCvUE0gQ2h1Y2sgTGV2ZXIgPGNlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gRnJvbTog
Q2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+PiANCj4+IERlLWR1cGxpY2F0
ZSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5IGluIHNldmVyYWwgcGxhY2VzIGJ5IGhvaXN0aW5nDQo+
PiB0aGUgaXNfZG90X2RvdGRvdCgpIHV0aWxpdHkgZnVuY3Rpb24gaW50byBsaW51eC9mcy5oLg0K
Pj4gDQo+PiBTdWdnZXN0ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
DQo+PiBSZXZpZXdlZC1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4+IFNp
Z25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQo+IA0KPj4g
LS0tDQo+PiBmcy9jcnlwdG8vZm5hbWUuYyAgICB8ICAgIDggKy0tLS0tLS0NCj4+IGZzL2Vjcnlw
dGZzL2NyeXB0by5jIHwgICAxMCAtLS0tLS0tLS0tDQo+PiBmcy9leHBvcnRmcy9leHBmcy5jICB8
ICAgIDQgKy0tLQ0KPj4gZnMvZjJmcy9mMmZzLmggICAgICAgfCAgIDExIC0tLS0tLS0tLS0tDQo+
PiBmcy9uYW1laS5jICAgICAgICAgICB8ICAgIDYgKystLS0tDQo+PiBpbmNsdWRlL2xpbnV4L2Zz
LmggICB8ICAgMTMgKysrKysrKysrKysrKw0KPj4gNiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2NyeXB0by9m
bmFtZS5jIGIvZnMvY3J5cHRvL2ZuYW1lLmMNCj4+IGluZGV4IDdiM2ZjMTg5NTkzYS4uMGFkNTJm
YmU1MWM5IDEwMDY0NA0KPj4gLS0tIGEvZnMvY3J5cHRvL2ZuYW1lLmMNCj4+ICsrKyBiL2ZzL2Ny
eXB0by9mbmFtZS5jDQo+PiBAQCAtNzQsMTMgKzc0LDcgQEAgc3RydWN0IGZzY3J5cHRfbm9rZXlf
bmFtZSB7DQo+PiANCj4+IHN0YXRpYyBpbmxpbmUgYm9vbCBmc2NyeXB0X2lzX2RvdF9kb3Rkb3Qo
Y29uc3Qgc3RydWN0IHFzdHIgKnN0cikNCj4+IHsNCj4+IC0gICAgICAgaWYgKHN0ci0+bGVuID09
IDEgJiYgc3RyLT5uYW1lWzBdID09ICcuJykNCj4+IC0gICAgICAgICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4+IC0NCj4+IC0gICAgICAgaWYgKHN0ci0+bGVuID09IDIgJiYgc3RyLT5uYW1lWzBdID09
ICcuJyAmJiBzdHItPm5hbWVbMV0gPT0gJy4nKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiB0
cnVlOw0KPj4gLQ0KPj4gLSAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgICAgIHJldHVybiBp
c19kb3RfZG90ZG90KHN0ci0+bmFtZSwgc3RyLT5sZW4pOw0KPj4gfQ0KPj4gDQo+PiAvKioNCj4+
IGRpZmYgLS1naXQgYS9mcy9lY3J5cHRmcy9jcnlwdG8uYyBiL2ZzL2VjcnlwdGZzL2NyeXB0by5j
DQo+PiBpbmRleCAwM2JkNTUwNjlkODYuLjJmZTBmM2FmMWEwOCAxMDA2NDQNCj4+IC0tLSBhL2Zz
L2VjcnlwdGZzL2NyeXB0by5jDQo+PiArKysgYi9mcy9lY3J5cHRmcy9jcnlwdG8uYw0KPj4gQEAg
LTE5NDksMTYgKzE5NDksNiBAQCBpbnQgZWNyeXB0ZnNfZW5jcnlwdF9hbmRfZW5jb2RlX2ZpbGVu
YW1lKA0KPj4gICAgICAgIHJldHVybiByYzsNCj4+IH0NCj4+IA0KPj4gLXN0YXRpYyBib29sIGlz
X2RvdF9kb3Rkb3QoY29uc3QgY2hhciAqbmFtZSwgc2l6ZV90IG5hbWVfc2l6ZSkNCj4+IC17DQo+
PiAtICAgICAgIGlmIChuYW1lX3NpemUgPT0gMSAmJiBuYW1lWzBdID09ICcuJykNCj4+IC0gICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+IC0gICAgICAgZWxzZSBpZiAobmFtZV9zaXplID09
IDIgJiYgbmFtZVswXSA9PSAnLicgJiYgbmFtZVsxXSA9PSAnLicpDQo+PiAtICAgICAgICAgICAg
ICAgcmV0dXJuIHRydWU7DQo+PiAtDQo+PiAtICAgICAgIHJldHVybiBmYWxzZTsNCj4+IC19DQo+
PiAtDQo+PiAvKioNCj4+ICAqIGVjcnlwdGZzX2RlY29kZV9hbmRfZGVjcnlwdF9maWxlbmFtZSAt
IGNvbnZlcnRzIHRoZSBlbmNvZGVkIGNpcGhlciB0ZXh0IG5hbWUgdG8gZGVjb2RlZCBwbGFpbnRl
eHQNCj4+ICAqIEBwbGFpbnRleHRfbmFtZTogVGhlIHBsYWludGV4dCBuYW1lDQo+PiBkaWZmIC0t
Z2l0IGEvZnMvZXhwb3J0ZnMvZXhwZnMuYyBiL2ZzL2V4cG9ydGZzL2V4cGZzLmMNCj4+IGluZGV4
IDg0YWY1OGVhZjJjYS4uMDdlYTNkNjJiMjk4IDEwMDY0NA0KPj4gLS0tIGEvZnMvZXhwb3J0ZnMv
ZXhwZnMuYw0KPj4gKysrIGIvZnMvZXhwb3J0ZnMvZXhwZnMuYw0KPj4gQEAgLTI1NSw5ICsyNTUs
NyBAQCBzdGF0aWMgYm9vbCBmaWxsZGlyX29uZShzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwgY29u
c3QgY2hhciAqbmFtZSwgaW50IGxlbiwNCj4+ICAgICAgICAgICAgICAgIGNvbnRhaW5lcl9vZihj
dHgsIHN0cnVjdCBnZXRkZW50c19jYWxsYmFjaywgY3R4KTsNCj4+IA0KPj4gICAgICAgIGJ1Zi0+
c2VxdWVuY2UrKzsNCj4+IC0gICAgICAgLyogSWdub3JlIHRoZSAnLicgYW5kICcuLicgZW50cmll
cyAqLw0KPj4gLSAgICAgICBpZiAoKGxlbiA+IDIgfHwgbmFtZVswXSAhPSAnLicgfHwgKGxlbiA9
PSAyICYmIG5hbWVbMV0gIT0gJy4nKSkgJiYNCj4+IC0gICAgICAgICAgIGJ1Zi0+aW5vID09IGlu
byAmJiBsZW4gPD0gTkFNRV9NQVgpIHsNCj4+ICsgICAgICAgaWYgKGJ1Zi0+aW5vID09IGlubyAm
JiBsZW4gPD0gTkFNRV9NQVggJiYgIWlzX2RvdF9kb3Rkb3QobmFtZSwgbGVuKSkgew0KPj4gICAg
ICAgICAgICAgICAgbWVtY3B5KGJ1Zi0+bmFtZSwgbmFtZSwgbGVuKTsNCj4+ICAgICAgICAgICAg
ICAgIGJ1Zi0+bmFtZVtsZW5dID0gJ1wwJzsNCj4+ICAgICAgICAgICAgICAgIGJ1Zi0+Zm91bmQg
PSAxOw0KPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZjJmcy5oIGIvZnMvZjJmcy9mMmZzLmgNCj4+
IGluZGV4IDkwNDNjZWRmYTEyYi4uMzIyYTNiOGEzNTMzIDEwMDY0NA0KPj4gLS0tIGEvZnMvZjJm
cy9mMmZzLmgNCj4+ICsrKyBiL2ZzL2YyZnMvZjJmcy5oDQo+PiBAQCAtMzM2OCwxNyArMzM2OCw2
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBmMmZzX2NwX2Vycm9yKHN0cnVjdCBmMmZzX3NiX2luZm8g
KnNiaSkNCj4+ICAgICAgICByZXR1cm4gaXNfc2V0X2NrcHRfZmxhZ3Moc2JpLCBDUF9FUlJPUl9G
TEFHKTsNCj4+IH0NCj4+IA0KPj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBpc19kb3RfZG90ZG90KGNv
bnN0IHU4ICpuYW1lLCBzaXplX3QgbGVuKQ0KPj4gLXsNCj4+IC0gICAgICAgaWYgKGxlbiA9PSAx
ICYmIG5hbWVbMF0gPT0gJy4nKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4g
LQ0KPj4gLSAgICAgICBpZiAobGVuID09IDIgJiYgbmFtZVswXSA9PSAnLicgJiYgbmFtZVsxXSA9
PSAnLicpDQo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAtDQo+PiAtICAgICAg
IHJldHVybiBmYWxzZTsNCj4+IC19DQo+PiAtDQo+PiBzdGF0aWMgaW5saW5lIHZvaWQgKmYyZnNf
a21hbGxvYyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzaXplX3Qgc2l6ZSwgZ2ZwX3QgZmxhZ3MpDQo+PiB7DQo+PiBk
aWZmIC0tZ2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMNCj4+IGluZGV4IDcxYzEzYjI5OTBi
NC4uMjM4NmE3MDY2N2ZhIDEwMDY0NA0KPj4gLS0tIGEvZnMvbmFtZWkuYw0KPj4gKysrIGIvZnMv
bmFtZWkuYw0KPj4gQEAgLTI2NjcsMTAgKzI2NjcsOCBAQCBzdGF0aWMgaW50IGxvb2t1cF9vbmVf
Y29tbW9uKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KPj4gICAgICAgIGlmICghbGVuKQ0KPj4g
ICAgICAgICAgICAgICAgcmV0dXJuIC1FQUNDRVM7DQo+PiANCj4+IC0gICAgICAgaWYgKHVubGlr
ZWx5KG5hbWVbMF0gPT0gJy4nKSkgew0KPj4gLSAgICAgICAgICAgICAgIGlmIChsZW4gPCAyIHx8
IChsZW4gPT0gMiAmJiBuYW1lWzFdID09ICcuJykpDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVBQ0NFUzsNCj4+IC0gICAgICAgfQ0KPj4gKyAgICAgICBpZiAoaXNfZG90X2Rv
dGRvdChuYW1lLCBsZW4pKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUFDQ0VTOw0KPj4g
DQo+PiAgICAgICAgd2hpbGUgKGxlbi0tKSB7DQo+PiAgICAgICAgICAgICAgICB1bnNpZ25lZCBp
bnQgYyA9ICooY29uc3QgdW5zaWduZWQgY2hhciAqKW5hbWUrKzsNCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4IDk4YjdhN2E4
YzQyZS4uNTNkZDU4YTkwN2UwIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+
PiArKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IEBAIC0yODQ2LDYgKzI4NDYsMTkgQEAgZXh0
ZXJuIGJvb2wgcGF0aF9pc191bmRlcihjb25zdCBzdHJ1Y3QgcGF0aCAqLCBjb25zdCBzdHJ1Y3Qg
cGF0aCAqKTsNCj4+IA0KPj4gZXh0ZXJuIGNoYXIgKmZpbGVfcGF0aChzdHJ1Y3QgZmlsZSAqLCBj
aGFyICosIGludCk7DQo+PiANCj4+ICsvKioNCj4+ICsgKiBpc19kb3RfZG90ZG90IC0gcmV0dXJu
cyB0cnVlIG9ubHkgaWYgQG5hbWUgaXMgIi4iIG9yICIuLiINCj4+ICsgKiBAbmFtZTogZmlsZSBu
YW1lIHRvIGNoZWNrDQo+PiArICogQGxlbjogbGVuZ3RoIG9mIGZpbGUgbmFtZSwgaW4gYnl0ZXMN
Cj4+ICsgKg0KPj4gKyAqIENvZGVkIGZvciBlZmZpY2llbmN5Lg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyBpbmxpbmUgYm9vbCBpc19kb3RfZG90ZG90KGNvbnN0IGNoYXIgKm5hbWUsIHNpemVfdCBsZW4p
DQo+PiArew0KPj4gKyAgICAgICByZXR1cm4gbGVuICYmIHVubGlrZWx5KG5hbWVbMF0gPT0gJy4n
KSAmJg0KPj4gKyAgICAgICAgICAgICAgIChsZW4gPCAyIHx8IChsZW4gPT0gMiAmJiBuYW1lWzFd
ID09ICcuJykpOw0KPj4gK30NCj4+ICsNCj4gDQo+IExvb2tpbmcgYmFjayBhdCB0aGUgdmVyc2lv
biB0aGF0IEkgc3VnZ2VzdGVkLCAobGVuIDwgMg0KPiBoZXJlIGlzIHNpbGx5IGFuZCBzaG91bGQg
YmUgKGxlbiA9PSAxIHx8IC4uLg0KPiANCj4gQnV0IGxldCdzIHdhaXQgZm9yIGlucHV0cyBmcm9t
IG90aGVyIGRldmVsb3BlcnMgb24gdGhpcyBoZWxwZXIsDQo+IGVzcGVjaWFsbHkgQWwuDQoNCkFs
LCBhbnkgY29tbWVudHMgb24gdGhpcyBjbGVhbi11cCA/DQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

