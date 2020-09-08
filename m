Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509D42617BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgIHRlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbgIHQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB96C061379;
        Tue,  8 Sep 2020 05:50:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so14723553otk.7;
        Tue, 08 Sep 2020 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xtdyDDmFLb1n/bPdUXOwa5UJMDQzkeNGV49EUd3+LOA=;
        b=KqsK1NT52K0nEsZYDrIpWu/nttM49kNDxDkaTEQ41DlAcJMqFgy9wed9oAOhBOhmp9
         JjWIha7WgNUYARkHfU31ZSSrWF9UpyHjc97HwVebb5O26IgiHCFN+l4d/KFWvBWtcZTv
         Vth5VaeiQvFW3eko41wx4jAtxw2/mg/opj2NomPN7bIdTGl/eFfj34xI+YtfoyBJLhO4
         ZYaKesEZJWG9ZzXmK/OlmuV73f6uZZIja67+5/qKm7MUEk2RinVcTzcSZzgUo4ISxXyG
         s1WPksUe7qCIKILuYyO3eGU9gozVTrOuUEkYGUdPmjxsNt2nTuZ5m4OdpixNMvbgJDBA
         7mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xtdyDDmFLb1n/bPdUXOwa5UJMDQzkeNGV49EUd3+LOA=;
        b=lF7EuLUvOI0d50EyfDmByouOzxgf4sq1SjCTHmYfkzISCy6YEWEyBB+KtUlbkR4Pc/
         wYmUwgjQncLYMo273nheXGPfs9qqOnaoE5KZST1BfrIrhybuNJIt52LeBJl7dnzyzejq
         paAlzDICfBebFXs9lEmrNp6u7FrJ4sBvIkZjgnIeyx4DpLPJqciutF60GD54Ar+trhrB
         0VGWGDUV+aPym7jLVv1IYzWQIurGSHAaeG56/wRP0PiVHWyOSUlT9wEHbe3npzTreKgW
         ClJVbz7OXY/6IjDTNm02eyAZ/TKhWeUF53dit4aOKYCNX0fc7iGViR/5JYEZbYJ2ASZh
         qQ5g==
X-Gm-Message-State: AOAM5329Lt9WlVWVERfGbmmuLfj1q4FARf2K45Mj6q59YtmQ9HYW0888
        Z8T/9cZoKGQUMiG8ZR7Nc98Z5AIi+QVFKkij8eY=
X-Google-Smtp-Source: ABdhPJwtfceBKr4ySVSekpTEJOWofhFAdR/HN5Djc/qSNrXRqYaxksUN/th6Slnv/3Rr9epMjUvjruy4l7jgMS6+JTI=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr17851789otb.162.1599569425234;
 Tue, 08 Sep 2020 05:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075956.1069018-1-mic@digikod.net> <20200908075956.1069018-2-mic@digikod.net>
 <d216615b48c093ebe9349a9dab3830b646575391.camel@linux.ibm.com> <75451684-58f3-b946-dca4-4760fa0d7440@digikod.net>
In-Reply-To: <75451684-58f3-b946-dca4-4760fa0d7440@digikod.net>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 08:50:14 -0400
Message-ID: <CAEjxPJ49_BgGX50ZAhHh79Qy3OMN6sssnUHT_2yXqdmgyt==9w@mail.gmail.com>
Subject: Re: [RFC PATCH v8 1/3] fs: Introduce AT_INTERPRETED flag for faccessat2(2)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:43 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
>
> On 08/09/2020 14:28, Mimi Zohar wrote:
> > Hi Mickael,
> >
> > On Tue, 2020-09-08 at 09:59 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> >> +                    mode |=3D MAY_INTERPRETED_EXEC;
> >> +                    /*
> >> +                     * For compatibility reasons, if the system-wide =
policy
> >> +                     * doesn't enforce file permission checks, then
> >> +                     * replaces the execute permission request with a=
 read
> >> +                     * permission request.
> >> +                     */
> >> +                    mode &=3D ~MAY_EXEC;
> >> +                    /* To be executed *by* user space, files must be =
readable. */
> >> +                    mode |=3D MAY_READ;
> >
> > After this change, I'm wondering if it makes sense to add a call to
> > security_file_permission().  IMA doesn't currently define it, but
> > could.
>
> Yes, that's the idea. We could replace the following inode_permission()
> with file_permission(). I'm not sure how this will impact other LSMs thou=
gh.

They are not equivalent at least as far as SELinux is concerned.
security_file_permission() was only to be used to revalidate
read/write permissions previously checked at file open to support
policy changes and file or process label changes.  We'd have to modify
the SELinux hook if we wanted to have it check execute access even if
nothing has changed since open time.
