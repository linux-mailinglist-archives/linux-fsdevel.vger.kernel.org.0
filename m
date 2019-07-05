Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31B160C2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfGEURV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:17:21 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59920 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbfGEURV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:17:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7EED28EE1F7;
        Fri,  5 Jul 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357841;
        bh=Rr0/c3YY6b7M6XGt7eOf4jjmV2d3TMURmcZoEpYrahY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FOFnX6fsexFCfW5mVUquzMC+bE32BwR1CPHjvlO4jFuhi/W5UwqdXK99onoRuLSlD
         vPV4PeI6GTA25+sQ+tDl9kUxG7ZGE8Bx6Owp9UlW/go1GD22tDCYa0f/VEnIOtJPql
         9AAD+80Vj6CtXPqU0XebDXt9F4MGG3Vuj7/a/8Nk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3-_X30Ba98IQ; Fri,  5 Jul 2019 13:17:21 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27D648EE0CF;
        Fri,  5 Jul 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357841;
        bh=Rr0/c3YY6b7M6XGt7eOf4jjmV2d3TMURmcZoEpYrahY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FOFnX6fsexFCfW5mVUquzMC+bE32BwR1CPHjvlO4jFuhi/W5UwqdXK99onoRuLSlD
         vPV4PeI6GTA25+sQ+tDl9kUxG7ZGE8Bx6Owp9UlW/go1GD22tDCYa0f/VEnIOtJPql
         9AAD+80Vj6CtXPqU0XebDXt9F4MGG3Vuj7/a/8Nk=
Message-ID: <1562357840.10899.9.camel@HansenPartnership.com>
Subject: [PATCH 4/4] palo: add support for formatting as ext4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 13:17:20 -0700
In-Reply-To: <1562357231.10899.5.camel@HansenPartnership.com>
References: <1562357231.10899.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that iplboot can read ext4 filesystem, allow palo to create them
with the palo --format-as=4 option.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 palo/palo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/palo/palo.c b/palo/palo.c
index e088993..26da01b 100644
--- a/palo/palo.c
+++ b/palo/palo.c
@@ -506,8 +506,8 @@ do_formatted(int init, int media, const char *medianame, int partition,
 	    }
 	}
 
-	sprintf(cmd, "mke2fs %s -O^resize_inode -b %d -l %s %s", do_format == 3 ? "-j" : "",
-		EXT2_BLOCKSIZE, badblockfilename, partitionname);
+	sprintf(cmd, "mke2fs -t ext%d -O^resize_inode -b %d -l %s %s",
+		do_format, EXT2_BLOCKSIZE, badblockfilename, partitionname);
 
 	if (verbose)
 	    printf("Executing: %s\n", cmd);
@@ -868,6 +868,8 @@ main(int argc, char *argv[])
 		format_as = 2;
 	    else if(strcmp(optarg, "3") == 0)
 		format_as = 3;
+	    else if (strcmp(optarg, "4") == 0)
+		format_as = 4;
 	    else
 		error(0, argv[0]);
 	    break;
-- 
2.16.4

