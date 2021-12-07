Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2946BCF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhLGNyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhLGNyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:54:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675FC061574;
        Tue,  7 Dec 2021 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aFv8En/ZUuUzwcf8yZWk1KkdnnIDox4k6wRcsscE4CA=; b=caIUwf1+oqIuwD7WX8dHhC9UTo
        Y4yoywzSlSBcgtevqtNslcnAAKNAKrB3XEENVhXwsT6H4jzZsKi3EACKIDNhADJgm6Ea/4edVX4gi
        gitKf1XwVR6/1nPPS6XOWTdZQimhmZPVpewL8a38thcuEiH6UG58SYqpUZqB9l4CvDrlVGNf2bBGL
        nFa5ckxibtS6fYZmoX2Q4OSEitPQaqxl2jGHDgbiINmcJuLLNhmKfkQDXeueBTJAhrLByfovzu1Pg
        ztDh97cXtlzPOZgkbhVA8JgrWO1jjmNGE2mLKQyJMDHjkI+7Qt4BRiaIBdevwASn2WAKOXSFvsTlb
        Mx/owSRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muasC-007Ofb-3U; Tue, 07 Dec 2021 13:51:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71DE5300237;
        Tue,  7 Dec 2021 14:51:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C17F20239D92; Tue,  7 Dec 2021 14:51:12 +0100 (CET)
Date:   Tue, 7 Dec 2021 14:51:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ingo Molnar <mingo@redhat.com>, quic_stummala@quicinc.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_sayalil@quicinc.com,
        quic_aiquny@quicinc.com, quic_zljing@quicinc.com,
        quic_blong@quicinc.com, quic_richardp@quicinc.com,
        quic_cdevired@quicinc.com,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: Re: [PATCH V1] fuse: give wakeup hints to the scheduler
Message-ID: <Ya9m0ME1pom49b+D@hirez.programming.kicks-ass.net>
References: <1638780405-38026-1-git-send-email-quic_pragalla@quicinc.com>
 <CAJfpegvDfc9JUo6VASRyYXzj1=j3t6oU9W3QGWO08vhfWHf-UA@mail.gmail.com>
 <Ya8ycLODlcvLx4xB@hirez.programming.kicks-ass.net>
 <CAJfpegsVg2K0CvrPvXGSu=Jz_R3VZZOy49Jw51rThQUJ1_9e6g@mail.gmail.com>
 <Ya86coKm4RuQDmVS@hirez.programming.kicks-ass.net>
 <CAJfpegumZ1RQLBCtbrOiOAT9ygDtDThpySwb8yCpWGBu1fRQmw@mail.gmail.com>
 <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9ljdrOkhBhhnJX@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:45:49PM +0100, Peter Zijlstra wrote:

> > What would be much nicer, is to look at all the threads on the waitq
> > and pick one that previously ran on the current CPU if there's one.
> > Could this be implemented?
> 
> It would violate the FIFO semantics of _exclusive.

That said, look at
kernel/locking/percpu-rwsem.c:percpu_rwsem_wake_function() for how to do
really terrible things with waitqueues, possibly including what you
suggest.
