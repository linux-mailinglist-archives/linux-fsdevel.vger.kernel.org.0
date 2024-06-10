Return-Path: <linux-fsdevel+bounces-21333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117739021EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222811C20CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654B981AB4;
	Mon, 10 Jun 2024 12:49:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6A80639;
	Mon, 10 Jun 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023740; cv=none; b=HA7RpwOiX2asF24JlGR0cYQtEx5/202ujhFYFD7G5J6z2vNBsAxxn6+q7/O5c+trAWCQw/iCEB6cZHp0mbx2uzX2XysF/d2D/5EjfnL3wzy2KGZJ8uaZdeCEqWJwu6q4kQoPVMduIWKtyx+BZPbwKVCxEy1QzxsI0BgdMkgb4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023740; c=relaxed/simple;
	bh=c1EmVzZERqjSJs/SlkFG6bKIoC5k7IxAp0ghoFzDQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7hAryKAy3STYX5UC4MdgKTGw/0zxUngdadWGB99c81XMdU9AVWOkZ1YoJCosA44/AUTk0OLIyowZb7oAoEYFjTIceAUzS2KAe3/tdZH9hJPk5jCHHs4VoIA6RiFnVmsAUCwmGsy30/Mr/dY0m71W1iMqHdqRcI7enHEHUOXJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id EBF00579; Mon, 10 Jun 2024 07:48:55 -0500 (CDT)
Date: Mon, 10 Jun 2024 07:48:55 -0500
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
Message-ID: <20240610124855.GA2193924@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
 <20240610015024.GA2182786@mail.hallyn.com>
 <6pwskrbtmxjy2ti3xabfslmupjhat7dhrnbftinzhxgxnsveum@5jq5l6ws7hls>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6pwskrbtmxjy2ti3xabfslmupjhat7dhrnbftinzhxgxnsveum@5jq5l6ws7hls>

On Mon, Jun 10, 2024 at 01:47:13AM -0700, Jonathan Calmels wrote:
> On Sun, Jun 09, 2024 at 08:50:24PM GMT, Serge E. Hallyn wrote:
> > On Sun, Jun 09, 2024 at 03:43:34AM -0700, Jonathan Calmels wrote:
> > > Attackers often rely on user namespaces to get elevated (yet confined)
> > > privileges in order to target specific subsystems (e.g. [1]). Distributions
> > 
> > I'd modify this to say "in order to target *bugs* in specific subsystems" :)
> 
> Ack
> 
> > > This effectively mimics the inheritable set rules and means that, by
> > > default, only root in the user namespace can regain userns capabilities
> > > previously dropped:
> > 
> > Something about this last sentence feels wrong, but I'm not sure what
> > the best alternative would be.  As is, though, it makes it sound as though
> > root in the userns can always regain previously dropped capabilities, but
> > that's not true if dropped in ancestor ns, or if root also dropped the
> > bits from its bounding set (right?).
> 
> Right, the wording is a little bit confusing here I admit.
> What I meant to say is that if a cap is dropped in a *given* namespace,
> then it can only be regained by root there. But yes, caps can never be
> regained from ancestors ns. I'll try to rephrase it.
> 
> BTW, this is rather strict, but I think that's what we want right,

Yes,

> something simple? Alternative would be to have a new cap masked off by
> default, but if granted to a userns, allows you to regain ancestors
> caps.

we absolutely do not want to allow regaining caps dropped in an
ancestor namespace.

thanks,
-serge

