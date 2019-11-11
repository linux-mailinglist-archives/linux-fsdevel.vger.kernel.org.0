Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D03F71ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKK3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:29:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37623 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKKK3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:29:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so10706244qkf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neDYQCtvWG6GFLAme/V0Z/I/G6+bUaaHqT/zW9Z6Xws=;
        b=qhhB8Kljn7x47tZP6LMxBFrevO8A3qPIsX/IrEO+xjXdyoG+d/WmadVZ+WqSylArCp
         2dQfJJlBgrQlZ+0C8iAqUaLeauPQ6hUP/8wgBuK1pcBMgHcrL8LdFLEgxX+qfyVVMPMR
         WSYWJ635h2fYRFdYCwHOEovyGAXrsVSV+wqprNu4J8Ss01G+/+9TBSRu+4nMYQks84Ve
         CJLfa4RzkN5ldNZbCtI71AyPy/yAK7B7B2eVmnYrdUMP0v+Uwo3ULhLABMIYbgsgSBOJ
         siVOaCwwalZJdRrzLp+fdnqALBBftwzZwTR78ZPhY2UHHiHoboajfuvkzaSmPzbe7S24
         t6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neDYQCtvWG6GFLAme/V0Z/I/G6+bUaaHqT/zW9Z6Xws=;
        b=G2LJGOKC6DlkFqytJyECs1ydjSdg4ckE22G5dZeBzAuJoWcoxZPKbK96cb2gdbRgEl
         N0bp4mCJqXEEQIt3F6WGHUDe+lpX+mNNy7p07MjHojswp5gSZCuZ17mOdajF9/BKwGMY
         CU/2+x011sSfwg0jtuFRZpvoDvpLJYB7imTXuRQ4Nj3rQp49+vSugZis1CvhhqH81Hm3
         YGzjSONSNa8x/0xYfMm7VZ+zjrlJJ33vncJ4cdBX9ObXpdCkp1sPkbPjW83EstnqvsG1
         VtzQW43b7CMSmhASsBvpHFTHpuk9A/qH1aNT7WiVce8KMdSETJvMCzrkuz6yTjEq9aCw
         T3TQ==
X-Gm-Message-State: APjAAAVU3Xb0V5pHy3xbDGG8axj0AA0qkAv2FB3Q4P98/417ilo+/d42
        /YKa/7pRQsL6EaHmV/WRRqfkhd9cTxJJiVRMleVtpg==
X-Google-Smtp-Source: APXvYqy/nyfp+GQeHSfInpIwAhjuAclF3Inv8QGDz8ZXi4t0RJsu/giKvtvOR4wCf+5u0xuFp9+OI5w+cUsLuXatlJk=
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr5660664qkk.250.1573468140848;
 Mon, 11 Nov 2019 02:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20191031084944.GA21077@redhat.com>
In-Reply-To: <20191031084944.GA21077@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Nov 2019 11:28:49 +0100
Message-ID: <CACT4Y+Y6CSG7fzOV7BTx3JQ8SKGy8iPyUggGUUv8A0JRhpkU7g@mail.gmail.com>
Subject: Re: syzkaller for uffd-wp
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 9:49 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hi Dmitry,
>
> would it be possible to grill the uffd-wp patchset with syzkaller?
> It'd be nice if we can detect bugs before it gets merged.
>
> Peter posted it upstream, but we can provide a kernel git tree to
> pull. To fuzzy you likely need to add the new UFFD_WP feature flag and
> registration options to the fuzzer.
>
> Thanks,
> Andrea

+syzkaller, linux-fsdevel

[getting through backlog after OSS/ELC/LSS]

Hi Andrea,

I won't have time for this in the near future unfortunately.
But if you (or anybody on the lists)  are interested in providing
better testing for uffd, we have docs on how to extend syzkaller:
https://github.com/google/syzkaller/blob/master/docs/syscall_descriptions.md#describing-new-system-calls
You may also look at the past changes adding new syscall descriptions
and we have help provided on the syzkaller@ mailing list.
Generally, the core syzkaller team (<1 person overall) can't become
experts and describe thousands of subsystems in a dozen of OSes.
