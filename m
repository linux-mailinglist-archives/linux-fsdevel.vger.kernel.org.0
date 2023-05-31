Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B9718BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjEaVVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEaVU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 17:20:59 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60246129
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 14:20:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-56896c77434so937427b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685568057; x=1688160057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoZ0QonL7GpvkzVGqoB0gV8pXc0xldAiiia3lsdp4Jw=;
        b=bV4CEIauWya7OBEvEJZ8O8BySgJRaCgtsOwV6TTfZUxO5baLK/jxr8/dThczBffNj1
         g1gilTPiZQifPjEoO+IN/kk9i9ttCodVZ8VAZQtdacEO/I73YOsQw1P3KDX0Q7NmzVl5
         fWejNhHweIU62YqvrPCRW4133WGgKrli3JmhqeqvcL8piPMRhv5kXzRVBqPq9qLq/qnk
         DYPmRx+V/9Ra/NmqVGiyPe/eqdSrEtP3EsfkjQln612yGRhW29oLVVtt+CMN+/kCRLon
         kft2gp88qfJMj0vw5N1jDI9nRjKoMbdmze8lCQUhFECmOfrFLAjt2nlsqiJvMXmcx5wf
         sMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568057; x=1688160057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoZ0QonL7GpvkzVGqoB0gV8pXc0xldAiiia3lsdp4Jw=;
        b=OW0ES5AF0O0bQUdmXGSsWkiMe0ytpsRCfAVuNBnoXlohne37/SmDn3SQdXuq7jr85R
         r3KABgE1RDaFK8BnyEByp6ajpQDBIMsYmu6hKkGBMnFHX5cmo3b9ViQYjBHRTWMGghKj
         HB1bo62OhXG4ZRj9DlrYCpQGG40P6NWwA+Q8NG6L/sfpY5sBUdj9OLoLo0IRYRqHADKj
         xn52/I+Ma0ejOChwjjD/D7WLGjE1vZCczIHOg1+/Ac90isHkPePqAFl9xljlyj/Ecinm
         6mgRTpBbfIKZ0M4loCBp6RBHGsU1rVP576pKBdYSyJ5m7LYoxgDtoHDKj5DsCNKkKpFc
         lAzQ==
X-Gm-Message-State: AC+VfDz+p6U4e2tC6YT9lFYMhrXxi+t6M+LN6OZ7X7T/bWdrN+j0A71C
        WxIKrD2ZeuO5obVIrVeJKuyvnwNWI4xRlPTy6tCO
X-Google-Smtp-Source: ACHHUZ7xDxpY+qZ+kHStKpfyGCUmSZFIrAOaNegLCNmyLU6OfWoFLFoTJ5KIVySJiQxq5mqHTIQOq8i1T+EuU78aXoc=
X-Received: by 2002:a81:d246:0:b0:561:9051:d2d3 with SMTP id
 m6-20020a81d246000000b005619051d2d3mr6586195ywl.11.1685568057462; Wed, 31 May
 2023 14:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230530232914.3689712-1-mcgrof@kernel.org> <20230530232914.3689712-3-mcgrof@kernel.org>
In-Reply-To: <20230530232914.3689712-3-mcgrof@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 May 2023 17:20:46 -0400
Message-ID: <CAHC9VhRA_XkkiZpg=d1RiME+VUYe7bsuV6pOpsseDRWfwV+q9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sysctl: move security keys sysctl registration to its
 own file
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, dhowells@redhat.com,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        j.granados@samsung.com, brauner@kernel.org, ebiederm@xmission.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 7:29=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> The security keys sysctls are already declared on its own file,
> just move the sysctl registration to its own file to help avoid
> merge conflicts on sysctls.c, and help with clearing up sysctl.c
> further.
>
> This creates a small penalty of 23 bytes:
>
> ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
> Function                                     old     new   delta
> init_security_keys_sysctls                     -      33     +33
> __pfx_init_security_keys_sysctls               -      16     +16
> sysctl_init_bases                             85      59     -26
> Total: Before=3D21256937, After=3D21256960, chg +0.00%
>
> But soon we'll be saving tons of bytes anyway, as we modify the
> sysctl registrations to use ARRAY_SIZE and so we get rid of all the
> empty array elements so let's just clean this up now.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/key.h    | 3 ---
>  kernel/sysctl.c        | 4 ----
>  security/keys/sysctl.c | 7 +++++++
>  3 files changed, 7 insertions(+), 7 deletions(-)

Ultimately I'll leave the ACK to David or Jarkko, but this looks
reasonable to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
