Return-Path: <linux-fsdevel+bounces-8278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199288321A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 23:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B41C22808
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AB1D69F;
	Thu, 18 Jan 2024 22:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BF9461;
	Thu, 18 Jan 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617529; cv=none; b=bn6QtrKgsLFB3Cwvau3ZakkGHT4VffANCxChapVbzShxypti3N6Z9BRPDbF49asIzYKFbWch2k+RpBh6+IkvUN5Z6q6oX8NVthlWRz2IJ5P+GmB9tgzeWFukRoXXi4Pdn+nS28Hsp2UpQe+IIBI16nJeYNNN3cohnbocb3tC1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617529; c=relaxed/simple;
	bh=Uxm3ZCJ1AIpcuno353fMYV7ATucuO6QsXzXIQvNIKCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+1PCDWV8aUac3AoPkQkGVxKwAfuovjiXHEIE/NIdpi7XPRxeO8yXVGJxzOZZ1+m8FfZUjFR2EfGceiidlpiGMGs0zt1PUffbR+Ill6ck9BzT1Awe8ikvHlucYDbcIWrf/G3GXLmkyVUUEQP11kAc6h0PBbgM20biqI/ZE8L6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from archbook.fritz.box ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5PRT-1rRQUy2IBZ-001Pcc; Thu, 18 Jan 2024 23:37:57 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	dan.j.williams@intel.com,
	dxu@dxuuu.xyz,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joel@joelfernandes.org,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maco@android.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com,
	willy@infradead.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
Date: Thu, 18 Jan 2024 23:37:15 +0100
Message-ID: <20240118223715.3995-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-alice-file-v3-1-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-1-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3ZWllC8Ho3Z1onA8+rX5xJsG/l3qEtc5Ga7MCEDrVMq0Zk6MyfS
 qlntgSFZEb3Mpv3UOrHw1L6NsrfLvM4jOkdu+lm2XIgPb2KESk3Tzy4/vbbYXJdDltP0M8n
 wrq1tYEyFWC4CPGlLP7c2hcS9zlRYCIe6L9eyOUnXS2L4iAkBCz9m8C4vbwkQ8gXUkINKiv
 NX+VifNLl/6OurNPKwikg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xesSxXeBpSU=;9lHmk8RuItJ7n6vAzMvDrbgX+Eb
 SpGqgTDwcB3AoAMxyPTeTzm1XlH5c3zBNMVv2GEF6LbgzQaN98cMIHU8iueSCV1MpeTj6HK2b
 nFuslhWGVU9tdGfpO9PpEu7Up2lvIQI6IQBB85PwhHrHm8dxtP1begBJA9DJR+X0+PbUXBRDC
 FUHG2mZMvpWTxTjj8S/beDV8bQe6N3O/A8UNlK+UBi7Vj8eoc3Y2hs3uzWPOME209rphPJc2y
 QYpYcLfIXS3XC7JfnKgYy0rIKQ+BmaxJOnET8+A1e06V8Zxkpejx6J/Re92FZqCr3V7NUI4r9
 RtjkSrPyaumc/RAG8+ZQJC8RqIRPeqqV/UPqPrCdZCYd3zRCjqtB3bf9TzflfCJTQbz1fMPbi
 irA10iZoO0YsvdwmTvtAx02kJoariLsIgAg59juICx7YDm9vGPLbqOf8iZJ3UP0HagRFGsAdR
 kXM61skWLV7WNkyHVTH9WENNgSJrrkOcc7qpe0CzvXwEJlC5X+UhX7td3w8Kp9ODf5d6asJI8
 kPjZ20Mxdxv6EkHzrv8zAyONZAtAZotrP2uSWBRs2KjWWlLdZmCCFXUq9MeVGDKv4pnNzlFj2
 D8cSGk3qpozSwUeYoEWk5xlfhyllRkeOWIjAK2DPOWt1Wm+6GX/jKvK37iKc4rj0JtqYQI8e2
 mhMx1VKyS5xpGm57FzltNjNy09ZP3DNWJqTqYFl6SbjLv14bqUB8ghH3t+rFcThfZ8wPUfCXR
 kv2AHhIsKoFfa6aqqMT9WssODkrNsBJ4+WIKLuKJtpgO9aQGVmxCL3ks95HhDYYpczHg61bkR
 qDqLM1QDeF3/Bzf+sp9dOL/iyNaJgHaR13Gw1T30FPuwbRe3rp0hMKZIJ8JY4mtL1e+xtj7u5
 z+mbt8mG6vNCKOGo6UiiL+vD20vJi7xkSOkM=

> +++ b/rust/kernel/file.rs
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Files and file descriptors.
> +//!
> +//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
> +//! [`include/linux/file.h`](../../../../include/linux/file.h)
> +

These could be converted to use Commit bc2e7d5c298a ("rust: support
`srctree`-relative links"). Same applies to links in
`rust/kernel/cred.rs`, and `rust/kernel/security.rs`.

	- Valentin

