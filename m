Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDE5827B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiG0N3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiG0N3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EC3AB16;
        Wed, 27 Jul 2022 06:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8727DB8200B;
        Wed, 27 Jul 2022 13:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4F9C433B5;
        Wed, 27 Jul 2022 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658928579;
        bh=RqDnTpQokIaXPiiGqAVTN0iGNn09ykWFc9ETGImEwwc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LE4Mav+vGrqrOEhngvh7P/82ID1fpJx+65Pj0iWljgnsvWF42sCvfmKX1JDpwcd5V
         mCCC3EBa0NOnIosAv4H4KLXta+ZvbnB34t3su/0uZO8fvuEXf7cXLfpx+cUhDTIMLt
         ZdZ46HtFgmc/uI2X6MV8+ZghuiaMND/R1sxx3ZkzpuDU1TQuhWyVu0kXsPCmD33LIQ
         szDLqQpQ48Wl+csARI2ecMYxPPQabRWoSA3JQuD+HKhyJIMtbdXTVLpx/L7v+3GFtz
         Eq4H9vv9MJmx6AdDKFrlZQAPJ+Y7j/NPaaoxV+sPFWYGafJDv/bq8cBICB3ACldkQ/
         gfAhgT2u/tIzQ==
Message-ID: <4085e655f6f22ab185f14cfb6a0c5dee9f12b55e.camel@kernel.org>
Subject: Re: [PATCH] vfs: bypass may_create_in_sticky check if task has
 CAP_FOWNER
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Date:   Wed, 27 Jul 2022 09:29:37 -0400
In-Reply-To: <20220727131649.v5iuvg2mitny2aci@wittgenstein>
References: <20220727123048.46389-1-jlayton@kernel.org>
         <20220727123710.tzg44xojlc3pmsiw@wittgenstein>
         <82064e83752ee731909f4782ba85bad428ad180b.camel@kernel.org>
         <20220727131649.v5iuvg2mitny2aci@wittgenstein>
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

On Wed, 2022-07-27 at 15:16 +0200, Christian Brauner wrote:
> On Wed, Jul 27, 2022 at 08:55:35AM -0400, Jeff Layton wrote:
> > On Wed, 2022-07-27 at 14:37 +0200, Christian Brauner wrote:
> > > On Wed, Jul 27, 2022 at 08:30:48AM -0400, Jeff Layton wrote:
> > > > NFS server is exporting a sticky directory (mode 01777) with root
> > > > squashing enabled. Client has protect_regular enabled and then trie=
s to
> > > > open a file as root in that directory. File is created (with owners=
hip
> > > > set to nobody:nobody) but the open syscall returns an error.
> > > >=20
> > > > The problem is may_create_in_sticky, which rejects the open even th=
ough
> > > > the file has already been created/opened. Bypass the checks in
> > > > may_create_in_sticky if the task has CAP_FOWNER in the given namesp=
ace.
> > > >=20
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1976829
> > > > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/namei.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 1f28d3f463c3..170c2396ba29 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -1230,7 +1230,8 @@ static int may_create_in_sticky(struct user_n=
amespace *mnt_userns,
> > > >  	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> > > >  	    likely(!(dir_mode & S_ISVTX)) ||
> > > >  	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
> > > > -	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
> > > > +	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
> > > > +	    ns_capable(mnt_userns, CAP_FOWNER))
> > > >  		return 0;
> > >=20
> > > Hm, no. You really want inode_owner_or_capable() here..
> > > You need to verify that you have a mapping for the inode->i_{g,u}id i=
n
> > > question and that you're having CAP_FOWNER in the caller's userns.
> > >=20
> >=20
> > Ok, I should be able to make that change and test it out.
> >=20
> > > I'm pretty sure we should also restrict this to the case were the cal=
ler
> > > actually created the file otherwise we introduce a potential issue wh=
ere
> > > the caller is susceptible to data spoofing. For example, the file was
> > > created by another user racing the caller's O_CREAT.
> >=20
> > That won't be sufficient to fix the testcase, I think. If a file alread=
y
> > exists in the sticky dir and is owned by nobody:nobody, do we really
> > want to prevent root from opening it? I wouldn't think so.
>=20
> Afaict, the whole stick behind the protected_regular thing in
> may_create_in_sticky() thing is that you prevent scenarios where you can
> be tricked into opening a file that you didn't intend to with O_CREAT.
>=20

Yuck. The proper way to get that protection is to use O_EXCL...

> That's specifically also a protection for root. So say root specifies
> O_CREAT but someone beats root to it and creates the file dumping
> malicious data in there. The uid_eq() requirement is supposed to prevent
> such attacks and it's a sysctl that userspace opted into.
>=20
> We'd be relaxing that restriction quite a bit if we not just allow newly
> created but also pre-existing file to be opened even with the CAP_FOWNER
> requirement.
>=20
> So the dd call should really fail if O_CREAT is passed but the file is
> pre-existing, imho. It's a different story if dd created that file and
> has CAP_FOWNER imho.

That's pretty nasty. So if I create a file as root in a sticky dir that
doesn't exist, and then close it and try to open it again it'll fail
with -EACCES? That's terribly confusing.

--=20
Jeff Layton <jlayton@kernel.org>
