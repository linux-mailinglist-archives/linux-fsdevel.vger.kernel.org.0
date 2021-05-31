Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2B39672D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEaRgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhEaRga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 13:36:30 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6AC014CE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 09:40:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnkxw-0030gH-Fw; Mon, 31 May 2021 16:40:36 +0000
Date:   Mon, 31 May 2021 16:40:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     tianyu zhou <tyjoe.linux@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Missing check for CAP_SYS_ADMIN in do_reconfigure_mnt()
Message-ID: <YLURhCHSEwlL2oCD@zeniv-ca.linux.org.uk>
References: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 10:59:54PM +0800, tianyu zhou wrote:
> Hi, function do_remount() in fs/namespace.c checks the CAP_SYS_ADMIN
> before it calls set_mount_attributes().
> 
> --------------------
> // fs/namespace.c
> static int do_remount(struct path *path, int ms_flags, int sb_flags,
>               int mnt_flags, void *data)
> {
>         ....
>         if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
>             err = reconfigure_super(fc);
>             if (!err) {
>                 lock_mount_hash();
>                 set_mount_attributes(mnt, mnt_flags);       // <===
> protected function
>                 unlock_mount_hash();
>             }
>         ...
> }
> --------------------
> 
> However, in another caller of set_mount_attributes(),
> do_reconfigure_mnt(), I have not found any check for CAP_SYS_ADMIN.
> So, is there a missing check bug inside do_reconfigure_mnt() ? (which
> makes it possible for normal user to reach set_mount_attributes())

IDGI.  By the same token, there are callers of e.g. memcpy() with
CAP_SYS_ADMIN checks upstream of those, as well as those that are
called without any such checks whatsoever.  The answer to such
observation would obviously be "what of that?" and I really wonder
what your criteria are.

For another example, in the same function you have lock_mount_hash()
calls as well; are you going to report the calls of that made without
CAP_SYS_ADMIN?

IOW, what are the heuristics you are using to select the functions
you deem suspicious?
