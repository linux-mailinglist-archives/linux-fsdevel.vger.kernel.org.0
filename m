Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C496A45CE58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhKXUtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhKXUtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:49:41 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1788C061574;
        Wed, 24 Nov 2021 12:46:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 207so7985411ljf.10;
        Wed, 24 Nov 2021 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqvC+dGbfcX6cKXaEroZ5TEDlwO+hSkZLjOyRL/i65M=;
        b=TcA3Rt9RWkYyKJgneybHJZWfkYCfIKSvcMQ4Fj3n2JNzm8PQCgSgkJc6CbX11j7ved
         Ld/wWhaiYekfnIUycbvocmFX7/QnDYjTjidQF6q94HaFwbHWuJUwK65XmMk5oHOpvuHj
         nkm0AGHRbBnWZgpHVB7wqqJZbxH2EDzTeNd4ZMcazbZbZo08aclDlxv+YdtPlv7b1ffo
         MDU2dZOUBFFk8ID9fp7o3nSSNnBfFMzbsL/FXnpSaDpfUmarOpmyB7je/wGin6cYMstD
         jJbeVPVLsouO+L6CKq66JWLe5JKFUSxYQiaZRLyQpNZsTyGzE9YgF92kYvdFqA9YQt7b
         g8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqvC+dGbfcX6cKXaEroZ5TEDlwO+hSkZLjOyRL/i65M=;
        b=HPE2J0On/tVKeGZBkMLNX/Cypo59PHkBDggDt209xnSOXTGo7qOlSzzOO6/Q9KfjON
         p/9+sdApZ865TkPrsrjimC040joqHcQMt64cOnkjrrQeT3ZCZXz8b8+sTPabJ6PtFlb8
         97Q7y4fRU+/jfyMFvn+HLSiK/uU1bwu4G5kz+vQjGi6zzQY8AzJy/xmKM+BCwv7aczlF
         QBf3vlkqQgmG+Nyjp+frEcKARAq9pXP+l88Nc50YkFvFuBcyZthlL4BrpgzQjZe2Cr57
         jghJM5/HlUelHqlKsw8QiE5/JtWknIOlAMTjI4CRvE+IRhc3FUz3t5lafjDXRFy6uacH
         xl1A==
X-Gm-Message-State: AOAM531IeoNL3atKmCCapzORBTQJCyiLpT6bMUa1E6uzaHPC7EGb5/sW
        dzo4RMP9kbNOFXT+bF9swhA=
X-Google-Smtp-Source: ABdhPJzwTzo1b7j/+DUso3wsuKzfqD0+SzfyXNXfc3mkgDa231ju+a0J3nvbbccKYDe86sApmqEc+g==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr19691966ljp.280.1637786789149;
        Wed, 24 Nov 2021 12:46:29 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y22sm79998lfg.272.2021.11.24.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:46:28 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 24 Nov 2021 21:46:26 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ6kopRGlHEOgOb5@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <YZ1KZKkHSHcSBnBV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ1KZKkHSHcSBnBV@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:09:08PM +0100, Michal Hocko wrote:
> On Tue 23-11-21 20:01:50, Uladzislau Rezki wrote:
> [...]
> > I have raised two concerns in our previous discussion about this change,
> > well that is sad...
> 
> I definitely didn't mean to ignore any of the feedback. IIRC we were in
> a disagreement in the failure mode for retry loop - i.e. free all the
> allocated pages in case page table pages cannot be allocated. I still
> maintain my position and until there is a wider consensus on that I will
> keep my current implementation. The other concern was about failures
> warning but that shouldn't be a problem when basing on the current Linus
> tree. Am I missing something?
>
Sorry i was answering vice-versa from latest toward first messages :)

--
Vlad Rezki
