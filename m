Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5F757272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 05:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGRDnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGRDnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:43:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9E10C8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 20:43:42 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-caf3a97aa3dso5562954276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689651821; x=1692243821;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/0l9RJowbMxXDULly0Ti3aPz7vZFI5wYz6gn4D5zxQ=;
        b=CncNHcE3w55A8LIGKQUsaOgkrJsUyucNE+YSlx8iqq6BtRqhkmprOPimO3jnWweAxj
         aN228hLHIju/BFL4mOpO8q2s1QG61Zi1cf1KnLCSi1LTALG0quvDiKY/m6oxsvQmrd1K
         ECdlWD1OtwzqxeTOEvOO96szV8e71C12QAC+/4doO4R804A55oqsyhgny0cYMU3DOZ0R
         Lr+XTUqV4vNE6FngkWVnwQeJ5In9W+Mjp2nxeRJQh+Pj6IKm5EAvI8UcbWqlkF6oXvPN
         tngVvzOucnth/Nw3yz/xdpMq32Mr88Fo185e8cKzl1lNUTXHEsCKcVwEnmhSZYe2zrpR
         i8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689651821; x=1692243821;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/0l9RJowbMxXDULly0Ti3aPz7vZFI5wYz6gn4D5zxQ=;
        b=DyB0xUyZhPklxsLRxGJ2SP/oXfRG1UlS2/rTWFPqe9ZlUKgiqGMzMj9THvmgWiLEld
         LUhhCRoB8Cwjk1SlC2g7Xy81ZAl3jp77ftNJ/Xlzx4e615pwrTbt4AJHxT5N4tgrwQSW
         /LpI+d4TJ6ksSPt/PYZhlNug4oIAoy1pqpQI8vQmYRV2iBJZ8kbJcH76uIMMgzjI38SB
         VuPT1F9Gednv3cAzhfLEWfwLpvIFTZHPkhWrnlPFoSqR8t8srDgDAKBZbdAvL6Kj2RsD
         XH+Tqiei+E2IgpEilVABn1DvYYSJ7CUz8t3JcVFDbF9iZcCxrcQWvm02ZoyNrgfAGyg1
         iMQg==
X-Gm-Message-State: ABy/qLboS78ePz5LNKd+w7Mwoj7ZKUD3h35TVIjMHkTlW9QoTYG6PNoo
        Llw3VkLuvE+1vqFIK7fuCXOhSA==
X-Google-Smtp-Source: APBJJlFC950yHTDDs30Dfo+udphheJh0ySlAY8ixTHrpSMmicnpTVarfG8yPJ59C/YDcqaFiP5999w==
X-Received: by 2002:a25:21d7:0:b0:b9e:889:420f with SMTP id h206-20020a2521d7000000b00b9e0889420fmr1629907ybh.12.1689651821104;
        Mon, 17 Jul 2023 20:43:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j11-20020a25550b000000b00bceb538a275sm255483ybb.21.2023.07.17.20.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:43:40 -0700 (PDT)
Date:   Mon, 17 Jul 2023 20:43:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jeff Layton <jlayton@kernel.org>
cc:     Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: linux-next ext4 inode size 128 corrupted
Message-ID: <26cd770-469-c174-f741-063279cdf7e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

I've been unable to run my kernel builds on ext4 on loop0 on tmpfs
swapping load on linux-next recently, on one machine: various kinds
of havoc, most common symptoms being ext4_find_dest_de:2107 errors,
systemd-journald errors, segfaults.  But no problem observed running
on a more recent installation.

Bisected yesterday to 979492850abd ("ext4: convert to ctime accessor
functions").

I've mostly averted my eyes from the EXT4_INODE macro changes there,
but I think that's where the problem lies.  Reading the comment in
fs/ext4/ext4.h above EXT4_FITS_IN_INODE() led me to try "tune2fs -l"
and look at /etc/mke2fs.conf.  It's an old installation, its own
inodes are 256, but that old mke2fs.conf does default to 128 for small
FSes, and what I use for the load test is small.  Passing -I 256 to the
mkfs makes the problems go away.

(What's most alarming about the corruption is that it appears to extend
beyond just the throwaway test filesystem: segfaults on bash and libc.so
from the root filesystem.  But no permanent damage done there.)

One oddity I noticed in scrutinizing that commit, didn't help with
the issues above, but there's a hunk in ext4_rename() which changes
-	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
+	old.dir->i_mtime = inode_set_ctime_current(old.inode);

Hugh
