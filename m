Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E646F6766B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 15:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAUO3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUO3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:29:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF01F5FF
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 06:29:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3598568CFE; Sat, 21 Jan 2023 15:29:28 +0100 (CET)
Date:   Sat, 21 Jan 2023 15:29:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] Revert "gfs2: stop using generic_writepages in
 gfs2_ail1_start_one"
Message-ID: <20230121142927.GB6786@lst.de>
References: <20230120141150.1278819-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120141150.1278819-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	struct address_space *mapping = data;
> +	int ret = mapping->a_ops->writepage(page, wbc);
> +	mapping_set_error(mapping, ret);
> +	return ret;

I guess beggars can't be choosers, but is there a chance to directly
call the relevant gfs2 writepage methods here instead of the
->writepage call?

Otherwise this looks good:

Acked-by: Christoph Hellwig <hch@lst.de>
