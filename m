Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB554EE4E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 01:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiCaXue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCaXue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7651B2C4B;
        Thu, 31 Mar 2022 16:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55EE5617A5;
        Thu, 31 Mar 2022 23:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D7C340F0;
        Thu, 31 Mar 2022 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648770524;
        bh=6zXF3RtH0MX2dSUeTh1r3Iz5LNcDSqi2XStc7THHwHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GiuRiz7BBnjgIuNm+MWqvnxJv9rwWH0x02X8yEEbIdE1A+VxiHDiOWzLiq+/gHnLz
         Suj93g6Bi+SVgqFl0gQoTHFmp6u1w2E0iYx68C5rnTyTjpBfs6SglL4N70o/6BlFf7
         0HCy+egJKD9YrsoOwZE8j/3nRk0wNYSE6/Hcj2yU=
Date:   Thu, 31 Mar 2022 16:48:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] fs/proc/kcore.c: remove check of list iterator against
 head past the loop body
Message-Id: <20220331164843.b531fbf00d6e7afd6cdfe113@linux-foundation.org>
In-Reply-To: <20220331223700.902556-1-jakobkoschel@gmail.com>
References: <20220331223700.902556-1-jakobkoschel@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  1 Apr 2022 00:37:00 +0200 Jakob Koschel <jakobkoschel@gmail.com> wrote:

> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> ...
>

Speaking of limiting scope...

--- a/fs/proc/kcore.c~fs-proc-kcorec-remove-check-of-list-iterator-against-head-past-the-loop-body-fix
+++ a/fs/proc/kcore.c
@@ -316,7 +316,6 @@ read_kcore(struct file *file, char __use
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
 	struct kcore_list *m;
-	struct kcore_list *iter;
 	size_t tsz;
 	int nphdr;
 	unsigned long start;
@@ -480,6 +479,8 @@ read_kcore(struct file *file, char __use
 		 * the previous entry, search for a matching entry.
 		 */
 		if (!m || start < m->addr || start >= m->addr + m->size) {
+			struct kcore_list *iter;
+
 			m = NULL;
 			list_for_each_entry(iter, &kclist_head, list) {
 				if (start >= iter->addr &&
_

