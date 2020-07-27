Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811BB22F5FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgG0RDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:03:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgG0RDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGglKJ077115;
        Mon, 27 Jul 2020 17:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=YSd/DCjifAY9uPCsm7hyxFKJZ6h8+4lUnuWlZhX+os0=;
 b=bl2HIKfKrj0JI5zKXs1HlrUlHgsjXiglhtQn33fzbbzVTnxeIJ0BX0/6YoQvHeCqbAT+
 tQIKHHHSgkOYJADoYaXyKLec4HCDAIC5SShpYuKLr2svR7vpl904ytNXVVUAWc3qf72k
 LeBznQaa9Ar7WDNQc0C9blXki9XY2bWBtBBeDAkB3w3UnLdrkP2bvoV7ztlVp688Gi4n
 mJQ0PlqkAgGGYO0eEZpqSX6jB5tqjB8tQxQG2Wu7tg7ACnJFJ5hYjI4HYdWUAclZNVjL
 aopr9oCCEQkKPVIyQmJMD3CSk4rzz4ddkYQjGCjo8+RxbekNuUDuFiUaPvMKMi6AmGd2 Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1j2rut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgWmL055565;
        Mon, 27 Jul 2020 17:02:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9f8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:10 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGd111604;
        Mon, 27 Jul 2020 17:02:09 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-1;
        Mon, 27 Jul 2020 17:02:09 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date:   Mon, 27 Jul 2020 10:11:22 -0700
Message-Id: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support for preserving an anonymous memory range across
exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
sharing memory in this manner, as opposed to re-attaching to a named shared
memory segment, is to ensure it is mapped at the same virtual address in
the new process as it was in the old one.  An intended use for this is to
preserve guest memory for guests using vfio while qemu exec's an updated
version of itself.  By ensuring the memory is preserved at a fixed address,
vfio mappings and their associated kernel data structures can remain valid.
In addition, for the qemu use case, qemu instances that back guest RAM with
anonymous memory can be updated.

Patches 1 and 2 ensure that loading of ELF load segments does not silently
clobber existing VMAS, and remove assumptions that the stack is the only
VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
and could be considered on its own.

Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
using an ELF note.

Anthony Yznaga (5):
  elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
  mm: do not assume only the stack vma exists in setup_arg_pages()
  mm: introduce VM_EXEC_KEEP
  exec, elf: require opt-in for accepting preserved mem
  mm: introduce MADV_DOEXEC

 arch/x86/Kconfig                       |   1 +
 fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
 fs/exec.c                              |  33 +++++-
 include/linux/binfmts.h                |   7 +-
 include/linux/mm.h                     |   5 +
 include/uapi/asm-generic/mman-common.h |   3 +
 kernel/fork.c                          |   2 +-
 mm/madvise.c                           |  25 +++++
 mm/mmap.c                              |  47 ++++++++
 9 files changed, 266 insertions(+), 53 deletions(-)

-- 
1.8.3.1

