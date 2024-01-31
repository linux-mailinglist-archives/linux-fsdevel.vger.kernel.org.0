Return-Path: <linux-fsdevel+bounces-9724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2A844A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046F21F21BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19D39AFD;
	Wed, 31 Jan 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CG5KULzV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AWxy5ai4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A839860;
	Wed, 31 Jan 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737291; cv=fail; b=f+tlDGWu+BtGS7LTfDL1WBQ9K44hnxXvLj04YsjWpR5qpvQu5LZ+Tg6u9+DBV9ZpGIqBC2zQnsV82kqVuJVnsU4sBoNi/F/4gigp1xtk8bzfJ6uWWzXNWecnEgNY+fqWRwhCsPYpgsP775M5qGgWVEfEbs7Q5vL/YGxTZO5bqQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737291; c=relaxed/simple;
	bh=nJ4RLnmdaZK1NaOgOQBoGaqK8OHvfxBLQotII9WmkX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZarMzMaIBSqc3cU36Q7eXfdmvLh/rwmD41DUO9uVrWc0MMsboMQOmP0FauOrNMotixsobuJ6wSjuEmts/OENCobSQuDavZZm6bJwXaj+qT9ZTwFlJnSPvCFVNSbMn6CZ2guwvt27zIW8Oe1F8P75JDg2Q/3hkAjaf+pgFeDxB6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CG5KULzV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AWxy5ai4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBp40008446;
	Wed, 31 Jan 2024 21:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=M71YxiMIIUxybB5vqH5foKg9OnqNJO42dR24vo6aXqE=;
 b=CG5KULzV92fsqEo1NfEVsYXjjuu1Dqx/st8ywl6sHLhMX1bX32nDUquUmSl3p7/MHvLl
 P1kFjs5yLpMDgAsz5pJChUg6L9kDV11FEKpcZ9B2iYrafglBSxC69FvjI05aeU9feZnr
 ikkNiLF5Gmz7jH1RlhTf+V35zAaqi6dNRcTf+kpf6DtqFD+OF+ZElf8Id2U+fc+G8UFp
 HqnInzrK29F3R73TlF9Qn2WtoX/UGYBKz/YzGRcad8IgdRcvSZkSH6UqefvJL8vt4rBw
 t+JT3qfZZ9YRQKxUdAEJpyiF5F4jbk5SrmP++6+x3tny0miiar3OpVzdCTzZnn9TdOk7 gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm431xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 21:41:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VK7ZVK036101;
	Wed, 31 Jan 2024 21:41:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fxeqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 21:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZZfIXyIJI5mSsX+ZBqzYcinJdHVVjPV1cvAuGVtexAEn/peDUtr0+xUxAI3kb1Ti25Rk5sDUowIsrYIj/N+3eOxjaCZ6JDSBLKTDW73rsDw2arHvfo75u1q96u3R02DNuNig2dj1HB0Px2TFKYUp853WpioLviVphgYpsgd5kM291khl03dgx6YIry8nPUTWcNotnM+D6bPJ5h52PTToinYFqqn/cJh4iixl1jvqtdlWXaSesYYCyzpUJXvQeR8BxyI27h+umYGUbodUiKJg1chkEfVWJ3zXUlv+v+snYr54tHChoAdlybTu51aDSxfHTKJcjNK6EayQdJ3fJwoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M71YxiMIIUxybB5vqH5foKg9OnqNJO42dR24vo6aXqE=;
 b=dv4J8mq3Pa3r1ebyJ2+0oTEMmAmBCsu9woOJnnDs0kARl9SqSSRDyORJErn72HHJgA7iaowMwwLVWeOqLx3ysdPNbAnFkjNir7R3UiE0n/o+TZbNu41W2W7ZxNIzJY8hB16hrHJW9/MR7r8TizEoSM7LjomG6SAgCsi7WEmp6K8pmk5A1kAJyhoOrsFXL14uW2vS3foSzWdw1aWWgJvjR+S/6TTEcqVIP80UlzPCIiUiQ8BZD2zP79wBkiNQZLUKDU7zht8EjgE4scprbT4yPu1rqjl6ajwH/kFOp2S60RYaFHx1wEm0vv0E4VR/MkwtOxIiS43ZdbP//lhJT71WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M71YxiMIIUxybB5vqH5foKg9OnqNJO42dR24vo6aXqE=;
 b=AWxy5ai4V8WyTnf1oTOZAtoASpb8vOrBQKjWYUTiGw1rh8sr4MWlSuVsO9bq866EfWgY3oZ2qQ1ruxnG9iUPY7TAcSDjEPD7Ch4sZntnQc6wZunrAJeaKAVSyG/j200NJZ7mb/0507pdGCssQilb56BAOlr5hPm7++CQ4j/Jt2I=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.25; Wed, 31 Jan
 2024 21:41:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 21:41:07 +0000
Date: Wed, 31 Jan 2024 16:41:04 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240131214104.rgw3x5vuap43xubi@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com>
 <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver>
 <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0086.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f496014-7ea9-4d02-7de1-08dc22a554f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f01fVXjkeLqvZ/rH3/NYTlBKmPgrOuWdaxf8xJXS8HZd6D1tSOExZHMR/TVrVzBXeTTJgqOUYYpEYrZFHmZ3nQrtrEX+Dbygxk7AtPzk1EEm8Hnwsv9fH0zbpOO5SfUJ8o7fnfiYhTiRmdiTcXtUZa3ZBq0LAjRHWGZ4lvOvb/icPHg4CmSE9j/oBBkWHmms6Zq8loSIDZsc3M1bqUhqi0mgDxINX4dd5CNxwP52qAHrnMibYbDgwrTo8GUM1PDgfnXqvJ6HB4iENCerq7w80Lg0fxoRrb2hi1yNuZQfp9mcmlgE7w5/GRWiV8QqN94u4X2ETcmYXUDsaaTgW90T8R6v93pMPqzR8gT+5KR5E9bx9CmVB5ncCGMeOQtZ81YM/nNLT7hlJuZ0m/8CKqqSezQVmA9hYzS47pnv8XhqN3uciL2kEOSif2mSS2p+ik/VMTNIP5cRa0vWUBDzBICE77OaD78DCgFPrfpQf2TEIj21XPlGA34LOjmMAU9eqsOLhx13LiFXwMQhnTh3CH52giMuvT69UYipN0plnyuppDWaCnFNjkEn9EFnVgUXi4pp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(33716001)(26005)(1076003)(41300700001)(6916009)(316002)(66476007)(478600001)(53546011)(6506007)(6486002)(6512007)(83380400001)(9686003)(6666004)(66556008)(38100700002)(5660300002)(7416002)(2906002)(66946007)(86362001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXNHVHMyNForVmF0SnRnTVBIcG84VTF1eWpWblkxajF2TFhTV29ZdStNYllQ?=
 =?utf-8?B?ZHVXRjVzb2xESmlFdWFSTk1OU3ZQQm9BeGpOK25Pclc5QVNabkRhSUlpME9S?=
 =?utf-8?B?NnREZDNwNFVxUU9ESlIrZjdmSEs1TC9tVTlCRGhQR1RBcyszbEJOK005dTNV?=
 =?utf-8?B?Y2RvUytUa0hHNzVhYmhxcEhrdGhvQkdseHRLYjlxbUJNeVEzRzdLOEZpNTVI?=
 =?utf-8?B?VEZ1YUgxL29lNjNWTFhNemlqQW1PYVZSRTZXN0NlWlVjdWQvb3lDMy9GQTVP?=
 =?utf-8?B?Z3kwU2E2Q1dvT25qTEJIcVF6L1ZjLzRQQ3NwMWs4ajYzeUw2amlLQVYzVXBS?=
 =?utf-8?B?WkM5djlvRnlmdmNjenlMM1ZuNk5sZ0pBZ2lmbmE1VlZaR1hXcEtlbTBBbERw?=
 =?utf-8?B?a2Q2N0wzSTZMa2cva1hlK01La3lrcnQvdHlkOGRCT3FHSkw2WEpTMG5oMktY?=
 =?utf-8?B?ZlJicmRwQ1NYa1RJdHFZZzhpYjFnWndIbVk3MWZYOVplMWlCcFA0N3hzL3Fz?=
 =?utf-8?B?T0VFUG10bHVrRCtRNDZ3S1N4RE9GZXcwa25pbUluOE55YXE4YUM0MEV3d1RT?=
 =?utf-8?B?RkRHY0lYUGErbGprc1BleHFudjZzQjFMcU50VlNBZERvM2E5M0s0NUJhOGp1?=
 =?utf-8?B?ZmNiclVraC9jV3FjYVN5WDY2YVU0eVpVeXFLSlpYQ09tRVQ2RlUzZFBvS253?=
 =?utf-8?B?SzB4QVlLWFNPellXNncxd3pXTWxNSVNNcTFFR0lEOWZJMmc1L1FlNVZ1QkdP?=
 =?utf-8?B?Y1BheVlEdmNudVgwTkxXVTRCTTFPWWllWDFCRkVDaGRuSWhDVElMU0Nyc1Ix?=
 =?utf-8?B?YWNTUE1TWEF6VGZBQXV5aUYxMk94QS9GaUVnRDlETU1zbkxKOWFCNXpLNElU?=
 =?utf-8?B?NjI4b1BRRUxURHpIY0dsUXc4QlNRODljUnRDM0tMUXg3L2ZFRnBOendOWW14?=
 =?utf-8?B?WmlFOVRUczJ2dzFlLzh5N21UZ2VIbGZOTmd4TTB1RWdDQVBYRGlrN0hnb1k3?=
 =?utf-8?B?UDM4Zk1CMHhHQWlUTzk0YW50TElRekpwd0d1V3RKdTB3WjlObjdMZ2VsSlVh?=
 =?utf-8?B?N2NyaCtoR3JtdmlHUFlHSzZ4TEgwdXVMKzV1RzltcU9YeDFmQ21wdjdBanov?=
 =?utf-8?B?ZDdialJQRWxzWmgzejFTMlB4c3pSVWJoYWNmWnk1a0VIZzg3ZnduOTl6cUtC?=
 =?utf-8?B?VjIxMW9ZMFBUREVkT2ZGd2tQRmJrOHZqUzZzVExUQW14bHpLR0VtM2FlVGRP?=
 =?utf-8?B?dmpuUm5qSkxGaGxzQkRYblU1WTQ2b1FBYVRRaDlMamZpU3lvWnZBS2dtdmtx?=
 =?utf-8?B?VjhEbEFWVEVDNUNKRTBLYm9sOFQ2WGkra0pWYUNUTzZxaEVDL2tHT0o5ZGps?=
 =?utf-8?B?RnUyVjJNYVZwTkZjd3owNHppZVlydlJ4OVlEVmsrbTB2NFdmd0dRM05NaFZm?=
 =?utf-8?B?QWFmK3dwYS9hRVJiT1hic1dMT2xDWExwcmVXaEhTY3JzK2kwRnJmZnhORDVt?=
 =?utf-8?B?YWFWckYvM0ZzR0tlbUg1V2ZCSmVHQVlqU3Joc0FpWTBMZUhmMjVsVng0R2c2?=
 =?utf-8?B?UkdWbzhtZXUvUXlWNXZpZnpYSnpHRThGWC8yNXJaV1hCMHFQam1vK2g5VHh6?=
 =?utf-8?B?elMwazlhNmlPblZEK2FrcWpOc3lPMHk4UkZZSDR6aFFET0dGRW1DV0J5UFNC?=
 =?utf-8?B?cDI4c01nUGdZVWdMdWp5bGFVa2JkUWVlOVIyNEYzeDVKUk9rSW5sMVg1UUJD?=
 =?utf-8?B?eWZ5cTBMVE54eEMrQkJZYnMyMzlvWjk4YmkzSmY5RVFxc0laNjExZWg2aXY0?=
 =?utf-8?B?NGhhSjdqaHFPVjQ2WUFQTDN1SEJpWm8yS1gvS2RkTUx3K1hveVBCc1JIT24z?=
 =?utf-8?B?VFRiNk5MY0JpZUpsR0RwallBamd2Zk1Ua29IY21jWFYxeUpZWlZyM0pFQjNs?=
 =?utf-8?B?Y1AyZll4bXlFNHRFeGRTei8rV21lM216UFE1dWgwOEtHMTNOeEFJWCtQbVFz?=
 =?utf-8?B?bVp3bUZzandkc1p5RnQra3VYYnZsYVE5UjhwUENnaDVPWG1GNXRUdlJweUhy?=
 =?utf-8?B?QnRKcGJJcGRhd2ZsQU5MR1IxWExISmo1YkVWNlFEUjkzcENDYXljdDM0QVRY?=
 =?utf-8?Q?Mqn/c+H8w0pQwGT7wHwpRGw9i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fwKPFKpznJZT/oT4wVUi5YLmbyO26F3WmeQL9NcunTd20DKFVzqPh6Yd/iYpdvwEj9OqE6x13pKd9HTp1rv3+cHd2dKlvdCZxWukcw0jlmFn7RvT1LWrKcagAiaeAh4rbz35iLPcbM7hKAWKPK96P597BT0ybRvcNgASZlp7TPGtom2XOT0AHrvoC5D/4voIDmkHGE49Igx0PqFpioEPwOaaeatQwbVPcDXwXOq196uMqe022HnvpsWQK1PpoRVyEC2NQLSss8WWQusywz0axfb7ssGaNIc0ORwskYGCMS8oKP8idEgOavj1Xd5Ch31XZm8qAxrYaitW6gvjWlXOG+ceDsfpp3n+xnVC60o5dqvtmuFrXL8aWVI/41ZcPCGIasMpwmsugOnTMCmGGvUTau5it4jMFTRfyyILKxT5H4nXGaqga+1kOttG/sHJD0zMWGCZGIXQpUYny2o4aNgjCOiLVHOfHgZsn9NoZXVqWhn8px1S+dwgBMByxtlMR6LXKVtlzqXhXsqlQ7qdNRlrzXf4BAqSXZtJIq4Q0XkvOJDkzgeCHNuYrnOYa3we1qYXbxEXE8oMPeR5I45lpMFqa/iNVoAcuC7gB8azJ+J4kbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f496014-7ea9-4d02-7de1-08dc22a554f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:41:07.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcF+sCVABgnN2Wxskdm9g7kiYzW3U4BrjD7Hq2li+w0bVr5QA1hqqtcMUJhRvfbXwPa4Wp2Q+JFZ8b+MUKITPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310168
X-Proofpoint-GUID: lq6JTlAY8AVtJ1IOT6AWbr2UvdoM6gzE
X-Proofpoint-ORIG-GUID: lq6JTlAY8AVtJ1IOT6AWbr2UvdoM6gzE

* Lokesh Gidra <lokeshgidra@google.com> [240130 21:49]:
> On Mon, Jan 29, 2024 at 6:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240129 19:28]:
> > > On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > >
> >

...

> >
> > > Your suggestion is definitely simpler and easier to follow, but due t=
o
> > > the overflow situation that Suren pointed out, I would still need to
> > > keep the locking/boolean dance, no? IIUC, even if I were to return
> > > EAGAIN to the userspace, there is no guarantee that subsequent ioctls
> > > on the same vma will succeed due to the same overflow, until someone
> > > acquires and releases mmap_lock in write-mode.
> > > Also, sometimes it seems insufficient whether we managed to lock vma
> > > or not. For instance, lock_vma_under_rcu() checks if anon_vma (for
> > > anonymous vma) exists. If not then it bails out.
> > > So it seems to me that we have to provide some fall back in
> > > userfaultfd operations which executes with mmap_lock in read-mode.
> >
> > Fair enough, what if we didn't use the sequence number and just locked
> > the vma directly?
>=20
> Looks good to me, unless someone else has any objections.
> >
> > /* This will wait on the vma lock, so once we return it's locked */
> > void vma_aquire_read_lock(struct vm_area_struct *vma)
> > {
> >         mmap_assert_locked(vma->vm_mm);
> >         down_read(&vma->vm_lock->lock);
> > }
> >
> > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> >         unsigned long addr))    /* or some better name.. */
> > {
> >         struct vm_area_struct *vma;
> >
> >         vma =3D lock_vma_under_rcu(mm, addr);
> >         if (vma)
> >                 return vma;
> >
> >         mmap_read_lock(mm);
> >         /* mm sequence cannot change, no mm writers anyways.
> >          * find_mergeable_anon_vma is only a concern in the page fault
> >          * path
> >          * start/end won't change under the mmap_lock
> >          * vma won't become detached as we have the mmap_lock in read
> >          * We are now sure no writes will change the VMA
> >          * So let's make sure no other context is isolating the vma
> >          */
> >         vma =3D lookup_vma(mm, addr);
> >         if (vma)
> We can take care of anon_vma as well here right? I can take a bool
> parameter ('prepare_anon' or something) and then:
>=20
>            if (vma) {
>                     if (prepare_anon && vma_is_anonymous(vma)) &&
> !anon_vma_prepare(vma)) {
>                                       vma =3D ERR_PTR(-ENOMEM);
>                                       goto out_unlock;
>                    }
> >                 vma_aquire_read_lock(vma);
>            }
> out_unlock:
> >         mmap_read_unlock(mm);
> >         return vma;
> > }

Do you need this?  I didn't think this was happening in the code as
written?  If you need it I would suggest making it happen always and
ditch the flag until a user needs this variant, but document what's
going on in here or even have a better name.

Thanks,
Liam

