Return-Path: <linux-fsdevel+bounces-64297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3EBE05E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83F0480661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1430F547;
	Wed, 15 Oct 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA0e42Ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF730E849
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556311; cv=none; b=VElHb1Q0j9fY5tl+SznLadtzjCeTOJDfRsy/glOSnQZ1MBvcNbTm5W3NObhDucWrZ0MA1IYP72G+ySOWOF+JFUUYzXUEvJcLWX77IQWRniLopkfH4o4YGBb628lNp+/w9Np46yoye9YFzlJv6ACUvtFVb2tbMO2n70Wb85IwsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556311; c=relaxed/simple;
	bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibYATYy4WbJ+ASe8PDqodU4TIvxD3+4N10nFRSdq5kqofBT7Uhv3p4uFQdkkCFs6jgOjwz3VmIn44xdyaONtu4Pi+sIZ/wWSHOskHF+i+j9vvrBYqcCFxfyl9a+yEi8PDb2dOJf20QgV2UV2FWlizPWOsPxAitYD1SkUvqUompY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA0e42Ho; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-856cbf74c4aso1330144385a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556308; x=1761161108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=cA0e42HoUfvW3gVGL6iILHQaTVyX/2HEor6DEKhjyaVcB7FRSv5qHA29OksEfPZqjS
         t7wxBGLxx8ApRZpqC5v1ILhA8EUiN84/+tYTfRCIyIPr8IfGo/63h5x2P/edOFmMYS8/
         DOOP49a1itunEXOlj78PLdKB2Gph4vdk9gmT2h3J5xmtwC9ga6OrGRNf/VCZeMf4rUtV
         lBO1IpexRrtiZLemfbk+Vods/Cq+LpvJFTJtIGTPVuONUhXgCq5pucfQ9ZBqjHklOUBL
         j9pbyGLmAVVWDd7lMM20z18ms32goqE2sMBByxyyuNXPuTGpygfAx0M2mgM9fH5JDkm2
         xCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556308; x=1761161108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY/3IsdbfI0mC9DM0+1rrUO6mTTZQIEYJMq8pO85TCM=;
        b=nF8/wJjg6IY0Qmcv0SSlb65ahf00NNYjfRFJWlvcCQ5E0PbL+QM35qStr/PpvOIqjd
         rKotaaLCPal6VhOZYNGrXgfZhEMFMblx96mFE6hZ8B97Vj5D7gnOLxDYNFT2Y23scy3T
         6NOzUF+lORcvCN+8eBHPOkL2JBSm7cNyxPDdwyMNnx/zap1L6R6rNPgOwiFG9VMWZ6SP
         sFwnoInA0zqiBDGoGO2FfwtLwRKqtHCd4dUUt/np5skjm5pMDG9l9LLaWyCmuZwJCUCO
         Sml4mJbsNoey56LOCLBYK+1Y9HFZTBPh2KVWw5t1iqO6wkQgql8gt3AIyOuw9g4qygmD
         8X5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDR/3DZmgkjhWafxRkkOPqILTlLHEFpCP9p3qr5PZ6mRmYfbU7WhQja4/Gee0h21Ju2+51UXoG/N0sqUJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEH0G1ZLyCz8H/w8K/5s4VdV+qcxeyj6I9RL8zdFVC1Y9k5In
	/4crIH4LLd+9/0LSWqqa2qXZ0D16Nso4JaOGaeydXIAr+W5j7pnCxMUn
X-Gm-Gg: ASbGnctpvwdfmCvy9JxiqdvaeDpfZS779/+K3IOb3ozKvJh9p5eY44USQymrcbn49gd
	2B/y5HmUrqcMDujlOa5RdN52xnBcDvGEPEGFX40l3wr/9B09AvFxGG9CWT1HcHX67cXIvt94bAo
	PEGFLY+X7ejRfYYj6Qw5PCGlMNd9Sw0JVDtYAuxkm+JWL92yhYGoxL/AP/pH/BlsmMv4k+GAUSa
	ztqjG1nf4AMSwgVsDtW58L/qch3o4Dg6CbJqtF5hcu1UCnsd97crimZfHH3t/bioPuUqyFXY+iB
	qz4qwG/A3RNe1+KCJ7dwbzuXHhZT4MiADmpjn7l73GPHYI/KDgptxLNfr7d/nOofvm5SFOtrqPy
	TB93iK77VIRQMbOAg75+C0mZOprs8/Pwz51ntUbXYzS1mTjdONd13pokkXBQyaejr/tUz/nc/gJ
	/wVs1Ca7yVKeURcgQ4CkOhG9lHivadKYxtOjPkdVAwkvUlNwjo4pWHVa+gW+6GuMBYjN3imsp+a
	djIEzQayPdoxV3z/1WcdjCbsc1M
X-Google-Smtp-Source: AGHT+IF/CUBVvLt2dkQCDA5YZrHOn4tHGJzgB3mXHJTBxXrUXPaXJyBN4wC5HBKmPT8DqAH/ADgWzg==
X-Received: by 2002:ac8:7f8f:0:b0:4db:aeb0:b624 with SMTP id d75a77b69052e-4e6eaceb3e7mr380441741cf.30.1760556307886;
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:34 -0400
Subject: [PATCH v17 04/11] rust_binder: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-4-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1790;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2D3oEpmQYcHuLZnWIpYHzvkvUja5YWzKptv7Pd2qprM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLuOpLGTfFQjBZXdio1nayh5dtiHoR1n54dLy3fgkauJkhueXEntNbGxy1JTge4mrx8nVKiNy+z
 1vw2Aya3HWws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/stats.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/stats.rs b/drivers/android/binder/stats.rs
index a83ec111d2cb..10c43679d5c3 100644
--- a/drivers/android/binder/stats.rs
+++ b/drivers/android/binder/stats.rs
@@ -72,7 +72,7 @@ pub(super) fn command_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_command_strings` is always safe.
         let c_str_ptr = unsafe { binder_command_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }
@@ -81,7 +81,7 @@ pub(super) fn return_string(i: usize) -> &'static str {
         // SAFETY: Accessing `binder_return_strings` is always safe.
         let c_str_ptr = unsafe { binder_return_strings[i] };
         // SAFETY: The `binder_command_strings` array only contains nul-terminated strings.
-        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.as_bytes();
+        let bytes = unsafe { CStr::from_char_ptr(c_str_ptr) }.to_bytes();
         // SAFETY: The `binder_command_strings` array only contains strings with ascii-chars.
         unsafe { from_utf8_unchecked(bytes) }
     }

-- 
2.51.0


