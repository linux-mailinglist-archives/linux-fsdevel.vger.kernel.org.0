Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2A7734DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 01:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHGXUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 19:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHGXUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:20:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672A1705
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 16:20:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58473c4f629so58837537b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691450416; x=1692055216;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ut/hDJ+qFMS0sDMssVLi/Qh1tossNoTViyk+Sv5I6I=;
        b=OnbGVA8IPnrsdTREsUm581mRdehgXJT0uL+ALPcn3gfxErJrXCtKmSomsOKaQATGMh
         f0VvgjqMIW5HLukSt/TZqta9FHSpbW8xuPg/WJY9Y8dBtzBXk68FxKvGTf0SBMt/xuPE
         yb72/yaLEWHxd2i86q/oL/iyLDDk998ORMSoUHaZduqRHpQmcSBeRXdyojnyjv3Pm4Gp
         0hyU2N4jgt9pJV3/SHK5m7Gafo6teeA6CAaXNJJ1Z5NngK3Yas1VVpJwsDY8b342oTWb
         +N+E2aHGEdoYFXjyTrvdzsHzrQ8RpCJH9Ba/1//rKN61ZJdF3SLJ42ybI7Ydk3RiGWfT
         qyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450416; x=1692055216;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ut/hDJ+qFMS0sDMssVLi/Qh1tossNoTViyk+Sv5I6I=;
        b=PJKeMmJn1Kh1R699ANFAVygFM43D5s7JqJSFF9ssc6dpSE+KVUe6UsHMkx/svGqx+z
         TJZ2GZ495HsgKKWYAuFBhGNZzocsUkoDhoJOopGG2RVTImkAA5eDEBPQIWduRta2bMVm
         J+3vH+8Gx9g59EvTJPsUMzK9hE84BcIvlua7MgM0eJ7fWcXw4f7qy5wEQkSWJUmbSZ8F
         qYS14UHV0Ysq7aeXgeRfDDa1O2SrHgqms7Zne+eulJLwrRnGLcMetzC0THTXD9QoMObG
         xmUY2lDAsHmKTbbyppl2mdUtHf9Gqk36Gru3V57W4gs3mDNVCLO5DBqa0MVq5X8613/T
         pYng==
X-Gm-Message-State: AOJu0YztwYQ1B6N/AieuC/JNTluZKHDd/8+I5lUgjtqB3JuZYyv7WfUi
        yg6A2MEdFZW+BK1pPbMWU9TcHyq7hNypU9w+Zg==
X-Google-Smtp-Source: AGHT+IGdVk9oJYWbSpXuFj0KYecexGvmGzQrsUIUE7DdG+7VjOx16xy0jF3toasrtnWqbigopnLRYvJP03sO+CW+ag==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a81:af45:0:b0:581:7b58:5e70 with SMTP
 id x5-20020a81af45000000b005817b585e70mr85942ywj.5.1691450416406; Mon, 07 Aug
 2023 16:20:16 -0700 (PDT)
Date:   Mon, 07 Aug 2023 23:20:15 +0000
In-Reply-To: <20230718234512.1690985-29-seanjc@google.com> (message from Sean
 Christopherson on Tue, 18 Jul 2023 16:45:11 -0700)
Mime-Version: 1.0
Message-ID: <diqzo7ji30eo.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v11 28/29] KVM: selftests: Add basic selftest for guest_memfd()
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Add a selftest to verify the basic functionality of guest_memfd():
>
> + file descriptor created with the guest_memfd() ioctl does not allow
>   read/write/mmap operations
> + file size and block size as returned from fstat are as expected
> + fallocate on the fd checks that offset/length on
>   fallocate(FALLOC_FL_PUNCH_HOLE) should be page aligned
>

> <snip>

> +
> +static void test_fallocate(int fd, size_t page_size, size_t total_size)
> +{
> +	int ret;
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
> +	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			page_size - 1, page_size);
> +	TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size);
> +	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size, page_size);
> +	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");

This should be

TEST_ASSERT(ret, "fallocate beginning after total_size should fail");

> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			total_size, page_size);
> +	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should succeed");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			total_size + page_size, page_size);
> +	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should succeed");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			page_size, page_size - 1);
> +	TEST_ASSERT(ret, "fallocate with unaligned size should fail");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +			page_size, page_size);
> +	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and size should succeed");
> +
> +	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
> +	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
> +}

> <snip>
