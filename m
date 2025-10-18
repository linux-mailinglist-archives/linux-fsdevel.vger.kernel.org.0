Return-Path: <linux-fsdevel+bounces-64574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CCCBED661
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B894EF6DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77AF285CA9;
	Sat, 18 Oct 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQn2XBtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138328469E
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809551; cv=none; b=Q+Qa1J0mlz7PyPfuztJ08dahqOjv2NmVzOu7heQFHN78I6LbAkfM1mLtW39zIzrx+dkbG7ayyd1/0YcND0buNCn4S0mXEZ4mWCJFAWadwdSy4sCmSHGGpnD+f/9lV2yu3xMA5xhwqA4/1cojCjzj1TmAxBqOz+pR+YQdK3yawFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809551; c=relaxed/simple;
	bh=CzY30Cbw7NH9BCqW+7Dm4yyfJiEmTcSRj3QBxiZsJWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o7UpGv1bsHCoKZqK2UvMMayvXRF9PSTPPI4SpZhPxUUomQ/S4/hEwEmWUlAFlkyflyPdv5je6Zs7vgFXsP6nxrH29AKEXFTqaOvDAxVDWaCUvX14mW6Ru9KAmNnAADWTwU2xA2cDrubNWe7zGBXtXhUpkl3Jtq1uo2wke0iwfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQn2XBtZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87c1cc5a75bso34439506d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809547; x=1761414347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lawTNFgWMdwiPfh6WDKLTV6aPOfN+Nzqh2uzIhroikw=;
        b=JQn2XBtZHFcfyd0otLfHMIY2rjaug1QAyR3P4HT6Nhx+HGjJ8IDNRoAsH7r+NltaEK
         jT+mD32eTIWFecS4qBPgSgaKG949+MgyP6TcOKiRvoN/IOOiKulaIcatHQ138pUn1MmS
         at2q3Vqo0bJHD72ziz/6guu1rn06JyzC3zTd0A4DORkrXD2BX2/PWgiTj+gS69usb0+C
         Z4pd0Ia28fm2fZjMqThmk6HfJbJrQ60ypyxPqHEfGtRG3bh6AOKUxb92yuOBpQc6iIUN
         7t4DkBAxlVWEp6A5RxIP/7szbwbuYq1IfuLwxMo8cyEoqleYqeToYMkoanI8KR9vMfVC
         zBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809547; x=1761414347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lawTNFgWMdwiPfh6WDKLTV6aPOfN+Nzqh2uzIhroikw=;
        b=uM6umHlnj54FPLI16tMHWmAvt5mpNppJPkCY9oDbsxCuWJ+TomHyPYwsGB4Eq45zJi
         xIkyupgEbMxbv2LMY9eaGcWaQU61tgzZwBg2O4ImxOrh+Q9HklEJ66c86IDF/g5yTTE2
         IJaThXGvNX/she1RXFt/EIi62rIhxVy/wGYlD9V7JSutfZHt04pPKi16MYE1K/n2Db3v
         LJyQwmmt+x65SWfxPzTv91rINE1Q8cO8eczfefIwegK8iBWaQ6yf4f/50ziEFX+RIImW
         Y8HhpQ2ucktZqQggo3PyGT+CuYUMTV14YdwwCwjToRdUBoe3qspmKaWokVB5HyXEYRIJ
         bjPw==
X-Forwarded-Encrypted: i=1; AJvYcCVObvaVCILSMDX/CDLqKssKdLNu+HyxqFWY0M/VDm7dFPlEt49fal5RhVHvniStxj4mT2iGtdny0wjkXY+V@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqDrEkl/3tzlWHBQZsVhLKjGNIt4AuEVFqDJom+ahxZop/mW0
	RkX0hYDoq40sXAQFO7WrnvuIrQjj6MpLzKj4NpT8HxzHV0XeNhcd3au6
X-Gm-Gg: ASbGncs0twtTjNdYLa9PtYe0xQHL34SlRg6u8ncbHaH0xZ5UvB00mS2NwQDwdsPRDCt
	HVipHcGbG1ZNRIK6v/k+xZfck5Cxblapijbr7sVkbs7AVR8IrS3nW0Lzk10PoR+11W2t4aUcyrY
	xpql8GSNZQlTFv9vRa2UYWyrYmcnYm1K/ynUsTtk904OJlNO7/ZPzC6xQv7M9qA4+q2n+ldNx0c
	qp/mPp9t2Q1HDcgEp93jE16WtwJZ+teaDC9YO1LonNBC2G2tVFga2iITun9gZ37DhuqDcHz/wBW
	6Ol3KrwdvZyCsi+VGJSDYTcnZc7xS8Ngr72lF7VF5riQEuIyagyGQFbVwCIG1KWj3jBwoUUyVKF
	X+tXI0HxpKtLYSHVVrQYwZGwilJ70FNGWRSoogOAQQfOGakQ9EEkidYo/t6isRPGLQi1EkVSUpC
	zCg9ZHZPqVvhGfiIaYMYPRPHwuDTumMlI9s4H4q9UmVMIAgZwcb2ZPZVNXkMNYf7SNqLHPoIm7e
	UfM2k1+Mb72rMWWk1r6f6ndLixmXeJVQuFttYvQbRdS+DlRnOAf
X-Google-Smtp-Source: AGHT+IGtoC16cs2IUHy92V+PgbYqI7ItzE0B6P6UQD9FJc874xh/zcTQPxmAHJdRXWEe38KwPk6DJw==
X-Received: by 2002:a05:622a:1350:b0:4e6:ebe3:9403 with SMTP id d75a77b69052e-4e89d3578camr111769721cf.41.1760809546751;
        Sat, 18 Oct 2025 10:45:46 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:15 -0400
Subject: [PATCH v18 04/16] rust_binder: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-4-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=1838;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=CzY30Cbw7NH9BCqW+7Dm4yyfJiEmTcSRj3QBxiZsJWU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCdjYy/3zPtDG6mLhbi/m87N/OQUz3F9LUrbbVL/SdtvY9mUE4M1GxOy/SM9SDWwBVOLExEXvgS
 qD3AZBhe7nAg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
2.51.1


