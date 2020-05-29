Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35EC1E7127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438058AbgE2AKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbgE2AKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:10:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EEC08C5C7;
        Thu, 28 May 2020 17:10:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSbP-00HEZb-Lh; Fri, 29 May 2020 00:10:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] pcm_native: result of put_user() needs to be checked
Date:   Fri, 29 May 2020 01:10:23 +0100
Message-Id: <20200529001023.4107547-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
References: <20200529000957.GW23230@ZenIV.linux.org.uk>
 <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and no, __put_user() doesn't help here - skipping
access_ok() on the second call does not remove the
possibility of page having become unmapped or r/o
in the meanwhile

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/core/pcm_native.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index aef860256278..47838f57a647 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3093,7 +3093,8 @@ static int snd_pcm_xferi_frames_ioctl(struct snd_pcm_substream *substream,
 		result = snd_pcm_lib_write(substream, xferi.buf, xferi.frames);
 	else
 		result = snd_pcm_lib_read(substream, xferi.buf, xferi.frames);
-	__put_user(result, &_xferi->result);
+	if (put_user(result, &_xferi->result))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3122,7 +3123,8 @@ static int snd_pcm_xfern_frames_ioctl(struct snd_pcm_substream *substream,
 	else
 		result = snd_pcm_lib_readv(substream, bufs, xfern.frames);
 	kfree(bufs);
-	__put_user(result, &_xfern->result);
+	if (put_user(result, &_xfern->result))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3137,7 +3139,8 @@ static int snd_pcm_rewind_ioctl(struct snd_pcm_substream *substream,
 	if (put_user(0, _frames))
 		return -EFAULT;
 	result = snd_pcm_rewind(substream, frames);
-	__put_user(result, _frames);
+	if (put_user(result, _frames))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
@@ -3152,7 +3155,8 @@ static int snd_pcm_forward_ioctl(struct snd_pcm_substream *substream,
 	if (put_user(0, _frames))
 		return -EFAULT;
 	result = snd_pcm_forward(substream, frames);
-	__put_user(result, _frames);
+	if (put_user(result, _frames))
+		return -EFAULT;
 	return result < 0 ? result : 0;
 }
 
-- 
2.11.0

