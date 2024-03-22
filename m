Return-Path: <linux-fsdevel+bounces-15042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8AE88649A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 02:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82406B21C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF771392;
	Fri, 22 Mar 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2FGRtdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27165C;
	Fri, 22 Mar 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070444; cv=none; b=R8Treyr+DQwRKVGZFvYiIeiocr0b4nEFb4jJygfEPCEaHx3GhEjzahQ0i8I8s/TpvgK+RDA5SfP1fcOU/RFnxQlSb+y1SzznHbqGjfQbBQFdqpIxd2QppJi+gW1fCezhvp22Spf1vCezEyg38rBhJHHDtqxNaOFjgVzlqMked/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070444; c=relaxed/simple;
	bh=UezMJ6BGmvAPNOKpgIMHTqQ5+LXCECHMe/jAQaIzMD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj6yIPhnzdXAgLObS535FetYsxtRf3gINwuMz2JmDAvSnjzHJCBv3W74Kk7qeV/l2rhXBbfodwg0HdOVQClU8dOSA2F2xggFMh4Txls8EsPdfKZ7GszxKZwgbv202sbrYY82gpMKtlZvwWGepDNqY3dng6/puRyJZMMQaXdmiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2FGRtdY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78822e21a9dso89395885a.2;
        Thu, 21 Mar 2024 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711070442; x=1711675242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AEhwZNosta1NIlXJ9RmSmF3Nm4p1XcIBc8mpun1aEN4=;
        b=N2FGRtdYrmrZfyOTiOlspA3GyMW3aNrHAtRIRHrluFpFOOCagL5GxKfp5rIx2rWHKE
         pkegLdkM3hsD32i+eAWlogXonNOAJA/jb3zMoZfY5R7ZSTWQE/zJhW7BH9PCwWtOMrUO
         +RPC8ozGhRb6mkaeTQ91FHYMKGJzrLfm6Q2T6zP0xOIJnXAP0N8mthC69dMSgl6DFKOS
         YXYbfcs200w9KAKnadugLn/zVeDRYLXgQJgAknOtEC1aRCc7Lb8CxFzffGAe3xusikEs
         mceXkAnBkZ5MUHlg0ReXrjJ0Xs0y+ZUNlg0MdEb2A0lry6bwW+Eu0FA8A7qDxTkDDhPt
         NgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711070442; x=1711675242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEhwZNosta1NIlXJ9RmSmF3Nm4p1XcIBc8mpun1aEN4=;
        b=F2XsyQlaibBfMUHg9FWqIwvVbSXoygv5Eq4FJmoQtJh2S7+QFi/LNYmrZ/0VK87I8M
         d8df5K8ZWLJUsUX4t9/9g6FBwKrhwB4wBA37ZjHKr+qgCNwPsW4teanYdALuK8swONin
         BWkY802G0WXM3uBQIkAxpqtQSBaHwTTfKshpBgxzDCqwDoFdVRKz7vjBFDlF+oLrLGYQ
         ea6BMfzSVNnqq1n+syV+NIwKniNedXvujFlqBB0+wwb4Vf3pZYGyKIWaORhzfJ9VU/SW
         Mm75YmD3G1h65nvBabACdaCaWy6jEpbT1YfRUXqRVHg5XayW63BUmfkoYSL39DZK9veo
         s6/w==
X-Forwarded-Encrypted: i=1; AJvYcCW/P/0d/AtGtNaTxmwTIJIwiV3w/+bakZk9eMSbXLO62JxUOpPepLkDfXSb2Irn+DmRS8dkMpf7PS7BattS6PtbIZ9sTcMIxLbDO9nZhNhsPJkfy2q08/oB4WbKLYnvA9N87Cr5XcT+6GAVCRFU
X-Gm-Message-State: AOJu0Yw95OsXRBMuMcOXTYfdT6UmxBNaYNXNuzPZcegCcpeM9SEoLtiM
	VzRus7DEioRenZVMm0lDQsvEJ4YsmqfI2KKDfhR0NMMHDG8vybmP
X-Google-Smtp-Source: AGHT+IEWSZCVoJVhIdVcPVe3W35iSPVUa6L0bXnFX58YCRM7aHptQvoeiNQUxAV9KzBwEaUjygdswA==
X-Received: by 2002:a05:6214:250f:b0:691:3549:340a with SMTP id gf15-20020a056214250f00b006913549340amr852080qvb.42.1711070442054;
        Thu, 21 Mar 2024 18:20:42 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6-20020a0562140d4600b0068f75622543sm539138qvr.1.2024.03.21.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 18:20:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 329D41200043;
	Thu, 21 Mar 2024 21:20:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 21:20:22 -0400
X-ME-Sender: <xms:1dz8ZU2gZM_-IyRDNQn_7CUS9NLIGkbijFnDGAY1KHEzVcgf12me7Q>
    <xme:1dz8ZfGKz4ob86Uy6xPsWLG2j4R5tZRsq3lOUXKwh07k3nHb-hO0F0Je26eOigBtJ
    JEpxTO1_fbA9XV86A>
X-ME-Received: <xmr:1dz8Zc4Gv5yVnBO2oTPI0NP0I9iswSWi8zIpiQChUkKuviBpv7okrT7duw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueff
    ieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1dz8Zd1lPoz8_Pp0-zmrt8CFTCq6VTHW1mtrURi0A5g4ud28L9PDrQ>
    <xmx:1dz8ZXGxFZAlvpdOZS_InlbiDOA7wghDY-JfjPjZfWrOWu9602LG9Q>
    <xmx:1dz8ZW-vuuk3y_KfVzcrQ2S07KNuou9n9mSxT7PugiTugwoXH7unXQ>
    <xmx:1dz8Zcn9C63mB7_QHvia4MoAb38X_nhUkLaJ3ot2ellw0e9db5Lf7A>
    <xmx:1tz8ZYIvGt_gRsFbwrFT7ed2MX7vo4W9n49Mx9-h_3v0vlQvoWJhEfMNTAw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 21:20:20 -0400 (EDT)
Date: Thu, 21 Mar 2024 18:20:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Alice Ryhl <aliceryhl@google.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
Message-ID: <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
References: <20240309235927.168915-2-mcanal@igalia.com>
 <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
 <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com>

On Thu, Mar 21, 2024 at 05:22:11PM -0700, John Hubbard wrote:
> On 3/19/24 2:32 AM, Philipp Stanner wrote:
> ...
> > > 
> > > > +        if ret < 0 {
> > > > +            Err(Error::from_errno(ret))
> > > > +        } else {
> > > > +            guard.dismiss();
> > > > +            Ok(id as usize)
> > > > +        }
> > > 
> > > You could make this easier to read using to_result.
> > > 
> > > to_result(ret)?;
> > > guard.dismiss();
> > > Ok(id as usize)
> > 
> > My 2 cents, I'd go for classic kernel style:
> > 
> > 
> > if ret < 0 {
> >      return Err(...);
> > }
> > 
> > guard.dismiss();
> > Ok(id as usize)
> > 
> 
> Yes.
> 
> As a "standard" C-based kernel person who is trying to move into Rust
> for Linux, I hereby invoke my Rust-newbie powers to confirm that the
> "clasic kernel style" above goes into my head much faster and easier,
> yes. :)
> 

Hope I'm still belong to a "standard C-based kernel person" ;-) My
problem on "if ret < 0 { ... }" is: what's the type of "ret", and is it
"negative means failure" or "non-zero means failure"? Now for this
particular code, the assignment of "ret" and the use of "ret" is pretty
close, so it doesn't matter. But in the code where "ret" is used for
multiple function calls and there is code in-between, then I'd prefer we
use `to_result` (i.e. `Result` type and question mark operator).

> I hope I'm not violating any "this is how Rust idioms must be"
> conventions. But if not, then all other things being equal, it is of
> course a nice touch to make the code more readable to the rest of the
> kernel folks.
> 

One more extra point from myself only: if one is using Rust for drivers
or subsystem they are going to take care of it in the future, it's
totally fine for them to pick coding styles that they feel comfortable,
I don't want to make people who do the real work feel frustrated because
"this is how Rust idioms must be", also I don't believe tools should
restrict people. But in the "kernel" crate (i.e. for core kernel part),
I want to make it "Rusty" since it's the point of the experiement ("you
asked for it ;-)).

Hope we can find a balanced point when we learn more and more ;-)

Regards,
Boqun

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

