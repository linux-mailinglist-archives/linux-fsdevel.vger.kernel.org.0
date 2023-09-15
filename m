Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DB7A1E63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjIOMRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjIOMRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC55B30DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwY60HhWZw2zdeAWEkQbv8cGTe1OUoW+7dI7Ga0rLuU=;
        b=ZNoKkWan3DQSazDIAAEoKn9B1KNdR0aC9q8hpHQxH44TiePsPstDkVUJwx4CA75tEwbc66
        HOz04sTpgDGMwPln8O0Y1SRYiBwCao67zyTkL0H9X12YNHhnThxy2MBPjNT2A9C2Fcm7FK
        jeIznU+iumdmHu+lILYt/lmypOa5mAk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-qLAvrmbgNAO4F4B8Lc6z_g-1; Fri, 15 Sep 2023 08:16:11 -0400
X-MC-Unique: qLAvrmbgNAO4F4B8Lc6z_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90266811E8F;
        Fri, 15 Sep 2023 12:16:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id E71DB40C6EA8;
        Fri, 15 Sep 2023 12:16:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Sep 2023 14:15:18 +0200 (CEST)
Date:   Fri, 15 Sep 2023 14:15:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Ungerer <gerg@uclinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: Re: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Message-ID: <20230915121514.GA2768@redhat.com>
References: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/14, Ben Wolsieffer wrote:
>
> Fixes: 47fecca15c09 ("fs/proc/task_nommu.c: don't use priv->task->mm")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  fs/proc/task_nommu.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>


-------------------------------------------------------------------------------
Sorry for the offtopic question. I know NOTHING about nommu and when I tried to
review this patch I was puzzled by

	/* See m_next(). Zero at the start or after lseek. */
	if (addr == -1UL)
		return NULL;

at the start of m_start(). OK, lets look at

	static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
	{
		struct vm_area_struct *vma = _p;

		*pos = vma->vm_end;
		return find_vma(vma->vm_mm, vma->vm_end);
	}

where does this -1UL come from? Does this mean that on nommu

	last_vma->vm_end == -1UL

or what?

fs/proc/task_mmu.c has the same check at the start, but in this case
the "See m_next()" comment actually helps.

Just curious, thanks.

Oleg.

