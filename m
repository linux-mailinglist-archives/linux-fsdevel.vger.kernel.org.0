Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4965DC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjADTIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 14:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjADTIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:08:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403B395DF;
        Wed,  4 Jan 2023 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fDWgFBewtGbw5iHxoxFeYnyYWjOHMX1rLb6gb0kyAo4=; b=pLZgry/SIAY2jl21cVLf3rPcM1
        7uVnYL8dQNMbocA/QpUWiK5zz4Qbly8AG12vjlkGqWskg+BLlaZh0QN4SFHPoxqxhnhvnZyk+pT3c
        6QlT/ZGnOKRWPPfgqdM52zDa54hcFxPqZipEY1LZKlJ48davm+95elVs1ij+nQ1Vk+TQL+hmTWh+x
        c8YJrhqvdO9kzCmLEJeuL/cT6a7VGYu3xu582YLp/VM1O4Hq2l/R+zRvv5CDKir3I54pekM/z/n3p
        IWBn0zkoE0ZOld28/hdgYLY7mfwm9Q+Nr/lG860+lPIjEbZgz5qw/7uQ9ze74qrXlxZ4KfMQvLrBI
        nmPreJDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD97Z-00FJmu-26; Wed, 04 Jan 2023 19:08:17 +0000
Date:   Wed, 4 Jan 2023 19:08:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y7XOoZNxZCpjCJLH@casper.infradead.org>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-8-agruenba@redhat.com>
 <Y7W9Dfub1WeTvG8G@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7W9Dfub1WeTvG8G@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:53:17AM -0800, Darrick J. Wong wrote:
> I wonder if this should be reworked a bit to reduce indenting:
> 
> 	if (PTR_ERR(folio) == -ESTALE) {

FYI this is a bad habit to be in.  The compiler can optimise

	if (folio == ERR_PTR(-ESTALE))

better than it can optimise the other way around.

