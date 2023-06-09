Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B772A31B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjFITak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjFITaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:30:39 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6A358C;
        Fri,  9 Jun 2023 12:30:36 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43b54597d3cso608359137.2;
        Fri, 09 Jun 2023 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686339036; x=1688931036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOeVmKuvyPHaMkc8uESbcUdSUrNt0hAA6JKro/+RBHo=;
        b=FLalOxKws+D9XF+oPsCIzAz9QZxslO/7EP876glsKwejASvW9cQPWq9xKSg4MxVeQ0
         n2kZtoU6Zhc51661iFL/vV+c9VpDZL+La3p07cug3PTGbUhLLg8opMn4RWXYuXAq8oBD
         iPfpuJ0OjbuY4IR4rZIJ5qm0GsPJc1SGG7IsyhZ3tg+wZkIKkG8Q8djJc/c8dqgH6i86
         uDvJUQbdTeXMQk/IVZ7nVwEsOdmp0b5x1A8gmeXv7Ik4pFp7cdBfYidb3GNrMPANdSDr
         sryxORdP+oYe6NEtk/HJVvQn1XpSDX6Ryt/gTlL6Psf2l+MSO6pXMis9kWeDFQdp8ZXG
         +gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686339036; x=1688931036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOeVmKuvyPHaMkc8uESbcUdSUrNt0hAA6JKro/+RBHo=;
        b=Zjvq6P7+IOw3ix2jxfwkpcaHZ4iFoqyhS9W+f+aqgHRP5CsDa5WUazWIkGyv2H9qTS
         xoB8NRGHUMQjcsDrlpXPMs7bHQ4GKM6HJwFtzt5aIKkbsDUyhFGC7yNQQrn0IeeCegrU
         LIZN3UTXgSvf/jgYqd+TAvn4hJpRrKvHmBvs9BmtwGhSv7vrjgF71qsnVVW77+ZyRxh6
         HkrNs4Fui0Jrbte3Gq1TiW2FKi8QGUW1nykdXeCyU2kcT5g/+E2l49RgPQoPgS1/L6e8
         bbbxkrEw+Dezq/jyx4rkmYnDxkgxENfraQ5Owi+H+mnSuzCYKFsAVQaaswaI+UfmSiW7
         gKZw==
X-Gm-Message-State: AC+VfDzXu2iKrYWoQeerRFWMQxfPwfvS7MKQiGkH0BhIFsaYxLlYxH+p
        mc9Jh94naySuspe4Lcvz7E0T8HR+qiwfwuGKWLM=
X-Google-Smtp-Source: ACHHUZ6y4sDZ+eCfx66xQhxaFjIdOcjLrhVZuy/cq9gmMouoY/sr9ckj12r6szTMe7nnMfGdDq7mJ6J3rEjd4FZlEAE=
X-Received: by 2002:a67:fd4d:0:b0:43b:32a7:a0b6 with SMTP id
 g13-20020a67fd4d000000b0043b32a7a0b6mr1276087vsr.16.1686339035826; Fri, 09
 Jun 2023 12:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 22:30:24 +0300
Message-ID: <CAOQ4uxhw9PLz7JaLaZR4hidZUEod2fkiVWvkmbZQoFaiMNe2XQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ovl: port to new mount api & updated layer parsing
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 6:42=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Hey everyone,
>
> This ports overlayfs to the new mount api and modifies layer parsing to
> allow for additive layer specification via fsconfig().
>
> I'm not sure if I need to rebase the changes on top of Amir's lazy
> lookup. If so, please let me know!

Yes, please.

I look at the conflicts and they don't look so bad.
I think only need to figure out numlowerdata during parsing
which should be pretty easy and then the entire wacky loop
to figure out numlowerdata in ovl_get_lowerstack() can be nuked.
all the rest stays the same.

Thanks,
Amir.
