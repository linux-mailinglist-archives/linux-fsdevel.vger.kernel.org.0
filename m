Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4682974003C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjF0QAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjF0QAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F330C3;
        Tue, 27 Jun 2023 09:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4DB611D3;
        Tue, 27 Jun 2023 16:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E3C433C8;
        Tue, 27 Jun 2023 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687881644;
        bh=+GcraKhz7wR5FRWp8QTf0ZwDivzumVRLKSa7P/eGsIw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e5+5HCCGTB5EGLosVGCU5hMoto93SkODqq6yF7s+u9fuK4Jf12AUUT23+Trak8vsS
         d6KnOTGBpBKdNhVCn9nJxu/iytXXt/DrlV6okVsFGkTpi5QL6+IBZmUs0341jrFtsF
         Ms/s7pJnLzQQEJNELj/uK6OIQ9onmVmBZAwYQTk7+S/rEVzk/V9GvZR3fG6ngYWdBh
         zy9c4hnYyZI209jCuE/AJGFQruSeTtH/eIEhfdk9FnqH5Jt3/ck4TNLgNHbPLVvv0b
         0fDkhFY3MeTQ+w0tko+CvyYhgRLA2QyYlEwcxLssYsAv0YyfmjnKYicj10USQzqVVi
         SJ3NMvKXt9DWw==
Message-ID: <51e756daf978ba61fbc15f209effac5daf59137a.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Date:   Tue, 27 Jun 2023 12:00:42 -0400
In-Reply-To: <0697f0d1-490b-6613-fea0-967a40861b25@yandex.ru>
References: <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
         <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
         <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
         <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
         <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
         <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
         <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
         <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
         <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
         <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
         <20230623-paranoia-reinschauen-329185eac276@brauner>
         <0697f0d1-490b-6613-fea0-967a40861b25@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-06-23 at 22:18 +0500, stsp wrote:
> 23.06.2023 20:25, Christian Brauner =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Jun 21, 2023 at 07:05:12AM -0400, Jeff Layton wrote:
> > > On Wed, 2023-06-21 at 15:42 +0500, stsp wrote:
> > > > 21.06.2023 15:35, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > > I don't think we can change this at this point.
> > > > >=20
> > > > > The bottom line (again) is that OFD locks are owned by the file
> > > > > descriptor (much like with flock()), and since file descriptors c=
an be
> > > > > shared across multiple process it's impossible to say that some s=
ingle
> > > > > process owns it.
> > > > What's the problem with 2 owners?
> > > > Can't you get one of them, rather than
> > > > meaningless -1?
> > > > Compare this situation with read locks.
> > > > They can overlap, so when you get an
> > > > info about a read lock (except for the
> > > > new F_UNLCK case), you get the info
> > > > about *some* of the locks in that range.
> > > > In the case of multiple owners, you
> > > > likewise get the info about about some
> > > > owner. If you iteratively send them a
> > > > "please release this lock" message
> > > > (eg in a form of SIGKILL), then you
> > > > traverse all, and end up with the
> > > > lock-free area.
> > > > Is there really any problem here?
> > > Yes. Ambiguous answers are worse than none at all.
> > I agree.
> >=20
> > A few minor observations:
> >=20
> > SCM_RIGHTS have already been mentioned multiple times. But I'm not sure
> > it's been mentioned explicitly but that trivially means it's possible t=
o
> > send an fd to a completely separate thread-group, then kill off the
> > sending thread-group by killing their thread-group leader. Bad enough a=
s
> > the identifier is now useless. But it also means that at some later
> > point that pid can be recycled.
> Come on.
> I never proposed anything like this.
> Of course the returned pid should be
> the pid of the current, actual owner,
> or one of current owners.
> If someone else proposed to return
> stalled pids, then it wasn't me.


Beyond all of this, there is a long history of problems with the l_pid
field as well with network filesystems, even with traditional POSIX
locks. What should go into the l_pid when a traditional POSIX lock is
held by a process on a separate host?

While POSIX mandates it, the l_pid is really sort of a "legacy" field
that is really just for informational purposes only nowadays. It might
have been a reliable bit of information back in the 1980's, but even
since the 90's it was suspect as a source of information.

Even if you _know_ you hold a traditional POSIX lock, be careful
trusting the information in that field.
--=20
Jeff Layton <jlayton@kernel.org>
