Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A515B204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBLUlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 15:41:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40808 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLUlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:41:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so3994964edx.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=IgiKGasrvpx5KEqTjK3uSOaiUPZJr6oQaxEeiUKRSC7Mzut+kfrtuMYf7JfgJYo2j9
         r6YHIpl0Oomh/U1TMzjQtQYQDvEFopln06zrn/G9JdYxAN1cr+G4MM7V+yIgIdgHmkT5
         mB2IAKAHrGr3Dq04+09yh6iga9CCs4Dv6Lzfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=S3SWiXy+C956kwWy0oeBgNdxARLjEF1FK1MPUkaq8ke3fMrCIgIOAu645tidwMLDOn
         ElvTheOKuCWzLb1BvaPb8tUzc/u5mLYTad15Y5gkQxu3TUYlURt6IoSKOk0k7EtKdc2/
         yqUupa8hTRIqBIBRTnh2/QHwCejN/U0Esbs8DX9N3V5R5XugEh5Lkzi8jJjik3/ydLJV
         weivc6qwhh6BBQKiIZyFesYKtpndtYKI0TqRzAYUXnDlsmA/2Gyb1iy9Agid4197WrNR
         bw+sgi4tnqjP/26qNK8BS5rl8XbtpA10/RUpVY9hyYxX+tcCOd6f/sRxYMpgbk1Y/zQe
         oWmA==
X-Gm-Message-State: APjAAAXx8iLF2Ii0McizdRehzfA4Il6aaxruAzRW0s4lm77R2fHsy/ZP
        VG1L1rfrRtkuADEh96aYFarzz/zwXps=
X-Google-Smtp-Source: APXvYqy38cBRA794sy0TnDMhBCdE///rn0jhybG9PH5gF0oarritqSqDBor4wTf27TATJgdL/AUdyQ==
X-Received: by 2002:a17:906:3ce2:: with SMTP id d2mr12961508ejh.292.1581540109299;
        Wed, 12 Feb 2020 12:41:49 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id x6sm19906edr.60.2020.02.12.12.41.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:41:49 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id y11so4037245wrt.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 12:41:48 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9321452ljj.265.1581539720898;
 Wed, 12 Feb 2020 12:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212200335.GO23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to prevent racing with fs shutdown while you are doing the second part?

I was thinking that only the proc_flush_task() code would do this.

And that holds a ref to the vfsmount through upid->ns.

So I wasn't suggesting doing this in general - just splitting up the
implementation of d_invalidate() so that proc_flush_task_mnt() could
delay the complex part to after having traversed the RCU-protected
list.

But hey - I missed this part of the problem originally, so maybe I'm
just missing something else this time. Wouldn't be the first time.

               Linus
