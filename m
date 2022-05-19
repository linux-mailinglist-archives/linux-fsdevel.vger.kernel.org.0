Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D752CE3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiESIWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiESIWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 04:22:24 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371DBC18;
        Thu, 19 May 2022 01:22:22 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J82sSa010076;
        Thu, 19 May 2022 01:22:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : to : from : subject : cc : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=Y32AomQWawSt5k6hrMn03HlEv57jnzh+aBey1ubN5tY=;
 b=V/AVkCoScxOuT6etMWN12p1VdHn2wOD0fxu2+1mkDpMbnTKiSaxEMCxsfbPBVkXgDHRS
 pSpD3qRpRRwJ4kywh1lZGFF4aqsBupP7VOve4NU4PmvkiTQsz14hS9vhZ8frwiZME8op
 b/WndKxIbeq3kCll0IZIMQ+YEsPA/SuaWIOlz794uY1D0ZeBqD/JKU5w7yrFS4OpyRk7
 L+HWbkJMcQh5Lf/3e/3dMf0sygiOrXZLcMCN/oo95QZxVszZ8BnyI7jtobnF82wHgT7R
 LrYLD8uAKqVD7JNSE8+kWAJoGfVymGU0muARKCSa+JUxRCloxtSrP94TvC+kZpDRCm5t Mw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g27q4v115-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 01:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFZCTvInPlfbr7zA3N4ZG6y0/ipTBx6TT+UCg74rstgbqYDr5HVJX9j226ABCATdETRpe6VPRSLziFM6quav2GC8n/+qw1W33KJX747W0KA8xMEHzuBTChP3Q2128EnsfJgWfzfLdvYWa8nUcoW16IvoEkBYMKOgCtTSh1UJyGrTmB6KfwZOoWkGLDWrUl7MA3AsFJcqcahPcOjAZ94ndoKriBsmuUH9WisTQlixKg8AlOfTPHvl7wC2E7C/QmKKsp8xX0oIGQ3pojhfPBwP4w07SXXKbW0GF4emOf/y/JKkOUuiPICWcZOsrCTwGOpOJ4xlQOD0Isr6w6Eses7saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y32AomQWawSt5k6hrMn03HlEv57jnzh+aBey1ubN5tY=;
 b=B2Ho7QpW3BFYT+W0Lo6K7C6FzZ+Zt8aN/rrUdKcG6T8eYBei/O2ErbC9x/SXr6wOtmsIaT9Lf+od5b8yVPDql9UXM+CngT5dC3A2jnSbM0u0EN37jMiOq/Td8ZUmzRfJ15hPQflL4uPe9L19nTJptnE0VWCPX11lKurXwU3hbuvBTLTFZmIVnLLQA8wPfvHAvyxOezBqa/c88yDu1vZzLxKLPE+JUVZ5H28r+y+Sb43QoY06r1VBx9tKQ1n9NoxTDUaYf29XGxjNV3CGx+ooQB6BmT8Bw+o98vXoM6p1l1WOfNx3KIR5bwGHwHPz0D62lcjeSKkLAm8YdqUPzDd8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by CY4PR11MB1382.namprd11.prod.outlook.com (2603:10b6:903:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Thu, 19 May
 2022 08:22:13 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::1cd4:125:344:9fc%7]) with mapi id 15.20.5250.019; Thu, 19 May 2022
 08:22:13 +0000
Message-ID: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
Date:   Thu, 19 May 2022 16:22:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     dchinner@redhat.com, amir73il@gmail.com,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: warning for EOPNOTSUPP vfs_copy_file_range
Cc:     He Zhe <Zhe.He@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:404:29::33) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa89fa4-6555-4dfa-dd46-08da3970acf9
X-MS-TrafficTypeDiagnostic: CY4PR11MB1382:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB13829E36D0EC615F32AD9B6A8FD09@CY4PR11MB1382.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4PxemTYMCCflT/gmQ+InuL8DZdusZDG24v85u8I0LWSuKPDY3Unr8RUJT0/fdPj0brq6KnnPpTGNmkR5v4Qnjdm7I68qaRXJwQ6Qb3Tmj/BmKRIND50Yu5+3Qmuj0FLrVcW+w039SFB2LQd36TK9KSZC8sU/LXwlV69uMIARzYGz1l0nGYgAS1NDv8CgkDIBWKFvJuwAigTuc3GdJSiL0LTefpeDG4410TNo97qY3rLyjZ0yo/g7RyHUy5Qf/8TAiW2MkOn8RwXk6KAZvJxZTzNzFrqwElp17MwaAEeLEjx8iKldlykUykO3EZcrItt6n/mU1tJSUF6Zr9BYAW/posJ+IChay4ClW+jdf6lbqLSxNZLnsi0vN1EKJ7acrg6eHva62rkeTsNkWj+TndO5zUkaq3s03f9T7HaX0+JbSPjsX4pYycOVO6d0lCBkS5jTtS9V8XLJ2Dda+6tTSkdIvv4tQR/hvd3og3qi9jOn2CrnHI+E7HJcKJ3NMIAxLlf9WCqgontm/EKGvzwePzJsatrZ+ddp4smQ5XCSTq+Vu5hycAib0m0cWPW/F/5Ttja7ylGzfEaXSYSPzqgSrelrCczUWUDhHe5blLFz4eClO9v20udbMjTWB6h71ka46NeNCjHmANBpmwoKMZCRj7vJSWQhdrzVFgfQDJRrYO/G2fmJ4XKWIwa8Im0p34VFckMw5aGqTRTjy6Q9xrUbYmpOpfw5ptVA4FV8Q4eIkxovtrK9uakQWmjoIiQS+mStRXUUhbo0gwiwPoYP+3TxSa9FxVmWyPVimp5oYlwJZgwAI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6666004)(38350700002)(38100700002)(52116002)(186003)(6512007)(83380400001)(110136005)(316002)(31696002)(31686004)(86362001)(8936002)(66476007)(6486002)(107886003)(45080400002)(66556008)(36756003)(2616005)(508600001)(66946007)(5660300002)(6506007)(26005)(4326008)(8676002)(58493002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjh4ZWYrUUdmNUFnemhxVHF0TUxJdGx5L1ROZWQ4SDBySnZyZyt0ejJhYlhS?=
 =?utf-8?B?K2JBNVY5djlRMFdwQ1NUNEppb2pWWDNPc3pJRWZvaWpRanVhTTJxaW9yWkpi?=
 =?utf-8?B?by9zbXdRenVLRzBHZm9hRHdaWHpTWVBBTHQ2M3huS0FkMVg5dHN2eGdzYmtO?=
 =?utf-8?B?M1o5UU5YcTdCbjFoQWR6UFJjeEpRVzRXcXNaZGp1T3hKazg1WkI4VkZZSndn?=
 =?utf-8?B?NTRUQUxaMjRFdHJIa09kQkVtRHFLZ3ArS2lBZnZhVmVjbGg0K0EwTVIrOHNq?=
 =?utf-8?B?OXMwdUNFdGplai9KL29hZDFPU3Jta3VaZ0dON2p4aVZ1YURlYkNsWGpMQzJ6?=
 =?utf-8?B?bXdiSy91N1dxUjlsVks0aGJYUi9mOW1lUmY0clFYUVlDVjhqTk9hU21rcnlo?=
 =?utf-8?B?aUJrTFVRQkNIMDg0Nk9XR1RURmJiWTh0ZzRhZlo0ejZEK1VtYThPSndDM1Nh?=
 =?utf-8?B?Qi9JSjNBMzNkYnhkamlHM1hJTklBTGFQMWg0cEd2a1kwYkJSUUhPdVlZanZM?=
 =?utf-8?B?Y2ZaUmVlWWZ2cHIwSXVKc2VraVJxYSsyVHRGd25aOHFVWHFvOGxXNFVTQmdK?=
 =?utf-8?B?L0FJWnUzbzlmSlFteG5LblZFd3JXOStoQlZxQVk1YXVRZzdTdzV4TC9yQ2pS?=
 =?utf-8?B?c3BLNHdsdXBFM0tDMGdESkVsNDdPbHZzYlBlL2FUTDFKUWdNYnNEVzF3dkpp?=
 =?utf-8?B?bituaFVsT01wSzFKNEtpaXg0Rml2VERuSUxUYUFsS25OaG40VlpCZUxJUm10?=
 =?utf-8?B?QTNzM0V5K0hEcE53WTZzTjJRYW5KRDVOVmVjaCtTVlloZkQwZjZkaGxnVDh4?=
 =?utf-8?B?Rmxyc1loazJFNmYwVXVFK01ubERJL0g3MGlIUzFVS2NLOFdXeEVyZzhZQkhn?=
 =?utf-8?B?RE1yVHYxaXREbHFSaTcyYit1bTlaenR1N0hWU2hmVnBuWEZMTEpSaE9xYU1Y?=
 =?utf-8?B?cE9jdnRueEhZcUJsVHB3VWdxdW1FTGR1cERlMFdEWUdud2Nac08zSjdoNHRN?=
 =?utf-8?B?a2dCZGZmclg2T0dPRGlxVjI0MTRxV0Mvc1RDZE5tZ1ZHbmYrRkdlYXZGbU1P?=
 =?utf-8?B?Y0laMU9RMTBKamh5aHoyUEJPM25COTNIZmh6ZElZQXFzNkhyRGZmQ2pDbkp2?=
 =?utf-8?B?R0JabDJ0RU9KcHBleTZYTXg4TElsRmpPZG9EVEl5NGowZ010WUhFMmJFQUd5?=
 =?utf-8?B?d3BabmEyaVFyNVZNQzY5SEZnejlUS1Qra3JnaFE2QUtJTnZubHRqZU9xd0xj?=
 =?utf-8?B?bHkvMm42YjdBanFEVy85dEVtcTk1LzVLSGdiejJEQk1Fbjg2NXZiR0ZmQ3A1?=
 =?utf-8?B?dkwrd2IvMEVIajVLSG4xbnZia0c2ZmRLdGpvYnRPWHBtODBRZkYreVA4MmNk?=
 =?utf-8?B?TUF2NXRUbG5Ta2NheU1HR25yeTF2QTEzRW05eGg0emdiZmJSMzFLa1Z1V29k?=
 =?utf-8?B?M0xuSjNDaDZrNXhXcVFxUTY3SlBDcS9KMmVBQVdSMHcyV2JGZjljMzM1LzJa?=
 =?utf-8?B?MG4ybjRlVVFjdHhFenUva3VSbGZZdjBEMlBqWkdDbnl1Nk9aNTBCYzh1TTFk?=
 =?utf-8?B?Sms1NFpSaURUUEFYdlN5OWtDcWt0TlFkeWJFUHE4S0JNcGVwUnRLRDhZYjJS?=
 =?utf-8?B?eG9LK3l6d0xFT2N0cFNNNmM4eG9JNzJFbUNqbVcwMkhJVm1hUGZCcTc3QUJE?=
 =?utf-8?B?dXZjTnBJazBheXByTmZ3eFhreGI4elVyVytRMGtQR1luendTR3o0Y25uZXp2?=
 =?utf-8?B?UXFMRUpzZkc3N3c2UkVKTFZjU25Zdjh4b2FlQmEyLytHaG1maFFtYlBLQVVp?=
 =?utf-8?B?aDZLbnVwR2hPY3RJaHU2VmE1bEZQTThiM3BnVnNVTGN1YmY4RlMvVDJ3cjk0?=
 =?utf-8?B?VHNjYWxHcWlkY1kwRllGZTdJRkNLQk5LTFZObWNaMFA3eHlRcTVTb3VxbUl2?=
 =?utf-8?B?ZFJqREhwM2RzVkh6S0FIWWQyd1VPSjdPUUFJWnhNemlSUFNMUWdzQVdGbkFK?=
 =?utf-8?B?WlFPcHpaWjBJa2ZhWTZMZG9yQXBNK0VtL1AzWVFManhRV3BPTVBHdnBsWHlS?=
 =?utf-8?B?RmdjeGxnYkVIWll2NWxaWVB6T2p1ZmkxMjlNRTcvK3lidThuK29wSHFSa0ds?=
 =?utf-8?B?amVncElDM3NvVy9kYjhvL1BhTzBNOWtMWnNPMjdaWDFIRGNjTXhjMkFaajZJ?=
 =?utf-8?B?SzR6OWZVWDBJaEZTS2RMbDlFVTM4VnpIV01uRFFGNHFPQVdKbUh0T3dMQThJ?=
 =?utf-8?B?Ull5YjlkaSt1ak9wM2tCY1ptTXR4UDZVdWlkM1dQZHFXVzI5SWhkUEQ5aDJq?=
 =?utf-8?B?cmZlWTVxN1NFMHIwK2FqcXZLZ0ZSa2VON2x4bGNjem8vcFBoVGdkQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa89fa4-6555-4dfa-dd46-08da3970acf9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:22:13.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uQ8v7z1E60kmeH3bRT1psUlBk8WiwLaQ/wud1/i9y42iWof+idFQyCzFzXnLPAL2+//lhuYWV4hDRQQgWxIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1382
X-Proofpoint-ORIG-GUID: Nd9TybIGQddoGZMGCj4sBBHfs3u4dVlg
X-Proofpoint-GUID: Nd9TybIGQddoGZMGCj4sBBHfs3u4dVlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 mlxlogscore=877 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We are experiencing the following warning from
"WARN_ON_ONCE(ret == -EOPNOTSUPP);" in vfs_copy_file_range, from
64bf5ff58dff ("vfs: no fallback for ->copy_file_range")

# cat /sys/class/net/can0/phys_switch_id

WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+0x380/0x440
Modules linked in: llce_can llce_logger llce_mailbox llce_core sch_fq_codel
openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
CPU: 7 PID: 673 Comm: cat Not tainted 5.15.38-yocto-standard #1
Hardware name: Freescale S32G399A (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : vfs_copy_file_range+0x380/0x440
lr : vfs_copy_file_range+0x16c/0x440
sp : ffffffc00e0f3ce0
x29: ffffffc00e0f3ce0 x28: ffffff88157b5a40 x27: 0000000000000000
x26: ffffff8816ac3230 x25: ffffff881c060008 x24: 0000000000001000
x23: 0000000000000000 x22: 0000000000000000 x21: ffffff881cc99540
x20: ffffff881cc9a340 x19: ffffffffffffffa1 x18: ffffffffffffffff
x17: 0000000000000001 x16: 0000adfbb5178cde x15: ffffffc08e0f3647
x14: 0000000000000000 x13: 34613178302f3061 x12: 3178302b636e7973
x11: 0000000000058395 x10: 00000000fd1c5755 x9 : ffffffc008361950
x8 : ffffffc00a7d4d58 x7 : 0000000000000000 x6 : 0000000000000001
x5 : ffffffc009e81000 x4 : ffffffc009e817f8 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffffff88157b5a40 x0 : ffffffffffffffa1
Call trace:
 vfs_copy_file_range+0x380/0x440
 __do_sys_copy_file_range+0x178/0x3a4
 __arm64_sys_copy_file_range+0x34/0x4c
 invoke_syscall+0x5c/0x130
 el0_svc_common.constprop.0+0x68/0x124
 do_el0_svc+0x50/0xbc
 el0_svc+0x54/0x130
 el0t_64_sync_handler+0xa4/0x130
 el0t_64_sync+0x1a0/0x1a4
cat: /sys/class/net/can0/phys_switch_id: Operation not supported

And we found this is triggered by the following stack. Specifically, all
netdev_ops in CAN drivers we can find now do not have ndo_get_port_parent_id and
ndo_get_devlink_port, which makes phys_switch_id_show return -EOPNOTSUPP all the
way back to vfs_copy_file_range.

phys_switch_id_show+0xf4/0x11c
dev_attr_show+0x2c/0x6c
sysfs_kf_seq_show+0xb8/0x150
kernfs_seq_show+0x38/0x44
seq_read_iter+0x1c4/0x4c0
kernfs_fop_read_iter+0x44/0x50
generic_file_splice_read+0xdc/0x190
do_splice_to+0xa0/0xfc
splice_direct_to_actor+0xc4/0x250
do_splice_direct+0x94/0xe0
vfs_copy_file_range+0x16c/0x440
__do_sys_copy_file_range+0x178/0x3a4
__arm64_sys_copy_file_range+0x34/0x4c
invoke_syscall+0x5c/0x130
el0_svc_common.constprop.0+0x68/0x124
do_el0_svc+0x50/0xbc
el0_svc+0x54/0x130
el0t_64_sync_handler+0xa4/0x130
el0t_64_sync+0x1a0/0x1a4

According to the original commit log, this warning is for operational validity
checks to generic_copy_file_range(). The reading will eventually return as
not supported as printed above. But is this warning still necessary? If so we
might want to remove it to have a cleaner dmesg.


Thanks,
Zhe
