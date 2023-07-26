Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8F763A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjGZPJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjGZPJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:09:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104102683;
        Wed, 26 Jul 2023 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3SBJoGUFZ8lwNkwq/ql9uohKYuuPWo1S+MSI6dKly68=; b=kxg70PNCtug0NJoFTuxLUyLzfJ
        yoL1xXtL8MafasBRbj3eKvHSYAe/765iHCyGLEVnRawDXUnEEUBDfFJ5K4mtDwrZ56ZwNKXLRqMVL
        WyB7C0LBiht5Rv5BXDbmUjmyQPDEvoGEE/BBcprp5VAbEaWgfo3gfvSQqbYghXGezTUvrQuDgi4tl
        BeVsH8AADMNLrZcyT3iOv/c1l1CwhEY5OHLZC6A64M3Jdky3ZvMxQgEpHVJRtrtYNVoRwqwPGCGJP
        cKXPTSmg7LQahm5ypLgqF/Dr6T7myCulXlL1hlUS069de/c5He+dIOj6/EkZo5gWjGWBNnqPi4fCP
        HHA7XSQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOg7Y-006aoa-W3; Wed, 26 Jul 2023 15:08:13 +0000
Date:   Wed, 26 Jul 2023 16:08:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        avagin@gmail.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/11] maple_tree: Add some helper functions
Message-ID: <ZME23DS/Elz2XPey@casper.infradead.org>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-4-zhangpeng.00@bytedance.com>
 <20230726150252.x56owgz3ikujzicu@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726150252.x56owgz3ikujzicu@revolver>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:02:52AM -0400, Liam R. Howlett wrote:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> >  static inline
> > -enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
> > +enum maple_type ma_parent_type(struct maple_tree *mt, struct maple_node *node)
> 
> I was trying to keep ma_* prefix to mean the first argument is
> maple_node and mt_* to mean maple_tree.  I wasn't entirely successful
> with this and I do see why you want to use ma_, but maybe reverse the
> arguments here?

I think your first idea is better.  Usually we prefer to order the
arguments by "containing thing" to "contained thing".  So always use
(struct address_space *, struct folio *), for example.  Or (struct
mm_struct *, struct vm_area_struct *).

