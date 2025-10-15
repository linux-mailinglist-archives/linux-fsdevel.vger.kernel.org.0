Return-Path: <linux-fsdevel+bounces-64298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A2BE05FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2884F3580F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B6930F936;
	Wed, 15 Oct 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqqtQJJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65A30EF99
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556313; cv=none; b=UDKBxHsg7x40Y/yF14n3pVXjD9SQLh8iPTJS0V6Dcr4j8kX5dgEdUd4KzGDjYM6buNiIROuXdiPQKkqS4vp67GKvTn5+9AFamal/i0TT/6f0nXADrBXlqsA1JfT1SbRx/iBqWMw9+SNbqr56l26S7i7w4b0KKTtGU9Jk858IHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556313; c=relaxed/simple;
	bh=KlspLvr521ZswwzUDPIsBp2B9Wg66z4eaz2g1WzaBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjGZnPradYJUmhPp1STmCUmVaD7El6oOgStyrqr3Q4NXQRJGhl5ukrF0Ey+BkIps9K2bgiqoTyBLA4FHm+9EMPMw9+xfky6am54xngtQVobXnOf1rv/3wnvDcdyDli9SJRFOyoccYvaxcAXCnP5XLF6+i1e6zcjiV1phc4VpP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqqtQJJ7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-795773ac2a2so85635006d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556310; x=1761161110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlH2K2eTZ1PSArwqcAz1RbXMF6sxizBGN/Y8PHlK+Wc=;
        b=dqqtQJJ7q2mvoF1LmHDRpIvCUFDiczBljqWAcANZB8KY4/h8tV7bQLloX5+Kdr65Af
         N6dXvuuOqFQejwyS0Tld87zQlzCCaCP4TpQh95i79NcTCOeVvUtf3n4otaYCe+Mamiur
         Q9dBCP2DJNBDbe4iWAjyK8C4vTuGdugwxLrJF3y/Jl6Fb0jAjYu703tDrylIVIHqYlLH
         jJwCQPGnXK4GbQNimztnjj2sflq+0ND9/UcPFeH9S7pZr+cMU26498qRT+PheMiJGHmX
         NtJY+qVn0bZ2pZpshFREMi2hTUeUF8qxUJAdkinoObmGHZ6GIW68lrTRl66eOlelHMzN
         heYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556310; x=1761161110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlH2K2eTZ1PSArwqcAz1RbXMF6sxizBGN/Y8PHlK+Wc=;
        b=FwRbm7FaEfuHtYCqp3vs09/IiU2P2bGyjWfFZM9y4CnjaBg6Q8hVdESW4t1IA9FWpb
         pczmt0VTgM9gsbpgN1qKK0vVnYHk8Fv1qzq/aG2JxNQvqFj7fwBysmFhUQptXNd7Ivw8
         0+JYrz8UGXx5aZbTycaVlQxbZnAFpd6apRRVQCKkVVyqSEh9gbkOmVDHA/8hfBjggE5/
         ENp0SvF+RIJViIQsNLBPsM9MMyRv0cY9RnrKFBbneuyJhbFsrx2kxTDjfaEYoY8HSZZb
         Mg9PZkygtMgaAxCd+IFDpsIu2F5X8N4mRPphCdZSmlj0p5YRYNI9ZLOwvWMeJ+d8Z8tk
         0t5g==
X-Forwarded-Encrypted: i=1; AJvYcCWATwaX7iYFcQXWSE9O60zdMm4sRUNpc9CebsuP/Lmki5qXyGDRmV8VrFM2ebR66waxA1WsM5HHhNoXGkjE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/1sBLpQ/sOmYOanTJxRojLOZ3vP9YTquwN3+xSIVCAocusax
	9yqiXNT4JTbtADPBrXz4gzcAqxUTCC97SHE7eflE+lx1rmz8QUsItIzD
X-Gm-Gg: ASbGncu2djrK2xhjbN20g6eJfBR9BXtGGP6S4/6g61D8Ipci+zntn1N8NLGpXzrQCMa
	doOE8/fbHeaeG0LdIMXFt7bF26P39bhZ8USiYVMnaXAcN8B+tmJRu8p0keKJ7Vx5BWbBV8qui74
	r1Xvii8Y8VIQOTtj4CAAORqiO9Ena9h1JonqkVtDEEee+SSVunMAEP29UXVfrI1ZstDGROoDzj2
	VTDkjKIO4MGlUlgHSTo0O52U40/cITvvddBTkQsW9SxvqGhuBXlsgay6fByP5CVS3q4OOOTTU91
	NH9cV7HwyJM0VgaI3w7+4P3qq5yb0HFWRCGaHUMPchusC69xJezHFsOA8j3e2Bw3k2RRiD/GGYa
	CoY9uydisyB8BXlgvfPqybXpNtcXQXjwjd+BEVvO3JSx2cnx+Jybt7f8DWvtqmeYTymr/qCcIIX
	enpbq6WHvQgKem+Jn5h7v02HygMfY6S1baA7tVAajPJalFZ8erPHqnB0X4OPP83/nj8ektQaOT1
	HbXbKO1iXQUjdBxnfJQ+b2IwC4f
X-Google-Smtp-Source: AGHT+IGPF1xrploY4yyf3/qJv7Wa6m7LEZDAuiBlGyAxIyb2xiX2HjjGqOaaPv9jGE8ttZXyV/gqwg==
X-Received: by 2002:ad4:5e8a:0:b0:81a:236c:c846 with SMTP id 6a1803df08f44-87b2ef6c9c9mr354624946d6.33.1760556310156;
        Wed, 15 Oct 2025 12:25:10 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:35 -0400
Subject: [PATCH v17 05/11] rnull: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-5-dc5e7aec870d@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=1516;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=KlspLvr521ZswwzUDPIsBp2B9Wg66z4eaz2g1WzaBxk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHxMXWDjPc4JHWDJF+k+dKHv7GUEw5MjBiz/HrOQDc00FLmk5b2RTxkdaw7ylNTACU7Exa4g7kq
 NOXZk/P8Bewk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit d969d504bc13 ("rnull: enable configuration via
`configfs`") and commit 34585dc649fb ("rnull: add soft-irq completion
support").

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull/configfs.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8498e9bae6fd..6713a6d92391 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{NullBlkDevice, THIS_MODULE};
-use core::fmt::{Display, Write};
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     c_str,
     configfs::{self, AttributeOperations},
-    configfs_attrs, new_mutex,
+    configfs_attrs,
+    fmt::{self, Write as _},
+    new_mutex,
     page::PAGE_SIZE,
     prelude::*,
     str::{kstrtobool_bytes, CString},
@@ -99,8 +100,8 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-impl Display for IRQMode {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Display for IRQMode {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self {
             Self::None => f.write_str("0")?,
             Self::Soft => f.write_str("1")?,

-- 
2.51.0


