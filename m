Return-Path: <linux-fsdevel+bounces-1560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E337DBEC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 18:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FDDB20C82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156E199AE;
	Mon, 30 Oct 2023 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K6FBFyU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400A199A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 17:22:45 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87FCAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:22:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b9377e71acso3092796a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698686560; x=1699291360; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Qr0s7U6dNvm4eYZh7Mu5zVALixvf2eu+TeTE5e0wtE=;
        b=K6FBFyU1DF1rfavAUKIcxaN0vyXJ/Dw/+3Xydj8aYSVXny+yYzkh7Yq+VgCM2kTktf
         sB+Q4bXXZ3HRrT8TvCVYGJN+Qik44Zt3D23T/rOIwStGRHenpijbE4xL2L1/JTRtzVSx
         Qvb/My6dEoaBsJtpD0qhRqutdZ6fBdIC1fJzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686560; x=1699291360;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qr0s7U6dNvm4eYZh7Mu5zVALixvf2eu+TeTE5e0wtE=;
        b=QU0qsCGxq5q0PYObNKPq0yuu1lgy6kiPEzTEk2o+vdnPkJ0U1rTkoav/hgz+TpwEfZ
         BUczHQPsxOJW3n/t/y8lck5NMIlPoB3JF5iNCexby9kmYxZmBuUFebxUOvk5GJYJ0SJt
         KqOQJ2V7Cx7MZ5Jgum2Q9ex0wuEMOp8li6bnrUxRpmvsA2EHs0+it5ui6Q5TiwV923/y
         4e8SHejvyoaXs15It5yH13068Eu6wohIBiCm72Sqcd461gvtLonhC/D/8G6h6MIPi/3u
         anRFwNMrxqUCdvl/ouJ/kDWv6iFLaNneUwVr2NiNOz/t8Phwc3g+GrT4Mb9ZNlpQ6+ss
         XkPw==
X-Gm-Message-State: AOJu0Yw9gdMH7GIaFaUDii/ACJBo5+SinoFiCxUVxokaTO7cvxPNX7g3
	josYEKHEmXwWdJJynk3+/t/qJg==
X-Google-Smtp-Source: AGHT+IEQdg7ndIN3pFd8/LN/aBFNKYCrURckGqhkwr54kkCced1dxp+aoW938zbkS1o7G7SUFjW8bA==
X-Received: by 2002:a17:90a:1948:b0:280:2613:c378 with SMTP id 8-20020a17090a194800b002802613c378mr5384902pjh.40.1698686560313;
        Mon, 30 Oct 2023 10:22:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a608900b0027d0de51454sm7274970pji.19.2023.10.30.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:22:39 -0700 (PDT)
Date: Mon, 30 Oct 2023 10:22:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrei Vagin <avagin@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Dave Jones <davej@redhat.com>, David Howells <dhowells@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Greg Ungerer <gerg@kernel.org>,
	Henning Schild <henning.schild@siemens.com>,
	Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
	Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Rolf Eike Beer <eb@emlix.com>, Sargun Dhillon <sargun@sargun.me>,
	Sebastian Ott <sebott@redhat.com>, Serge Hallyn <serge@hallyn.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: [GIT PULL] execve updates for v6.7-rc1
Message-ID: <202310301009.2464A71@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.7-rc1. This includes 3
changes I want to explicitly call attention to:

1) Eric Biederman and I refactored ELF segment loading to handle the case
where a segment has a smaller filesz than memsz. Traditionally linkers
only did this for .bss and it was always the last segment. As a result,
the kernel only handled this case when it was the last segment. We've
had two recent cases where linkers were trying to use these kinds of
segments for other reasons, and the were in the middle of the segment
list. There was no good reason for the kernel not to support this,
and the refactor actually ends up making things more readable too.

2) Christian Brauner has made it possible to use binfmt_misc with mount
namespaces. This means some traditionally root-only interfaces (for
adding/removing formats) are now more exposed (but believed to be safe).

3) Alejandro Colomar noticed that the ELF UAPI has been polluting the
struct namespace with an unused and overly generic tag named "dynamic"
for no discernible reason for many many years. After double-checking
various distro source repositories, it has been removed.

All three changes have been living in linux-next without any reported
problems.

Thanks!

-Kees

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.7-rc1

for you to fetch changes up to 21ca59b365c091d583f36ac753eaa8baf947be6f:

  binfmt_misc: enable sandboxed mounts (2023-10-11 08:46:01 -0700)

----------------------------------------------------------------
execve updates for v6.7-rc1

- Support non-BSS ELF segments with 0 filesz (Eric W. Biederman, Kees Cook)

- Enable namespaced binfmt_misc (Christian Brauner)

- Remove struct tag 'dynamic' from ELF UAPI (Alejandro Colomar)

- Clean up binfmt_elf_fdpic debug output (Greg Ungerer)

----------------------------------------------------------------
Alejandro Colomar (1):
      elf, uapi: Remove struct tag 'dynamic'

Christian Brauner (2):
      binfmt_misc: cleanup on filesystem umount
      binfmt_misc: enable sandboxed mounts

Eric W. Biederman (1):
      binfmt_elf: Support segments with 0 filesz and misaligned starts

Greg Ungerer (1):
      binfmt_elf_fdpic: clean up debug warnings

Kees Cook (5):
      binfmt_elf: elf_bss no longer used by load_elf_binary()
      binfmt_elf: Use elf_load() for interpreter
      binfmt_elf: Use elf_load() for library
      binfmt_elf: Only report padzero() errors when PROT_WRITE
      mm: Remove unused vm_brk()

 fs/binfmt_elf.c                | 215 ++++++++---------------
 fs/binfmt_elf_fdpic.c          |  20 ++-
 fs/binfmt_misc.c               | 386 ++++++++++++++++++++++++++++++++++-------
 include/linux/binfmts.h        |  10 ++
 include/linux/mm.h             |   3 +-
 include/linux/user_namespace.h |   8 +
 include/uapi/linux/elf.h       |   2 +-
 kernel/user.c                  |  13 ++
 kernel/user_namespace.c        |   3 +
 mm/mmap.c                      |   6 -
 mm/nommu.c                     |   5 -
 11 files changed, 443 insertions(+), 228 deletions(-)

-- 
Kees Cook

