Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F043E8E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhHKKVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:21:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhHKKUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:20:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F139B221CC;
        Wed, 11 Aug 2021 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAGk8iOiGdr+N/h116Wjgrew3d+TBsOOLglnQkB62gk=;
        b=JIUKtvQZFGHR6+JpRBtCklcDPvZKsfGiHDpFhQOGdKfGWYjCjy7fcxp0u83uy2CkTsJXJQ
        WmUG1cxvJxF4U957bod/H/A3QhsBee6i5DFX6f+YLDcAWzG7Lr8xSUaORP/8Ed/ANeOnER
        VC62Tp6uDhdegvWjjRKNXV7IbPXZMGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAGk8iOiGdr+N/h116Wjgrew3d+TBsOOLglnQkB62gk=;
        b=rf3QvjlaW3f4bRmlW/2QvNNbrnOmhST9WeDhT8C0rd4KXAb+l54atTniMyLbuNXZyDUpky
        F53kYo4N6nuSPfAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D48B6131F5;
        Wed, 11 Aug 2021 10:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Rrg1M2ukE2FQDQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:20:27 +0000
Subject: Re: [PATCH v14 035/138] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-36-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <95316d90-fad8-61c4-edeb-c2fc56e0b346@suse.cz>
Date:   Wed, 11 Aug 2021 12:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-36-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> By using the node id in mem_cgroup_update_tree(), we can delete
> soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> bytes of kernel text on my config.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

