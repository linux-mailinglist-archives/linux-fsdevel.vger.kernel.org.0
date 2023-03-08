Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B990B6B1501
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCHWXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCHWXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:23:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB45709B;
        Wed,  8 Mar 2023 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R4qQSPrsrxUiF/LJLwzutyWNWtqvwbqt9ycagzE4dZQ=; b=WpHJJcvB82hSQFBxW2dUBjILSg
        xWKBDo52IxNzYVR8UxlzdFs1AX5W3i7+KKQgVUYNhZdb8E/cbEEPRjdtYj7pAVUCH22rs58crVnnw
        58pIGfnUH7p/ZVXxJUxXKnWIXVN/A/eof+fzQfAi8Coo1I1yICPSB8WHrwTFZ5C5aAL8Ie3184eQ+
        axjXHq6rLEVpG2YgxUW1eyoL+o6PY9I9114cnaAukCTtHkbMdj0V0SBas/RqNQ3Bx/Tidd4hGD7WX
        0EyyeIRrrrrz4ACT9N2QvjVG4uLmRk2doE9emiWOkxqUI0EEcQNtr7VCw6fLq0EgY/MwU3D3nFM4X
        W2DwxJGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa2Bf-006xGf-CU; Wed, 08 Mar 2023 22:23:07 +0000
Date:   Wed, 8 Mar 2023 14:23:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 2/2] mm: compaction: Limit the value of interface
 compact_memory
Message-ID: <ZAkKy8LVXKF2C7kv@bombadil.infradead.org>
References: <202303061405242788477@zte.com.cn>
 <c48666f2-8226-3678-a744-6d613288f188@suse.cz>
 <ZAjorPD2nSszUsXz@bombadil.infradead.org>
 <cd60d29e-9512-dcc6-e72a-a4936fed42f5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd60d29e-9512-dcc6-e72a-a4936fed42f5@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:54:31PM +0100, Vlastimil Babka wrote:
> On 3/8/23 20:57, Luis Chamberlain wrote:
> > On Wed, Mar 08, 2023 at 11:23:45AM +0100, Vlastimil Babka wrote:
> >> >  {
> >> > -	if (write)
> >> > +	int ret;
> >> > +
> >> > +	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
> >> > +	if (ret)
> >> > +		return ret;
> >> > +	if (write) {
> >> > +		pr_info("compact_nodes start\n");
> >> >  		compact_nodes();
> >> > +		pr_info("compact_nodes end\n");
> >> 
> >> I'm not sure we want to start spamming the dmesg. This would make sense
> >> if we wanted to deprecate the sysctl and start hunting for remaining
> >> callers to be fixed. Otherwise ftrace can be used to capture e.g. the time.
> > 
> > Without that print, I don't think a custom proc handler is needed too,
> > right? So what would simplify the code.
> 
> But we'd still call compact_nodes(), so that's not possible without a custom
> handler, no?

Ah right. It does beg the question if that form is common, so to define one.
But that's just extra work not needed now.

  Luis
