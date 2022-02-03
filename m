Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD334A7E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiBCECs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 23:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBCECs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 23:02:48 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE52C061714;
        Wed,  2 Feb 2022 20:02:47 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFTKX-006hwU-4m; Thu, 03 Feb 2022 04:02:45 +0000
Date:   Thu, 3 Feb 2022 04:02:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ksmbd] racy uses of ->d_parent and ->d_name
Message-ID: <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
References: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
 <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 08:16:21AM +0900, Namjae Jeon wrote:

> > 	Why is so much tied to "open, then figure out where it is" model?
> > Is it a legacy of userland implementation, or a network fs protocol that
> > manages to outsuck NFS, or...?
> It need to use absolute based path given from request.

Er... yes?  Normal syscalls also have to be able to deal with pathnames;
the sane way for e.g. unlink() is to traverse everything except the last
component, then do inode_lock() on the directory you've arrived at, do
lookup for the final component and do the operation.

What we do not attempt is "walk the entire path, then try to lock the
parent of whatever we'd arrived at, then do operation".  Otherwise
we'd have the same kind of headache in all directory-manipulating
syscalls...

What's the problem with doing the same thing here?  Lack of convenient
exported helpers for some of those?  Then let's sort _that_ out...
If there's something else, I'd like to know what exactly it is.
