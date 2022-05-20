Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D852F2A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352683AbiETSbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352725AbiETSbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 14:31:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908C13E06
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:31:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 202so1427416pfu.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/D44zTPGmOvqCz58NoXY7GJ7Oz3KVoVYsKXMavYtIGY=;
        b=hXnBtM8ClLBza+ZRSfpaH9QJs4e70zsjGGwXTB768f+j3vqY+PwjCmxCHfgcbOWUIo
         WkA4z40qGEeH8ye8nA+9vKsDvo6jzo3aKNFN66eMopiC5L5Nz2Rul1xe3uZjLa1NNsDS
         u417yZ070yvLbJ7u7T7AavZQoAUrK7xIHezbfLj969JZM7ZTkx89y4HMQ1l2TNDF2Sq2
         0LpzAaltp9AMFcI6xh0jpic9+djmA9wPzf6w2Yikovx4w7ogKachx1moE40EDvrT0Jd+
         1BUoZb8r51kRFW2pPCxPq3BYf2iYgtUzn0y36Ygbn7Tx0RaCNfgu370pJo+mNPyz2DS+
         NhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/D44zTPGmOvqCz58NoXY7GJ7Oz3KVoVYsKXMavYtIGY=;
        b=oSdGTHINc2FH3cplJpbewx80UF50jGvNJRE95SrqPRrtxxPQp0SJBkgf6O4sFQiJH8
         9+9YCT3A5hbawHgRjyPV4McgFUboU6gwL5set4kh9PWEbZnjbM+NgavtwqnzHPHv2o2W
         +aCLjAfPFKSYy2nhuLbKoxKEPh+HPt3jIUAE53mOyp7MXE7U+6jUVCvjQRuBJ/fkpj2t
         DBdNPngzRc48aYwobSLwIX7Xw5Jt7FrQxZcec6Q6XNUHZebAdJiTHlLdc4mFBrV2CNC3
         8iE7CWjjO4YEx0S2TS5baVJonFDbsFd8CvpLEOf7IJrGIwQxELtVUgtR4R0OFi3jCxYq
         aoeQ==
X-Gm-Message-State: AOAM531rtLPzXU1Tf5931E6yYuMJ/K8oqPV54f5/BRgZcRDLi8DuXxfz
        zRIKZ1Xe7J/9U37V0KoTejcm0g==
X-Google-Smtp-Source: ABdhPJyXfnLY4U/z7B1YcpHIUBMTDAqIQuWt14grJnUQKMT9mxPH1mHBF0sFVeaMIPjRZNdy0Y/CKw==
X-Received: by 2002:a63:8243:0:b0:3f9:6c94:5112 with SMTP id w64-20020a638243000000b003f96c945112mr2534146pgd.173.1653071466429;
        Fri, 20 May 2022 11:31:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a201-20020a621ad2000000b0050dc76281e9sm2105316pfa.195.2022.05.20.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:05 -0700 (PDT)
Date:   Fri, 20 May 2022 18:31:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Message-ID: <YofeZps9YXgtP3f1@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
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

On Fri, May 20, 2022, Andy Lutomirski wrote:
> The alternative would be to have some kind of separate table or bitmap (part
> of the memslot?) that tells KVM whether a GPA should map to the fd.
> 
> What do you all think?

My original proposal was to have expolicit shared vs. private memslots, and punch
holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
handle memslot updates, conversions would be painfully slow.  That's how we ended
up with the current propsoal.

But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
and wouldn't necessarily even need to interact with the memslots.  It could be a
consumer of memslots, e.g. if we wanted to disallow registering regions without an
associated memslot, but I think we'd want to avoid even that because things will
get messy during memslot updates, e.g. if dirty logging is toggled or a shared
memory region is temporarily removed then we wouldn't want to destroy the tracking.

I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
should be far more efficient.

One benefit to explicitly tracking this in KVM is that it might be useful for
software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
based on guest hypercalls to share/unshare memory, and then complete the transaction
when userspace invokes the ioctl() to complete the share/unshare.
