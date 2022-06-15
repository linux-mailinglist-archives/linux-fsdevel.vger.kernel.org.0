Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CDB54CA16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354371AbiFONoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354405AbiFONob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:44:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3413054A;
        Wed, 15 Jun 2022 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B2uGtqdyTyve2A4HjKnERqrT+Xadprbqi+LBFQJ2wQY=; b=ufIki4AtSH5dq2SbjSMl8CPEFM
        v/EXBmPrriTKKf+lAr+zfVp5vQPC/WHGO384N0tyCGrmaWBPwMlw/6FQ3XPGYw8e6R4o/v8qnMUvp
        eTJQNBqMMkZcXw1dRJIqRgWEosXToBf2elNWVgrs4ARibwFgQPM/KhZL7gJWXEmEp+A2ctlGP1HpZ
        con0jb9tA2OCEhX9gVlKcS2bP5G9PMSuEEJsh3DYCnbwqaJg2QS7Ox95e8kQgp2l9SSJx7rCViRXb
        irBpdVoNMVr6dVuECOeDM3StQWjEVGlLZLRqFIpZk01yqzHG6iHr+c3Gd4wUlU/yLNyLiQs/9F7Ay
        WJEdjx0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1TJr-0015gS-QI; Wed, 15 Jun 2022 13:44:27 +0000
Date:   Wed, 15 Jun 2022 14:44:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 3/3] proc: use idr tgid tag hint to iterate pids in
 readdir
Message-ID: <YqniOxl4ACKVp9hM@casper.infradead.org>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-4-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614180949.102914-4-bfoster@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:09:49PM -0400, Brian Foster wrote:
> +++ b/include/linux/idr.h
> @@ -185,6 +185,20 @@ static inline bool idr_is_group_lead(struct idr *idr, unsigned long id)
>  	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TGID);
>  }
>  
> +/*
> + * Find the next id with a potentially associated TGID task using the internal
> + * tag. Task association is not guaranteed and must be checked explicitly.
> + */
> +static inline struct pid *find_tgid_pid(struct idr *idr, unsigned long id)
> +{
> +	struct pid *pid;
> +
> +	if (radix_tree_gang_lookup_tag(&idr->idr_rt, (void **) &pid, id, 1,
> +				       IDR_TGID) != 1)
> +		return NULL;
> +	return pid;
> +}

The IDR is a generic data structure, and shouldn't know anything about
PIDs, TGIDs or tasks.
