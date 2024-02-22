Return-Path: <linux-fsdevel+bounces-12493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF385FDA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F41B28E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193515098C;
	Thu, 22 Feb 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go89Vbph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A8134CDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618125; cv=none; b=NECDOjZw5mq2RTiNHbFmNg+58yEuvYawROKaqfxyezSUK8mMAJYeDBx5y8bEkuE40LzVK7OlfymNGnBKsIBJqsBg32NyFlRzHPXm5Uv7errJoJMYFRYY9WylnHSUc8o6qIXQSDjUmz3CWkzSW4g5uuOTzG3MrdQcbpnqdSW/KIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618125; c=relaxed/simple;
	bh=LXX7PqMr3zC8oZqJp54Ga14w9AN1euQicO2VzkwQwmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5OfO3zz8913C/gYZe5Zly16KLH/t0niKVGSeDN0QWUAWYtC9pIv24ziL1m6DopQS9HFy4SygAzw6UZYC/5Dfh2U5Rbawt3c0nJGIzs43yxApAL9R0x83+JRjdmGOcriACclpbtMDbpf8ADP9WPDaTVD0NaB/HeoN+YWsPDEcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go89Vbph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE1C433C7;
	Thu, 22 Feb 2024 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708618125;
	bh=LXX7PqMr3zC8oZqJp54Ga14w9AN1euQicO2VzkwQwmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Go89VbphDBQ9c/w0ic7kOjwAUEZCE1qYlHi8E6Lw5JTdV2LgyVXemwID1CEL4Wk8W
	 vReTbZEK3mWD+Ox9DiRTIEZGoAmulp/rzdL4gGGEy6EIZLzNcbC7IFQOtPLlqbSojl
	 FeMhnSY2nPwBfYAHGRrsfkUPRuiZ66I3bf2tZpDEUcWavHo+H7ZiHZWKknNdPWUjis
	 4N/jj3ruA9FS2taha+fBkW4nKVf6g7gPpSlObc/SOjXpZCw2W8HEudTtY2BZJxx+/U
	 Uv8QCi7vLbjMm+7r6qVI63kT+Z3FcTNumLxeos0AZYTeJCtcqOXU6cNGD+Mv7R6iJC
	 Nq2scWSYg9TzQ==
Date: Thu, 22 Feb 2024 08:08:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <aviro@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240222160844.GJ6184@frogsfrogsfrogs>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <ZddvIL4cmUaLvTcK@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddvIL4cmUaLvTcK@redhat.com>

On Thu, Feb 22, 2024 at 09:58:24AM -0600, Bill O'Donnell wrote:
> On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> > As filesystems are converted to the new mount API, informational messages,
> > errors, and warnings are being routed through infof, errorf, and warnf
> > type functions provided by the mount API, which places these messages in
> > the log buffer associated with the filesystem context rather than
> > in the kernel log / dmesg.
> > 
> > However, userspace is not yet extracting these messages, so they are
> > essentially getting lost. mount(8) still refers the user to dmesg(1)
> > on failure.

Eric pointed me at a sample program (over irc) that revealed that one
can read() the fd returned by fsopen() to obtain these messages.  I had
no idea that was possible... because there are no manpages for these
system calls!

Can we /please/ document and write (more) fstests for these things?
[that was mostly aimed at dhowells]

--D

> > At least for now, modify logfc() to always log these messages to dmesg
> > as well as to the fileystem context. This way we can continue converting
> > filesystems to the new mount API interfaces without worrying about losing
> > this information until userspace can retrieve it.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> 
> > ---
> > 
> > A few considerations/concerns:
> > 
> > * viro suggested that maybe this should be conditional - possibly config
> > 
> > * systemd is currently probing with a dummy mount option which will
> >   generate noise, see
> >   https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
> >   i.e. - 
> >   [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
> >   [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
> >   [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
> >   [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'
> > 
> > * will this generate other dmesg noise in general if the mount api messages
> >   are more noisy in general? (spot-checking old conversions, I don't think so.)
> > 
> >  fs/fs_context.c | 38 ++++++++++++++++++++------------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 98589aae5208..3c78b99d5cae 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -427,8 +427,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
> >  EXPORT_SYMBOL(vfs_dup_fs_context);
> >  
> >  /**
> > - * logfc - Log a message to a filesystem context
> > - * @log: The filesystem context to log to, or NULL to use printk.
> > + * logfc - Log a message to dmesg and optionally a filesystem context
> > + * @log: The filesystem context to log to, or NULL to use printk alone
> >   * @prefix: A string to prefix the output with, or NULL.
> >   * @level: 'w' for a warning, 'e' for an error.  Anything else is a notice.
> >   * @fmt: The format of the buffer.
> > @@ -439,22 +439,24 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
> >  	struct va_format vaf = {.fmt = fmt, .va = &va};
> >  
> >  	va_start(va, fmt);
> > -	if (!log) {
> > -		switch (level) {
> > -		case 'w':
> > -			printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
> > -						prefix ? ": " : "", &vaf);
> > -			break;
> > -		case 'e':
> > -			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
> > -						prefix ? ": " : "", &vaf);
> > -			break;
> > -		default:
> > -			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
> > -						prefix ? ": " : "", &vaf);
> > -			break;
> > -		}
> > -	} else {
> > +	switch (level) {
> > +	case 'w':
> > +		printk(KERN_WARNING "%s%s%pV\n", prefix ? prefix : "",
> > +					prefix ? ": " : "", &vaf);
> > +		break;
> > +	case 'e':
> > +		printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
> > +					prefix ? ": " : "", &vaf);
> > +		break;
> > +	default:
> > +		printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
> > +					prefix ? ": " : "", &vaf);
> > +		break;
> > +	}
> > +	va_end(va);
> > +
> > +	va_start(va, fmt);
> > +	if (log) {
> >  		unsigned int logsize = ARRAY_SIZE(log->buffer);
> >  		u8 index;
> >  		char *q = kasprintf(GFP_KERNEL, "%c %s%s%pV\n", level,
> > -- 
> > 2.43.0
> > 
> 
> 

