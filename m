Return-Path: <linux-fsdevel+bounces-21761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0019098D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB91C20EA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA294AECE;
	Sat, 15 Jun 2024 15:19:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE602179BC;
	Sat, 15 Jun 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464759; cv=none; b=ccHWVuY8eaYBZgGXgDVwgpIA8VACA7tIBgLwFwICFkUaWuOx5trAicMFg+s/6rZuooK6Mc0RtRH0MOCIAKMLGOocSXR5f5DAYeZreJxNePcvNWWAlaUr8JwtjeF5Zl4y9OKSfdHsUEkevgkjNa26zBdeP2ZPqOCl3sXvCVORMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464759; c=relaxed/simple;
	bh=1zDuwRl/lX9dBCJ3NnMtmQCVtCwygvYkw+bI7CIvKEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut4e2njVUCH0DSKaYG8avLBul5tEjQw1kMu77HZD7bB9AVQjkhBWI5DXNy2QoftBx4Q+GxEzA1HO52IQ4uIZsB5sCfCy4XpVStU5uIMi/wYtCSlm4/RcaZixtiifg7QGrtOkqZEl0aHyy1/Uch2kOy0uZxb63BxxWKXqIRyN4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B241C66D; Sat, 15 Jun 2024 10:19:08 -0500 (CDT)
Date: Sat, 15 Jun 2024 10:19:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andrew Morgan <morgan@kernel.org>,
	brauner@kernel.org, ebiederm@xmission.com,
	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>,
	John Johansen <john.johansen@canonical.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	containers@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] capabilities: Add user namespace capabilities
Message-ID: <20240615151908.GA44653@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
 <20240610130057.GB2193924@mail.hallyn.com>
 <o5llgu7tzei7g2alssdqvy4g2gn66b73tcsir3xqktfqs765ke@wyofd2abvdbj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o5llgu7tzei7g2alssdqvy4g2gn66b73tcsir3xqktfqs765ke@wyofd2abvdbj>

On Tue, Jun 11, 2024 at 01:20:40AM -0700, Jonathan Calmels wrote:
> On Mon, Jun 10, 2024 at 08:00:57AM GMT, Serge E. Hallyn wrote:
> > 
> > Now, one thing that does occur to me here is that there is a
> > very mild form of sendmail-capabilities vulnerability that
> > could happen here.  Unpriv user joe can drop CAP_SYS_ADMIN
> > from cap_userns, then run a setuid-root program which starts
> > a container which expects CAP_SYS_ADMIN.  This could be a
> > shared container, and so joe could be breaking expected
> > behavior there.
> > 
> > I *think* we want to say we don't care about this case, but
> > if we did, I suppose we could say that the normal cap raise
> > rules on setuid should apply to cap_userns?
> > 
> 
> Right, good catch. If we do want to fix it, we could just check for
> setuid no? Or do we want to follow the normal root inheritance rules
> too? Essentially something like this:
> 
> pU' = is_suid(root) ? X : pU

Yeah, I think that makes sense.  Thanks.

-serge

