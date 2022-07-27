Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BE95828BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiG0OdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiG0OdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700724BC8;
        Wed, 27 Jul 2022 07:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E7C061835;
        Wed, 27 Jul 2022 14:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91C0C433C1;
        Wed, 27 Jul 2022 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658932399;
        bh=1lDH0k5c1yMkmA9AQDiFognVwngu6QkMIs6vpOA/Uqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBRyHahqyVB+CAhcdIoEyuIdxhGsQKGgJirzJDfFlbPulhAO0WRirgkeFLAopEIXi
         yWCe4yOYID5mI0q3DYB1H17iVac/GmFNUbcDb6O+nrbrvZVPm5J6e1HGtrNuZSEB/I
         zdAtE4ZHe43/AacJtv3YVtL11Sl5/NmU2S37ECldflAhOHmhMXgHez75qTeVqqZjxF
         Tu1nYOwBlSS57laAPEt5ks09hhymTeGA756J0BHhFnh9k07ZFuz0RvchXFZel1p3JT
         1a6APWqeITE1S0qAyidme4GsaXxdDzqPzp7FbNLAZ4gfJ4YV41Dey7gTJpYOlgnOmw
         WGdXhNrFzr9/w==
Date:   Wed, 27 Jul 2022 16:33:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v2] vfs: bypass may_create_in_sticky check on
 newly-created files if task has CAP_FOWNER
Message-ID: <20220727143314.to2nx2osnw6zjxrm@wittgenstein>
References: <20220727140014.69091-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220727140014.69091-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:00:14AM -0400, Jeff Layton wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> NFS server is exporting a sticky directory (mode 01777) with root
> squashing enabled. Client has protect_regular enabled and then tries to
> open a file as root in that directory. File is created (with ownership
> set to nobody:nobody) but the open syscall returns an error. The problem
> is may_create_in_sticky which rejects the open even though the file has
> already been created.
> 
> Add a new condition to may_create_in_sticky. If the file was just
> created, then allow bypassing the ownership check if the task has
> CAP_FOWNER. With this change, the initial open of a file by root works,
> but later opens of the same file will fail.
> 
> Note that we can contrive a similar situation by exporting with
> all_squash and opening the file as an unprivileged user. This patch does
> not fix that case. I suspect that that configuration is likely to be
> fundamentally incompatible with the protect_* sysctls enabled on the
> clients.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
> Reported-by: Yongchen Yang <yoyang@redhat.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Hi Christian,
> 
> I left you as author here since this is basically identical to the patch
> you suggested. Let me know if that's an issue.

No, that's fine.

It feels pretty strange to be able to create a file and then not being
able to open it fwiw. But we have that basically with nodev already. And
we implicitly encode this in may_create_in_sticky() for this protected_*
stuff. Relaxing this through CAP_FOWNER makes sense as it's explicitly
thought to "Bypass permission checks on operations that normally require
the filesystem UID of the process to match the UID of the file".

One thing that I'm not sure about is something that Seth pointed out
namely whether there's any NFS server side race window that would render
FMODE_CREATED provided to may_create_in_sticky() inaccurate.
