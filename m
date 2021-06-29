Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A63B7492
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhF2Oqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:46:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhF2Oql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:46:41 -0400
Received: from orion.localdomain ([95.114.16.105]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mi2Fj-1lKUEL2JDl-00e1er; Tue, 29 Jun 2021 16:44:00 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, info@metux.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Subject: RFC: allow recording and passing of open file descriptors
Date:   Tue, 29 Jun 2021 16:43:39 +0200
Message-Id: <20210629144341.14313-1-info@metux.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3xy6TejQUnQI2icy7DUqxCsfEZzce5W3eyX4m6F9pur4Vdqwk4N
 BoBSyCJDqajKnBx5Nb7NKTAUXhnekGO8qgEVSdhxgffsOFu4eihtUgSqX/mmx4PfaQ/sKP1
 y6ECQRlTBIIa2l9jq96Q7kcFWZDo+becYNejo8STPtnzyd0dSuFLEqBjhjgLQHdU8R08hVm
 +VcgmcSNGp4T+3eDyBqoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gId4UYweEp4=:Hyl6nqqgKvSOFvzEYYGB5n
 9Nt+lX1n3uKETVh+FGE4nS41RytsAAKtVDGwU4uNeNZO5il5sQbe8whAnkZWyoFz2QrXcCk5A
 rMk7jMfihBc/k9m6Tlb/XBq4VB0epC63PnU5j53RgcPuwfYQ9lzJypqEfvQ19zYjZbSEFKpae
 g2JiIKVSNbCMbDQJUEAfHSV/uYh/ElAtIT7t9OWo4BKWuaNwxm0OEzSQERLK1S8ZCFbHLY4Ao
 XAX4Uk7fEnmWWCRAHZ3dW1Ik+MDjaiFkzgH0FwCiuQOSnLUbNDQj1xK72yhv7sf3E7g47TMZP
 ZLj3silr+KpRw5iNOp9AHeeAY7J1eeEFac9xs+e+4Tfv2E0aF/0jL7WB8y/szPJJXpq1ytDcF
 Uob8isHrIyxRkso73lPkBjGRpeN1Vktho/Z2HSmiA6NVDDEiTOpmc7gv4vuj0dzckyPLc67Ry
 zDcSECT1xfVnWGbU2qSv4tSpC/VgaSc0NX1KqSj4ivbYj8NSOXe+a8AOTRA/+PDeXB7PxQwSE
 Aty0Fi32hOdn2L+WLYBDoQ=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello folks,


here's an attempt to make it to record open file descriptors (struct file*)
and make them available to other processes via file system. The semantics
are similar to dup() or passing via Unix socket in regard that the 
receiving process will get reference to the same struct file instance into
its fdtable. But the big difference here is we're doing it directly via
file system (ie. retrieving is done by a simple open()). It works pretty
much like like Plan9's /srv file system:

    http://man.cat-v.org/plan_9/3/srv

To archive that, the first patch introduces the concept of "file boxing",
which means an open file operation can put a reference to another file
into the struct file, which will then be returned to the caller, instead
of the newly created one. The reason for doing it this strange way is that
the new struct file instance is allocated and prepared very early, before
we're calling into the actual file operation - refactoring this so that
the open() file op directly returns a struct file* pointer would be a
massively intrusive change, that I just don't dare to do here.

The second patch introduces a new file system "srvfs" that works like
Plan9's /srv file systems.


Another use case for the first patch could be direct fd passing in FUSE,
like Peng Tao and Alessio Balsini are currently working on, via other means.

    https://www.spinics.net/lists/linux-fsdevel/msg196163.html


I believe the patch 1 should be pretty straightforward and not doing any harm.
(it's not even compiled in unless explicitly enabled by something else)


have run,

--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

