Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387C72B97E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFLIAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjFLH7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E93A96;
        Mon, 12 Jun 2023 00:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5691261255;
        Mon, 12 Jun 2023 07:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3CCC433D2;
        Mon, 12 Jun 2023 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686556672;
        bh=izlq8mhE13n5UZ2KxbmZGEuic1El4k0CH0iUBoTcgYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpt0/ckEQlp3g461loOKF6eEyqvWYbkSzfPc97N5mabIXGZEcxmWHGcav0hxH0ICq
         sYe4JQYkoVXIxH9a8SS43OIT1IIDwwFfexMlBUSdcLG0WM0ocMwyxdJzGosn+cM+iJ
         oykzVYhz5C22/Gyx3UfC7OKJ4+ZMgfbrUEh9IOjAYeicYO/cHuS7IxdDRcgD+k3WMw
         TADIWrVhH478gF+vp8n3OMTx8XV5pT62wiMSyZC52f2Ga4u/B1XgojeCXfUVWKoMfG
         +KMWadqSIXnlGA0hdB8Ti1ZSDgtvajYQT/qPrIzQeoob95YQ+MFmuML8+gcAUm2XES
         fAravJu6YAidg==
Date:   Mon, 12 Jun 2023 09:57:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 0/3] Reduce impact of overlayfs fake path files
Message-ID: <20230612-heckklappe-bedarf-c0e81f7d19a8@brauner>
References: <20230609073239.957184-1-amir73il@gmail.com>
 <CAJfpegvDoSWPRaoa_i_Do3JDdaXrhohDtfQNObSJ7tNhhuHAKw@mail.gmail.com>
 <CAOQ4uxh=KfY2mNW1jQk6-wjoGWzi5LdCN=H9LzfCSx2o69K36A@mail.gmail.com>
 <CAOQ4uxgk3sAubfx84FKtNSowgT-aYj0DBX=hvAApre_3a8Cq=g@mail.gmail.com>
 <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegtt48eXhhjDFA1ojcHPNKj3Go6joryCPtEFAKpocyBsnw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 05:00:25PM +0200, Miklos Szeredi wrote:
> On Fri, 9 Jun 2023 at 16:42, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 5:28 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 4:15 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > Miklos,
> > > > >
> > > > > This is the solution that we discussed for removing FMODE_NONOTIFY
> > > > > from overlayfs real files.
> > > > >
> > > > > My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
> > > > > I am still testing the ovl-fsnotify interaction, so we can defer
> > > > > that step to later.
> > > > >
> > > > > I wanted to post this series earlier to give more time for fsdevel
> > > > > feedback and if these patches get your blessing and the blessing of
> > > > > vfs maintainers, it is probably better that they will go through the
> > > > > vfs tree.
> > > > >
> > > > > I've tested that overlay "fake" path are still shown in /proc/self/maps
> > > > > and in the /proc/self/exe and /proc/self/map_files/ symlinks.
> > > > >
> > > > > The audit and tomoyo use of file_fake_path() is not tested
> > > > > (CC maintainers), but they both look like user displayed paths,
> > > > > so I assumed they's want to preserve the existing behavior
> > > > > (i.e. displaying the fake overlayfs path).
> > > >
> > > > I did an audit of all ->vm_file  and found a couple of missing ones:
> > >
> > > Wait, but why only ->vm_file?
> 
> Because we don't get to intercept vm_ops, so anything done through
> mmaps will not go though overlayfs.   That would result in apparmor
> missing these, for example.
> 
> > > We were under the assumption the fake path is only needed
> > > for mapped files, but the list below suggests that it matters
> > > to other file operations as well...
> > >
> > > >
> > > > dump_common_audit_data
> > > > ima_file_mprotect
> > > > common_file_perm (I don't understand the code enough to know whether
> > > > it needs fake dentry or not)
> > > > aa_file_perm
> > > > __file_path_perm
> > > > print_bad_pte
> > > > file_path
> > > > seq_print_user_ip
> > > > __mnt_want_write_file
> > > > __mnt_drop_write_file
> > > > file_dentry_name
> > > >
> > > > Didn't go into drivers/ and didn't follow indirect calls (e.g.
> > > > f_op->fsysnc).  I also may have missed something along the way, but my
> > > > guess is that I did catch most cases.
> > >
> > > Wow. So much for 3-4 special cases...
> > >
> > > Confused by some of the above.
> > >
> > > Why would we want __mnt_want_write_file on the fake path?
> > > We'd already taken __mnt_want_write on overlay and with
> > > real file we need __mnt_want_write on the real path.
> 
> It's for write faults on memory maps.   The code already branches on
> file->f_mode, I don't think it would be a big performance hit to check
> FMODE_FAKE_PATH.
> 
> > >
> > > For IMA/LSMs, I'd imagine that like fanotify, they would rather get
> > > the real path where the real policy is stored.
> > > If some log files end with relative path instead of full fake path
> > > it's probably not the worst outcome.
> > >
> > > Thoughts?
> >
> > Considering the results of your audit, I think I prefer to keep
> > f_path fake and store real_path in struct file_fake for code
> > that wants the real path.
> >
> > This will keep all logic unchanged, which is better for my health.
> > and only fsnotify (for now) will start using f_real_path() to
> > generate events on real fs objects.
> 
> That's also an option.

Ideally we keep the generic file infrastructure separate from the
conversion of the various places because the latter operation is the
really sensitive part.
