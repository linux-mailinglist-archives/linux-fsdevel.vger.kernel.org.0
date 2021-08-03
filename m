Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FBA3DF89C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 01:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhHCXqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 19:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHCXqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:46:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74DC061757;
        Tue,  3 Aug 2021 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R0mXLW7elc+6/8EYD+RaHlxlUIP9yA2E2gi6qXvCjps=; b=VvdwOQuBLG6gU0rq7rgnWVjuVR
        r+3I66UDKo7qfQOHTAT/yLBnDqux/PG5BF5WL3YCcy0aZimfXHqFm19RSZWK6rzKxtguvd2bY+5oI
        JydgNzsNFpnPQrn5wY49pVgksCZtA0c2hZftav3GTRxAarnq+xCYGIQOy6dMQQfeLPZ7d2eCt2iP0
        UJVkn9HXvP495VzpEbwfHHJ5AtBGIWOWSjYDbpnA3YlvwE8n+zQk3Vt6LWLX9mBRiO17NGKNVrlMx
        2lAwy3cBxRpoFIctshkcDjnFfcnE3pqwHOzrHHF8pMOgOdmYu6vfEfAu2I1IX8JUiuXa2hkmzJkOB
        9+XOM2oA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB45O-005DCZ-Bg; Tue, 03 Aug 2021 23:44:50 +0000
Date:   Wed, 4 Aug 2021 00:44:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YQnU5m/ur+0D5MfJ@casper.infradead.org>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQnHxIU+EAAxIjZA@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 06:48:36PM -0400, Theodore Ts'o wrote:
> So over the weekend, I decided to take efforts into my own hands, and
> made the relatively simple changes to fstests needed to add support
> for ntfs and ntfs3 file systems.  The results show that the number
> fstests failures in ntfs3 is 23% *more* than ntfs.  This includes a
> potential deadlock bug, and generic/475 reliably livelocking.  Ntfs3
> is also currently not container compatible, because it's not properly
> handling user namespaces.

I don't understand how so many ntfs-classic xfstests pass:

config NTFS_RW
        bool "NTFS write support"
        depends on NTFS_FS
        help
          This enables the partial, but safe, write support in the NTFS driver.

          The only supported operation is overwriting existing files, without
          changing the file length.  No file or directory creation, deletion or
          renaming is possible.  Note only non-resident files can be written to
          so you may find that some very small files (<500 bytes or so) cannot
          be written to.

Are the tests really passing, or just claiming to pass?
