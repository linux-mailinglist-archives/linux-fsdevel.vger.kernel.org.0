Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93022CC50F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgLBS21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgLBS20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD0C0617A6;
        Wed,  2 Dec 2020 10:27:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id z12so69650pjn.1;
        Wed, 02 Dec 2020 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zNax7Y+1Ikzzmhg7iyW9MLSCw7jdgQnq4TmPmAJA28=;
        b=lqgtJVieKYGe00RIy86iIPDzKFYzexsfSaJr1YoR0txN85LXyOfkwRqTWB4Yi4HbdH
         nW1fn6UWKm75o2mYOsdPMdaVFWvTVzYmb3IHzsTFljeNu2jYbGsayg5p/0JjFIKUy7fi
         EcVJnKMcNIxe8nbRgx7UFLKUrp5JpvY6Ut1jHyBgbJv0ywwGLMkwB3LRH1YWUgazYloO
         FyEMdudReYKkvu8AvWCzlu/nf0Y6nkMhXK3doSrKwApihvi4aJpDpKf9Y8GzIlX70gTU
         HrWUPyuhdv2b7Xk0Cq6TUZ/dng83s4OMzmHCh3za7c3rpSqI13eT9uaq9BIQzuKJTWHf
         Bs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zNax7Y+1Ikzzmhg7iyW9MLSCw7jdgQnq4TmPmAJA28=;
        b=XppbEzX3EFYdTjpJmp27wo4u9p6fQNW7Rie+X2vU3T0DgTJb+aQw2ugIpOn2TcFs9s
         udxHD2udfCt2EeTZ3eCAh1ctf8KXakBOMYsMiRiFGqx3eksyc1sJkq3DwmVPiUxqVtzy
         D78sS2Blu9p3HGguI6sdyd1VFOsyjUWJx7Yli7Gv+61bUW9cVRH6mzBGWNRpE++SOwWd
         qf1oxoKLmz077Mz6n/7kk4HBjmBbldrCvca9aMANhFYUgX9xO+LrslQ3Q+0Af6nmMjqk
         CD/C36AVKdTv9jr6yRlWPz7T+VZveLNeY4p9z4nLyc4HExAcrVkCsmF6EOhkjp5cBq7I
         3RZg==
X-Gm-Message-State: AOAM532D9PY3/215zjVRkLXvSL+vowWuFc3b5A9aXDdlvVHh76Gjzkv8
        dJMQlelpQn1vgy95LL4hsqI=
X-Google-Smtp-Source: ABdhPJz1U890O+WgeLnLZND4JEg1gfgDFo2nW9DjhiZUqUmGdG+/Pm+qglOPbdvkQ2Toj/Szkz158w==
X-Received: by 2002:a17:902:b691:b029:d8:ebc8:385e with SMTP id c17-20020a170902b691b02900d8ebc8385emr3855010pls.48.1606933665893;
        Wed, 02 Dec 2020 10:27:45 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:44 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm: vmscan: simplify nr_deferred update code
Date:   Wed,  2 Dec 2020 10:27:17 -0800
Message-Id: <20201202182725.265020-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently if (next_deferred - scanned) = 0, the code would just read the current
nr_deferred otherwise add the delta back.  Both needs atomic operation anyway, it
seems there is not too much gain by distinguishing the two cases, so just add the
delta back even though the delta is 0.  This would simply the code for the following
patches too.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac2cf..7d6186a07daf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -528,14 +528,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		next_deferred = 0;
 	/*
 	 * move the unused scan count back into the shrinker in a
-	 * manner that handles concurrent updates. If we exhausted the
-	 * scan, there is no need to do an update.
+	 * manner that handles concurrent updates.
 	 */
-	if (next_deferred > 0)
-		new_nr = atomic_long_add_return(next_deferred,
-						&shrinker->nr_deferred[nid]);
-	else
-		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
+	new_nr = atomic_long_add_return(next_deferred,
+					&shrinker->nr_deferred[nid]);
 
 	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
 	return freed;
-- 
2.26.2

