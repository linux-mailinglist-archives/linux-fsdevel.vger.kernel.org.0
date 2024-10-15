Return-Path: <linux-fsdevel+bounces-32027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AA99F5F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7A728260A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38601B6CEB;
	Tue, 15 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz+++DUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73322036F1;
	Tue, 15 Oct 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017974; cv=none; b=KcxUW7rkYhw/9rmUuhHJL1xplkrSj9Ut8x6FZShoKfWQVGTGvOKFbKG5cKHUY8GgsQasKjJbR5R8ctKljJwAgRtGah49lSqKvKxT5s4JtuG0jtWPNfT3bsvakyPmJerhCPWX6Ie4GGgM0iFB1vUIWkDWZntezSWG+8L0OIREYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017974; c=relaxed/simple;
	bh=9KClIjMcjoCppzY7f0hKgjvul5Gc+2NAe3xFLGgCxLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2fXRAvfP6GGGmtx4bOmx+yg0jhNtkiEPd2HA3JWfPFE7/aGHRvQdA0Ra5RkDCXW0li8S02Yl8MR2lMbpPEQlyygeLgsaOfZ9ehu2c73YDE8GMgtGrXmG9qBbAwIHCF1uCS43Rdftn+PhZNrVBX0ENgrkop7kp9mNeogigvTveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz+++DUY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7afc847094fso438151385a.2;
        Tue, 15 Oct 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017971; x=1729622771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khv6hcv6kkDgKzCP7fyWTG/6xWqnN83cb3e1EtyOfCU=;
        b=Sz+++DUYYvFk9saEvlM3pfOVgggSg3ttMhEypd4dWuQb1hzPG+zczAVOROyc//QaRx
         Ol7/Sqve6yuWsUyZPFbXkVKwkOQsQCOKpNVSU0EhiAh95+K5Zhb1CD/UjtUYuISye+8G
         F4/4mZW5qJ/bvJ4G75+V7omqqdEUQVZM/vCPsyzJnAoHePkDM6CrD88HS4ZOVxpf9Anj
         /xkDccNeuGhfy86qjQ1FYWmudNTtw14k0ulgAJRbJ//V5dINxDcFncGIxai6LO6RdoR7
         Cr3NqFodwHIIEFGFX1pcj/cecKLYX0QvvBKouy4v+YuHx02dJYsbvaJq+YgMDHm8FnW/
         4hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017971; x=1729622771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khv6hcv6kkDgKzCP7fyWTG/6xWqnN83cb3e1EtyOfCU=;
        b=ra4HwmOKDX77/DMwx9yYIXmYN3uplgeerWlf1V67/IyK6RoABEzLFFX/aecobvKc1q
         bI2Fxhr4lJbo3HfB9iNiURIEZewutoViRLmf3gTDOKTA/NqohfNmqEtweGNfYUBzhQ2f
         UdguraDOdBeu0wLfm55IESTLO4Q6caA1y0n7qkIugrYFQMp+TVhNm9KhAL5ERmMvmBgE
         8Jy1sgPecp8BEHkE8TYDe6PFNGYeVmWTZf5lFpizwQ1b9HtieVwrUQotzpR/QZWYMY6C
         h7EEJDGRRlym8QA8fngpeKBTzacs7pTXh/xamwGuXGGCDqZSPTDgEVnBcln7FVoxKN8F
         wDWw==
X-Forwarded-Encrypted: i=1; AJvYcCU3I7Dipr/DwpS8ibrHWqozP+ngwd42rE6/z9+sz+aMUCOQhUrjp8yRjqSxbfqHIsrSIn3sJmKYUybtxrf2Dn8=@vger.kernel.org, AJvYcCWFaSyzy71UgDgndDyquGE6dGZ9dgGmEcXGUbL3eQIKDGxQQ4PZqLzN2WfqwY5AJ5TlVqIm4b1p1lL+5PkY@vger.kernel.org, AJvYcCWh/wqQM+HnFEUZO/Q9rs0HRoAnXJ4t6zXcgSQzxnhULFAmliPB27IKKVZO6UNeZwZoXR26knIhgjFMWon1@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfniH+q0Xn8FKhcAqf8j36P8CowNmTiaafkwYVnkDUelzRGeL
	9myqX5fYjokxZ7YIz/ALzFa4q7yHc87IgHtizu54ll9zZ2MGYr3a
X-Google-Smtp-Source: AGHT+IFLZlUJTHO5srdfwWocUIH9sEixb3oyQ2JD3OiGAPufZnDDk3dfTXAkDH+T133qGhtmtjY5WA==
X-Received: by 2002:a05:620a:4691:b0:7ac:b118:a732 with SMTP id af79cd13be357-7b11a36dfd3mr2269662885a.32.1729017971427;
        Tue, 15 Oct 2024 11:46:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136164db1sm102765885a.6.2024.10.15.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:46:11 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 951021200076;
	Tue, 15 Oct 2024 14:46:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 14:46:10 -0400
X-ME-Sender: <xms:crgOZztJzCO9eoe8Cnps_YAEOtkx8m_PC-1JUP6xChbQKDS0R5omDw>
    <xme:crgOZ0dMILz7Z8a0VuaK-Uv6S-G2L5L6oJ6yQqEGT0ZYIRaNjaCm4Uxou9j0DB0Jr
    ZDtzhB-FNRrEFDFxQ>
X-ME-Received: <xmr:crgOZ2ycHPlZN-kuMOVPtHbiMYCEQ6OU-ucOugSKtc570cPdxd2amshtpgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvgesrhihhhhlrdhiohdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsrhgr
    uhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheprghlvgigrdhgrg
    ihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:crgOZyMOK-ar6Tq0QfhOgpgdhKGwSZOCqjhywJ1uRt_Yx9WuidHK5Q>
    <xmx:crgOZz87kE3-D3joYLQ3w-_VD7l2SRtiTTJOyo1G5wvYpo1hLJpxcg>
    <xmx:crgOZyVwnly4RXS8JZyQb1go4l_Ssip-ACX4xfZqbFRD8mQFkc0Xkw>
    <xmx:crgOZ0eP8LKr3kjMKvRCamY9AxonuVBFjOziBQc46FWo6U9fzePHZQ>
    <xmx:crgOZxeYSwGBVIh1gPGOmiRGadasWOys2dYsbqloxPNDLviKChP3bZdT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:46:10 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:45:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <alice@ryhl.io>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
Message-ID: <Zw64XYHtjGmbnfTO@boqun-archlinux>
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
 <Zw6zZ00LOa1fkTTF@boqun-archlinux>
 <23a73a6f-160d-4d06-8d45-ec77293ff258@ryhl.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a73a6f-160d-4d06-8d45-ec77293ff258@ryhl.io>

On Tue, Oct 15, 2024 at 08:37:36PM +0200, Alice Ryhl wrote:
> On 10/15/24 8:24 PM, Boqun Feng wrote:
> > On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
> > > The `Task` struct has several safety comments that aren't so great. For
> > > example, the reason that it's okay to read the `pid` is that the field
> > > is immutable, so there is no data race, which is not what the safety
> > > comment says.
> > > 
> > > Thus, improve the safety comments. Also add an `as_ptr` helper. This
> > > makes it easier to read the various accessors on Task, as `self.0` may
> > > be confusing syntax for new Rust users.
> > > 
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > This is based on top of vfs.rust.file as the file series adds some new
> > > task methods. Christian, can you take this through that tree?
> > > ---
> > >   rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
> > >   1 file changed, 24 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> > > index 1a36a9f19368..080599075875 100644
> > > --- a/rust/kernel/task.rs
> > > +++ b/rust/kernel/task.rs
> > > @@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
> > >           }
> > >       }
> > > +    /// Returns a raw pointer to the task.
> > > +    #[inline]
> > > +    pub fn as_ptr(&self) -> *mut bindings::task_struct {
> > 
> > FWIW, I think the name convention is `as_raw()` for a wrapper type of
> > `Opaque<T>` to return `*mut T`, e.g. `kernel::device::Device`.
> > 
> > Otherwise this looks good to me.
> Both names are in use. See e.g. Page and File that use as_ptr.
> 

`Page` is a different case because it currently is a pointer.

> In fact, I was asked to change the name on File *to* as_ptr.
> 

I'm not able to find the discussion on that ask. Appreciate it if you
can share a link.

Anyway, this is not important for now, and might not be in the future.
So:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Alice

