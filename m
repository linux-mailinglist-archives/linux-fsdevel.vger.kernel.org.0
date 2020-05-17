Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170A1D6B39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEQQ6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEQQ6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 12:58:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C6C061A0C;
        Sun, 17 May 2020 09:58:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so7974983iog.13;
        Sun, 17 May 2020 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=altgAbX5kmqCSE/VnAq/k8WHhDiX7o4bWc9rHmz5wOo=;
        b=oFbmdXoJ7IKhXz/adk3cWUH02iVLEMbiWPS3oYco9rZQ/I26wyRUSLKaWf24g+fmgM
         0qhq7O2DIUF1Fhk8wDI097fDcjaHjfzIJizUGrWQRXS+4abA7AQP8BA28vbJbHrmAfGO
         XkSjfV7rVvsmFLSl+e1PMrZMYMEMTFax3aKxcsTGkJU3tfeUC9DAiPBYb2u7Xg2ypZuk
         MA4Zpt1cTWT2dI3a0VrQkrK2A89zZAnM1zaEULhYiV+MmlR4kaxnEiXDq+hnDNnofPzl
         F44myrooS17gGNTOq4w+l9JADdcPZhQ1Cb2mWVBLxhNG8vgwHIJ3wPBunDL4edBhA2KH
         4DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=altgAbX5kmqCSE/VnAq/k8WHhDiX7o4bWc9rHmz5wOo=;
        b=divN88/HSl9WAnLfCx3T21WIpG4yE4j9iEgDrmn3Bb6H/npHxwpP6gRN8n9dQ3HYF+
         NL6CdI3F/04dUF4cxg5x2O/njhPsX9HRLhFMCqsePT3cMSLFZr9Ggun1j+oC1spw6eih
         RnG6gvYBp0aWkfx1yonuqQtDs+f5w2jQ4nv1OO+NbC/1NclCmZRLT6uOn7r/HenEXuZO
         NajDGSPiBhgQnWq0geZGfrUSluT9n/d/grJ0hUieN3MkpQGFIm2k2G9Smgdjv2shDz/6
         9y6KKSgKdQ1g5GN0KU+vytGkRsIEa0X4NpYWzoNEBCHsYo0Mmz9rZ94JtZF0iFIpHwwU
         JTdQ==
X-Gm-Message-State: AOAM531cPSXvOBg6z4l8udqgzLJ8+1Z0u40nXFE3cIE1iGP3AqgALZpF
        T2cAwi9Qad7JrGXTst0DFqpzQqz+4R1DDBVpBmQ=
X-Google-Smtp-Source: ABdhPJzkS2SOWSJO0UWnl+/Jz2U+Hdy/n0LyIdKaxfJBksl9CvPkj0zWT07DTkmBhBac8VhhDnTeZ/MnxGHqCUexLPc=
X-Received: by 2002:a02:a58b:: with SMTP id b11mr11916189jam.56.1589734682438;
 Sun, 17 May 2020 09:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200505153156.925111-1-mic@digikod.net> <20200505153156.925111-3-mic@digikod.net>
 <202005121407.A339D31A@keescook> <CAP22eLEWW+KjD5rHosZV8vSuBB4YBLh0BQ=4-=kJQt9o=Fx1ig@mail.gmail.com>
 <202005140845.16F1CDC@keescook>
In-Reply-To: <202005140845.16F1CDC@keescook>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Sun, 17 May 2020 19:57:51 +0300
Message-ID: <CAP22eLEy5nc4u6gPHtY56afrvF9oTNBwRwNAc7Le=Y_8V49nqQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] fs: Add a MAY_EXECMOUNT flag to infer the noexec
 mount property
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 6:48 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, May 14, 2020 at 11:14:04AM +0300, Lev R. Oshvang . wrote:
> > New sysctl is indeed required to allow userspace that places scripts
> > or libs under noexec mounts.
>
> But since this is a not-uncommon environment, we must have the sysctl
> otherwise this change would break those systems.
>
 But I proposed sysctl on a line below.

> > fs.mnt_noexec_strict =1 (allow, e) , 1 (deny any file with --x
> > permission), 2 (deny when O_MAYEXEC absent), for any file with ---x
> > permissions)
>
> I don't think we want another mount option -- this is already fully
> expressed with noexec and the system-wide sysctl.
>
> --

The intended use of proposed sysctl is to ebable sysadmin to decide
whar is desired semantics  mount with NO_EXEC option.

fs.mnt_noexec_scope =0 |1|2|3
0  - means old behaviour i.e do nor run executables and scripts (default)
1 - deny any file with --x permissions, i.e executables , script and libs
2 - deny any file when O_MAYEXEC is present.

I think this is enough to handle all use cases and to not break
current sysadmin file mounts setting
I oppose the new O_MAY_EXECMOUNT flag, kernel already has MNT_NO_EXEC,
SB_NOEXEC and SB_I_NOEXEC and I frankly do not understand why so many
variants exist.
Lev
