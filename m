Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD8B3659A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhDTNRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhDTNQ7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB92561155;
        Tue, 20 Apr 2021 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618924588;
        bh=qhR1fpCqAsT1S7eszhL+8DGn+IohPdIv6ZmfP8rMA54=;
        h=From:To:Cc:Subject:Date:From;
        b=KUF557NhH5l1t2K0OYATzazaNCSAUMl7v8OSvEA6BB3++H9JFEiE0m47Qe20TLsyA
         Mg+bE3SvdjK4KbC0KDgBwkghXH1+SdNl7XPGJXfOGWL6rieURUdgwykpH/YpDMQBPG
         rKBgMRdJAVDnOl31RwFKVeNmayE39KOv5tA+vfGakvNDvdEpQ+NJsJgelSxLbVraWI
         bPMda19jc0MXqs60Xcjv5yfm6A6g9IJPG8oGUJGNTfLxnnkT0YtwmG/da8/HHsmN7t
         JmXlm7VjlV/79DJvWlsaprQDngcrZLv3QMmwPhKSGYJzeKATbw0tpP/7J7LXi7vTV1
         xuJcRy9ZW0OEg==
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
Subject: [PATCH v2 0/2] secretmem: optimize page_is_secretmem()
Date:   Tue, 20 Apr 2021 16:16:07 +0300
Message-Id: <20210420131611.8259-1-rppt@kernel.org>
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

