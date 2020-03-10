Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7B18098A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCJUry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 16:47:54 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38890 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJUry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:47:54 -0400
Received: by mail-pj1-f66.google.com with SMTP id a16so943417pju.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DUcwxxFRcgJR1d4ydhPOJt5zpra6K7hoDMr6GJuC66g=;
        b=fMgZFq3zdtsmjgrmZ83y+dSJSkDsZ1RxXFLnaUXLAWftyCsRbpnOPIZELEJvQYB2uH
         DCaJNkF/BmiZuR2IY7of7B5eWU3CYM1Bp+RKbcTdNqEPhwk3h5BL4rLBDUiAP20fc1Ps
         c+5viBYTEXQxtAUajXiZWTdBthiDog7IGOpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DUcwxxFRcgJR1d4ydhPOJt5zpra6K7hoDMr6GJuC66g=;
        b=Qq01fRkkLmrryBi+VV+5reMkkr3v0kKXuIqRcIAj2u5ES+Ak1KSeR9YH2UB0kgrnBO
         fqLWQ+n8UrPFH7HiwqsTFI6YmVcxvis9UY1Rds6zcOmZ4kH8b/cdF1NctIdO1ylkxhng
         hHdJ3CHKQmVS3CFDCnSHKVDwMMZwvV/xqVUcXcu788lWT7ROATbZjsT1k/wl5QQM2g+e
         bQDvVKVCJwijP/PC6wkCh1LID433RU74iYE14Z2Nfebd+AmCCkdeJ18i+BLrqOHYaGqG
         qmbZHZw4Q9R5VFzQvQr4nlBy9Jx07rJTisKTYSwSEObACRgsjg9zyVz/Kn51woweRn1a
         Fp6A==
X-Gm-Message-State: ANhLgQ0bbRdtz+v0XeLv63Q0FkL3aEdLLyE2OcuixZV69TDXPwLOTswU
        SgDqRaXn5SSv9ryxmaeGEYiA8A==
X-Google-Smtp-Source: ADFU+vudklcF8vh1bAtfnAiwP2o2XGlvb6JQXVwHa2R6IlMHlYTM2ZG1kz9TwCHN7BvEtMrMXaoTKg==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11mr10776957plb.245.1583873273478;
        Tue, 10 Mar 2020 13:47:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6sm16907149pfb.172.2020.03.10.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:47:52 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:47:51 -0700
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
Subject: Re: [PATCH v2 4/5] exec: Move exec_mmap right after de_thread in
 flush_old_exec
Message-ID: <202003101344.8777D43A44@keescook>
References: <87v9nlii0b.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170609D44967E044FD1BE40E4E40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87a74xi4kz.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51705AA3009B4986BB6EF92FE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87r1y8dqqz.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517053AED7DC89F7C0704B7DE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB51703B44170EAB4626C9B2CAE4E20@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87tv32cxmf.fsf_-_@x220.int.ebiederm.org>
 <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <875zfe5xzb.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zfe5xzb.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 08, 2020 at 04:38:00PM -0500, Eric W. Biederman wrote:
> Futher this consolidates all of the possible indefinite waits for
> userspace together at the top of flush_old_exec.  The possible wait
> for a ptracer on PTRACE_EVENT_EXIT, the possible wait for a page fault
> to be resolved in clear_child_tid, and the possible wait for a page
> fault in exit_robust_list.

I forgot to mention, just as a point of clarity, there are lots of
other page faults possible, but they're _before_ flush_old_exec()
(i.e. all the copy_strings() calls). Is it worth clarifying this to
"before or at the top of flush_old_exec()" or do you mean something
else? (And as always: perhaps expand flush_old_exec()'s comment to
describe the newly intended state.)

-- 
Kees Cook
