Return-Path: <linux-fsdevel+bounces-11857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E2185820A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A07D285CEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56D130AF7;
	Fri, 16 Feb 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oXB4Prd0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852212FF6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099167; cv=none; b=hTB6eZ80SIUIk+q5UFR0+6nr3AZnZR4c7kJ0RH3OocswQ9+SezrEUaL1AGG3Zeq8rlQDwZ50BiwzhKvghym+nk8aj0pUQWiMqfyHe6I12+BHVThRCSwICTTi9u9NMniQfhD0kFHNHmbATfcje0lHidHHarfI41aEe9u40JShrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099167; c=relaxed/simple;
	bh=WmcuCs3E9zzmdPnmKkHdT47Jolk6hbejMhixwPn9lZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsGJgPn6kGvJsIEID3HiJ/ZYIrnuZIX6kgCy/UlQbaOHt/RNcQ3JfTQkyHGRp3hLE00rKx19bt2HfFAudMTVfSlnsP2cyZJfUFOFhNXmNEn47bTGHVatr/Sgg3juJpcQ697xBVqWDAz6/OWpT+DE57Bsx4IahI6YcN5dGXY5i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oXB4Prd0; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TbxJ34w18zWK1;
	Fri, 16 Feb 2024 16:51:47 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TbxJ261CSzMpnPg;
	Fri, 16 Feb 2024 16:51:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708098707;
	bh=WmcuCs3E9zzmdPnmKkHdT47Jolk6hbejMhixwPn9lZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXB4Prd0xr4DbllDzXpOtEkKWmMatabfsvdhcka48wGoUQ7kj/C6WUiQfkihjhB5U
	 GBmSNHs7OBAUFWHIGLQLKC9b1wG5+1+cDlHY/SX+lyh+dx0683vVcLdjJbBk2wJKOa
	 5lcsZi76RhVwt7V4YvwZCuOLtoiU4TOvOUkLMV2I=
Date: Fri, 16 Feb 2024 16:51:40 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240216.phai5oova1Oa@digikod.net>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <ZcdbbkjlKFJxU_uF@google.com>
 <20240216.geeCh6keengu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216.geeCh6keengu@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Feb 16, 2024 at 03:11:18PM +0100, Mickaël Salaün wrote:
> On Sat, Feb 10, 2024 at 12:18:06PM +0100, Günther Noack wrote:
> > On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index 73997e63734f..84efea3f7c0f 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file)
> > >  {
> > >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > >  	access_mask_t open_access_request, full_access_request, allowed_access;
> > > -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > > +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> > > +					      LANDLOCK_ACCESS_FS_IOCTL |
> > > +					      IOCTL_GROUPS;
> > >  	const struct landlock_ruleset *const dom = get_current_fs_domain();
> > >  
> > >  	if (!dom)
> > > @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const file)
> > >  		}
> > >  	}
> > >  
> > > +	/*
> > > +	 * Named pipes should be treated just like anonymous pipes.
> > > +	 * Therefore, we permit all IOCTLs on them.
> > > +	 */
> > > +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> > > +		allowed_access |= LANDLOCK_ACCESS_FS_IOCTL |
> > > +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> > > +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> 
> Why not LANDLOCK_ACCESS_FS_IOCTL | IOCTL_GROUPS instead?
> 
> > > +	}
> > > +
> > 
> > Hello Mickaël, this "if" is a change I'd like to draw your attention
> > to -- this special case was necessary so that all IOCTLs are permitted
> > on named pipes. (There is also a test for it in another commit.)
> > 
> > Open questions here are:
> > 
> >  - I'm a bit on the edge whether it's worth it to have these special
> >    cases here.  After all, users can very easily just permit all
> >    IOCTLs through the ruleset if needed, and it might simplify the
> >    mental model that we have to explain in the documentation
> 
> It might simplify the kernel implementation a bit but it would make the
> Landlock security policies more complex, and could encourage people to
> allow all IOCTLs on a directory because this directory might contain
> (dynamically created) named pipes.
> 
> I suggest to extend this check with S_ISFIFO(mode) || S_ISSOCK(mode).
> A comment should explain that LANDLOCK_ACCESS_FS_* rights are not meant
> to restrict IPCs.
> 
> > 
> >  - I've put the special case into the file open hook, under the
> >    assumption that it would simplify the Landlock audit support to
> >    have the correct rights on the struct file.  The implementation
> >    could alternatively also be done in the ioctl hook. Let me know
> >    which one makes more sense to you.
> 
> I like your approach, thanks!  Also, in theory this approach should be
> better for performance reasons, even if it should not be visible in
> practice. Anyway, keeping a consistent set of access rights is
> definitely useful for observability.
> 
> I'm wondering if we should do the same mode check for
> LANDLOCK_ACCESS_FS_TRUNCATE too... It would not be visible to user space
> anyway because the LSM hooks are called after the file mode checks for
> truncate(2) and ftruncate(2). But because we need this kind of check for
> IOCTL, it might be a good idea to make it common to all optional_access
> values, at least to document what is really handled. Adding dedicated
> truncate and ftruncate tests (before this commit) would guarantee that
> the returned error codes are unchanged.
> 
> Moving this check before the is_access_to_paths_allowed() call would
> enable to avoid looking for always-allowed access rights by removing
> them from the full_access_request. This could help improve performance
> when opening named pipe because no optional_access would be requested.
> 
> A new helper similar to get_required_file_open_access() could help.
> 
> > 
> > BTW, named UNIX domain sockets can apparently not be opened with open() and
> > therefore they don't hit the LSM file_open hook.  (It is done with the BSD
> > socket API instead.)
> 
> What about /proc/*/fd/* ? We can test with open_proc_fd() to make sure
> our assumptions are correct.

Actually, these fifo and socket checks (and related optimizations)
should already be handled with is_nouser_or_private() called by
is_access_to_paths_allowed(). Some new dedicated tests should help
though.

