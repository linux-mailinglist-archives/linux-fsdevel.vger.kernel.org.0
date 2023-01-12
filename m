Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48D666F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjALKXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjALKWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4810459333;
        Thu, 12 Jan 2023 02:17:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B400561FAB;
        Thu, 12 Jan 2023 10:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB3CC433F0;
        Thu, 12 Jan 2023 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673518678;
        bh=RWmztfAERjHa5tH2ViWsV3yzcmvZGe2nsppJNqvO6nY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QimElLgAUkm2pWG+9clfVm0g/+I6aeQhLiop1NXH3ggqRgiSMYuDCeVoo/S6+gzJY
         PNOdc4zkc3g9vyJRLCGGXs4xGlo2bgd5WV5BpGVnWqWkZWHvG4+Twb3PpOcVWA00TQ
         CtSJ6oBVJZuWds8Gzwxd8uJD8KaK/QeN/ecUiTunWAzFOgwVHZkQpn5DSQxQ5pMdCZ
         nFZuhHlKq/ihDO4Z6VQ2I0D0Z7OO7T2vhPX7bVGqCpBjEdHbFWFj6FAHk6UWQOIMvG
         bwAyAfb1J08LRHSsE2RopFWsuG50ER9ahudfzjFNkB4hLI0aND1X18nTETl1T5hHXf
         F06w0Cy7QBsGA==
Message-ID: <9481a114-04d3-7276-bc82-ee18c685b5a6@kernel.org>
Date:   Thu, 12 Jan 2023 18:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [f2fs-dev] [PATCH v5 14/23] f2fs: Convert
 f2fs_write_cache_pages() to use filemap_get_folios_tag()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
References: <20230104211448.4804-1-vishal.moola@gmail.com>
 <20230104211448.4804-15-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230104211448.4804-15-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/1/5 5:14, Vishal Moola (Oracle) wrote:
> Converted the function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
> 
> Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> of pagevec. This does NOT support large folios. The function currently
> only utilizes folios of size 1 so this shouldn't cause any issues right
> now.
> 
> This version of the patch limits the number of pages fetched to
> F2FS_ONSTACK_PAGES. If that ever happens, update the start index here
> since filemap_get_folios_tag() updates the index to be after the last
> found folio, not necessarily the last used page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
