Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D321DC130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgETVQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 17:16:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40169 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgETVQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 17:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590009409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66Hol5qyCUFMxPkUsApvxi2EbBWIVzL0cKnQXWEPmBk=;
        b=M706xbrCDKav3vmcVTiClJS21YEAkJlL8m56NZxUbHjuOrWlNwmlii85+hzEJDqLglSvLT
        cZ4A4ZWQsBwCJqUMTkua8yIWkAtl4w3CBeXAv/tYx43+ts9SnK5NFYu08KCE0unoUZPWyK
        eIEbx8VjTBzjqaCW3L0D1GIcwNWFYgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-SbZPDIEGM3GaELLT19_jZw-1; Wed, 20 May 2020 17:16:45 -0400
X-MC-Unique: SbZPDIEGM3GaELLT19_jZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2281A0BD9;
        Wed, 20 May 2020 21:16:41 +0000 (UTC)
Received: from mail (ovpn-112-106.rdu2.redhat.com [10.10.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B0870879;
        Wed, 20 May 2020 21:16:35 +0000 (UTC)
Date:   Wed, 20 May 2020 17:16:34 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200520211634.GL26186@redhat.com>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
 <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com>
 <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com>
 <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 01:17:20PM -0700, Lokesh Gidra wrote:
> Adding the Android kernel team in the discussion.

Unless I'm mistaken that you can already enforce bit 1 of the second
parameter of the userfaultfd syscall to be set with seccomp-bpf, this
would be more a question to the Android userland team.

The question would be: does it ever happen that a seccomp filter isn't
already applied to unprivileged software running without
SYS_CAP_PTRACE capability?

If answer is "no" the behavior of the new sysctl in patch 2/2 (in
subject) should be enforceable with minor changes to the BPF
assembly. Otherwise it'd require more changes.

Thanks!
Andrea

