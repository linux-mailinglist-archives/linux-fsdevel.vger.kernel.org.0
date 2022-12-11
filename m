Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B146492A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 07:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLKGEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 01:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLKGEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:04:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349F12AB1;
        Sat, 10 Dec 2022 22:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636CA60CA3;
        Sun, 11 Dec 2022 06:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B2C433D2;
        Sun, 11 Dec 2022 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670738642;
        bh=U9Rhp55xf6rXsF3RAaS6Y+CbURUJS89vuN+H36qlHoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gvn7tDTwTp770J0jxxGbJ/eD63c2MIQ371jcBZF6XySVsl5cwc/6/VJo7EmthNzpR
         ox3i1TMBwhRRllHhRuEMj7/Ug14/jRwkSLG9TzG1xFIyrs+jBie1F8LMjwY/9KeJtK
         eIJeshb0ZiuFM2HlcrQabSdC3HRmw7LCtQjh0nG2y2NaUW5CC69gWekQmEFR96jvA+
         W3ZPJEJYx+e3y7DQ4q8N6XLP/qxyzl9WAQoFLBlxikvESbccCCFgAfPRaObz5IC/oX
         VspM7gm8zxvpsnKEKbW6OjUEbeBubLYFyePfm/TrC3WWIJWxybX8d6rAxbBHKq/UQM
         W5JZ+7R9vuEBQ==
Message-ID: <489f2daa-4559-6c32-71e2-8bab65fb8154@kernel.org>
Date:   Sun, 11 Dec 2022 14:03:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH v4 16/23] f2fs: Convert f2fs_sync_meta_pages()
 to use filemap_get_folios_tag()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
References: <20221102161031.5820-1-vishal.moola@gmail.com>
 <20221102161031.5820-17-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221102161031.5820-17-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/11/3 0:10, Vishal Moola (Oracle) wrote:
> Convert function to use folios throughout. This is in preparation for the
> removal of find_get_pages_range_tag(). This change removes 5 calls to
> compound_head().
> 
> Initially the function was checking if the previous page index is truly the
> previous page i.e. 1 index behind the current page. To convert to folios and
> maintain this check we need to make the check
> folio->index != prev + folio_nr_pages(previous folio) since we don't know
> how many pages are in a folio.
> 
> At index i == 0 the check is guaranteed to succeed, so to workaround indexing
> bounds we can simply ignore the check for that specific index. This makes the
> initial assignment of prev trivial, so I removed that as well.
> 
> Also modified a comment in commit_checkpoint for consistency.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
