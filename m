Return-Path: <linux-fsdevel+bounces-13592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24E871A4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD00B22124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FC548FA;
	Tue,  5 Mar 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLU1H/51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E6548E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633452; cv=none; b=pbWz/lon+ZgO3cU8XpTh+Qlgh3gZQWiUaejPEP7hG/+zuDfpmhQCOsVMU1MF54vHBoGPYo1/BafuEI3T9MFGoRbxVnGK0I6HPw8NbG/MA39WDGJ6NeX+zXRfXOQnXWCVUkC31KaSlxZ38a7hw0oWu2xeEHb4Qhm8+ILT/LzFvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633452; c=relaxed/simple;
	bh=1G1yCPEY6/Z8IdXz/ph95WvY99y1zo8FJPxv3Vlatgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adSrPTqnIWFYiL68H7DHaDb0IKtSptc6GlSjouY0fzNcfRze8avrL/usAo4WPa4jaOufPhEsCmyDCxhtgb1PS7/aznE7BHeMkyXEmPfmftgEPEN5ny/olGadSLy5sRXq7lwCtHXr7FY7aXvHMkN/ld0nEB92/LvNBCUOUjcFWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLU1H/51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EEDC433C7;
	Tue,  5 Mar 2024 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709633452;
	bh=1G1yCPEY6/Z8IdXz/ph95WvY99y1zo8FJPxv3Vlatgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLU1H/5133cmQIPX5OOkI1K2xyGjdAmAr15A/umM40p24fwHTjDNYeAvYNwu7ERn4
	 zqZNlsh2r9M2XQIQQQohLHHv1duV6hVnXlgE89VFUVyzcIQyiW5qIKOLpoBUCh5+Jv
	 UsMwNI8kvdGhiHbjAM2LF4ZAHwYj/k1bPluWEu8mu3KV/JbnKTqCpkuJ7mB4n16Z5e
	 2/8cjXjKTH1oiV5uqMvqlDy8xkm3D7yD82fRYcZDmYLKOLJcXSqOrgrHUsZ84hfe8J
	 bm+jdbW30c2HIeZMkvi+gJAvP1lDdFhrJZOTZJckyo2lo5nJ2BXfuibADjMkQTObFS
	 /1AJ3VDP00ghg==
Date: Tue, 5 Mar 2024 11:10:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <20240305-zugunsten-busbahnhof-6dc705d80152@brauner>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
 <20240305-abgas-tierzucht-1c60219b7839@brauner>
 <84acfa88-816f-50d7-50a2-92ea7a7db42@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84acfa88-816f-50d7-50a2-92ea7a7db42@redhat.com>

On Tue, Mar 05, 2024 at 10:34:26AM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 5 Mar 2024, Christian Brauner wrote:
> 
> > On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > > 
> > > Index: linux-2.6/mm/shmem.c
> > > ===================================================================
> > > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> > >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> > >  		 * been interrupted because we are using up too much memory.
> > >  		 */
> > > -		if (signal_pending(current))
> > > +		if (fatal_signal_pending(current))
> > 
> > I think that's likely wrong and probably would cause regressions as
> > there may be users relying on this?
> 
> ext4 fallocate doesn't return -EINTR. So, userspace code can't rely on it.

I'm confused what does this have to do with ext4 since this is about
tmpfs. Also note, that fallocate(2) documents EINTR as a valid return
value. And fwiw, the manpage also states that "EINTR  A signal was
caught during execution; see signal(7)." not a "fatal signal".

Aside from that. If a user sends SIGUSR1 then with the code as it is now
that fallocate call will be interrupted. With your change that SIGUSR1
won't do anything anymore. Instead userspace would need to send SIGKILL.
So userspace that uses SIGUSR1 will suddenly hang.

