Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63F268C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfEVRBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 13:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfEVRBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 13:01:34 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0870521855
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558544493;
        bh=DJgR/FpliS0Me3x1HOUMcXaB5qbJaIcK3y6mo6dtkdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsjcP/wmE2u37Efmd4kzw0sTZUcCVtwCP/zoIhkXmWefB513vNebZpabZCGppCTiw
         RAFkYaPZ8SUZF9kRQN3hH3a2OlrIW/+IvVmrvCN62iSKBZgDjCgez0MJ6iWGroFRH8
         IUJYfZ6SjKFupXceNRLuApBIuJeoaNJ4ZM88wQNw=
Received: by mail-wm1-f46.google.com with SMTP id n25so2964067wmk.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 10:01:32 -0700 (PDT)
X-Gm-Message-State: APjAAAU8EXYrjQSOwwX67mCF4j9jMngWlPLgmMqxg6xF1wwwFtvIIQvn
        omR6yrtCNV6xZ+z8iv2UQmhc/NTjKMNgSfxXaxsMMw==
X-Google-Smtp-Source: APXvYqzBx9G4+AB46uxctV97Fq8poIC7M64gsm10cbrSvVHNC4Tj4IpsQAKqofxPCwTs/+O9VRRtW3pzfwXutACQh6A=
X-Received: by 2002:a7b:c084:: with SMTP id r4mr7926856wmh.14.1558544489730;
 Wed, 22 May 2019 10:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190520133305.11925-1-cyphar@cyphar.com> <20190520133305.11925-2-cyphar@cyphar.com>
In-Reply-To: <20190520133305.11925-2-cyphar@cyphar.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 22 May 2019 10:01:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVCwe49q5mu=f6jTYNSgosQSjjY5chukMPo6eZtQGqo5g@mail.gmail.com>
Message-ID: <CALCETrVCwe49q5mu=f6jTYNSgosQSjjY5chukMPo6eZtQGqo5g@mail.gmail.com>
Subject: Re: [PATCH RFC v8 01/10] namei: obey trailing magic-link DAC permissions
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 6:34 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> One final exception is given, which is that non-O_PATH file descriptors
> are given re-open rights equivalent to the permissions available at
> open-time. This allows for O_RDONLY file descriptors to be re-opened
> O_RDWR as long as the user had MAY_WRITE access at the time of opening
> the O_RDONLY descriptor. This is necessary to avoid breaking userspace
> (some of the kernel's own selftests depended on this "feature").

Can you clarify this exception a bit?  I'd like to make sure it's not
such a huge exception that it invalidates the whole point of the
patch.  If you open a file for execute, by actually exec()ing it or by
using something like the proposed O_MAYEXEC, and you have
inode_permission to write, do you still end up with FMODE_PATH_WRITE?
The code looks like it does, and this seems like it might be a
mistake.  Is there any way for user code to read out these new file
mode bits?

What are actual examples of uses for this exception?  Breaking
selftests is not, in and of itself, a huge problem.
