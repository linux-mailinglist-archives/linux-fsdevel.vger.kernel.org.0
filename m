Return-Path: <linux-fsdevel+bounces-31703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4299A411
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F34281275
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43032178EB;
	Fri, 11 Oct 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rQ771CiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C32178F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650339; cv=none; b=hNobYpiAH0aXMMlyI7czrO3L/gJVnqnysr3XMxj8tkww3ZV19USKNQkehOQChYMWDrgeiJSiDrr4A/iEW/CUa0c3SSwycszLoemZorC05stll2J27MGIUvTL4DS6xrCgs8D+85d6idsUZ+6GlbTMai6wXkmZeGlG3wpxtmU6IAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650339; c=relaxed/simple;
	bh=MHOjzrUYLVcXDaO1SFFuif6X9lEzDQLQU8rL7K6XTnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWGKtWiIosQIyEB1t1qKZsEYwGDVOKxqO8n3YR26s6V1nQLPfd5CVAH/FlEhapuS1Ds2VwWGyz183NfvVsEgR2idCMUf+sg8lN6M5lpOilb6CkoY2Uz4ZaSnxLB2pGNi4d0j2Kj/QizoPbQ76jXKMZd934vpgVSo98ucZLv/J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rQ771CiR; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ5ld4hBkzm2d;
	Fri, 11 Oct 2024 14:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728650333;
	bh=YaVtQnc6mbIiONxg+8gg3YONHFrtLTIDXq9ZqDN4GPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ771CiR0WOfkPm2nZu6uT3+Fo3GXLTQUsRpBEC/ylTfiFq2eiLSAKKXjVKI4drPP
	 D2Hc+NzfeVUe9fa6vuzy8uJ18QIx1H/JGHdKVcSd0w21lLG0vzCC7t7SSavVmmwjWe
	 hZ0INWXRy6VIBwEm3nLW46NJ6cKCViuSjnZ58QPw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ5lc5FFrzs8q;
	Fri, 11 Oct 2024 14:38:52 +0200 (CEST)
Date: Fri, 11 Oct 2024 14:38:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Subject: Re: [PATCH RFC v1 4/7] integrity: Fix inode numbers in audit records
Message-ID: <20241011.upah1Ek3faiB@digikod.net>
References: <20241010152649.849254-4-mic@digikod.net>
 <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
 <20241011.Eigh6nohChai@digikod.net>
 <370204a3fbceef1bebfdcfc136beed98a3ca0229.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <370204a3fbceef1bebfdcfc136beed98a3ca0229.camel@huaweicloud.com>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 01:34:39PM +0200, Roberto Sassu wrote:
> On Fri, 2024-10-11 at 12:15 +0200, Mickaël Salaün wrote:
> > On Thu, Oct 10, 2024 at 09:20:52PM -0400, Paul Moore wrote:
> > > On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > > 
> > > > Use the new inode_get_ino() helper to log the user space's view of
> > > > inode's numbers instead of the private kernel values.
> > > > 
> > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > ---
> > > >  security/integrity/integrity_audit.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Should we also need to update the inode value used in hmac_add_misc()?
> > 
> > I'm not sure what the impact will be wrt backward compatibility. Mimi,
> > Roberto?
> 
> Changing the inode number the HMAC was calculated with has the
> potential effect of making the file inaccessible.
> 
> In order to use the new inode number, we need to define a new EVM xattr
> type, and update the previous xattr version with the new one. We could
> deprecate the old xattr version after a while (to be discussed with
> Mimi).

That was my though.  I don't we should patch hmac_add_misc() because it
is already in the IMA/EVM ABI and not directly reflected to user space.
The issue might be that user space cannot recreate this hmac because
this private inode number is not known to user space, but I don't know
if there is such user space implementation of IMA/EVM.

> 
> Roberto
> 
> > > 
> > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > > index 7c06ffd633d2..68ae454e187f 100644
> > > --- a/security/integrity/evm/evm_crypto.c
> > > +++ b/security/integrity/evm/evm_crypto.c
> > > @@ -155,7 +155,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
> > >          * signatures
> > >          */
> > >         if (type != EVM_XATTR_PORTABLE_DIGSIG) {
> > > -               hmac_misc.ino = inode->i_ino;
> > > +               hmac_misc.ino = inode_get_ino(inode->i_ino);
> > >                 hmac_misc.generation = inode->i_generation;
> > >         }
> > >         /* The hmac uid and gid must be encoded in the initial user
> > > 
> > > --
> > > paul-moore.com
> 
> 

