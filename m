Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF23E8E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhHKKSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 06:18:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhHKKSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:18:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 492B51FE29;
        Wed, 11 Aug 2021 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXxkzxAeI1zRXcfhNuJVox5GRDW+XRGzaSn15ZkzWIQ=;
        b=gtsSEl26C5k6EM+5zPX/KCK03KFnfVW5U022dEYv/6dmvqnBj8sxKsQcmr+8AuslP+ICBi
        9zq82WtbXGhTW6fIFLjzqf63kAJ5j+hczgbW0gwOxW+HmJ8s7KFt7R0s5/JFlXf4wb4/xy
        5+a5EoXL9E2Q6q29dEQzhqgztno9uas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXxkzxAeI1zRXcfhNuJVox5GRDW+XRGzaSn15ZkzWIQ=;
        b=Y9AYv4piIzyYwgX3rvmnxvuqYC1zL4R9d+zANMULk6eDe98Qj4qQQPjStMBH+wc8ngU6mK
        98UCKjt6pKGT7jAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3E497131F5;
        Wed, 11 Aug 2021 10:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 13VxAuyjE2HODAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 11 Aug 2021 10:18:20 +0000
Subject: Re: [PATCH v14 034/138] mm/memcg: Remove 'page' parameter to
 mem_cgroup_charge_statistics()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-35-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ba1109ed-4ec0-e99c-8524-17084c9f65b6@suse.cz>
Date:   Wed, 11 Aug 2021 12:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-35-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> The last use of 'page' was removed by commit 468c398233da ("mm:
> memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
> the parameter from the function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
