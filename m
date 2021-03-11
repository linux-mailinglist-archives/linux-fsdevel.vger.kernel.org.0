Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC9337D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 19:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhCKS70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 13:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCKS7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:59:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC948C061574;
        Thu, 11 Mar 2021 10:59:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so3206584wrz.0;
        Thu, 11 Mar 2021 10:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/VaT6QTTrMOXOdcCNY8dGczMxt/ZRKPGsNaK95kYCU=;
        b=Ge4XR5UrVenv/Ydt3uXyFTeYu01XXSCCJ5cLbGJIntiLgVO3lMSyWUkEh5f/k6nS5v
         P5CQJ9lD6FmgBSubCQZQA+0LOAgi/gsVBXJpxIGJ3hsrUncD7Y69NHkDIZO0QA1N0bXx
         XSQr3WjcPmz/xCJxDZRY1neSkD1qaWeU+4Ktt5mSDP4XxFAupObsnNf75/nHIH8zqSAu
         QioyO6NABSgIZ+/d3xpw/7OyerMo3oLbKtsqWNQwq1NLbgdplHNwBJRJJ9MyseUMbCyc
         MDTFNXDoKZzbiE3+35mHjELkcMDwenPWCH+nG7Kp3Noa9DiqVhUIn8Kn5va5KqY1075y
         JugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/VaT6QTTrMOXOdcCNY8dGczMxt/ZRKPGsNaK95kYCU=;
        b=T7d8oufZh+x9rN7eQd5bfDEeLXtDjSowfLMSPFqcUvf2w/oH8ezhxUiNILMnvK0tEG
         QYNcoJxhPMiYyAnaFvoqEzJQ46Ly6Wga3U1TT5A5O/ynV8QePzJMY/c3iAwfZYIKVGD9
         eZ0YXkqFT9nM82aUbDMYVtY6HJtApR+3YO6X5snlZcsHeB6FSXdkRvp9+P05gJkFNehh
         FSAaHC5YKbTnADskxeTwHLJFe6JRzOdgjesAc+ME0wgszi+zmc4hhXtOTxTSLcpgsDQS
         h1B3aM6kP2Rum8TGlS+ONTF+G8li9CDXErieQ84YU0n91MQsi62bLbrc+hQRY0PV0ffm
         eT2Q==
X-Gm-Message-State: AOAM532UkGUFu+NnqNndaMQBpERxjXspeW3ELHOimwEIVhq6qL9+9rHl
        N9714NJFx4GWs67bLsNON4cRtJQi6fau58RxlqAGaGMw
X-Google-Smtp-Source: ABdhPJw1DqQWu91k3LpEdVODHTcI9sUzHL/qp1K9Qx0cmIyDgFBqnBSglWl5/fs6OgOwfKmwa6MXEAMR0XK+s12GdC0=
X-Received: by 2002:a5d:6103:: with SMTP id v3mr9922691wrt.375.1615489157599;
 Thu, 11 Mar 2021 10:59:17 -0800 (PST)
MIME-Version: 1.0
References: <161547181530.1868820.12933722592029066752.stgit@warthog.procyon.org.uk>
 <161547183017.1868820.15107551878060916410.stgit@warthog.procyon.org.uk>
In-Reply-To: <161547183017.1868820.15107551878060916410.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Thu, 11 Mar 2021 14:59:06 -0400
Message-ID: <CAB9dFdvdPceQE85a4bAsxJOiJAr-VXU_57T6Np163mn5uFUXQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] afs: Fix afs_listxattr() to not list afs ACL special xattrs
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:10 AM David Howells <dhowells@redhat.com> wrote:
>
> afs_listxattr() lists all the available special afs xattrs (i.e. those in
> the "afs.*" space), no matter what type of server we're dealing with.  But
> OpenAFS servers, for example, cannot deal with some of the extra-capable
> attributes that AuriStor (YFS) servers provide.  Unfortunately, the
> presence of the afs.yfs.* attributes causes errors[1] for anything that
> tries to read them if the server is of the wrong type.
>
> Fix afs_listxattr() so that it doesn't list any of the AFS ACL xattrs.  It
> does mean, however, that getfattr won't list them, though they can still be
> accessed with getxattr() and setxattr().
>
> This can be tested with something like:
>
>         getfattr -d -m ".*" /afs/example.com/path/to/file
>
> With this change, none of the afs.* ACL attributes should be visible.
>
> Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
> Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> cc: linux-afs@lists.infradead.org
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003502.html [1]
> ---
>
>  fs/afs/xattr.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index 4934e325a14a..81a6aec764cc 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -12,14 +12,9 @@
>  #include "internal.h"
>
>  static const char afs_xattr_list[] =
> -       "afs.acl\0"
>         "afs.cell\0"
>         "afs.fid\0"
> -       "afs.volume\0"
> -       "afs.yfs.acl\0"
> -       "afs.yfs.acl_inherited\0"
> -       "afs.yfs.acl_num_cleaned\0"
> -       "afs.yfs.vol_acl";
> +       "afs.volume";
>
>  /*
>   * Retrieve a list of the supported xattrs.

As Jeffrey suggested, you may want to consider not exposing any of
them, but this seems fine to me.

Besides the reasons you mention, acls getting copied blindly is not a
good idea.  The source and target may be in different cells where
users and groups mean different things.  For files, it may switch them
from inheriting permissions from their parent to having their own ACL,
etc.

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
