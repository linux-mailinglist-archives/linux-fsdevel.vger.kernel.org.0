Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE27558B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiFWXAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWXAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:00:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFD5D137;
        Thu, 23 Jun 2022 16:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPDKdblPs9BwNuPF8gxg7Mb30CFLTLIRhLYCt5OH5LdGkf/Q93ISzMW0cSdJVfVQ+MpIlrFDXw1UoxVj8h5DKUxvCwe3Isei40hNUCn90603h0f38wZ8oF5hUfg+qY72EW1pqAdtKdZHLshawwKbQnOSrAK8GCuQgRJG7b9kCpRTRt/ai1htnRVR1JZwJdirZ8dFdI86LGn9FTAoLf3AcR8ftC4xkCMca9nki/om7x1B5lQQehbou6FIYNExdGsBDSx+NGpSPq7Jx8CXwd20+wkBO6zVhOcaZOvdsdXKdUFomwbi+fAqHgjum2rzAkKi/uJD1OdN6msv1WjLZDiiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcUCsHDOS1mwtvW0OpCsIxwcfsp22daMALGVK68o0Sg=;
 b=PnDt63md8LCHccHT/TeyHw9Ol6miT/hJR2bMxXYa0qO5tQJD0r40jG9vFerrOSFWJmDmKIprui40WHHbOwtoezEWweFPV/tsg+RFolXvTagswDL4LiZhc2v9nTDLftaGestDf4NZs8kZu+lI8YuESJduU/7bdBqJpU9kdv0IJ2pubxCPRuA92a58qJ3vaPtNcD108gTaleGNz+SS/weG09zJpGH/O8uGGQ8Z4Jsm5fyo1srwYR9XhiFZEAR/hxb4BBEulM91AatGsckM5Tb6Y1XI8c70kSCTgAt6T3PH1pQDXs9mASy4Jz7lE34bahVAVs6CF8jmxSJ15lap4d6oLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcUCsHDOS1mwtvW0OpCsIxwcfsp22daMALGVK68o0Sg=;
 b=TXfwbGanC7jk1WoxCqVCPB/vpvEisaUq0VL40amtIsXbe6HIgSEqqc+WYCoVePDpsiUDLRm33yAb7rdxGplC4cmHNQClfxqPbEwlQwXZhho7bYjW0aDvdM+LHLmtrHC9tozIKhYXJU7MX+tMXA9vYzzbVV/KbIMqHuMQAhuat0k=
Received: from BN0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:408:ec::11)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 23:00:28 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::40) by BN0PR04CA0096.outlook.office365.com
 (2603:10b6:408:ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Thu, 23 Jun 2022 23:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 23:00:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 18:00:27 -0500
Date:   Thu, 23 Jun 2022 17:59:49 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Hugh Dickins" <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <jun.nakajima@intel.com>, <dave.hansen@intel.com>,
        <ak@linux.intel.com>, <david@redhat.com>, <aarcange@redhat.com>,
        <ddutile@redhat.com>, <dhildenb@redhat.com>,
        "Quentin Perret" <qperret@google.com>, <mhocko@suse.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220623225949.kkdx6uwjlk2ec4iq@amd.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YofeZps9YXgtP3f1@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483e1c84-7011-4faa-d5f4-08da556c2a40
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/mqeTfxDmYu1qUPc5xoXwJOAG1XrRSYYOBQSjQn4MM5Qg+JYTVQ00cUUaOiqQGo/hdoeSH/MsDjPwe1QEQuvzOG1eDHVBggEu2Bpnu11/TZGmSJLwTwcRaMozEGvs9+F5OTfwSZRWodDcD18d6AJLFnEJ6Fh8vpSyF/bnl9WS6aQt4uFcKgSCE42WzT62B/uxXYrZymSzHhx37PXwoxBeClbkw9SWyf3DuEllR+i8mN7YNkvt1nm2TxPW8CLLGKImTwBtF09EgqR37hb3H2vLAGbgshLcKmdSCcD3x+LjdrwdmwZuVGDuZfhWX9ztamhL4CDd+942ulPdnvYjuftj/k1IMd4pIeL7L6uC2qZxgYEqlAsPsrqP0XsY2uAq7J3zaaVEDHe6eTQxDnoAJbq/3k5OYWsBIz/NUT9M9s9eVhM8BNz//9bodToBuFJNGLrhKTPazQqDTMYnTSsbb1cHDo/5desLuXwTJAtF2OBP0A3g0Us0+Ydz3JT09+eaqokiry2EW0FKdz/CJ7f7KtPRnzLxMdK1PajI7swKD7aEfmJSK5GEloQvAiNHjeENbJEOqCJQkJjX6CWFV+JDWRHO/630D1/qfbOwtyYMFMuzeVaW6/gp1KYE7ff3+Qx0qQZH1OrKDkmXVrW/dBjQz7UtAkvOELCJqttZJgWCd2UKqpHt01LJthW4sCCBYE94Ik/JCRXJNHG71dQ9wvhsA4u9gh+8hjCnxiWvobYi7FdIcWPlx9G0XW1UrlBpizmc+FhqVPmt7duCHPVpMhm4DFoxYXrvGclKkZEkOb29+Q/djrfH71l9gUtH9tbAtaSwTCCsOzvFbAxnBp4lFGhUDzRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(36756003)(336012)(70206006)(4326008)(8676002)(426003)(83380400001)(16526019)(316002)(478600001)(54906003)(6666004)(356005)(186003)(1076003)(2616005)(86362001)(7406005)(70586007)(40460700003)(44832011)(82310400005)(40480700001)(8936002)(6916009)(81166007)(36860700001)(41300700001)(2906002)(26005)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 23:00:27.9286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483e1c84-7011-4faa-d5f4-08da556c2a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> On Fri, May 20, 2022, Andy Lutomirski wrote:
> > The alternative would be to have some kind of separate table or bitmap (part
> > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > 
> > What do you all think?
> 
> My original proposal was to have expolicit shared vs. private memslots, and punch
> holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> handle memslot updates, conversions would be painfully slow.  That's how we ended
> up with the current propsoal.
> 
> But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> and wouldn't necessarily even need to interact with the memslots.  It could be a
> consumer of memslots, e.g. if we wanted to disallow registering regions without an
> associated memslot, but I think we'd want to avoid even that because things will
> get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> memory region is temporarily removed then we wouldn't want to destroy the tracking.
> 
> I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> should be far more efficient.
> 
> One benefit to explicitly tracking this in KVM is that it might be useful for
> software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> based on guest hypercalls to share/unshare memory, and then complete the transaction
> when userspace invokes the ioctl() to complete the share/unshare.

Another upside to implementing a KVM ioctl is basically the reverse of the
discussion around avoiding double-allocations: *supporting* double-allocations.

One thing I noticed while testing SNP+UPM support is a fairly dramatic
slow-down with how it handles OVMF, which does some really nasty stuff
with DMA where it takes 1 or 2 pages and flips them between
shared/private on every transaction. Obviously that's not ideal and
should be fixed directly at some point, but it's something that exists in the
wild and might not be the only such instance where we need to deal with that
sort of usage pattern. 

With the current implementation, one option I had to address this was to
disable hole-punching in QEMU when doing shared->private conversions:

Boot time from 1GB guest:
                               SNP:   32s
                           SNP+UPM: 1m43s
  SNP+UPM (disable shared discard): 1m08s

Of course, we don't have the option of disabling discard/hole-punching
for private memory to see if we get similar gains there, since that also
doubles as the interface for doing private->shared conversions. A separate
KVM ioctl to decouple these 2 things would allow for that, and allow for a
way for userspace to implement things like batched/lazy-discard of
previously-converted pages to deal with cases like these.

Another motivator for these separate ioctl is that, since we're considering
'out-of-band' interactions with private memfd where userspace might
erroneously/inadvertently do things like double allocations, another thing it
might do is pre-allocating pages in the private memfd prior to associating
the memfd with a private memslot. Since the notifiers aren't registered until
that point, any associated callbacks that would normally need to be done as
part of those fallocate() notification would be missed unless we do something
like 'replay' all the notifications once the private memslot is registered and
associating with a memfile notifier. But that seems a bit ugly, and I'm not
sure how well that would work. This also seems to hint at this additional
'conversion' state being something that should be owned and managed directly
by KVM rather than hooking into the allocations.

It would also nicely solve the question of how to handle in-place
encryption, since unlike userspace, KVM is perfectly capable of copying
data from shared->private prior to conversion / guest start, and
disallowing such things afterward. Would just need an extra flag basically.
