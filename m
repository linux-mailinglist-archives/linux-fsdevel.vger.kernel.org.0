Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F7365BAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhDTPBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 11:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhDTPBg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE7CC613CD;
        Tue, 20 Apr 2021 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618930864;
        bh=8H5HU47vEWQjvvF+2Pz4ChL06bcJ0cPitsV98kgBsxg=;
        h=From:To:Cc:Subject:Date:From;
        b=n4Nm3HlpfChYGkCY62zrscIigP2PS/KwtQe3rk8cf0a4kmFXBffFMI/JZOZf3lqXG
         I2DY9NMidPqLhsTgvFwkE+J6Fy9TPmwoPeQuiLO1iU5ibpkWYcCNMkqL8WamECYDx/
         cFnHJ2L51bPl3ihavFrLiRAdeJI2Bij5m4ZGUDbwVRUbPbbbOGIQTyE7lxfqgkGVlh
         +EYbmgdDfDCeyFVzW71FzXt7d+plT2fK+Ik0mpJZ2ndkuq0eiTmXZAZ7zGob/famDE
         EyW64QzflOhPuGIz3FV6JVuCs/V9Kd04MBng8Mkhuo5rTiWoHO+xJJif/5vq6yiKU1
         X3aq4Yn+wxUkw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v3 0/2]  secretmem: optimize page_is_secretmem()
Date:   Tue, 20 Apr 2021 18:00:47 +0300
Message-Id: <20210420150049.14031-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is an updated version of page_is_secretmem() changes.
This is based on v5.12-rc7-mmots-2021-04-15-16-28.

@Andrew, please let me know if you'd like me to rebase it differently or
resend the entire set.

v3:
* add missing put_compound_head() if we are to return NULL from
  gup_page_range(), thanks David.
* add unlikely() to test for page_is_secretmem.

v2:
* move the check for secretmem page in gup_pte_range after we get a
  reference to the page, per Matthew.

Mike Rapoport (2):
  secretmem/gup: don't check if page is secretmem without reference
  secretmem: optimize page_is_secretmem()

 include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
 mm/gup.c                  |  6 +++---
 mm/secretmem.c            | 12 +-----------
 3 files changed, 29 insertions(+), 15 deletions(-)

-- 
2.28.0


Mike Rapoport (2):
  secretmem/gup: don't check if page is secretmem without reference
  secretmem: optimize page_is_secretmem()

 include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
 mm/gup.c                  |  8 +++++---
 mm/secretmem.c            | 12 +-----------
 3 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.28.0

