Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326063ADA64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhFSO3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Jun 2021 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhFSO3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:29:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE3C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jun 2021 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pIxuiM+EalKyhY27YmC7fgBU/sfLThANATASIxILUaI=; b=GcOmeKN6O331YWUJzvFTj4xNA4
        Slsibo9iMrzHb9TKSvIJLjx5iqKiBoqgB49DailSkKgIsBy7mSHKGTkAqPGRy/RLGF6eV8syi8dXE
        qyv01fRLF6+39MhKjidPxOA47Sl4oww/LJR7HJMK6STI/1Mhja1KjpA6II0pX/A60axnxj6/hQl8Z
        MuJUOP7NdkJOZgq+xPDwT92duEiSRykhJBlL09sVveQEo0CJfnxN8PCa2Uh/hzw0p2OWj+XR2FJkE
        JhE4h/gTtb7tRnDfZaSe9BErCDOF65C2eT/xgz5Vw1RsZwCcr2jkkPvyAgMzd+XxODmeo29b93aks
        4tIGBj1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lubwB-00BJ1k-Li; Sat, 19 Jun 2021 14:27:10 +0000
Date:   Sat, 19 Jun 2021 15:27:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arthur Williams <taaparthur@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Allow open with O_CREAT to succeed if existing dir
 is specified
Message-ID: <YM3+u9E5gZGwarCN@casper.infradead.org>
References: <20210619110148.30412-1-taaparthur@gmail.com>
 <YM3mJjDovNHUxZ8v@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM3mJjDovNHUxZ8v@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 19, 2021 at 12:42:14PM +0000, Al Viro wrote:
> On Sat, Jun 19, 2021 at 06:01:48AM -0500, Arthur Williams wrote:
> > Make opening a file with the O_CREAT flag a no-op if the specified file
> > exists even if it exists as a directory. Allows userspace commands, like
> > flock, to open a file and create it if it doesn't exist instead of
> > having to parse errno.
> 
> Not going to happen.  It's a user-visible behaviour, consistent between
> all kinds of Unices, consistent with POSIX and it does make sense.
> 
> NAK.

Agreed.  POSIX states:

[EISDIR]
    The named file is a directory and oflag includes O_WRONLY or O_RDWR, or includes O_CREAT without O_DIRECTORY.

so I would say the POSIX committee considered this situation and
explicitly did not want it to succeed.
