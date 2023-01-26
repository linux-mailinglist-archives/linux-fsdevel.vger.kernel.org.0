Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D949E67D77A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjAZVOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 16:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAZVOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:14:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024C7DB1;
        Thu, 26 Jan 2023 13:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bXlr5GykOqxD+X3a8hCFETo6QgUbIMeWpQ3CTz0QRAQ=; b=ikbjb91IVpobEfKO5j+MoJU9+u
        WAg8rm++4+ZEBQFdvQOTQ09ll93LWCvvcCVTqmwMsOsbcdEFSIxuBg4KhnUqIKmErFpyGpUMKqCJU
        ufuSHMbmOxanIH6/aPuHEAHE4KEjWTrzQaxK+OK4XCZpuPLuq8dwiMEXvCMm2cjWxhG1OorSOFxMF
        iuEwd9zmTPNX/5JMnGxQE2OpjL6FIonpqX7kO49Y9uMx63O2oWueGTB2Daaw0UL4lceawnUci9VTG
        A9PdlYFkoTz6pFKmYjqlEkC4uJhyHQc2JX5+RJzPgCn28FGFu1ChZ6ybFai2elunJb9+xlE+CQ7Tq
        6nNPazmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pL9ZY-004Jkn-2A;
        Thu, 26 Jan 2023 21:14:16 +0000
Date:   Thu, 26 Jan 2023 21:14:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-fsdevel@vger.kernel.org, gscrivan@redhat.com,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] ipc,namespace: batch free ipc_namespace structures
Message-ID: <Y9LtKMC8/qqLNgcZ@ZenIV>
References: <20230126205721.582612-1-riel@surriel.com>
 <20230126205721.582612-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126205721.582612-3-riel@surriel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:57:21PM -0500, Rik van Riel wrote:
> Instead of waiting for an RCU grace period between each ipc_namespace
> structure that is being freed, wait an RCU grace period for every batch
> of ipc_namespace structures.
> 
> Thanks to Al Viro for the suggestion of the helper function.
> 
> This speeds up the run time of the test case that allocates ipc_namespaces
> in a loop from 6 minutes, to a little over 1 second:
> 
> real	0m1.192s
> user	0m0.038s
> sys	0m1.152s
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: Chris Mason <clm@meta.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>

OK, except that I'd rather
	a) made it
	if (mnt)
		real_mount(mnt)->mnt_ns = NULL;
so that it would treat NULL as no-op and
	b) made kern_unmount() and kern_unmount_array() use it:
void kern_unmount(struct vfsmount *mnt)
{
        /* release long term mount so mount point can be released */
        if (!IS_ERR(mnt)) {
		mnt_make_shorterm(mnt);
                synchronize_rcu();      /* yecchhh... */
                mntput(mnt);
        }
}

void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
{
        unsigned int i;

        for (i = 0; i < num; i++)
		mnt_make_shorterm(mnt[i]);
        synchronize_rcu_expedited();
        for (i = 0; i < num; i++)
                mntput(mnt[i]);
}
