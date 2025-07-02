Return-Path: <linux-fsdevel+bounces-53639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC161AF158E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174E03B45B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F70526FA53;
	Wed,  2 Jul 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbuLl7NI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A43260592;
	Wed,  2 Jul 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459079; cv=none; b=lqXYjbVvWEE0JDfM4u025GaTAd0XkVUF0ZOnWLOOy/S6dHeH7UKKWT6/sM76hiHr2Hvnfq/n/C9+RbbIEsl7dNmMxZKDfUbvEg8+HUDyevI4FWGod/LkYL2t8y42WR60N8KdIdMsXw6f/WUoE7sUElEknqnNJShOjyLIZpPbWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459079; c=relaxed/simple;
	bh=+4g/O9KavdfNBDEeSgTgC6+6CMsSSnI/shhS+omw080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/Z+bAfZAX+IDdtj1XGib0r4XnIG0emmAr31eKjwZnMMKSfGJeFNGSI27tkxEqXaNaaTvKBZjHRcf+5SSiwxdr3iDUAWNPCXfhAdLAWOANrLSncJj8mFha4v4ztMcRjKGo0KuzjwUPxm+dg0spXcmDm7sgIKklpgTVxr6qq8pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbuLl7NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5D7C4CEED;
	Wed,  2 Jul 2025 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751459078;
	bh=+4g/O9KavdfNBDEeSgTgC6+6CMsSSnI/shhS+omw080=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbuLl7NIBnEYmnPsgKXjoq0qMYuLvGVLef1YLrQdw90i4COG97ap70uC43+frYYOu
	 Sd0O2rrR8wdT1adpP97yHioNjM2+K1/XvJpRuOAP2H2qhS9ZmwP5Rmqb5NnJqlmbVh
	 bKPQAq+P8vl+tMW2Vwnm1+Ow6FtjRpgWEKkB/UXdjyn53DE1IbZHylle0eJ+hjg5ls
	 6ysAJe0Ovr5Ua1oxVYn9soULYh2jXiW/TqCItj+2tPZrcA69U8KE+r/71ubdNmu+R0
	 resL4bBiogg/H4jipdni0N/OERFPyynRck/ckAZFilSAhmLSWI0DzJjJFcCjjwiBqm
	 fhMRCIGA23zlA==
Date: Wed, 2 Jul 2025 14:24:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Message-ID: <20250702-herzrasen-anlocken-d4971baeba1b@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
 <20250701183105.GP10009@frogsfrogsfrogs>
 <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>
 <20250701194002.GS10009@frogsfrogsfrogs>
 <20250701195405.xf27mjknu5bnunue@pali>
 <CAOQ4uxjZWGz2bqen4F+fkQqZYQjKyufFVky4tOTnwng4D5G4nQ@mail.gmail.com>
 <CAOQ4uxhrW--Du4XvSWficnRenv24U4hwnCQtNsH4F5d4jaPjFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhrW--Du4XvSWficnRenv24U4hwnCQtNsH4F5d4jaPjFg@mail.gmail.com>

> Christian,
> 
> Can you please amend the return value in the following chunk:
> 
> @@ -119,11 +120,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>                                   struct fsxattr __user *ufa)
>  {
>         struct fsxattr xfa;
> +       __u32 mask = FS_XFLAGS_MASK;
> 
>         if (copy_from_user(&xfa, ufa, sizeof(xfa)))
>                 return -EFAULT;
> 
> +       if (xfa.fsx_xflags & ~mask)
> +               return -EOPNOTSUPP;
> +

Done.

