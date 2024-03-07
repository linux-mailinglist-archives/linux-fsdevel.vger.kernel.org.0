Return-Path: <linux-fsdevel+bounces-13876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA8874EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B21A1C2205E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF6129A95;
	Thu,  7 Mar 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNpOS9UV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443D8833;
	Thu,  7 Mar 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813722; cv=none; b=OO5N1zPDQmhmIHTv0oF47cRTiI7d8DmctQok2yUS0OSE5FLCLLfk2nDjvXyCh3+Eq/RhlhmYj8B5vAjxFxBuFNKB9uRg1ADC3K27FTw7sqxf+H6QG0GH1xHqlHJiVK5EFjdVFkAITbBvvuVeb4AttZLgvknh0KIPBeMQ/aed5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813722; c=relaxed/simple;
	bh=TnHFwGPif48Q3J+9erZR9DbQ9KJ5bj5ALNCtUGMsS/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9QZvZyGUzqMaLhTrXyyQn1UfuaS7cRApxfn3WIdfyXYWzH65ab0D53lvBMvLCd7d86/NTswyX85FaHF2rL6IRqnFrvtlWyLQX1fAFv1VuNKSy+jZFtFv8mdT4mTrXP1RgJl+rpdvyip3NKIjtCykwAniDMREOqHHqB/Y4YaFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNpOS9UV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCFCC433F1;
	Thu,  7 Mar 2024 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709813721;
	bh=TnHFwGPif48Q3J+9erZR9DbQ9KJ5bj5ALNCtUGMsS/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNpOS9UVEQbTRA+rsLunmXcdqEd/vB//bUMt63YL6K+BDMu73+IaWpZbj7jkT3X+E
	 8GvDO8k8dldVyxZB5cGMGp1PizKrgXY3ZAbF6oGmWItq+rPGwOH7v5D2Hrho3qI/Xk
	 Eho3PGqqaZwShjoHV4JCJ9ktUxVy2Y65K8Apl/xCEjip+2h8n8QO6JGfv7IQ5lcyW+
	 L3TrKAQbtZs6HdBqNv7hc0qN0VSS7rvHIY7yyaiyGZxdG33Pw/Qzk+FDIUoEtwqQ7+
	 /mftdUR37muR34nAoK6ryuCUEsWP5GJr/07oHtMI6RuRTIWTGTZWeXg3/QNIKjsq+f
	 XW1eL3odDWY2Q==
Date: Thu, 7 Mar 2024 13:15:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>

On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 6, 2024, at 14:47, Mickaël Salaün wrote:
> > On Tue, Mar 05, 2024 at 07:13:33PM +0100, Günther Noack wrote:
> >> On Mon, Feb 19, 2024 at 07:35:39PM +0100, Mickaël Salaün wrote:
> 
> >> > +	case FS_IOC_FSGETXATTR:
> >> > +	case FS_IOC_FSSETXATTR:
> >> > +	/* file_ioctl()'s IOCTLs are forwarded to device implementations. */
> >> > +		return true;
> >> > +	default:
> >> > +		return false;
> >> > +	}
> >> > +}
> >> > +EXPORT_SYMBOL(vfs_masked_device_ioctl);
> >> 
> >> [
> >> Technical implementation notes about this function: the list of IOCTLs here are
> >> the same ones which do_vfs_ioctl() implements directly.
> >> 
> >> There are only two cases in which do_vfs_ioctl() does more complicated handling:
> >> 
> >> (1) FIONREAD falls back to the device's ioctl implemenetation.
> >>     Therefore, we omit FIONREAD in our own list - we do not want to allow that.
> 
> >> (2) The default case falls back to the file_ioctl() function, but *only* for
> >>     S_ISREG() files, so it does not matter for the Landlock case.
> 
> How about changing do_vfs_ioctl() to return -ENOIOCTLCMD for
> FIONREAD on special files? That way, the two cases become the
> same.
> 
> >> I guess the reasons why we are not using that approach are performance, and that
> >> it might mess up the LSM hook interface with special cases that only Landlcok
> >> needs?  But it seems like it would be easier to reason about..?  Or maybe we can
> >> find a middle ground, where we have the existing hook return a special value
> >> with the meaning "permit this IOCTL, but do not invoke the f_op hook"?
> >
> > Your security_file_vfs_ioctl() approach is simpler and better, I like
> > it!  From a performance point of view it should not change much because
> > either an LSM would use the current IOCTL hook or this new one.  Using a
> > flag with the current IOCTL hook would be a missed opportunity for
> > performance improvements because this hook could be called even if it is
> > not needed.
> >
> > I don't think it would be worth it to create a new hook for compat and
> > non-compat mode because we want to control these IOCTLs the same way for
> > now, so it would not have a performance impact, but for consistency with
> > the current IOCTL hooks I guess Paul would prefer two new hooks:
> > security_file_vfs_ioctl() and security_file_vfs_ioctl_compat()?
> >
> > Another approach would be to split the IOCTL hook into two: one for the
> > VFS layer and another for the underlying implementations.  However, it
> > looks like a difficult and brittle approach according to the current
> > IOCTL implementations.
> >
> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> 
> I think this sounds better. It would fit more closely into
> the overall structure of the ioctl handlers with their multiple
> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
> you have the same structure for sockets and blockdev, and
> then additional levels below that and some weirdness for
> things like tty, scsi or cdrom.

So an additional security hook called from tty, scsi, or cdrom?
And the original hook is left where it is right now?

