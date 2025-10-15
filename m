Return-Path: <linux-fsdevel+bounces-64302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A21BE0638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85974F5833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2F306B33;
	Wed, 15 Oct 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAWmy3km"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413B310623
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556323; cv=none; b=QwFYGpgR9+cInxEJAZJEhgLztp7ZGvM3LVT71vgAZDZBsL8SPGXwAScRkffRsHXs8ncp85rLevr7wXCHcqau531njVfpYx3yOTgpmOo2KT2oM+A8g7wS5GgIWxdYpi85SOnNwRnH69NruJzNC8/Cyt0xg2TpiNqHwGDWg0KTsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556323; c=relaxed/simple;
	bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ak18Zzly5hFzUKSs0yk9q6QcPbQVF8wQzhE1/gMllGJRsa8A1vPtbd1OamGBTR6MMOOaIYNnJnn7cmDZZzhSVXDB0dUukH1i3DEqQU9hyS1ye/iEbhLxBIUTyKn015XSXlOAm3/T/W3HV8lY5GKD9e7PD5hZ0yG6ZtcPdXetRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAWmy3km; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7ea50f94045so19391636d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556320; x=1761161120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=EAWmy3kml5F4+VbSFVMMwmSbTG1JPrXc25HIJ7wTREx+dvdcv925LAr+3H/MK2yo8J
         3b9T0AX5Ziu4paKrSgcqxGTenO1PwPrhrzkoNEbyIxoWWF+Aq3cWbc+5V2kh4UQ7AA8E
         VQsfzcDkX92HSyd5p5oao9KAr6R1RVTKp7/itf1AdXmq07NlGuakb3PvyX35cHUwmxC2
         6fjYPFDV97+fr4if6sLN4cmCN0hWUKM1L9CBEYXRKwNeu9kOCNzsg2+6Ek2mJsUJ0RPP
         OkPwUg+mIY2Pch+B8q08Kn7Z3MuD/FVy14virXSGtKUv+g0ES3E3mh0HVDExPtD2Wfh/
         SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556320; x=1761161120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfr+jg9qjRBK3esGQQzBD5L0g4VK44y370TXRFAq7lU=;
        b=gjq8iyJbOEigMuGM7CcSveh8mRk6X3oafEol/wkLkKbKRLpPvYaN9Ta308C7aYMl3l
         k/VRW58FLmZ2yPEzQObxCMODV4va3K4rbgj7Uji+wUBEYPTVRzNe9LiJOe6PfGd5C/Wv
         /Dla0JBXNbglEKk1hBMFiBo8nEv+hwuNfVj3UezGOip1CvahWExTZsk/Q9RBUQ8Gg4a1
         /C2S8j49ZRCNsHmxKXMSh8Tbt6EuRoA0PsGoGVE5RleZIXh4RQe64av2h5BrTO+TjBx1
         C3/chAAa5kT1JCHbaZwbd8kC9PV5KuajwC5MkNVzYvdD3WFwvezfISO/uiwtLVS2XzR+
         75+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIuspiMyR5oj48gudJmOfwir2myi5bjvkXYUeKBsGqUug3rArQLHSAWpC0SrkaBpPbJOQk5wEL70MPZJl6@vger.kernel.org
X-Gm-Message-State: AOJu0YwUzA7Uw3tRf/h2fFRPks+6ShIo2hmQhk3hRK5eOl4qqgRk6YCj
	ugQWxXHIbBnYxymVfWuvOTAkFq3Qc8vi/FuTTgILHKx1QiVfNC7b0Dq0
X-Gm-Gg: ASbGnctMAmfCIxgnxzcyTFifAe3USpX/q7p5Mezkz6okp1cMM0pTdQDkgo7UFs5hZ3U
	abIoMef4efNKAdKieCVrVFXvrPeMHgV4fW00IIcXgR5m+jSqP944Zvy5/AcuQ5uWPsyl9VKC/kf
	CzHIgt3ZTAtCRDiVCaAzQvO3Thz/xYqMxMCw01mLJ5B3qfVcQT73GlD088JvSDjkpWv7zHZz6Ed
	Ea3uAgzGcffgKHUzvoH1MUG8OFce6UDRjArq2tFyLoeSMBzRJgq4YES18V7KQmvQHziRDCVyAsR
	g5jtRGykZZXLefXNIuZbOGHryzEAGELi0G/FCrqKU6Y9j8KFipCQAeKELKsWXvB6MvxTOQkkKqY
	HtKVsTh9UoWJxUP9s+AU4KJradH6U7fsaRsZKHqyzCOuuIi7ILHmwGIdvUCE8KKBBu+eaxp3nf/
	DoYZB4HtfLCQnxUAU7Z6iEp2n8txylB/w8V+sqJIRwalU05cT4Ceiprd/fY6vGkZJjaEpaqHR9T
	I65qf1bOpLhTIX/OlJgjaNW8hwxgRW3Pakosc+5WNjVcIOSG5S2JuQDXpdxEPE=
X-Google-Smtp-Source: AGHT+IEDOgFM0nazGEEfzHtKDS647mvDkfCfJSWTYyfnR0K2d3p2LPiGQli6GsrPQ32Cigz0HxquCQ==
X-Received: by 2002:ad4:5fc5:0:b0:787:f736:bc66 with SMTP id 6a1803df08f44-87c0c5cb92fmr20009666d6.1.1760556320049;
        Wed, 15 Oct 2025 12:25:20 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:39 -0400
Subject: [PATCH v17 09/11] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-9-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556296; l=620;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5hkdJMBXvyM5ROn0CqVVfhpYPBMFyjtfSpETEaraIms=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA49f7ifUr2XwLcazgyI6X2saN5gtmXaaA6IvRCW2zqJXH2aWsvrcTeWwyt5IimaZuePXX9+Xm5
 hOtGKK/bcVgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/ptr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 2e5e2a090480..e3893ed04049 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -2,7 +2,6 @@
 
 //! Types and functions to work with pointers and addresses.
 
-use core::fmt::Debug;
 use core::mem::align_of;
 use core::num::NonZero;
 

-- 
2.51.0


