Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CA7B317C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 13:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjI2Leu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2Les (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB91AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695987238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41757PcJTfcJdCCJnzrk+mJV9SfHrDKMX8xcqYqo8lQ=;
        b=MX8VnDjfwmn4X6gHFJp/9ygDiz/1IyXPj3D1wvY23TMQGnXaPEVMZndIBUrZ/3CD2N3GIh
        BG/0TPY55k9+cBIjLzyvb+tFxcgUA5A9MjEtebegPIcBBgfTaDenQDJF2m0vOZ6JGJgEq+
        aaRFaZOrOzDxo/h2MwMbuL7GstqSfiY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ESuMWTToNL-cBLlmhcSORg-1; Fri, 29 Sep 2023 07:33:55 -0400
X-MC-Unique: ESuMWTToNL-cBLlmhcSORg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dd053fb4f0so22854528fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 04:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695987234; x=1696592034;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41757PcJTfcJdCCJnzrk+mJV9SfHrDKMX8xcqYqo8lQ=;
        b=EdXd0Ibw2GX0MqKDbxzS4TjE4bgz37YEFiItnzNRxT3QTJihN32ATxbXN5GBBukrCl
         QdbLe5YeVLQF2Y2NeT0WriL9s/Rqd+rSr9VF0L/SqncKz6SdoVavoXLhL2lY1RJiiYgh
         vrpVKbcl3yZtASBqiQrZF9gD2bJL6NRJ5O/6lCn5HmR3BSNTGQjBko+Tg8SttVxCNu9F
         mW7mifL1TmHrU5PknppE4USWW3yGmna53Za7CpBEWbAybJoIrag03gEBKZWwWA8Y/3Se
         N9OyQ+HJLYDUbH9Oy8ew2fxP7Co3BI8fr1rKnpHkESgy145686rLCocZq/7QAya3Ga1L
         hm8Q==
X-Gm-Message-State: AOJu0YxCqneCop/nxWiw1ITOkGbgn2tfG9vUlM7L7eo5VrMwISHwOZ9x
        nCoPub3b6nkviHkeW2RiddkJ9UpDqGwviDtXJMqojWE2xbWg6sGdgCrGUzTK68axwOKQM2X55Zg
        BypBtwZaJAfuVNOMQKFS6paI0gQ==
X-Received: by 2002:a05:6870:390c:b0:1d5:8fb8:98ef with SMTP id b12-20020a056870390c00b001d58fb898efmr4239893oap.31.1695987234746;
        Fri, 29 Sep 2023 04:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy01C0dVSSXf6tbU8suZwYSLTAwJpM9IkDfrRHB2EAqrXb4oZMZ4C9QwPCRWN7o+nu7em3qg==
X-Received: by 2002:a05:6870:390c:b0:1d5:8fb8:98ef with SMTP id b12-20020a056870390c00b001d58fb898efmr4239876oap.31.1695987234411;
        Fri, 29 Sep 2023 04:33:54 -0700 (PDT)
Received: from rh (p200300c93f19a200f43f623a676b2d27.dip0.t-ipconnect.de. [2003:c9:3f19:a200:f43f:623a:676b:2d27])
        by smtp.gmail.com with ESMTPSA id s8-20020a0cdc08000000b0065afa998364sm1149936qvk.95.2023.09.29.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 04:33:54 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:33:50 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Kees Cook <keescook@chromium.org>
cc:     Eric Biederman <ebiederm@xmission.com>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
Message-ID: <7ddc633e-c724-ad8d-e7ca-62d6b012b9e9@redhat.com>
References: <20230929031716.it.155-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Kees,

On Thu, 28 Sep 2023, Kees Cook wrote:
> This is the continuation of the work Eric started for handling
> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> BSS, segment). I've added the suggested changes:
>
> - drop unused "elf_bss" variable
> - refactor load_elf_interp() to use elf_load()
> - refactor load_elf_library() to use elf_load()
> - report padzero() errors when PROT_WRITE is present
> - drop vm_brk()

While I was debugging the initial issue I stumbled over the following
- care to take it as part of this series?

----->8
[PATCH] mm: vm_brk_flags don't bail out while holding lock

Calling vm_brk_flags() with flags set other than VM_EXEC
will exit the function without releasing the mmap_write_lock.

Just do the sanity check before the lock is acquired. This
doesn't fix an actual issue since no caller sets a flag other
than VM_EXEC.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
  mm/mmap.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..7ed286662839 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3143,13 +3143,13 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
  	if (!len)
  		return 0;

-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
  	/* Until we need other flags, refuse anything except VM_EXEC. */
  	if ((flags & (~VM_EXEC)) != 0)
  		return -EINVAL;

+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
  	ret = check_brk_limits(addr, len);
  	if (ret)
  		goto limits_failed;
-- 
2.41.0

