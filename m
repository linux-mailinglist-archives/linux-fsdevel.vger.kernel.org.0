Return-Path: <linux-fsdevel+bounces-76384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFWfAP9ohGlK2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:55:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA8F111F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E92A3035D6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B93A1E7C;
	Thu,  5 Feb 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIztZXVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76A3A1E93
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285286; cv=none; b=dmgBU6hXkIrrs8qoYfji3ErEZ5p1YVksja1dphcmS6Uu8X7I4CA6lhwzmUDYN+JDfXeRSJgPqKPjLPx9L9cAd8iZKcA0VLYtucEW/THdK3LIGu5mKNnligcwhYPsvWuUoNCkz3zUZrD84EjQFK3XPI0MH0N3zYIwYRWpCzvAxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285286; c=relaxed/simple;
	bh=+gH07T7gJ7+X3xesrNA2+Bs3sMLJhA4gaSIsoseJoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f08utrXbOV3zGb/QOzOSeYY4bD43dkB82J08MqdvrOuqxohRkC+1c0qpPVx9bN1pyItTNsPIJcYLA4OCFyPFVzwoGOaBuVWx99ssAMRtWYwIjrdXCtR6q0tNXwh052kKwbv18aPSDGzl9VT1vapw2qQMmQVSfmWM8lulcgEAwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIztZXVg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c868b197eso484664a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770285286; x=1770890086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=OIztZXVg1hLazuEkmqd8LlclnaLE4rA0fxlphw3KvArdlCYxrvdQZyDtKojtlalHtG
         1a66CHSgueLHo3e7wgPFL5SSykTdE+DP/Wqo/IzjGPPDm4GcyVlPjTjvAduAfl8knaW9
         NrADuUlm153qtL+TZOZwB02E5FIxQEvXf8VcuyXxGRlrop4XdAcCjNyZpmvoKpOXaqx5
         iTqPuOKTZ61EEAXWEtUzcfKjsOfoqd6olMTXQbZ52wRe3LltSc6K1bAuQ04//rTzOU9I
         efFMVyoMMVC/Y1sfaoxEqpR0CYhnFWHReEGc2mHEIYgZfGzJCicUald9h2trI26NPIf1
         gaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285286; x=1770890086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=AdDn8Ujw8+xzuSqto0xyGBRFQwib0aF48OWSYwSgEcR61KgZJGQESXPOVK1jwbByM4
         M1+mEJ9VlfkdX1WYyu/21+WO2BxKyJelTTxQCQ+/i5U753oHczxLx9mqeiNMkM5QaG9c
         yuxqUDM4klEqjJ+y4a1PxKZQSBQb1QA0uUzjJp5UtjM4KKqykY0cn3a7qPKr1uvavIcf
         2rH/SG7gCLrBfWbCJVrq5THCTkIL6tmOkKl9jRCSGqhTIQ97pAnGpOT3nO3KVCpNr3za
         lTwevn4HG+djs9X0JApkRFrRx2zOj9dWYYp6MovX+E1IvseSwzTEOyH2ddrlF6qa49O0
         DSZg==
X-Forwarded-Encrypted: i=1; AJvYcCWggPvrrgb2PEGaaLM3Mbsp8Zyi3sJBQ9jsA8im6b8hBG1mlT/REiaw/jr+A3zLJGHIUik0eQ3EN6IxfVRX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQjMXfM42at40LzYTIHk5WTj02MvQVkYS6C1KxmOjEiyp3+JU
	1WRZapggk05eAK3xN78JhKMbs/jH9HXdhPCrjzfp8wFX2aXu2uIujsJt7GYKkb2QC5Q=
X-Gm-Gg: AZuq6aLtxGstXGYZc9CfYI2ekb6dJAJ0wzLN4qMVMI8Kuc9njQXvsUX6zjuFI5kw+Ei
	jljv2c9cgy1mWsr6y5TgEZZwfncbUIZMYIu2s1uOa537QHXlYODXZR0qJBk5gQ/p/QehhdkEtwZ
	uLA4eHLhwep+ShNj4P/1vvBwlDbnbJdIltja1NAG0VIo3HEZxoevuQSeGCKeh8WMUUT0Hn5+VZZ
	QSBhlrCWyGTtcCN6yHqqMXpdazj9RkdJvvFrBBLg9CWH4QhFnJYaJllpEQCqXBWJ+QFa4pq7ljy
	4zWPXa6gnJXiqvdxtkhv2ei1i0uFPwlTjsTe2OJuVL3XeAvejRZin4VlGAdV+/iii3I7r/GGPCG
	bewPjDhajrsSl0nGibzyld74NT6qf0gNrLvTrgwKsSMaejtY32kWClXlyPMf5JK8/eFkzR+GZ5s
	vLgFUW2gWoEQE=
X-Received: by 2002:a17:90a:c110:b0:354:a05d:9dc2 with SMTP id 98e67ed59e1d1-354a05da864mr1522955a91.9.1770285285886;
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354894533dbsm2000361a91.7.2026.02.05.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Date: Thu, 5 Feb 2026 15:24:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
Message-ID: <xh3iuwlz4wapmgzojg4v3sen4oezfua4vsedskvrqhc7ryyclj@jggikwra6dmj>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76384-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org,pm.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 96EA8F111F
X-Rspamd-Action: no action

On 04-02-26, 12:56, Andreas Hindborg wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a760fac287655..06fe2ca776a4f 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,8 +16,8 @@
>      ffi::{c_char, c_ulong},
>      prelude::*,
>      str::CString,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  
>  #[cfg(CONFIG_CPU_FREQ)]
> @@ -1041,7 +1041,7 @@ unsafe impl Send for OPP {}
>  unsafe impl Sync for OPP {}
>  
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
> -unsafe impl AlwaysRefCounted for OPP {
> +unsafe impl RefCounted for OPP {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> @@ -1053,6 +1053,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
> +// `&OPP`.
> +unsafe impl AlwaysRefCounted for OPP {}
> +
>  impl OPP {
>      /// Creates an owned reference to a [`OPP`] from a valid pointer.
>      ///

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

