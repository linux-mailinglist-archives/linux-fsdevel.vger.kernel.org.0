Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749F21AF40A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDRTAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:00:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51687 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbgDRTAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587236421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0Gisw9hWUsG7t2w9OL7DQLlQmWjB8dYgMJG70gQDSw=;
        b=a4Ta2E5+yaJoGONQxs8KxGyA7mkdoORM3CBb2+i7P+5DiyiQe28KhgfCDP6IS3PUtOEmUG
        2eMu0lN61ee7KcSmnBi9OAeMTtaEI7SQGUv0jQRs3r4CBF4HC2lSU9UFG0ei2vb38E9g/k
        RrtdrW5qACr9b29KAJVQyuTXFVEt68A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-BYVo8lhcOiee7_7XhfvY5w-1; Sat, 18 Apr 2020 15:00:17 -0400
X-MC-Unique: BYVo8lhcOiee7_7XhfvY5w-1
Received: by mail-qk1-f197.google.com with SMTP id k13so5548030qkg.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0Gisw9hWUsG7t2w9OL7DQLlQmWjB8dYgMJG70gQDSw=;
        b=DQyfzyoj8DsWANDfdXkIXWRiwGbd67yW97vVyo5w59yvJQmVZI2w1Yhw4OiCsT/s7o
         Z2Jsi5n/AAlX8vG/rVFZG5FPGUu1Y8y/5+LWtwcDGXV2gEU+bVhvQAJSmI6iw5OhRV7Y
         H5XghalDGXPBO5dPlX6QlCniXLhDrQXru4uwpbpPw1fWtpZL45AXJGjUnNXpfwheqjY7
         WUy7BU5j+lpmVszA4p+hMEeyOqb3rOr0f6svLNyA1bQDZ246i1PmfV1PvlafyZCKqjE/
         TbCWsKHhlr2G0Lao2X2R6xqXHCeMVSW1zalDU4YZFj/XGLPIfCMbNqPgBCTZ2XjBKE//
         5kCQ==
X-Gm-Message-State: AGi0PuYEiUuxL2xtJdFGnPlVdFGOJlzKy+3odwkLYE86VXAMY1Vt9lq2
        FHXjxshQI9L+5370kdrq0QucTOFQieaFcEQXa8/VCAeYDARUC1241rKZC4j1Z3FPjbVCEnqMp8C
        4ubUmutyyJGjyM0186a4FEL7vENfvCAqgIfO0yTFJjw==
X-Received: by 2002:a37:d0a:: with SMTP id 10mr8976655qkn.288.1587236417119;
        Sat, 18 Apr 2020 12:00:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2nHN5tNsMq4pPm5ciYHRA5VRWl7aSSu5+P9HKsSo/yFjTBtNzBH3IvuFjBQ139wkhhgPpEk79Jxs2c07SmRA=
X-Received: by 2002:a37:d0a:: with SMTP id 10mr8976624qkn.288.1587236416872;
 Sat, 18 Apr 2020 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200416143532.11743-1-mszeredi@redhat.com> <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
In-Reply-To: <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 18 Apr 2020 21:00:05 +0200
Message-ID: <CAOssrKe7RNyReAFLoQGBDm79qMdXEubhP5QhG_+UmGZXgeXBkA@mail.gmail.com>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 8:36 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> Hi Miklos,
>
> > POSIX defines faccessat() as having a fourth "flags" argument, while the
> > linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> > AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
> >
> > Add a new faccessat(2) syscall with the added flags argument and implement
> > both flags.
> >
> > The value of AT_EACCESS is defined in glibc headers to be the same as
> > AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> > with the explanatory comment.
>
> It would be nice if resolv_flags would also be passed in addition to the
> at flags.
> See:https://lore.kernel.org/linux-api/CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com/
>
> We should avoid expecting yet another syscall in near future.

What is the objection against

openat(... O_PATH)
foobarat(fd, AT_EMPTY_PATH, ...)

?

Thanks,
Miklos

