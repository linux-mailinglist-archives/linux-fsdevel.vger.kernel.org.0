Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036B613E9C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEEJP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 05:15:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35088 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEEJP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 05:15:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so7589512wrb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2019 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XkqFF/qDehoXj+gSNc9+3brMxalfb4Ck7997PYA1has=;
        b=jLq2IsmlVL6IJoyGi0zcebbCdjtl4Sph3OOUBUYdXukIqmVUOPvoDNSsz83kxwno5S
         U+e/RGJaiArhE+FMkUTZn5K3XChOwVWsejWvRjbM47Fl9am1pI1Iz4sODuH2YIstG/7n
         b7CSBaVFVngClTPkf81RH6nHju62cfeqGIQ1Pg1ZxNzih+SY3+i1MTAhm4NtcMMCfe8M
         dH8NssMQjEHZOroWVQSTCPnRyhmweIX4QLatzqO00sTkaxssZ1SV+ZkRANel7b5cgz2p
         5hEDkGdeT4eNLDkFvBP47QB1wy0IXbPRDexfRxdCg/f2yeT3kbTsXwWIkrvTPfXyh8GP
         esJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XkqFF/qDehoXj+gSNc9+3brMxalfb4Ck7997PYA1has=;
        b=UqHYFHkbJ9bVG4r/eQ9ORa81/UIlT7Jjnf3l8h5lprwSTiudhKxDmx6pMieoSPauYT
         nfRsOmK68+cn46cgrwF6ZYHhtjMLTOabriNuaXCuLinXtOfLAbcgxMCx/1EHDjzwmEYf
         pkmaCBOtm9wumkg22wC7w7eVzTP69aE9d4t83FM5AmoW3v/HwnMqoaigAG6NORO1GlnE
         1M7IbnMVWnjcgctCPjHXvclzygWRXEEG0YcBDdPG98TM+c3D5TgKyrULqrddKjV+myzU
         NZ8Gc3DEXeFVRxsvMzo+rC5PqWwl09GW7xKnVbf19xo/011lehOX5PKxtmIkX13SzBUb
         w2MA==
X-Gm-Message-State: APjAAAUsKZm27XkcdrWq+8cP7ZQs/ilUfTDrFsQ0l3eG+MuRMDN6AVsi
        GcQMmVHUfmu5f0xC2LyNVD8=
X-Google-Smtp-Source: APXvYqyuYZ+UR3CdEoN/ffgCNcqQAdkSy9VlrTxvKto1/YIRbCGaMsRf0iDmObvCr/jFomTjStTOrA==
X-Received: by 2002:adf:b458:: with SMTP id v24mr14569060wrd.46.1557047756004;
        Sun, 05 May 2019 02:15:56 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id o8sm4940511wrx.50.2019.05.05.02.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 02:15:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Subject: [PATCH] fsnotify: fix unlink performance regression
Date:   Sun,  5 May 2019 12:15:49 +0300
Message-Id: <20190505091549.1934-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__fsnotify_parent() has an optimization in place to avoid unneeded
take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
not to call __fsnotify_parent(), we left out the optimization.
Kernel test robot reported a 5% performance regression in concurrent
unlink() workload.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

The linked 5.1-rc1 performance regression report came with bad timing.
Not sure if Linus is planning an rc8. If not, you will probably not
see this before the 5.1 release and we shall have to queue it for 5.2
and backport to stable 5.1.

I crafted the patch so it applies cleanly both to master and Al's
for-next branch (there are some fsnotify changes in work.dcache).

Thanks,
Amir.

 include/linux/fsnotify.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 09587e2860b5..2272c8c2023c 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -175,12 +175,19 @@ static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
 		mask |= FS_ISDIR;
 
 	parent = dget_parent(dentry);
+	/* Avoid unneeded take_dentry_name_snapshot() */
+	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
+	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
+		goto out_dput;
+
 	take_dentry_name_snapshot(&name, dentry);
 
 	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
 		 name.name, 0);
 
 	release_dentry_name_snapshot(&name);
+
+out_dput:
 	dput(parent);
 }
 
-- 
2.17.1

