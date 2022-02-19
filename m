Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9EF4BC5F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 07:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiBSFu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 00:50:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiBSFuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 00:50:55 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF713BDE44;
        Fri, 18 Feb 2022 21:50:36 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLIdf-002uw8-6x; Sat, 19 Feb 2022 05:50:35 +0000
Date:   Sat, 19 Feb 2022 05:50:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, paulmck@kernel.org,
        gscrivan@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] vfs: free vfsmount through rcu work from kern_unmount
Message-ID: <YhCFKyVMtOSyBDJh@zeniv-ca.linux.org.uk>
References: <20220218183114.2867528-1-riel@surriel.com>
 <20220218183114.2867528-2-riel@surriel.com>
 <Yg/y6qv6dZ2fc5z1@zeniv-ca.linux.org.uk>
 <5f442a7770fe4ac06b2837e4f937d559f5d17b8b.camel@surriel.com>
 <Yg/273dWmTKDW5Mu@zeniv-ca.linux.org.uk>
 <YhAAaU5wSoFdMsQf@zeniv-ca.linux.org.uk>
 <YhAKV5cjXEz2JTBB@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhAKV5cjXEz2JTBB@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 09:06:31PM +0000, Al Viro wrote:

> FWIW, that won't work correctly wrt failure exits.  I'm digging
> through the lifetime rules in there right now, will post when
> I'm done.

OK, now that I'd reconstructed the picture...  The problems with
delayed shutdown are prevented by mq_clear_sbinfo() call in there -
mqueue is capable of more or less gracefully dealing with
having ->s_fs_info ripped from under it, which is what that
thing does.  Before the kern_unmount().  And since that code is
non-modular, we don't need to protect that either.

IOW, having
void put_ipc_ns(struct ipc_namespace *ns)
{
        if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
		mq_clear_sbinfo(ns);
		spin_unlock(&mq_lock);
		free_ipc_ns(ns);
	}
}

and
void mq_put_mnt(struct ipc_namespace *ns)
{
	/*
	 * The only reason it's safe to have the mntput async
	 * is that we'd already ripped the ipc_namespace away
	 * from the mqueue superblock, by having called
	 * mq_clear_sbinfo().
	 *
	 * NOTE: kern_unmount_rcu() IS NOT SAFE TO USE
	 * WITHOUT SERIOUS PRECAUTIONS.
	 *
	 * Anything that is used by filesystem must either
	 * be already taken away (and fs must survive that)
	 * or have its destruction delayed until the superblock
	 * shutdown.
	 *
	 */
        kern_unmount_rcu(ns->mq_mnt);
}

would suffice.  free_ipc_work/free_ipc/mnt_llist can be killed off.
