Return-Path: <linux-fsdevel+bounces-5322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD580A585
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC0128182E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861C1A72E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRvRDROr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1888840E4;
	Fri,  8 Dec 2023 13:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA9CC433C8;
	Fri,  8 Dec 2023 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702040846;
	bh=SoM8x/tugHwn+Aw7Ckn647a6hBilbt2LIQ8QfTxIMGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRvRDROrDplmOc4J0deSnjRWLLGfPdUoC08OtmjKBBVaNKm0FrU1Hh9dIrDNqAOBe
	 HnJU5tzwbP6vUsjWqwsqT9n2TghaBXk+yI/DSTHRoUh6J8TebGKZtlkVhUHGrHJSej
	 rMTfRzUZEeBvSvaA7cfzvYU+HN/EZ8U4j954fnUHh/LDvlF8pBANHxXqlvMMzuMc17
	 zrtOIeKzKW1hQzXtc9yYZgh6PVKPNMal3ObYBYFJdytUt9sOv28+B2W3BiLnqdSsoI
	 vjr5ZVsZS6uvDgNIyMbSXGXaOcujepTCT/JCGYOo2bFRvtQn55qgPf29L7eJ0bkNia
	 bT1Vn3kR//EOQ==
Date: Fri, 8 Dec 2023 14:07:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <christian@brauner.io>, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/4] listmount: small changes in semantics
Message-ID: <20231208-umtreiben-imposant-0b89b4dd2f80@brauner>
References: <20231128160337.29094-1-mszeredi@redhat.com>
 <20231128160337.29094-4-mszeredi@redhat.com>
 <20231206195807.GA209606@mail.hallyn.com>
 <CAJfpegs-uUEwKrEcmRE4WkzWet_A1f9mnM7UtFqM=szEUi+-1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs-uUEwKrEcmRE4WkzWet_A1f9mnM7UtFqM=szEUi+-1g@mail.gmail.com>

On Wed, Dec 06, 2023 at 09:24:45PM +0100, Miklos Szeredi wrote:
> On Wed, 6 Dec 2023 at 20:58, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 05:03:34PM +0100, Miklos Szeredi wrote:
> 
> > > -     if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
> > > -             return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> > > +     if (!capable(CAP_SYS_ADMIN) &&
> >
> > Was there a reason to do the capable check first?  In general,
> > checking capable() when not needed is frowned upon, as it will
> > set the PF_SUPERPRIV flag.
> >
> 
> I synchronized the permission checking with statmount() without
> thinking about the order.   I guess we can change the order back in
> both syscalls?

I can just change the order. It's mostly a question of what is more
expensive. If there's such unpleasant side-effects... then sure I'll
reorder.

> I also don't understand the reason behind the using the _noaudit()
> variant.  Christian?

The reasoning is similar to the change in commit e7eda157c407 ("fs:
don't audit the capability check in simple_xattr_list()").

    "The check being unconditional may lead to unwanted denials reported by
    LSMs when a process has the capability granted by DAC, but denied by an
    LSM. In the case of SELinux such denials are a problem, since they can't
    be effectively filtered out via the policy and when not silenced, they
    produce noise that may hide a true problem or an attack."

So for system calls like listmount() that we can expect to be called a
lot of times (findmnt etc at some point) this would needlessly spam
dmesg without any value. We can always change that to an explicit
capable() later.

