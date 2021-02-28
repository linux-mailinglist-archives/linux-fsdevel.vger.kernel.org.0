Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6132700D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 03:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhB1COg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 21:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1COf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:14:35 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC310C06174A;
        Sat, 27 Feb 2021 18:13:54 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGBaU-001Y6J-QU; Sun, 28 Feb 2021 02:13:38 +0000
Date:   Sun, 28 Feb 2021 02:13:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk>
References: <20210228002500.11483-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228002500.11483-1-sir@cmpwn.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 07:25:00PM -0500, Drew DeVault wrote:

> This introduces mkdirat2, along with the requisite flag argument, which
> presently accepts the same flags as open - allowing the caller to
> specify, say, O_CLOEXEC - and leaving us room to expand the next time an
> unforeseeable addition to mkdir is called for. Otherwise, it behaves
> identically to mkdirat, but returns an open file descriptor for the new
> directory.

No to the ABI part; "on error it returns -E..., on success - 0 or
a non-negative number representing a file descriptor (zero also possible,
but unlikely)" is bloody awful as calling conventions go, especially
since the case when 0 happens to be a descriptor is not going to get
a lot of testing on the userland side.

Don't mix "return an error or descriptor" with "return an error or 0".
It's going to end up a regular source of userland bugs.
