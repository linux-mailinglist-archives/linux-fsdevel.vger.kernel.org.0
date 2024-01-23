Return-Path: <linux-fsdevel+bounces-8624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB1839AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6EF28BF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B83B2A6;
	Tue, 23 Jan 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7vWgQTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3443A1C9;
	Tue, 23 Jan 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043905; cv=none; b=S+/Ibm67yMVR8IzghKtehpHZLf7uYb0YViK21eKBe87Ie23inWIjuGSKZ5ZpZ+TrU84VayxbLjkUAQoihWV2YjGEbTiCN4Z0s0IpRJcXE1MsPcNME7W4roy6TuFu2gQFHrTMZQMGR8FIzd1QSJYW3a+BiRjHETQVOHMETqoIbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043905; c=relaxed/simple;
	bh=+36HjVzztILbkALSK18P0mxKEELvU4cPVnMXhpLO5rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScTje/MJuhVTRd7Yexp/PRMjwP85uRFrasVr13+O71r7sAVnlYGo3vmBw1wB4u18zrYwsYY91KixCbhkrOIwedpFRMyEzuWRxR1FIgxbFqR7JNUKBsYEvwBvamuRXjXIYcqsx4kYaRFtUDrmogEZnwHSox52Glf1oT8xpk9KweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7vWgQTC; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so3230524b6e.2;
        Tue, 23 Jan 2024 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043903; x=1706648703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reh+KxPB+eykScmmnAVnuBclX+torbn4AlTfkHFZ6+Y=;
        b=a7vWgQTCEz5bOJI8hlRN9FPURKMNTK5nPxMh0Q+4TZNhpMeIIk8dIl73ocqMv3WWNi
         jIQXSbYOB19GiV2F3VmZVwvYOjtN4hguge1AU/61rZcnd7J9BdpCAgevgjhumHvcbM9f
         jEtcYOgrLVP5T2/uk7Sg/fLeOXoKzafvxKPeMQbXNfAceTJn0JXAyFtoyF8w+UK3YgNG
         P4CFvjUn6ewmerefyMZHHi5J2xDCa1UtAXFrAmbIdmh47afccLvuQj+HzaNOC/us35ZR
         qMigwWT9DGYeCsKuAtiwCTItf5H5VsUped2CDk/51gF+envklHCVsw7iE6ol/q74lo/r
         vQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043903; x=1706648703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reh+KxPB+eykScmmnAVnuBclX+torbn4AlTfkHFZ6+Y=;
        b=Tz11Qe8ax/6YRd8QJ/Hl48ZtNSvbHiHKqEIZtVcmAOV9yi69G47NxMTGqHN8BqPz8W
         lAQcEIxoencYI8XNzRj3sEGhA5rwZnrL4FvvGGowsyZHEpNtl9hrZSE8lXqJ+aJVXy8E
         4oTuTgSTjO5pQebW01uEpk9CEWlsfXVdVqhPt67UEU4K4dIsX2hikkwC8Y+0ESdDVI7q
         Ix3Cz+REvPwUJarlZuGWOgx0z3UsjZ+DRaGQh4jiJEEmgaIFmbThEzZIb7zS5VvVBd+s
         FYZoUMUpTpZzHkfj6fuWVHYEKF6/BYi4KrRocn9o9E+/h7fhAq/okILIiu8g4TKqlxOQ
         EXzA==
X-Gm-Message-State: AOJu0YyR08qdJxnjh37Ux1I0TWnWGK1iq3UH3Y1OwV8aGIBrHx2S9uog
	hdipxNppoXPLa2/XPvwS30DmTNBA82HEzMTXYw6poIhAcVg8gIgd
X-Google-Smtp-Source: AGHT+IGPJmB4uQ1T57OooaEVQTB+MhiGDRy4/8j7FggDA8w2xlzxyheHEMmGC/zEY7JMRlyABYtdMw==
X-Received: by 2002:a05:6808:159f:b0:3bd:a65e:601f with SMTP id t31-20020a056808159f00b003bda65e601fmr589723oiw.7.1706043902852;
        Tue, 23 Jan 2024 13:05:02 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h7-20020ac846c7000000b00429f883c347sm3739795qto.96.2024.01.23.13.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:05:02 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id CB79127C005B;
	Tue, 23 Jan 2024 16:05:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Jan 2024 16:05:01 -0500
X-ME-Sender: <xms:_SmwZS6JyKWPbwoBa_chgOwEe0Mrtf62Tow5-sw8KHhjm4YJ3M05-Q>
    <xme:_SmwZb7Y_2PETr57B1-lUu_25KiCBNxWshjsl5PIpeHZ7rWcrqesrEsV0Wvu92UXp
    x0QmheGutiMlwsfdg>
X-ME-Received: <xmr:_SmwZRdVMvuMUdP68l_yF2ouqfr6QoMMh1nj6t5vY8ElQ_RRrLRdRb8nzKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfedtheegueejjedvjefgffehheeuuefhgefhgeetffelkeefhedtfedu
    ffeuleeinecuffhomhgrihhnpegtrhgrthgvshdrihhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:_SmwZfJQ-NSjCcebd7sTuy6Kpj27PE6fPgnuyuRwcx3ooiSnviYzFQ>
    <xmx:_SmwZWKnz30vb4tSYMvNuOZqZmIvJ-dY14xLRKzZHzoM1QULHGg27g>
    <xmx:_SmwZQztCu1SQOZiiSkfYGSDGLlF5eVUtKN4OXb-KBYfV9nRgceH6A>
    <xmx:_SmwZb6vyLZb59tvzoo5Fs-pyNjj_U-3CFc50NOKUAYV6SkjdIwAmA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 16:05:00 -0500 (EST)
Date: Tue, 23 Jan 2024 13:04:21 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>,
	Dave Chinner <dchinner@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Ariel Miculas <amiculas@cisco.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <ZbAp1fjt5p4AX27Y@boqun-archlinux>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <ZbAO8REoMbxWjozR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbAO8REoMbxWjozR@casper.infradead.org>

[...]
> >  - The use of outside library code: Historically, C code was either
> >    written for userspace or the kernel, and not both. But that's not
> >    particularly true in Rust land (and getting to be less true even in C
> >    land); should we consider some sort of structure or (cough) package
> >    management? Is it time to move beyond ye olde cut-and-paste?
> 
> Rust has a package manager.  I don't think we need kCargo.  I'm not
> deep enough in the weeds on this to make sensible suggestions, but if
> a package (eg a crypto suite or compression library) doesn't depend on
> anything ridiculous then what's the harm in just pulling it in?
> 

If we are talking about using a external library in kernel, then one of
the concerns is aduitting/reviewing external dependencies I think.

However I just want to point another way that userspace and kernel can
share the code: we can put the Rust code in kernel, and pulish it as
a crate (https://crates.io/) so that userspace can use. This would be
ideal for things like on-disk layout for filesystems for example, where
we maintain the data structure in kernel source code, and userspace can
use the same code directly. Probably this is not what Kent asked for
though ;-)

Regards,
Boqun

