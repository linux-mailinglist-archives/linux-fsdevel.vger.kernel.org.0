Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4428109C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 05:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfHEDo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Aug 2019 23:44:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37714 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHEDo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:44:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so6145925pgp.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2019 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=IXcfai26P/X8GzjqUOtmAH/Jo83R/2UjSztaety4x290UiwGJr62Nqbed+2gcSQnQq
         dqrgQtS9ocweR9XW2Mm9pHhrHFFRMBaxYLcm1pzOCTxIROUS9hvQ0qWmtamBqxPLZnOT
         EhjWLNHhSgeW0KfvyTB5RDtd5Dx9aJd7gcu2qMZsycPbBk5FRPwlnfzs1JqQpV41O2NT
         TPWPxUu0Sy5kUJDKrSn5SMTtpXqbO/vsBlmx8w9Dg1h8usHVPrStDNgIQeda0jezkGNQ
         kPsX+LoS4FBe/97ALO78rYF45eRlRbbdHtywIrV0PhhVjh1e7t5mswweENmRPEKXbsYl
         gxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=CLamjgwUvPF07EuGCPTRtLYOx/H/kUX3rLPj55NMpnpHlTAOoox1OexebFBXf+DV47
         qMjJuUimpNnCUxBCowidXMwvyskZdCAmClHykyc1UtGnDm41wOkrCCpSMFtazxV/00+6
         I9XW0dnxY/Ma2s2hErieMjmfts2mLo3U2sPuYc2UNN9NiilNYB5nwS/gJVNDgpIrsjCF
         i3qttvTxyYKVHNCjPXxoYAzD/5NBbb+HuZP+wZYetrR9Lrg5L22p0bbjiksqDP0URAVi
         MTGgUWPns/sczHa1vBSOhGflKYqRSXdizXQRFBQbi7PFMp4W4uH5Nro4wNYLy6SpVbRt
         cYqA==
X-Gm-Message-State: APjAAAX5foolqktTogon5RZVeL0xCiZSpw0FQ0QgazkHVNvctuMbLxbS
        9/hHN9sFVS6oeozeKeK2Ygs=
X-Google-Smtp-Source: APXvYqy4lnuT+Nq4f5lxPk3nmqptozGkTW1Nn0qcFMewuAbFZKOxXjof5Tv5YsVkUmYJ47dOKqH08g==
X-Received: by 2002:a17:90a:376f:: with SMTP id u102mr16333110pjb.5.1564976665920;
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:61e6:1197:7c18:827e? ([2605:e000:100e:83a1:61e6:1197:7c18:827e])
        by smtp.gmail.com with ESMTPSA id t8sm13977229pji.24.2019.08.04.20.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
To:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
References: <20190805023206.8831-1-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0b9303-fce0-e7a8-a27d-af8e3903f097@kernel.dk>
Date:   Sun, 4 Aug 2019 20:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805023206.8831-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/4/19 7:32 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").

Applied for 5.4, thanks.

-- 
Jens Axboe

