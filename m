Return-Path: <linux-fsdevel+bounces-55522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12438B0B3F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 08:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA75A1724DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 06:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138E1DFDB8;
	Sun, 20 Jul 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YmW1K6X8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA661C5F2C;
	Sun, 20 Jul 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994385; cv=none; b=MIqdEzJy+Zf3kKN3LTEvOYF93oZghmTH23FiBmpOPMk5alMPSUV8XCfjkkEn8QSI5ikbRClvh+6eaOSESvpNwtKxPhHPQZ1BaYy1kUnzlTqQDL5piTaqlddmOZwH7PQxQIYadQ4HvAUO+7yPZGV6QWoj87xocehrNFK8TFDyx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994385; c=relaxed/simple;
	bh=6AF1DrYAjh9UiBobvuPlLao7ekzQEI/5JlPKdx9Vvu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJGPEj97MFMT0CVbRjJM/lAt3qGefWA2cTmGI8h5pnxyQ6hWQ+IKcQmpu+IRvtHAFTvtV7BrRzb/1UIV40ghQVdbisKm7ESopQZd+aw8yKNl94m4FxsXgZnreixAhJCPxtQe8I2NMC/2Ts9OiENDlRZF7rDxhgUBQGOr5iwBO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YmW1K6X8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0X3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:50:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0X3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994260;
	bh=rTdzYvwFHc/obNMmPtvKZfNfhBVjDuwkEkiFsct/pho=;
	h=From:To:Cc:Subject:Date:From;
	b=YmW1K6X8nh5gvx+/lSaLL/0uVHsAorsxD+AVsaUyPiomu4l2Jbf0BfVqyQpPxeoO9
	 kr5smMv1P2CI6IH4hiMwDx1+VV5DzlIMt8CxJShOD63VVlIfqYpUZYD7StXNc1s+as
	 TlEMiqy2G350jxTX+x1Y2Ql+ORTOydINiaJq9CGtdg6A11P5c+PhVpuWEf5f5W1Q3O
	 am/ZAB0HJioLUUtB4/sAiRstoaTRokISJSjRNjfFBOWIc5W5hlAH03xyxYGC+Z23Y0
	 DEipT/5KCZeI5RAXsfCvHLzmp9kPkp3m0uETy1p5uCRXQ3MHxcJZAVKZdSLBLVbSG6
	 nuRE85ysqy4ew==
From: "H. Peter Anvin" <hpa@zytor.com>
To: 
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
Subject: [PATCH v2 0/7] Replace "__auto_type" with "auto"
Date: Sat, 19 Jul 2025 23:50:37 -0700
Message-ID: <20250720065045.2859105-1-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"auto" was defined as a keyword back in the K&R days, but as a storage
type specifier.  No one ever used it, since it was and is the default
storage type for local variables.

C++11 recycled the keyword to allow a type to be declared based on the
type of an initializer.  This was finally adopted into standard C in
C23.

gcc and clang provide the "__auto_type" alias keyword as an extension
for pre-C23, however, there is no reason to pollute the bulk of the
source base with this temporary keyword; instead define "auto" as a
macro unless the compiler is running in C23+ mode.

This macro is added in <linux/compiler_types.h> because that header is
included in some of the tools headers, wheres <linux/compiler.h> is
not as it has a bunch of very kernel-specific things in it.

Changes in v2:

- Restore indentation of macro backslashes (David Laight)
- arch/nios2: Replace an adjacent typeof() with a similar "auto" construct
  (Linus Torvalds)
- fs/proc/inode.c: change "__auto_type" to "const auto" (Alexey Dobriyan)

--- 
 arch/nios2/include/asm/uaccess.h                        |  8 ++++----
 arch/x86/include/asm/bug.h                              |  2 +-
 arch/x86/include/asm/string_64.h                        |  6 +++---
 arch/x86/include/asm/uaccess_64.h                       |  2 +-
 fs/proc/inode.c                                         | 16 ++++++++--------
 include/linux/cleanup.h                                 |  6 +++---
 include/linux/compiler.h                                |  2 +-
 include/linux/compiler_types.h                          | 13 +++++++++++++
 include/linux/minmax.h                                  |  6 +++---
 tools/testing/selftests/bpf/prog_tests/socket_helpers.h |  9 +++++++--
 tools/virtio/linux/compiler.h                           |  2 +-
 11 files changed, 45 insertions(+), 27 deletions(-)

