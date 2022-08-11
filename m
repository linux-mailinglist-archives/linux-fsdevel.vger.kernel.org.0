Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DA5905B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiHKRVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 13:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiHKRVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:21:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE40615D;
        Thu, 11 Aug 2022 10:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZSaBef4TEsOmXRDVarUw+7ZrGNXv2K756yktGPhrOlVVGXAUCcQvxii/MHrM8TXXTF+JRzP9B1zwfR1AO5B34aC1kVoccDvhMuEfCwuHug/v0z8Eu3fBOKizfta1ft5FzazMy3BGYMoFhJsxaIZYWTV43giqDyW85EJd1czC7cVafNh9Eoxi+zMvosqDcRTT18SecutEU1V4rciEHfK50pXR6Vusfwp7Vr3rv7OmhzmpL3yWBAizCvgOw1EvJ2f9O4jXP6U+DBCATiCgf6pUUYHvXhv13qEoNKaOEbfCQu/cAPiQcPTa665AcF+pFqDX7slg0qJPKvzJROwb+fQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0Q+GMF8RnpImoOKnalWiQCx1kkpxe9UeWby1WECuPo=;
 b=A8HO17JKeO5qACAGm5sV3V8Oktd/wSvWEADN6Mz4/ZCgwzPEjDpz9DZVauE5yXvaoJyrCRpfV2t7xmXpY/IpAs0HFnBUXWCJCKuobYhN56IX4T0iirDrQAaRubB5ItaJD+oPljhERpPJAWOvOpZ7NWXDsHfnbw1G4oQixlSHkSkRVi2PDZUTvSToT1qfZr07P3Tri9rWMUCwZZRaO2YeYyCBILe8r1f5VI06QQBVntk/Ac/GylxzMKWVwOk/NG/zcNL0sZja/EiM8tFO2MIxk0x9tN/Y7XqEEhgAckKVYSU/NHBDFhHgtlfttxHjRJ0Uat8qjVubTC6ewJBWnsU+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0Q+GMF8RnpImoOKnalWiQCx1kkpxe9UeWby1WECuPo=;
 b=DxS3JzX7bhK0Q6a6xk0lm4NK75h6bnkTH6HPH7w3tuZmIphCK9ckWD70FOQu22w8LCmE8BC4IG+N0TtgSiL8OJfTsH5IVOA4FprlJGP59Hv8NvSIzT0j1fFAJdPa9KQ59WJ2mAXn3zyvWnlaIwzAnr6fNgvqbNLmAKBLhffCrTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 BN6PR12MB1331.namprd12.prod.outlook.com (2603:10b6:404:17::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Thu, 11 Aug 2022 17:18:55 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 17:18:54 +0000
Message-ID: <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
Date:   Thu, 11 Aug 2022 22:48:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379cd098-9b17-488d-83c1-08da7bbd9171
X-MS-TrafficTypeDiagnostic: BN6PR12MB1331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc5lnYGd2vo0XhUDJcP36nHWl9vMGYwfiHWkAwwBnuDDo9wx2AVhNarl6CPGUe/XmbKOvq7CsflgDLlFw7Jf5zutvXURws1N23muzArCppBlkAViL3Hy5c+GcclFEOdsfvtr1neAU5AU8xrOUqTtPVC7hN7GupGPBUBSjFhogsj7fVipssZw9OfoiPmaspNG5/bE32d2uv5w9ZnL2hrhcr5fed3utQKJaBLswubr66xJi7eunVhLBa3XalQkpcRaBecNKrcZvLTIJ8LVw6cKkrF1v3Eqq18Gb4upnIfePuCdhsUOnIFIEPPj0mI8OWmuSLuykyjbBP6ZyPlqRVy6Gr8VpQeRIG7b/AphgDt7gvhHkRTrbcKa6OT2q5V+oH+A4pAfemsNwiJ5E/kAmcxKD86eqGT5mT2s4bKqZrl93eLCAZ7APsuQ/a4XQ6WyZTkojY3MGSOugWYNogw2O/Av1vLh6iDan8JtQ89jFuGekApn2KFzP7q0mHURFO3buof7WP2BTtR3/0HycTz4u169cSRrCcLtwWuGzwVKpiI6TBAH29vhwHP9IM+TnFM7hts8Zyij8aOJPwXbULOdiLcVoyFjtIK94nf0tgEltDXYnsUP0f6lXdPX7eFWJTse/wShP7oMx1YrKpWAK6C6RYgZdSv1XLc0SfP9gYB1jmVMg9ec5NbhJDSa01h1uwGlD1lgUrLlUAK5xLorGCiZw+NKtli52i/1b1mizyXXOSKoGwpQt9r69D7uTGfLJ2DeULtVQ1UsWJ87djWag6uXDFiOqbkDkSHf+T8ret2NnvZcNrZZLhilisG0FVEBILHhoicd6QDdtNGJvDICQalSs0fbuhW6ZZiJWDNcGCs9YQIjJT3iMCbEG40XuxN91ZVhWvTEyil18Oj2zNEKlrOaaYDQMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(6486002)(966005)(31696002)(4326008)(2906002)(7406005)(38100700002)(8676002)(66556008)(66946007)(66476007)(5660300002)(8936002)(316002)(110136005)(54906003)(36756003)(6506007)(53546011)(41300700001)(186003)(26005)(7416002)(31686004)(6666004)(2616005)(478600001)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVB6YjYrcFEyeXdqSGsveVFwSGN2MG1KS0xydE9UMjdvMzA3MWJtSjhhSElr?=
 =?utf-8?B?clRFZUhoWEdJSUxhMFEvUWNXVmNGZnR2eEdQM1FCV2RwSjBqSzcxTWRBaWlz?=
 =?utf-8?B?M1Q0cVFuUDVXakhBdGhWS1VtczRxYlV3NEk5ZlpyZ24rZzZMN2FFRjh4a0FU?=
 =?utf-8?B?Uk5VUUU1bGhycFB6SjlqVU1EMWlXaHFFSFFkWjRPWGN4bVdKMVYyNkhJdEx6?=
 =?utf-8?B?eVg5cUsrVk11RStYTGhzSVN2b0ZMUWhqaVEyOFdFZDhvclVLckZGajBwMzFD?=
 =?utf-8?B?a1FhK1JTZDEvOXpneU5ZY1RkS2VONldJcmdweHo2blRvQzVrYWJNck85SFRZ?=
 =?utf-8?B?cWtuK282VUo3cXRoMStPV2dwV09qdDlnNWdUek9DNThTZWhKZ2FkOTJNaVhp?=
 =?utf-8?B?ZzNkMlM2SlQ2Z04xanpqUWM2b2liK3FYUXdvWmhxU0dFbHpxMG1qU1JNa3JF?=
 =?utf-8?B?RkV5cUhnZFhucExEOXd4dUF6RDV5OS83cnRjQWtvQk5RL3gxMGpYMUpXOGFn?=
 =?utf-8?B?WDFZSFlqemhIYjZ4SGo3YWJDMEp4TlJNektOMHlCN1VIUlRMZk1oRXlHOGg5?=
 =?utf-8?B?RjlURjBYZ0tuVVdoVWx0TFhRNEJ4aWJMZElIR2lhZFc3eElBT2dwM092NG5E?=
 =?utf-8?B?ZjRpdThTUlpxWTVvZC93ZFg4OTh3SjJGblBlN0NFZytTNTVvcHpPN3pGOVJR?=
 =?utf-8?B?MWFGeXo5ZTIwRDhUTlVZVVdsaEZMdnVIeXJwVmlsaWlOSUFZZEJEVTlVdGl6?=
 =?utf-8?B?d0FkM0NWajVwaS9TVVVOZ2V0OUtZa1RBMEtLR1dqcEJUT2p1a0NtdTZCVGt2?=
 =?utf-8?B?TzhZUk1mL1krbGlFNmE5TlpPVXIzR0dvYUQvaTNTNG9mNVBNZTN4NDY4Y0VK?=
 =?utf-8?B?Z2hLVHFDdm5aeHo3ZWR1K0xxd1MwdGx2SmRTNlh0cmhiVENNaFJNdWpiK3hK?=
 =?utf-8?B?bjdRN3pQZ2pURTA1NC9xdE1GRlNFMlZwdXdTSXRRTHNMV01yL1hMamdKS3Jr?=
 =?utf-8?B?ZmZ2NTJ1MU9UakZGMXlQQ2g4U3ROYmlrUkE1b3RrTDgxTkRBVkZkR1pVSENT?=
 =?utf-8?B?N2RkNzdGMjR3b1NsenZkb01xaFJaWGlhSVJQMTlmc1N1R3IxTzNJbU9VUEYv?=
 =?utf-8?B?MkRRckh5cXhYZE1sL2ZNVTNIbzBXZVRhYVE3MENDcDVJMTNrUTJMRW5Ia2Fh?=
 =?utf-8?B?dEFYNFg4djFsWU9LcDU5K1BQY2pkYVl0d010NUE1a1JyNXprZGFuV2dkWitL?=
 =?utf-8?B?N0poZVpyM1Yza2c4MElhckVyOEJ0MDdHZElwQ2lxd0c0QlZlK3Z2V0I3REFE?=
 =?utf-8?B?dVBUZzJtRlNTMkxIYU9VRE5GVGJRekw3YzVJUW5sL3RyUUhOU2ExbXZsKzVN?=
 =?utf-8?B?c0JwanNBRGpRTjV0OURFRzBpVGw5OVgzWHZydXoxaGNzQkEvSXZEYU9IVEla?=
 =?utf-8?B?c3BYTmNsd2JjUkM3ejJBODhVak0yelBqc25XdTJld0dmUlJkVW5kSHE2VThB?=
 =?utf-8?B?SEt3MWZCMWIrRXA4N1pBcEY4cTdGUlg3MXd1MENOU0FXaUdobFlTYXBWNEx4?=
 =?utf-8?B?MGxnY0ZadTNFUVNkZUk2eVlIVVVVNlVlM3BXalBuM2dteU5xNS9DY1EzenR6?=
 =?utf-8?B?QVdwUWpjTlcxV29GWWhBUWgyZ0lUbGhvKzBCOFhjQlBEVW1xN1U2T1pxZEtm?=
 =?utf-8?B?cENDNzlmdkJWaEZscFZGV2FNeTNseGZzYXZhdlR1eEEvbGxGVVo3MThuVzN4?=
 =?utf-8?B?NlNTMTN1dmY1VEh2QksyTVJodHpZdGhhUHFpQnFYOUUyTXd6UmJiN1oxRE9V?=
 =?utf-8?B?eXpEQUpKY1liY3BhbHJ2cm9scDc2VTlqZjFKMDZEVDh4RFlYZ3gzRHhSOHU4?=
 =?utf-8?B?Um90ZmRIR2JOYXdtWHNQdXR5MUlmZjJCUjFDYmRSQ28rWXhHdnRqOHd5WDVm?=
 =?utf-8?B?elUrNGJmeXB5S1ZVRWpIWHcxL2szd2NXRmhBL2NIaU1VM2VSVzhwSVo5NE8y?=
 =?utf-8?B?Sk1IVXhPSDJmSWtESUgrcHozZHZ1NTFyVGQwc3ZqZG5nYitpWkpwL2orSFdP?=
 =?utf-8?B?Z25KTHlpSmwyNHlMNG5Xb01DdCsrZEJ5RVVPa24rMkVZQkF1VjBPajErSzdx?=
 =?utf-8?Q?+LxI5Rbfb5Lrp3OQ4CYC03uXG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379cd098-9b17-488d-83c1-08da7bbd9171
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 17:18:54.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQP+OVxTHHfPohLGhI42vAtiLu+vO3sfkCsem3mf9smex9JK+yuTVoaeP0H1thakz1NT35ipbR0DYXVVoR5SRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/08/22 17:00, Gupta, Pankaj wrote:
> 
>>> This is the v7 of this series which tries to implement the fd-based KVM
>>> guest private memory. The patches are based on latest kvm/queue branch
>>> commit:
>>>
>>>    b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
>>> split_desc_cache only by default capacity
>>>
>>> Introduction
>>> ------------
>>> In general this patch series introduce fd-based memslot which provides
>>> guest memory through memory file descriptor fd[offset,size] instead of
>>> hva/size. The fd can be created from a supported memory filesystem
>>> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
>>> and the the memory backing store exchange callbacks when such memslot
>>> gets created. At runtime KVM will call into callbacks provided by the
>>> backing store to get the pfn with the fd+offset. Memory backing store
>>> will also call into KVM callbacks when userspace punch hole on the fd
>>> to notify KVM to unmap secondary MMU page table entries.
>>>
>>> Comparing to existing hva-based memslot, this new type of memslot allows
>>> guest memory unmapped from host userspace like QEMU and even the kernel
>>> itself, therefore reduce attack surface and prevent bugs.
>>>
>>> Based on this fd-based memslot, we can build guest private memory that
>>> is going to be used in confidential computing environments such as Intel
>>> TDX and AMD SEV. When supported, the memory backing store can provide
>>> more enforcement on the fd and KVM can use a single memslot to hold both
>>> the private and shared part of the guest memory.
>>>
>>> mm extension
>>> ---------------------
>>> Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
>>> created with these flags cannot read(), write() or mmap() etc via normal
>>> MMU operations. The file content can only be used with the newly
>>> introduced memfile_notifier extension.
>>>
>>> The memfile_notifier extension provides two sets of callbacks for KVM to
>>> interact with the memory backing store:
>>>    - memfile_notifier_ops: callbacks for memory backing store to notify
>>>      KVM when memory gets invalidated.
>>>    - backing store callbacks: callbacks for KVM to call into memory
>>>      backing store to request memory pages for guest private memory.
>>>
>>> The memfile_notifier extension also provides APIs for memory backing
>>> store to register/unregister itself and to trigger the notifier when the
>>> bookmarked memory gets invalidated.
>>>
>>> The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
>>> prevent double allocation caused by unintentional guest when we only
>>> have a single side of the shared/private memfds effective.
>>>
>>> memslot extension
>>> -----------------
>>> Add the private fd and the fd offset to existing 'shared' memslot so
>>> that both private/shared guest memory can live in one single memslot.
>>> A page in the memslot is either private or shared. Whether a guest page
>>> is private or shared is maintained through reusing existing SEV ioctls
>>> KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
>>>
>>> Test
>>> ----
>>> To test the new functionalities of this patch TDX patchset is needed.
>>> Since TDX patchset has not been merged so I did two kinds of test:
>>>
>>> -  Regresion test on kvm/queue (this patchset)
>>>     Most new code are not covered. Code also in below repo:
>>>     https://github.com/chao-p/linux/tree/privmem-v7
>>>
>>> -  New Funational test on latest TDX code
>>>     The patch is rebased to latest TDX code and tested the new
>>>     funcationalities. See below repos:
>>>     Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
>>>     QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
>>
>> While debugging an issue with SEV+UPM, found that fallocate() returns
>> an error in QEMU which is not handled (EINTR). With the below handling
>> of EINTR subsequent fallocate() succeeds:
>>
>>
>> diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
>> index af8fb0c957..e8597ed28d 100644
>> --- a/backends/hostmem-memfd-private.c
>> +++ b/backends/hostmem-memfd-private.c
>> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>       MachineState *machine = MACHINE(qdev_get_machine());
>>       uint32_t ram_flags;
>>       char *name;
>> -    int fd, priv_fd;
>> +    int fd, priv_fd, ret;
>>         if (!backend->size) {
>>           error_setg(errp, "can't create backend with size 0");
>> @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>                                      backend->size, ram_flags, fd, 0, errp);
>>       g_free(name);
>>   -    fallocate(priv_fd, 0, 0, backend->size);
>> +again:
>> +    ret = fallocate(priv_fd, 0, 0, backend->size);
>> +    if (ret) {
>> +           perror("Fallocate failed: \n");
>> +           if (errno == EINTR)
>> +                   goto again;
>> +           else
>> +                   exit(1);
>> +    }
>>
>> However, fallocate() preallocates full guest memory before starting the guest.
>> With this behaviour guest memory is *not* demand pinned. Is there a way to
>> prevent fallocate() from reserving full guest memory?
> 
> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.

That is correct, but the question is when does the memory allocated, as these flags are set,
memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
allocated.

Regards
Nikunj
