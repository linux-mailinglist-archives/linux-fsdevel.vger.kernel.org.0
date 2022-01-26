Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68FB49C0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 02:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiAZBWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 20:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbiAZBWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643160133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GZ3Dedx2+qAhxuYqUMOz36xfZAcdnnXf1bRw8z3k2mE=;
        b=U1RW/NRDF1h+4pEsrCihjjeRojCj8lp7LZCWzB5iGmOugElLrt0HAYANV6bSsMM9iTkVrg
        mRL5ZrbyFDNUMWmLjhUcS1Ll8tG70hCx/jrCxjUQbt/uPZ3Uwodde4cSzPjKw1qPGnRceZ
        VnL/crHNXk2wq4O/VmaUGKhJtNSrE5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-_ehUbgIuM2uPWicB98SjDQ-1; Tue, 25 Jan 2022 20:22:10 -0500
X-MC-Unique: _ehUbgIuM2uPWicB98SjDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25B62F25;
        Wed, 26 Jan 2022 01:22:08 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F66B1882;
        Wed, 26 Jan 2022 01:22:07 +0000 (UTC)
Date:   Wed, 26 Jan 2022 09:22:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2] proc/vmcore: fix possible deadlock on concurrent mmap
 and read
Message-ID: <20220126012204.GA2086@MiWiFi-R3L-srv>
References: <20220119193417.100385-1-david@redhat.com>
 <20220125170900.472fdb649312e77a4a60d9da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125170900.472fdb649312e77a4a60d9da@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/25/22 at 05:09pm, Andrew Morton wrote:
> On Wed, 19 Jan 2022 20:34:17 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > Lockdep noticed that there is chance for a deadlock if we have
> > concurrent mmap, concurrent read, and the addition/removal of a
> > callback.
> > 
> > As nicely explained by Boqun:
> > 
> > "
> > Lockdep warned about the above sequences because rw_semaphore is a fair
> > read-write lock, and the following can cause a deadlock:
> > 
> > 	TASK 1			TASK 2		TASK 3
> > 	======			======		======
> > 	down_write(mmap_lock);
> > 				down_read(vmcore_cb_rwsem)
> > 						down_write(vmcore_cb_rwsem); // blocked
> > 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
> > 				down_read(mmap_lock); // blocked
> 
> I'm wondering about cc:stable.  It's hard to believe that this is
> likely to be observed in real life.  But the ongoing reports of lockdep
> splats will be irritating.

This is reported by Redhat CKI on Fedora ARK kernel. That kernel enables
many debug feature by default, that's why lockdep detected that. Usually
kdump kernel add 'nr_cpus=1' by default in our distros, so it won't
hurt. It may cause lock issue in theory, so should be false positive
warning. Since it has Fixes tag, cc:stable should be OK.

