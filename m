Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742BF546A2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbiFJQO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiFJQO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:14:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A6219006
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 09:14:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c196so24263458pfb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqYpRJpV7hTVkJzWeySC/55ywPreerEYyAHVK7rq9LA=;
        b=ZehwwLYuij7pbQaghWD2GrdTIOfQ1XgasEUmVI+nhvd82X4ZEWGF79XBvheRliFM+8
         LQlrxByJVokCQ/gINBsFhOZhZjHXcpmAir492TXOaXI7iC/F7Bwi4ptRQtYUbYGyY5SQ
         TxK5qW/wV8CCV8YqQLV5jWM8YEEm92a1WCcQVxigUczBkLKzhwgrSGPjDy4yzeckQMEl
         k23GcmLFp8s0aWbczjuNfnjBEB9gzzj7nGZZJi5rfah1FRb/8MQ3Cd99incf77459IOk
         fmV8msfIleb4V2r4FMWvWw0fr1RX3bQCUO2JP23SfG2qby97FTF15ddfD8Y7n8su8tG3
         h2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqYpRJpV7hTVkJzWeySC/55ywPreerEYyAHVK7rq9LA=;
        b=Y4dvufTek7dymCzxswU9F2HLGF2WRfmbezXdb3fuomhQaLTZ4XWfmOc6n4MhHrPxTI
         HhM4qg2CKn1fjwj+S9bGRoczkvuM8bRG6eqiE/6LT6wxenD0fOkiNhr2MaBXmWMi+Owe
         VGfH4ERn5ovpLp37r7HsACBNsBgyZXST+jarV0dsVRs2BBYdAwte4iqPMI9mgBHJIChl
         KM+0lvxuGwbfIl1tm7vUGSZuUA1tz9wHT8YjL8ff6eDuZ33T19zYsufP/arJCvuKAkDj
         perrmODjC5ODTg3UlJklWH+sJ2blgPIwkD59g9PmwOaivQZL2+ad8RRUvTag7DemCHnc
         tP/g==
X-Gm-Message-State: AOAM533y+yXXKrFMryJ4Zmv2yT5fpkaMdJxGszDDp2PYyoDPC+nmvH7w
        t5BcrLU6iQC0dxawfv1wG5E9xQ==
X-Google-Smtp-Source: ABdhPJzxrryZznx/9GnvIIDqh+c23V5/Xt5ZsJHD0N8PohIbtiXWvM06mGWU66DmH3LeRvNyTftAHA==
X-Received: by 2002:a63:5:0:b0:3fe:2558:677 with SMTP id 5-20020a630005000000b003fe25580677mr14572323pga.113.1654877666234;
        Fri, 10 Jun 2022 09:14:26 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902e3cb00b0015e8d4eb28csm18669442ple.214.2022.06.10.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:14:25 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:14:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <YqNt3Sgzge5Rph/R@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220523132154.GA947536@chaop.bj.intel.com>
 <YoumuHUmgM6TH20S@google.com>
 <20220530132613.GA1200843@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530132613.GA1200843@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022, Chao Peng wrote:
> On Mon, May 23, 2022 at 03:22:32PM +0000, Sean Christopherson wrote:
> > Actually, if the semantics are that userspace declares memory as private, then we
> > can reuse KVM_MEMORY_ENCRYPT_REG_REGION and KVM_MEMORY_ENCRYPT_UNREG_REGION.  It'd
> > be a little gross because we'd need to slightly redefine the semantics for TDX, SNP,
> > and software-protected VM types, e.g. the ioctls() currently require a pre-exisitng
> > memslot.  But I think it'd work...
> 
> These existing ioctls looks good for TDX and probably SNP as well. For
> softrware-protected VM types, it may not be enough. Maybe for the first
> step we can reuse this for all hardware based solutions and invent new
> interface when software-protected solution gets really supported.
> 
> There is semantics difference for fd-based private memory. Current above
> two ioctls() use userspace addreess(hva) while for fd-based it should be
> fd+offset, and probably it's better to use gpa in this case. Then we
> will need change existing semantics and break backward-compatibility.

My thought was to keep the existing semantics for VMs with type==0, i.e. SEV and
SEV-ES VMs.  It's a bit gross, but the pinning behavior is a dead end for SNP and
TDX, so it effectively needs to be deprecated anyways.  I'm definitely not opposed
to a new ioctl if Paolo or others think this is too awful, but burning an ioctl
for this seems wasteful.

Then generic KVM can do something like:

	case KVM_MEMORY_ENCRYPT_REG_REGION:
	case KVM_MEMORY_ENCRYPT_UNREG_REGION:
		struct kvm_enc_region region;

		if (!kvm_arch_vm_supports_private_memslots(kvm))
			goto arch_vm_ioctl;

		r = -EFAULT;
		if (copy_from_user(&region, argp, sizeof(region)))
			goto out;

		r = kvm_set_encrypted_region(ioctl, &region);
		break;
	default:
arch_vm_ioctl:
		r = kvm_arch_vm_ioctl(filp, ioctl, arg);


where common KVM provides

  __weak void kvm_arch_vm_supports_private_memslots(struct kvm *kvm)
  {
	return false;
  }

and x86 overrides that to

  bool kvm_arch_vm_supports_private_memslots(struct kvm *kvm)
  {
  	/* I can't remember what we decided on calling type '0' VMs. */
	return !!kvm->vm_type;
  }

and if someone ever wants to enable private memslot for SEV/SEV-ES guests we can
always add a capability or even a new VM type.

pKVM on arm can then obviously implement kvm_arch_vm_supports_private_memslots()
to grab whatever identifies a pKVM VM.
