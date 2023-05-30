Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D8715AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 12:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjE3KCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjE3KCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 06:02:19 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818293;
        Tue, 30 May 2023 03:02:18 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-437d6a60763so3997010137.0;
        Tue, 30 May 2023 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685440937; x=1688032937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT1qkkma+q67NEpQZltMHALdeo6gNC82P8llxmAKdXs=;
        b=Jtg7zTv+Zpqbj6VlkqZw1Tfvfdh3pVBlBAqX+4w/iRHWVN/J6XU3tOn+ch8V92GN3o
         boACNZNERmIYBqpMEcwvMUla5ymSBKbOQDjHXDWBxZyTo3yRvTng2efZLJ4ZI7773SXG
         9csaKLkPzBLta8UlYAQpoyaHf2blN9VH8NpvV24pyDu10jAg6b1+5JOsa0M/vLlEBvhm
         Ggrb9uM4nPLqJQvf9ywv5KeeSpw89NKaNzeqHo13zZVp/CZn9zkO+f2iWoauv7WLMEDT
         PcbHrZM/REz2VbM5loQLfn01olTlBv3owL2CQGMdkT/54uUOonvl6ZZX4L0LSQgP63Rs
         CMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440937; x=1688032937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT1qkkma+q67NEpQZltMHALdeo6gNC82P8llxmAKdXs=;
        b=dEehHGVuynz34pP4u7bgW7ath4bY1Q102APN39GD9tEXZwdm80Ay9keRT7KOgrPRVx
         AQRaCTGQlAUTvn1NFaml047Q6oIIalifuVLzbVlbi9yZ4CVHcYNCz0YCVWCpDkLxj8d+
         WA+1s2ySXaGfpBmF6rxPIISmOEgwSrSIie5qPwgcQrxBTbWSARlftwUMm6CieS1ztgNr
         dp2mGu0MEwcPDJ2KkD0S4cIRb8Li5/EtgkXOWvDAK41n4mQFXgkw0pHN9XCKPD/PQntA
         EXmfbG4J2eeNJyImSOvL+CQ+f8B+rhbx6ewCU+jBZUHpCdN0gxQRocQ4IvlAGBHxHkVn
         vMuA==
X-Gm-Message-State: AC+VfDzdaiuFHqjhAo6WZnPxmzB283NzFNx/r7cv5w0GKged/AL43+9R
        D43b+pU+ihSBs0roe4oqs4m2i5egi72q4q/kzLQ=
X-Google-Smtp-Source: ACHHUZ5fDPOCKtE2m8AyTExCFljbUB2RTgrI+JpgBtUxpcgN+XR2hZYpuloSyzgcBBTL0lPRlT3kBesxIQce+zP2spY=
X-Received: by 2002:a05:6102:2928:b0:434:8540:377 with SMTP id
 cz40-20020a056102292800b0043485400377mr3877154vsb.17.1685440937296; Tue, 30
 May 2023 03:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230530020626.186192-1-zhiyin.chen@intel.com> <20230530-wortbruch-extra-88399a74392e@brauner>
In-Reply-To: <20230530-wortbruch-extra-88399a74392e@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 May 2023 13:02:06 +0300
Message-ID: <CAOQ4uxhAn9JOGioLwqt0W6AvS532B5KOFzanWfPOBEuYHsDPTA@mail.gmail.com>
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
To:     chenzhiyin <zhiyin.chen@intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nanhai.zou@intel.com,
        Christian Brauner <brauner@kernel.org>
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

On Tue, May 30, 2023 at 12:31=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, May 29, 2023 at 10:06:26PM -0400, chenzhiyin wrote:
> > In the syscall test of UnixBench, performance regression occurred
> > due to false sharing.
> >
> > The lock and atomic members, including file::f_lock, file::f_count
> > and file::f_pos_lock are highly contended and frequently updated
> > in the high-concurrency test scenarios. perf c2c indentified one
> > affected read access, file::f_op.
> > To prevent false sharing, the layout of file struct is changed as
> > following
> > (A) f_lock, f_count and f_pos_lock are put together to share the
> > same cache line.
> > (B) The read mostly members, including f_path, f_inode, f_op are
> > put into a separate cache line.
> > (C) f_mode is put together with f_count, since they are used
> > frequently at the same time.
> >
> > The optimization has been validated in the syscall test of
> > UnixBench. performance gain is 30~50%, when the number of parallel
> > jobs is 16.
> >
> > Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> > ---
>
> Sounds interesting, but can we see the actual numbers, please?
> So struct file is marked with __randomize_layout which seems to make
> this whole reordering pointless or at least only useful if the
> structure randomization Kconfig is turned off. Is there any precedence
> to optimizing structures that are marked as randomizable?

Good question!

Also does the impressive improvement is gained only with (A)+(B)+(C)?

(A) and (B) make sense, but something about the claim (C) does not sit righ=
t.
Can you explain this claim?

Putting the read mostly f_mode with frequently updated f_count seems
counter to the goal of your patch.
Aren't f_mode and f_flags just as frequently accessed as f_op?
Shouldn't f_mode belong with the read-mostly members?

What am I missing?

Thanks,
Amir.
