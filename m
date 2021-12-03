Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC0467F33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhLCVZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 16:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383169AbhLCVZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:25:25 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95567C061751;
        Fri,  3 Dec 2021 13:22:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 17B985FFF; Fri,  3 Dec 2021 16:22:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 17B985FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638566520;
        bh=jjTjVe1/Yi2iHOyB/1/4DxWUUveowVmbuD+Agok51gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukl3pOXpDOMZ5PE2seEqFqBorQPdC+Xv1r4CfStJ0ZwtS9/dckW+Z1G/1p0ubpAEz
         kN0Hre2y1yO+ZdUDTAz+44dEbLCQJVV78RZpO4K07mcbHPqMwGKirAKbc3JJZ4Xr0o
         HkgPjl08f3DIqqH5Rnvv6C7vbbSfIgpcTtSg5zYQ=
Date:   Fri, 3 Dec 2021 16:22:00 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211203212200.GB3930@fieldses.org>
References: <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
 <20211201195050.GE26415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201195050.GE26415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:50:50PM -0500, Bruce Fields wrote:
> On Wed, Dec 01, 2021 at 01:03:39PM -0500, Bruce Fields wrote:
> > On Wed, Dec 01, 2021 at 12:42:05PM -0500, Bruce Fields wrote:
> > > On Wed, Dec 01, 2021 at 09:36:30AM -0500, Bruce Fields wrote:
> > > > OK, good to know.  It'd be interesting to dig into where nfsdcltrack is
> > > > spending its time, which we could do by replacing it with a wrapper that
> > > > runs the real nfsdcltrack under strace.
> > > > 
> > > > Though maybe it'd be better to do this on a system using nfsdcld, since
> > > > that's what we're transitioning to.
> > > 
> > > Trying that on a test VM here, I see each upcall doing 3 fdatasyncs() of
> > > an sqlite-journal file.  On my setup, each of those is taking a few
> > > milliseconds.  I wonder if it an do better.
> > 
> > If I understand the sqlite documentation correctly, I *think* that if we
> > use journal_mode WAL with synchronous FULL, we should get the assurances
> > nfsd needs with one sync per transaction.
> 
> So I *think* that would mean just doing something like (untested, don't have
> much idea what I'm doing):

OK, tried that out on my test VM, and: yes, the resulting strace was
much simpler (and, in particular, had only one fdatasync per upcall
instead of 3), and total time to expire 1000 courtesy clients was 6.5
seconds instead of 15.9.  So, I'll clean up that patch and pass it along
to Steve D.

This is all a bit of a derail, I know, but I suspect this will be a
bottleneck in other cases too, like when a lot of clients are reclaiming
after reboot.

We do need nfsdcld to sync to disk before returning to the kernel, so
this probably can't be further optimized without doing something more
complicated to allow some kind of parallelism and batching.

So if you have a ton of clients you'll just need /var/lib/nfs to be on
low-latency storage.

--b.

> 
> diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> index 03016fb95823..b30f2614497b 100644
> --- a/utils/nfsdcld/sqlite.c
> +++ b/utils/nfsdcld/sqlite.c
> @@ -826,6 +826,13 @@ sqlite_prepare_dbh(const char *topdir)
>                 goto out_close;
>         }
>  
> +       ret = sqlite3_exec(dbh, "PRAGMA journal_mode = WAL;", NULL, NULL, NULL);
> +       if (ret)
> +               goto out_close;
> +       ret = sqlite3_exec(dbh, "PRAGMA synchronous = FULL;", NULL, NULL, NULL);
> +       if (ret)
> +               goto out_close;
> +
>         ret = sqlite_query_schema_version();
>         switch (ret) {
>         case CLD_SQLITE_LATEST_SCHEMA_VERSION:
> 
> I also wonder how expensive may be the extra overhead of starting up
> nfsdcltrack each time.
> 
> --b.
