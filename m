Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17206C3822
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCURZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCURZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:25:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA74C6F1;
        Tue, 21 Mar 2023 10:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 162B6CE182E;
        Tue, 21 Mar 2023 17:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A38C433EF;
        Tue, 21 Mar 2023 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679419500;
        bh=jMe23j9qiVcClWh2iL2SnVCuz9tmjChhUHm7yW5Rmo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YysKQ5CtwSUZt14skZumy98a67A0ZUEadlGC3Z2VeRzrvDt86toI/8ef+57cx274Q
         n0kjeg5DD4jnnZQtTy4b03oytoJtavI1ygSAXHRyt7zMehbq0dx3aXLhp9mugvDtdz
         4tHJ3+gTPNaIefeUB1vhhZaZKqq7PdEnEcrgZawiuUFKZccSU6UTkZKeIP5o9spenv
         c13mlQrAGArsUOUiOmMbwVhBdvIS+jG83ZBB3YupKjCtscmjseloddwDIsPDk+0huU
         BoHYVWxAKPIVb3EKMgUmsOwWyg3+KxvE+fcXV7n3/ChXiXNOhvWm/MHKJ3KC8iO5qJ
         OtbVCK6+BthNg==
Date:   Tue, 21 Mar 2023 18:24:50 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Does Landlock not work with eCryptfs?
Message-ID: <20230321172450.crwyhiulcal6jvvk@wittgenstein>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:36:19PM +0100, Mickaël Salaün wrote:
> There is an inconsistency between ecryptfs_dir_open() and ecryptfs_open().
> ecryptfs_dir_open() actually checks access right to the lower directory,
> which is why landlocked processes may not access the upper directory when
> reading its content. ecryptfs_open() uses a cache for upper files (which
> could be a problem on its own). The execution flow is:
> 
> ecryptfs_open() -> ecryptfs_get_lower_file() -> ecryptfs_init_lower_file()
> -> ecryptfs_privileged_open()
> 
> In ecryptfs_privileged_open(), the dentry_open() call failed if access to
> the lower file is not allowed by Landlock (or other access-control systems).
> Then wait_for_completion(&req.done) waits for a kernel's thread executing
> ecryptfs_threadfn(), which uses the kernel's credential to access the lower
> file.
> 
> I think there are two main solutions to fix this consistency issue:
> - store the mounter credentials and uses them instead of the kernel's
> credentials for lower file and directory access checks (ecryptfs_dir_open
> and ecryptfs_threadfn changes);
> - use the kernel's credentials for all lower file/dir access check,
> especially in ecryptfs_dir_open().
> 
> I think using the mounter credentials makes more sense, is much safer, and
> fits with overlayfs. It may not work in cases where the mounter doesn't have
> access to the lower file hierarchy though.
> 
> File creation calls vfs_*() helpers (lower directory) and there is not path
> nor file security hook calls for those, so it works unconditionally.
> 
> From Landlock end users point of view, it makes more sense to grants access
> to a file hierarchy (where access is already allowed) and be allowed to
> access this file hierarchy, whatever it belongs to a specific filesystem
> (and whatever the potential lower file hierarchy, which may be unknown to
> users). This is how it works for overlayfs and I'd like to have the same
> behavior for ecryptfs.

So given that ecryptfs is marked as "Odd Fixes" who is realistically
going to do the work of switching it to a mounter's credentials model,
making sure this doesn't regress anything, and dealing with any
potential bugs caused by this. It might be potentially better to just
refuse to combine Landlock with ecryptfs if that's possible.
