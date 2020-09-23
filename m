Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768E9274F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 05:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIWDlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 23:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWDlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 23:41:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354EC061755;
        Tue, 22 Sep 2020 20:41:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKvew-004GoQ-Q1; Wed, 23 Sep 2020 03:41:35 +0000
Date:   Wed, 23 Sep 2020 04:41:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 01/16] vfs: export new_inode_pseudo
Message-ID: <20200923034134.GE3421308@ZenIV.linux.org.uk>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-2-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:52PM -0400, Jeff Layton wrote:
> Ceph needs to be able to allocate inodes ahead of a create that might
> involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> but it puts the inode on the sb->s_inodes list and when we go to hash
> it, that might be done again.
> 
> We could work around that by setting I_CREATING on the new inode, but
> that causes ilookup5 to return -ESTALE if something tries to find it
> before I_NEW is cleared. To work around all of this, just use
> new_inode_pseudo which doesn't add it to the list.

Er...  Why would you _not_ want -ESTALE in that situation?
