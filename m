Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46F1E8BE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgE2X0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE2X0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:26:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B3DC03E969;
        Fri, 29 May 2020 16:26:17 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoOF-000Be4-3C; Fri, 29 May 2020 23:26:15 +0000
Date:   Sat, 30 May 2020 00:26:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess misc
Message-ID: <20200529232615.GK23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The stuff that doesn't fit anywhere else.  Hopefully
saner marshalling for weird 7-argument syscalls (pselect6()),
low-hanging fruit in several binfmt, unsafe_put_user-based
x86 cp_stat64(), etc. - there's really no common topic here.

	BTW, after that series there's no more __clear_user()
callers outside of arch/* and damn few in arch/*, other than
clear_user() instances themselves...

Branch is uaccess.misc, based at uaccess.base.


Al Viro (9):
      pselect6() and friends: take handling the combined 6th/7th args into helper
      binfmt_elf: don't bother with __{put,copy_to}_user()
      binfmt_elf_fdpic: don't use __... uaccess primitives
      binfmt_flat: don't use __put_user()
      x86: switch cp_stat64() to unsafe_put_user()
      TEST_ACCESS_OK _never_ had been checked anywhere
      user_regset_copyout_zero(): use clear_user()
      x86: kvm_hv_set_msr(): use __put_user() instead of 32bit __clear_user()
      bpf: make bpf_check_uarg_tail_zero() use check_zeroed_user()

 arch/x86/include/asm/pgtable_32.h |   7 ---
 arch/x86/kernel/sys_ia32.c        |  40 ++++++++------
 arch/x86/kvm/hyperv.c             |   2 +-
 fs/binfmt_elf.c                   |  14 ++---
 fs/binfmt_elf_fdpic.c             |  31 +++++++----
 fs/binfmt_flat.c                  |  22 +++++---
 fs/select.c                       | 112 ++++++++++++++++++++++----------------
 include/linux/regset.h            |   2 +-
 kernel/bpf/syscall.c              |  25 ++-------
 9 files changed, 134 insertions(+), 121 deletions(-)

