Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3077B32F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjI2M7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2M7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:59:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BBAB7;
        Fri, 29 Sep 2023 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmHeRReypOC1/PTNYdEeOv0TmfOCqlGndNJrCadbeNo=; b=q5zVxBi33+Nmp9sMvNQxIi5Dum
        dThXVAqNoC3JwqJ59jU8OZ0hV/jd6QMLq2riYYbdMzzXvmiJIGDeejnFdIyPOqik2nndUT8FLSXJB
        /9PJEjlgqyxWOQ2vAaneH0kH00AXJ4tKkh5Z/uRANmE74ZU0ji1y7Flw3c8HQ/AQAEK6tjMKiEoIu
        Dbtl+jfgoG+YDzkPkRLhApIwz+OzLPW/zV4oAuSc8C8oX6VDcEAcXwi3ZDFH/POsa4Fbu1dNn3zJ4
        PCHwhz+bxClpQ4CevUPXhH4MHw3nx1KXUB7hvVas5h+7Af0zSCAIZ7IvmLrdVOXeS31P1qA+l0M+F
        HNiCTCag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qmD5e-008rPk-G8; Fri, 29 Sep 2023 12:59:30 +0000
Date:   Fri, 29 Sep 2023 13:59:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3] vfs: avoid delegating to task_work when cleaning up
 failed open
Message-ID: <ZRbKMmRm8i+/E88f@casper.infradead.org>
References: <20230928102516.186008-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928102516.186008-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:25:16PM +0200, Mateusz Guzik wrote:
> Below is my rebased patch + rewritten commit message with updated bench
> results. I decided to stick to fput_badopen name because with your patch
> it legitimately has to unref. Naming that "release_empty_file" or
> whatever would be rather misleading imho.

Do we still need fput_badopen()?  Couldn't we just make this part of
regular fput() at this point?  ie:

+++ b/fs/file_table.c
@@ -435,6 +435,10 @@ void fput(struct file *file)
        if (atomic_long_dec_and_test(&file->f_count)) {
                struct task_struct *task = current;
 
+               if (!(file->f_mode & FMODE_OPENED)) {
+                       file_free(file);
+                       return;
+               }
                if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
                        init_task_work(&file->f_rcuhead, ____fput);
                        if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))

