Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0F327021
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 03:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB1C7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1C7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:59:17 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC27C06174A;
        Sat, 27 Feb 2021 18:58:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGCHm-001YgY-OA; Sun, 28 Feb 2021 02:58:22 +0000
Date:   Sun, 28 Feb 2021 02:58:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk>
 <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 09:21:09PM -0500, Drew DeVault wrote:
> On Sat Feb 27, 2021 at 9:13 PM EST, Al Viro wrote:
> > No to the ABI part; "on error it returns -E..., on success - 0 or a
> > non-negative number representing a file descriptor (zero also
> > possible, but unlikely)" is bloody awful as calling conventions go,
> > especially since the case when 0 happens to be a descriptor is not
> > going to get a lot of testing on the userland side.
> 
> Hm, I was just trying to mimic the behavior of open(2). Do you have a
> better suggestion?

open() *always* returns descriptor or an error, for one thing.
And quite a few of open() flags are completely wrong for mkdir,
starting with symlink following and truncation.

What's more, your implementation is both racy and deadlock-prone -
it repeats the entire pathwalk with no warranty that it'll
arrive to the object you've created *AND* if you have
something like /foo/bar/baz/../../splat and dentry of bar
gets evicted on memory pressure, that pathwalk will end up
trying to look bar up.  In the already locked /foo, aka
/foo/bar/baz/../..

TBH, I don't understand what are you trying to achieve -
what will that mkdir+open combination buy you, especially
since that atomicity goes straight out of window if you try
to use that on e.g. NFS.  How is the userland supposed to make
use of that thing?
