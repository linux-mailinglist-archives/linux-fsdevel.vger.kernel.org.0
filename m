Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D3481CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhL3N7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 08:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhL3N7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:59:06 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2753C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 05:59:05 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2vxO-00G1M0-Gn; Thu, 30 Dec 2021 13:59:02 +0000
Date:   Thu, 30 Dec 2021 13:59:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hans Montero <hjm2133@columbia.edu>
Cc:     linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
        Xijiao Li <xl2950@columbia.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Subject: Re: Question about `generic_write_checks()` FIXME comment
Message-ID: <Yc27JtY8WwsE00Hs@zeniv-ca.linux.org.uk>
References: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 03:07:25AM -0500, Hans Montero wrote:
 
> Furthermore, why doesn't VFS do the `O_APPEND` check itself instead of
> delegating the task to the filesystems? It seems like a universal check,
> especially given the following snippet on `O_APPEND` from the man page for
> open(2):
> 
>   APPEND
>       The file is opened in append mode. Before each write(2), the file offset
>       is positioned at the end of the file, as if with lseek(2).

Because we need to make sure that no other thread will grow the file between
the check and actual IO?  And exclusion might very well differ for different
filesystems.  Incidentally, what kind of semantics could you assign to
O_APPEND on a block device?  Other than "ignore it", that is...
