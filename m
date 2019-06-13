Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3C4470D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfFMQ4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfFMBSO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:18:14 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE68208CA;
        Thu, 13 Jun 2019 01:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560388694;
        bh=t8ziDUjGRatmX8RI2sR6uyYMindRv5VWtp1mspyO4HE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B6QwZ4EL/RBtMxQBQ2C4dYwyr9DAJ+Z2Z3aJYcMQaieNiGU59KS/u8/xtLLpUbW7T
         m8OVV9+d3Wy/w/AD79mktyWQ9phS4xvdMROxkLy5tWqzeIv5KZdGBnmd8Y37PQfYMW
         8g+LcA6tVIJiZ3F672gNG+5F6YHn3ViB+XbeCa+A=
Date:   Wed, 12 Jun 2019 18:18:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: mmotm 2019-06-11-16-59 uploaded (ocfs2)
Message-Id: <20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>
In-Reply-To: <492b4bcc-4760-7cbb-7083-9f22e7ab4b82@infradead.org>
References: <20190611235956.4FZF6%akpm@linux-foundation.org>
        <492b4bcc-4760-7cbb-7083-9f22e7ab4b82@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Jun 2019 07:15:30 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/11/19 4:59 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-06-11-16-59 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> 
> on i386:
> 
> ld: fs/ocfs2/dlmglue.o: in function `ocfs2_dlm_seq_show':
> dlmglue.c:(.text+0x46e4): undefined reference to `__udivdi3'

Thanks.  This, I guess:

--- a/fs/ocfs2/dlmglue.c~ocfs2-add-locking-filter-debugfs-file-fix
+++ a/fs/ocfs2/dlmglue.c
@@ -3115,7 +3115,7 @@ static int ocfs2_dlm_seq_show(struct seq
 		 * otherwise, only dump the last N seconds active lock
 		 * resources.
 		 */
-		if ((now - last) / 1000000 > dlm_debug->d_filter_secs)
+		if (div_u64(now - last, 1000000) > dlm_debug->d_filter_secs)
 			return 0;
 	}
 #endif

review and test, please?
