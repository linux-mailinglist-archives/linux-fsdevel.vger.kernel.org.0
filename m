Return-Path: <linux-fsdevel+bounces-21336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9A902261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B51F23D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231B823CB;
	Mon, 10 Jun 2024 13:05:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD57F490;
	Mon, 10 Jun 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024743; cv=none; b=mms4yZnzUBSpJ8CZAqPmBrzFLlqPfkdY71YuM5QYKySHbNfUwWUixQm4MXt32bbSTgnS/bUmwNjJyROVcGKQlWUUcosHTNOKCsaE5xZWVB1PYBMoHkxMQk5+zocKlLHFnUir0FqpkE37b1JsbIE2xPYMGwNY6S5QrdnKhOMIuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024743; c=relaxed/simple;
	bh=zJgbNNJw/GCorqly4uRVoGjpIM8ilgL2XnXXEjZD+mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG5uoGCetUBRtRAscEyI1apKbrL9wxS1gPmPJkcysCZRa1Kn1nIfYb7EImOqnBLtDa9eGnPF+uSu+2Rz9x6BUCzDkvHPf5vzwe2OmOrlsC0T1tgPQflXNc9YBYfRL6xdf6QD60gv7/DgPoVcnGimxOd++nnkyqitww6h7yi3F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4456B579; Mon, 10 Jun 2024 08:05:40 -0500 (CDT)
Date: Mon, 10 Jun 2024 08:05:40 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, brauner@kernel.org,
	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	KP Singh <kpsingh@kernel.org>,
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
Subject: Re: [PATCH v2 2/4] capabilities: Add securebit to restrict userns
 caps
Message-ID: <20240610130540.GC2193924@mail.hallyn.com>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-3-jcalmels@3xx0.net>
 <20240610023301.GA2183903@mail.hallyn.com>
 <svpbmv37f5n537seb3cfsylnlzi6ftuad4dqi5unoycylmcf7r@6knq7sibdw7w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <svpbmv37f5n537seb3cfsylnlzi6ftuad4dqi5unoycylmcf7r@6knq7sibdw7w>

On Mon, Jun 10, 2024 at 02:46:06AM -0700, Jonathan Calmels wrote:
> On Sun, Jun 09, 2024 at 09:33:01PM GMT, Serge E. Hallyn wrote:
> > On Sun, Jun 09, 2024 at 03:43:35AM -0700, Jonathan Calmels wrote:
> > > This patch adds a new capability security bit designed to constrain a
> > > task’s userns capability set to its bounding set. The reason for this is
> > > twofold:
> > > 
> > > - This serves as a quick and easy way to lock down a set of capabilities
> > >   for a task, thus ensuring that any namespace it creates will never be
> > >   more privileged than itself is.
> > > - This helps userspace transition to more secure defaults by not requiring
> > >   specific logic for the userns capability set, or libcap support.
> > > 
> > > Example:
> > > 
> > >     # capsh --secbits=$((1 << 8)) --drop=cap_sys_rawio -- \
> > >             -c 'unshare -r grep Cap /proc/self/status'
> > >     CapInh: 0000000000000000
> > >     CapPrm: 000001fffffdffff
> > >     CapEff: 000001fffffdffff
> > >     CapBnd: 000001fffffdffff
> > >     CapAmb: 0000000000000000
> > >     CapUNs: 000001fffffdffff
> > 
> > But you are not (that I can see, in this or the previous patch)
> > keeping SECURE_USERNS_STRICT_CAPS in securebits on the next
> > level unshare.  Though I think it's ok, because by then both
> > cap_userns and cap_bset are reduced and cap_userns can't be
> > expanded.  (Sorry, just thinking aloud here)
> 
> Right this is safe to reset, but maybe we do keep it if the secbit is
> locked? This is kind of a special case compared to the other bits.

I don't think it would be worth the extra complication in the
secbits code, and it's semantically very different from the
cap_userns.

> > > +	/* Limit userns capabilities to our parent's bounding set. */
> > 
> > In the case of userns_install(), it will be the target user namespace
> > creator's bounding set, right?  Not "our parent's"?
> 
> Good point, I should reword this comment.

