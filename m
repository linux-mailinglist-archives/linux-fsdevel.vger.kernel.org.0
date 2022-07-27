Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2F582724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiG0Mzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiG0Mzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:55:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63241D0D6;
        Wed, 27 Jul 2022 05:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 682D1B82153;
        Wed, 27 Jul 2022 12:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C7DC433C1;
        Wed, 27 Jul 2022 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658926538;
        bh=Ueocz9L79rTNSAstAjmwQKxxm/QmHSKhgtyMys5mMjg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lLOmrHGky8Jzx6KZ2PxRk0xU8qkIXWRfnk2nXdp4DI+g2cJwFwSr3/Gw3OX5ZgYRd
         pnnPuuJvt9EPT2X8Z2WQ/HIe5ZS1M4/xLlyoPukzznfbPOB2wnG8DdNqunxIiVvRAq
         9BokZvmSvlrgm1YGvMfwZAdjHRnzsQc9debL60uX2+KnhtdUc6/qZFNU7SDZ+zwDac
         vokKiQWOwpNTOyn979afK4u9SxFqJMFWeSbhLt/Kk8t/MuewV5tTU5LVZYsFjJDB1G
         JRGZ0Xq+Nm9pOtQ53n1jDBjptPGqPlvKatW6+0riZXXpT2Sa3HLRmh0jB8X3/9Dg8r
         Mr2PYeZDVxZMQ==
Message-ID: <82064e83752ee731909f4782ba85bad428ad180b.camel@kernel.org>
Subject: Re: [PATCH] vfs: bypass may_create_in_sticky check if task has
 CAP_FOWNER
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Date:   Wed, 27 Jul 2022 08:55:35 -0400
In-Reply-To: <20220727123710.tzg44xojlc3pmsiw@wittgenstein>
References: <20220727123048.46389-1-jlayton@kernel.org>
         <20220727123710.tzg44xojlc3pmsiw@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-27 at 14:37 +0200, Christian Brauner wrote:
> On Wed, Jul 27, 2022 at 08:30:48AM -0400, Jeff Layton wrote:
> > NFS server is exporting a sticky directory (mode 01777) with root
> > squashing enabled. Client has protect_regular enabled and then tries to
> > open a file as root in that directory. File is created (with ownership
> > set to nobody:nobody) but the open syscall returns an error.
> >=20
> > The problem is may_create_in_sticky, which rejects the open even though
> > the file has already been created/opened. Bypass the checks in
> > may_create_in_sticky if the task has CAP_FOWNER in the given namespace.
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1976829
> > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/namei.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1f28d3f463c3..170c2396ba29 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1230,7 +1230,8 @@ static int may_create_in_sticky(struct user_names=
pace *mnt_userns,
> >  	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> >  	    likely(!(dir_mode & S_ISVTX)) ||
> >  	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
> > -	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
> > +	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
> > +	    ns_capable(mnt_userns, CAP_FOWNER))
> >  		return 0;
>=20
> Hm, no. You really want inode_owner_or_capable() here..
> You need to verify that you have a mapping for the inode->i_{g,u}id in
> question and that you're having CAP_FOWNER in the caller's userns.
>=20

Ok, I should be able to make that change and test it out.

> I'm pretty sure we should also restrict this to the case were the caller
> actually created the file otherwise we introduce a potential issue where
> the caller is susceptible to data spoofing. For example, the file was
> created by another user racing the caller's O_CREAT.

That won't be sufficient to fix the testcase, I think. If a file already
exists in the sticky dir and is owned by nobody:nobody, do we really
want to prevent root from opening it? I wouldn't think so.

--=20
Jeff Layton <jlayton@kernel.org>
