Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017DF4ED9E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiCaM4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiCaM4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:56:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C717179C;
        Thu, 31 Mar 2022 05:54:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c23so23348611plo.0;
        Thu, 31 Mar 2022 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wfpr7Xh+FqyWgrHb9mRhd4rKnQSyLplPFkeGhzZb9g0=;
        b=i/ngoARk9G29TRu+hD3k0dQHOk1wObrkCJsOm3kiIZUGiULzE0Fn4otgnZIf5EjPRt
         hzXWNN2BDpNYZA9c89KtvdIF1eV16n+J8SfuGEj/0JOpJxWt2uT2EhQusimH5cOgD/3K
         NHJuzEPtFOejFbPldk9Tl4hugh8qcUsHh6z1fIv3CFg6fVGHo+3lxH1EpV26BTkw+ztk
         k7+/9O/u9XkNZ0quJrRNSd9/lYr3xisC2CDcYDYxTLkjjH6T5Hr+lXIk55XCLZowm4Eb
         +VPEgm8dZOZ3aH5yp6P7qfUijB8uRiOfNVCuNvShz3Tes0P5tVrHTXQFD2yvBpSq3o6v
         rMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wfpr7Xh+FqyWgrHb9mRhd4rKnQSyLplPFkeGhzZb9g0=;
        b=l8ISQ4GHsg5bnrXphkTxSa1MyQag3HV8WERZqwHpmTmEmpMDyKL675Xp8wEHgD1sZH
         RCxZtAF85D0Enz5f9iMZYx8fRP859nHEtyHldqqMsRiQmuQ010kcIcb5u0PW3o2n+OAM
         CPSL/65mFbdPq+gATcW8QkON4d6DL90W9Rlv3fsxbWjm1nJCCeM5zqp7qD0hJygVkGLQ
         yIj5yQK3KB2NR9qp0FsF58gIwQLfJlDZZaX/BVSTLv6r3166iohbsGxh1uOmT26vBvu/
         Q62MR8qws9WOipF0iKWJm2vA3x325J/omqzwVAW7nGApX4Z9pllQAbG1pvY38dehh1VD
         SMkA==
X-Gm-Message-State: AOAM533rO+Kh+Yjj0SfwpH8Ss59VvTuzxoWti0GzS3qv8NyiBHbyCmQ/
        2CUEhQl9qEBwIa+D9pOLVlwgCL3w4NY=
X-Google-Smtp-Source: ABdhPJyIxh8bjfoXp9wP+YtcB3sGF8ILMbOkVTafMOPc1P4GJ8XxfJL2v9YtIFTFBwC2vUJjw7ytGQ==
X-Received: by 2002:a17:902:b705:b0:154:a806:5325 with SMTP id d5-20020a170902b70500b00154a8065325mr40873453pls.30.1648731286249;
        Thu, 31 Mar 2022 05:54:46 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm9977493pjy.35.2022.03.31.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:54:46 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 2/4] common/punch: Add block_size argument to _filter_fiemap_**
Date:   Thu, 31 Mar 2022 18:24:21 +0530
Message-Id: <38648a1fb58b0ab554a21d11eef92f932a3bd7a9.1648730443.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1648730443.git.ritesh.list@gmail.com>
References: <cover.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

Add block_size paramter to _filter_fiemap_flags() and
_filter_hole_fiemap(). This is used in next patches

Also this fixes some of the end of line whitespace issues while we are
at it.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/punch | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/punch b/common/punch
index b6b8a0b9..706e7c11 100644
--- a/common/punch
+++ b/common/punch
@@ -109,6 +109,7 @@ _filter_fiemap()
 
 _filter_fiemap_flags()
 {
+	block_size=$1
 	$AWK_PROG '
 		$3 ~ /hole/ {
 			print $1, $2, $3;
@@ -135,19 +136,19 @@ _filter_fiemap_flags()
 			}
 			print $1, $2, flag_str
 		}' |
-	_coalesce_extents
+	_coalesce_extents $block_size
 }
 
-# Filters fiemap output to only print the 
+# Filters fiemap output to only print the
 # file offset column and whether or not
 # it is an extent or a hole
 _filter_hole_fiemap()
 {
 	$AWK_PROG '
 		$3 ~ /hole/ {
-			print $1, $2, $3; 
+			print $1, $2, $3;
 			next;
-		}   
+		}
 		$5 ~ /0x[[:xdigit:]]+/ {
 			print $1, $2, "extent";
 		}' |
-- 
2.31.1

