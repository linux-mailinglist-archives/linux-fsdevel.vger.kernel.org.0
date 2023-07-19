Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0282D759731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGSNjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 09:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGSNjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B811C;
        Wed, 19 Jul 2023 06:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432BB61638;
        Wed, 19 Jul 2023 13:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507F6C433C8;
        Wed, 19 Jul 2023 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689773980;
        bh=KIb7q+NtNE+KBfEiNJ0Q3nOHxWMm45lA4WVZ9SwBWF8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=gaqxW45kGtoKFnDNNv629brjH/mey+u1zrY+JTYF+Xct1aygG1J4Cf6N5TAdbyf95
         2UQ3DpMsJY9gZ/ErtakGGWIqjwaqOwsKcm2y3YVSYVrxM+2RWzCuF6bzEjT83PpAcr
         AGyWDI+pJBXz2XJ1m2wYil5ZnC85al8khQ/W4g+oUVReQT1yoreruC76NRb0RMublg
         +no2nvv+RqXbaCJv3KQVstHdVnFLcEEYeY1VCIjZ704OwGCykRUyhgj3tGnEgItJBD
         Kzs/75HMkiwCdVcTz9jVBoTVjf+xmRrTVbvZXW9OTzSwRub4koHl/Aq6fKSbtpIb+H
         H1gh8r1VAddMg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 19 Jul 2023 16:39:23 +0300
Message-Id: <CU66VMG4IKSD.33KF2CEZJ2I1@suppilovahvero>
Cc:     <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        "Fuad Tabba" <tabba@google.com>,
        "Yu Zhang" <yu.c.zhang@linux.intel.com>,
        "Vishal Annapurve" <vannapurve@google.com>,
        "Ackerley Tng" <ackerleytng@google.com>,
        "Maciej Szmigiero" <mail@maciej.szmigiero.name>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        "Quentin Perret" <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>,
        "Wang" <wei.w.wang@intel.com>,
        "Liam Merwick" <liam.merwick@oracle.com>,
        "Isaku Yamahata" <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a
 per-action union
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Sean Christopherson" <seanjc@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Oliver Upton" <oliver.upton@linux.dev>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Anup Patel" <anup@brainfault.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.14.0
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-2-seanjc@google.com>
In-Reply-To: <20230718234512.1690985-2-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed Jul 19, 2023 at 2:44 AM EEST, Sean Christopherson wrote:
>  	/* Huge pages aren't expected to be modified without first being zapped=
. */
> -	WARN_ON(pte_huge(range->pte) || range->start + 1 !=3D range->end);
> +	WARN_ON(pte_huge(range->arg.pte) || range->start + 1 !=3D range->end);

Not familiar with this code. Just checking whether whether instead
pr_{warn,err}() combined with return false would be a more graceful
option?

BR, Jarkko
