Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F341D4CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgEOLk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgEOLk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 07:40:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090DC061A0C;
        Fri, 15 May 2020 04:40:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d7so1379809eja.7;
        Fri, 15 May 2020 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vx+rjdJtrqWDo1iVdx81WH5syu+StElM96JO8y30OpU=;
        b=WPgjtmvuU+9RwoLj/n0H1YhScjg1h4Hgu330I4kqOUDcfeSuQOZKl+5ux8rbb0A1+r
         7ELm48Nk8g4Iq8itsNp7nRoCsTlAKAoHnK2ah+xePeZp2pK0stb6n4zW7y9MitNbYdDS
         bNg0TemLo6X1Wgm4LbjMS91beAkfCoPyvVNVG0xkHsjsU38LIBSiNPr88k5yhaJMl2mH
         5eqEVtZV3131W/HDvA1aAfjmoreTAFOE/V6gi/szPbw3TsONPhAJeXwsxwdtqP1sG/pY
         Ej20wI+N6z6ZiALRxth0w2i3BmnjBrdrQ0f5/Jd0EBrHTFEvOrXEbpUpoKxv8TREGGdn
         cagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vx+rjdJtrqWDo1iVdx81WH5syu+StElM96JO8y30OpU=;
        b=HZGYHONT4WO708GtyeZN6eKcpcXCGLpq6LXJk/r5n0iKT14Quw1CzxtpW9ElCZ4/95
         IBS7ZMKrLSPYjFOJPRsAk/M7EAmhe+L8tZdELGkjDLQLFN1w0VoQCnBM+oKFeUAWpV7L
         9YLUqQ4VB8IVq4puPqIXIppH2SPAPTMIlIWNnw7fA4AkQwUBDm2SsnzOBJ4N4IcQoWMI
         CwTisAzrKa3B8c+vv6LYPrBS5t9fkB+r9DU8pZnEnwtkqCUfhA7/Ah340bfHlMQb3lpT
         hdh7+5Dg3Ht6wc8PqxNTMiszU5SkWwlSqTWCYL6rox8ZF4qN6TUe1ujis7dbz+0T8PL+
         rx9Q==
X-Gm-Message-State: AOAM531nfBhkprFPJojQTX+spcT+vp+o+jJJmf5VO7UBQOld7Q56Hbsd
        Dd8u/0sgSIXINyysxgs17Wh0U8H/z5Q/A/phfPA=
X-Google-Smtp-Source: ABdhPJx0AgOk2Zn12eGSfHnaAvM6elutzBoNttSm5PyZ1UJxJxfvsS0M4rtJbN9T/Be3JEHKy9yQwj/NrvyofhO0SFM=
X-Received: by 2002:a17:906:add7:: with SMTP id lb23mr2366474ejb.6.1589542825282;
 Fri, 15 May 2020 04:40:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 15 May 2020 13:40:14 +0200
Message-ID: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
Subject: Setting mount propagation type in new mount API
To:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David, Miklos,

I've been looking at the new mount API (fsopen(), fsconfig(),
fsmount(), move_mount(), etc.) and among the details that remain
mysterious to me is this: how does one set the propagation type
(private/shared/slave/unbindable) of a new mount and change the
propagation type of an existing mount?

I've looked at the kernel source for a bit, and did not see how this
is possible.

The draft manual pages sent out a few months ago provide little clue,
with the only hint being in the draft fsopen(2) page, which says of
fsmount():

       fsmount()  takes the file descriptor returned by fsopen() and cre=E2=
=80=90
       ates a mount object for the filesystem root specified there.   The
       attributes of the mount object are set from the mount_attrs param=E2=
=80=90
       eter.  The attributes specify the propagation and  mount  restric=E2=
=80=90
       tions to be applied to accesses through this mount.

However, that text appears *not* to be true. The 'mount_attrs'
argument of fsmount() does not seem to permit specification of
propagation type, since in the kernel there is this check:

        if (attr_flags & ~(MOUNT_ATTR_RDONLY |
                           MOUNT_ATTR_NOSUID |
                           MOUNT_ATTR_NODEV |
                           MOUNT_ATTR_NOEXEC |
                           MOUNT_ATTR__ATIME |
                           MOUNT_ATTR_NODIRATIME))
                return -EINVAL;

Thanks,

Michael


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
