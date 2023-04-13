Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDB6E17B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDMWxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjDMWx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:53:28 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BAF171F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:53:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i10-20020a170902c94a00b001a0468b4afcso8818788pla.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681426404; x=1684018404;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8guo045Q+5eAEwhfUr30hz0PJkqMwxW7HV3gxeLbUM=;
        b=Rjwp4Xdm6ZLaEPgG8cQHjLF9ituKkBuE4Kg1flS/uBoAlJ5LElw7Yfif+urjga4Z1k
         Id9XGYBIPjUILBU5HRcXu81p8pDXA/u7T7lfZ53bFi0pGFkAASoZMc1FKWQlhEzWj7g7
         M8ApiMQugbqBdsiM2beP1Zmsfm7UP5aAC4H3s81SX9hYygeAlfdJWkF78OhRMgmv5bOY
         YVoHszS0N47VwRyOsgUt/J/+QeiNlvAv36oX5BxahWlc22nXKEGI9AqKs9w9dhKamSyI
         7JyyYvDzq5fdoA1a6pagi9+JsHhlJPaWALPTL0IkyyyP5IWH3eftfLt0+7o6zZeS826/
         vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681426404; x=1684018404;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8guo045Q+5eAEwhfUr30hz0PJkqMwxW7HV3gxeLbUM=;
        b=b+Kp0bAj20RQjAt389hLsOa1o0K4kHxaEDFuaREpEGY2Vonkyu+Qks8d1PsRZoO2qm
         1NPhOkZElDQpGm9xwRX7ap4wzEwwJ6DZdAhMUcR0VV/9NAarz4rsia6UOEvjJA2H9s4R
         XK7jAi6rZLraY31G7pYbxph9w3jmVPT6vJAMoXlFOwfHTsbUdzu4P7rrDXmr+q9IbY+I
         b3R4C8SuuOBHU26h8/dWcnKJ/MpynlO/WAt1BjrbFpeLarIfsGLNmMxeH+hkklKb0yxg
         6qGoG/XIt5kReXB+rKxFhdOBv5Tbb7lMrwxwOALrgVo7zinrUFRUvbvHYFk1grd95cnZ
         ektw==
X-Gm-Message-State: AAQBX9eucxyFVgoGIi1Wgsxz0Mb47rn0wsV15I2ajOv+VY87Ee4l6c7J
        ln+ZfeyeFaX/4P2gvjuFfxhOZyXsCxl3zymCrg==
X-Google-Smtp-Source: AKy350ZDf9SfJRuS6hlT3xzlEOA5lECkBtR1nsxMCxij1QGPtfZHXE7tqJcIaT1y2UkRtOi3D6c9Q8ilUDsupR7kxA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:3ea7:b0:246:f5c3:576 with SMTP
 id k36-20020a17090a3ea700b00246f5c30576mr979461pjc.6.1681426404283; Thu, 13
 Apr 2023 15:53:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:53:22 +0000
In-Reply-To: <20230412-kurzweilig-unsummen-3c1136f7f437@brauner> (message from
 Christian Brauner on Wed, 12 Apr 2023 11:59:52 +0200)
Mime-Version: 1.0
Message-ID: <diqzedono0m5.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Wed, Apr 05, 2023 at 09:58:44PM +0000, Ackerley Tng wrote:

>> ...

>> > > Why do you even need this flag? It seems that @mount_fd being < 0 is
>> > > sufficient to indicate that a new restricted memory fd is supposed  
>> to be
>> > > created in the system instance.


>> I'm hoping to have this patch series merged after Chao's patch series
>> introduces the memfd_restricted() syscall [1].

> I'm curious, is there an LSFMM session for this?

As far as I know, there is no LSFMM session for this.
