Return-Path: <linux-fsdevel+bounces-11449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E7853D83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426AFB24481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2618462177;
	Tue, 13 Feb 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YsdLbjff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PiL9LGB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AD6216F;
	Tue, 13 Feb 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860495; cv=fail; b=mU+oQWN63cHJ9df6/xT4dBgk/iZjI20iKO58MO+qOvm66Y05UrNM1C4gBYmf54doPpgVIChsF/RCuKgHZkw7HrJLGzWgbncBsVYZTXBhJ7iw1gWLDxYj5o0SOdrWNSENgeHq24U3zGhE8AgXhd2WnkHQ9IYFQjTkB+2EikTl1tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860495; c=relaxed/simple;
	bh=c797SQeQ/LORUXuFDQA0WkS68o17uybDJgmp+quTLhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HEl5PNCN8I7KpJogtOSc9+keiXRjor/KZcxVpZXcCpEIiEE7gQhu6DKdA/paX5aJAgjCqhDD+uqCYUEQxI4nDb/IoM0INlY7wjVIL5WrZa+lPEUDtVBLBHxuYyA7zP7MVw/edbYs4UgxrTKmcC0xFpr0EGyvVe5t4i+GWhr5U5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YsdLbjff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PiL9LGB1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DL3xIA003639;
	Tue, 13 Feb 2024 21:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=c797SQeQ/LORUXuFDQA0WkS68o17uybDJgmp+quTLhI=;
 b=YsdLbjffIfeXjylAP4M99tqq8t9OcoxQ1Jzp5JVNMBSY/dWfvdJ4TV+0ZiodJUyYtrRU
 558mOufHj3/KRjZ1GNbb1EwZRhHps/SanX75MOOq6lwAElmUAoubtYiC8Ku0BAKHjm9I
 eUJelSuXBlBbB59HKVFVjDPkwSsi89xfKkCbUWagy2Om700/IHJ5wBNoxFjwWm6F0lHQ
 Ze/wypO3HXBoVFu1SOl4QoBQNs/mWW7qPRwWWk9h5hdwrPwWxBYEAOA2pSnJMzhCo0hN
 YI+HjzSa1+5oKOtKGR8nqYAk7RGaeU1xooPAqJsmLzBS1gFQ0dSWDtxOt1+4x/cSAsLn Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8efvrbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:41:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DKfFA1013768;
	Tue, 13 Feb 2024 21:40:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apaqfq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 21:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwiHOEhfh7WgDgApM9eKjQbUjdW++QLL5OvhUf9zQhO0b5P1lAp/8PGQQgx64MoqWvPCg3bI4WbyMgWm2h9t+JJfurRJCXb77FL0IjA2oUlmJLWq0HMlILi4fmJBg/2VqvbtqzjJtTsthFkGzgI3uoQrFK+azF/AH94YyH9cV5x4y6lG4bahOSR+e4fRxKjpW00esuXrrFlZOxZV3GfZcJh0tjxucw+KuCyDwRuh7SfiXabqv11FH8BYfqaN6iq4vsFyn+6LwAROplGQKEb4MhOvL/Xxj6q7TISlQZXfPkRgPjCLJddyoh12dWEXvmfLc0gTMxVJhlagqlF75F1ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c797SQeQ/LORUXuFDQA0WkS68o17uybDJgmp+quTLhI=;
 b=CMbqYPTfQ20I3k5J4QRuVX7X9UmGLEmXgYXY/bWT/OxnB9MEs7t/woUXouLme5rM/qNBlMHaPkON9fuDUU1b4VAzBeZSc4NIm0ipB17NJqvpfj22WfQ7zi0uBa0j+HAh5CfxlzXbzyAAtZdM50Wmx6Bb6VbP5YyzatPIw9qH9vSbOIy6MATh+FWAbtRYJXjnO9/Krf3wB0SzEY5u4KF1lZu5GMwce16RDv9/cz4sdwl3zyauMysbzFIb/QFxTbNIl9WaWdf6VMdO4sxhp8T48IVD75qcHTDDTIgOKyDc9t0ruKxdo6jZpRiKa0ysMy/wUIeAteyeCjk6r/I1nFv4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c797SQeQ/LORUXuFDQA0WkS68o17uybDJgmp+quTLhI=;
 b=PiL9LGB1j0UxKn29ZEyiyVQsqDABq9I9CnMwmDUNTexT1JQTQ/o5eLmkXG0W4B6DSLhxsjbLHsxOtUiWXAVD2fxr59XXYVBlVVMWPUXqY/O/BUPYN3C76T/B9XSCSBnca9FXftXR20ncrQ1WGnWja7j0FYMvFRbVEIbqiihGVW8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 21:40:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 21:40:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        kernel
 test robot <oliver.sang@intel.com>,
        Feng Tang <feng.tang@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel
	<linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org"
	<maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH RFC 0/7] Use Maple Trees for simple_offset utilities
Thread-Topic: [PATCH RFC 0/7] Use Maple Trees for simple_offset utilities
Thread-Index: AQHaXsTep4btIAyOWU6/ps1XtD7lQLEIzPYA
Date: Tue, 13 Feb 2024 21:40:35 +0000
Message-ID: <61820F51-AB93-45D1-812C-D6EAA089AE3E@oracle.com>
References: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYYPR10MB7675:EE_
x-ms-office365-filtering-correlation-id: 960f89ee-712e-4d0d-c0d9-08dc2cdc694c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RjAzzGg8WWLR/iV/bn18476JTwsLUnXuO4SHa9ZVvagV5xBzuo1VBb2Zp9T+HR8xIROvlBkvGd6mXWyGh5xl8KEC0pnUmI6oSWRz+sMpS4K3srHUzjea5TUOqbV79hI46DVwZsxbCPYlUbmuabMPsLHwLjdbIL437YumZBL+4Sc1Ju3AHnkwo97E6fbNuGvabcWJ3151M4RaGj6Z1nlwO+I4Sz3mRBkehuQyvL5GxebmfYoOVwAK7yG7nkigvwS35W9KVO0RBpm3E+hYEmNDRkzJYbbaprD4PAqgndZ3cl4g4qdZQcbR7NdZ2QKptfalFKv7evI828GemkHI70AYHmz8pKqYX5KbY0bJ409Raz9NnRToJJsubFDgIFBv+BAWa+Q7I28bTq62AygtdCkzvjcHVo6akwoFx2w8o4uARIJxZqnvQcMAbvLRBG65edS6GydyNIdSaWCP2zo5ipmahaxZL3Ebd7PyEWdBO4dQxbgZDUUUdo3FBDUVNtPvNLVhdaCweX7Y1KD2jz0/W3F7SeJUCJyRDiuNi4jHdP//ZEsGf3mrTjyl65y+i4byoSqeMruqhbRktwjkCJ1jbv23Us+BeZV9dk6CbTm1TpOTpD0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(86362001)(122000001)(38100700002)(71200400001)(966005)(6486002)(26005)(478600001)(76116006)(110136005)(54906003)(316002)(2616005)(6506007)(33656002)(6512007)(53546011)(38070700009)(36756003)(66946007)(66556008)(7416002)(5660300002)(2906002)(8936002)(8676002)(41300700001)(64756008)(4326008)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N0JiZzNhTktqNlZacndxM3ZLS2dFaVRDUlNnN3N5Y1NaWFJWakVXQnpYeXJN?=
 =?utf-8?B?YzlPb1hqVzJZL051Wi9KQllPRG1YTW11K1NWYUVQdUZFWi9MVmtCT1FrQ0M1?=
 =?utf-8?B?ZFBaSHI2UU9EUjhDbUswcllMdkI5K001TzdTQmhSWlQrMGFZbU43TlhRMmZn?=
 =?utf-8?B?TmVTU0tTSm9vVlFoNUtPcXFUdkUvcktlSlUyOXdML3V4NGxoU3NvcmJzZktJ?=
 =?utf-8?B?dWRFdVVualVlcUtQaHRkZnpXTzFtbWtEUTBQMFJLNEFKQ0Q2WnBHUHMzbWxK?=
 =?utf-8?B?WDR6dVJGZmJGR1BZQ3M5Nk5GeGpOWExLYVAvTHZEQWFXa2pNRVJ6K0VkeVg5?=
 =?utf-8?B?ZzNyQTZCZXAwbC9wSmdIbC9ITEV0WXZSTWZOT01Qc3RzRUEwUEhMc0FKVjBr?=
 =?utf-8?B?M21DbkptcWg0YjBkSUtHM1hka2Rmbytmc1hjOUhrSTU5ZFZIekFLZlM3bzhj?=
 =?utf-8?B?K3VnZFlYZkdkMGVhY2I3cXVkQUMxRHBDUVBMSXRzYVE5N3BMcUtVU0h5ais1?=
 =?utf-8?B?dWszL1dUd2xzaVh1cnBva2pTTHJSNnp1SG5KMnhBbXR2TWtTZitYYjFYOG01?=
 =?utf-8?B?S0gwTG9PL0VlaVpOWjVWYVVHM2Y5Z2NKSmxOc0lLbWV6MHBSVjFHNUNMcERr?=
 =?utf-8?B?RXY0SmdFTTRzYXZ3bDlsN1A0d2NVM0s5c2NSbW56R2dKbDIxZ01jT1JTS3Qz?=
 =?utf-8?B?cEZGYndqMVVsc2lqTjFVdytOSEk1K3RkbW5vK1JIL3dYbEV6bnlyNWpudFhH?=
 =?utf-8?B?a2lZVHBqK3loaGRXMHU5ZVhnOWtacXpNR1RFRkN4ZkRmT0NFcW9TMXBUelJH?=
 =?utf-8?B?VUIzMjNWNjFBL1ZsUzVTbEdVVERDT3lkYW1tOXpsa1FlNS9TM1NhVWpRenpV?=
 =?utf-8?B?cDVyd3pEMTlVWjArZXZaYTV3alR3dVQxSVIxdEZhRHRUZ1JZME93bGZuaWFW?=
 =?utf-8?B?R0I2LytwbXNnQ1B6Qm5zcGl1Sk5KNkV4S0IrbERacitSUnBaQ3h5N2UyUHVB?=
 =?utf-8?B?bWZYUGpRSjVrMlpxUk01TEVKbkx6WTJxT2pmK2ZtWVdiTTZOTWtoUG5iQ1dk?=
 =?utf-8?B?ZjJqZVcvNk81UUVGYkhMZi83VUhBVEo5VGh1cGdJWXJEcWp6K0FTM3pUTkJ2?=
 =?utf-8?B?TExIcDV3VmVwTHlHbThNTlgyL0Q0QmlLaURWL0dDRVRUMW4xaHdPdUNjenVL?=
 =?utf-8?B?N3ZmZTRMOUZZWnBVME1ZM3dHUlhuWVQ3TEF4WGZmenBpeGkyVE5qaFZlcHgw?=
 =?utf-8?B?MWw0Wi9CM1VZY0RtWXk0VGxqMHVJOXpVM3czaWduT2N2TzJodkI5dURPanZX?=
 =?utf-8?B?NEJmbjJLZW1HYTgxZ1hsblRmdSs2UnRLRTg0OFozWDRYZHNYZTlINnh6Qm8x?=
 =?utf-8?B?VEFuODFyVmJTZHZ4R0VXT2pQR0xPU0hTdWM1Z1FGMHpPbjROZnNzeDRoaHhl?=
 =?utf-8?B?L1RHbEMvNllTLzFsSm1uQmZlQ3lzTTcwOFdRYkUxZEdKbUZhc1VRVkpQaWlP?=
 =?utf-8?B?bEEvaU1RWnIwdEd5bnZYUzIyTmRaWDRaN1VreWxLOExJTWVxVkxzN2hiSGZt?=
 =?utf-8?B?S2dxakEvWFJaKzRLRzlWb0U5YlFBTEdFTjduY0h4T1gva25SRWNiME51ZlFv?=
 =?utf-8?B?TE9sOEpJVEFuNUtlWWtCaUVYdWtjUExKN0Ywemc1MjJ3WXpDYzhIR3VIaWU3?=
 =?utf-8?B?UmdHUTJ2OW00Qmk2VkFlUUtLMHVwSnY3VGRjK210YnBBM1ZKWGtuZG15RCtK?=
 =?utf-8?B?OVRlMUNkalM3Zk1DQ0UwYjRzOFhkQld0REtJMlBuNmZTWEZtWVdYL2RLQ0cv?=
 =?utf-8?B?bEZqMVo4WTlya3BaT3ZrRXM3c1VBYzIyOE1KUC9wdWhYakR5ejNTUUhDN2Yy?=
 =?utf-8?B?dkFIdkZ1U3FnREd2b3M4K1pjS290eHBtanNaQ1lZd2R3dnN6dEZVS0svc29j?=
 =?utf-8?B?Z3hMbFBmTUYzRlRLWnFHRGNrNE0rZ0luQlhTY1JjUUZDUFNIMXNsQ2NvNGpY?=
 =?utf-8?B?RVJtdkQzc2ZYZGpMN3k5dnEwYzNkczZzYklCTyszazVhUGFmMjFZR0ZCQ2g1?=
 =?utf-8?B?MnQwNUdvUi9SVkZ1WG1xc1dzU1A2Y3U3SHJtOWdMUm9RKytIWVprUnc4cU1y?=
 =?utf-8?B?UjhFRmpOTmlLYlRIeW5Wb0d2bHBZZWVpemRNRDBqb2tKT1ZycFZ0Y1g5ci9L?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <226B4B87A329694CBD61558BD8BB5647@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UKwWDy0j8yWt3FjA8iT2XUQAOuTt92xgz5a7RTaN16uQe/ZImfT+3IZxxq+s77ZuYjUu03WHIGMMVVNMPVjvRhOWeyk7NL9J3C259XWwc4wz3OGDhwZWb/w+JW70wkhB5q2u+DApb8mtaVTFRhoCPscAku+U6t5BlCR13hO9JTu+3IXZ4mB2wyKnP0lydi1IqCh+oLZiRoBtFKXB6CkY87LRJKUYS64rFWd9hMk7FAjP7s1DN5QCP2+3inq3shnLOq5+fXjWyHPIb68GLfPmVnkSltJow4Bru/y+/QknHTsWtocA/npodV9G9cP8IWGvoNXsO5aj1+mHFcLSgMGg+bYZnUhdpzA9FxbbwZ6XnL+JNqSvXNjeCUWbcQAalMh5fnAB1o5RbVqP59/3TnKXPD3fHAcdnVIPLDI3gHw9dTepDYNwM9fT5Jr7C5tNiE2vvNGWCX6wn9MP8gbTHfIkhvvUdHbjO6wagCKCJYKPrY7prBTDmaHYq4n+yetBkKbo2jDjXyRRlfoVVXYWx3J8sUpnJOJPpbIyOWwjkBgHIRqsz1HDf07bNatlwz+hmPpjtneBEkERcU7EQsEif+LuCfceIdWC9Ju2mC/YjFN47vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960f89ee-712e-4d0d-c0d9-08dc2cdc694c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 21:40:35.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3OUoWT3RB7ar382rOfl37QCG02kVNjDq2eTfBLi4zQO7/N3NVUWYjxbeF5idXygpJhfG+8ESUjGllwT8ZvZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130170
X-Proofpoint-ORIG-GUID: FN7vbf5PxHIJTLJjj2d2Upsz953d9u00
X-Proofpoint-GUID: FN7vbf5PxHIJTLJjj2d2Upsz953d9u00

DQoNCj4gT24gRmViIDEzLCAyMDI0LCBhdCA0OjM34oCvUE0sIENodWNrIExldmVyIDxjZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBJbiBhbiBlZmZvcnQgdG8gYWRkcmVzcyBzbGFiIGZyYWdt
ZW50YXRpb24gaXNzdWVzIHJlcG9ydGVkIGEgZmV3DQo+IG1vbnRocyBhZ28sIEkndmUgcmVwbGFj
ZWQgdGhlIHVzZSBvZiB4YXJyYXlzIGZvciB0aGUgZGlyZWN0b3J5DQo+IG9mZnNldCBtYXAgaW4g
InNpbXBsZSIgZmlsZSBzeXN0ZW1zIChpbmNsdWRpbmcgdG1wZnMpLg0KPiANCj4gVGhpcyBwYXRj
aCBzZXQgcGFzc2VzIGZ1bmN0aW9uYWwgdGVzdGluZyBhbmQgaXMgcmVhZHkgZm9yIGNvZGUNCj4g
cmV2aWV3LiBCdXQgSSBkb24ndCBoYXZlIHRoZSBmYWNpbGl0aWVzIHRvIHJlLXJ1biB0aGUgcGVy
Zm9ybWFuY2UNCj4gdGVzdHMgdGhhdCBpZGVudGlmaWVkIHRoZSByZWdyZXNzaW9uLiBXZSBleHBl
Y3QgdGhlIHBlcmZvcm1hbmNlIG9mDQo+IHRoaXMgaW1wbGVtZW50YXRpb24gd2lsbCBuZWVkIGFk
ZGl0aW9uYWwgaW1wcm92ZW1lbnQuDQo+IA0KPiBUaGFua3MgdG8gTGlhbSBIb3dsZXR0IGZvciBo
ZWxwaW5nIG1lIGdldCB0aGlzIHdvcmtpbmcuDQoNCkFuZCBub3RlIHRoZSBwYXRjaGVzIGFyZSBh
bHNvIGF2YWlsYWJsZSBmcm9tOg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jZWwvbGludXguZ2l0DQoNCmluIHRoZSBzaW1wbGUtb2Zmc2V0LW1hcGxl
IGJyYW5jaC4NCg0KDQo+IC0tLQ0KPiANCj4gQ2h1Y2sgTGV2ZXIgKDYpOg0KPiAgICAgIGxpYmZz
OiBSZW5hbWUgInNvX2N0eCINCj4gICAgICBsaWJmczogRGVmaW5lIGEgbWluaW11bSBkaXJlY3Rv
cnkgb2Zmc2V0DQo+ICAgICAgbGliZnM6IEFkZCBzaW1wbGVfb2Zmc2V0X2VtcHR5KCkNCj4gICAg
ICBtYXBsZV90cmVlOiBBZGQgbXRyZWVfYWxsb2NfY3ljbGljKCkNCj4gICAgICBsaWJmczogQ29u
dmVydCBzaW1wbGUgZGlyZWN0b3J5IG9mZnNldHMgdG8gdXNlIGEgTWFwbGUgVHJlZQ0KPiAgICAg
IGxpYmZzOiBSZS1hcnJhbmdlIGxvY2tpbmcgaW4gb2Zmc2V0X2l0ZXJhdGVfZGlyKCkNCj4gDQo+
IExpYW0gUi4gSG93bGV0dCAoMSk6DQo+ICAgICAgdGVzdF9tYXBsZV90cmVlOiB0ZXN0aW5nIHRo
ZSBjeWNsaWMgYWxsb2NhdGlvbg0KPiANCj4gDQo+IGZzL2xpYmZzLmMgICAgICAgICAgICAgICAg
IHwgMTI1ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gaW5jbHVkZS9s
aW51eC9mcy5oICAgICAgICAgfCAgIDYgKy0NCj4gaW5jbHVkZS9saW51eC9tYXBsZV90cmVlLmgg
fCAgIDcgKysrDQo+IGxpYi9tYXBsZV90cmVlLmMgICAgICAgICAgIHwgIDkzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiBsaWIvdGVzdF9tYXBsZV90cmVlLmMgICAgICB8ICA0NCArKysr
KysrKysrKysrDQo+IG1tL3NobWVtLmMgICAgICAgICAgICAgICAgIHwgICA0ICstDQo+IDYgZmls
ZXMgY2hhbmdlZCwgMjI3IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0N
Cj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

