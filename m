Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5772984F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFILmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFILmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:42:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBCD30EE;
        Fri,  9 Jun 2023 04:42:36 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565a63087e9so15470877b3.2;
        Fri, 09 Jun 2023 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686310956; x=1688902956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VWbml9vm0j/K8rXjZ4MZh9cHa+yubilvKrJHb5AUTg=;
        b=UHK+k8jgzaAlhB8mpPGiLo+0MaFqcVc9TQbS7Vo+X24EphFbjrw4riQzsR3328x3bk
         Hn0SJX8G9jjyhu4CWh4lmiVyUrChGUTLJA4q3og19Jh3mMpsrh8m/HqwyJUPH8h0PUTX
         nH0xEh7yA0gqPOnf9i/NhckLgzbJfZnKVL86i1zvqcPg8J7IehYsqGp8sJ21ZkOhpBxI
         Qcm7oPhRh4/KnWCLbHFDXVUT2aljqm/NCVmT6hARsvDGxphbUs5SSwachXaJuFrgYtfQ
         W7+idAqBa0UmDCUSItVke2urrb64cF+qTFZcMQSI0pH2S6JQ/qH41eZXZUOYWY2oVTnd
         PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310956; x=1688902956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VWbml9vm0j/K8rXjZ4MZh9cHa+yubilvKrJHb5AUTg=;
        b=UKkPdRLlDuIauc5+FZm8bsN+hDbVskweqLAm5t9j5AsONAs9lBf4fKrqrNfKIhBrA6
         2iejoaeSqw/7GEJzUgTTdqymUMrnB6+9kJ5EHWnfC2YiNI1DGo5y1p4rIbizItrHJ/m5
         QOVI4U1EeOYi0/zmdbCSRVEA3npX2KtkFKV4DPL72x6cUDuHoM4EhPquAqT6lj/mLZxA
         Bc6+cp+2BOmv+IXW7umdaQYFRyXoPhM0MSxe2tA1G4piqb8xNSk7aSxHMSJt3tHDDP66
         DULljHifNqdTS85u9ChRNGiV3PMCSKyZ6mKan2+4roxmx8CY/kL2JTxqtMOpwGUOJI/M
         2Y1Q==
X-Gm-Message-State: AC+VfDxx0SRaSir/rj74qM2H2gpKc5+o+6QB+uK8nnXT4OOH3S3qGjud
        eYTmz5N5CBcrf6MjWAgbgGtcOoNAmiZFW7PyIFVvK1NxVR8=
X-Google-Smtp-Source: ACHHUZ6tW53ZXngN93wz9oF7Mpp7POxJTk4IPWWf2sz62WA+74iAWCcJqjZs01/mel0Vpqpu2mXBiHLHt62fjMZRR/g=
X-Received: by 2002:a0d:eb10:0:b0:565:5cf3:d941 with SMTP id
 u16-20020a0deb10000000b005655cf3d941mr942574ywe.5.1686310955849; Fri, 09 Jun
 2023 04:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
In-Reply-To: <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 13:42:24 +0200
Message-ID: <CANiq72kZSKz+Y4Zh2GKxqEx2NpGLPYzU5VAntqJDOhMfzxGO_A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     Christian Brauner <brauner@kernel.org>
Cc:     Ariel Miculas <amiculas@cisco.com>, linux-fsdevel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 1:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Any wrappers and code for core fs should be maintained as part of fs.
> Rust shouldn't become a way to avoid our reviews once you have a few
> wrappers added somewhere.

Definitely and, to be clear, we are strict about it (e.g.
https://rust-for-linux.com/contributing#the-rust-subsystem).

In fact, we appreciate maintainers that are willing to take patches
through their tree and take ownership of code too (e.g. KUnit and DRM
are doing so already).

I imagine Ariel sent the RFC as a way to announce his work early on,
especially given how some patches were split, the lack of commit
messages and tags, etc.

In other cases, we have reviewed patches privately first to iron out
this sort of thing, but I wasn't aware of this series coming (I knew
Ariel was working on puzzlefs and that he wanted to submit it
eventually, but not that an RFC was ready).

Also, some of the code here comes from the `rust` branch, but some of
it may not be ready yet for upstreaming.

Cheers,
Miguel
