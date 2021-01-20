Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2C2FCC22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 08:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbhATHyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 02:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbhATHyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:54:17 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49315C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id g5so7567299uak.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=Ylwu8MaIfcMtXeRHHcdwBLnRoutC82UYXqkJIBtOivUEMmhWi5MIahULll+FlWnkT7
         JmPX49Txh2CBicmCu1r/uHDoOgGt43Pt6egifpvlG0N9WkQ4sd9dWwhT2XqzPCrYxuFJ
         lvaRyu3cL5u3PMTRSekUykObI3rpbo85ziBNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNdd7I2hNKAtcfKQGi3GUg+MhbxssvCuRmdUQZa83G4=;
        b=h8D/JKWU8cOrK2s7q2DZF4lRbd0EeaYVlIXzYCW4izQZzjgHQvIJ0wuRXrNO6zkRtr
         Hhuj8ENrS8e0HJ0tgwqGUanq4MYHY8eegdU1uRSZtpVvk4Du4bADoeqF9e3nR2dxLBy+
         7vwypG7/hNPMzHIebm/jCQ51Z52dge+OzoC/01fWGs6qAYpVRaZW0pfJM/Y8ZgkfVxy0
         A8SlwGCsVm0IhtxlHC5Iu75XyLYqQUXJgVXExj+9KE3cACTSjegk0KZKZo5oR32vq9Aq
         e3msibkuRaTarj3uTdMhaEz5DJ00hl3OpD5PAJwXzyk/DjC9SCZM59cA7K8fbT9pYZAI
         xmiw==
X-Gm-Message-State: AOAM533xvrumQwwTn1q0Na5sUYyok4fOKI7SRQiXT6sy/8CQb23a6EKE
        noP4KpcNOhk1zodFnclpeFi4P6Y0Bzl4ckvYdAIEpg==
X-Google-Smtp-Source: ABdhPJwRciGoD7gQP+crKeuujj3hoGxybSoXTk18gDmGI7WKaAUZHP/lExz5OVrqMvYJynhTLUACKyEZrrtu5fA93GI=
X-Received: by 2002:ab0:7296:: with SMTP id w22mr5234322uao.13.1611129158535;
 Tue, 19 Jan 2021 23:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <87a6t4ab7h.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6t4ab7h.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 08:52:27 +0100
Message-ID: <CAJfpegvy4u9cC7SXWqteg54q-96fH3SqqfEybcQtAMxsewAGYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:11 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > filesystems (overlayfs and ecryptfs) into account.
> >
> > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Restore old the behavior for ecryptfs that existed before the overlayfs
> > fix.  This does not fix ecryptfs's handling of complex user namespace
> > setups, but it does make sure existing setups don't regress.
>
> Today vfs_setxattr handles handles a delegated_inode and breaking
> leases.  Code that is enabled with CONFIG_FILE_LOCKING.  So unless
> I am missing something this introduces a different regression into
> ecryptfs.

This is in line with all the other cases of ecryptfs passing NULL as
delegated inode.

I'll defer this to the maintainer of ecryptfs.

Thanks,
Miklos
