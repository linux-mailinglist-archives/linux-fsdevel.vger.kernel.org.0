Return-Path: <linux-fsdevel+bounces-11866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583688582CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3691C21522
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71CE12FF9B;
	Fri, 16 Feb 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjB+qEB0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C512EBC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101710; cv=none; b=ebRwQrUtySg5zqc4gnx7ZxN2flPo9JrgqzHw1/y0exq7A9nyJXIl7puBCIonxA+phgL34E8FrIxws2lzcTO+SJNAo9KIMyv02hFRKzYxhbc/DfDXxCs1EuFiawsfKwh7Tl6tw8bvK7M/DGYuRqwqAKNbAdFCqjrskev4lVw+MSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101710; c=relaxed/simple;
	bh=U5u/jtmynX6/pQ09+vEX5z0p/FTODL0p9/sZC8wv1NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6YFP4ndUlnjeqvCnoouOYsmIS+2gSFb/AaMEPhw2Oi5l/5cC+MTzZTONiCyEuh8tSX02MziFAvs2rHqL3sGE9bex5xSw3KVEsgn24/748z6PjG9DOdzt55s/dZNiaWXVHmeSvIGhMBmb9CLwfMuJUGjq4aiHh8Foz8tktnrvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjB+qEB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D7C433F1;
	Fri, 16 Feb 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101709;
	bh=U5u/jtmynX6/pQ09+vEX5z0p/FTODL0p9/sZC8wv1NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjB+qEB0WPvnfjdoVZXm6s7fXyL6ZOxIqaGL47zZtzRFQUWzO0tsUdhJHjhjQJee5
	 aJ8c868e3mE8TvB08BJ0sK5OAAlz/KUGZiYr1Fgq0BY0L7vKaAtrmNPOddayt6w3mA
	 xjhtjAYOnfq3SKx8Qer+WRpOFf/0syZH6c28FIQVnrdsIrmveQo3D98EM6tFkwm+1q
	 Ev+ZM1UlGBDJTf0aT5fQrUqiDdHvQzp+UdU0frxcHDY+nEEAGvmRtRtCxgX35Q8lSg
	 qiDZ2e9V0iM1iRmcaSXTGqFlMDYALkpQeFqMsKKHEY/e1XDgP4zNU0YY2eo2teCRlC
	 Eq+NxStlgykOw==
Date: Fri, 16 Feb 2024 17:41:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240216-fehlzeiten-zahnpasta-2d4c3351455f@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216-gewirbelt-traten-44ff9408b5c5@brauner>

On Fri, Feb 16, 2024 at 12:50:45PM +0100, Christian Brauner wrote:
> On Thu, Feb 15, 2024 at 05:11:31PM +0100, Christian Brauner wrote:
> > On Wed, Feb 14, 2024 at 10:37:33AM -0800, Linus Torvalds wrote:
> > > On Wed, 14 Feb 2024 at 10:27, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > Ok, that turned out to be simpler than I had evisioned - unless I made
> > > > horrible mistakes:
> > > 
> > > Hmm. Could we do the same for nsfs?
> 
> Ok, here's what I got. I'll put the changes to switch both nsfs and
> pidfdfs to the proposed unique mechanism suggested yesterday on top. I
> would send that in two batches in any case. So if that's somehow broken
> then we can just drop it.

Bah, I pasted the version where I forgot an iput() when a reusable
dentry is found. Fixed that already.

