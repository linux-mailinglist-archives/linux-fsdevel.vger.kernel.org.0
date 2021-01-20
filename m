Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FAF2FCC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 09:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbhATIBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 03:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbhATH7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:59:45 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 23:59:05 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id n187so1500544vke.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raG85U5m6BVpkFn9tnlYSwbmBuD+wqMz8bt05EHQnpE=;
        b=COBq+q3DyHX/wjdBbdPiY06GVMPcsbaUsOQZTyJ7qWCOT9Qwlsa14PlxON1EmmP3dn
         ZyLBJZlg9mscFGi0pxRYe1PkgnxzZ7cc4PGSDkCygYvQXkYEPB+iqlRQKVsFYRij4TSP
         0se7PqcCswNtOkSxGRxAGUJHRKavvDfakuICQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raG85U5m6BVpkFn9tnlYSwbmBuD+wqMz8bt05EHQnpE=;
        b=OKyfTNT5YqHUXBRTNHYsDNdhTMb23gyAcshF+Q06v6c3sgISgpktm0oVEgGZLMVdPU
         Mh0t3kmoelvfSezpm9ZHCSahL2XIEvHbee0jWRbAPp+jI2nonvcf5eycNn5aHc4YTGGC
         tYQad+x1N1oIHdG7nnmM/i+DKB/QW68l8/AyF00FBRgLZTWAz62cbwsXnJL4+Ou+rhSZ
         vay1QazdjHF4xm65xrU1crL09r5t5z0vrTkq6EeNiYvps6IGlzHzLmJn5DZYVkGyIN3d
         NWx/IR/O3Fm7Z6jNlEAJFqGkeJMpcrB4DLqYXucJ/6FREWYPkMhKAzGZ+LuOYJNHF7RK
         rYwQ==
X-Gm-Message-State: AOAM533aGS9hsuHN9dxTadxgu9OSngnROvFe9mNddYvt2ZvvtrAjbCZx
        wBzvORGP2VTYNMOzDIuirMOjbLbbAbhQ8rUQ/4ruHg==
X-Google-Smtp-Source: ABdhPJxTrW09RNX/58RsaWlPlSBaSO57A7eNZ40/KxN4vYPs/WQG40kBkXd8dat0tMmqg4Q+Tp0YtsfcCmv0wTVCO0Q=
X-Received: by 2002:a1f:410c:: with SMTP id o12mr5782747vka.19.1611129544253;
 Tue, 19 Jan 2021 23:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-3-mszeredi@redhat.com>
 <8735yw8k7a.fsf@x220.int.ebiederm.org>
In-Reply-To: <8735yw8k7a.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:58:53 +0100
Message-ID: <CAJfpegt=qKzyu76b_vNF5_Be2-1dovZ6t06=haVgtC8sq1qsbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > If a capability is stored on disk in v2 format cap_inode_getsecurity() will
> > currently return in v2 format unconditionally.
> >
> > This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
> > and so the same conversions performed on it.
> >
> > If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
> > that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
> > user namespace in case of v2) cannot be mapped in the current user
> > namespace.
>
> This looks like a good cleanup.
>
> I do wonder how well this works with stacking.  In particular
> ovl_xattr_set appears to call vfs_getxattr without overriding the creds.
> What the purpose of that is I haven't quite figured out.  It looks like
> it is just a probe to see if an xattr is present so maybe it is ok.

Yeah, it's checking in the removexattr case whether copy-up is needed
or not (i.e. if trying to remove a non-existent xattr, then no need to
copy up).

But for consistency it should also be wrapped in override creds.
Adding fix to this series.

I'll also audit for any remaining omissions.  One known and documented
case is vfs_ioctl(FS_IOC_{[SG]ETFLAGS,FS[SG]ETXATTR}), but that
shouldn't be affected by user namespaces.

Thanks,
Miklos
