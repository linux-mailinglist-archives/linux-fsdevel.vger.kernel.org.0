Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B501C0F09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgEAHxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgEAHxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 03:53:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC1C035494
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 00:53:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so6922128ejx.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBA3kWcV1EmEL7fNmuvvfUm9MgrKtq0ZwPzgOB7jxY0=;
        b=HWYJKgbn6Yzr2UMYpS/j+sOBW/wz7i6JHJhql1zCyxplMmvrDqqtazn85w9QlQuog8
         pFS4cnMQM4Rz8eCEIJ32ylWpAzojc+G8FnlfjB92YMFgM2sGqGPJriIrUPqYIcbu6jqU
         N4jO0T+MGT4F4gXwWiQwczONmyi0W1rscLr+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBA3kWcV1EmEL7fNmuvvfUm9MgrKtq0ZwPzgOB7jxY0=;
        b=k8/6NKsDli5RlH1bX6VFiggE2wpHV3Coxo8iIPiTeL9ijCRRhUdzUmvypmeL506cMf
         8B4VtE/z/HJQfxWeKaVEykIbQ+CGCgcya41yCyhFSk994eP4MuC4FgNciyfuu8AMQk89
         UeMVZd4TmROXLyrV0CLBQKgJexXq8FyrTHXNlihlTVyxtDw4citrwesTfmhXTwXqf5fj
         pdtey7xqOL1KP2nL/t0fiFGzpy0kZEF3nhyVXTxjF4fP57DKkfzvs32zKut1hK9VZ4ES
         LA+dsekl+uoshwfRZvRh9EmeTMrMGcnRmJKplI0Fdsui72CbqfftGMqF+1NPuohFbgsw
         FqCg==
X-Gm-Message-State: AGi0PuarY7J9Vv2Eo6Gi7kvBN7PLI+rBUDbVs1Hr6T1TfkQtFM2GBduG
        GL9J69hkPtlAJUT8KBBFJnn9XNQMa//mLnHr3PL2jw==
X-Google-Smtp-Source: APiQypIq2tQ4WheHgdnSbQZQ6TK69W68gxYzTTiQfJwYiHl5BUL+C//RNxupGrpp/Y1uE3sl8aYe0YfAiEwQQNaqpDk=
X-Received: by 2002:a17:906:340a:: with SMTP id c10mr2104707ejb.218.1588319610486;
 Fri, 01 May 2020 00:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
In-Reply-To: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 1 May 2020 09:53:19 +0200
Message-ID: <CAJfpegtWEMd_bCeULG13PACqPq5G5HbwKjMOnCoXyFQViXE0yQ@mail.gmail.com>
Subject: Re: fuse doesn't use security_inode_init_security?
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 8:55 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Hello,
>
> I noticed that the fuse module doesn't currently call
> security_inode_init_security and I was wondering if there is a
> specific reason for that.  I found a patch from 2013[1] that would
> change fuse so that it would call that function but it doesn't appear
> that the patch was merged.
>
> For background: I currently have a virtio-fs server with a guest VM
> that wants to use selinux.  I was able to enable selinux support
> without much issue by adding
>
>     fs_use_xattr virtiofs u:object_r:labeledfs:s0;
>
> to the selinux policy in the guest.  This works for the most part
> except that `setfscreatecon` doesn't appear to work.  From what I can
> tell, this ends up writing to `/proc/[pid]/attr/fscreate` and the
> attributes actually get set via the `inode_init_security` lsm hook in
> selinux.  However, since fuse doesn't call
> `security_inode_init_security` the hook never runs so the
> file/directory doesn't have the right attributes.
>
> Is it safe to just call `security_inode_init_security` whenever fuse
> creates a new inode?  How does this affect non-virtiofs fuse servers?

Not sure,  Adding more Cc's.

I know there's a deadlock scenario with getxattr called on root inode
before mount returns, which causes a deadlock unless mount is run in
the background.  Current libfuse doesn't handle this, but I think some
fuse fs work around this by not using libfuse, or at least have some
special setup code (glusterfs? ceph-fuse? not sure...).  I also don't
know whether the ->inode_init_security hook is related to this or not.


Thanks,
Miklos
