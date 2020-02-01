Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BE14F584
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 01:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBAA4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 19:56:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49888 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBAA4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:56:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixh5T-005Ta0-1z; Sat, 01 Feb 2020 00:56:39 +0000
Date:   Sat, 1 Feb 2020 00:56:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel@vger.kernel.org, devel@lists.orangefs.org
Subject: [confused] can orangefs ACLs be removed at all?
Message-ID: <20200201005639.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Prior to 4bef69000d93 (orangefs: react properly to
posix_acl_update_mode's aftermath.) it used to be possible
to do orangefs_set_acl(inode, NULL, ACL_TYPE_ACCESS) -
it would've removed the corresponding xattr and that would
be it.  Now it fails with -EINVAL without having done
anything.  How is one supposed to remove ACLs there?

	Moreover, if you change an existing ACL to something
that is expressible by pure mode, you end up calling
__orangefs_setattr(), which will call posix_acl_chmod().
And AFAICS that will happen with *old* ACL still cached,
so you'll get ACL_MASK/ACL_OTHER updated in the old ACL.

	How can that possibly work?  Sure, you want to
propagate the updated mode to server - after you've
done the actual update (possibly removal) of ACL-encoding
xattr there...
