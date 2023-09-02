Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B8790829
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjIBN76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Sep 2023 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIBN75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:59:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347EFC;
        Sat,  2 Sep 2023 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ykAU0IuBWCOAh/V+bHoSxJwmB/ONT4m36dnHXVeI+gc=; b=M/kbn/GSgML7w28FfggmH7XG6B
        AoIOPSIS/rWN+MsWq75QfC/Aee19klAuIvycRMJdm8AER52SmM8ldLrimDyFfGzgfA1Lh27sJMhjx
        9yR6IcYoIrGndMgjYzvRoVm4M/ZCmqT4UI5tCYhmnQUr66neucxUcFUTIXtw2EMPmynRUEf96gTef
        F7fCCcZU2Z6YpiIZfwoADbPIrShS3D2YGkNno4Vrc5chfgi8c+J1r/XUDm2LU5pVzVck07858xIDd
        e7YyQUXHRVLmmrJ2hEWQiN04YMXTLjuPogl7tDhN6y4GH1ZZAKxIH2VC7FBmAjAZduDxoiuRKz6Xp
        RntoFSfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qcR9o-00EvUv-Kx; Sat, 02 Sep 2023 13:59:24 +0000
Date:   Sat, 2 Sep 2023 14:59:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     seanjc@google.com, ackerleytng@google.com,
        akpm@linux-foundation.org, anup@brainfault.org,
        aou@eecs.berkeley.edu, chao.p.peng@linux.intel.com,
        chenhuacai@kernel.org, david@redhat.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, jmorris@namei.org,
        kirill.shutemov@linux.intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        liam.merwick@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com,
        yu.c.zhang@linux.intel.com
Subject: Re: [PATCH gmem FIXUP] mm, compaction: make testing
 mapping_unmovable() safe
Message-ID: <ZPM/vJnwI4bi9bo2@casper.infradead.org>
References: <20230901082025.20548-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901082025.20548-2-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:20:26AM +0200, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable - it is the
> case for guest memfd folios.
> 
> Also incorporate comment update suggested by Matthew.

In the meantime, 866ff80176aa went upstream earlier this merge window,
so it's going to have some conflicts.

