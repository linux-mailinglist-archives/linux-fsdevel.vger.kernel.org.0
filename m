Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878A427799D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIXTo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgIXTo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:44:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9846C0613D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g29so338266pgl.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADwlTn9rnJzlHv/xfLefERCgTh/zOY3+dj+IP5LMhIo=;
        b=L2Wx7FlLw8QHVp62Ne3mt4GV7+MUCO/WLUazgDqXAmYbUX1Et5GwKUZRbOhKWcg1pJ
         h3F8YG2QH8T53HlhbxkOnKDq7rYr7VYQSpBZ/SrGKbAAN0q9gjlZztvIvkLYWYD2H5p5
         D5jWhUDJxNaNV9x10hDsgdYsv3+GqUJuih92RXGRYnyEyog4jlWpFA8o+B+sqtqEeysu
         zXsVFR5QGsEI7lJZ39JHqx1JjZyubGP7QEwNsybW+JHQWulohPcvjDgNlPxNi7sQOhp+
         YLXR3ph4QhgGStegDp9ue2849D7tWES5wOYPeY73GujeWcYMaP3DsMTgcgakPfQ8C4Iw
         pmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADwlTn9rnJzlHv/xfLefERCgTh/zOY3+dj+IP5LMhIo=;
        b=nb+fUWURGMiv4LM6QsBThO72+wX0/hPB3C3FbrR1Adu1XP6uZtKd8lTZDJ7Q1baA2x
         6uhtAfoOvL+nPg9tofxPimzzQv6RDUaVckGw/1tPDqxxmSJ61dZKurMjbEBD41Yo4M+k
         FBvAFecAEqS0/0i7dVt5vixD0HTJQatIZ4HuGq9WPh9pgxXqwbMuzwEtHzhuWsw8vQpg
         2LB4lP8k3iZs45mnQX4Wl6PdCuf3znC9x2IukggdotD9vsxAKVxSAla8bGaeYcSYe4K+
         3oSdq1nVQ/H+6JgrsXAMXJCm5POwVQsBtF0O4HhA89sJ+/xbvfX85OhduXr/zCgbT9jw
         1R8Q==
X-Gm-Message-State: AOAM533NIuAlYlvhuSxbB1dfovmnIj3uCFCPMmoJnx3NXczNxSBqxJYr
        Wt+9T7EB0W/Uc2oMjNgRvNAUQg==
X-Google-Smtp-Source: ABdhPJyn7jUbiC3AGiO/dBfKmKGpcA3VV/JE4LzjEmCUjGJIbrcL8/kmgANM72e+JonEfnG9EJ77rg==
X-Received: by 2002:a17:902:854b:b029:d1:cbf4:bb43 with SMTP id d11-20020a170902854bb02900d1cbf4bb43mr778274plo.13.1600976697336;
        Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1911? ([2620:10d:c090:400::5:d63d])
        by smtp.gmail.com with ESMTPSA id u10sm267612pfn.122.2020.09.24.12.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:44:56 -0700 (PDT)
Subject: Re: bdi cleanups v7
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20200924065140.726436-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9235ba9-95a0-4251-ee7d-e4012775346e@kernel.dk>
Date:   Thu, 24 Sep 2020 13:44:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924065140.726436-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/20 12:51 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Applied, thanks.

-- 
Jens Axboe

