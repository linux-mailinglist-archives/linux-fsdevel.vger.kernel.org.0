Return-Path: <linux-fsdevel+bounces-8669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF9F83A04C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 04:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3401F2B241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05660C132;
	Wed, 24 Jan 2024 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnfDVaCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD086105;
	Wed, 24 Jan 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068685; cv=none; b=peUKWFuiYe4EulQjTVL+T1EZeBi1ygNhStBqMvYx0q3gCLrGvZ2S/GDawv2Ng9G99rcEUQ6o4Dg5uOwafbfeBlkvq3wR+zus4P9c/OnjbmcvQXlZ5XDk9Awgb6miph+0VxOV3WrxR75CUldcuqWP6mKX9ZAOQk4f58k+vBCAXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068685; c=relaxed/simple;
	bh=h/rb248OA03TSbrqF0eZgJ6CT7ACloF6JhCPBkV/Df8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECNU8S7prYevIRog6u7cDhvTEJI8jjw5m9xS2bIkAo0xMSsQlZ2WPm+lnDRJuuH+vdCsXlukZ2pjWlvSptmxlB801xZeE67fqBygWoSWlx4HM3MPtK4dxG7qUx079ET4sW4HbRsUIXfZd6sL3hP6HxE83M7MYep9fFmdpOZAZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnfDVaCF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78104f6f692so369533985a.1;
        Tue, 23 Jan 2024 19:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706068683; x=1706673483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkDGd++VYhFkJLyUlOlXCT60hFOGwDxW/O9I/vnFLB8=;
        b=fnfDVaCFxcH5YeiY9SYIz79uQ34CfQKy/QD2xC6jYrSLkrTPfdbul5fwpDY2eacO4s
         N9B3h224hbyzQDI8qGm9fwt4RnasBjwQHufaHnCeL9Jt5ZMEDnSy5l4a96D4V8bLX01p
         pZb7G0v3Ea66voHOUUpon3dtOd8hwlkS0nPFmZpjtepocQOZXe14S3rP36+Sp7jYY/w5
         5RTyoFBZBSFy0PIsBJncBS710JqOyJj90AMplMOm3xPCKdYRBr1P6MvPTFS5scw7NcYr
         h/puS2oHJzBdYMDK7eg3wgCXHZ2lsNiSdk+R1+fK9FQYCM5or/mNeLgP1uqgxTdtx+eY
         oieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706068683; x=1706673483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkDGd++VYhFkJLyUlOlXCT60hFOGwDxW/O9I/vnFLB8=;
        b=H3Kjp/BiPDeQzK6F5l24WhUIGTednIWCLIoI2lV5ghn7h0l52Vv3yQVwz+QUAvuGPy
         nMHHVOpAcxy8v0vJB1wJwIV71dOTaOSg9CpWnTVJVJtwu8DXD5YXjHxKXQhX3gbhSr4r
         VfyvI/v7DuIjfHMdeeUlArdgy0S7uaD8vUX7W2JWp7BZ86W5red4y+CiheB98ORLGUWS
         ZDXKWr2QlxY3y0q/XHC3pWS2AWmI83Dl5DEHe3FzS9fHOwzEec58GMtZ66/hm6QI5Jx3
         YZeptAnzpooWA4jNTwEa08pDYvLBYJqCuvDyKV+ApwdkcGY+Y+wmg8cJv3icCoxDQaaI
         TYPQ==
X-Gm-Message-State: AOJu0Yx3XsP9aW0r19DNvph/8a0GxPA3veubNjFyEn7B3G/0NgI8Q2Za
	e8UQUKh6kJb5/DRYhqLJRHxKofuvdwEX9R6S0b14TN3UKA4GSwnw
X-Google-Smtp-Source: AGHT+IE9OX9sgY+VSjE4vn+Zdbs2u9x2Sc0H683YVWqVO7IMwsnLp+nq2gQgPEwie/ruc3uasFNO8Q==
X-Received: by 2002:a05:620a:1276:b0:781:e4cd:785a with SMTP id b22-20020a05620a127600b00781e4cd785amr869883qkl.21.1706068682752;
        Tue, 23 Jan 2024 19:58:02 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w7-20020a0cc247000000b006854ec9dbabsm4067484qvh.92.2024.01.23.19.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:58:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id AF53C27C005B;
	Tue, 23 Jan 2024 22:58:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jan 2024 22:58:01 -0500
X-ME-Sender: <xms:yYqwZRZrlU-twhTHaHr0NRbBr80xXMbRL8gL0nRaueQdMlBZgbaL5Q>
    <xme:yYqwZYZ4EjUegnOcrNbQTx2pokiolvBS2esTvaSE5Q0w9eXR6BPX9DOIKDsZm_Kld
    z8JdU_TCZP0QHuEQw>
X-ME-Received: <xmr:yYqwZT8NDniyx7xmUf0VGXcrfd-yavkj_Haueu7F_1pcBiSu73NiT4MsXEltxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:yYqwZfqp2drSoYEmCnD7tRE5h3zU1aplA5fTtOhmYv0J-FcyRf3b7Q>
    <xmx:yYqwZcq_H3jcmD64IyXk0qlbAJFGLVhOfv0QT5IFYg6DEauZEcuKQg>
    <xmx:yYqwZVTB8iYSh2PV98IuMyIIlUwsMLrCHtWvAbIDT-e8qRIClZ6bSw>
    <xmx:yYqwZYZCimC5AWbHMwPd_3vtULTXOvauuUVD7MLaDBh46ewmnaxNGg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:58:00 -0500 (EST)
Date: Tue, 23 Jan 2024 19:57:20 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>,
	Dave Chinner <dchinner@redhat.com>,
	Ariel Miculas <amiculas@cisco.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <ZbCKoKB4OXzeTIgo@boqun-archlinux>
References: <ZbAO8REoMbxWjozR@casper.infradead.org>
 <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
 <201190.1706050689@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201190.1706050689@warthog.procyon.org.uk>

On Tue, Jan 23, 2024 at 10:58:09PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > I really want this to happen.  It's taken 50 years, but we finally have
> > a programming language that can replace C for writing kernels.
> 

(I'm not sure Matthew wants to rewrite the existing kernel piece in
Rust, my read is more like he feels Rust can be used for new or
experimental stuffs)

> I really don't want this to happen.  Whilst I have sympathy with the idea that
> C can be replaced with something better - Rust isn't it.  The syntax is awful.
> It's like they looked at perl and thought they could beat it at inventing
> weird and obfuscated bits of operator syntax.  Can't they replace the syntax
> with something a lot more C-like[*]?
> 

Isn't the feeling on the syntax (like, hate or can live with) really
based on personal experience? I'd rather not use this as an argument,
since I can find syntax haters for every language ;-)

> But quite apart from that, mass-converting the kernel to Rust is pretty much
> inevitably going introduce a whole bunch of new bugs.
> 

Desite whether this is what gets proposed here, I do really want to
agree with you, but I'm not able to tell whether this is an educational
prediction or unnecessary worry, since I could say the same thing for
every patchset that adds new features ;-)

To me, it doesn't matter which language wins the "best C replacement for
kernel programming" award, the lessons we learn from Rust-for-Linux will
likely apply for any other "high-level" language. Hope that we can all
agree on that it's all OK that people want to try out new stuffs and see
if they *actually* work. Because then we can discuss on something
concrete and objective.

Regards,
Boqun

> David
> 
> [*] That said, we do rather torture the C-preprocessor more than we should
> have to if the C language was more flexible.  Some of that could be alleviated
> by moving to C++ and using some of the extra features available there.  That
> would be an easier path than rusting the kernel.
> 
> 

