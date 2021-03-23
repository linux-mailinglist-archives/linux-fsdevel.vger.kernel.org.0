Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF059345716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 06:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWFFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWFEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:04:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E5C061574;
        Mon, 22 Mar 2021 22:04:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f16so24002413ljm.1;
        Mon, 22 Mar 2021 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFi4t0LwY0/K7P1KzIFPQAnrQ32/ev3JJFzV7tX7RKk=;
        b=SMFDbPc0pk3vToOaNc6sXwfhvd1OwvXso6Z74eSubasphj185X6E7FYll5EeTQBU89
         VxRpqCzu5wWAUKeAYemf0D8N9LZBXG+PzcmgVJNGv75dhHvjn/CZKo/fUCNf77lOjlm+
         Kn36yzqSVey+L+LqEMAzMlNLZDspYBjRzcH5LFuXfYzVDiEde7iVohCTA437G5ntNRYz
         OH8L4wBUrCR3VIE0VAFtTGyNECZOzEB9jwPOQ5So5p1kVoGB9DUcCPQ+pxaatPAAIB3M
         RG+eS13Z3RhjEDDffJ6r+Vmsu5yK5NzZT+uKh7Gqo6YxCYKTvm0HiBBGvmj7yiTSvXp8
         dqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFi4t0LwY0/K7P1KzIFPQAnrQ32/ev3JJFzV7tX7RKk=;
        b=R0MJAoN3T7aS100QK5+hlowh76pS3r30B0/IoGiJfRp2ACw4ABBG1LBZbWwV5vPn3Z
         0ks8WEtGIDLiNdSzUkiSjSOWwYyLWKKE0jIpJXbW4pbwh3q9xxdUNBkjKL6HJmzz1eWv
         2sxYD9zfdmiLbOaIucN9oQ0kkM8Xy8qnTy+eoFis8G4ZeZnT5g3ryTHCKW8gZxC4TQG+
         cZtL6QpxW+6bZd5LTWgvzI86EUbbJWaFRi3Xb4uhRlHP/tZqpF7ErUhtImbcH7j0nn/+
         ooKHsmn+WgawaT2/iMVJmncm80d1b5GpHGM1vXJPqptd0XbyI7HBaGuhxiFC9fuiZuMu
         gX3g==
X-Gm-Message-State: AOAM530wSziPTUe9sLdTyCuNE9hcV83hQBA92oYQ8xdkOIQt9l3cqNZC
        c2RM53hFREcVbY5gTX4xOtcUShbrVC8QeWS1qsVSO4U0aL0DtQ==
X-Google-Smtp-Source: ABdhPJywpQh2eLBXniSg8yoBz0GpvCTWcxpxz+8wSJBCgMgMm31oTW2hJrxWfbkRs30lyz9cAL0vXn1cKlRpSFi20mM=
X-Received: by 2002:a2e:98c5:: with SMTP id s5mr1823738ljj.218.1616475885492;
 Mon, 22 Mar 2021 22:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk> <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com> <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
In-Reply-To: <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 Mar 2021 00:04:34 -0500
Message-ID: <CAH2r5mucWfotrdXvVvvUG-GEOhB=zGAhuPXSzAyw7X=EZDDzYg@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

reran with the updated patch 7 and it failed (although I didn't have
time to dig much into it today) - see

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/534

but it seems to run ok without patch 7 (just the first six patches)

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/535

On Sun, Mar 21, 2021 at 9:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Mar 21, 2021 at 09:19:53PM -0500, Steve French wrote:
> > automated tests failed so will need to dig in a little more and see
> > what is going on
> >
> > http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/533
>
> <looks>
>
> Oh, bugger...  I think I see a braino that might be responsible for that;
> whether it's all that's going on or not, that's an obvious bug.  Incremental
> for that one would be
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 3febf667d119..ed16f75ac0fa 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -132,7 +132,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
>         }
>         if (dfsplen) {
>                 s -= dfsplen;
> -               memcpy(page, tcon->treeName, dfsplen);
> +               memcpy(s, tcon->treeName, dfsplen);
>                 if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
>                         int i;
>                         for (i = 0; i < dfsplen; i++) {
>
>
> Folded and force-pushed (same branch).  My apologies...



-- 
Thanks,

Steve
