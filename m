Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938379F6FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjINB6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjINB5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:57:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04F2735
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:03 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-273fa168866so433158a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656563; x=1695261363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pjDK4myqRW/1aonXWMm2h3oZGIvtROhN9F/LidQar5g=;
        b=dJtzDA07+INpKs4V5zvz6WT/LN0VMq3pBBB4mtURmvN9yqyhPSN2hqL/Bc35JPrN2Q
         DCJ+T9w5+YhgZr6eyIYd1KPkckhCAzkmYQGUKxIf/9iOSiuuZ4WAnqp/ZCAOLxxYUWwI
         VpzldBLOIJaUmBBLGpA6ES1HayBQkSlwA4BI4/O8P6z0X5FQhzQwLWRyNJEbR0B9hpdq
         dJdpcakEyPZ3k2SHfuBpAzD3z0KWaBHkf0ez6F0eXCAtvB1evj9ODauCHtSjdweOQ/TT
         z6qw9lTUlKuO9lUrmHzEmAQkg+zjLq+zWrG7OQOhwyUWT/SqP4Y6xUoLcClZrGjoKfUw
         rCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656563; x=1695261363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjDK4myqRW/1aonXWMm2h3oZGIvtROhN9F/LidQar5g=;
        b=It8NsIPms0yi1FsBOKJd3KyX3EYKOIOt/juOjjJa/3dEICQEeKKFp/9OkB1EdliPaB
         OPiPhXiDR7cT0/vXgdBHb5PTcqXhynk9QIxbxjSDNuXcDe/9D4+2av8rnQeqTTnK+7zr
         aefh4vF4tzznn/nyHX278rJQuwHoKmRwtUCb2UMaewoOtN826zU4+xUuZ/BkgqH1GmLN
         uknnkUR8tUE3+utSAblZdPQg549ontombrUEqkE7mdEZxwSpIBqN4mLLDXmxxMxrTF5L
         PHPNpsyXaqQlHYfsPAP1Nkcy9BKqM6knxOq11G3VV04i6y/Q9JdmjmVRJZoll6P87NNG
         3C8w==
X-Gm-Message-State: AOJu0Yz3QXE5Dgn8CEpoMioBNuGjFp86Gtil4M9OhI0Ki2qwew39ACgN
        iVIGyIkDQoBJy/0dl9wh8lkNTNABUjs=
X-Google-Smtp-Source: AGHT+IGkqKKLF+YNvEneEdPalVclX+vMSg6CmJX8h6r/u0gfxt18eBEohuQohG5dATROkCqosWZykFZT8R8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fa8b:b0:1ae:6895:cb96 with SMTP id
 lc11-20020a170902fa8b00b001ae6895cb96mr149990plb.5.1694656562630; Wed, 13 Sep
 2023 18:56:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:11 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-14-seanjc@google.com>
Subject: [RFC PATCH v12 13/33] security: Export security_inode_init_security_anon()
 for use by KVM
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TODO: Throw this away, assuming KVM drops its dedicated file system.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 23b129d482a7..0024156f867a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1693,6 +1693,7 @@ int security_inode_init_security_anon(struct inode *inode,
 	return call_int_hook(inode_init_security_anon, 0, inode, name,
 			     context_inode);
 }
+EXPORT_SYMBOL_GPL(security_inode_init_security_anon);
 
 #ifdef CONFIG_SECURITY_PATH
 /**
-- 
2.42.0.283.g2d96d420d3-goog

