Return-Path: <linux-fsdevel+bounces-13767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0C873A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B35B1C210BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51580605;
	Wed,  6 Mar 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="clGU/OFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cy92YTor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078D1EF1C;
	Wed,  6 Mar 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738358; cv=none; b=fSSDdPHeXhu8Qhuqn08dQ3nLAxDFxetXfsMa3VD+VzPzHScQhIAZj05CH6XbL4BVdYVNgrm7FrS2BbU2uctwrHue+K7+Oyqc5M4B2rqYBlysYuE+nkxbm45Kfe0p+8IaSSgNj03YZFr7FtUBKEeLgNLX+++wS7yRXdVmYc7LRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738358; c=relaxed/simple;
	bh=f+TDSr+XIaHaz0oSQ/iAhi2S0Quq8jl1leb5iAf+fIw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EDS7TURrpmutrT5mhok4yswuGJydXUOeN1yOr6CvbFPRYKrpxKmUjK3e+uYl33uvz7e5Bd4DGgM1Xjp4Dd8106XnIgQ03xquKU2GfOBQ+a852h6v0uS/jwxMt4LxPJToOXgtFzv9KjA72WzSt2v7SPOYs7J3BBeXhIzs7krJbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=clGU/OFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cy92YTor; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9392818000AA;
	Wed,  6 Mar 2024 10:19:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 10:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709738354;
	 x=1709824754; bh=5z53l5YZyT1JRwcbB0hXCVqeOpp7A9hrbEaesXr4t5k=; b=
	clGU/OFlXJz8LTnBqEgcergEqyxHBEV3y3nydnkBKMpNI/AT13HoYi1ENz1sWdAJ
	SxzrUEXxN4PCybHLnCGoAZch2bzWqhuQMyiSpRx8thRrAV0ELrrqhT0fjIZjnGWg
	H7XXo3QYuz/hLvtDu3wZjv6o29o0zJRDsZZzsUg3x7Vq++LgNdO7qSRgx8xkEOgW
	hNlowlxlbKUgeWx5SsfrXuZ812PB5V7HheXxBHhXwweWKIBT9upZyxS6ilYp2WbC
	hD7Prrlgy8lmjGS1gfkB5gO+v5DhOftAwr9xXHaLFiOeOIQmQ3RCr+j02E+6zNPc
	G7yTOWj+aPIxnMASUDb8HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709738354; x=
	1709824754; bh=5z53l5YZyT1JRwcbB0hXCVqeOpp7A9hrbEaesXr4t5k=; b=c
	y92YTorqFHF8gAaKdWzmHu2LFKLjWDqucCxpSbdE0NbLTJF76yj9VSfQF14xXarV
	KOd5y2VnYF00bJaqUsoHmoHaSs+R2gOGa+RWIq5/YykPjuyeKLYG71lSWRrfpSWK
	5CyViswlvHiO/sk3KRNO8/Yae/Z/R1YivHcFZgV9dQFanqK+dFFND3tXdG8aco7I
	22JT5vOBmOr8isUYWKs+91Tts4E3jFq5hOKQCer+5quSP98e04/w2kh6Ebv6lvlE
	M9QE5lGAzyc7mZRhhmXox+of/8vSUpvBUOls91Jjxv8nT+Cf+KIbHqVbF6ymfeKA
	KTPjcBPuHwLQD5VKdfOUw==
X-ME-Sender: <xms:cYnoZf9msN8LDmWA3naC5YVhBcpb-qmRS1rvvdqMOphUSWx1U5WvkA>
    <xme:cYnoZbsQrxdBOMArkSEhp8e4eM5gVLRwTc_riwurF7WsYws01jNIEXnkW3ekg0GrU
    BZUhOt-WXN1HyERIvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cYnoZdB5VuwHy-KKcxtNGkSFnEmZPA_b3Cdv2bmis5dfFkdpxLlOhA>
    <xmx:cYnoZbcp5kLoHcTz_I1GEb1YJlKLecqEKKugCpXEB66Kd_eQDJ599Q>
    <xmx:cYnoZUPxcai3hM6xNWn274Ep9xMSCOwdAJ8vhU699xnPNWgYAC0sCw>
    <xmx:conoZdlCDCa0vUG40g7JY-Ta4YmlNTg1g7eGj7YLQRluDl8eemtXUZ2Ae7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 52D03B6008F; Wed,  6 Mar 2024 10:19:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
In-Reply-To: <20240306.zoochahX8xai@digikod.net>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net> <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
Date: Wed, 06 Mar 2024 16:18:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Paul Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Jeff Xu" <jeffxu@google.com>, "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Mar 05, 2024 at 07:13:33PM +0100, G=C3=BCnther Noack wrote:
>> On Mon, Feb 19, 2024 at 07:35:39PM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:

>> > +	case FS_IOC_FSGETXATTR:
>> > +	case FS_IOC_FSSETXATTR:
>> > +	/* file_ioctl()'s IOCTLs are forwarded to device implementations.=
 */
>> > +		return true;
>> > +	default:
>> > +		return false;
>> > +	}
>> > +}
>> > +EXPORT_SYMBOL(vfs_masked_device_ioctl);
>>=20
>> [
>> Technical implementation notes about this function: the list of IOCTL=
s here are
>> the same ones which do_vfs_ioctl() implements directly.
>>=20
>> There are only two cases in which do_vfs_ioctl() does more complicate=
d handling:
>>=20
>> (1) FIONREAD falls back to the device's ioctl implemenetation.
>>     Therefore, we omit FIONREAD in our own list - we do not want to a=
llow that.

>> (2) The default case falls back to the file_ioctl() function, but *on=
ly* for
>>     S_ISREG() files, so it does not matter for the Landlock case.

How about changing do_vfs_ioctl() to return -ENOIOCTLCMD for
FIONREAD on special files? That way, the two cases become the
same.

>> I guess the reasons why we are not using that approach are performanc=
e, and that
>> it might mess up the LSM hook interface with special cases that only =
Landlcok
>> needs?  But it seems like it would be easier to reason about..?  Or m=
aybe we can
>> find a middle ground, where we have the existing hook return a specia=
l value
>> with the meaning "permit this IOCTL, but do not invoke the f_op hook"?
>
> Your security_file_vfs_ioctl() approach is simpler and better, I like
> it!  From a performance point of view it should not change much because
> either an LSM would use the current IOCTL hook or this new one.  Using=
 a
> flag with the current IOCTL hook would be a missed opportunity for
> performance improvements because this hook could be called even if it =
is
> not needed.
>
> I don't think it would be worth it to create a new hook for compat and
> non-compat mode because we want to control these IOCTLs the same way f=
or
> now, so it would not have a performance impact, but for consistency wi=
th
> the current IOCTL hooks I guess Paul would prefer two new hooks:
> security_file_vfs_ioctl() and security_file_vfs_ioctl_compat()?
>
> Another approach would be to split the IOCTL hook into two: one for the
> VFS layer and another for the underlying implementations.  However, it
> looks like a difficult and brittle approach according to the current
> IOCTL implementations.
>
> Arnd, Christian, Paul, are you OK with this new hook proposal?

I think this sounds better. It would fit more closely into
the overall structure of the ioctl handlers with their multiple
levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
you have the same structure for sockets and blockdev, and
then additional levels below that and some weirdness for
things like tty, scsi or cdrom.

>> And there is a scenario where this could potentially happen:
>>=20
>> do_vfs_ioctl() implements most things like this:
>>=20
>> static int do_vfs_ioctl(...) {
>> 	switch (cmd) {
>> 	/* many cases like the following: */
>> 	case FITHAW:
>> 		return ioctl_fsthaw(filp);
>> 	/* ... */
>> 	}
>> 	return -ENOIOCTLCMD;
>> }
>>=20
>> So I believe the scenario you want to avoid is the one where ioctl_fs=
thaw() or
>> one of the other functions return -ENOIOCTLCMD by accident, and where=
 that will
>> then make the surrounding syscall implementation fall back to vfs_ioc=
tl()
>> despite the cmd being listed as safe for Landlock?  Is that right?
>
> Yes

This does go against the normal structure a bit then, where
any of the commands is allowed to return -ENOIOCTLCMD specifically
for the purpose of passing control to the next level of
callbacks. Having the landlock hook explicitly at the
place where the callback is entered, as G=C3=BCnther suggested makes
much more sense to me then.

      Arnd

