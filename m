Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972591709A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 21:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBZU3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 15:29:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46919 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgBZU3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:29:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id g96so677427otb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBBYCrKEWuOTMe5EyAwkmAIoT9VVH7fpRYrxe98vHCY=;
        b=uVGxei6e9yF0ykQTCRbpF1Xcix7hidQzKjxKmA1TAaLMeWBjYprbRURWAhfm37DnMO
         ALgX0i/omp1eS4k0RzspH50ykrH6+tYuInb+/v3+dsQydB2Gf1JHLwkVAh7PVr7+/vRd
         FEXucDxG2gKpfW36N9FsDf3SO19ksbFgC8vKl0aQmSTLblf+uGgXkO2fWfA4XxFM+8Js
         jMnrrdCbNQqqzS+mSb6pWZJeJ7i2esnsfJ3vaxuZQhlQ6v6KWz6UIlXWOgBKqvTBvuUx
         ppCNzmE84DNL1pPvauf2ZbbPd7pYXUAe4jXhVazh2kQtXxxw/ibvY1NOsCYPKL926wLL
         APqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBBYCrKEWuOTMe5EyAwkmAIoT9VVH7fpRYrxe98vHCY=;
        b=TGyRAlZAuVvvJ0busbg8qEPuEI8Eo/ixshTJ9Tk+8zGkG4A4L/HLZ5o1kyzjRjmRbc
         ilQhEPWFqxig8Vb3AX5tPRgz+Rz2lgE0u8snvsOI+mmEh18J1cDbdgL4lAzj8hhOHOmr
         2gfXlljg8oq3hMmFN+GH6xKz28yRVFqXjDURVuoaKcOjuphhQIvyTnlsvaWykpqoSNnS
         f4FeMIgwQPCU1hKAlMNCLAABMOUVVh6krHsZsFIo/CCZiaCQ7sq8ORATnD6SNJZTcsTc
         NEn9cLpmg3v2jtyM6eo8w6rfqFXjxJxe9JnLCrYbr7PH8wAaCtMtTsWRcEZvY5QD9ehL
         9/Og==
X-Gm-Message-State: APjAAAWvgDJLKFh3A8+WX17wCZadI/MQ7NKo4igDxZ4eR/ydezdgKx+x
        ihAuFPndSb/uRolZ37Qr64oh+tz0V0Sgu1hDT9/rPQ==
X-Google-Smtp-Source: APXvYqy7E7A1017OqCy2OgReSsVvINF1u2X33Ne5TrenikJqc56r0qDxjZlM9E+pAKGCyqxj9LTAbiG86jPOqxjX13k=
X-Received: by 2002:a05:6830:1219:: with SMTP id r25mr502917otp.180.1582748984487;
 Wed, 26 Feb 2020 12:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <20200224160215.4136-6-mic@digikod.net>
In-Reply-To: <20200224160215.4136-6-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Feb 2020 21:29:18 +0100
Message-ID: <CAG48ez36SMrPPgsj0omcVukRLwOzBzqWOQjuGCmmmrmsGiNukw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 05/10] fs,landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> +static inline u32 get_mem_access(unsigned long prot, bool private)
> +{
> +       u32 access =3D LANDLOCK_ACCESS_FS_MAP;
> +
> +       /* Private mapping do not write to files. */
> +       if (!private && (prot & PROT_WRITE))
> +               access |=3D LANDLOCK_ACCESS_FS_WRITE;
> +       if (prot & PROT_READ)
> +               access |=3D LANDLOCK_ACCESS_FS_READ;
> +       if (prot & PROT_EXEC)
> +               access |=3D LANDLOCK_ACCESS_FS_EXECUTE;
> +       return access;
> +}

When I do the following, is landlock going to detect that the mmap()
is a read access, or is it incorrectly going to think that it's
neither read nor write?

$ cat write-only.c
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
int main(void) {
  int fd =3D open("/etc/passwd", O_RDONLY);
  char *ptr =3D mmap(NULL, 0x1000, PROT_WRITE, MAP_PRIVATE, fd, 0);
  printf("'%.*s'\n", 4, ptr);
}
$ gcc -o write-only write-only.c -Wall
$ ./write-only
'root'
$
