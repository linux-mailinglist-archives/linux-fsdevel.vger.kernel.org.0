Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235145F117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351390AbhKZPze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:55:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56614 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbhKZPxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:53:33 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD4E21FD37;
        Fri, 26 Nov 2021 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637941819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ+Mm6JkV2Xf+vFQs3eoCHIf48wz7aoTUs8bjzPap3k=;
        b=qAe2WCHRLdGzgPM+zT8eJXkmYsFOBqZ2pQ73KBeXJ0xonvjhQJd81DM6XEy2PVcqO10YsA
        57CA6qNLOAOQCJNp9gns/Bg7wxbL9qCBupZBbXXK9pwR22lFSc/hX1eQQCsw3BxnS7tJe5
        JhLiNGy4dQ04j3nHuclo4OzZujIfbC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637941819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ+Mm6JkV2Xf+vFQs3eoCHIf48wz7aoTUs8bjzPap3k=;
        b=fGmgVKfp1jmCter1YmfQc0E1Fp+1Jp30bVaFYsPJCyg5KwJUXR+YE6d2qvb1TEEHwEVl59
        m2VtwfCawNbW+vDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87DF413C65;
        Fri, 26 Nov 2021 15:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gtp/IDsCoWHfdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 15:50:19 +0000
Message-ID: <ce493dd5-ad75-60dd-97e4-663e016d1669@suse.cz>
Date:   Fri, 26 Nov 2021 16:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 4/4] mm: allow !GFP_KERNEL allocations for kvmalloc
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-5-mhocko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211122153233.9924-5-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/22/21 16:32, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> A support for GFP_NO{FS,IO} and __GFP_NOFAIL has been implemented
> by previous patches so we can allow the support for kvmalloc. This
> will allow some external users to simplify or completely remove
> their helpers.
> 
> GFP_NOWAIT semantic hasn't been supported so far but it hasn't been
> explicitly documented so let's add a note about that.
> 
> ceph_kvmalloc is the first helper to be dropped and changed to
> kvmalloc.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
