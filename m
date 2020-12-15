Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17AF2DAE9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgLOOK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 09:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgLOOKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:10:45 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE33C0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 06:10:03 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w1so23204810ejf.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NO1cdDn3rveUCdkxTy4K6Bz123za1ZPbmRLXpINNXFQ=;
        b=Cj5TDFrP2UXo3tmwVUdTH7+GGb5RV0uPmO3jFGipk9hla1suqNd371yVeP25Rb7d8R
         95thK+Kh0JbtyxNnRkK1QRrqiZ6+aDvVemT0KoFkKgrhdDhdeIjuWDIIBY1fJxz/XCAD
         5GZ+TCH1ctDULr82sPdO6oNK483aeK/vBbo5gKWwqupJhRnSgpppS20wv5YTPvbMj/Ks
         oeCMBtDzYPiSCngc2EEZ7N5Qv1l88T9Ndv4Df6mkbk9phQGuT+4qPHBxfWzfQG2sW5Ra
         ipaEaUl9qeKnOtRDEfXw3a1Y+gzWybJBjz8NjbwoO4TpGQhICs7CJx6+gWBEE/GzU6JV
         jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NO1cdDn3rveUCdkxTy4K6Bz123za1ZPbmRLXpINNXFQ=;
        b=HpSK9QXibs12imTTAW5gLfsKQfTs8kyimn36f7rjZ/cDlh8x7lS4+WCELtbIL/3Fx7
         20YrU6c6CPH79XDIgL6myzLiREasuVm704mlx2ZD/U099nrja4Iqb8OAXhpyuVvygnul
         9azS2wr+byL4bSYl5ZTs56ywb709QuE5CBfVIZ1mVZt73XMTn3em4lLxvbQ3Dk/FJGwT
         rMRgC29jv21+jsXq0Zbe+a9C+UT2rsLINRgyDRc94qFQviPkcY+2m/8ACi0+C/VY4jEE
         rzFFgq6sTYRg9HwURbxYGS/5v2vG4As/kFdBkQ0vjcvksMC9jwodE3EJ9WeHBHPdnxxQ
         NHcw==
X-Gm-Message-State: AOAM530BL28WA5xXxjico99aYPuDtI+N7pU937X1uN2BxK0m3RQKcRD6
        mvo2ZbKS2z9zizTDDhQEevRv3A==
X-Google-Smtp-Source: ABdhPJzPRYE9A5cY1G5sZnG6cPGdS4cAxTTw3KczQzQ73+UAxRhdd0rjjZ9pos0m/8EZVDC0oufo1A==
X-Received: by 2002:a17:906:8587:: with SMTP id v7mr26396217ejx.381.1608041402353;
        Tue, 15 Dec 2020 06:10:02 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id d4sm19109737edq.36.2020.12.15.06.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:10:01 -0800 (PST)
Date:   Tue, 15 Dec 2020 15:07:54 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201215140754.GD379720@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.  This should not exacerbate the contention
> to shrinker_rwsem since just one read side critical section is added.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Yang, this is a step in the right direction. It would still be
nice to also drop memcg_shrinker_map_size and (trivially) derive that
value from shrinker_nr_max where necessary. It is duplicate state.
