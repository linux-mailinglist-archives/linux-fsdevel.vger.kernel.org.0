Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794514656C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbhLATyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbhLATyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:54:12 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AAC061574;
        Wed,  1 Dec 2021 11:50:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C78C06EEE; Wed,  1 Dec 2021 14:50:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C78C06EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638388250;
        bh=TYOPkEpCN1935j9eNcnnAvlmWIOyOzqnOXPdZZSgRFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLUZBKEhzC+5+x/eud9eKWd5JNbFsDZX5AcotSLMzJWptv1h8z1yPJx1P6Taau9eH
         VUik3eYLm4vzOUtoSbRuLxXSPgfGz1QPqp6FeRGkVA6xmKuocu5xxuuxJuT6055kQn
         /X6zPD2E7AWbNIPhSjyhqYnFj1fNbbfJBRq+EkIE=
Date:   Wed, 1 Dec 2021 14:50:50 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201195050.GE26415@fieldses.org>
References: <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201180339.GC26415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:03:39PM -0500, Bruce Fields wrote:
> On Wed, Dec 01, 2021 at 12:42:05PM -0500, Bruce Fields wrote:
> > On Wed, Dec 01, 2021 at 09:36:30AM -0500, Bruce Fields wrote:
> > > OK, good to know.  It'd be interesting to dig into where nfsdcltrack is
> > > spending its time, which we could do by replacing it with a wrapper that
> > > runs the real nfsdcltrack under strace.
> > > 
> > > Though maybe it'd be better to do this on a system using nfsdcld, since
> > > that's what we're transitioning to.
> > 
> > Trying that on a test VM here, I see each upcall doing 3 fdatasyncs() of
> > an sqlite-journal file.  On my setup, each of those is taking a few
> > milliseconds.  I wonder if it an do better.
> 
> If I understand the sqlite documentation correctly, I *think* that if we
> use journal_mode WAL with synchronous FULL, we should get the assurances
> nfsd needs with one sync per transaction.

So I *think* that would mean just doing something like (untested, don't have
much idea what I'm doing):

diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
index 03016fb95823..b30f2614497b 100644
--- a/utils/nfsdcld/sqlite.c
+++ b/utils/nfsdcld/sqlite.c
@@ -826,6 +826,13 @@ sqlite_prepare_dbh(const char *topdir)
                goto out_close;
        }
 
+       ret = sqlite3_exec(dbh, "PRAGMA journal_mode = WAL;", NULL, NULL, NULL);
+       if (ret)
+               goto out_close;
+       ret = sqlite3_exec(dbh, "PRAGMA synchronous = FULL;", NULL, NULL, NULL);
+       if (ret)
+               goto out_close;
+
        ret = sqlite_query_schema_version();
        switch (ret) {
        case CLD_SQLITE_LATEST_SCHEMA_VERSION:

I also wonder how expensive may be the extra overhead of starting up
nfsdcltrack each time.

--b.
