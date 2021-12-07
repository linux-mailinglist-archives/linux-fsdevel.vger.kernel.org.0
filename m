Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BF46BC35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhLGNR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhLGNRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:17:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C485C061574;
        Tue,  7 Dec 2021 05:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=84jAjImm1LdpYEYMEGOBbQQ2NxM0geZn/FzzqcLRQy8=; b=M2xRRXJvNlXJfe8qZrdyMLBzOS
        FLGM2i+fugcC0rfReaH6dZLyQNP4CBKyOiO6mjNcOADAzdLOXWEHsk2ezbhmopvfEM+mPviAHIzqQ
        ivD2mzd33bEQGlqKdnPyBjQnqvnhkMmqwYCyq8ppYW5wHZ7yfSorf53JuNlu4Ii5Pr749+c72mkhj
        u57elMEBohRj+50CuPWojdT43WPhclNjB8Cljpu5EZJJYQVWq1K0kyG7aBBakZAXYhCU7CoFcxRGh
        K0Tn37z9mUCD4cRVCUkoHxP5QbB8H1qUjU8FdW3o18+J/9+WS37M4EEMSkVC9EMZqYGeKKoaB/sPu
        my57USug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muaI2-007Mhh-NU; Tue, 07 Dec 2021 13:13:51 +0000
Date:   Tue, 7 Dec 2021 13:13:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jack@suse.cz, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix lockdep warning from taking sb_writers whilst
 holding mmap_lock
Message-ID: <Ya9eDiFCE2fO7K/S@casper.infradead.org>
References: <163887597541.1596626.2668163316598972956.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163887597541.1596626.2668163316598972956.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:19:35AM +0000, David Howells wrote:
> Taking sb_writers whilst holding mmap_lock isn't allowed and will result in
> a lockdep warning like that below.  The problem comes from cachefiles
> needing to take the sb_writers lock in order to do a write to the cache,
> but being asked to do this by netfslib called from readpage, readahead or
> write_begin[1].

Isn't it taking sb_writers _on a different filesystem_?  So there's not
a real deadlock here, just a need to tell lockdep that this is a
different subclass of lock?
