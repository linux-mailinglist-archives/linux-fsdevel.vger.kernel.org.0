Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650976471A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjG0GnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 02:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG0GnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:43:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ADB1FFC;
        Wed, 26 Jul 2023 23:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7njBkesOY2tlQsI4Gxqi7a9a6df6aSJgCMYjBZ4ml7tEDU0+k+Glq9Zh7irp3smT3ZTJYY6clCXqxx5Hg2l9HrxybiLHDQWY3HaBDIzM7SPiAkYw+/EvnlK2PqRhQTTV2uKB7DhDylUhXmLgrY5iWGQo68/v/y81UjyLnMUmiwGOGmLAAJQgqX/VHTUI44EfkhGmQiGNg5RAC0A6Z2al68xTA3JldfykpPc9mcXd2l9MFUJ7bX/aefKRg050ENARf631gNVmEAoYFILj3CknyCMVfkhxTTROtB6pnYCzjxuOjDIvvJ0N3Z8RX+/6TEDqwuqwQGMYY06+yq3QxuGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlDom0HAUnxOle/icKp49hOpqWSyZAaZGR1HAudsQ2c=;
 b=odbPz86jkqNKRQ+v5Cyj90CRRyYS66I59+RmYMiilvITtKbXBIj3Fh1PG8hNDgZoH4mETzbgg0n6mMVRW3Pgq2dbL5655x7+6vlaRQwvQtDuh1XLUrN7EcZAPNfMs4WrQJ4fC0oYNjNDL9phkCPlTz45W45VJZXvBR6G/ZuJR+hPxBR0sy9t455ndWxQju2ocH5hyRURawwtkyu0GjTt6i4HQSEmeQiSxX4HAOlXsfFsQ2QAxfNGosWgNpjNsPs01ojst9XWB3fTBBUiO8bOyweYgqpkA/VI06Z0QLR+AiIV+kTFEUHAka3gTadt18FU6blDOYOLyJjKv/ba4lIO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlDom0HAUnxOle/icKp49hOpqWSyZAaZGR1HAudsQ2c=;
 b=DyZCoVt3WlIfQkmhq0vWkyf7fxZrlqUHyUsHK+F/HweAnxj45Uu6qTxpQQ5KRGUWCUQSaTW7xk7581cQPf7+35dIx1Ym5V8QawCZq8+YdP4nX5q8IlNm4v6QcnYZ1bi7mwDEvS10z+iJoF43v90EnsLazlWRLsRP8mOn8GTtASY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 06:43:07 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 06:43:07 +0000
Message-ID: <66efd7f5-92ed-45ec-0550-ca7f012a6e63@amd.com>
Date:   Thu, 27 Jul 2023 12:12:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 00/29] KVM: guest_memfd() and per-page attributes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com> <ZL6uMk/8UeuGj8CP@google.com>
 <2f98a32c-bd3d-4890-b757-4d2f67a3b1a7@amd.com> <ZMEsuyqHhp1DAVdR@google.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <ZMEsuyqHhp1DAVdR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f411065-4260-4649-cd33-08db8e6cbc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbwQeRUieEAwbP1+x/XdV+tOEEMl8OPARIGYUM01BtuAzub1VTZ/FQbk4KyNjKdAgTWwRvFPeCbstr24wwatrfIFg1iFjjwGdEd7irR6YT8hIx6Jx2ZPRsENgjR+FF38cD3z20kwPBJHSX1qal1mfz2Ktv8UvHOAzLSEKdR7s51u0eM1Nk+8SZk8syr/831VemPAkxbVlXbgSOC8q1EKLmy0vO4Z+ilYfThpU5Yq2ZgNVEQG7SX56XElhmrUY5qs9cADR9AFu4gjitjgxiE8elJedRB5+xPjZZWX+HCkNdMkYxtS/gCUqz2MkrEyDpNyx9hKGZO9/iaqNcIRUaKEwMEcvKGW0lVnXCPPZHwMuPmjU24w+oYuDlvaPXd4AbqqXKnRcdSwwXWOVObfWh6zu/auBraCAzafpEZmki3FqF247U0SahmratDFIh6av0BDy0G3HH2uRsyiXcR8HEGq0Ui3/tUfLhNgODv9MlM8fpao1yOE3YFy/X1kOiQnsdfg8m7+zaC+fevjZjUylrtShJ5VuPs55dYYqyNRcJzrZZKJZSwnR66nV8yWXxa5iaRhgs3gfa9mW/oiCEgFNJeWJIAmdxxtcwa347zLd6hcByNShWvNvKc9HC6tjkLA0OV2/1WdTKwb6z9kZaRTQYSfKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(6486002)(31686004)(2616005)(26005)(6506007)(6666004)(6512007)(478600001)(53546011)(54906003)(186003)(4326008)(6916009)(83380400001)(38100700002)(66476007)(66556008)(66946007)(5660300002)(8936002)(8676002)(7416002)(7406005)(2906002)(41300700001)(316002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFqLytUeitZcENaQ1RhR0tzK3Y1SFVSVzFDaDIrbkRiVHRhUEZaUjMwNXJC?=
 =?utf-8?B?WEh5RzRWbm51QkVDTTE1RkdzVEJXRnhJeVlHLzVhKzlsOW44R0xpMVMwNERm?=
 =?utf-8?B?enBhOG9OU2tPWHVKbmJGcTNWVHJyNjVaUk1yUVpFY3JHNkFCM0tueFpDZWhq?=
 =?utf-8?B?dkszNDlWM3kxYXJNWnNKZUZEQ0lYOFlnYURvZHEvbW9YQUk5cEJxZ0o0enlX?=
 =?utf-8?B?Zi8zNjJSajU3Wk9iQ2VaR1hhNzgxc01LbHJUTkx2ZXZQWGk1SVcwaENud3gr?=
 =?utf-8?B?OTZYdDY2QzlUMGxPUVJtR0s5NlJYWENTVU0yUWcyUCtoMXJvTXoxdE9jRVRr?=
 =?utf-8?B?ZXBLd1ZDZzVsVFpwMUZLUXdHT2tmcnAvVWlIQXVud2hNcmo1UkFTMG9CMXdt?=
 =?utf-8?B?d0pad0dCRnFhRVBEU3NvdFd0Rks5K2pSQytuSFdoZ0pvMi9OTDk2WjJKd3hv?=
 =?utf-8?B?bXV1enU1Rmd5SUhOYkQyeG4wMEg3QUNEVGl4Vm9wY1J2eU1kTmZtakhCTGJI?=
 =?utf-8?B?ZDlWeDFJbXl5OVBRS3NkLzB3VzQwR3Z4elVwUUpYVm1RUllEVUlCYWJjT2pB?=
 =?utf-8?B?MnEvdll0VTBUNEdndURINTV4L0xaN2xjdEhmME1CNGhOUFVBSmgrV0VsUE1Q?=
 =?utf-8?B?M1JqZk5aZTdiLzNwMmRydDNSVVdsaHc0Y2lHOUVrQ1FYb0pHeWhGWVZUMzhI?=
 =?utf-8?B?YnByaWx5SmJhK0oxRFBacGVBeHNWL0lJVWFMRWpPNXEwMnlsTWNwc0RZcktG?=
 =?utf-8?B?WXdKY0J6UUV3OEV1OTBRVUFMcHFuNnJ3MHY3eFRTUStVdmk3N1M1TFozUG9X?=
 =?utf-8?B?aE9XUFZoVWVMY3NmVnZiZ3BhY3VQdnRJOCt6M3RYTmtPZTF5RDdRK2xMUDI3?=
 =?utf-8?B?VktjL3lLYzFOTUtPUW5FMUllZVIxSUMvRWsxZkI4dWltTkFDSzBEMDNxOXpB?=
 =?utf-8?B?RC9VeVFnV0oxcGZRa2VjLzluLzA1VkMwVWNYSVpjMEtzak1iS1JOZ2N2UVp3?=
 =?utf-8?B?ZUM5c2lHMnFjdENEMGt4eVQyWXhha0hOZUp6cmxZbXoyZ3lIZklUUjBUTXBu?=
 =?utf-8?B?NEdzMzNWRVRnQzRUVTdJUUh0M1U2S3ovbWdJZVc4RWIzWWRBSExNZWt1VnJs?=
 =?utf-8?B?VEIyWjAvckpUYmIvSmFnZHRnR0cyVmxZaW93Mk1Ya3J5bkNXNHJKa3dhdThn?=
 =?utf-8?B?c0ZwaU9QaFJYTW1wcGswa0pkL04yd2J3N3pEZUV2SnBna0JXUFN0Yks0VG1a?=
 =?utf-8?B?VHRUTkppRXl6VFBxckIwWkx5U2haZURVOTYyTGtOTHhGSkhCZHBSdE9vaHJ3?=
 =?utf-8?B?VXJOL0krRk1yc05HWUNWL0NlSDdPWUROUjREV1FWUm1wV3FKL3ZZc1NVSzRB?=
 =?utf-8?B?bTNpUkFHbEFsYnloS1VPSk9lY0o4VlZ6SSsvQk16Q0tnQ2xscXlreFBhbDdF?=
 =?utf-8?B?RTFBcm9MSzV3Rzd3TDhrUzFHVlFFRkZsVXM4QmtuVVd1ZjdTdVRZaGFwemVq?=
 =?utf-8?B?bXczLzlIY1R6VmNSa1ZJeTkzbU5XZ05abFdUcW1MU1ppN3ZJTTRPcWt1MGN4?=
 =?utf-8?B?K2RjVVVLd0hjSCt5a1pnVDAvWk81bGJpZHBwS1dtZ1VRREtDNTFvRTJjN1B6?=
 =?utf-8?B?R2ZqN2tZNzBiWGZOWnhFY3ZQQjVYbzF3aGx1emFZM1hDd0VyV2JHbUFIMzJJ?=
 =?utf-8?B?Y1FNdXI5YmExbzk4YXBqd1kxNmFsS0UwZ0hLR1B5bTRSTUtWMUFPQXVGNWVu?=
 =?utf-8?B?MWVldVYyNU1CWnczNDc5OWlhcGlmbEFnLzQ0OWlSUmNnS0JZSXB0bGtxSGIr?=
 =?utf-8?B?cFR4dUlUczJJSGZlVUVyNStFSE5wNWpTUUV5VXZEQXp4WW03VWV4NFJ4K1Z6?=
 =?utf-8?B?R1BiVHBKekxCVTByQjJUb1pyM1lCakYyVjhZQlhGZ1lNcHVqTEJRQ0swcnhp?=
 =?utf-8?B?RVhpK05jaFF6QVZ4Z0V3ZGpWRW0wbmlJNlk1bEl0SVhXRllRbnVZcHUrMzNJ?=
 =?utf-8?B?Q2dIaHNYQUYyWXkrNXJLbExka2F3RjVHRUV0U21QcjdyRk9UbVkrVEoxalkw?=
 =?utf-8?B?dEZTVXBtZ3BvampCOXlXakRsQlBBU2VJZldmMkkzajdvYTF6UGxKeXZlbG1z?=
 =?utf-8?Q?zyegKlxZB0f3GX+AWWIRIdRSy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f411065-4260-4649-cd33-08db8e6cbc37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 06:43:07.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQgBB+cR9k7S2hKQdQH+MM6E66Rzft8eP+3RAW9AQusVp8uersYDdzA/Dihjsi56GTLv9XWwMcua9kE9dDs21g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/2023 7:54 PM, Sean Christopherson wrote:
> On Wed, Jul 26, 2023, Nikunj A. Dadhania wrote:
>> On 7/24/2023 10:30 PM, Sean Christopherson wrote:

>>>>   /proc/<qemu pid>/smaps
>>>>   7f528be00000-7f5c8be00000 rw-p 00000000 00:01 26629                      /memfd:memory-backend-memfd-shared (deleted)
>>>>   7f5c90200000-7f5c90220000 rw-s 00000000 00:01 44033                      /memfd:rom-backend-memfd-shared (deleted)
>>>>   7f5c90400000-7f5c90420000 rw-s 00000000 00:01 44032                      /memfd:rom-backend-memfd-shared (deleted)
>>>>   7f5c90800000-7f5c90b7c000 rw-s 00000000 00:01 1025                       /memfd:rom-backend-memfd-shared (deleted)
>>>
>>> This is all expected, and IMO correct.  There are no userspace mappings, and so
>>> not accounting anything is working as intended.
>> Doesn't sound that correct, if 10 SNP guests are running each using 10GB, how
>> would we know who is using 100GB of memory?
> 
> It's correct with respect to what the interfaces show, which is how much memory
> is *mapped* into userspace.
> 
> As I said (or at least tried to say) in my first reply, I am not against exposing
> memory usage to userspace via stats, only that it's not obvious to me that the
> existing VMA-based stats are the most appropriate way to surface this information.

Right, then should we think in the line of creating a VM IOCTL for querying current memory
usage for guest-memfd ?

We could use memcg for statistics, but then memory cgroup can be disabled and so memcg 
isn't really a dependable option.

Do you have some ideas on how to expose the memory usage to the user space other than
VMA-based stats ?

Regards,
Nikunj
