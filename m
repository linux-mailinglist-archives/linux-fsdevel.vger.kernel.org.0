Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815AD64B4D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiLMMIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 07:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiLMMIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:08:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82E13F9E;
        Tue, 13 Dec 2022 04:08:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v7so8147580wmn.0;
        Tue, 13 Dec 2022 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EZN5D7YMctr8QYDTHJDTpFFxPnxIXKf6eLLlSncA3Q=;
        b=eiaUdUECEAE9B/WItc5/7yC7N2DCJ4LWnIJgM/MErm3f7mYB4qUpJo9AvOq/BkrLg8
         hGENktrO5oxY/UTJDsAHg9tra7m7QHF4zKLx/EzPta2YCZgnIzne3bfKp/2/c6WCGYQ7
         qJXoAvoTmwuFWTloB2WXmuvU72FmrZ/7QYG8APKPh7bWLRp0+XFmyTHE372D/JYR9l6k
         wxXo8rRvPQLeiHJsXLM1h8d0PrX6lTNl+3pzD+WIpbL0JbBDzUF0hhNhMs0fr8TLBeMk
         y/uyh6bxLq8QNuTh6aZW4QwpY0ZKdNrhgOtgJs4rqctwtH7tTPjBjalUlxvPWCgRW5nE
         HSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EZN5D7YMctr8QYDTHJDTpFFxPnxIXKf6eLLlSncA3Q=;
        b=sL6kvw2Rle+/FTuudwWWF94XybT5+PjiZ4K2Ynk8ae8tw/rNPyvzmBYyyxK3fr2fe+
         3W6eb++9K7uEBLyDbx4mgw+8ukbD4DL0/a4nXpauwFJfFS5kJuvyo8hnMbxCH0nLY0Hd
         luGhtN8RvEMuROJBeNxlPs6rNvjZPqNFzCel3hcrYulskbRKoCXOHvc0w9OzZ7saNUB/
         ogSGGyg8iVI4lJyScM3Q/FOoO7+CfoI4+MCM22PsXuG58wxs4qgROtMbR8x47uFOMxuZ
         4iuXG+H/f1HS103PUkvmYmpbtXYEb0o3TNNBj0CaYA/+bHGT42tRZ1Fq52nNGCzxWQ/v
         m4KA==
X-Gm-Message-State: ANoB5pmeHbnOGxjYDji3Zo4UOPbApLukchV3JOmxaOozM7+C/hpjRlTr
        MN1GD3UzKiJNJT3PddR/+iY=
X-Google-Smtp-Source: AA0mqf7ETkqGHV59uaPAmaovl76uzzXvMs6DSiuvDOEdPStlHcrv23Z8t6DLh74A59lDb19WtVkSzQ==
X-Received: by 2002:a05:600c:600c:b0:3d0:8c7:65dc with SMTP id az12-20020a05600c600c00b003d008c765dcmr14934963wmb.0.1670933319702;
        Tue, 13 Dec 2022 04:08:39 -0800 (PST)
Received: from localhost.localdomain ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c500e00b003cf774c31a0sm12941255wmr.16.2022.12.13.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:08:39 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: [PATCH] copy_file_range.2: Fix wrong kernel version information
Date:   Tue, 13 Dec 2022 14:08:34 +0200
Message-Id: <20221213120834.948163-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit d7ba612d0 ("copy_file_range.2: Update cross-filesystem support
for 5.12") prematurely documented kernel 5.12 as the version that
changes the cross-fs copy_file_range() behavior, but that behavior
change was only merged in kernel version 5.19.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 man2/copy_file_range.2 | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
index ac74d9a07..25146a1dd 100644
--- a/man2/copy_file_range.2
+++ b/man2/copy_file_range.2
@@ -152,7 +152,8 @@ Out of memory.
 .B ENOSPC
 There is not enough space on the target filesystem to complete the copy.
 .TP
-.BR EOPNOTSUPP " (since Linux 5.12)"
+.BR EOPNOTSUPP " (since Linux 5.19)"
+.\" commit 868f9f2f8e004bfe0d3935b1976f625b2924893b
 The filesystem does not support this operation.
 .TP
 .B EOVERFLOW
@@ -171,11 +172,13 @@ or
 refers to an active swap file.
 .TP
 .BR EXDEV " (before Linux 5.3)"
+.\" commit 5dae222a5ff0c269730393018a5539cc970a4726
 The files referred to by
 .IR fd_in " and " fd_out
 are not on the same filesystem.
 .TP
-.BR EXDEV " (since Linux 5.12)"
+.BR EXDEV " (since Linux 5.19)"
+.\" commit 868f9f2f8e004bfe0d3935b1976f625b2924893b
 The files referred to by
 .IR fd_in " and " fd_out
 are not on the same filesystem,
@@ -191,13 +194,15 @@ emulation when it is not available.
 A major rework of the kernel implementation occurred in Linux 5.3.
 Areas of the API that weren't clearly defined were clarified and the API bounds
 are much more strictly checked than on earlier kernels.
-Applications should target the behaviour and requirements of 5.3 kernels.
 .PP
-Since Linux 5.12,
+Since Linux 5.19,
 cross-filesystem copies can be achieved
 when both filesystems are of the same type,
 and that filesystem implements support for it.
-See BUGS for behavior prior to Linux 5.12.
+See BUGS for behavior prior to Linux 5.19.
+.PP
+Applications should target the behaviour and requirements of 5.19 kernels,
+that was also backported to earlier stable kernels.
 .SH STANDARDS
 The
 .BR copy_file_range ()
@@ -223,7 +228,7 @@ such as the use of reflinks (i.e., two or more inodes that share
 pointers to the same copy-on-write disk blocks)
 or server-side-copy (in the case of NFS).
 .SH BUGS
-In Linux 5.3 to Linux 5.11,
+In Linux 5.3 to Linux 5.18,
 cross-filesystem copies were implemented by the kernel,
 if the operation was not supported by individual filesystems.
 However, on some virtual filesystems,
-- 
2.25.1

