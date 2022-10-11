Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB725FBA17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJKSEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJKSEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:04:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E320719BE
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Mwbv3iQPCgy6ZSMrRqvJqSSEK0Lj+zLBE4qwzSsFCbU=; b=qQ4sLa9AjFvT0JX4Fmk1iDbbtz
        VrbLckgeyneQnOUEqDhZs/3nqH6TvSgMbtDl33ZhLvOV7hZ40doFMTs1FcROVnP0vazQGDincZ8kt
        ev5ZU+GcmIWftdlkL9dSgdqtdEhg05r3a2qgRuS+KxITzt1oJspPkVh9f8rWu0kW4ic/TDbj9gyOK
        R9bUdhGc1E+RT3e0XuMi6Rk9MQml1YnNZ8/W8RT0s+iVlTMYNmCmxeOwsdb330tdviWWCVUkMY4yW
        H9HT7HRdbh6uGLUKE0mUcq1n9w/xRhc32TiYV4c0UWt1apc4Wx+GuPXRtGpQt8opbrUyz7obZzPlr
        ze1QOifA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oiJb8-009afb-2a;
        Tue, 11 Oct 2022 18:03:22 +0000
Date:   Tue, 11 Oct 2022 19:03:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>
Subject: [RFC] fl_owner_t and use of filp_close() in nfs4_free_lock_stateid()
Message-ID: <Y0Wv6qe3r8/Djt7s@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	In the original commit that introduced that thing, we have
a somewhat strange note in commit message:

    Use filp_close instead of open coding. filp_close does a bit more than
    just release the locks and put the filp. It also calls ->flush and
    dnotify_flush, both of which should be done here anyway.

How could dnotify_flush() possibly catch anything here?  In the current
form the value we pass as id is
	(fl_owner_t)lockowner(stp->st_stateowner)
and lockowner is container_of(so, struct nfs4_lockowner, lo_owner);

dnotify_flush() looks for matches on dn->dn_owner == id; anything
not matching is left alone.  And ->d_owner is set only by attach_dn(),
which gets the value from
        fl_owner_t id = current->files;

If we ever see a match here, we are in deep trouble - the same address
being used as struct files_struct * and struct nfs4_lockowner * at
the same time...

Another interesting question is about FUSE ->flush() - how is the
server supposed to use the value it gets from
        inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
in fuse_flush()?  Note that e.g. async write might be followed by
close() before the completion.  Moreover, it's possible to start
async write and do unshare(CLONE_FILES); if the descriptor table
used to be shared and all other threads exit after our unshare,
it's possible to get
	async write begins, fuse_send_write() called with current->files as owner
	flush happens, with current->files as id
	what used to be current->files gets freed and memory reused
	async write completes

Miklos, could you give some braindump on that?
