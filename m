Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2E40BAC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 23:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhINVxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhINVxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:53:17 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE80C061574;
        Tue, 14 Sep 2021 14:51:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 38514C021; Tue, 14 Sep 2021 23:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1631656311; bh=TnXdIO/oF8kdpia/r491f3TADt5GhanlBg8g1B7rlOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3+TN1nUPD7E0ikf3ybTrtRRFeG+ZMypqS6RWcqbQpq7MMOrh5csDJQKtgqhdPa8n6
         yQ6/e4rc16wk3fryGfNrabWRor0YgKassUSnJloJ0aK9Xua47cuX2WcW1gfymYpmer
         h3T2j9l9nSAmypkP1neoOVqUiQ3hbuZ02xo8nBOGfYvk+CTcISWMWSgxjFTWg3Fs16
         +9SgklmDuWSf/lG3giknSANUSNZrHAmjA2Wue3FYU7YlStIPZWTR9v0HKjLNAMo5Pu
         cKl31Fl4aA5fNcfn3uxq33js627akWaBlvGEhoL0+5lg0tfNWyApTSuhYKC7F+Wlgy
         03L6LZr6z4m4A==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CE81AC009;
        Tue, 14 Sep 2021 23:51:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1631656310; bh=TnXdIO/oF8kdpia/r491f3TADt5GhanlBg8g1B7rlOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJuDIZ0KNIBIsCWAwJIBTUKARF062cKhG8Izjmu7Vgs0kdCzVFNrGl8EvKgCQPjB7
         NvbztZkdPdABmARgGCtq1uReBl0X7UZMmJLdrkk8VjVqC5aVczXUKKkgxJU7PdAWYf
         ULl/9B6rNX3MRoUof3MWTxtYOgFPLQwcJnm7D3jRxyApqXxQcvd9Iq8wo8t4yAxjrg
         LUuKVU+b/s1whApaf173AslTEtux+yflsS8J316d88Di/dauNTnmAbgcgcDnXT53fu
         3ZrhkPyYmVMzI2CBmzrELf0E8g9UZmmU1UWOEiLWn9YDp3D1ELsl6wLk4+Yj+E4/dV
         QDr4PSOlME2JQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 7519297c;
        Tue, 14 Sep 2021 21:51:41 +0000 (UTC)
Date:   Wed, 15 Sep 2021 06:51:26 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] 9p: (untested) Convert to using the netfs helper lib
 to do reads and caching
Message-ID: <YUEZXktGOCUWfvnU@codewreck.org>
References: <6274f0922aecd9b40dd7ff1ef007442ed996aed7.camel@redhat.com>
 <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
 <163162772646.438332.16323773205855053535.stgit@warthog.procyon.org.uk>
 <439558.1631628579@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <439558.1631628579@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

David Howells wrote on Tue, Sep 14, 2021 at 03:09:39PM +0100:
> > Does this change require any of the earlier patches in the series? If
> > not, then it may be good to go ahead and merge this conversion
> > separately, ahead of the rest of the series.
> 
> There's a conflict with patch 1 - you can see the same changes made to afs and
> ceph there, but apart from that, no.  However, I can't do patch 6 without it
> being applied first.  If Dominique or one of the other 9p people can get Linus
> to apply it now, that would be great, but I think that unlikely since the
> merge window has passed.

Agreed with the merge window passed it'll be for next one -- but I'd
like this to sit in -next for as long as possible, so I'd appreciate
either being able to carry the patch in my tree (difficult as then
you'll need to base yourself on mine) or you putting it in there somehow
after I've got the most basic tests verified again (do you have a branch
pulled for linux-next?)

I'll try to get tests done in the next few days and check my notes for
things that were missing in the earlier version you gave me in the
past.. Sorry for not doing it myself, you're of great help.
-- 
Dominique
