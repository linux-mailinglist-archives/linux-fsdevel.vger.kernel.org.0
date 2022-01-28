Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09749F031
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 01:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiA1A6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 19:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiA1A6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:58:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E26C061714;
        Thu, 27 Jan 2022 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u9jRVqA2Bs0NAfgFYlA/hW35TDeyw2nDJVEFZxEAkdA=; b=WU6/JKhymEPIif84GWAnNrY3V1
        kcr8jGkUmFjPdkh3hx/9NozOuav9GoeLWTa4qJOtsTRajITpY3qrDBwRMvnyPX4x6XpVDqKPleXfR
        Vn3tuzR7hQkcfBTTh6lzTMjna8TWOTTpJ3OEUUUxDX+E87JwZRCusukTvkXd+FY1J4f8A3ue4vApm
        33raRVtD8HNvg6L9aoUE2FYVwLg2sbvJAyx6eF02G0ud0ocOEeYmDPM/9R8PS7sQ5tcqFjrQmAduQ
        ncN4jyXWPSbNzt9jpvzHtesTzhLze4i2uipyUk4D33XzFoGLNSin9xYf/7Dq6jA9nmC0rLIufzwss
        3dwi4KgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDFaY-005q2k-AJ; Fri, 28 Jan 2022 00:58:06 +0000
Date:   Fri, 28 Jan 2022 00:58:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] cifs: Implement cache I/O by accessing the cache
 directly
Message-ID: <YfM/ngiPN5wkwjii@casper.infradead.org>
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
 <164329937835.843658.13129382687019174242.stgit@warthog.procyon.org.uk>
 <CAH2r5mu4FeX2x=Xd0jDnQopTfhOBP_P91-NH-A+bNdx6THCu8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu4FeX2x=Xd0jDnQopTfhOBP_P91-NH-A+bNdx6THCu8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 06:55:23PM -0600, Steve French wrote:
> Regression tests so far on Dave's cifs fscache patch series are going
> fine.  First series of tests I ran were this:
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/11/builds/160
> but I have to run additional tests with fscache enabled etc.
> 
> I saw that checkpatch had some minor complaints on this patch (patch
> 4) which I cleaned up, but was wondering other's thoughts on this
> checkpatch warning:
> 
> WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
> rather than BUG() or BUG_ON()
> #101: FILE: fs/cifs/file.c:4449:
> 
> ie
> 
> + page = readahead_page(ractl);
> + BUG_ON(!page);

Just remove it.  The kernel will crash just fine without putting in an
explicit BUG_ON, and it'll be obvious what the problem is.
