Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3E1809A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 21:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCJUz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 16:55:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34517 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgCJUz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so6862442pgn.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCee8pfoSpfKAyMHOiluaFP5r2d1cxa5sV/2QbU588A=;
        b=HoWjp37PtFeniqj35yD1VTg9ADYkej22MfwMB13TIeFC7foF85mFkueDcopx5DNEc6
         Gnjfy52P9IdsdWJrxkP6VvsqgV7Ue9g2VZYhaEy0A6IxGTIL6JYTjbsqPyWEMiArT+m7
         INOy2/C/ssYCuaWafqLRtBe62wmczU69h1pvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCee8pfoSpfKAyMHOiluaFP5r2d1cxa5sV/2QbU588A=;
        b=ckieaIeXL9FTNC99cpGdjxxzv8HnmU2LSP7SJ4hzQ7PsdgfcAsJSCLeAzHu8XfrYYD
         wFDWWbpxd5DukAMjWWQ9Mvu3sAO0T2KtAb3HqQApjgoahbL/vMYedYk9Rj6q0Ykish6N
         hN3Q6CQhWAsD2hdHWo/og8dIbu9+xxxyrYEdeCvmbYmH7lsXUtft02OAnuiTjojAo7x1
         rF88oVinPULioNYfEN+ShCZkzDr2LgXEIncYXhgdzbu6fGLaWVZjvAboS0GZ4o6Q6e+V
         m0S7Hxkp0LpLQPrcF5A+n26WV3FTDNr7i5m9+9jZbBZkNqwMFOxKtHy3HbCjmhsEY3nM
         pG/g==
X-Gm-Message-State: ANhLgQ0/TN95okozxiq5wREs4E1s93yVwrFCToUG8+fKdxKUzvsoIerl
        eXp63PjF64CVr1kYCkRCAv2vHQ==
X-Google-Smtp-Source: ADFU+vv4dCRRSTIODLKjbWRTG/zSV8gZAQ/i5OlKX+nEWRlVelr9/0GQ269GPVKo38XW0ci648ABSw==
X-Received: by 2002:a63:450b:: with SMTP id s11mr22416425pga.45.1583873756120;
        Tue, 10 Mar 2020 13:55:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w138sm5130844pff.145.2020.03.10.13.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:55:55 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:55:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] exec: Add a exec_update_mutex to replace
 cred_guard_mutex
Message-ID: <202003101352.28BE3BEB4@keescook>
References: <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <87zhcq4jdj.fsf_-_@x220.int.ebiederm.org>
 <AM6PR03MB5170BC58D90BAD80CDEF3F8BE4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <878sk94eay.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517086003BD2C32E199690A3E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y12yc7.fsf@x220.int.ebiederm.org>
 <87k13t2xpd.fsf@x220.int.ebiederm.org>
 <87d09l2x5n.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170F0F9DC18F5EA77C9A857E4FE0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rq12vxu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rq12vxu.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:02:37PM -0500, Eric W. Biederman wrote:
>     exec: Add exec_update_mutex to replace cred_guard_mutex
>     
>     The cred_guard_mutex is problematic as it is held over possibly
>     indefinite waits for userspace.  The possilbe indefinite waits for
>     userspace that I have identified are: The cred_guard_mutex is held in
>     PTRACE_EVENT_EXIT waiting for the tracer.  The cred_guard_mutex is
>     held over "put_user(0, tsk->clear_child_tid)" in exit_mm().  The
>     cred_guard_mutex is held over "get_user(futex_offset, ...")  in
>     exit_robust_list.  The cred_guard_mutex held over copy_strings.

I suspect you're not trying to make a comprehensive list here, but do
you want to mention seccomp too (since it's yet another weird case).

> [...]
>     Holding a mutex over any of those possibly indefinite waits for
>     userspace does not appear necessary.  Add exec_update_mutex that will
>     just cover updating the process during exec where the permissions and
>     the objects pointed to by the task struct may be out of sync.

Should the specific resources be pointed out here? creds, mm, ... ?

But otherwise, yup, looks sane:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
