Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F12C2F87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404137AbgKXSEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 13:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKXSEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:04:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB08C0613D6;
        Tue, 24 Nov 2020 10:04:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id l2so21723413qkf.0;
        Tue, 24 Nov 2020 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qZ2mbF42a4EoCPjpueBEzfe9XOwF2IptTReGgUwObs=;
        b=is4ScJMtRgB8A67gco8/ShkniDzY10n7rMewX714/9E8uwhLChpIiLuhS9NYdAwKZO
         wwPFFE1umeJEQtu7KDxbrmdClPTpQcYjr1RpDpjnuZBK1iq0PQfGRfm19X+XI49NQayK
         8lAFgH0g1BclA/vf2p2mEb1VckBHMRHQuZY2MAZGNuGYbRuKC1k7RL8V45KondL8dAgu
         pkggwpY/K/3AGEFSp3YuAHk/ID2wYfhEWzIb5TQJq39NiNddKNAmZTO9FhKaayKgBddH
         Z4wiCaTnVN8dlV2LZgcg+T7QWmffCA0edb1cuImXXMdzH67nJfiqgEY4ncID7PjQAYKh
         /ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8qZ2mbF42a4EoCPjpueBEzfe9XOwF2IptTReGgUwObs=;
        b=d6DHjdJRsXIAyhuzzQGB2cDDK00FvW9xeTKRd83jonBdF9eoKqZzxhmT6x4wf6CiKR
         KtCvmbkH+opxH/7hGXHcbsdeYeg2DiPDrxK/mJ2/ELOOtwR78z7fsy1O6Sy3xsBm4f19
         gxwjskdO8UBHzQbS6A/i7pqX3LB+yljDKK+qEarY4BbWZbH7Ru4SJSbm+L/hNMyQqd7j
         QM6tdjqb+7UHqm245XR616UxE11dC3z66CwtT7h78BqmTk8M+03AzVIwY1VUH+JuP0AG
         akNV6Kfl/lvo5ufsnRdb8H4BpScyAv6wucPcf8Ae2J9Lz0w4dQSZfxgyR7UwpK/eX/Zt
         mxfA==
X-Gm-Message-State: AOAM530RuBpKSjUPia7QYvlM6BfxKqblNzYmsMwxaag/tzut7mZRGcOx
        QcREZjSMyfF4lB3ZAzzYrlw=
X-Google-Smtp-Source: ABdhPJypHMVf10j8dqLbG3/kMc2wzxScN+9Rw3Fm44OZCed30V+ovAuzBFJQGc76NiRl6CUPNsyaww==
X-Received: by 2002:ae9:e007:: with SMTP id m7mr5836885qkk.416.1606241040110;
        Tue, 24 Nov 2020 10:04:00 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id c14sm13621716qko.29.2020.11.24.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:03:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 13:03:36 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 21/45] block: refactor blkdev_get
Message-ID: <X71K+JS+xnGs+EPF@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-22-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:27PM +0100, Christoph Hellwig wrote:
> Move more code that is only run on the outer open but not the open of
> the underlying whole device when opening a partition into blkdev_get,
> which leads to a much easier to follow structure.
> 
> This allows to simplify the disk and module refcounting so that one
> reference is held for each open, similar to what we do with normal
> file operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
