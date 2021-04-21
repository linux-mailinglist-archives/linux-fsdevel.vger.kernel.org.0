Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2236681A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhDUJfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238140AbhDUJfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618997711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFFOkQmFoT44FyitzBtJNBAyIcAKGsIgK97fQioaoI0=;
        b=AtVfmtqCsBzQqCUeAF/GxULHpKLmhv8e9samQdOKynfQGgvVB8TKc28ZCUCmuiMhB5okl9
        KSLrT8+qOtdMD8YSTMpdfB2ecFYGO8is9aQsgjWC/9gbNZIjiO/VW3Qeiv6aG3nbZ7M73T
        jWR77YoBny/kD+Pk45KyloiaIqKcCIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-z6OMJECiOX2JWnTVVwLLDA-1; Wed, 21 Apr 2021 05:35:07 -0400
X-MC-Unique: z6OMJECiOX2JWnTVVwLLDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7609E81746E;
        Wed, 21 Apr 2021 09:35:04 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-224.ams2.redhat.com [10.36.113.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB2C5DDAD;
        Wed, 21 Apr 2021 09:34:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 0/3] perf/binfmt/mm: remove in-tree usage of MAP_EXECUTABLE
Date:   Wed, 21 Apr 2021 11:34:50 +0200
Message-Id: <20210421093453.6904-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stumbling over the history of MAP_EXECUTABLE, I noticed that we still
have some in-tree users that we can get rid of.

A good fit for the whole series could be Andrew's tree.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: x86@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  perf: MAP_EXECUTABLE does not indicate VM_MAYEXEC
  binfmt: remove in-tree usage of MAP_EXECUTABLE
  mm: ignore MAP_EXECUTABLE in ksys_mmap_pgoff()

 arch/x86/ia32/ia32_aout.c |  4 ++--
 fs/binfmt_aout.c          |  4 ++--
 fs/binfmt_elf.c           |  2 +-
 fs/binfmt_elf_fdpic.c     | 11 ++---------
 fs/binfmt_flat.c          |  2 +-
 include/linux/mman.h      |  2 ++
 kernel/events/core.c      |  2 --
 mm/mmap.c                 |  2 +-
 mm/nommu.c                |  2 +-
 9 files changed, 12 insertions(+), 19 deletions(-)

-- 
2.30.2

