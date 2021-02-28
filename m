Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0B327010
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 03:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhB1CZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 21:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1CZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:25:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C4C06174A;
        Sat, 27 Feb 2021 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QxjWbUC+jHKiwdfCQzRFephzuELq+zDjx4CMd2Cj2Uc=; b=cgfmvYSKdFJjK2Zi/jk2rmNoVF
        IN8k+mrew5GvKkX3ehHOvcQP/BuGSFZIZWKpJ6As1lVVjYwqpvAvGn2AaWw82jzyFQ+Mtzi9WzNoX
        l2Dg7aI8J5DECXNUnz9yQeuhwmwO/26PM8QFCiXvcFhe4QmRdNQ0ZCQ89PXDqe8Fc/jgIsE8l8b1t
        khAI1JOvjm0dQjSpNfuM/i5TqFx14yw0PGaSxwQrFzOe8Iu+jBrznlqT5hCwi57HRqkWuaphMnZBo
        l/dCi3ZucrCu8VBlKdukxt3rs7f96P9KKUHOtPblrJo1DD5GPuCCzAs31v8Z91M5gYlCPCj0EIn84
        ITseWZqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGBlA-00E25K-Ti; Sun, 28 Feb 2021 02:24:42 +0000
Date:   Sun, 28 Feb 2021 02:24:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210228022440.GN2723601@casper.infradead.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228002500.11483-1-sir@cmpwn.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 07:25:00PM -0500, Drew DeVault wrote:
> The mkdir and mkdirat syscalls both return 0 on success, and use of the
> newly-created directory requires a separate open or openat (or openat2)
> call. The time between these syscalls is an opportunity for a race
> condition. It is thus desirable to establish a means of creating a
> directory and returning an open dirfd for it in one atomic operation.

I don't understand what the TOCTOU race is.

$ cd /tmp
$ mkdir foo
$ sudo su fake
$ rmdir foo
rmdir: failed to remove 'foo': Operation not permitted
$ mv foo bar
mv: cannot move 'foo' to 'bar': Operation not permitted

Where's the problem?  If mkdir succeeds in a sticky directory, others
can't remove or rename it.  So how can an app be tricked into doing
something wrong?
