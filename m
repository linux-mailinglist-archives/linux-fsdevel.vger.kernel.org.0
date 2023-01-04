Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87D65D38F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjADM7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 07:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjADM7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:59:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EDFCF1;
        Wed,  4 Jan 2023 04:59:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA04613F8;
        Wed,  4 Jan 2023 12:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1CAC433D2;
        Wed,  4 Jan 2023 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672837158;
        bh=iWDdWxl66rSFkYARxRSp2SEDLaWgJX3KGlk1roZ9Czk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVMfEkT723Lnwh/XF7IkU7FhJK1nzFouEtJ6FsV1GrMI5jnOKWgxkScL1quuNc9dY
         ybv2Cj24z8N9hPOvuyzRjABdLecVadIB7Zuwv1U10r2e2bTEDJvr5qBTvMawHR/ZRY
         g/xSsvW/Qw5YFF8UYa8KW5XJn+oPY7aweXYieWlY1Z0bNBmqz6lLQWv2S38tcrG63t
         h2aAOkO+ANA2LfW/mz7AeucRexyd8fJSKz3+owrhaMh/ApUZic2vbXtqXIR5KFEkMz
         debrCxk4z8FoQwJ6t0nOAkm2yfV/CC2hMPh4tR3C8T+0ii5W4dwtAUqNVofH55IPd/
         Xkj4KKF6GF+ug==
Date:   Wed, 4 Jan 2023 13:59:13 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] generic: update setgid tests
Message-ID: <20230104125913.ziqie73mc7paiz32@wittgenstein>
References: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
 <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:53:56AM +0100, Miklos Szeredi wrote:
> On Wed, 4 Jan 2023 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Over mutiple kernel releases we have reworked setgid inheritance
> > significantly due to long-standing security issues, security issues that
> > were reintroduced after they were fixed, and the subtle and difficult
> > inheritance rules that plagued individual filesystems. We have lifted
> > setgid inheritance into the VFS proper in earlier patches. Starting with
> > kernel v6.2 we have made setgid inheritance consistent between the write
> > and setattr (ch{mod,own}) paths.
> >
> > The gist of the requirement is that in order to inherit the setgid bit
> > the user needs to be in the group of the file or have CAP_FSETID in
> > their user namespace. Otherwise the setgid bit will be dropped
> > irregardless of the file's executability. Change the tests accordingly
> > and annotate them with the commits that changed the behavior.
> >
> > Note, that only with v6.2 setgid inheritance works correctly for
> > overlayfs in the write path. Before this the setgid bit was always
> > retained.
> 
> Shouldn't the test ignore sgid without group execute instead?   It's
> not a security issue and expecting a certain value is not going to
> help find real issues (e.g. in old distro kernels, where this test
> will now start failing).

Yeah, I would be fine with just leaving the group-exec and all-exec
tests 10 and 12 and dropping tests 9 and 11.

> 
> Yeah, doing that is more involved, but I do believe that it would be
> the right way to go.

Just asking so I'm not missing a subtlety you're thinking of: why would
this be more involved? Seems easier to me even.
