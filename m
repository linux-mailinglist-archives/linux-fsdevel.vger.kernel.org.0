Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98A53E4EC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhHIV4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 17:56:20 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:1857
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232193AbhHIV4U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nzg0JsJe3+u5NO7aRkKN43ICh00ZXDe+OW0A/RD+LlkuqiLbY1DiZIZ4GRoqcQ0HfrFjnlrql/9bLYpYcdcki+UkmR8suztzR8D7Ofvrs/qtBc0JEC2MLS8Uj9b+nysfWTlozzkLTBDZE+EuiXOt43VOWTTMe5u55Eqz/1pgAHj5iWrDsezF6QeAFuQOGQQHqyT2zq8opGmwl21gpHb7TeTSz+MAKWrcbiec8ze8ROsQ2/4qiOz/J8XJCQ96HGWfTGfw7LdXcq+5erG9O0JNlXONqoJ1gzXfXPJdu4RjEbSbavorWVnGzHtIJZEomBNICCA2fKXPQynPfVFe7WO5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjfqcuynl6MNwWd/ZCoVZg3ncqANglufLbMbDorr4IU=;
 b=Eb5d+tU/FMpC17fcA7BgpwhTd6835rEtKJcRmEEujF3wEqDplREPU+VwQi4GUQG/WInOQGQvrU6vcpNJ10PEYJs3Z8z9dXlsd01NMq3KVysnNHTW1f3hbDXYOnCcuM5naCStFg4Cq45qJnuHh1qNfZT2zZjNVCzQWiZRIvrGcItUqQgq3rB9QrndI2S3GhcaKOUoI7Mm47JXy3O+vdcSMbaOAmrffV8pjZxsZ9hdiu24b/LfeojqdICMK6OtkW6K7b9bmqTVczsOTqtAEcME66aGbdwR4AyqJ6BAmB88zxSQWptANlVu5PxJqpsqMR7QNc9u8hYxr5WkuziVd+fBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjfqcuynl6MNwWd/ZCoVZg3ncqANglufLbMbDorr4IU=;
 b=FSu0tPPV2gwlr3Lx/QgZ8K7q+i6UTH800vC3B/j13KkRO4q11lhf8CsgVCTAE1Afmq9X19QEvU7K86G5wtvIKaSvoxY4CZ83uzbbzyCtuC56huvJQ5jaWMywx+Hpitpemfmt19cEiO+rG0DC6Ea9WR61BFiGYd1louHCe8DLLxE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 21:55:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 21:55:56 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <YQR+ffO92gMfGDbs@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a8a6a63e-3bb7-47a1-1427-55633f1bf211@amd.com>
Date:   Mon, 9 Aug 2021 16:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YQR+ffO92gMfGDbs@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 21:55:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9c3def-6ac3-4a7f-ad85-08d95b807723
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5295F82C01BEDC78DB002AEAECF69@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va1GgnlgkQoGJwHV4u/vWPT7qTpos8azTAmvWS6mQTBalS5XDFQ7rPECEiFxbzhVX4g9ynz6AYUXHBRPGK/BG4lHF214foWL5qc8Ipuv0n5mmNDzMO6Hv31jefLDxr2WadSnaBSsjhcOlIOeTWLFx35539aLQslnZfOQcrR9HIQ/6Jd3qwyUn+WpQhxX+RMaadPnpPiWvT9tSAdv9jKY2wvGt+n0iyJAStAkjw27F0ml616aW8od/L4TyCN/Rsf541EY8pzky7JXzvLU7/IGPLbkS9Hvxze0OonQm7R88g9MhsEH3AoxCa1Dm0lfC8HR3hmxX1uEP24QfIQXKcPZfwRKBPLq0NW1sw827/Ze3N7ol42kAYvvUSlkfJ1fdqtgA1kGUUXPxnFYsMw2nJtU9v6jqjnhxQynBDVvxyErLtGxsYZAlEmTNvdX+nmrFLK4DICPDMozvwfe4Oj00+8tawhx77i/3HhvN/VZYNdWL+sJYOkHz2yNX+Lwy5LNmgFVKmK14mEy7WoQSf1Xy8xi5vf+Mxe7pordAYQihwWwnshQp3BI/u3xhBqUxlGblRIQPkCHfOBx98RbAX43hywnlXnNdkX/s+2X2x6Pi/xKfx8gAVBEPaD5OgvLqBbD091GXXkIopa3grc0gvtmehCybzehCkXBaWrV8m3OjyvmpEFoODxwI3Yf98qWX4ZcfLXnsmSKLIhNbAq0Hm0Db0p2zYqIPigk2iJAVqz1CHGYfUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(956004)(16576012)(186003)(6486002)(8936002)(31696002)(86362001)(8676002)(53546011)(7406005)(54906003)(7416002)(478600001)(316002)(2906002)(4326008)(6916009)(26005)(2616005)(36756003)(66556008)(38100700002)(31686004)(4744005)(5660300002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZMNW96ZEk2QzY2UndOajg2OTJLTVYzanlKMlhka2FENy9NeEFGRXJETkdQ?=
 =?utf-8?B?aWtaNU9oOCtFYkhVWnJpME9QQTdwT3Q2cXdlT1lxRzhuTHkwdmFaT2p1Y1NU?=
 =?utf-8?B?VFVveHVIdERHcXNDOGs3Rks1dXlGeUhsc2FqT1BDTlZkNFRuQndsQTl0OFo4?=
 =?utf-8?B?UllFdXU3RWVUOUFoSnkrOUE5SDVmVCs1YVV1SytqVHNEQW1zQnA1VnIwQW5Q?=
 =?utf-8?B?TGpld0lkSWZOWEw2OThaZlY3NGs5RG5vSTlKRkFlbUxveThTL2dEM0g3dVpv?=
 =?utf-8?B?TzZXWkl4WkRhZFViMTc5dk43UHVqRlNWTVdHRDM3N1BRelVrbHVhaDM4N09u?=
 =?utf-8?B?Rm0wcVRTYS9wSzRhZEdUUkVBRTAyb01zUkdsU1pNRlhPanpvdXlBd2RLV2NJ?=
 =?utf-8?B?RWN0YjRZTXVSVG1tK0k5cFRuRkd5Z1hiRFJ3dGNYQnU5dUtqVDl4aGtWemhz?=
 =?utf-8?B?czdBOG4zSzZhQ3ZhK2Z3R2Z3c2xDVnRqc0VyWFZIeThXR054LzF4QTlOMXg3?=
 =?utf-8?B?N1h2bDRieDB0VEczcXpTSjNyTUJkY3ZtNVB1amhjTmVGQXdUWlVVcVk0L0FF?=
 =?utf-8?B?N1Q0L1pxUHljbjBXZHY2TWNMZGpUSTlra3ZHV2NNdWE0bmNoVFNvWEtHanR5?=
 =?utf-8?B?Y3BsTUdwODJXSjhDMS9oNSt0WExzMDUyYkdzWFE3Mm9ZUmdsRy9BYnZjM2R0?=
 =?utf-8?B?RFVuWlBheFpWejN6S09HSVQwNnA0WVJGZUhkUnhIamhGN1dQajgwSWtLNlVO?=
 =?utf-8?B?a0JpbTNQWTZUZHRlRkZKWlg5TnpTcE9yN1BmZmN3WE01YXgwMjlJMSs1cXdx?=
 =?utf-8?B?QzVOMUtoeWN4bytkVjByd0drZlJBNmFtblluOEwvMEpMcGl2T3I4c2tYbERZ?=
 =?utf-8?B?U014OFVoRUVxSGl1RGo4YnhTSTFrcUQ4ZmYwMSszc2x3OFovZEhLUnFWSlRk?=
 =?utf-8?B?aDNJWnJwaFhTUTEvZitBMkZPRkZPNE1xc1Z6aC9JaFdrOFFQbUlkb2hJOGlH?=
 =?utf-8?B?MG9iL01CbERyeWtHRDJTd3pUVDlMS3hod2tNVW1qbTRJN2pzbzRIS0cxSXg3?=
 =?utf-8?B?cVhLZzdZbjAzMmIwL0VvcStiQkJVSEVuMmw3cFkwQmw0Yzh5Z0tSWlVQNXp6?=
 =?utf-8?B?cTM4bGx3cjVtV0ZBU1dOZlN3eEJNVk9NdDBaMG4wWEpPeU1mdmJrbmhVM2VJ?=
 =?utf-8?B?RkMvZ0M2TDkxQXdnbWxKbWN6UkdIaS8wdDFZS1hGRXdsZ2JRcU9PREhOMmp0?=
 =?utf-8?B?Wk9LcFk4eWQyV3BJTTNyMEl1Y2YrL0JPTDRWckd6OUFLbjBGZmFFbGdja2N5?=
 =?utf-8?B?KzQ3WE8rODBHSDRxLytmSXBFbDZVL3R1TStDM1ZicjVKOG9aU0tWZGVLb1Fa?=
 =?utf-8?B?Y1hjUGFscjNhUjRaV25ldllCdGthamREMVFiZ3Q2UThMTTNCbThLNlVnb0g1?=
 =?utf-8?B?ZXQ1R0tZWWZkL1RjTlYzY2J3NncvNXplQSttT3R1MjFrZDJXSDd2WFhNMUJx?=
 =?utf-8?B?VXlyQmNFSDR2VzhRVTFUK1V4M3h5L3l6WnNPZ0lteFprQkhNK1JTS3h2cmxq?=
 =?utf-8?B?YTdMVjd4Nm9zYkdiMit1bGF3VlJIdHdlQUdRMFVvQzlKWktFeWJ3bVFvVlhr?=
 =?utf-8?B?Y3E2dVFvK2NROUdqZXJmWEtWYStMTW42bWR5K2g2aERiOVRHZytIWGtqQ0tZ?=
 =?utf-8?B?clhaZVV3blo0L2dRbDJYMUM0QmVFTGQyRjVjenYrN0xoeVhYblUzcFJHb3lu?=
 =?utf-8?Q?hU5Nt3rVA6gzUChUx3/nd3C3z1WuFX1/ao0tSAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c3def-6ac3-4a7f-ad85-08d95b807723
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 21:55:56.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVMUdJrJtSzpeS/OVG6KXOyXh5yqKz+0hfHnt6FLUw5aHfd3whCwKAMeR092Kk8k7apxnVxc1jIYxygM9OqnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/21 5:34 PM, Sean Christopherson wrote:
> On Tue, Jul 27, 2021, Tom Lendacky wrote:
>> @@ -451,7 +450,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
>>  	 * The unused memory range was mapped decrypted, change the encryption
>>  	 * attribute from decrypted to encrypted before freeing it.
>>  	 */
>> -	if (mem_encrypt_active()) {
>> +	if (sme_me_mask) {
> 
> Any reason this uses sme_me_mask?  The helper it calls, __set_memory_enc_dec(),
> uses prot_guest_has(PATTR_MEM_ENCRYPT) so I assume it's available?

Probably just a slip on my part. I was debating at one point calling the
helper vs. referencing the variables/functions directly in the
mem_encrypt.c file.

Thanks,
Tom

> 
>>  		r = set_memory_encrypted(vaddr, npages);
>>  		if (r) {
>>  			pr_warn("failed to free unused decrypted pages\n");
> 
