Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43443736A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFTLMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjFTLMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7FA10FE;
        Tue, 20 Jun 2023 04:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C26611E2;
        Tue, 20 Jun 2023 11:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D894C433C0;
        Tue, 20 Jun 2023 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687259533;
        bh=48Q1ZvZWks9PL/vJ+2ghQX3YFsGy4B0LOKhH2s8OAiY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lAQamsTgFEzaPXSFzQljTEmdNDn4UuRICLZgEEuVC3CBhxynrKaamZgCDbzFRpUg1
         l7uUSdesVHquPyMRFYlV4RrZPDg0HLcXcGB/KyRtN44+N/JnFLZe5fz3BUJTPVVaz/
         9RY+X7oe9yci2dZNFdQVmFh5tOwd8Yn/gJU+7NjBYUCY6hboCYQZixQoJNNLtwAoLp
         +SPB8AmPCh+e2KBcQHmxg6EqsrNaN9hFMSlyws67yrSQO54bb97TFhP3KX4DmEZB7i
         r3/W0HIGggtrHAyEH7Uphw3glax5kLduey7UaXSYp4y20jZqU0ko9mql/5TZPTo71G
         oqhsbtPmlFdQA==
Message-ID: <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 07:12:12 -0400
In-Reply-To: <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-3-stsp2@yandex.ru>
         <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
         <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 15:57 +0500, stsp wrote:
> Hello,
>=20
> 20.06.2023 15:51, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, 2023-06-20 at 14:55 +0500, Stas Sergeev wrote:
> > > Currently F_OFD_GETLK sets the pid of the lock owner to -1.
> > > Remove such behavior to allow getting the proper owner's pid.
> > > This may be helpful when you want to send some message (like SIGKILL)
> > > to the offending locker.
> > >=20
> > > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> > >=20
> > > CC: Jeff Layton <jlayton@kernel.org>
> > > CC: Chuck Lever <chuck.lever@oracle.com>
> > > CC: Alexander Viro <viro@zeniv.linux.org.uk>
> > > CC: Christian Brauner <brauner@kernel.org>
> > > CC: linux-fsdevel@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > >=20
> > > ---
> > >   fs/locks.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 210766007e63..ee265e166542 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -2158,8 +2158,6 @@ static pid_t locks_translate_pid(struct file_lo=
ck *fl, struct pid_namespace *ns)
> > >   	pid_t vnr;
> > >   	struct pid *pid;
> > >  =20
> > > -	if (IS_OFDLCK(fl))
> > > -		return -1;
> > >   	if (IS_REMOTELCK(fl))
> > >   		return fl->fl_pid;
> > >   	/*
> > NACK on this one.
> >=20
> > OFD locks are not owned by processes. They are owned by the file
> > description (hence the name). Because of this, returning a pid here is
> > wrong.
>=20
> But fd is owned by a process.

No, it isn't.

fd's can be handed off between processes via unix descriptors.

Multithreaded processes are also a bit of a gray area here: Suppose I
open a file and set an OFD lock on it in one task, and then let that
task exit while the file is still open. What should l_pid say in that
case?

> PID has a meaning, you can send SIGKILL
> to the returned PID, and the lock is clear.
> Was there any reason to hide the PID at
> a first place?
>=20

Yes, because OFD locks are not tied to a pid in the same way that
traditional POSIX locks are.

>=20
> > This precedent comes from BSD, where flock() and POSIX locks can
> > conflict. BSD returns -1 for the pid if you call F_GETLK on a file
> > locked with flock(). Since OFD locks have similar ownership semantics t=
o
> > flock() locks, we use the same convention here.
> OK if you insist I can drop this one and
> search the PID by some other means.
> Just a bit unsure what makes it so important
> to overwrite the potentially useful info
> with -1.
>=20
> So in case you insist on that, then should
> I send a v2 or can you just drop the patch
> yourself?

--=20
Jeff Layton <jlayton@kernel.org>
