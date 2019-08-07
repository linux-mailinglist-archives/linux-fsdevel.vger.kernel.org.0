Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B785437
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfHGUBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 16:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbfHGUBY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:01:24 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7B42229C;
        Wed,  7 Aug 2019 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565208083;
        bh=4Y+9zhlp+p8rLuzDnvz16xcsN6RE4cU24OrOaFTWccE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zQWA7F1KoIQRCIl1yVyS0BiJUwsrwYEryJKxMHNxcX6ONB8eZ93zxVmeDQ44zmmr7
         94PMczCgAY0emIRaZfVAe7SJ/fxtD+5a/tCkNgG8bpb7LPhysLSpabBlToJlvBBdXz
         27kDL9DLZKISnabXM7rW3N8cStMFHWeqYCj5Xb7E=
Date:   Wed, 7 Aug 2019 13:01:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v4 1/5] mm/page_idle: Add per-pid idle page tracking
 using virtual indexing
Message-Id: <20190807130122.f148548c05ec07e7b716457e@linux-foundation.org>
In-Reply-To: <20190807100013.GC169551@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
        <20190806151921.edec128271caccb5214fc1bd@linux-foundation.org>
        <20190807100013.GC169551@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 7 Aug 2019 06:00:13 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:

> > > 8 files changed, 376 insertions(+), 45 deletions(-)
> > 
> > Quite a lot of new code unconditionally added to major architectures. 
> > Are we confident that everyone will want this feature?
> 
> I did not follow, could you clarify more? All of this diff stat is not to
> architecture code:


My point is that the patchset adds a lot of new code with no way in
which users can opt out.  Almost everyone gets a fatter kernel - how
many of those users will actually benefit from it?

If "not many" then shouldn't we be making it Kconfigurable?

Are there userspace tools which present this info to users or which
provide monitoring of some form?  Do major distros ship those tools? 
Do people use them?  etcetera.

