Return-Path: <linux-fsdevel+bounces-15222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A348988AA57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589AA2A6468
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04F13BC32;
	Mon, 25 Mar 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RCcQHTY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBbIeN9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553C6BB29;
	Mon, 25 Mar 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380012; cv=none; b=MG0sUTkQPlQjNKRUsIWzjkBmMOCEY95ZeSYE6G8ojkyMYp4oCISariAYHVgrZ17PVbWJRx/wDWtC26Cn/0/Am8D0IYvfQrTl63QB/MLg3+RsqqSD9Aj7CTDXz8bO59yiPjMVBKH2WTqnr3y1cSOWN7IdNLUhTdyArXgJSjae0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380012; c=relaxed/simple;
	bh=oEQlhi8arM5cuE7dBJQ+u+v8GUiKwXIoSASHhFE7MKI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=N8YtQoDs7cVUcPFZ4VC9Fn1rxfluGFJKdk7EmLTY0hjWifMOt/bNhlvdjjwbr/F90btar72Z16ghB7JUkP5TSF2YA0XRZc6N1W2nsXI+QjW8mtjzWjq1TSaVMoYiE3N8VCtQ1NEG8fr7dyZNjGA68rFIvuJDEuzVdJkWWten/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RCcQHTY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBbIeN9E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 966FA13800AD;
	Mon, 25 Mar 2024 11:20:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 11:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711380009;
	 x=1711466409; bh=g770sXbK9Jbur01w9o0WTRWbVluhYx1p/FD0rMuaRVo=; b=
	RCcQHTY/jUNJBtskhQ25uUUooukTioOxM3umgzQbbnISKCtD6gTy6bOZms21WM5E
	egLKMW2rFNvN9Yscsjj3zn88WjYDICdyJBQFCyMWrCrsRTdsmx9DFE63GkZZYkL3
	Ncs4OIW5ZUtR//TsmIybekG+0U6fMeNF+mOYvNFxfm26e1RsBzDI8EktewAJvk4S
	+YfmzDNorLSN43H0ymh5m9OogEgFUEAJscHqoyyRiHM1gN13WN/OHyoPFn4FXMz6
	ltyKtkgsX9vq/mqgiPaYEfT1sDMi8dF0ELY80dVvQfIDgS6lkl3s6TM/aFxUJ97/
	cb1axyyxXZfvj5ci1Fnh4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711380009; x=
	1711466409; bh=g770sXbK9Jbur01w9o0WTRWbVluhYx1p/FD0rMuaRVo=; b=b
	BbIeN9EaCzfnelICp5g/6F33JNhFWiOuxaf37W1DZsDz3wJ0DqAGG4Up9kcJb7Mk
	bsJLngFWZgNpM+bnJigKIhAGILIt5/+4hIdzaTgTRT464aP5+bg1IvZ7APUajm4q
	w/H45wOIo8edO0rmQ7UdtP/Ot2pZ9o57Xy5eEn2vZ4j5b+clgjgEwTRSkI6CqJ50
	m6kg7hpez6vTuuyjmTasB63Kd2O0qym0EHaNiuk11KgAiXKysj9UQc0gXjlupjMa
	yyoHGcpX01ppQr1Y64d5ENLzxtnWe08tfYIObnfZaMaERUYAoEoEyjOb+zBmlPsH
	TBfbWVlCXi7pJRCQzZwqg==
X-ME-Sender: <xms:KZYBZshei6yJvw5iPfodpCynyDmGPQjZ0G2o1yfX7RW2TODWcMJTig>
    <xme:KZYBZlAn1cZEkPcnQi0E24-T4lf0NXM8AY8e53faILnlRTC_YWQMarHJtuPShIul4
    aozlmLTp1IGbXBvF10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KZYBZkH1M79uVAy4nM8giOKB-BL018GMRX6DpWuOLcqVi0WLk7iCkw>
    <xmx:KZYBZtQ-R9KeyVY6i4FSzI-lfTy2YlfS_DekLXo55KmpHCDdd9fEAw>
    <xmx:KZYBZpz8e4rurR7obZNBdCCbTgIGGz4oubQFa4tXERwSDLsdcG0b9w>
    <xmx:KZYBZr5SdQRC1wNJ7DVcreOznqMJv00KPTJ6Cpjzk0iD1x-WL07PhQ>
    <xmx:KZYBZspzzUg0xkNaKgHrHxJE0LRtvnE2CmOXVYXy4j3tpxXKWb0TjQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 204FAB6008F; Mon, 25 Mar 2024 11:20:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80221152-70dd-4749-8231-9bf334ea7160@app.fastmail.com>
In-Reply-To: <20240325134004.4074874-2-gnoack@google.com>
References: <20240325134004.4074874-1-gnoack@google.com>
 <20240325134004.4074874-2-gnoack@google.com>
Date: Mon, 25 Mar 2024 16:19:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Jeff Xu" <jeffxu@google.com>,
 "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for IOCTL
 hooks
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024, at 14:39, G=C3=BCnther Noack wrote:
> If security_file_ioctl or security_file_ioctl_compat return
> ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
> command, but only as long as the IOCTL command is implemented directly
> in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
> f_ops->compat_ioctl operations, which are defined by the given file.
>
> The possible return values for security_file_ioctl and
> security_file_ioctl_compat are now:
>
>  * 0 - to permit the IOCTL
>  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
>    back to the file implementation.
>  * any other error - to forbid the IOCTL and return that error
>
> This is an alternative to the previously discussed approaches [1] and =
[2],
> and implements the proposal from [3].

Thanks for trying it out, I think this is a good solution
and I like how the code turned out.

One small thing that I believe needs some extra changes:

> @@ -967,6 +977,11 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd,=20
> unsigned int, cmd,
>  		if (error !=3D -ENOIOCTLCMD)
>  			break;
>=20
> +		if (!use_file_ops) {
> +			error =3D -EACCES;
> +			break;
> +		}
> +
>  		if (f.file->f_op->compat_ioctl)
>  			error =3D f.file->f_op->compat_ioctl(f.file, cmd, arg);
>  		if (error =3D=3D -ENOIOCTLCMD)

The compat FIONREAD handler now ends up calling ->compat_ioctl()
where it used to call ->ioctl(). I think this means we need to
audit every driver that implements its own
FIONREAD/SIOCINQ/TIOCINQ to make sure it has a working compat
implementation.

I have done one pass through all such drivers and think the
change below should be sufficient for all of them, but please
have another look. Feel free to fold this change into your
patch. The pipe.c change also fixes an existing bug with=20
IOC_WATCH_QUEUE_SET_SIZE/IOC_WATCH_QUEUE_SET_FILTER, so that
may need to be a separate patch and get backported.

    Arnd

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..2e5b495a5606 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2891,6 +2891,7 @@ static long tty_compat_ioctl(struct file *file, un=
signed int cmd,
        int retval =3D -ENOIOCTLCMD;
=20
        switch (cmd) {
+       case TIOCINQ:
        case TIOCOUTQ:
        case TIOCSTI:
        case TIOCGWINSZ:
diff --git a/fs/pipe.c b/fs/pipe.c
index 50c8a8596b52..a6ebb351ea4b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -652,6 +652,14 @@ static long pipe_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
        }
 }
=20
+static long pipe_compat_ioctl(struct file *filp, unsigned int cmd, unsi=
gned long arg)
+{
+       if (cmd =3D=3D IOC_WATCH_QUEUE_SET_SIZE)
+               return pipe_ioctl(filp, cmd, arg);
+
+       return compat_ptr_ioctl(filp, cmd, arg);
+}
+
 /* No kernel lock held - fine */
 static __poll_t
 pipe_poll(struct file *filp, poll_table *wait)
@@ -1234,6 +1242,7 @@ const struct file_operations pipefifo_fops =3D {
        .write_iter     =3D pipe_write,
        .poll           =3D pipe_poll,
        .unlocked_ioctl =3D pipe_ioctl,
+       .compat_ioctl   =3D pipe_compat_ioctl,
        .release        =3D pipe_release,
        .fasync         =3D pipe_fasync,
        .splice_write   =3D iter_file_splice_write,
diff --git a/net/socket.c b/net/socket.c
index e5f3af49a8b6..bb4fa51fe4ca 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3496,6 +3496,7 @@ static int compat_sock_ioctl_trans(struct file *fi=
le, struct socket *sock,
        case SIOCSARP:
        case SIOCGARP:
        case SIOCDARP:
+       case SIOCINQ:
        case SIOCOUTQ:
        case SIOCOUTQNSD:
        case SIOCATMARK:

