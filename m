Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38688297A61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Oct 2020 04:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759167AbgJXCsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 22:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758990AbgJXCsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603507729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFNtBnPmuVnuHPViwRUDEpYcIjv16AoqlrRsofzXiPA=;
        b=IziHGzrv0CAHlg/BomPJM+ma9LDWP4QBafGD9pTx0L6oIKnz8SzSf3gUl9JjVeyMY3IIu2
        rLRSUWR2qZFvSY6u1OxRJdbFkuRNyDTai6EzXTzPmH57WxMwq8Cc1DcCVqWTHnZznT/UOP
        8AQAfg7UoRQUt/n5eDo83uyHfNYllLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-SQfhWY5qMAupfAoaYfqP1Q-1; Fri, 23 Oct 2020 22:48:45 -0400
X-MC-Unique: SQfhWY5qMAupfAoaYfqP1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 994405F9E9;
        Sat, 24 Oct 2020 02:48:41 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A246210013D0;
        Sat, 24 Oct 2020 02:48:36 +0000 (UTC)
Date:   Fri, 23 Oct 2020 22:48:35 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/2] Add user-mode only option to
 unprivileged_userfaultfd sysctl knob
Message-ID: <20201024024835.GC19707@redhat.com>
References: <20201011062456.4065576-1-lokeshgidra@google.com>
 <20201011062456.4065576-3-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011062456.4065576-3-lokeshgidra@google.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone,

On Sat, Oct 10, 2020 at 11:24:56PM -0700, Lokesh Gidra wrote:
> With this change, when the knob is set to 0, it allows unprivileged
> users to call userfaultfd, like when it is set to 1, but with the
> restriction that page faults from only user-mode can be handled.
> In this mode, an unprivileged user (without SYS_CAP_PTRACE capability)
> must pass UFFD_USER_MODE_ONLY to userfaultd or the API will fail with
> EPERM.
> 
> This enables administrators to reduce the likelihood that
> an attacker with access to userfaultfd can delay faulting kernel
> code to widen timing windows for other exploits.
> 
> The default value of this knob is changed to 0. This is required for
> correct functioning of pipe mutex. However, this will fail postcopy
> live migration, which will be unnoticeable to the VM guests. To avoid
> this, set 'vm.userfault = 1' in /sys/sysctl.conf. For more details,
> refer to Andrea's reply [1].
> 
> [1] https://lore.kernel.org/lkml/20200904033438.GI9411@redhat.com/
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Nobody commented so it seems everyone is on board with this change to
synchronize the kernel default with the post-boot Android default.

The email in the link above was pretty long, so the below would be a
summary that could be added to the commit header:

==

The main reason this change is desirable as in the short term is that
the Android userland will behave as with the sysctl set to zero. So
without this commit, any Linux binary using userfaultfd to manage its
memory would behave differently if run within the Android userland.

==

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>


BTW, this is still a minor nitpick, but a printk_once of the 1/2 could
be added before the return -EPERM too, that's actually what I meant
when I suggested to add a printk_once :), however the printk_once you
added can turn out to be useful too for devs converting code to use
bounce buffers, so it's fine too, just it could go under DEBUG_VM and
to be ratelimited (similarly to the "FAULT_FLAG_ALLOW_RETRY missing
%x\n" printk).

Thanks,
Andrea

