Return-Path: <linux-fsdevel+bounces-71969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2292CD8923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 242DA3001BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE94320A14;
	Tue, 23 Dec 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qGyLxkqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbHwabs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9E2B2D7;
	Tue, 23 Dec 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481848; cv=none; b=dG4CTXvoCG428wuVo04G5lysxWU/DQIe7p05m6pi8as4U8TKI0yfzV92px2R9LsBhhUre1F4aSht5LDfKadx+flZwMfLq6OVCrpP2Z6cbs2IsX5z0fi5Sf9qpa+JyvRIOvPLs6e8o8Qg8EFfl6cuRImmdv6a1hRsmz0iPC4XWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481848; c=relaxed/simple;
	bh=ZxnbK/tuSeva1q4H9fceVj5sBYXvnNUjIqXxeMk13jM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f7uEZuTkWqAZCsOonHSpKvzTjzVKSTfpdXxhgPEfSDfrdWkRddl9CqkEU7DlmYsx6x0tr58pDRTj3g0wUoEMNzLCOXJhHFouxmu2t7FRXBuwX+mBIF1C10Jy9v7g5FTDmlv7m799/UJf7IxF5B/9XAyEkRC5VnNRVVST7tpKJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qGyLxkqJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbHwabs3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C7BB1D0000C;
	Tue, 23 Dec 2025 04:24:04 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 23 Dec 2025 04:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766481844;
	 x=1766568244; bh=TLE/VjYuhddhKoJWz03DDnXY1C9LkKtH429uJ9zU2zk=; b=
	qGyLxkqJpfsG2e+TrmEccMxNebXxMJ1NGAhPG5je4MZRbrhjmb485oqp8KlaN1D+
	c9cBPtSFqAm0qu+EbJCo5SfIkf9EnyqySgCJVXuxmcOMxG5Awn/AZLaWCuPlmWE9
	uDguqAkQZHSL4AK3Kdx24nSCEEt+5O1nVTJjxH1Eq/yUv1fp/exRGNQeyqccI+te
	zkphPUMG9gGrsmnpQcATjqoYCUq6bzyuqZLMf/gUbFyNtrv75gOLRMjQFwAI6FiC
	c3zD42ZG4kanmrSj+o8Z+69HO7SAgCngmJRW5SwrWihzNukQ8mREk4T8dqlqA8Cd
	OFUXY3jP8E5i3mV1Xn9N6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766481844; x=
	1766568244; bh=TLE/VjYuhddhKoJWz03DDnXY1C9LkKtH429uJ9zU2zk=; b=S
	bHwabs3Wb11Ccy0Qn1hz04WRB/MeQCt8Dm9mUac82lfnlfOFELCqhz0TW8G2qqSD
	SpZhUXAoz88AwrRFqTE8Oos6+fhyZifbTI/sViPwWyoEEMXN0RXp88qgQ2oM9565
	SCm9FOwB3S8Y4pRWEx/AWglN8b45ld19/elNKkep0KyWZxmG3eL8PRd+tmCca8tT
	1lEJXPTuHS8rFC80X8NY//S0qTH4uduEJOTeSTqR5loxe3b/OdRx1tWMOKk3J9KC
	pILevi0V9nRC4ugxX55y+/Gf7kj0Mf6TlJFCfU+8lRkjwS5cdmUtRd8zQCHHg/pi
	a4QLzGKnBJFwxHngvfnlA==
X-ME-Sender: <xms:s19KadD_AT7YrilnQVxZvFF6m3tKfVd9YqaEbkiDnoHilGQYEc6OnQ>
    <xme:s19KaWWf_UF9Hrbf717JagYfegNPRh9AeEtMkEzFi2w17cOZtOJwfMDpC8BFOOkpc
    ysnUUBv7jEK42JwOrmjZSo7G03oapF7AcgsfKnT-8lGd4J8u80jYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehleeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeetfeduheevuddtuefgueevffeludehheefheffueejudelvdehiedvffelffejtden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvrhhnugessghssg
    gvrhhnugdrtghomhdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughird
    hhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:s19KaUM2b4Kkd7wnRK-1b4wtmaOnhBUMlbgAyY2qzTsfIJHWZEh6AA>
    <xmx:s19KaT6m2pccJ99Vix8lRba_MJv_NcIMhXFDQminZCvtMhu6OjSdBw>
    <xmx:s19KaW3E1XRMZ5EqXrHWrlZUe_9cQsNbnpsrg12Er0xNKxBFSAjTDQ>
    <xmx:s19KaczRa1_ih6UUVtv0d5lmeMt1fshfrLj_Nf13tz-K7qfDMu5oug>
    <xmx:tF9KaTafVmyp8n8OEyngsEmTkl5aF73BgZ_vZ6Q8gzHbvV3lZz4vo8o5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A1CD6700069; Tue, 23 Dec 2025 04:24:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFH8t3pChEx3
Date: Tue, 23 Dec 2025 10:23:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Bernd Schubert" <bernd@bsbernd.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <29077ea9-3c6a-442b-9f6d-493da6bf262d@app.fastmail.com>
In-Reply-To: 
 <20251223092253-6c03d7f4-04c7-4272-a4e8-9e38f41f4dad@linutronix.de>
References: <20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de>
 <e320ea3d-dd4d-4deb-81fe-aea41f648e31@bsbernd.com>
 <20251223092253-6c03d7f4-04c7-4272-a4e8-9e38f41f4dad@linutronix.de>
Subject: Re: [PATCH] fuse: uapi: use UAPI types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025, at 09:37, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Dec 22, 2025 at 10:16:39PM +0100, Bernd Schubert wrote:
>
> What about the following aproach:
>
> #if defined(__KERNEL__)
> #include <linux/types.h>
> #elif defined(__linux__)
> #include <linux/types.h>
> #else
> #include <stdint.h>
> typedef uint32_t __u32;
> ...
> #endif
>
> (borrowed from include/uapi/drm/drm.h, the identical #if/#elif branche=
s are
> necessary for unifdef.
>
> This works correctly when (cross-)compiling the kernel itself. It also=
 uses
> the standard UAPI types when used from Linux userspace and also works =
on
> non-Linux userspace. And the header can still be copied into libfuse a=
s is.

Yes, I think that may be the best we can do here. I was wondering whether
The above can be simplified into '#if defined(__KERNEL__) || defined(__l=
inux__'
but according to 00c9672606f7 ("drm: Untangle __KERNEL__ guards") it nee=
ds
to be two separate blocks.


Another header with the same problem is include/uapi/linux/coda.h,
which already has special cases for (at least) djgpp, cygwin and netbsd.
I have no idea if there is any hope of keeping that one generic and
while allowing it to be checked with nolibc. It looks like that one
has already diverged from the userspace version at
https://github.com/cmusatyalab/coda/blob/master/coda-src/kerndep/coda.h
which uses the c99 uint32_t instead of the BSD u_int32_t.

This hack got it to build with nolibc:

--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -114,6 +114,12 @@ typedef short                   int16_t;
 typedef unsigned short    u_int16_t;
 typedef int                 int32_t;
 typedef unsigned int      u_int32_t;
+typedef long long           int64_t;
+typedef unsigned long long u_int64_t;
+typedef u_int16_t      u_short;
+typedef unsigned long  u_long;
+typedef u_long ino_t;
+typedef void * caddr_t;
 #endif
=20
    Arnd

