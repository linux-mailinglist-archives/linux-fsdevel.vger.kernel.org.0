Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBBE3E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfJXVgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:36:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42653 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfJXVgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:36:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so252884ljh.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=G+CKE+0sNMbBuosjchwhgzz8NQwfbV/8kKBYcW1zgIA+wCHZXB0W4xnrddKNkrujly
         nBXQf8TMFFxtwDaqAlubm1WQBu/DIP2jq0ClHTeKxpnxD8j4n3vqHGpl41RLHFrD0jXc
         jfdzDY5G/0JxiPvAj8Pc7cihC14c7Kl2f6hiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=VCyFm/QJKhIqqOl+0YFc9RDoLRv6NrXBnRt9KopvJgWy1SXSvdIDGiYpMdnRxtMaIr
         ccGme07s5sNAuPTZcazuOMkPnh1eZeZ6+XeDSWpM7ufY3okSNLggr/ZXyr7ET21+mn2L
         2r1Tv+9J1TIX2c25iExy8pTSignMGg4cu+gOBHu2K/MFrXH5fYNM+3Jr8ZGIUQ6LH5Q1
         QMTSSZ0ITdz9wAP0YvgyhX1BrfZ1/Y8yZ/K5QXzanpLT7Mn+5wsMJ+weu674B23P1J3i
         r2OqFG2hBxf7i7PoKoY51t3Xfy62v3aqABeyOTo028m0d+UHL5CBC+6PJUvp7eSq0Oav
         JZUQ==
X-Gm-Message-State: APjAAAVH0fClBr0nBQfUrpG4wTVsQHovxLirTI61F9Rioeu6Vd3K+Yve
        zzZdb9iYACbL3mmcvanlmlVnlvQzIq9zbQ==
X-Google-Smtp-Source: APXvYqzu+TxCc6zUa/4NXQTBHOoTeWODgeqe9dOBKezKXg5his7tQ+QyoCgRql6HI4m1VVLKxIikRA==
X-Received: by 2002:a05:651c:237:: with SMTP id z23mr27472438ljn.93.1571953004062;
        Thu, 24 Oct 2019 14:36:44 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t22sm11796379lfg.91.2019.10.24.14.36.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 14:36:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 139so82662ljf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 14:36:43 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3303284ljp.133.1571952607809;
 Thu, 24 Oct 2019 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Oct 2019 17:29:51 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:57 PM David Howells <dhowells@redhat.com> wrote:
>
> pipe: Add fsync() support
>
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.

Can't you just do

    ioctl(fd, FIONREAD, &count);

in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
him, and let's get out of here"

               Linus
