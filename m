Return-Path: <linux-fsdevel+bounces-11049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24813850447
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 12:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34BE286E75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 11:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808B3D551;
	Sat, 10 Feb 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PdXBtEFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDYzjXhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC713AC01;
	Sat, 10 Feb 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707565856; cv=none; b=BrHvRAjYbbU91owH2vmYXR1F7uFHn8bSNJuCqbn+BO5vwcP9uMu2YcJpcBapBEUCqK0wXsAo+zD4mb2HYeGWJKd1mm7TjInhuMSu4QJoQYtpeHMpbSOKwJpLxKqWbVSJOW8YJcp28GHMj+xTEpwKrSQpR6e0zwsQVeNtzye5YF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707565856; c=relaxed/simple;
	bh=3dET8an5Gz1SS9FXD5hxaVyn7YwxJMF0vmAH6cqPKSo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lZGJUSgy0XtNEkfQvFCrBF1i6y02NezZCchPKshgXTEuHVAn13zQm/9jTk2l4TP+Arw42SZOlxe8Yl8Q+CW0lWPln2Cp6iOzV1GmBxbDfxH3qyD87figwed3Hwp0pcCwa33ez40Tsljf687cWMyDWVYz8+epXOO/kc14TMZpP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PdXBtEFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wDYzjXhC; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4EAFA3200AB8;
	Sat, 10 Feb 2024 06:50:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 10 Feb 2024 06:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707565852;
	 x=1707652252; bh=GYCupbwc9/Vzg4u4JrBBtaVznNlOVVB07ME4hlvX4ls=; b=
	PdXBtEFRl2P1LTgI9BVcd+JrhaFei/qqGk3M0suapdGx6DyGmV6OD4mnkvZKn/qT
	YKfAuyyS0iAo3HVd9isAvkwTFHDsjOHSnPCW++XIpySrL0tq2U90Vd3mfBJiCNat
	DR3xEgbmsmLk2h/s+7kv0fSQYvY7d4GKhT5O46QKHEczkAzEEKQ/mp9LXWuR6aLA
	1AuWc3If2JRCl+j3N+o5zelp6p6e5mu7ZpYKMjVy+laOWmXdMNgeYpbXkXxKfwuX
	97yXdYhzV2ZjVXljrhXbfe+j0jmMXUgclRAml6FJ6jEbE4yBL+xhCiKL4oq3X1+W
	aSYNzFj42Z14ywTtzvfbEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707565852; x=
	1707652252; bh=GYCupbwc9/Vzg4u4JrBBtaVznNlOVVB07ME4hlvX4ls=; b=w
	DYzjXhCOORoDpA6WbFTB7ugE94QUIPg1iN0YC5vmVgJ4FBetMEPVN6OAJInu8PFi
	rBJ1wK3QMoEKrfhGTFDVJUPZt8Tt4E4YcfnvQ9rg0KKAJm1Hq6An/V4SOCPaBl7Q
	O72S1rYqQz1x4gj+aZSyyrBPwboaXIB604pqp+/Ng1PYJBa78IuHaFy78p28TIU7
	77/I41+e32RpEeX11QUoeM41tlMLhmjVHOldpE+r3I50fZjTmrGpORNdqU5vMnp0
	SFyelLNTsUldQqeegqarCb/75NaEvBju86W/gMefzxjinHcxPD6mvC+QiBc9K3a4
	hQ9WnpQaMBK/5aArxXSGw==
X-ME-Sender: <xms:G2PHZbxqGMuJaJNg07f5mnNK_5Ruzi4wGfE5knOg8yy3tPYoSx7DJw>
    <xme:G2PHZTR2kB5JxUP_G_3C8-VgSD3t8iL18Lrf4O4roV90kz-AHRMkHRfh0w0Ofv5HS
    Nqm5etZzO6_HDzWKes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:G2PHZVVkBdWD4syOaBF7K2jURlethordOBytIbUNPWrCQqcaJpwUwQ>
    <xmx:G2PHZViCrwT0j6AwscCMmHgGo9A8Q9dRLkYe6Hu5VukSBYcW8O8FXA>
    <xmx:G2PHZdBTOWO8PUeAyeLkAvsY9beRA3EYZ7rC5-1Py0FNCLUPiop9PA>
    <xmx:HGPHZR563C78BpyRyXOM2fraMP1q2ZL3N7IwajjMXgtT9wsPjTWsWQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C537DB6008D; Sat, 10 Feb 2024 06:50:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <036db535-587a-4e1b-bd44-345af3b51ddf@app.fastmail.com>
In-Reply-To: <ZcdYrJfhiNEtqIEW@google.com>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com> <ZcdYrJfhiNEtqIEW@google.com>
Date: Sat, 10 Feb 2024 12:49:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Xu" <jeffxu@google.com>,
 "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024, at 12:06, G=C3=BCnther Noack wrote:
> On Fri, Feb 09, 2024 at 06:06:05PM +0100, G=C3=BCnther Noack wrote:
>
> The IOCTL command in question is FIONREAD: fs/ioctl.c implements
> FIONREAD directly for S_ISREG files, but it does call the FIONREAD
> implementation in the VFS layer for other file types.
>
> The question we are asking ourselves is:
>
> * Can we let processes safely use FIONREAD for all files which get
>   opened for the purpose of reading, or do we run the risk of
>   accidentally exposing surprising IOCTL implementations which have
>   completely different purposes?
>
>   Is it safe to assume that the VFS layer FIONREAD implementations are
>   actually implementing FIONREAD semantics?
>
> * I know there have been accidental collisions of IOCTL command
>   numbers in the past -- Hypothetically, if this were to happen in one
>   of the VFS implementations of FIONREAD, would that be considered a
>   bug that would need to get fixed in that implementation?

Clearly it's impossible to be sure no driver has a conflict
on this particular ioctl, but the risk for one intentionally
overriding it should be fairly low.

There are a couple of possible issues I can think of:

- the numeric value of FIONREAD is different depending
  on the architecture, with at least four different numbers
  aliasing to it. This is probably harmless but makes it
  harder to look for accidental conflicts.

- Aside from FIONREAD, it is sometimes called SIOCINQ
  (for sockets) or TIOCINQ (for tty). These still go
  through the same VFS entry point and as far as I can
  tell always have the same semantics (writing 4 bytes
  of data with the count of the remaining bytes in the
  fd).

- There are probably a couple of drivers that do something
  in their ioctl handler without actually looking at
  the command number.

If you want to be really sure you get this right, you
could add a new callback to struct file_operations
that handles this for all drivers, something like

static int ioctl_fionread(struct file *filp, int __user *arg)
{
     int n;

     if (S_ISREG(inode->i_mode))
         return put_user(i_size_read(inode) - filp->f_pos, arg);

     if (!file->f_op->fionread)
         return -ENOIOCTLCMD;

     n =3D file->f_op->fionread(filp);

     if (n < 0)
         return n;

     return put_user(n, arg);
}

With this, you can go through any driver implementing
FIONREAD/SIOCINQ/TIOCINQ and move the code from .ioctl
into .fionread. This probably results in cleaner code
overall, especially in drivers that have no other ioctl
commands besides this one.

Since sockets and ttys tend to have both SIOCINQ/TIOCINQ
and SIOCOUTQ/TIOCOUTQ (unlike regular files), it's
probably best to do both at the same time, or maybe
have a single callback pointer with an in/out flag.

       Arnd

