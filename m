Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3975A0CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 23:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGSVzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSVzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:55:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E051FDF
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 14:54:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99364ae9596so30777066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689803697; x=1690408497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpNnWnPyxzC0NSwOwUxwFXML73N2PXfa+cgDdImdoSQ=;
        b=NB8jnaILqWlUSjoqa2DuwIlr5sIiVBlH5ll0GB7VJ94jTNRcxdq+q2az4u6lN7VXg4
         o6F5xWDsnFWsZDWizA9OIwjzMHSlrRUaoLo029vmZSQpdr1QnED5t4IJxVLOx3N5Chj5
         vJ6nW9JX+Q34odPv8TCKxME8ZsorQXxh6hnJ29YYOL3G8jGAk9ugu3PK/op2Xo3Txdly
         /8lQPm/wBgWwivXi0h7eex59f2qSQk5GouUACFh/Dvh6ukKzlYRku86zlOqDmc5ynWMO
         12bMXDyHEdfjz7deE400RiH/PICVgW1X3e4/Nctw9ZRy8leGuoN1jIgsesu/ws9lKslt
         yseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689803697; x=1690408497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpNnWnPyxzC0NSwOwUxwFXML73N2PXfa+cgDdImdoSQ=;
        b=K4ZEZsyOf4tqfOSx7YUhbFmbOGK2tSshCntpYtER/twCggfVhvtUJ3Y/iwURvPuHYZ
         nqX059OYwG2WEUEYG6Pvr0sGZaRHKen5436YAuYHJ6XHKswRKQHa07CxbPZebpGCRroj
         vI/tMwA29ePwKxkz8QDDnQslCEppU8MA27IE+r7c1zA3wbc88y6Om667A3xizUdb6Wqb
         TfB0cBH8RIp+xmDOG//6rWHbwciQAlrpvLsvZGBLg8p2uKSf+58En7lfu4SaxN2q3asS
         S576/NwMlMBMGqBTKsz9fghEm4ruEKKpW0ttSr6omW3wW0EIiiCoKdytsG673ITeLy/F
         mgVQ==
X-Gm-Message-State: ABy/qLZEDkGXxDNxq0tA1k0IaQ/HI7wykGsRPlYk8cFJgscCrui++y/6
        v5ICEJ3TNtQdGehj8BYIzrXAhfEVFKQOMoVg1tR53A==
X-Google-Smtp-Source: APBJJlFNP/u4PLWdbUpDUO/EDcj+Vvn+ADWg7TLotRFNwc67uCHj7496GlfZJDuLIKnSUNN95ya3n1jNcy6cG+EYYmI=
X-Received: by 2002:a17:906:7a16:b0:982:2278:bcef with SMTP id
 d22-20020a1709067a1600b009822278bcefmr3469134ejo.60.1689803697537; Wed, 19
 Jul 2023 14:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr> <20230719211631.890995-1-axelrasmussen@google.com>
In-Reply-To: <20230719211631.890995-1-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 19 Jul 2023 14:54:21 -0700
Message-ID: <CAJHvVcj+Sc41mfercqxBii5cqRBEgZxNix2R1YMi04K-5nBh8w@mail.gmail.com>
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
To:     Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 2:16=E2=80=AFPM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> Thanks for the detailed report Dimitris! I've CCed the MM mailing list an=
d some
> folks who work on userfaultfd.

Apologies, I should have quoted the original message for the others I
added to CC: https://lore.kernel.org/lkml/79375b71-db2e-3e66-346b-254c90d91=
5e2@cslab.ece.ntua.gr/T/#u

>
> I took a look at this today, but I haven't quite come up with a solution.
>
> I thought it might be as easy as changing userfaultfd_release() to set re=
leased
> *after* taking the lock. But no such luck, the ordering is what it is to =
deal
> with another subtle case:
>
>
>         WRITE_ONCE(ctx->released, true);
>
>         if (!mmget_not_zero(mm))
>                 goto wakeup;
>
>         /*
>          * Flush page faults out of all CPUs. NOTE: all page faults
>          * must be retried without returning VM_FAULT_SIGBUS if
>          * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
>          * changes while handle_userfault released the mmap_lock. So
>          * it's critical that released is set to true (above), before
>          * taking the mmap_lock for writing.
>          */
>         mmap_write_lock(mm);
>
> I think perhaps the right thing to do is to have handle_userfault() relea=
se
> mmap_lock when it returns VM_FAULT_NOPAGE, and to have GUP deal with that
> appropriately? But, some investigation is required to be sure that's okay=
 to do
> in the other non-GUP ways we can end up in handle_userfault().
