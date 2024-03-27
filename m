Return-Path: <linux-fsdevel+bounces-15484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957F88F1E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 23:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970DA1F2E26E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48F154456;
	Wed, 27 Mar 2024 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXAMtdvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D053371;
	Wed, 27 Mar 2024 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578411; cv=none; b=kV0/pj8oa3lmpNH3Hl9vJlHsRq8A8or2wxAr8yMJZTeRa25lOwlJwnuJxzSixSyl2ak62L8YDl4SEhUyyldFCfPEvf7dbuualdtTdUzP3igMjOGKYsxpNgRPMc8rDOvsCI4t/Y5jLsM3KsTgUGjp16s/qYc0Jtq96bR5Y84w86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578411; c=relaxed/simple;
	bh=0Eet4ylxwVn8zzff8qm5Ev6iikG6meyrEjfL2p8QNSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR90pNOd9w34PZd5F2D+rWHUlAVm2ijV6t1KGrabB1jDwngge7fhVaNdU/sUigLLzg7GMLnoQdDxVdkJ9OjstobuTDrEsv4r4Ult/VWsOrfAQQaIvJLVE3mkPu28I+2T0UabxxAGq1Pg9Fa54t8gHCXemWchHhI16ynKELRBSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXAMtdvT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbc649c275so216530b6e.0;
        Wed, 27 Mar 2024 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711578409; x=1712183209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwkzJWECmlG16QHW6cdxBA+RFUUXDB2JZzSWnyJ9i9M=;
        b=eXAMtdvTXcqrV5fF/gApSbtWEJX1d1Q0V78I4hziiI7KwefykhWOytUA285ZGBt1R1
         4Uo2x6PjZAX0PPZ+GZRy4skuQoUX1tJUkKJgMWxQR50K+SubocvkbMj5/gWFRk6oegb3
         PUC/FZ86Blnbn97i8UzIIwg9Dfr+hLKY4UKGnha8QCFmIm1ilYshQUlJ6YYBeQc5GZL3
         HZCUDVR/j8OFStPZHBDL5vxNS5OEK7C/UxDakmv5sbNLD5o1egKd/UQK4ZLu4QLHb811
         J9sPh+6ilBSFX68sKdxn6dNzZYHRU1g9r/01uSW36HV3ieULTkVkwiFBiRmwrNqG0cmr
         LB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578409; x=1712183209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwkzJWECmlG16QHW6cdxBA+RFUUXDB2JZzSWnyJ9i9M=;
        b=GeYoJ3EbflZgQjpcLG79IVHnbjS+hTwFKe3RH05aXWFLQpzr1SFxng+QWhbvoxhqeX
         EFWFGIHsW2Zn8IkozqIGuiTjoCQwrgBBH8+NgYaNFYWLApavzDHunCFK3W/TprL/46yz
         zAGJdQhWs6036RC1ISaHzwWPf+S7+pTJPTdgI/NjndhlxI6tu8U1RQLpSlGMHe4P7BqS
         RAr90+35OGC4lj+NhF0wqawqTC+YRCVgqOwEukwLjdt6IBkgYIF1N4ld5BKT7YnP8Guf
         9WnKTJJI+E1BpASCYk5V7WYHlmXH/XsaQ450ZinQ3TwxpCdD/iH0pb8C1ufQGBh95nd4
         FDMg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFjrY6b0WTIyQcxp0No5mjVFcFOzLTxv6VfHePMBdAWQxAPrANuz3KsyTJmGvBr9gxDIPW7LlaCuJIeJHUH8wiktuszS+mTBqWCwQ/V/cgrf2FjpJMtXnNA/luhLZpZ1Pr8LpNU2nFYB+7BAuLLzJhVzcm97xNuDu6ZlMWM2Z4SqXlS81wMhz+CBE+qbgS24nC8ah1S+wh22i0VNW5YxatyKX3HP8UA==
X-Gm-Message-State: AOJu0YxpbKacbHHr9LGnGW6lAoWzdQiQ3KHRtww9S7LW5T1QfeZe8VNw
	1XiN8+hUNbW03lwT5q4S3FUzFIcPR9CyQTOWTX9wLQSFUJKAe6T7
X-Google-Smtp-Source: AGHT+IHGjWRkib9W0zZ7sBiv2+oNDjTn8vPgkUQXGuUBpsO88nnHMrIhshfeJQFgUjASDsrFPq59RQ==
X-Received: by 2002:a05:6808:1920:b0:3c3:bc13:2ef6 with SMTP id bf32-20020a056808192000b003c3bc132ef6mr1745797oib.43.1711578408539;
        Wed, 27 Mar 2024 15:26:48 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05622a1f8900b00430b907c234sm44446qtb.26.2024.03.27.15.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:26:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BFF2F1200032;
	Wed, 27 Mar 2024 18:26:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 18:26:46 -0400
X-ME-Sender: <xms:JJ0EZssyggSfZ6YjPdCrgVHmiiYnF9ISGg8qRTw2dRlJ_4OtCPIqng>
    <xme:JJ0EZpceLAoOOR2BkRinIpB7dRQsbCeREWac5nra_IXl2PydmcB8OZW3KGErvv-26
    O0FtNTCXxnnY-BgWg>
X-ME-Received: <xmr:JJ0EZnwI2RQuYOE9TVkfAjn0DQ5LI00G7ZxHqNtuOdJFb-LnHSgcixl95Gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:JZ0EZvNwO33iGaiqTG-7ZzVuMMV87SwZDByVEsyd7zmVMGfHE69hKg>
    <xmx:JZ0EZs8tEdCQFG8o_MfzJWRwjFgYey-NnTcb_k3LlVNwB9UV3wsQgQ>
    <xmx:JZ0EZnUXM0RUg3Z1xRGgQQRPQK30oby7EvU786fOMY_TowKu7F7hEA>
    <xmx:JZ0EZlesTXnuse3WVFfYtD1w__b0mzjqGbRixc-X4rlPGNIvtMZJ6A>
    <xmx:Jp0EZvqzuiYJ8N-zPPc5jkCgD_cpCsPArUQB6bhYGCfZuCjG4HTPG--mOzIEAWfZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 18:26:44 -0400 (EDT)
Date: Wed, 27 Mar 2024 15:26:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,	comex <comexk@gmail.com>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Philipp Stanner <pstanner@redhat.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgSc_8PuBNs9Gp67@boqun-archlinux>
References: <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <ZgSNvzTkR4CY7kQC@boqun-archlinux>
 <iurfeuqq5hfwhv66d2wozlzv24avyypgtgoqpmorghmimzqwur@zj2qfot47d76>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iurfeuqq5hfwhv66d2wozlzv24avyypgtgoqpmorghmimzqwur@zj2qfot47d76>

On Wed, Mar 27, 2024 at 05:49:41PM -0400, Kent Overstreet wrote:
[...]
> > > Strict aliasing is crap in C and C++ because we started out with
> > > unrestricetd pointers, and it just doesn't work in C and C++ with the
> > > realities of the kind of code we have to write, and we never got any
> > > kind of a model that would have made it workable. Never mind trying to
> > > graft that onto existing codebases...
> > > 
> > > (Restrict was crap too... no scoping, nothing but a single f*cking
> > > keyword? Who ever thought _that_ was going to work?)
> > > 
> > > _But_: the lack of any aliasing guarantees means that writing through
> > > any pointer can invalidate practically anything, and this is a real
> > 
> > I don't know whether I'm 100% correct on this, but Rust has references,
> > so things like "you have a unique reference to a part of memory, no one
> > would touch it in the meanwhile" are represented by `&mut`, to get a
> > `&mut` from a raw pointer, you need unsafe, where programmers can
> > provide the reasoning of the safety of the accesses. More like "pointers
> > can alias anyone but references cannot" to me.
> 
> That's not really a workable rule because in practice every data
> structure has unsafe Rust underneath. Strict aliasing would mean that

I don't follow, a plain data structure like:

	struct Point { x: i64, y: i64 }

doesn't have any unsafe Rust underneath I think.

> unsafe Rust very much has to follow the aliasing rules too.
> 

The point I was trying to say, the aliasing rule on Rust raw pointers is 
relatively relaxed compared to strict aliasing in C since Rust has
references which should have more accurate informatio on aliasing.

(but not a language expert).

Regards,
Boqun

