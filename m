Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAA534068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiEYPcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiEYPct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 11:32:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82109A448;
        Wed, 25 May 2022 08:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZhecps911d6t6gMr2pbT1wS+F+KM8Nyk7L+DXuacGgj+YZTWZ9gBkvjwBiN4ZpeJq1rd96+S7ivtcP49tq0f9fGrT5bGwEjuO2MTfNlmUSySc7Qe1X8cdbrHNhslejt44oEHIsYPWO7YMBcnx39g6z6Msh7PkJ/U/qFn7+aH7qjiNjxx8dmV3BxEez5R1bejlWh3fsXTA33btRR0dNHwkcOI143S+7yCTYOY1DVniDgAF7/a3TFjtnRfgGV/Bdc1uTIL/SEimCzRIWd5tF8MuYEW2VlwuS81TM32gjJL+b8iFc5o+WO28ym5Jr5UAhT2Xguxx1BRXGVkXSxEyulgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPO7AoLOlynVMxDWk+ZtO0SSkoRglLgQBlu+JDb89V4=;
 b=GTQ5u+Q6+Rqj061LVskc1NnRyQNwi8hLgvpW2WUc4F6U3XL/MjPHBgN8Ztw7thkJEZJte+1rzoL1BAe3sd0MJ0+z40Eow1Qq7wlP76xcD6XZeWM8nGtsr1n6zCVDo8TOBWqRbQJxD/seEqtUe0YmUpoqzpnI/qnEhLHXig7zeXzdTIQMEoY+EfTJ3bfKILgjMVxrSvyyGNsdNRN49To8FHoow/rKKReuxJiivucSIdg8YG9rOluBRLSlPrkTOq8NkvwbXeiZuOyG428H4LvgT5ORpWfBufh8oKv3XaS6cPvaynYzDpdKwkWhiR6LnDH/WRsqOEj8vEmMIzrEp5SZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BN6PR01MB2707.prod.exchangelabs.com (2603:10b6:404:d8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 15:32:40 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21%3]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 15:32:40 +0000
Message-ID: <146bd483-e7d6-0c0d-865a-e43124cc06ae@talpey.com>
Date:   Wed, 25 May 2022 11:32:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/7] cifs: Use iov_iters down to the network transport
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     linux-cifs@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <165348876794.2106726.9240233279581920208.stgit@warthog.procyon.org.uk>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <165348876794.2106726.9240233279581920208.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aded9b2e-9baa-4ab3-386b-08da3e63cded
X-MS-TrafficTypeDiagnostic: BN6PR01MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN6PR01MB27079A241A76069E1A63A429D6D69@BN6PR01MB2707.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysUVg0jRdUZo3pFISqXUlfg8lCQcN7sbBG2qvA3nV1OJvohajZQoekzTQad5ehtQOHv4y8pgE4Zj0fGbWXCYXKzunkGyB8GPrHPgybQREaW4wQawhXG7xOf1gZZa3XVP6tNJ2QWjoGuPMkxspvvlq7jzk8EHHLAGG4E24gKprr4yMrp7O/x4poywOTpEpJvEZ7kBdzLcVsdY4fi/edDN1A7VG8H93fbOMSXCedZRTYQMxRganXnSbrp3zdjfQaS09fK9iQL8ArDFxZ5TWg1xE7sG5zvOCyjr2hxlRtN9N2+RwRwq1M2/kpnoLYTdOHpj/OUgxn0CPpyJlnoSW5buSPQGtsZr9kSMNaT8iTlKy29lS28fNfsHXNhigR+OWi0ATSj2qBACl6aOxDnlyEhQU40G+VcFjP10NJydSPRlCtxyLQvTbyfkv0OJJ7fowN2LBabsFDd5SBqkMN+nVkxXPUTgvmILqg4CWZz6lQd0E7jL8qK/cOFEDtFXWQb1CmIhnVjYL11Rb6wdZgDpBKUpnvH5naO4MRSWDK9vWeV4kaSMVXTAelwBLORT3QzuIpo5HAvJPPL0d4yJT3a5SyxxpzQoiG94nCZBtBr9U/R6Oo95iQEwY4YtqvlFa70cCtfzD3A1NFiFGBmfuFraySgLEMC6HMS9xaoyEtaGHxGc7kosGL5Ok9F9D1JTQtq0jIDVfe3V7m3CeY6oaF1jKNuDREpbpwGob81yLABiMPTSgU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39830400003)(346002)(366004)(136003)(396003)(6486002)(54906003)(186003)(41300700001)(508600001)(5660300002)(4744005)(316002)(2616005)(66946007)(8936002)(86362001)(7416002)(31686004)(110136005)(36756003)(31696002)(38350700002)(2906002)(52116002)(6506007)(66556008)(8676002)(66476007)(4326008)(6512007)(38100700002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFWczY3cGdiQ2diTlVZWUNrblVmZ2tCSzRqa042dmNjblloZHBZcWk0TklE?=
 =?utf-8?B?RGVuOUhydURVN2RzZm45b3c0NUQzRUpVc3pGSEJ6eTZlaHZpcFR5M0RDdjd1?=
 =?utf-8?B?RTJlazRXS2xCamh0Y0s5c1plRTBiUXo5Q3g5LzQ2aDE1N1VvZXRMWHcwMVd4?=
 =?utf-8?B?ck54enBtaGdMRFpIdk0rRzhNaWpuMjVuSSsvczA5YzN5MktydU9Obm1VNFY5?=
 =?utf-8?B?YVhmdXBMNy9XUjh6SXp5WTBhU2NyK3Z6dGlpc1lpTFpxeWIrRGgrTFZSZ2Y5?=
 =?utf-8?B?TFFMVjRlVkZNN1BFV3RQNzhNRnR5SVZpcFpnSStTYmxtWm8xQ0RlbzZlVHZN?=
 =?utf-8?B?QS93R2x6ZGJPenNnK0wvbW9jUmJPTDhqVHl4UnViclJjVm5RNFA2OEJxMUNl?=
 =?utf-8?B?ME9xb05LdXdnVEFJT1NHdDBzb3lWakhLcFBaREtEYlNSUFMyTEk5UFRoc0Jv?=
 =?utf-8?B?MUNMTHpPQ2pWMkJBWmF1ZUp5RGNNTkhhQUJFbU16NExOY210NGtvRXQyTGFM?=
 =?utf-8?B?eU1nQkhDUnA4YkJqN2VLV2t4cUlzZTgzdFZsNmQ0ZVQyb05XUnVUR3psZFQv?=
 =?utf-8?B?bm9xa0pxbjNEQk1ZdVRvYWM5NUkvUjFtdWdRVnlCZlVhSW5EeEF6UzExeGg4?=
 =?utf-8?B?eWYrRmI4ZmtRdHBObmVWRjRaTzZoWkM1dkxEbDlCSDRoUngwN1JpV1ZGR0kr?=
 =?utf-8?B?dko3YXdqelNFZnFPKzlKeTNINDFBeDJDMjZqa0c2cjhYTlNGa1c3Q3dtcXJo?=
 =?utf-8?B?T2xKd2FRVmdaMGMxcnd4UEtqYkt0WWwzVitHQ0RPQ2RRYUZhdFd5RHdIQjNG?=
 =?utf-8?B?QTNQcThPS2c0RHgyS0hudlo1ckZsYVFjaHBBeEJUNXA1V010MzNEYUJYMlFP?=
 =?utf-8?B?d0kxQVlEa29PM1Yya243a0JlUFdWdDZISS9FN1lXR1Q4Y3lXdEF5Q2d0dXhD?=
 =?utf-8?B?YzhKcDJFQUhuOVczR3RCZlRFWVkrN1NGdmwwNW02VWUrdWg1N01aeFllcUdt?=
 =?utf-8?B?VzJxSExoWDBsL3JrN0doRUdKWmZDUFVpeXIzVVRFNk9kSng0RHlDZnVDQnpq?=
 =?utf-8?B?S0xyZENYeUsvbUZISm1OdDl3VnBoUWpWQVZQdllEalNOUGg2OFdMRHlQUDdh?=
 =?utf-8?B?S1NycEhKVXpIYWhJR3Mxblp4ZXJPc2dwNHRBWWI3aE1kbW9mV2JrZFZybG9v?=
 =?utf-8?B?eFI5M0dpbXJzTTU1elFCcHJWWkdJQm9HYkVYQWdSUyt1ZytUL0YvbURYcW9M?=
 =?utf-8?B?S2tVNzdHcnVNclNkWE5NeFhUNEZ6Q25CK2hsVmNkcUFrVmIySFhaejRDNkQw?=
 =?utf-8?B?Tmo3Q0w5b3kxWjA1aVBsa25aMjRjMGZ3RFBVcURFamQxTDNkNEoreldFZ3k5?=
 =?utf-8?B?OWVMVDZmZDlWZnNzeXUvbzIxYi80RFc5MjlKamlIc08vVlEvblR5ZFpTZ1FF?=
 =?utf-8?B?c2NUN2NsV3hTQ0J5K3FTTFk5bDRzWG90VHliNTA5MnZKYUUyRlJVbWEzZVZt?=
 =?utf-8?B?OWsvMS9EVFdWNjMvRFY4K1JOOTVUaGVsZm1nRzlXc1BMOWd5QkxMTm0vZy84?=
 =?utf-8?B?dGdEN09RMXptQ3RlY3dPWEFaYWF3SW5ndllkSFMxZkVsckZGREczZklIYVNF?=
 =?utf-8?B?UUxRMVUxa0xrSkhpMEYvNHVPSUpqLzFlZGpQN1Ivc2wxRDVOUHFKSlIzTlVH?=
 =?utf-8?B?ZFkyYzg0bWVwY09NKzIxQVNlSTFqTVBNT3l2Rzg0RGV1OUJkWGNJUkVXR29s?=
 =?utf-8?B?YVN2bHQrci9JUTQ1S0hjdmhZVVZEbVh6aDZCcVYwRmpoTll1NnB5cnU0ZG5r?=
 =?utf-8?B?dmhxck1VVXloR1Y1U2JXMXRNd29zRmJxdmFXZHpibDlGemVpc29MSHBISnRF?=
 =?utf-8?B?ay92QlRvWCtFbDU5UmUzMWh1YmpPODh2SlZzK0FvUTdjanJ0MXhNaEpuaExy?=
 =?utf-8?B?eHJRYlRmMm9LMVVQRVlSeDM3REZRQTVGK0hrU0xMSzBTWDJuV2pBcU1TYTZD?=
 =?utf-8?B?SUl3ZHpOWXYvcXZ3Z29TbEpZZzVjV0N5cHN1dkhuelNReXptRmNqeTcxMGUv?=
 =?utf-8?B?QVhWb3NFOUUwb0RSbWlNT2dKQWo2bDdLSzYvV0RoT2l3bkQzM3p1YXVDbUFn?=
 =?utf-8?B?dVdxMFVLVktpUUdiUXl4b2pMZ0lNQVBPQ0RiSGc3VEZCMW82V0NmaENWeUds?=
 =?utf-8?B?SGszVnFEVzhraDkwN1pVNFNQTTdMdk1DMURyQVVBWmxYUkw5bG1udjd1NVlK?=
 =?utf-8?B?cG01VWxVZUpzNmQyWW9HcHNOa05rNXltL1REMG54STJUZUQyakJjbFNvRW40?=
 =?utf-8?B?NUVLZjllZXNMN3p1SHNCRnF4Mm9mNU1tS3ZqNzA2SzRWWkRXV0J2Zz09?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aded9b2e-9baa-4ab3-386b-08da3e63cded
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 15:32:40.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Mk1TLHjF4ZLL4kEFOYo7F5nigCZYY06P7CuR7iQqCUU0Qoj9wFPy3BGsrrEAg4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2707
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/25/2022 10:26 AM, David Howells wrote:> There's also a couple of 
changes in patch 7 from Namjae Jeon to make
> soft-iWarp work.  Feel free to discard that patch if you get a better version
> from him.

I think we should send that patch directly, and not include it
here. I actually have some comments/suggestions on it, and the
client sge handling, which I'd like to discuss separately.

It's fine to keep it here temporarily, but it should be dropped
once this series moves forward.

Tom.
