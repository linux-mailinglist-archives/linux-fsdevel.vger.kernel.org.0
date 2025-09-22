Return-Path: <linux-fsdevel+bounces-62392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B3B91230
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D017AA476
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC5304BDF;
	Mon, 22 Sep 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnKWf3f9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D02F2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544459; cv=none; b=K9UMSWnhqyZ5y0YxZNEYhYrM9rqoEtWXR0CHCnMya+TxZ7sfqYAmdPesTwueGmt1ODyhSSn67/EXRTnXSD4LQ+TGcQsNPLFxidTY2Za/9hgjbdMNFaWAlR7U2EJW1bq1lrfz9WLdNpcF/zYEDXBgH+LOQN8JHhsX2n5V2//clp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544459; c=relaxed/simple;
	bh=ys4IEoI+fdLVxLUuxJrPv2vA1+IDivHuaUVkT1Fa8W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDUWDj+/tD6H2NUObAjn8E7dS2XyWW075igNUeyeY3gCxViFX73myvhwmnRXYD2B102KSgU1/fKmXljKeCLydyndA3ug238XB8mDgPNSAuhR1Bpi6Y5RC32PEg0+jc2gMG5DcnDM2ILy3HL+1NqRPlrtAJ1ui6ALbUshF6yTONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnKWf3f9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso2195975a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544453; x=1759149253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=NnKWf3f9JLbhDurAKtmSidZidQLjQDmIWh+dkaIsYa/dr6Ymul0jwcB94JBDpEIan+
         PzuxSyqXjGbc+8N9tvXJh5MN+aYar/g4CZBRuuTlVAKQq5oMsA1ap6zjJT6oWLZLmvr5
         KKkhYDYkBirLrmp0ZTGls6VGKDjesUzZksbbMTfibz5B8xgXgQL0wT9gRZxRUbowi6cT
         MhptO8yyTVzP5sJaSddSAMbAn3lAxL0C4eH7frcttexo3ZAinW9hpHq7tm0kEtokp4Cg
         rx3XZiwqEU8nHyHdmDj9R3tc3M36uyGN9Tpqpsq8qJSR20YxwjoDY5GohLiCQgNWV3yH
         +UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544453; x=1759149253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNq/C59VuTgRCn+nlqpjLe4b5aVpPSyRTgdZcEzYFpA=;
        b=eC37Gd8uvDrXqdtW16qKdp0IJZVOMyb90dODbfNXHAJM8eieFw/czPnkGfkEwNjXxa
         EXnGkY7xEl98gqVO7/CU9YoQfJEmkKzcP86nr4PCVINQJGX7g7w91DocqJKeNvQyFwV5
         JW+JCdNL9PUKRZ5rspC1JLjYV5qPjw8zVeh7HBCnUcGq63pr87U12+pS3uE1i5cey8FY
         R5xXobpttUjg/FnDo/HoQQOlfvblWlW+vwZTCsT4gwdL+6A7vNyO9onN6QYs/sVPA2Xg
         hUyubJwuljwUBOLkn86oJnAmSJFxEBA3hT+ERu1YBeXCd8K2bCHPZuwK+BfkBlw6qQDo
         ojGg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ecD0cBnx4w3U7yepJ68VTlRFe3Iri5zC4pZi4ALBxdrYlQ9BTnEvBn4VVyyYGdHG6ezR3D5khNJAvLND@vger.kernel.org
X-Gm-Message-State: AOJu0YzdTz+IhGbF2lT8ck8toF/VBWjp2MBw0o+ROAMqYIHPpscH1fl7
	pwe4sCNE300xTGXaZ0e8jZU6URBHG48kQnhqTVDLIl6/3DU80Pd78vL1C4mgc0PI6ICMQpmE9qP
	RwSvn/hmIZ+E0srF5BXuWnXr/3HfRkuW8Z2KA
X-Gm-Gg: ASbGncv6R0bznaryJk1vE46Kj1RFkHNL4as2siDDus+gZiyylisqVNWo+c3danvsZ7p
	7mLWziavHJXSC19tbbXG8grLwNHvoVGfkI/8ZHL65Qoc8l6vUFy9XvfuX1jUSaF6vxSTIXsGFJk
	9hyJC+R2BLYxCjG+n/J7FX2Bz8U8dh/r9t5qlCMM0C9HF2puvvJV65A9NjbKn8TZ8QothbA05ec
	DuWDmE=
X-Google-Smtp-Source: AGHT+IEPnzETHfIgVe8rbYGpffEitkgUY5tbApm7qiaC9l5Nc8ofRpUyTQPO48qxBeA4pIWC06Mh2wcCe4/H5YFHFPg=
X-Received: by 2002:a17:90b:3d0f:b0:32b:dfdb:b27f with SMTP id
 98e67ed59e1d1-33098246affmr18469898a91.17.1758544453556; Mon, 22 Sep 2025
 05:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV> <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk> <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV> <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
In-Reply-To: <CAHC9VhSJJ5YLXZbB-SvQket-PJCv81quM6XLrBDc7+erus-vhA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Sep 2025 08:34:02 -0400
X-Gm-Features: AS18NWDPYNiBNGWS7nxHqJa1sonTvXEysr_U_r4l4cLpOAIMmTBrwipP0XT2NVE
Message-ID: <CAEjxPJ4Ez1oYXa4hEcSLSrO+ikLN0kgrWQc+2n2K7wWoy7a7pQ@mail.gmail.com>
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, Sep 21, 2025 at 5:41=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> > On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
> > > > +       dput(dentry);
> > > > +       return dentry;  // borrowed
> > > >  }
> > >
> > > Prefer C style comments on their own line:
> > >
> > >   dput(dentry);
> > >   /* borrowed dentry */
> > >   return dentry;
> >
> > Umm...  IMO that's more of an annotation along the lines of "fallthru".=
..
>
> Maybe, I still prefer the example provided above.  The heart wants
> what the heart wants I guess.
>
> > > > @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_bloc=
k *sb, struct fs_context *fc)
> > > >                 goto err;
> > > >         }
> > > >
> > > > -       fsi->policycap_dir =3D sel_make_dir(sb->s_root, POLICYCAP_D=
IR_NAME,
> > > > +       dentry =3D sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
> > > >                                           &fsi->last_ino);
> > >
> > > I'd probably keep fsi->policycap_dir in this patch simply to limit th=
e
> > > scope of this patch to just the DCACHE_PERSISTENT related changes, bu=
t
> > > I'm not going to make a big fuss about that.
> >
> > Not hard to split that way.  Will do...
>
> Thanks.
>
> > BTW, an unrelated question: does userland care about selinuxfs /null be=
ing
> > called that (and being on selinuxfs, for that matter)?  Same for the
> > apparmor's securityfs /apparmor/.null...
>
> That's an interesting question.  The kernel really only references it
> in one place after creation, and as you've already seen, that's easily
> changed.  It's more important that it can be uniquely labeled such
> that most any process can open it, otherwise we run into problems when
> trying to replace fds when another file that the process can't open.
>
> I'm adding the SELinux list to tap into the folks that play with
> userland more than I do, but off the top of my head I can't think of
> why userspace would need to do anything directly with
> /sys/fs/selinux/null.  There are some comments in the userland code
> about not being able to mount selinuxfs with MS_NODEV due to the null
> device, but that's the only obvious thing I see while quickly
> searching through the code tonight.

Is there a reason why these patches weren't sent to selinux list in
the first place?
In any event, yes, Android userspace (in particular the Android init
program) relies on /sys/fs/selinux/null at a point where /dev/null
does not yet exist [1]. Hence, I don't believe we can drop it since it
would break userspace.

[1] https://cs.android.com/search?q=3D%2Fsys%2Ffs%2Fselinux%2Fnull&sq=3D&ss=
=3Dandroid%2Fplatform%2Fsuperproject%2Fmain


>
> > If nobody cares, I would rather add an internal-only filesystem with
> > root being a character device (1,3) and whatever markings selinux et.al=
.
> > need for it.  With open_devnull(creds) provided for selinux,
> > apparmor and whoever else wants to play with neutering descriptors
> > on exec...
>
> With the ongoing efforts to push towards better support for multiple
> simultaneous LSMs, we would likely need to make sure there each LSM
> that currently has their own null device would continue to have their
> own, otherwise we potentially run into permission conflicts between
> LSMs where one could end up blocking another and then we're back to
> not having a file to use as a replacement.  Not sure if that is what
> you had in mind with your proposal, but just wanted to make sure that
> was factored into the idea.
>
> --
> paul-moore.com
>

