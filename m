Return-Path: <linux-fsdevel+bounces-832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9C7D1091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000B11C21005
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0501C2AC;
	Fri, 20 Oct 2023 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scrivano.org header.i=@scrivano.org header.b="f/Akho6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD011BDD4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:31:18 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 06:31:17 PDT
Received: from m32-12.eu.mailgun.net (m32-12.eu.mailgun.net [141.193.32.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF51A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 06:31:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=scrivano.org;
 q=dns/txt; s=email; t=1697808675; x=1697815875; h=Content-Transfer-Encoding:
 Content-Type: MIME-Version: Message-ID: In-Reply-To: Date: References:
 Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=H30MfQJ7jYcuOdi1JUAUJ6pywT2nj7wKmIdh5yZHems=;
 b=f/Akho6DGg+cUUdHnEzlWMOIonVTJ+57DCw3aFLxbY2Im8eggebXsHIaizL7h9xz3KEdDVEtQe7tt/780uY/dYAIdGOHuwlwB6DbG0Udt6xjv6bmSUWIWshR+o2OcVSWlUX4f1HxIV9jVJfNEWPdzrCxsLIdr2OXgT1cnkZol3LbHjOnR0drfAFbT5TlK006uRI2I42ooMCajRsOHYJRRMRAU2vYrpQ1V39rqV4ewRZnPE5vVZko5Fgc4SQImJ0hlNxz/AFDOda8COf22eOAlKUdd/o+ftW53vMvf6i0p0uf0Ez5ty033wdzfQbC/L7Nsb9KxbrDX3fYdUoDnqCCIQ==
X-Mailgun-Sending-Ip: 141.193.32.12
X-Mailgun-Sid: WyI4YjkwYSIsImxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnIiwiNmYxOGEiXQ==
Received: from localhost (93-38-24-113.ip68.fastwebnet.it [93.38.24.113]) by
 9bd0fe46fe11 with SMTP id 65327ff09361f864fc7dc614 (version=TLS1.3,
 cipher=TLS_AES_128_GCM_SHA256); Fri, 20 Oct 2023 13:26:08 GMT
Sender: giuseppe@scrivano.org
From: Giuseppe Scrivano <giuseppe@scrivano.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Jesse Hathaway
 <jesse@mbuki-mvuki.org>,  Christoph Hellwig <hch@lst.de>,  Florian Weimer
 <fweimer@redhat.com>,  Aleksa Sarai <cyphar@cyphar.com>,
  linux-fsdevel@vger.kernel.org,  Al Viro <viro@zeniv.linux.org.uk>,
  stable@vger.kernel.org,  Greg KH <gregkh@linuxfoundation.org>,  Linux
 regressions mailing list <regressions@lists.linux.dev>,
  giuseppe@scrivano.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
	<2023101819-satisfied-drool-49bb@gregkh>
	<CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
	<38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>
	<20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>
Date: Fri, 20 Oct 2023 15:26:07 +0200
In-Reply-To: <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner> (Christian
	Brauner's message of "Fri, 20 Oct 2023 13:01:44 +0200")
Message-ID: <878r7x77dc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> writes:

> On Fri, Oct 20, 2023 at 10:34:36AM +0200, Linux regression tracking (Thor=
sten Leemhuis) wrote:
>> [adding Christian, the author of what appears to be the culprit]
>>=20
>> On 18.10.23 20:49, Jesse Hathaway wrote:
>> > On Wed, Oct 18, 2023 at 1:40=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
>>=20
>> FWIW, this thread afaics was supposed to be in reply to this submission:
>>=20
>> https://lore.kernel.org/all/20230712-vfs-chmod-symlinks-v1-1-27921df6011=
f@kernel.org/
>>=20
>> That patch later became 5d1f903f75a80d ("attr: block mode changes of
>> symlinks") [v6.6-rc1, v6.5.5, v6.1.55, v5.4.257, v5.15.133, v5.10.197,
>> v4.19.295, v4.14.326]
>>=20
>> >>> Unfortunately, this has not held up in LTSes without causing
>> >>> regressions, specifically in crun:
>> >>>
>> >>> Crun issue and patch
>> >>>  1. https://github.com/containers/crun/issues/1308
>> >>>  2. https://github.com/containers/crun/pull/1309
>> >>
>> >> So thre's a fix already for this, they agree that symlinks shouldn't
>> >> have modes, so what's the issue?
>> >=20
>> > The problem is that it breaks crun in Debian stable. They have fixed t=
he
>> > issue in crun, but that patch may not be backported to Debian's stable
>> > version. In other words the patch seems to break existing software in
>> > the wild.
>> >=20
>> >> It needs to reverted in Linus's tree first, otherwise you will hit the
>> >> same problem when moving to a new kernel.
>> >=20
>> > Okay, I'll raise the issue on the linux kernel mailing list.
>>=20
>> Did you do that? I could not find anything. Just wondering, as right now
>> there is still some time to fix this regression before 6.6 is released
>> (and then the fix can be backported to the stable trees, too).
>
> I have not seen a report other than the crun fix I commented on.
>
> The crun authors had agreed to fix this in crun. As symlink mode changes
> are severly broken to the point that it's not even supported through the
> official glibc and musl system call wrappers anymore not having to
> revert this from mainline would be the ideal outcome.
>
> So ideally, the crun bugfix would be backported to Debian stable just as
> it was already backported to Fedora or crun make a new point release for
> the 1.8.* series.
>
> The other option to consider would be to revert the backport of the attr
> changes to stable kernels. I'm not sure what Greg's stance on this is
> but given that crun versions in -testing already include that fix that
> means all future Debian releases will already have a fixed crun version.
>
> That symlink stuff is so brittle and broken that we'd do more long-term
> harm by letting it go on. Which is why we did this.
>
> @Linus, this is ultimately your call of course.

my two cents as the crun maintainer:

We were messing with /proc/*/fd files to do something not supported.
The kernel patch made the error explicit instead of ignoring errors just
in some cases.

Since it was already fixed upstream in crun and the fix is included in
the last three releases, Debian could simply pick a newer version; or I
can help with a backport if that is what they prefer.

