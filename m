Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD522A5BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 02:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgKDBUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 20:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgKDBUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:20:33 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590C8C040203
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 17:20:32 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o3so15115415pgr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 17:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hvt5hI7HDdctAK55bNYHJ4XmctT+HEghDbdMAXPbZ5g=;
        b=aq1E5K6kmU0nnjzsWI1rt2Va0QbZ4Ji0niXipuJ5JAyVE6NWm1egHASx7hciZfzlqS
         WFzJyG+PPERqUOm3Cpq4u+lbuXqmVNltCsiw9tPfOHQIHqJBnm3oDgCGBqC2ROBEbVaW
         Dr4cC3+gqfWJ5XT+cy1v/Nys0JxqFwmZBwCspAPzJ/8RgEjOMzEHJShTlTXQ2wGijcgi
         DFOWC6qjRgTZA4dorxFY2lUe6Yyd3gkRXn7XDDLjJDej8ZG/Wnem5lNkRL5ka7ZAqebX
         wa/hq9AkNWBvT5yRLe1H6RwZU8+Xyu8Ww3B73YJEL4QPUXg5C19vpIlgAbM+rpyIjjIK
         JT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hvt5hI7HDdctAK55bNYHJ4XmctT+HEghDbdMAXPbZ5g=;
        b=N0oZocih/YX7L4DYLX9AVdPDvFi5BYWsqupR6Pr/Gof7TjvCbN8GYhnWD6mf8Tuen9
         +vyu7tllTBfXoTivsKeghoootSZPXGw9EnWBuo6w3DTW9eWEY8408gPKNlMSqGsAE7iJ
         C1Yrh6QVLpo1Nol/WoI7BNSDgj26+tAfJ6d9bbHM3lL33QY9xYAjDZqigtPTy4eJqSWq
         luaYHT62gXcxtSMcrZ45PN7+8DoBcwnWPy+19jXykOuVTf4XJSeMDLQu8ynkv/Hx4QnH
         r8eD3m3nivK9JfNxSGyYYom+42yT8PT1JCPH0c9cnuu/YUsw0G07kGvwXH5Mm9hMLLyu
         Achg==
X-Gm-Message-State: AOAM533WN2Dt23h5YWUy4CmZvsYeZQSOiA7+E22NrTyaycR272CfZ5mL
        fLZGM2QimOxNe7PM4lNYo7w=
X-Google-Smtp-Source: ABdhPJw6Pl73jkTlMTonNNuU+/cQ5qa9lh3QwW74KxYvv8py0F5+EQ1WCskUYGT0hBbMUIPaUEV0eA==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr18712465pgc.214.1604452831915;
        Tue, 03 Nov 2020 17:20:31 -0800 (PST)
Received: from DESKTOP-P2JGRFE.localdomain ([1.234.114.36])
        by smtp.gmail.com with ESMTPSA id w131sm346176pfd.14.2020.11.03.17.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 17:20:31 -0800 (PST)
From:   Wonhuyk Yang <vvghjk1234@gmail.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, vvghjk1234@gmail.com
Subject: Re: [PATCH] fuse: fix panic in __readahead_batch()
Date:   Wed,  4 Nov 2020 10:20:17 +0900
Message-Id: <20201104012017.19311-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103143828.GU27442@casper.infradead.org>
References: <20201103143828.GU27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wonhyuk Yang <vvghjk1234@gmail.com>

Thank you for your reply.

> By the way, this isn't right.  You meant 'if (xa_is_value(page))'.

I think you missed a ! operator. Actually I was not sure that there
are other internal entries except retry entry and zero entry in 
the xas_for_each(). 

> The reason we can see a retry entry here is that we did a readahead of a
> single page at index 0.  Between that page being inserted and the lookup,
> another page was removed from the file (maybe the file was truncated
> down) and this caused the node to be removed, and the pointer to the
> page got moved into the root of the tree.  The pointer in the node was
> replaced with a retry entry, indicating that the page is still valid,
> it just isn't here any more.  And so we retry the lookup.

It's a little difficult for me, but thank you for your specific explanation.
