Return-Path: <linux-fsdevel+bounces-76861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPJ4KPpsi2lhUQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:38:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283D11E042
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66253040204
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C48938A709;
	Tue, 10 Feb 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qte6o8FY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C8329E67
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745073; cv=none; b=I7YUEX+G628ARU2oDZ0as3IM4w4VDPzaOwbdb2MaAE+wY9L39HH+z2mTkJbJmRVj7k/WhEPkvRVomtLM4QEUlO1xBN691RGpVCXHDorft2+7nqaPNgr2umNHTrQw80R5YOMf2QSvmAACMkwcvfqPq9+kDQ3Iq8WqqanD4DgSSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745073; c=relaxed/simple;
	bh=3szwt70BMoxuffnqEgGMSIgDpYN7gakbZvdzoElSNIk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABMdHzeKbv4pa++EWHmFUC+mWmr92WZutg8nhosfR0GXc5BziGQThdmbt+vu+1MSnlLo0CI9nis3C/P9ZczgjZV820A2efsWHwrTBglbg7/H3qVkTDWG+YWlGUzX/UtJfHwj/RVy8utY6WWB0unfxet9iRhLglS7tuZHZzk277Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qte6o8FY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43767807cf3so1979505f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770745070; x=1771349870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kcajNkZvqw0N/nfY61jD2BzncjCpqz5WyjJmeEDaRC8=;
        b=Qte6o8FYNQ2i3sNtBjU6SSVLP2SF+U+j+3C+mtnr7F9q7PWo2Q9/is3Dmbc4++jXEE
         uSX3deV5yEVExN4PPX33ri25FzFfpaKtlVCQ5qgMEVnLGtuZnEcsAuiG7BVM9sHNEDyt
         54oDaIdCEM+VHjKPFYniPvRJy0J7p2NLc6aNnbkWSWVAjsIAs4KQso0KLdrey0SS9Ony
         eRsPiQiUQxwj3nIubFe+ATFTg/rXqerTk0+xNWx3Zqr/YYlD119Ncq4HEalo3PtQkKm9
         qtVeLKgi2T6q7gfLbiIzKtmg3s2zknQ/T/CkNkK18lXjbbacG8SfJfdpYHjjittq4rlQ
         tHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770745070; x=1771349870;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcajNkZvqw0N/nfY61jD2BzncjCpqz5WyjJmeEDaRC8=;
        b=fdNDUeFt2lBpuXcQGUy3P12rBhrFW/c4lOct30K9U/3xpM/MfQRxW1LNyY3sbgKLAg
         fOM/BAmWMndgvZAYBHySRTA5TbaJSbiJYSJ/A8AbghjAGdqdz9XE5/uAsCywLeGMtIgB
         tO+3gtsNCRLXlFWQ4XavWY9UC8wJKK2Qf3TUbAzuO4EGuAVAArZhFDfj2mdnipnqOAi3
         bVmqG8S5HDecDUiXNpLXW5xo3vRRiODAsklCG9SIomdn6V8c9TgmshZ/p4Zf2bM+TjoK
         3xzHcBc2M/YBS/Kp4IJhplEOhbsnJZbTb/d6VBeueLwrvfm2T9Gdp1r432dQeUjQXoWS
         cwIA==
X-Forwarded-Encrypted: i=1; AJvYcCWl+SEqB+B0+Px5xSOD0HWEcIYO6vLsKXKQT8/PqtYhqLWsN8AvTKLeiAUXohYlgWkOTB36YpTJamJpKkAd@vger.kernel.org
X-Gm-Message-State: AOJu0YygqnsFyCu7dsRs7o0IqFHa7jjuud2ehIbjW7DmglH06S+Kj69H
	zFTvePyWhNdwuciD/DZcAuo7w1jp4/RlgpuLd4r1YiXN1ZAQ9nA5utQt
X-Gm-Gg: AZuq6aI1WvVXB82nXwEPDhYFZaReynx0kEHbqgZt1bzDASrvS70oGd/osGJ+dXPQCuh
	7NyxSMLykmR1ikIRz40FqP2r2wbVLIaCUK9JZVkxVV85MybvP3rH7ypwe3lVizuHpXzcgHwkOPm
	KGKQNUDlCtmSXNPkhoxtKZ+082FmdDmu9Eychel/ZEreUOsuwnhysvhH96JXoqiZBVx2vPHGWIM
	sfkOK47vyn/0rDn0SJxwEKriWFrkhJsx2qnmIC6qx9ya0+t1lma8E9OqMW3w/NS17p+a1lruj0Y
	w2aouq/wMNAwaYqc8mMugc3kCsJ9yU7bmwDlxpQpl4sI8Z37hWGR0RHzrbH6dsDpdzN8OF5tfHY
	s8UiZ08OXMIVww3rDKzha6xIskvMlFi6JaTTtiiEKzHonCDAwWIWaJpIiYE0D8sJhdmEJ13nqxB
	7sMSvgCeCNvvMC920/tika2QQr/UYHoiIshdaZMYm117BYbeIQDOQaVppgZY9xDKII
X-Received: by 2002:a05:6000:1843:b0:437:711c:8750 with SMTP id ffacd0b85a97d-437711c8a40mr10998758f8f.46.1770745069651;
        Tue, 10 Feb 2026 09:37:49 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-125.ip49.fastwebnet.it. [93.34.90.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43637e31a01sm27353103f8f.27.2026.02.10.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:37:49 -0800 (PST)
Message-ID: <698b6ced.050a0220.9e34a.3e08@mx.google.com>
X-Google-Original-Message-ID: <aYts6ElcQf9XlGuH@Ansuel-XPS.>
Date: Tue, 10 Feb 2026 18:37:44 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: David Disseldorp <ddiss@suse.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: correctly handle space in path on cpio
 list generation
References: <20260209153800.28228-1-ansuelsmth@gmail.com>
 <20260210223431.6bf63673.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210223431.6bf63673.ddiss@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76861-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gen_initramfs.sh:url]
X-Rspamd-Queue-Id: 4283D11E042
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:34:31PM +1100, David Disseldorp wrote:
> [cc'ing fsdevel]
> 
> On Mon,  9 Feb 2026 16:37:58 +0100, Christian Marangi wrote:
> 
> > The current gen_initramfs.sh and gen_init_cpio.c tools doesn't correctly
> > handle path or filename with space in it. Although highly discouraged,
> 
> "highly discouraged" isn't really appropriate here; the kernel generally
> doesn't care whether or not a filename carries whitespace.
> The limitation here is specifically the gen_init_cpio manifest format,
> which is strictly space-separated.
>

Yes but the value space-separated was done only out of simplicity also with the
parsing in the .c tool not strictly a requirement for the actual cpio blob that
is then generated. The problem is in the intermediate file and I feel it should
be fixed or handled.
 
> > Linux also supports filename or path with whiespace and currently this
> > will produce error on generating and parsing the cpio_list file as the
> > pattern won't match the expected variables order. (with gid or mode
> > parsed as string)
> > 
> > This was notice when creating an initramfs with including the ALSA test
> > files and configuration that have whitespace in both some .conf and even
> > some symbolic links.
> > 
> > Example error:
> 
> The error messages don't really add any value here.
> <snip>
> 

It was really to give output of what happen when file with whitespace are used.
The shell is not so chatty with this so these error are really just the mode gid
and other values that gets parsed with the filename whitespace.

> > To correctly handle this problem, rework the gen_initramfs.sh and
> > gen_init_cpio.c to guard all the path with "" to handle all kind of
> > whitespace for filename/path.
> > 
> > The default_cpio_list is also updated to follow this new pattern.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  usr/default_cpio_list |  6 +++---
> >  usr/gen_init_cpio.c   | 10 +++++-----
> >  usr/gen_initramfs.sh  | 27 +++++++++++++++++++--------
> >  3 files changed, 27 insertions(+), 16 deletions(-)
> > 
> > diff --git a/usr/default_cpio_list b/usr/default_cpio_list
> > index 37b3864066e8..d4a66b4aa7f7 100644
> > --- a/usr/default_cpio_list
> > +++ b/usr/default_cpio_list
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  # This is a very simple, default initramfs
> >  
> > -dir /dev 0755 0 0
> > -nod /dev/console 0600 0 0 c 5 1
> > -dir /root 0700 0 0
> > +dir "/dev" 0755 0 0
> > +nod "/dev/console" 0600 0 0 c 5 1
> > +dir "/root" 0700 0 0
> > diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> > index b7296edc6626..ca5950998841 100644
> > --- a/usr/gen_init_cpio.c
> > +++ b/usr/gen_init_cpio.c
> > @@ -166,7 +166,7 @@ static int cpio_mkslink_line(const char *line)
> >  	int gid;
> >  	int rc = -1;
> >  
> > -	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
> > +	if (5 != sscanf(line, "\"%" str(PATH_MAX) "[^\"]\" \"%" str(PATH_MAX) "[^\"]\" %o %d %d", name, target, &mode, &uid, &gid)) {
> 
> This breaks parsing of existing manifest files, so is unacceptable
> IMO. If we really want to go down the route of having gen_init_cpio
> support space-separated paths, then perhaps a new --field-separator
> parameter might make sense. For your specific workload it seems that
> simply using an external cpio archiver with space support (e.g. GNU
> cpio --null) would make sense. Did you consider going down that
> path?
> 

This is mostly why this is posted as RFC. I honestly wants to fix this in the
linux tool instead of using external tools.

So is there an actual use of manually passing the cpio list instead of
generating one with the script? (just asking not saying that there isn't one)

One case I have (the scenario here is OpenWrt) is when a base cpio_list is
provided and then stuff is appended to it.

In such case yes there is a problem since the format changed.

My solution to this would be introduce new type that will have the new pattern.
This way we can keep support for the old list and still handle whitespace files.

An idea might be to have the file type with capital letter to differenciate with
the old one.

Something like 

FILE "path" "location" ...
SLINK "name" "target" ...
NODE ...

What do you think?

The option of --field-separator might also work but it might complicate stuff in
the .c tool as a more ""manual"" tokenizer will be needed than the simple
implementation currently present.

I'm open to both solution. Lets just agree on one of the 2.

-- 
	Ansuel

