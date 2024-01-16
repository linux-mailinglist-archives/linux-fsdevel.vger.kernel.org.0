Return-Path: <linux-fsdevel+bounces-8063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FA82F10E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C83B2304C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA831BF4C;
	Tue, 16 Jan 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZucDhAi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jMv16cCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78E1BF41;
	Tue, 16 Jan 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GCuo5l029679;
	Tue, 16 Jan 2024 15:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5rM0zxhTYOnEicKZvlAB4dYVDZhfGu3lgh4nzUX3DAo=;
 b=TZucDhAiKEroCjcPtbGw4/udTOAbCHkwhSkR4ptY53sPrFpFRf4FosxIq4wbWLjTY2CC
 iWZapnozKq006YZKicTCBZJZVfI+DNFVfzFb4C4LmcfYofScj9lcQdXDJ4TNla+uU7aN
 Syd5i4uHUpSRU1B/GnL53UYhSYRlHDecEoK7nuiDNBhyXN+wJACcC2YmmjJgRvEoxYFn
 vNXPa205W+jnQ4VSU2k5Y7IFcHpCqtrFbPbc88uV+wC4yiJf+t5Xh+ZCQaVHDgVsQ+qr
 ihpZ5AkLlxG8nlQbuuR2s9pBx6JTCxUrk2AyTE7x1ZBlGJAjQi+bXH1xJZPHflfBqRQM ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u529j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 15:08:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40GE2KRo024897;
	Tue, 16 Jan 2024 15:08:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy8ayg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 15:08:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvO3UT0TIq+f3qJYqnIOoq2SAhYzPzNooV6mlzQ3l+qSPnTPmFDpXenS/1vXB7yrjacbw4co6g+cowK+f7YzKa8MCDLQ4Lads/2XMqCkNpfiEt2HYwM4xpjKsvsN6FRTKpZSXpObvE8EzKUglRMTzaMD789++UJD6iaeNSyJahZaY/Vs8DX8tMDxLfIZHOaNLyVrO3RMZytbZWAVMqKSt8I6uOH1qN9gSR01IA8Xxmz86wPWBzkMENC1LPQOTB8xwAy/qGnpM2Ad4PcAcDfnHGHuFhFXg0Kx+1E7mcgoOrISnRgxIktXFLSj4kIDku0c6jSZUAbltKzYJloL3cJ41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rM0zxhTYOnEicKZvlAB4dYVDZhfGu3lgh4nzUX3DAo=;
 b=nCIGpu3gHc3RIEZd7A8/O19D74MC74/SRBp7+E9wutvkbpMY+ElJ5jzzLPa/d9/Lvr0igTKzocnhqZ5GgBxp5/EJK6eskzrZvY0qj1XeWZ8jL4InVIlVgZKrV+MDhLLZMb0HVZXYbH4YOu/C01AuhipFMTeqGg1Dpj2Jcu9Ol8R1gVTKQ6B3HZ5VH2kkYPmT3yvhZJ7YX5bSMZy/bmR2b29Q2kUlhq/Na8U99j7ME/JkAOU6Kyv45T0e2RGFHDYn3bnsXk8AF7OjblKwcjj6aP9QxOrhHQ82hxdFiHZY4fUrVoGp9U9PUw1yjaIUsuLmlMHi0oFA9CKyVpAAu6EKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rM0zxhTYOnEicKZvlAB4dYVDZhfGu3lgh4nzUX3DAo=;
 b=jMv16cCk9lLXRZgrNNJ5dX98811XYTQaq9ZSLD+OMNv526/d8HRf7JX5dT9fsSsKJBQ7BtjASYbzddZAnb+Kc40C8LUiBOVoVKdYFza24085vS63TMO8CQz8U2NtSWVUPx2LwSaa6/TerJSidVkbJJMPy7YGBV5riyL+8PkkwMs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 15:07:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7602:61fe:ec7f:2d6f%5]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 15:07:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: syzbot <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>,
        Christian
 Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel
	<linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at
 (4)
Thread-Topic: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at
 (4)
Thread-Index: AQHaRtJ5hUKp+hXs9Em4vbPVFPTeFbDcjeEA
Date: Tue, 16 Jan 2024 15:07:56 +0000
Message-ID: <B4A8D625-6997-49C8-B105-B2DCFE8C6DDA@oracle.com>
References: <000000000000e3d83a060ee5285a@google.com>
In-Reply-To: <000000000000e3d83a060ee5285a@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5833:EE_
x-ms-office365-filtering-correlation-id: 4ead560d-c78d-416e-7141-08dc16a4ec0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 b0FjroVgmwd7WRHC8QIyl2E8aTKDoHA9czMLx82gj9rVoxwFWa9+omwTaVuhX1sxnyEPqIKeMbTuDGHViRsc4gXXjb+lwj36ppA38edh2LRospIjviOvW62zoHcIan3TIC9ksztSXdh0+nuoujPIlVKwLy3JDl68dRhcxjnB7Al2S/kX0SAHQPr9sHiw2FCm7aBEJ8SuV8gycB0xZQAC/vvPCEWqIQg/uf1GBaDatgUUTgf9p9ySJ8Hm4sjLvYgp8UsCHhTAWBySY3G00U4+zMoYffcQy5J1Hvbr9tyI58Cxw6Vca6uY4aS47YgKLkS4yKY6VYLl3/+7fXEhhXs74unOxFyZQAk5LnYzI+ZtlQOUxGOkmgSsFgVoKUiZJq2CwBsB3Q0hs39a+xrAZr6Vk0rDG2R3Ggnnga/2rhQ+z0LE/0Y7lUhsa2S14kgi1UnJ64Ti9AZQgu4zJ8wijKasxSF9GBcDYlG6kf8XxPDN7CXNe6vn/g3hYxCYsY4wA8FTAdImNSPianheoFlYFdwZdiu6w1r02oK7Zk88c6CIaE3kY3aNE5vOSsFp7xa2l+5HALS+qC4zAIEo3fIiPjhtItUW/r7dW01yUljizOg+qlp3D/z8Wbo7o2bZoBnk0MIDorPsEUKTq40cRMADGe0x9WzTeLWqZcO51D5FyjWNMfr+Mvoqk7EwE7B8khtiYzUG08sk4LtHwKJ/m/AY3r+oSCA43xea8ouWzuNDEEOUWsA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(86362001)(478600001)(966005)(6486002)(38070700009)(36756003)(33656002)(53546011)(26005)(83380400001)(2616005)(71200400001)(8936002)(2906002)(4326008)(8676002)(5660300002)(6512007)(6506007)(6916009)(38100700002)(41300700001)(66476007)(122000001)(64756008)(66556008)(54906003)(316002)(91956017)(66946007)(76116006)(66446008)(99710200001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mll1d2U1ZWZ5Y1puRm9YUFF4WGRhTHBKeGxleUozMXZObmJqOHUzalRNc2t0?=
 =?utf-8?B?a09lTGlOdnJMMGVzZlVRS2VCN2k0OXM0Skd3ZUptOTE3YTRlVE1zaUdaUFpK?=
 =?utf-8?B?VVFrZU1HL0gxYkpVUU5HNXowZWk1eVRRdXVRUUQ5c3VjQUlNRjRJVmhLcENG?=
 =?utf-8?B?TkRSYk9wMmhvZFNhR042aXlBUnRiR3RTeVNiL3p4WkVBS0FsRWRKM2dzOVNZ?=
 =?utf-8?B?dGNwVkdqa1h4OVNJZkkybGM1bHJFR3NFcEgyVWdoRUxlUXFpT283S3JkdnJk?=
 =?utf-8?B?TVJ2WmtCNnlpYnU3dS9yaFBIV0ZWNDZhWmdwRjM5Z2toSCt1NU9LaVBGY056?=
 =?utf-8?B?L2kyQW1RZTBOWUp6Rkk0dXd2eExnUFJmd2RsYnFHL1lhcXluRlVzSk5NLzRq?=
 =?utf-8?B?OUNvaXFrbDZ3amFwUHV0VU8zdDI2QlkzZG5wU2ZCZUt6RGFuZStWRUQ5WFJp?=
 =?utf-8?B?cDY0SVhsaEt5V2VPT2dmNEIxcFI1MjN4SVRMN1lxanVTOW9WYVlSc2pKR0l4?=
 =?utf-8?B?NkhlYkhDVlI4ZWp0SXdDTUNBSVlGY0R0L2xXdFp3dTVOdDhhU0hsZG8zRklI?=
 =?utf-8?B?QkQ0U25HUEU2dWozQjZleXR0bDFhTko4V1VDVWJoZVZvTUJldGpMejByRm5a?=
 =?utf-8?B?c0I3elJ6UmpDVmZVTHUvZWhHUWVOeFkrZ3ZHbk1qRFJ5TmVoN0VjczdZU2dw?=
 =?utf-8?B?T3lGendQQmd6SFpLci9YaFBxTFc0L3Y0S29POVZhRE9Qd1VNdE5MSlRzVnRL?=
 =?utf-8?B?c0ZTRDBDVStzV2ZjU25RQm5mKzNnaS8rZFJ5R0xrMzUvY1BicEZFM3BodHBT?=
 =?utf-8?B?SVcwN21VdWpGK0NTV2NNeFE5YjJMVHFncmdNaEgySC9xVnpZWW9scFNqOFJE?=
 =?utf-8?B?QlRPNmoyKzFjRGFNamJtcmg1QmNBTER6eVhtaFpHcnMyenRrcDJ6bmN4VGxz?=
 =?utf-8?B?RWtLNURGUXpyQjNNdlB2OUZaSWFHS01BZXZtSVJteW9aRzk4dmhlNW85WHRm?=
 =?utf-8?B?K0Z5Wlh6dnlUSWYxaHNLVWdueXdqRkg1Q0p2YWR4d0VtVXdTV0I2YTNqSVly?=
 =?utf-8?B?NlV2RmplekdweDcxaVFQWnlPZUFyN05RbEY1QnpSWE5kZWx3cVdyUzNUQTlF?=
 =?utf-8?B?NmdwOTIzbmdDOURYV0dwRlltb0ZJemhXMWFsYzFCT0pQamJZdms3UFNrNSt2?=
 =?utf-8?B?Q1lXVHFhamRqekEvQ2cxQkVaWmJhNFcybFRiNFlwUG5MMENxWmRJMml3QVBk?=
 =?utf-8?B?NW9WTk9tcjY1bzBRQkkwM1YySVgxOFBDNUpkSzE1ekIwVFVVcVV4MmI2Q1Jr?=
 =?utf-8?B?ajRiRXBqM2hpZWFHUGplYVFDVUlPd0hSKzA0cmlsd2dBQzRQdDZKUWd0aGhn?=
 =?utf-8?B?YkZ3aFhZN2IvRjV5NVdCek1mMzdPb25JUHk5bGp0K0drTFdEbmNHLzRQMzVv?=
 =?utf-8?B?MVRQUVk1WVZva2R4QlVwVnduSWtQR2F3MW5PSWYvcEUycmdRYStVbldDSGZU?=
 =?utf-8?B?UEpvRmNOL1NHeVJUa2l2cC9UNHVsdkVvT1JIVm1PTVFyaVZRbGNOOXFVMlNl?=
 =?utf-8?B?cHNaVWQ0VHZWeWpvd3BSQmszMEFLODhyc0JYMXNNM0VGblN4M25Tb0xoY0t6?=
 =?utf-8?B?bUVMaG1DTExPVnF2U3psUkd2YkpqK2c4T2NEZ0dxQTFZRXZMT0V6WHdFTmRi?=
 =?utf-8?B?SVJubnVpZW1LbURteCt1azhuUDVJT1AyMFlzMk5HcXJBYWNwNTE1WEFNZEp2?=
 =?utf-8?B?QThBQ2JvYmIvdWV5cW5xSXVPZzA0c2FyMTEzVGMwYnJpQkVYczFXYVZndzNV?=
 =?utf-8?B?dkRHQ0lsK1Jla2Nqb216NGJCRzBocDN3dUZ2SklLRWg4bEpxWGg5WHN6Y3R4?=
 =?utf-8?B?Nll1NldZeDdaUzlrWHFYQzBRWGtsRnRLWEp2MS9nbk9tZ1pNQ2xUNG45NGVP?=
 =?utf-8?B?QWNrNndKdDdLS0laZ3dWb09qYVlDVEpieGFlTnZGNlIwN3BLMDFGT0hINTBD?=
 =?utf-8?B?WlkwTG5jdEwvalhBTUlnQnFyOHljZ1ZSaG5jNDVqVGNkbVdZUXl2QStaU2FF?=
 =?utf-8?B?ejhpZ2hVMW5TUTRUTm4zdU1lS2VrMktzQndSVkdNN0cyRUdkazhQZEY2L25h?=
 =?utf-8?B?ZnhicU1kSDk5NUYzQmQrbGRBQjVna2h2dkxlRVJvVGdFZFd2Sm04QVN5b0dv?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <414FC69E016E8F4B826743600E2F85CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d4Gnw8lTFEdmB6Q6lqn2ZgXPmD9Rb69wTVWNdoDdZ82vH9rhcUkYTj2f5Nc8SvNozSnj/2voEyaeLBZAIGNOn9sq0vwSFrWHDXVD7m6WxU0J1SQoX/F9yWmjIIAr+83s0WHkEI7rwPqTsgCef6hX8OSk6jo/czCCHPXlPjZcf1JlaVXgs4tJo2s+S4OFgjyKdcupggnB++4b/EESDGp/Fx2mHGyaHs3QpMR+nOFCWbdm0BpiGhzxPK/OPC3QkNfFZBqkNLed8Uzkq3lUECOcFSmUWnNSYAEzJglmz5XHJMS74ouO1+KUHFaPrhxn8t0cDitPzqeeUenUB8SWRzT6lrkTjgCZOBerMtkk7jCbs0W5fkj41Oh8upNND1hLHnU5DPvMaD/HP89DxUmfKKMIo0WQth7IHYV9AVdJIblb0Iur/EPJIVGex/An27i7wiGZZNOZyshSB2MrQrvzkpowhWnBXLTT44ztwHgkb2tF+JfjxPQq4QmmyTNCRo4TAzYn6LA5zTHC+gIyPbRxPGbGqx1cflV/kFrd3er15te/Mrwrkyjlqp3W7r4eWBRJYUnN0DdunC3LWwJZyxo8jQv7SyYTethmCBigz1QwJc3Ir0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ead560d-c78d-416e-7141-08dc16a4ec0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 15:07:56.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uK88B+NjY74gVInlJIY4UOEGNfEfWCXq7ItjuRqSs5AnFUcubBzC8rubwcNVPxtcUcHiGreA3xX5XarP+qZCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_08,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160118
X-Proofpoint-ORIG-GUID: VObDVK5JYCD3T_ONPt04TImD0DfFm69o
X-Proofpoint-GUID: VObDVK5JYCD3T_ONPt04TImD0DfFm69o

DQoNCj4gT24gSmFuIDE0LCAyMDI0LCBhdCA1OjE04oCvQU0sIHN5emJvdCA8c3l6Ym90KzA5YjM0
OWIzMDY2YzJlMGIxZTk2QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SGVsbG8sDQo+IA0KPiBzeXpib3QgZm91bmQgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoNCj4gDQo+
IEhFQUQgY29tbWl0OiAgICA4NjFkZWFjM2IwOTIgTGludXggNi43LXJjNw0KPiBnaXQgdHJlZTog
ICAgICAgdXBzdHJlYW0NCj4gY29uc29sZStzdHJhY2U6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL3gvbG9nLnR4dD94PTE1NWQ5MTMxZTgwMDAwDQo+IGtlcm5lbCBjb25maWc6ICBodHRw
czovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD1lMGM3MDc4YTZiOTAxYWEzDQo+
IGRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9
MDliMzQ5YjMwNjZjMmUwYjFlOTYNCj4gY29tcGlsZXI6ICAgICAgIERlYmlhbiBjbGFuZyB2ZXJz
aW9uIDE1LjAuNiwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi40MA0KPiBzeXog
cmVwcm86ICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5zeXo/eD0x
NmNlZmRjOWU4MDAwMA0KPiBDIHJlcHJvZHVjZXI6ICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3Bv
dC5jb20veC9yZXByby5jP3g9MTY0ZmU3ZTllODAwMDANCj4gDQo+IERvd25sb2FkYWJsZSBhc3Nl
dHM6DQo+IGRpc2sgaW1hZ2U6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3Qt
YXNzZXRzLzBlYTYwZWU4ZWQzMi9kaXNrLTg2MWRlYWMzLnJhdy54eg0KPiB2bWxpbnV4OiBodHRw
czovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vc3l6Ym90LWFzc2V0cy82ZDY5ZmRjMzMwMjEvdm1s
aW51eC04NjFkZWFjMy54eg0KPiBrZXJuZWwgaW1hZ2U6IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVh
cGlzLmNvbS9zeXpib3QtYXNzZXRzL2YwMTU4NzUwZDQ1Mi9iekltYWdlLTg2MWRlYWMzLnh6DQo+
IG1vdW50ZWQgaW4gcmVwcm86IGh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9zeXpib3Qt
YXNzZXRzL2JiNDUwZjA3NmExMC9tb3VudF8wLmd6DQo+IA0KPiBJTVBPUlRBTlQ6IGlmIHlvdSBm
aXggdGhlIGlzc3VlLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRoZSBjb21taXQ6
DQo+IFJlcG9ydGVkLWJ5OiBzeXpib3QrMDliMzQ5YjMwNjZjMmUwYjFlOTZAc3l6a2FsbGVyLmFw
cHNwb3RtYWlsLmNvbQ0KPiANCj4gICAgICAgICBvcHRpb24gZnJvbSB0aGUgbW91bnQgdG8gc2ls
ZW5jZSB0aGlzIHdhcm5pbmcuDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gQlVHOiBLTVNBTjoga2VybmVsLWluZm9sZWFrIGluIGlu
c3RydW1lbnRfY29weV90b191c2VyIGluY2x1ZGUvbGludXgvaW5zdHJ1bWVudGVkLmg6MTE0IFtp
bmxpbmVdDQo+IEJVRzogS01TQU46IGtlcm5lbC1pbmZvbGVhayBpbiBfY29weV90b191c2VyKzB4
YmMvMHgxMDAgbGliL3VzZXJjb3B5LmM6NDANCj4gaW5zdHJ1bWVudF9jb3B5X3RvX3VzZXIgaW5j
bHVkZS9saW51eC9pbnN0cnVtZW50ZWQuaDoxMTQgW2lubGluZV0NCj4gX2NvcHlfdG9fdXNlcisw
eGJjLzB4MTAwIGxpYi91c2VyY29weS5jOjQwDQo+IGNvcHlfdG9fdXNlciBpbmNsdWRlL2xpbnV4
L3VhY2Nlc3MuaDoxOTEgW2lubGluZV0NCj4gZG9fc3lzX25hbWVfdG9faGFuZGxlIGZzL2ZoYW5k
bGUuYzo3MyBbaW5saW5lXQ0KPiBfX2RvX3N5c19uYW1lX3RvX2hhbmRsZV9hdCBmcy9maGFuZGxl
LmM6MTEyIFtpbmxpbmVdDQo+IF9fc2Vfc3lzX25hbWVfdG9faGFuZGxlX2F0KzB4OTQ5LzB4YjEw
IGZzL2ZoYW5kbGUuYzo5NA0KPiBfX3g2NF9zeXNfbmFtZV90b19oYW5kbGVfYXQrMHhlNC8weDE0
MCBmcy9maGFuZGxlLmM6OTQNCj4gZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvY29tbW9u
LmM6NTIgW2lubGluZV0NCj4gZG9fc3lzY2FsbF82NCsweDQ0LzB4MTEwIGFyY2gveDg2L2VudHJ5
L2NvbW1vbi5jOjgzDQo+IGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4NmIN
Cj4gDQo+IFVuaW5pdCB3YXMgY3JlYXRlZCBhdDoNCj4gc2xhYl9wb3N0X2FsbG9jX2hvb2srMHgx
MjkvMHhhNzAgbW0vc2xhYi5oOjc2OA0KPiBzbGFiX2FsbG9jX25vZGUgbW0vc2x1Yi5jOjM0Nzgg
W2lubGluZV0NCj4gX19rbWVtX2NhY2hlX2FsbG9jX25vZGUrMHg1YzkvMHg5NzAgbW0vc2x1Yi5j
OjM1MTcNCj4gX19kb19rbWFsbG9jX25vZGUgbW0vc2xhYl9jb21tb24uYzoxMDA2IFtpbmxpbmVd
DQo+IF9fa21hbGxvYysweDEyMS8weDNjMCBtbS9zbGFiX2NvbW1vbi5jOjEwMjANCj4ga21hbGxv
YyBpbmNsdWRlL2xpbnV4L3NsYWIuaDo2MDQgW2lubGluZV0NCj4gZG9fc3lzX25hbWVfdG9faGFu
ZGxlIGZzL2ZoYW5kbGUuYzozOSBbaW5saW5lXQ0KPiBfX2RvX3N5c19uYW1lX3RvX2hhbmRsZV9h
dCBmcy9maGFuZGxlLmM6MTEyIFtpbmxpbmVdDQo+IF9fc2Vfc3lzX25hbWVfdG9faGFuZGxlX2F0
KzB4NDQxLzB4YjEwIGZzL2ZoYW5kbGUuYzo5NA0KPiBfX3g2NF9zeXNfbmFtZV90b19oYW5kbGVf
YXQrMHhlNC8weDE0MCBmcy9maGFuZGxlLmM6OTQNCj4gZG9fc3lzY2FsbF94NjQgYXJjaC94ODYv
ZW50cnkvY29tbW9uLmM6NTIgW2lubGluZV0NCj4gZG9fc3lzY2FsbF82NCsweDQ0LzB4MTEwIGFy
Y2gveDg2L2VudHJ5L2NvbW1vbi5jOjgzDQo+IGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFt
ZSsweDYzLzB4NmINCj4gDQo+IEJ5dGVzIDE4LTE5IG9mIDIwIGFyZSB1bmluaXRpYWxpemVkDQo+
IE1lbW9yeSBhY2Nlc3Mgb2Ygc2l6ZSAyMCBzdGFydHMgYXQgZmZmZjg4ODEyOGE0NjM4MA0KPiBE
YXRhIGNvcGllZCB0byB1c2VyIGFkZHJlc3MgMDAwMDAwMDAyMDAwMDI0MA0KPiANCj4gQ1BVOiAw
IFBJRDogNTAwNiBDb21tOiBzeXotZXhlY3V0b3I5NzUgTm90IHRhaW50ZWQgNi43LjAtcmM3LXN5
emthbGxlciAjMA0KPiBIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5l
L0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMTEvMTcvMjAyMw0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpIaSBBbWly
LQ0KDQpUaGUga21hbGxvYygpIGF0IGZzL2ZoYW5kbGUuYzozOSBjb3VsZCBiZSBtYWRlIGEga3ph
bGxvYygpLg0KDQpCdXQgSSB3b25kZXIgaWYgdGhvc2UgdW5pbml0aWFsaXplZCBieXRlcyBpbiB0
aGUgZmlsZV9oYW5kbGUNCmJ1ZmZlciBhcmUgYWN0dWFsbHkgYSBsb2dpYyBidWcgaW4gZG9fc3lz
X25hbWVfdG9faGFuZGxlKCkuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

