Return-Path: <linux-fsdevel+bounces-70529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311FC9D845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7101534871A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637935957;
	Wed,  3 Dec 2025 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLpulbdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0A1FE44B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726429; cv=none; b=MfnRKw8Q8GE84gBhNhpZgrR6khmTdFiyYqcuEqVA8RypsbgCZnTX7Fg9V8T57S5mSelV+4bky2pUP3vbN+hl+MX30nEV0/rJYZcA+rjutyGmQVXJh73B47izwilxECeeyEnNVSLot14IkF3Bfwc3gVwVrzOECLOrGtWIeF0cb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726429; c=relaxed/simple;
	bh=3nO+YcV9+oE4XpniiLIyxdEaMIE8lYstD85AACwuLDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe61DcuMFul767WAdrOuoZW0o+av1X2rkUyTUhRnimATDAHUsv3o5AAc+UGCd5T+y6i6C7CpZPmwhpWS+LbM32jQCIYmD087xCoxJtJrlSzwP35PDJB1aq/2UT8bTVkrPPrTZh2kSOEfQjSzwK6b+3GijrV9RnKdBJZvuLgQfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLpulbdH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88242fc32c9so71448706d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764726426; x=1765331226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtH1a85NzPXIElQyhEPKVrfDvnNRb+rvBUgIUrut7Kw=;
        b=ZLpulbdHFBuz7J52MuyOIQ1Y3U8SB9lTC6264JsyNnqSRuJj7m0PZ8y7eKvMPM3Sol
         rLVKMu1G7YfuxL5shNUWpOdxFn47imeoQ6KUY0AX9rlMudYEQsYNJo0X760eiWPXsFmp
         jXbJuWOc+QKgkXBDBPJKuAHezVJEyIL0mC/AgQ/1SXp5PTfThL8Dvh8S/GiBYGibeUZy
         KQJczWyAAovaz4St/568241YXbC56ygndDWzni8BqfwZZkY1JRsUwgNXrj9AtGdF1m1v
         JAbaR73Joqe1miRLsL0NbyzJl/zgU1deueDJNhf4b5XJ2+AziBjqymuQhQuZcXHN/GE0
         aoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764726426; x=1765331226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtH1a85NzPXIElQyhEPKVrfDvnNRb+rvBUgIUrut7Kw=;
        b=o/i6P39P8Vi2U5QnUO6dx42mxpU9EH3sYfEr5q5Wiyhv2P792EyfOpSj8kEQsj/4GT
         hJF1/iYihrSyRHVQqdJPX07Mz/lERLgChEk7S1z1XZLHV2fxR/bX3WrxrhvDv58RE9kS
         ox8dtWZB0I7umYuWRa5ph2sdn2SE8o762lred6Wvejz+251VLtNzTB1Db1E8VLdlV/ea
         bljhtV7I0Ao6TAivvRCaGp1fZrXKpmsbouHXRv3TgtlFcPszUWxfgPfJTHsOYbbnHShC
         BTVKh4y3CT1rNWSZPQ3woOKlWrj8knu60ECzkAkKmCzxnIIdetQKQQ0D8bofS0zGdrA1
         gSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWFrAS0Cvb0vkcaqGWC7xFWa6ailWx3xdPPsl8/DPkHD2BXOxBREHFBHm6YJZCW2nU3s7IYz5Ii/HivX/Vi@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKIps+MvrqXCVVOgRGZCx++L29ndP3dtt6k/5+7SSfOoSUSv/
	WjhzEtqpkBZx5NoPhg8pEnSnBAtrHkV4jyKDfNCGNmhEelimUmRFtnV6
X-Gm-Gg: ASbGncsepphusTFqYf1w4KSGKq1lB5Plht5kXiBuWyKDMaHurPlIGdASSjtHOQ8/vs6
	Z5qeQXA5uvu59AovpXZcmPqBv3GPgDzW28TfQaZPLNvmLqKlztOCb7Q0Vgji6zzJWtteDhSGKNN
	IIjmpGhh4NWtPQV1+l8KycC0gvXseS6rWE9a4WHj8POFBlSKq0qX+gjEbJtAgM7IzpQ3H2dvBA6
	AM70i8Gegi046nDz0mfLD7mi6W88FQJznqvGA0LAMPIjB6pUobk5oeu5Hu1qgj6SPFgafhQI/eN
	ChCMjESy2Dop91uD4Tz0uOXvSkilZr7gurO7YLe6awJV6IAT96Z9mgmk7RvJga1M6+q4IhKqx4u
	IUPhQNkB5ZNP3yTG+85iG4uUa9kj/ZGqezGXo/S5PSfsRN95IJWVHhmFVLLAveFhU4As8RHyaJc
	9m3EZb1RuC81UBwALHHr4wk20LDRsOxWJYmCbHMYz6wi2Z9UOcxjjQ2PG/u92J4XhZymmLt1eVw
	b7l97xGMSZw6RR9Es9tWxmLPQ==
X-Google-Smtp-Source: AGHT+IFeMR+oSVn09EJ3IDZOwhh2uiS4UVZ0hp1HU+YMpxzfU9ogbzDHH3W62a3tJUAdySWBH37uAw==
X-Received: by 2002:a05:620a:2805:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8b5e47cfdaamr99382185a.12.1764726426099;
        Tue, 02 Dec 2025 17:47:06 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524b1aa6sm119441246d6.8.2025.12.02.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:47:05 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id ACD9EF40079;
	Tue,  2 Dec 2025 20:47:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 20:47:04 -0500
X-ME-Sender: <xms:mJYvaaDmnK-eQoA_EF5dIKBTmJFKJG6JnnoegiOnZKVT8CNUG_YZFg>
    <xme:mJYvadSJ45vWYeQ9F5mL5h1nMVY-8bU-OaEP6MA5NELkAMhxMnC3oTCpPE77lCBHK
    7T7DCcgyxDTJotNCxAXaXhpptJ3QWP-MaGb6ZrIeVNqxosuK0JF82c>
X-ME-Received: <xmr:mJYvafxcm6YlRM-vftTxYa0HsgC9YSewKe3-7hU6gkHJFIR9j-dqDET8mDz9W_yI4jfLTFLmfy4EJaHEsee2Ieq8FtBpB-e8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepkedupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruhhsth
    dqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegu
    rghvihgurdhmrdgvrhhtmhgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrd
    ifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopegvlhhlvgesfigvrghthhgvrhgvugdqshhtvggvlhdruggvvh
X-ME-Proxy: <xmx:mJYvafm1w4VDhZtfL-vbtABRjhTNIcFLz8_RoOmFJXiaSOHOJFRUsA>
    <xmx:mJYvaTW4xPwqaL8AsLZ0eWuclQx3vE9Zqhyto1-mcNhBpI554zsuvg>
    <xmx:mJYvaXX2hT3SDveYJ-poTdQsJ8M2nsxtzyvAAaEGn-Ah6ycumKDy0w>
    <xmx:mJYvaS9D9MkMxArS_FuKXUpeU0lMFKOAD8JwuBHAD4qUAR-XYoc_nw>
    <xmx:mJYvaaBq2FcntQ00GFur5OcCdB2TqHkbOovvZlruCm-nWJGwWixyD_zx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 20:47:03 -0500 (EST)
Date: Tue, 2 Dec 2025 17:47:03 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,	Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Carlos Llamas <cmllamas@google.com>,	Yury Norov <yury.norov@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,	linux-block@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	Benno Lossin <lossin@kernel.org>,	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Lyude Paul <lyude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, Remo Senekowitsch <remo@buenzli.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>,
	Gary Guo <gary@garyguo.net>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,	Alexandre Courbot <acourbot@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,	Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH 00/46] Allow inlining C helpers into Rust when using LTO
Message-ID: <aS-WlwsvGrbGYIYs@tardis.local>
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>

On Tue, Dec 02, 2025 at 07:37:24PM +0000, Alice Ryhl wrote:
> This patch series adds __rust_helper to every single rust helper. The
> patches do not depend on each other, so maintainers please go ahead and
> pick up any patches relevant to your subsystem! Or provide your Acked-by
> so that Miguel can pick them up.
> 
> These changes were generated by adding __rust_helper and running
> ClangFormat. Unrelated formatting changes were removed manually.
> 
> Why is __rust_helper needed?
> ============================
> 
> Currently, C helpers cannot be inlined into Rust even when using LTO
> because LLVM detects slightly different options on the codegen units.
> 
> * LLVM doesn't want to inline functions compiled with
>   `-fno-delete-null-pointer-checks` with code compiled without. The C
>   CGUs all have this enabled and Rust CGUs don't. Inlining is okay since
>   this is one of the hardening features that does not change the ABI,
>   and we shouldn't have null pointer dereferences in these helpers.
> 
> * LLVM doesn't want to inline functions with different list of builtins. C
>   side has `-fno-builtin-wcslen`; `wcslen` is not a Rust builtin, so
>   they should be compatible, but LLVM does not perform inlining due to
>   attributes mismatch.
> 
> * clang and Rust doesn't have the exact target string. Clang generates
>   `+cmov,+cx8,+fxsr` but Rust doesn't enable them (in fact, Rust will
>   complain if `-Ctarget-feature=+cmov,+cx8,+fxsr` is used). x86-64
>   always enable these features, so they are in fact the same target
>   string, but LLVM doesn't understand this and so inlining is inhibited.
>   This can be bypassed with `--ignore-tti-inline-compatible`, but this
>   is a hidden option.
> 
> (This analysis was written by Gary Guo.)
> 
> How is this fixed?
> ==================
> 
> To fix this we need to add __always_inline to all helpers when compiling
> with LTO. However, it should not be added when running bindgen as
> bindgen will ignore functions marked inline. To achieve this, we are
> using a #define called __rust_helper that is defined differently
> depending on whether bindgen is running or not.
> 
> Note that __rust_helper is currently always #defined to nothing.
> Changing it to __always_inline will happen separately in another patch
> series.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

For the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
[...]

