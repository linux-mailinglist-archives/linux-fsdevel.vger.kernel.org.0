Return-Path: <linux-fsdevel+bounces-39622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E191FA162EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248D5164B10
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C91DF74B;
	Sun, 19 Jan 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPhIuRU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8753F9D2;
	Sun, 19 Jan 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737304291; cv=none; b=HUcXbsU7CkMo1TslOqmpLEwf6ICgikQAySuy/MV4KecsuaeklkvdGDBcb7yJaqLTt77/Bte6P+K3+AXo3r3CM0jDR6KQWjaWfCmwB5LDBG8QGxP1KWnOoAQxa6gnqKNRAPLxks4GZaygEe1WPaSdtX6Zx+uyPgoNqEOcGNaW+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737304291; c=relaxed/simple;
	bh=rqXOjQ4Dl77WNYj6CMd9uYvCbeTPInrKbB3cOpIY1d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gX0xKhTlhd7zoSltu307xP5W1Ak1Jf/tzxy21G6JTe/9AMGMlRrjSqvU3pITZDvIljtLmTksbgqWNmBFOUfWiyAHTNgIC2X2nfmxV1KLldvLwS7ZwU9tkFHK87KWlhirAZdnCbNQDcxTF6fkLdmzkjoCp3nTkEaN9eeQ4PuuEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPhIuRU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580BBC4CEE3;
	Sun, 19 Jan 2025 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737304290;
	bh=rqXOjQ4Dl77WNYj6CMd9uYvCbeTPInrKbB3cOpIY1d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SPhIuRU5ZnA0imTCrayMcyzPhfivKDGmjdk0OT5fyaqW8IrVZkfGXYaQVV9wPmio1
	 kGmO+L/if3aF3AMzPMrYCsP+f7b7WtigDB+vb22mhnuN1A9fLvFnNXFKbQl8ayTPpK
	 xuBLSsSNB0jKFrfTvZoRwTCiOCDHPnVX8/9+HrfYqPasRQM3Ad3VGRXCFajOoyeqy2
	 0nF5+/TfKl+pqZMKpCMZ0ZQJZMZvNRrVne8WfjtF95s4PBBwsvafLBOhv5mxRCADNj
	 jqVxMFsV/eFaMif4kh2QzE2o5FnUujfr4EzvumonKfVbJtaDkgPs/9hBKEMS5Hx03U
	 sLbvuh/t8BVuA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3a227b82so3404002e87.0;
        Sun, 19 Jan 2025 08:31:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcTZSNwu61zgsPBK82ahb4lKGZP0CgQYPWYPr9aLEW9UL8PcWmXvjlV0kgfxVVsvtflKz1E7kk3I0=@vger.kernel.org, AJvYcCXoByCflbaJ7W/2FSfyQbbzqGdhHnGeesiVyIIDLC6sgEkCdYyZmLfMQWJwW2C51uSfkzVheYV99o4YnYvQRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/JFoF0+2D9lEyC4/coXAQQcKu4sejXY7Juxs/6FOHB3rc4Ms
	aWWW5Ciq6FeM8NGhn2hCX4kEtTXKK5zO/FnJJVnr9BJB/HesehW26HmQonF5OTyu8dHGSeK6UO0
	GzhLuZ2wvnW8Y6DAoWY4fciVFS4c=
X-Google-Smtp-Source: AGHT+IFUXEDzAwGXqlatoGI6OQs9L1OzhGHSjo8lYtVNMzhALJZ4EGtkcgC92ATcrFx7AuHOhdtopTqDeyjKgmiESfI=
X-Received: by 2002:a05:6512:2346:b0:542:297f:4f64 with SMTP id
 2adb3069b0e04-5439c280a83mr4369134e87.43.1737304288668; Sun, 19 Jan 2025
 08:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
 <20250116183643.GI1977892@ZenIV> <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
 <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
 <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com> <45d245a9db73f3c41f31626a675d6356704198ef.camel@HansenPartnership.com>
In-Reply-To: <45d245a9db73f3c41f31626a675d6356704198ef.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 17:31:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEXKxgKNUoYW-sW_NqegcqG21Q0Rsdg0JQPwunBiR5mQQ@mail.gmail.com>
X-Gm-Features: AbW1kvY7DG3xZ_OatI86NdIv8s2XWhLOfGFajwR1D32GeGz_EcLkKnG8XMQE6vY
Message-ID: <CAMj1kXEXKxgKNUoYW-sW_NqegcqG21Q0Rsdg0JQPwunBiR5mQQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into evict_inode
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 15:57, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2025-01-19 at 15:50 +0100, Ard Biesheuvel wrote:
> > On Thu, 16 Jan 2025 at 23:13, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Thu, 2025-01-16 at 14:05 -0500, James Bottomley wrote:
> > > > On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> > > > > On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley
> > > > > wrote:
> > > > > > Make the inodes the default management vehicle for struct
> > > > > > efivar_entry, so they are now all freed automatically if the
> > > > > > file is removed and on unmount in kill_litter_super().
> > > > > > Remove the now superfluous iterator to free the entries after
> > > > > > kill_litter_super().
> > > > > >
> > > > > > Also fixes a bug where some entry freeing was missing causing
> > > > > > efivarfs to leak memory.
> > > > >
> > > > > Umm...  I'd rather coallocate struct inode and struct
> > > > > efivar_entry; that way once you get rid of the list you don't
> > > > > need - evict_inode() anymore.
> > > > >
> > > > > It's pretty easy - see e.g.
> > > > > https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> > > > > for recent example of such conversion.
> > > >
> > > > OK, I can do that.  Although I think since the number of
> > > > variables is usually around 150, it would probably be overkill to
> > > > give it its own inode cache allocator.
> > >
> > > OK, this is what I've got.  As you can see from the diffstat it's
> > > about 10 lines more than the previous; mostly because of the new
> > > allocation routine, the fact that the root inode has to be special
> > > cased for the list and the guid has to be parsed in efivarfs_create
> > > before we have the inode.
> > >
> >
> > That looks straight-forward enough.
> >
> > Can you send this as a proper patch? Or would you prefer me to squash
> > this into the one that is already queued up?
>
> Sure; I've got a slightly different version because after talking with
> Al he thinks it's OK still to put a pointer to the efivar_entry in
> i_private, which means less disruption.  But there is enough disruption
> that the whole of the series needs redoing to avoid conflicts.
>
> > I'm fine with either, but note that I'd still like to target v6.14
> > with this.
>
> Great, but I'm afraid the fix for the zero size problem also could do
> with being a precursor which is making the timing pretty tight.
>

OK, I'll queue up your v3 about I won't send it out with the initial
pull request, so we can make up our minds later.

I take it the setattr series is intended for merging straight away?

