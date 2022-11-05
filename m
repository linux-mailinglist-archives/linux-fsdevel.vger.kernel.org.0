Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC261D9B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 12:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKELeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKELeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB71C920;
        Sat,  5 Nov 2022 04:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605AA6090C;
        Sat,  5 Nov 2022 11:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2C0C433C1;
        Sat,  5 Nov 2022 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667648058;
        bh=aPsJ3tPFbBeVu0/xlG/SDWoFVAR10XjI3Pny8nFp4Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge1IBemhCv5y08Wrwf4NxCP6bAOsPR9ni3XQewsRVIwYdWi6elB1rVNo5SeQi+1zB
         rdEFlB4/2hxMSxuxwKlmfzBEx/b2J6bQY48QIatyALeY/PbEBaHPwWk129YwpoOAng
         ayv9fDqouoMW/qGUv5yWI+Rl7jh91XAz1XMdovXCPm9l1WGQhclND/dUYU3xfjAO2+
         jTQuYbEffCX1uewcyGJreNWvKtsdn3mC9d3SKGd6pKtkwxy77vN4KvalV2SDxFq0A3
         1Z6i7Lzl3vz2AQWE813ydHwy/X0pm6BHbe9FkGftrzlYGqqDlOD1Ialy3xcxSW0Y09
         63ibkXBdWCbBg==
Date:   Sat, 5 Nov 2022 12:34:13 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in
 simple_xattr_list()
Message-ID: <20221105113413.lzgwdlcobmliq32b@wittgenstein>
References: <20221103151205.702826-1-omosnace@redhat.com>
 <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:38:57AM -0400, Paul Moore wrote:
> On Thu, Nov 3, 2022 at 11:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The check being unconditional may lead to unwanted denials reported by
> > LSMs when a process has the capability granted by DAC, but denied by an
> > LSM. In the case of SELinux such denials are a problem, since they can't
> > be effectively filtered out via the policy and when not silenced, they
> > produce noise that may hide a true problem or an attack.
> >
> > Checking for the capability only if any trusted xattr is actually
> > present wouldn't really address the issue, since calling listxattr(2) on
> > such node on its own doesn't indicate an explicit attempt to see the
> > trusted xattrs. Additionally, it could potentially leak the presence of
> > trusted xattrs to an unprivileged user if they can check for the denials
> > (e.g. through dmesg).
> >
> > Therefore, it's best (and simplest) to keep the check unconditional and
> > instead use ns_capable_noaudit() that will silence any associated LSM
> > denials.
> >
> > Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> > Reported-by: Martin Pitt <mpitt@redhat.com>
> > Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v1 -> v2: switch to simpler and better solution as suggested by Christian
> >
> > v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/
> >
> >  fs/xattr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> VFS folks, this should really go through a vfs tree, but if nobody
> wants to pick it up *and* there are no objections to the change, I can
> take this via the LSM tree.

I can pick this up as I'm currently massaging the simple xattr
infrastructure. I think the fix is pretty straightforward otherwise.

Christian
