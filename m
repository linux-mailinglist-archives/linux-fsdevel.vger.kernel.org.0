Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22BF49883B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbiAXSX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 13:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbiAXSX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:23:29 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C9EC06173B;
        Mon, 24 Jan 2022 10:23:29 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id m6so54039925ybc.9;
        Mon, 24 Jan 2022 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tZG6vWxuDQCoLS5EQblxGJTd+bt3ysX5fuLcy2Y6SM=;
        b=QSphLw8QGXwRadu8SEtVzrz+uAPxzgUXxBCTYvd8u+EzKvCZYAMBZbvQ0GzUT9lkYb
         0TFOXxY45WV0PSZ3ddQrjy3SQUZPtqa7YHPvmJPNMydM6+eoBo5UbK6ID0lAxUXi4Yh6
         cDwBWqa26f1/ChJ5kBk1ndFaK8Ev13pXKn1EwTz+x03VEnqw4GLyjew/7KqFj6mIXLfZ
         NGFBY2KQodm75wHc9O8diYkzmXH7Do2XpcpuaIeHir/nIE1PdxyZHTbCtnoH2k9mJDZ3
         EvbnqZajKgkg8BShwDfIVg2MLmiSTM2Rdoa4IpRk+xk2SGoT/Y+5JrWnhq7lX2NjL3Dk
         xdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tZG6vWxuDQCoLS5EQblxGJTd+bt3ysX5fuLcy2Y6SM=;
        b=e+TMnMSUPe61uPJIfuE1DM4zwkKxWXskJc6cTTIfFgrnnPkOrJDo8lMvbg4rhJqA9X
         9tceQ3LwFTHWCaByGYLc1zCrGsFODYzILQggTTsilXi4jMsnUa1kcOEhSxru/kYxfyP5
         R9pQVb4xhUCTn+MX2sApR2zQp6olat3kT1uaLIzF27vUneC/urrUnEMFTucKO8IrYrFH
         6XjvyqAEXy2NwOf8RMcPkvmg+c7B/O/5wqQPRBMg5iEpkXWcBstgNwtcFhKWyxOL0xC6
         Y1Fmwj8SUa/ujCDG+C8aTilvIherHWmeG5Wcr8S4WeIYG18XDGqqQdwbohDYbecPeimf
         6iuQ==
X-Gm-Message-State: AOAM533YmhywzoTR+xm0eb/HyvfHjsGPTaBu0SM8VZSq3D4RRh2jv1X+
        Bu4IygxGPDIFqXzglJVaxR5I1nijDFCASMA1fGiJ+UFM7wQ=
X-Google-Smtp-Source: ABdhPJzklKeY0cEKgb7H/Bf3xipTsWELKbetuLEAQtTx3cw76yIbNXFjOpOEq9A85WGOlo0z4286U2sC9tfe/L373hM=
X-Received: by 2002:a25:42d7:: with SMTP id p206mr24456154yba.182.1643048608104;
 Mon, 24 Jan 2022 10:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20220124003342.1457437-1-ztong0001@gmail.com> <20220124104012.nblfd6b5on4kojgi@wittgenstein>
In-Reply-To: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 24 Jan 2022 10:23:17 -0800
Message-ID: <CAA5qM4A_pArXkyLvcXbJwp0xFSnDZJ+Md82ME1AOrt+5v-zaDg@mail.gmail.com>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 2:40 AM Christian Brauner <brauner@kernel.org> wrote:
> The fix itself is obviously needed.
>
> However, afaict the previous patch introduced another bug and this patch
> right here doesn't fix it either.
>
> Namely, if you set CONFIG_SYSCTL=n and CONFIG_BINFMT_MISC={y,m}, then
> register_sysctl_mount_point() will return NULL causing modprobe
> binfmt_misc to fail. However, before 3ba442d5331f ("fs: move binfmt_misc
> sysctl to its own file") loading binfmt_misc would've succeeded even if
> fs/binfmt_misc wasn't created in kernel/sysctl.c. Afaict, that goes for
> both CONFIG_SYSCTL={y,n} since even in the CONFIG_SYSCTL=y case the
> kernel would've moved on if creating the sysctl header would've failed.
> And that makes sense since binfmt_misc is mountable wherever, not just
> at fs/binfmt_misc.
>
> All that indicates that the correct fix here would be to simply:
>
> binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
>
> without checking for an error. That should fully restore the old
> behavior.
>

Thanks! That makes sense.
I modified the patch according to your comment, added another fix for
the return type issue and sent a v2.
Thanks again.
- Tong
