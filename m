Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDE630D84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKSItS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 03:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSItQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:49:16 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90CB65867;
        Sat, 19 Nov 2022 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0TKN0dlGfGdFwo0dwprmBXt8F8zozs1lggU4kgtJGsE=; b=ADa12tjmGzsxLncfyrWy0a5a0r
        w084JLxMODd12t/5V2nbkiin9AdRZWntJk/SJq6zqMOZKJLDSMuLUtKgR4lLPiciZa74Sktkmcy0j
        Z7LP45wtH15ucIwu5tLJKgXVVycrcyI5/AG7QlNJ00LuhFb5IBhJq4ip74Dp0+dXXGpnAwlaSvLup
        7VtfQF/z2da/GGs8ZC18zUxEMJQsia7RDerMAvB95iO70RzBIELFwpEZP3ZsUvH9WAxxiYwynB2v6
        kUiF2UNsxiG6jV0ncs1IhE956RvrKELtml7GT6o/NEBLhlMbefvYJW2gx336rs32nwT5XT1J5JlzG
        TOhpyLZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owJWO-0051Q8-21;
        Sat, 19 Nov 2022 08:48:20 +0000
Date:   Sat, 19 Nov 2022 08:48:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <Y3iYVFT40L0+/MzO@ZenIV>
References: <166807856758.2972602.14175912201162072721.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166807856758.2972602.14175912201162072721.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:09:27AM +0000, David Howells wrote:
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> Fix this by adding a new LSM hook to load fc->security for submount
> creation when alloc_fs_context() is creating the fs_context for it.

FWIW, it feels like security_sb_mnt_opts_compat() would be a saner place
for that.  It would need to get struct dentry *reference passed to it,
but that should be it...
