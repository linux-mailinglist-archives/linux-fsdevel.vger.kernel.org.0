Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D31E9742
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEaLZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaLZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 07:25:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1EC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:25:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so8605168wru.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2020 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NCqPxv61HP8uasLwnBBVjufpcRJ1rU1+glsxEdxco8Y=;
        b=KF9Ej4ICbPmLvx/hgFWnNlC8gllljqz0v2m2q0sH00aswm7GGZvsq4suXgPosT2hnu
         kVF9xLd/CxQzG4iHhOM86tGNEluxoMlUFObJMn2Ft+TvZo8xL50LS6VBUQ6lUhjzB+1B
         3vjtM0bWLtnDe6uy8gHlvpV2bLzRpTgc7W5IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NCqPxv61HP8uasLwnBBVjufpcRJ1rU1+glsxEdxco8Y=;
        b=KPgmR8kJJTkvWYaQLN1Qn53INuJE4qDiV65IIpdfHaT1kQgNPm2HXGWVoou7I78SY3
         EsMTZs3TPiTK31sESODLl2xv58WFeQ1759hCY3ldIQnB94dGfAkTJTV8gwAkvw9/nif/
         mFpP0vRA8zpyzFLbZHPsIWOaIF9iBsc4HT93El+sIIs1jTF9VPRH1WY+ymWmrNaX+9Ci
         hLdMp5t9J5QIZ6nTViMBYAgLPnL2u8QxxhdhSAsMG/PL2G6OwZnXHUAZRvhotCJXl37m
         R2f32vybvspe0VOUCEk8GR7bk3K+GwTH8rwZNo2YC+2CzO9qjD+Khq1wKpSrApQvzk//
         +5/g==
X-Gm-Message-State: AOAM533BLQecFyK4GnEh2z37t8SEvBTTtO5dyU/eD6+BmkXpwnJFbB4e
        RS5f4FB6p6YIBT7lMpA4iOmmqRHr5JowdAV9nI8eJAnV66orZjimYa6diCaC/mhCIALDKMKBU0j
        t7h2xxurMvLWc9JzDbbhHTq3aOCrIS+Oma2wIVqIv3xAl7tpcovm7PNglRmaKXdTJA5DuTUAOu7
        Fq+Ji26r5XxJ9WCQ==
X-Google-Smtp-Source: ABdhPJwWb1kfTy0tW4YI1pz5nHDuebz97Rk7C/pMEqAA9opeSIP+S/y7BRsPiHc5c+Lzc+cwpd08WA==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr17013832wrm.346.1590924301497;
        Sun, 31 May 2020 04:25:01 -0700 (PDT)
Received: from noodle ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id p1sm16621027wrx.44.2020.05.31.04.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 04:25:00 -0700 (PDT)
Date:   Sun, 31 May 2020 14:24:44 +0300
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        keescook@chromium.org, yzaikin@google.com
Subject: [PATCH] get_subdir: do not drop new subdir if returning it
Message-ID: <20200531112444.GA25164@noodle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In testing of our kernel (based on 4.19, tainted, sorry!) on our aarch64 based hardware
we've come upon the following oops (lightly edited to omit irrelevant details):

000:50:01.133 Unable to handle kernel paging request at virtual address 0000000000007a12
000:50:02.209 Process brctl (pid: 14467, stack limit = 0x00000000bcf7a578)
000:50:02.209 CPU: 1 PID: 14467 Comm: brctl Tainted: P                  4.19.122 #1
000:50:02.209 Hardware name: Broadcom-v8A (DT)
000:50:02.209 pstate: 60000005 (nZCv daif -PAN -UAO)
000:50:02.209 pc : unregister_sysctl_table+0x1c/0xa0
000:50:02.209 lr : unregister_net_sysctl_table+0xc/0x20
000:50:02.209 sp : ffffff800e5ab9e0
000:50:02.209 x29: ffffff800e5ab9e0 x28: ffffffc016439ec0
000:50:02.209 x27: 0000000000000000 x26: ffffff8008804078
000:50:02.209 x25: ffffff80087b4dd8 x24: ffffffc015d65000
000:50:02.209 x23: ffffffc01f0d6010 x22: ffffffc01f0d6000
000:50:02.209 x21: ffffffc0166c4eb0 x20: 00000000000000bd
000:50:02.209 x19: ffffffc01f0d6030 x18: 0000000000000400
000:50:02.256 x17: 0000000000000000 x16: 0000000000000000
000:50:02.256 x15: 0000000000000400 x14: 0000000000000129
000:50:02.256 x13: 0000000000000001 x12: 0000000000000030
000:50:02.256 x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
000:50:02.256 x9 : feff646663687161 x8 : ffffffffffffffff
000:50:02.256 x7 : fefefefefefefefe x6 : 0000000000008080
000:50:02.256 x5 : 00000000ffffffff x4 : ffffff8008905c38
000:50:02.256 x3 : ffffffc01f0d602c x2 : 00000000000000bd
000:50:02.256 x1 : ffffffc01f0d60c0 x0 : 0000000000007a12
000:50:02.256 Call trace:
000:50:02.256  unregister_sysctl_table+0x1c/0xa0
000:50:02.256  unregister_net_sysctl_table+0xc/0x20
000:50:02.256  __devinet_sysctl_unregister.isra.0+0x2c/0x60
000:50:02.256  inetdev_event+0x198/0x510
000:50:02.256  notifier_call_chain+0x58/0xa0
000:50:02.303  raw_notifier_call_chain+0x14/0x20
000:50:02.303  call_netdevice_notifiers_info+0x34/0x80
000:50:02.303  rollback_registered_many+0x384/0x600
000:50:02.303  unregister_netdevice_queue+0x8c/0x110
000:50:02.303  br_dev_delete+0x8c/0xa0
000:50:02.303  br_del_bridge+0x44/0x70
000:50:02.303  br_ioctl_deviceless_stub+0xcc/0x310
000:50:02.303  sock_ioctl+0x194/0x3f0
000:50:02.303  compat_sock_ioctl+0x678/0xc00
000:50:02.303  __arm64_compat_sys_ioctl+0xf0/0xcb0
000:50:02.303  el0_svc_common+0x70/0x170
000:50:02.303  el0_svc_compat_handler+0x1c/0x30
000:50:02.303  el0_svc_compat+0x8/0x18
000:50:02.303 Code: a90153f3 aa0003f3 f9401000 b40000c0 (f9400001)

The crash is in the call to count_subheaders(header->ctl_table_arg).

Although the header (being in x19 == 0xffffffc01f0d6030) looks like a
normal kernel pointer, ctl_table_arg (x0 == 0x0000000000007a12) looks
invalid.

Trying to find the issue, we've started tracing header allocation being
done by kzalloc in __register_sysctl_table and header freeing being done
in drop_sysctl_table.

Then we've noticed headers being freed which where not allocated before.
The faulty freeing was done on parent->header at the end of
drop_sysctl_table.

The invariant on __register_sysctl_table seems to be that non-empty
parent dir should have its header.nreg > 1. By failing this invariant
(see WARN_ON hunk in the patch) we've come upon the conclusion that
something is fishy with nreg counting.

The root cause seems to be dropping new subdir in get_subdir function.
Here are the new subdir adventures leading to the invariant failure
above:

1. new subdir comes to being with nreg == 1
2. the nreg is being incremented in the found clause, nreg == 2
3. nreg is being decremented by the if (new) drop, nreg == 1
4. coming out of get_subdir, insert_header increments nreg: nreg == 2
5. nreg is being decremented at the end of __register_sysctl_table

The fix seems to be avoiding step 3 if new subdir is the one being
returned. The patch does this and also adds warning for the nreg
invariant.
---
 fs/proc/proc_sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d459b087..12fa5803dcb3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1010,7 +1010,7 @@ static struct ctl_dir *get_subdir(struct ctl_dir *dir,
 			namelen, namelen, name, PTR_ERR(subdir));
 	}
 	drop_sysctl_table(&dir->header);
-	if (new)
+	if (new && new != subdir)
 		drop_sysctl_table(&new->header);
 	spin_unlock(&sysctl_lock);
 	return subdir;
@@ -1334,6 +1334,7 @@ struct ctl_table_header *__register_sysctl_table(
 		goto fail_put_dir_locked;
 
 	drop_sysctl_table(&dir->header);
+	WARN_ON(dir->header.nreg < 2);
 	spin_unlock(&sysctl_lock);
 
 	return header;
-- 
2.19.2

