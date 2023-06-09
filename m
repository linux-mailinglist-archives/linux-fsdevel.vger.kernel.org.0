Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749A729DC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjFIPFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjFIPFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:05:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113811FEB;
        Fri,  9 Jun 2023 08:05:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so1920364f8f.1;
        Fri, 09 Jun 2023 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686323099; x=1688915099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm1RzwDp533yvq8IXnJJlJWRXI4ay4ojZpMj1ZL4i0Q=;
        b=YaxCfluHQ/VIRRtKjub/lFepPWEjg5aqVNg6fyE16/08p6eeh+nT1n03hXXs9WAuwI
         ux9q49U+AYXpmuozmMm9FbXRxTwSOkpF24kMLw2TGYmXHUs9yFZcDWm6F1heZzIX8h94
         b+xSZ70WhLs29/9XXDLvOqW7qDvY7PYHkDTzsGsfsPQfvc5DcjW/t0OR9hvzQseH5PeA
         epg7o7Pl39QvPyGnbocxl1DcvJmywV+iuWlxYPFXnrH81CqoIEOUU6vPHcfo3vJPh2WD
         V2qVtWogwLUWj+HrQ1kGuMpJdKzHP0dlEqk37SOhbKf+qxzoUKuBVd92RzP81hWVdz1/
         NHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323099; x=1688915099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm1RzwDp533yvq8IXnJJlJWRXI4ay4ojZpMj1ZL4i0Q=;
        b=SQh2eEv9a4wZ5Jrxf/V3vYAoN2vEMrncRxK6cBCl0d2Xq5govSv6atCvVYJU7vdljI
         aOidACpyk9GaKJu+9d4fPJR4JYo95+D8MKHLm5zxmV/hX2rKVJCtFI3f4cM6zRTt7y+g
         j+jBdHwGQXOd1rC5s7hzylRcYFaeuYGz3f9mmD7vsW0pCRFhMlpcWQ4mrmPoZNQ1M1MJ
         yvQeAoBc0j/wtRYju/yI+aukpclgTJh9ACPvctRmndlkhWbqGGvjEnVKZHpCTEh2j5Tw
         vDpdzAmdW4g2K75xmQkZ68yGdndP+LsXGb5BnsbVreTDEu+KrYNWDvdmDqpCVjnoB4ct
         hGIQ==
X-Gm-Message-State: AC+VfDyYGesfwU+hbMPL00eT5pYxwc/hnK58nfaRlLAsbJvB1CnSUJBS
        o4kCFOGLXZ+hnGmzXIy1+HKuxwnUQig=
X-Google-Smtp-Source: ACHHUZ5fWVo/td8zldlBcdi1ZwlsUd8/y1QFt87zTALroZtEvJ7WQMrgyIAgwsueFn8d5x5vlnZ8WQ==
X-Received: by 2002:a5d:525b:0:b0:30a:f3ca:17ad with SMTP id k27-20020a5d525b000000b0030af3ca17admr1247470wrc.66.1686323099134;
        Fri, 09 Jun 2023 08:04:59 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0030aedb8156esm4636359wrr.102.2023.06.09.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:04:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <matthew.wilcox@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Fri, 09 Jun 2023 17:04:56 +0200
Message-ID: <23757331.ouqheUzb2q@suse>
In-Reply-To: <20230119162055.20944-1-fmdefrancesco@gmail.com>
References: <20230119162055.20944-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=C3=AC 19 gennaio 2023 17:20:55 CEST Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().

According to a suggestion by Matthew, I just sent another patch which stops=
=20
allocating aio rings from ZONE_HIGHMEM.[1]

Therefore, please drop this patch.

Since the purpose of the new patch is entirely different from this, I chang=
ed=20
the subject and reset the version number to v1.

Thanks,

=46abio

[1] https://lore.kernel.org/lkml/20230609145937.17610-1-fmdefrancesco@gmail=
=2Ecom/
=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> The use of kmap_local_page() in fs/aio.c is "safe" in the sense that the
> code don't hands the returned kernel virtual addresses to other threads
> and there are no nesting which should be handled with the stack based
> (LIFO) mappings/un-mappings order. Furthermore, the code between the old
> kmap_atomic()/kunmap_atomic() did not depend on disabling page-faults
> and/or preemption, so that there is no need to call pagefault_disable()
> and/or preempt_disable() before the mappings.
>=20
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> fs/aio.c.
>=20
> Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.
>=20
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---



