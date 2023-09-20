Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843787A8F3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjITWXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 18:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjITWXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8BD6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695248565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wf1ilFnN40MCOQdTnir6rzgfTHWCDirDBrdNo7z0qfI=;
        b=IzRG3JPetrAKVwwkU2l9S7yRpl8MkqV273gbY/jOCnVb7yCWRTZtLCcdYJgZsM4BbMVCeS
        4N/wvDfAFm0t0KdLPAZfCXxFJL7f1lbEkAFrrZYaJzrYFGYdCxCtiDLdF6ppPC+s9uHvV9
        VqiLQ7XjX+KZd6LUmVhzrxUtDy8/Ebo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-wPPuppLQO0SLdceeEFMs3Q-1; Wed, 20 Sep 2023 18:22:41 -0400
X-MC-Unique: wPPuppLQO0SLdceeEFMs3Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4219F800B35;
        Wed, 20 Sep 2023 22:22:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3AAA492B16;
        Wed, 20 Sep 2023 22:22:36 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v5 01/11] sound: Fix snd_pcm_readv()/writev() to use iov access functions
Date:   Wed, 20 Sep 2023 23:22:21 +0100
Message-ID: <20230920222231.686275-2-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix snd_pcm_readv()/writev() to use iov access functions rather than poking
at the iov_iter internals directly.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.com>
cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Suren Baghdasaryan <surenb@google.com>
cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
cc: alsa-devel@alsa-project.org
---
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bd9ddf412b46..9a69236fa207 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3527,7 +3527,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!to->user_backed)
+	if (!user_backed_iter(to))
 		return -EINVAL;
 	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
 		return -EINVAL;
@@ -3567,7 +3567,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!from->user_backed)
+	if (!user_backed_iter(from))
 		return -EINVAL;
 	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
 	    !frame_aligned(runtime, iov->iov_len))

