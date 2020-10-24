Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD16A297A4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Oct 2020 04:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756423AbgJXCI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 22:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbgJXCI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603505336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TyNEe+vv4iRyq+oo7Hz26v9tT88fTf/9Q+gM91AeZ/U=;
        b=K9NjELY4Jg9fRZ/nt+5+O6j4cE4SR0SujLs1WSr7mOrIo9BUtJ47LTEkn3WcGuNzA2oGRn
        ow1iC74cE1WIz8rGSQ7wEW7rFPGPRrdSFDe4Q02rWAs9KYlgEABfALWQ4lSOeCoETk/2OU
        TKcLETSVr3IBhsxWBqEnrbZX9001Lo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-HZ6NTf5aP22FAfLxYL8_oA-1; Fri, 23 Oct 2020 22:08:52 -0400
X-MC-Unique: HZ6NTf5aP22FAfLxYL8_oA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488B1805EFC;
        Sat, 24 Oct 2020 02:08:48 +0000 (UTC)
Received: from mail (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 918E95D9D5;
        Sat, 24 Oct 2020 02:08:44 +0000 (UTC)
Date:   Fri, 23 Oct 2020 22:08:43 -0400
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v5 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20201024020843.GB19707@redhat.com>
References: <20201011062456.4065576-1-lokeshgidra@google.com>
 <20201011062456.4065576-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011062456.4065576-2-lokeshgidra@google.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 10, 2020 at 11:24:55PM -0700, Lokesh Gidra wrote:
> userfaultfd handles page faults from both user and kernel code.
> Add a new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes
> the resulting userfaultfd object refuse to handle faults from kernel
> mode, treating these faults as if SIGBUS were always raised, causing
> the kernel code to fail with EFAULT.
> 
> A future patch adds a knob allowing administrators to give some
> processes the ability to create userfaultfd file objects only if they
> pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> will exploit userfaultfd's ability to delay kernel page faults to open
> timing windows for future exploits.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

