Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97821590A95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 05:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiHLDWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 23:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLDWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:22:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9630A3448;
        Thu, 11 Aug 2022 20:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH8X2lJfoGkP9oqfgOqY0tLQXKFyNgWLjgLkwM4GGTKQ0U3QGUo68qTqjhpXxODspU1ekIzEEzwX6HJ6ds7tfko83rLBIylmiqCyOEiiEJp/dTkiCQgeVI0l0GQjSwXRwRBm0YCISe1RUjsfVOjUZ73j/9/CrXOvfLEUZ/KSQrytML8iHHQZxwr8X8KkXQyW16C5CjMFmIw/YrSo3zO1qcDtdWWdsjLTT2QpbLP0+paj9nzztwkMzeOkYc9sfhoWta3Ug7TESDQul4FYe96MTJ8qY5CTlO1UazgpAlcIZBni/2c/uem+JG0nnG7iYy3HLUdZD9h5u/AHVTKNdEgN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7nUyX5ayqEwA6xpStRmIJ4HcV2UCdahAWihtB9eG6I=;
 b=ne59ySwt0AAX16GxzJ/4XV1sluJuHAAxd9qfRMUJK5sVa9xDpaPsTDtR/7FQlTnYar5+X5ChzAz8ai62s/UsFWlFCAK3Sl0gMyORICYqRbp3C//6sGOkXSgpk0VaOPB05E+rsi9VKp/g+euY/kFEDIbgMJ9ScipFG46H73m4QnQh2GNfHwiY0Tx/qhFYfQeCcGC9H1nr2l3HKScOhqEXsmKK/fZzv9visUsQhyAPoGfVPSYfJUOqF+hUVRrK9YCO8JLIAyJ1ahIuxYeXHIhlfrxU/LrRDgimKiGdKQMFhybif1KIYtLHxmN/i+eTpNSf4j9aAiurNIWQ6b6dZiqZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7nUyX5ayqEwA6xpStRmIJ4HcV2UCdahAWihtB9eG6I=;
 b=3flujOwpI5SIuKuaGemlDPP3ZUFKFl0kvzgDqREkmH/HKc4A/veDMjAkrFrHLKbzTZXnehyizLBVeL0OI86d6xoUMvKenUsBZt/mIauHZscKu27NauRTz1OC0hLGtdMg5azseAICim/anlHAP7VZbcPbfhLHa86CNEkA0XSKeP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 12 Aug 2022 03:22:33 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::d9f4:5879:843b:55da%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 03:22:32 +0000
Message-ID: <ec935cfd-17fc-a6b6-b424-2e514512f94d@amd.com>
Date:   Fri, 12 Aug 2022 08:52:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <20220811133255.GB916119@chaop.bj.intel.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220811133255.GB916119@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921e126d-cff8-47af-a560-08da7c11e4ed
X-MS-TrafficTypeDiagnostic: DM4PR12MB5818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v01k4n2ZTph4MC8jR5K3WEpK+HCKpPTW2nqPDcAX7QWhRkFOE7TQ/5UcAfUcDtryFqyejgz6kgmMH4PN9GkO7uHr/hGgaEPZTiyHSGIR2YYMnXC88vytSkUF/s/r1M30FSeA1Ymgm+uvxAEdQbFzMWwkRzDYLcqYyr4kW8h/llzElwSOwSnnCIteKts7osza4WLw2/bBIoHOypfMQcRgRukgkl1+h3Ro5IjXzuQeL8VGf37DE0hAotnPVcl7adV/LJxL28u8QoI9Qvwvcj61gsNen2ZdSmvhjZjJOkk2Czw63xSZXoN3dCq8H2NcCC6F1XVKu/sLwjTN5HOmHuHNYwb1eGGWaa3d1gTv2NRco3S1HxMC/0vzgsNZrSo8XRbupJ6uRX4JTmxCed+RMdNsVnPwtYOf+rT8M/dDfOQnN9sFRP4cQFDNXl0Kxc9kkjK09yVThDB4q9SGILK/u5N3725VzM6wW4Z0FzL8ZU/1NMKcAQQERNPFtS1c1gdo6Jy8YyA6ydn9slQFeEqYGEEuBV5fNM/r19oRHpjZNUlKyoH2elF6wZXZz95/TO0651gYyCkaJkDkr5RrjLixsiBsEyv9nHkPCO7SfzIL5kuLAcrD22SWuvaI1Ae4R/eVSMYWyix/pMsou6n06WjdIpxB4+P1kcDp02+loAdPOSlKYwMAK+4tuGyyoj185QL8WUwHCU+KgZvTIGZqgIwz6BOswfpd1LgLafzkG3OShNG/P55RdM9CSljdLSUJA4pXfc4fjz2Rk1kJSCU7V5ImbYTfBgi04hX8KGZ5cQ5fyAH9dlO57SK92yOODDGF4EIjvhV4o7bynCrY6GUiCL7QcWvvKvMowewjZMIanWKBHtafmiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(186003)(2616005)(26005)(41300700001)(53546011)(6512007)(6506007)(36756003)(6666004)(31696002)(110136005)(54906003)(4326008)(316002)(66946007)(66476007)(2906002)(66556008)(6486002)(5660300002)(478600001)(966005)(8936002)(8676002)(7416002)(7406005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09oVmI5WjBvQTU1WUs1akhSR1lwR3o0cVlMOHRqcmYyQnFYMXFwbG5ZSFov?=
 =?utf-8?B?N3E0UUI2cFdVSnhXZFB5TmNjSUxKUnZrcW8zcTZNZXg4Wi8vR1NESXJJVDlW?=
 =?utf-8?B?WnBIRGx3d0VPaU9YVzlsb3dnWThRQkJ3aE9GUzVWMzVNdFVQSjZPQTZsTEto?=
 =?utf-8?B?WHh5OUEwcE43NU5rRmF6Y29HY1l0OUM1M2VMZTlFSUcvTTZ5d1B1eTRMdm1s?=
 =?utf-8?B?cHN0Q0tUWmUzNmFaZ1RiNHA2VGUrVDQ3KzgrZi9HSmZLWUczWFpxQVJ6VGps?=
 =?utf-8?B?a0lVQmQ5WXRxR0YvVnhka3hJWlFUUjMyaTRXc1lLN3BPN3VNbkRabmJLcFRz?=
 =?utf-8?B?WGtVb1V3bEJydFRKVnRQZDVWS2dpR2NJaVdObDVxbGd4cHRlZ01DaDNOaFhJ?=
 =?utf-8?B?MURudFpoSmFOVVMrTElpVS8wYWZldCtLTGg3eElLRjFMTzZtVFIvKzlhY0xp?=
 =?utf-8?B?eWY3dll6Q05rb2VORlhCV1BvUWdSYjl6NDVNRDd0c2dJOWpESU5aaStNUzhy?=
 =?utf-8?B?a0F6WW5Gc1haUTM0MFc5QmVkQzBCcVRkZjFvK05ja1Vvdm1OOWl6TEdqZ1NO?=
 =?utf-8?B?ZW5ZZXptSjZkRVE2OXN6VTZ4NCtmdVhtQi94WWYxTTdmNGJFb3FSZmtPTXlm?=
 =?utf-8?B?TmpMVUxtZFZ5YkYvU2h5ell6eHFVRGxtdXhqYk1xcncyelYrbEQ1QVAyWXo5?=
 =?utf-8?B?Y3RxdHdXK3k2dGZyK0RXZnN5UXkwNDVWRHI1Yjc1aklHOEZrWkR6UWdWZlhj?=
 =?utf-8?B?dmlrTkNqazhsQStaa3dmYm40cnZtZk5CaHFMVDJDVi9TejBxOHZxak1UenRS?=
 =?utf-8?B?aWt4cndmYzBiMEFtdGx4QW9RZWlKNFFWQzQyWGZEMFJqdHJVK1M0c3ZEQXZH?=
 =?utf-8?B?M2Zzb1o2ZER0b053VTRtVjRheDc5WVhEYUR5WVUxaWlMVk9QUjNCeGtmTjRY?=
 =?utf-8?B?NXVFdGM1QXpyS0VQTVk2K2k3YTNkVjJpNlRJT1p1V0RBNGZGZGNKS2RVdVYv?=
 =?utf-8?B?eGp5aUVCZ1JxU2QwZ3RDTjFDTjZJQVUrZHJNVHVNZjV1c3hJWW5CU0hxMUt5?=
 =?utf-8?B?NUluMUthV21VN0ZRdHkwbVJCRjg5VDJvVVgrdDV6dFZYaGpnV3hKOFNlektx?=
 =?utf-8?B?bFU4UWo0NTcwUW1yL3h3RDVZUHRSc1dUbEtGQmVKck54U01pYXBRU1lxWFBu?=
 =?utf-8?B?MW1MbGduQjEveU9yTVRMTHYwZWRkRmZDV21nN1JjaFBhS1VCdjRBZks3NFEx?=
 =?utf-8?B?c21mSlcwMDhuUXVKeXFxU1JBTXQyTVRVNmg5RDQ3aU9hK0o5SFhlY08vOHox?=
 =?utf-8?B?NVZqUjdmT0UxSUc4aUZNYlMwMkdadkFIZzIzaTB4cm5Tc1ZmbGxpUzVVVWFF?=
 =?utf-8?B?S1BKVVcvZ1ZKQ3NMSzJGRnVSaVBpRXpNV1hNNlRkTW1jVElPcWIrSmtvZWto?=
 =?utf-8?B?dXJabENxdm40TGdaTWZaYzh4cE9sUFRwaHRtMTA5WDlWeTRYbUVxdFpTRDdJ?=
 =?utf-8?B?YzBjbGNYQ1hJNWJPQjNNSStLSlRvZXJRZ0h4OHV2M2I0OURVZ3hFN0g3ZVhN?=
 =?utf-8?B?Q0I3dk91L00xbEt2ZkRKeWU1ZGN4cjQ3dWRGbnRid2pmYmJ5bU9LUjM4R3R0?=
 =?utf-8?B?MmZIR1ZYT09UMDg2QzFnRkpWUTh0b0FIR3FvSUpKOWttK096U2xTUXBZNjAy?=
 =?utf-8?B?aVoxZVlsM1ZyQ0VCT2djS2YvQzI2c3RZckgvVFc5VU9Mc0N0S3dNdytGa05E?=
 =?utf-8?B?cWh0NzUrbXJMdWk3elVUdHFIUUtiWmpjYlo5L3VmUk04WUM0S3BFVXQ5UHA5?=
 =?utf-8?B?cElVUWt4SkZBOGdIUE1HcnBHb3l6TUFqWkk5SzVDN2tEemJ5Y2h3NFp5cUw4?=
 =?utf-8?B?QStwR3FKc2ZnNkUxZTlZeTJoUDhMdm1LRzJ6K0ZNa1JwUytvZ2dkSzdQUWFP?=
 =?utf-8?B?TlZVbjdSMHc5Wjc4azN4WXZtWG1YMk1nN0VUeGUvNTcvOWU1UkpocElaazV5?=
 =?utf-8?B?OXVremdkSnFHZ1BFMDBmN2doVWdRQzJ3UkdqaFRIeS9qNzhGSHBEcVlNbnk5?=
 =?utf-8?B?K0FNek4wRDNJMnRTRGlmMTZVU0JKdWxDcUdiNVEwM2dhTkZwK2hkYWdKcmlH?=
 =?utf-8?Q?hDcEgvbihpvbTFe0co91eb8P3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921e126d-cff8-47af-a560-08da7c11e4ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 03:22:32.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZgy0f3LWs2S3phIjAbmAyA/aG8MjzTXJ/opErAzSgjLGdspJZfvMnkowIANHqn6dR/pwHHJFKRyoBFsdX7vVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/08/22 19:02, Chao Peng wrote:
> On Thu, Aug 11, 2022 at 01:30:06PM +0200, Gupta, Pankaj wrote:
>>>
>>> While debugging an issue with SEV+UPM, found that fallocate() returns
>>> an error in QEMU which is not handled (EINTR). With the below handling
>>> of EINTR subsequent fallocate() succeeds:
> 
> QEMU code has not well-tested so it's not strange you met problem. But
> from the man page, there is signal was caught for EINTR, do you know
> the signal number?
> 
> Thanks for you patch but before we change it in QEMU I want to make sure
> it's indeed a QEMU issue (e.g. not a kernel isssue).
> 
>>>
>>>
>>> diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
>>> index af8fb0c957..e8597ed28d 100644
>>> --- a/backends/hostmem-memfd-private.c
>>> +++ b/backends/hostmem-memfd-private.c
>>> @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>>       MachineState *machine = MACHINE(qdev_get_machine());
>>>       uint32_t ram_flags;
>>>       char *name;
>>> -    int fd, priv_fd;
>>> +    int fd, priv_fd, ret;
>>>       if (!backend->size) {
>>>           error_setg(errp, "can't create backend with size 0");
>>> @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>>                                      backend->size, ram_flags, fd, 0, errp);
>>>       g_free(name);
>>> -    fallocate(priv_fd, 0, 0, backend->size);
>>> +again:
>>> +    ret = fallocate(priv_fd, 0, 0, backend->size);
>>> +    if (ret) {
>>> +           perror("Fallocate failed: \n");
>>> +           if (errno == EINTR)
>>> +                   goto again;
>>> +           else
>>> +                   exit(1);
>>> +    }
>>>
>>> However, fallocate() preallocates full guest memory before starting the guest.
>>> With this behaviour guest memory is *not* demand pinned. 

This is with reference to the SEV demand pinning patches that I was working on. 
The understanding was UPM will not reserve memory for SEV/TDX guest in the beginning 
similar to normal guest. Here is the relevant quote from the discussion with Sean[1]:

	"I think we should abandon this approach in favor of committing all our resources
	to fd-based private memory[*], which (if done right) will provide on-demand pinning
	for "free". "

>>> Is there a way to prevent fallocate() from reserving full guest memory?
Regards
Nikunj
[1] https://lore.kernel.org/kvm/YkIh8zM7XfhsFN8L@google.com/

