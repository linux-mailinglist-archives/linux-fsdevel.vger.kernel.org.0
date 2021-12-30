Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB994817EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 01:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhL3Aq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Dec 2021 19:46:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhL3Aq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Dec 2021 19:46:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B961C615B8;
        Thu, 30 Dec 2021 00:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7FC36AE9;
        Thu, 30 Dec 2021 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640825186;
        bh=98eWbz1Wy4ptLli6ALaKAlJq7kZ1urcdjW/mQtAR0Fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1ZXE06RWOW18UExJ+S0kOGfu1G9EqNsU/Yf3gcwogRqJ2BnpUQOwDqCd3iMadQlGG
         emQGn1dXiVKQu9NsGMnVts/3aevxQnigpCD4kIgiLKteO/UTtcdkwbNNZ3/JGz0P7y
         Vs8AgCDpwWUB/U7beM+8Xawf5LsAEPFE8KI79JE0=
Date:   Wed, 29 Dec 2021 16:46:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        viro@zeniv.linux.org.uk, keescook@chromium.org, yzaikin@google.com,
        nixiaoming@huawei.com, ebiederm@xmission.com, steve@sk2.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] sysctl: move maxolduid as a sysctl specific const
Message-Id: <20211229164624.bbf08e1ed4350e97282344e2@linux-foundation.org>
In-Reply-To: <YcDYtcJG+ON1bowf@bombadil.infradead.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
        <20211129205548.605569-5-mcgrof@kernel.org>
        <d20861d0-8432-76d7-bcda-1b80401e0a22@digikod.net>
        <YcDYtcJG+ON1bowf@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Dec 2021 11:25:41 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:

> On Fri, Dec 17, 2021 at 05:15:01PM +0100, Micka=EBl Sala=FCn wrote:
> > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > index 7dec3d5a9ed4..675b625fa898 100644
> > > --- a/fs/proc/proc_sysctl.c
> > > +++ b/fs/proc/proc_sysctl.c
> > > @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_fi=
le_operations;
> > >   static const struct inode_operations proc_sys_dir_operations;
> > >   /* shared constants to be used in various sysctls */
> > > -const int sysctl_vals[] =3D { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, =
INT_MAX };
> > > +const int sysctl_vals[] =3D { -1, 0, 1, 2, 4, 100, 200, 1000, 65535,=
 INT_MAX };
> >=20
> > The new SYSCTL_MAXOLDUID uses the index 10 of sysctl_vals[] but the same
> > commit replaces index 8 (SYSCTL_THREE_THOUSAND used by
> > vm.watermark_scale_factor) instead of adding a new entry.
> >=20
> > It should be:
> > +const int sysctl_vals[] =3D { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, IN=
T_MAX,
> > 65535 };
>=20
> Can you send a proper patch which properly fixes this and identifies
> the commit name with a Fixes tag. Since thi sis on Andrew's tree no
> commit ID is required given that they are ephemeral.

I did this:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: sysctl-move-maxolduid-as-a-sysctl-specific-const-fix

fix sysctl_vals[], per Micka=EBl.

Cc: Micka=EBl Sala=FCn <mic@digikonet>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Antti Palosaari <crope@iki.fi>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lukas Middendorf <kernel@tuxforce.de>
Cc: Stephen Kitt <steve@sk2.org>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/proc_sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/proc_sysctl.c~sysctl-move-maxolduid-as-a-sysctl-specific-cons=
t-fix
+++ a/fs/proc/proc_sysctl.c
@@ -26,7 +26,7 @@ static const struct file_operations proc
 static const struct inode_operations proc_sys_dir_operations;
=20
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] =3D { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_M=
AX };
+const int sysctl_vals[] =3D { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MA=
X, 65535 };
 EXPORT_SYMBOL(sysctl_vals);
=20
 const unsigned long sysctl_long_vals[] =3D { 0, 1, LONG_MAX };
_

