Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5294C2E6ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgL2HxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Dec 2020 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2HxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:53:10 -0500
X-Greylist: delayed 144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Dec 2020 23:52:29 PST
Received: from hermod.demsh.org (hermod.demsh.org [IPv6:2a01:4f9:c010:1460::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1031CC0613D6;
        Mon, 28 Dec 2020 23:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1609228197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:in-reply-to;
        bh=//yLaZSjNdLlz/C9HAUQPZz9tltS99gtWDxcBQPPlE4=;
        b=Z9x/D9VhxMH48rNrYyLzrcfdZsownJNnxcqld/XzsNHcCASXv69T6V5AKuixVHS1fN5I9y
        53WZt9VwBieU4CSya5EDAblJLzTC4pX9bwxm8YApI1A6oSyv/J1TPl+/e73UcWLvpyB3AP
        2op3luxmkPHeKxSqxUlM/Z03TLiU9xbu1igFcBa17XCPCv6UqBn5ZzEgeuCRNtYk2O93Xk
        je7FMcgXoKWXDDWB1S3kw+rVVs8Ndq9hHl8PuzUUWsE2LW9z/SlCFehYjMwtXRnK1Fdd5e
        LsGFtVKdgC3+JcwwxIg+jjsePrwdhO/sG5kPjiV9qtqRgbvVGFII+d8HK+Q1xw==
Received: from note (<unknown> [2a01:a282:13:14:1a3d:a2ff:fe1a:7964])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id 7d1a8c44 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO) auth=yes user=me;
        Tue, 29 Dec 2020 07:49:57 +0000 (UTC)
Date:   Tue, 29 Dec 2020 10:49:55 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     djwong@kernel.org
Cc:     david@fromorbit.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] xfs: new code for 5.11
Message-ID: <20201229104955.565423f9@note>
In-Reply-To: <20201218171242.GH6918@magnolia>
In-Reply-To: <20201218171242.GH6918@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Please pull the following branch containing all the new xfs code for
>5.11.  In this release we add the ability to set a 'needsrepair' flag
>indicating that we /know/ the filesystem requires xfs_repair, but other
>than that, it's the usual strengthening of metadata validation and
>miscellaneous cleanups.
>...
>New code for 5.11:
>- Introduce a "needsrepair" "feature" to flag a filesystem as needing a
>  pass through xfs_repair.  This is key to enabling filesystem upgrades
>  (in xfs_db) that require xfs_repair to make minor adjustments to
>metadata.

Hello.

Most likely I miss something obvious but according to xfs_repair(8):
BUGS:
The filesystem to be checked and repaired must have been unmounted
cleanly  using  normal  system  administration  procedures (the
umount(8)  command  or  system  shutdown),  not  as  a  result of a
crash or system reset.  If the filesystem has not been unmounted
cleanly, mount it and unmount it cleanly before running xfs_repair.

which is there since commit d321ceac "add libxlog directory"
Date:   Wed Oct 17 11:00:32 2001 +0000 in xfsprogs-dev[1]. 

So will be there situation of uncleanly unmounted filesystem with
"needsrepair" bit set? Will one be able to mount and umount it before
running xfs_repair in that case?

[1] git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
