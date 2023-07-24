Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708D75EBC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGXGj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 02:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGXGj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:39:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8010D5;
        Sun, 23 Jul 2023 23:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBNytuG9pELw+wCkLN4x1giJm/z26G8CcsZMEb99JyC7zp0yx3rWos8RU/0dlROo3sxMwAe0im8lJnlNJGafVpsYrxEMGjS0teCClOd98oKvcOMIJyyvrwrGGw0AVcvlJA/rYE0m6/Y/rck1kLPbvvHxY8C3fb/460schR3rlhHWw6KL9NkMgko2LVLPqoyPXNQwkf/UQVRwyRtxUztW6miLhX4HFI+SbIwRDOCC1aXvFwLHXeaag/MiE3qJOsw9ocEs28kp3NsKRwxTeIUlXZs+kmXPBoJ2hWeaWa5yc69LvwSrBTMD4gf978M2zx02o3eDGvUYsZQl6RnpOeXUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPDUPsv+OHeCKSGGIj9yi+Hnv4eueeGpUW2NUc1vEDw=;
 b=LhO6m3ocqmex7d/RiRz6C+W48Y/dlBNLSaT7riGfIOUvDKG4vG2V8Y0VtjaRheC9UV3P2VeziKL1G75rSTWZNXJriALI2qrQLdhQpXVAqGpD1+QPEPRbOC14de5cz5QF8maxpWXo22syNarAQRlAg8e2oP5IM48xZFfzRQoFZ+4/VzPbyyWL3+4ejuMCMJ1lZ31eRIE0PQcJ9WT1IMYoljH0E8b8Ix9wTz0pDcSPvEM/ZLqJicswHTQNJzK0BLG3G4MFPFdhDdnqk7B4w0DN3JtlaFomSLQwT22d70lznVjQsCflUqSdd/toocnmrrdlm3/3Q2uo9/ZNI1EwGCThDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPDUPsv+OHeCKSGGIj9yi+Hnv4eueeGpUW2NUc1vEDw=;
 b=roJqN2HfCG4+WWoSkaJ5YX0Dhx+IIDOWW2tAahPS/3+/eWlxrGMch5sudrWV+rEMrv3EcI/FawMVF+1CrL4iXZhJccDOMF21ltZzRL9QGH6LnCeUy7bXLe1aVAvefSIdQJl/jVH67i3QG2u3mYk86nD0uxrOJScsHSxMBiv8kRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Mon, 24 Jul 2023 06:39:05 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:39:05 +0000
Message-ID: <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com>
Date:   Mon, 24 Jul 2023 12:08:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v11 00/29] KVM: guest_memfd() and per-page attributes
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
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
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 076b3286-626b-46fb-6874-08db8c10ac96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwYfBBYT3muu8BO+rgOd4DlIqS5SleOjlqADeG6tqthegVLvuIHdPzgj6H5dWm5trTsr1gQ+a83UM4DUGUAi+s8y+5bygSM4VV3/hE1kaJrz/a4y/mpQMlKMfdxA06u+D0KZFpFXZyKPFAphKH1erhpeOzQ9Y7HAL4OPncyt45DtJCBhSqVt24WqHrsKYKanJYshZCrnW/ZKC5pkYevwdPXanLJIYiplpLv+xdLOohfOhpbYDSDl9wuJtf8wstUbxwHgW0Jn23DpK86GKfQl8sYN0OEOnuJE+hc9Nw7ZT/ayxaAvokW7Vn+DC+dUPbTkzetAAoOjexkLSsvUPnjCe0LrlPsQLQaDAfgeC/EGoH73ipqsLssy18aJ3btJadnkR03V+2lVPVeiubyp7Vvs1pB9B8Iwflx/FPOeXT9sBRTaU5U64w/3jPxe3FzozvnKtmQINxz45EUWMSD3R36xRL2chpYEHOw+eChZr/qtXGs0fb3oTOYwGofQo0TzAlE7xBMsJKCkPPgFSTC+CK79Yo0u6/9XpvYt+jMDpe0tR9ZDxQMeIDsHuM5eZcECeicUA/AwbSuB7/Zgklg14ELPuOFHT9B8fGaoWvpRO9sfweolkLHEUpbIeIMvf0u0aOMVdqHYgZNyWgP2Qsl7F6mIOKPdNMDsFxlUQrUyq95QtS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(38100700002)(921005)(66899021)(53546011)(2616005)(36756003)(83380400001)(7406005)(7416002)(8676002)(110136005)(8936002)(5660300002)(478600001)(54906003)(66556008)(66476007)(316002)(66946007)(4326008)(41300700001)(186003)(26005)(6506007)(6512007)(6486002)(6666004)(2906002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZoRnlBUDJyR1dyWEs5b0ZscndEVWJXa2NFczU5bDFYV05rSW5nYXNEZXdm?=
 =?utf-8?B?OERoOWdWYkkxK3VENjJVbXEyNkkxYXVEVjBLZmpPL0VhL1cwZzVvY1drR1JT?=
 =?utf-8?B?N1hjSVhZQmUyNzh3SUdhY0VBVUJWVHNjVTkvajRUQ29xL1ZSM2tBZy9sREdj?=
 =?utf-8?B?UFpldzlBOVVINVRZM2lVOHFmWDV5MlMrOWttNmhXem1pOHZkeDI1Q3VJQ2FB?=
 =?utf-8?B?RjV3Vm84bkFqM1g5WWgwWkw1ZUtWeXFLdVkvSzZGTkZ3NGFQQkp0RGxTMWhx?=
 =?utf-8?B?SVprQTNOV3RJUG1ESUpaU2JoMFlvcDEvSHRoYXBBWmYyWWxJamRsQUdXd1Ur?=
 =?utf-8?B?TllKekMwVUNpQlNYdFU1NHRaR24xaG5CQWN5Wks4aUV2T21EbC9wS0pnZElu?=
 =?utf-8?B?V1ZzeUw1VjlsYnZGODRIRFd4Wm9iTGVtbldZcDQzKy81WTBTUGIyeG5STHZT?=
 =?utf-8?B?djEyNWo1WTZkdmJaYmI1TFdMMGNpdEMxSmZ4WGhYSmUxYXhiVk9sSEcyQkJM?=
 =?utf-8?B?b25FWFhqK1dlRGNWaVhKTXY4K1dnVE9wUjdYcE5Ed3NxTXNOeTlRb3IzSzkx?=
 =?utf-8?B?Wnp4THY1TTd4VHVzcWhRNnJQU2FTZmxnMlVETXNIUWpRZndzN0NmdjFRd3h1?=
 =?utf-8?B?a1laUW1EK0dKOHJjVExpTkZkT0tSUUZBZzVISHVOZFJhNG9CcUZHcnQzUWJR?=
 =?utf-8?B?VUZXVzNaanp4b3o0UlprdlhJNjVPSjY5ZnlXQStCeEE3Tk1nNng3R0R5OUN3?=
 =?utf-8?B?RWQ1RkpEK1ViQ2Nua040UnJORWx4WHZRamVFMFcxcGFvem9BbUhrcU4wZms0?=
 =?utf-8?B?WlRWZ2QzTmg4dzZPdmpMYWhBUjhZUm8rZ25iV3ZCYkI5ejk3eEpiRXJGZWV5?=
 =?utf-8?B?dWVOMU16VUFKaitGTmhKUDU3eFRPMFVZSkRoT3R0Vk9vWFAzdjBTNWhUR0xO?=
 =?utf-8?B?cEJ2K2trMDMxdXFIWGE3elRlU3BEbm1wdmhnalVCaTdPaFE4VnVDcEhYcUNk?=
 =?utf-8?B?bDkrWUdCUlFqcTdjNVJuaXpuMkFqT0dDT0RXZUxlUTRqdFE4MmF5bit5MnBz?=
 =?utf-8?B?QmUrMkc3ejA3M3NGNDJpU2x6b1BTZDZRQXlpQ1Z3ZmZna1RkVnNNUTloSHdo?=
 =?utf-8?B?MmplQmN3emREVTc3QjM0NzljU1ZxZDZwY0p3RWJKbjhCa0xrT2FLWlAzRmVU?=
 =?utf-8?B?VFZtQnlMdXg5aGc2SWdvb1FVVms1Wkp1YTd3YWYrOFlHTHJRWWZNcTViZEVE?=
 =?utf-8?B?U2hJVGFzVjVSOHhDK0t5dklTNGFmRmkvZk53bTdpYWE4U1E1VTdEa0VRTXNl?=
 =?utf-8?B?dU4wa3JjK040UW5ZeEpQNzl5bkUyakhaYTBBRWVpU2YwMXFXeTZhdDlxY1hM?=
 =?utf-8?B?VFMyc2xuN3ZOd1Q3VS8veXVpQVhkTSt3aG1MMGxOWDg5ZGZiVkpHeldmWkg2?=
 =?utf-8?B?OUpmUE1lUnRXT2RIWUI1VCtyZFJUcm5lbkpRb29nekt2SUV0RmZtakdFbGQz?=
 =?utf-8?B?QjFXWC9MRDAzNGFUMHpicHFSTFJxZEdUK2hNTGNYcHJaTzVFZGc5NzNlUjFm?=
 =?utf-8?B?dzFIOEZqTzJrcFRDNXFjR3NlMHBNbXlkcUhHQnZqL3kzRUZRYnlMQ1ZscW1Z?=
 =?utf-8?B?UVVHV2p4T1ZRa0haTFQ2Zkh1UGZuNThEaVNhOUFTcEh4WW9aa0szYzJYTGJ1?=
 =?utf-8?B?RWpWdmFxY2l3Yk9EdHZDY0hpNHNuTU9KVStXZzZwT0pCNCt2NmtZYjFNVGkw?=
 =?utf-8?B?eEszanhYZmwwb0RUL1JOZ2Vkc3FzT1V3NUVscm9Mdk1oTjE3QmQ4bXNkL0Fk?=
 =?utf-8?B?b1MzYzJqWXBNcnlaVDdNUzBSUFVZVnZQdlNEMnYrUEFBbDdOZnVSSlNXQ3dp?=
 =?utf-8?B?V0tYS2pScVZlTmlsWC9MYTFId2NiOXVxbHhqYWF6TCtLdlVnSGNQYS9XbGxw?=
 =?utf-8?B?NG1HcWsxeXlNVFpzbC9ma3dNK1JjRG9iNXE5ZGxlL0dzNWltMWd6bXZPMWV6?=
 =?utf-8?B?aExPMnZadU0zZXoxMmtlRzVaMUhZYzJDL2h2WTRHMkIyaTMzdi9aa2VKNTE5?=
 =?utf-8?B?cHpHUGdydDVLZVBrSFhlQms5Yko4NVRnbk4rVHNLMk12aFFIVzR0QkwrUjRR?=
 =?utf-8?Q?amJpMnW8DV/IBiVn2HDv8+u+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076b3286-626b-46fb-6874-08db8c10ac96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:39:05.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzVeJFK0RtlE0mOaAY9S50k+ogzzjG0MuHLg60uHtqbm99Rz/tgFNZ7/z7dMuV5otSKvWBXRaXMFk7RMCFmatQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/2023 5:14 AM, Sean Christopherson wrote:
> This is the next iteration of implementing fd-based (instead of vma-based)
> memory for KVM guests.  If you want the full background of why we are doing
> this, please go read the v10 cover letter[1].
> 
> The biggest change from v10 is to implement the backing storage in KVM
> itself, and expose it via a KVM ioctl() instead of a "generic" sycall.
> See link[2] for details on why we pivoted to a KVM-specific approach.
> 
> Key word is "biggest".  Relative to v10, there are many big changes.
> Highlights below (I can't remember everything that got changed at
> this point).
> 
> Tagged RFC as there are a lot of empty changelogs, and a lot of missing
> documentation.  And ideally, we'll have even more tests before merging.
> There are also several gaps/opens (to be discussed in tomorrow's PUCK).

As per our discussion on the PUCK call, here are the memory/NUMA accounting 
related observations that I had while working on SNP guest secure page migration:

* gmem allocations are currently treated as file page allocations
  accounted to the kernel and not to the QEMU process. 
  
  Starting an SNP guest with 40G memory with memory interleave between
  Node2 and Node3

  $ numactl -i 2,3 ./bootg_snp.sh

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 242179 root      20   0   40.4g  99580  51676 S  78.0   0.0   0:56.58 qemu-system-x86

  -> Incorrect process resident memory and shared memory is reported

  Accounting of the memory happens in the host page fault handler path,
  but for private guest pages we will never hit that.

* NUMA allocation does use the process mempolicy for appropriate node 
  allocation (Node2 and Node3), but they again do not get attributed to 
  the QEMU process

  Every 1.0s: sudo numastat  -m -p qemu-system-x86 | egrep -i "qemu|PID|Node|Filepage"   gomati: Mon Jul 24 11:51:34 2023

  Per-node process memory usage (in MBs)
  PID                               Node 0          Node 1          Node 2          Node 3           Total
  242179 (qemu-system-x86)           21.14            1.61           39.44           39.38          101.57
  Per-node system memory usage (in MBs):
                            Node 0          Node 1          Node 2          Node 3           Total
  FilePages                2475.63         2395.83        23999.46        23373.22        52244.14


* Most of the memory accounting relies on the VMAs and as private-fd of 
  gmem doesn't have a VMA(and that was the design goal), user-space fails 
  to attribute the memory appropriately to the process.

  /proc/<qemu pid>/numa_maps
  7f528be00000 interleave:2-3 file=/memfd:memory-backend-memfd-shared\040(deleted) anon=1070 dirty=1070 mapped=1987 mapmax=256 active=1956 N2=582 N3=1405 kernelpagesize_kB=4
  7f5c90200000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted)
  7f5c90400000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=32 active=0 N2=32 kernelpagesize_kB=4
  7f5c90800000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=892 active=0 N2=512 N3=380 kernelpagesize_kB=4

  /proc/<qemu pid>/smaps
  7f528be00000-7f5c8be00000 rw-p 00000000 00:01 26629                      /memfd:memory-backend-memfd-shared (deleted)
  7f5c90200000-7f5c90220000 rw-s 00000000 00:01 44033                      /memfd:rom-backend-memfd-shared (deleted)
  7f5c90400000-7f5c90420000 rw-s 00000000 00:01 44032                      /memfd:rom-backend-memfd-shared (deleted)
  7f5c90800000-7f5c90b7c000 rw-s 00000000 00:01 1025                       /memfd:rom-backend-memfd-shared (deleted)

* QEMU based NUMA bindings will not work. Memory backend uses mbind() 
  to set the policy for a particular virtual memory range but gmem 
  private-FD does not have a virtual memory range visible in the host.

Regards,
Nikunj
