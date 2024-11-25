Return-Path: <linux-fsdevel+bounces-35775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276119D8482
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ED316610B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CA18FDDB;
	Mon, 25 Nov 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgzdBuf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14610F7;
	Mon, 25 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534284; cv=none; b=XUVh9qFuPA1qoaIGjoF+7belg6eIUriB6Hec9goTY0hs3+cxYFnym6oFCQkNR41q/VgMMclFVstYnz83lrD5sAe9Pb4PKOFqWt9Y+sc/rTDEFUxlIM+YyRkQlYvr+NJThAm/jJ/4++Fe4WrVUPZWkIq9aCiyaCVVLinMYC0tsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534284; c=relaxed/simple;
	bh=9hJKJJYPLIrBQ+vYfIyHSAtFZ3S8XKYxSXw0zeY2XYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9VsRXi4lWlW4kxGB3Vh+IIfcr8AKBXPdw8e1yyKV4nzvOgPbo6QsJvzF0xPy4h5Ts04eU4HawmEOnXx4oTQxLmxdwpTtKF0A9Iq4/Rdg/RJKUVhytui9xWQRdU6/sFJFVt6CeOvmwzhkqDNE0MBuwJ5I0Ge4tzkc6vJvq637YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgzdBuf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B397C4CECE;
	Mon, 25 Nov 2024 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732534283;
	bh=9hJKJJYPLIrBQ+vYfIyHSAtFZ3S8XKYxSXw0zeY2XYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgzdBuf48rb0LrpH34QUDhFPe8FUeGdBwClCpSFNFHqgob0oTKki2tePlWcXYo8dO
	 HAZW8HbEib0mEW3Is6S+KheH/4zfkut1yvR9qmgaZ0xBUS03HQmMHgF5efN8naz7gz
	 xjqMbN1r1mK4VREdciCFUBWVFLtH0MiFVbGXWN423PXcpbhv3BmNOvz6wcqlxcuagB
	 7vBnRn4rzQtlW+WW+Ik01IBT6QegBPwZ2nqigcq55XThsv38H1CcAjRlj+7xah+Qj8
	 e7s/zc5mFBcn9mTUNNXi99yYnj62++CHgZLqtLTnpz8mvWIvpQFmPMqRoCDq8sinUH
	 na6IM+/TiyciA==
Date: Mon, 25 Nov 2024 12:31:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/26] target_core_configfs: avoid pointless cred
 reference count bump
Message-ID: <20241125-braumeister-dorfbewohner-9d1caf8f56a1@brauner>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-9-f352241c3970@kernel.org>
 <20241124182612.GW3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124182612.GW3387508@ZenIV>

On Sun, Nov 24, 2024 at 06:26:12PM +0000, Al Viro wrote:
> On Sun, Nov 24, 2024 at 02:43:55PM +0100, Christian Brauner wrote:
> > The creds are allocated via prepare_kernel_cred() which has already
> > taken a reference.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  drivers/target/target_core_configfs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> > index ec7a5598719397da5cadfed12a05ca8eb81e46a9..d102ab79c56dd7977465f7455749e6e7a2c9fba1 100644
> > --- a/drivers/target/target_core_configfs.c
> > +++ b/drivers/target/target_core_configfs.c
> > @@ -3756,10 +3756,9 @@ static int __init target_core_init_configfs(void)
> >  		ret = -ENOMEM;
> >  		goto out;
> >  	}
> > -	old_cred = override_creds(get_new_cred(kern_cred));
> > +	old_cred = override_creds(kern_cred);
> >  	target_init_dbroot();
> >  	put_cred(revert_creds(old_cred));
> > -	put_cred(kern_cred);
> 
> FWIW, I agree with Amir - 
>  	revert_creds(old_cred);
> 	put_cred(kern_cred);

Ok, done.

