Return-Path: <linux-fsdevel+bounces-31682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086F99A110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C742854CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70223210C31;
	Fri, 11 Oct 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="z2LRA7br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B74210C09
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641763; cv=none; b=POp6XQpWKkUGYba0syYlzjiFMhPg4qgVOfOMwSXpctSvsnmSshg0OiZowy/Ur4qqLL1ux/7W+ZUQe/V8u7infU1XsiZxt5kzGCak/p4jABE6sQvAGttpY4nzN2hhNUGGlSMQmenovveSkAt2ZnrqQam3r70TexoJ1O9unnRdPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641763; c=relaxed/simple;
	bh=zwQ70n0SSlfb/OyoAuBHTRaQ85w0aqqiMni4QYSsldE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVcQ70kLQ2+ulrwR4tGDeDB/+FUOCDeVqA6+dLmFUeJdKQyYC0p/g1IdzXB/ZakHr54yPmXzEsZeHe2/CGylJDpSSV9YFYV8iQ7I9S5doiZu2wV1yp3IW7qFv5Y9ZHPWKufOp9ikfTt5VVvYx9stvf1NZIf2qi5Xw1vEt1BqAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=z2LRA7br; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ2Zl3YX1zKH9;
	Fri, 11 Oct 2024 12:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728641759;
	bh=MdL4NDl3ZoA3WJAyXDtnvpK7cAFgEh48Z4dOPu54AiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z2LRA7brSb1Kk/IXKA1ZMnDCcKUfvGc9rQkT5FlMTCtTTLJAT4ZAwWp8rhnLgStek
	 LcOTpTeW6zTAfcrjenkFR2lSz9bBRfv9wcaZTgjMTz2JMqAbq3hRF7i3nLQAFtWfv5
	 wKAux4oujGNGPGkgsqnClYcjvp+6xjf9EpaQX4e8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ2Zk2PGPz8W0;
	Fri, 11 Oct 2024 12:15:58 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:15:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>
Subject: Re: [PATCH RFC v1 4/7] integrity: Fix inode numbers in audit records
Message-ID: <20241011.Eigh6nohChai@digikod.net>
References: <20241010152649.849254-4-mic@digikod.net>
 <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
X-Infomaniak-Routing: alpha

On Thu, Oct 10, 2024 at 09:20:52PM -0400, Paul Moore wrote:
> On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > 
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> > 
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/integrity/integrity_audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Should we also need to update the inode value used in hmac_add_misc()?

I'm not sure what the impact will be wrt backward compatibility. Mimi,
Roberto?

> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 7c06ffd633d2..68ae454e187f 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -155,7 +155,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
>          * signatures
>          */
>         if (type != EVM_XATTR_PORTABLE_DIGSIG) {
> -               hmac_misc.ino = inode->i_ino;
> +               hmac_misc.ino = inode_get_ino(inode->i_ino);
>                 hmac_misc.generation = inode->i_generation;
>         }
>         /* The hmac uid and gid must be encoded in the initial user
> 
> --
> paul-moore.com

