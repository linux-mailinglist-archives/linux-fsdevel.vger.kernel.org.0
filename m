Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2634DD35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 02:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhC3Asn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 20:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhC3AsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:48:25 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5618C061762;
        Mon, 29 Mar 2021 17:48:24 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lR2YN-000ssh-1X; Tue, 30 Mar 2021 00:48:19 +0000
Date:   Tue, 30 Mar 2021 00:48:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: why is short-circuiting nfs_lookup() for mkdir(2) et.al. dependent
 upon v3 or later?
Message-ID: <YGJ1UyTYumVZCa8v@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

        In nfs_lookup() we have
        /*
         * If we're doing an exclusive create, optimize away the lookup
         * but don't hash the dentry.
         */
        if (nfs_is_exclusive_create(dir, flags) || flags & LOOKUP_RENAME_TARGET)
                return NULL;
OK, fair enough - we don't need to find out whether it's negative or not for
mkdir() et.al.; if it isn't, server will tell us to sod off and we can live
with not having it in cache - in the worst case, we'll have to do the same
lookup we'd skipped here at some later point.  Same for rename(2) destination -
if it wasn't in dcache, we are not going to bother with sillyrename anyway, and
that's the only thing where we might care about the destination.  If rename(2)
succeeds, we won't see whatever had been there anyway, and if it fails, we won't
lose anything from having lookup done later.

        What I don't get is why, unlike rename(2) target, mkdir(2) argument is
handled that way only for v3 and later.  It's been a long time since I looked
at NFSv2 servers, but shouldn't we get NFSERR_EXIST if the sucker turns out to
have already been there?

        What am I missing?
