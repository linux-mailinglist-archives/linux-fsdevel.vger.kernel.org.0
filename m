Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3800B1B22F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDUJgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbgDUJgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:36:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EBC061A41
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 02:36:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so9469509edv.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvQfXYa7OuQRubb/pe1NKM1WDL58usuh9DmpVkQdaXA=;
        b=HtF4fSRlF5BL+Rp3ZBD/jsftUDAEZ06/Ef78AW4EYdxqpH7Hah/bo4k3KdHLLfhnKV
         IEIvmq5e4KsYJROS71rXPIlzo30jtTPwQVycMuz6yOoM9rsfOhj9WEUsw145a6aK1Jvk
         iqaIZtdWYGbUI5NUZXZENdkHOilOUU6jzikwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvQfXYa7OuQRubb/pe1NKM1WDL58usuh9DmpVkQdaXA=;
        b=eh4IRG+w1TSfjEFPQwzG190GCXOxaDvL5DSQxVwKtKHCNwKm/8aX5XwZkgmBLcsvQJ
         BL+um00Xz4UUehbbVwp9Rpe61JvycADd1+1OxbpzyhIqj9q0MEaw7GGN+qElxXgxTV5L
         AsaknOFx3lDNLcaWOM9UIEAe+uAsm6dhTAF4iHp7nMOZEA9uAhlxU/q/ZdO+9oGZnlUU
         yNVgfiN5sXUucsDLs2t1BX23wZ8bUvSNBSs65iYh3wTyl5eaJgxxXKo+tYm4LnDqF2lR
         vTpHnv6xwX6nYJBJVZGOe6MBTW7+op6Wt79nNiG/wp/JOEU3qissb3QIVPWTppmjlBdv
         TozQ==
X-Gm-Message-State: AGi0Pub1ir+/7yJInlxX+3cadslcrcL/qQ4CbhwpstzE6GovgHjgb4oX
        b3+HnBH4MxAo/czt56gtus+vdMa4ntTTwhMtugq5Qw==
X-Google-Smtp-Source: APiQypItc+QOKYRaC4wg++htE0Gc6LcZ8EgCgsTAG5CToiNPUvzzsuYG1iJV8Eg2YL+hR21Hk80UqqtI7Wbcu/Jn0S4=
X-Received: by 2002:a05:6402:3121:: with SMTP id dd1mr12660866edb.168.1587461810483;
 Tue, 21 Apr 2020 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz>
In-Reply-To: <158642098777.5635.10501704178160375549.stgit@buzz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Apr 2020 11:36:39 +0200
Message-ID: <CAJfpegvrRxYsN5L1GSWTCZgmBR4kf00YeD9JNx=fEd4fDKuOtg@mail.gmail.com>
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:29 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Stacked filesystems like overlayfs has no own writeback, but they have to
> forward syncfs() requests to backend for keeping data integrity.
>
> During global sync() each overlayfs instance calls method ->sync_fs()
> for backend although it itself is in global list of superblocks too.
> As a result one syscall sync() could write one superblock several times
> and send multiple disk barriers.
>
> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
>
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks, applied.

Miklos
