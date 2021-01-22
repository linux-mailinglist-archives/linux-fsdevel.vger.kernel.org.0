Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E928300783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhAVPiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbhAVPiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:38:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF234C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:37:42 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z11so5465382qkj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZaF/WX9nSAPKzAOVbLoodFR1fM7SpQVDxi0yDL3P1Q=;
        b=xTiwK5cLB8g9CfwBkhlzmlF7NIFB8I8YodSP84h0Xsf0DWVdMS1wJv/kD8r/R0nSOQ
         M0ShCC7DJ+xfWzBg3WUbYj6lvrHkMZ9QNGG1slAnxOVred3oDiKk05ZCp8zuelqTAwWy
         D+xwyX1fncnK02+F5r9pC1IXnS7Yi+8ia3b8yIm28+ThtxayluSHlAC2w/f9pc2GFgyt
         bXH5YbQvsqoqkrIjKyCxLO+c7RVax5PF1pafG11FhbNOFAxn8dDuccFbjDHFSphggas5
         p5sBZNOzw+eXKyOIoVOAuSTRInvTd5ApmUmmr5bHFSOiRsa7rOfVYfjPmqEFMk0WoxXJ
         MAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZaF/WX9nSAPKzAOVbLoodFR1fM7SpQVDxi0yDL3P1Q=;
        b=o9q9OcQrx/qaPa7jTYhyrjrirhZ6fJ4xglxCeoxbjYVTWpPJIP9HQIY/PsT6Oumn94
         XUqOK1JH7Z+to870KiVMcCy3tVWTXG1rUoF4vKWcvPIVN7TT8/q6h9OdBBSfiTy36glJ
         2dz2gUhojUpmLnhH+xsDGqIx5U61Y0L7B5ItKoQDMMB6AlRR/a+whK8A4rtaQGW8DuR/
         kjUYCzJL9Cqw38vAz46PrbBZscXV5/AteyoSwhyHTaLThcfdm4ziQ3q7qzchhmzMgYo/
         oDPkcJqfnzbTYaEQ7G7XJ38BAb9zcDy9rpMZUIC2MNz+uqZhEkbYzk0SlAuEjJlgrirJ
         3dbA==
X-Gm-Message-State: AOAM532YodBLH125Z45ZNiNTOof80OtvMU7dlTMVipZt8T+jOfHhcUw2
        W6JOv4VMjDyH3X8c0xW9zcGTgg==
X-Google-Smtp-Source: ABdhPJy8LMdIB37aaCk8sjZFOA7IxON4EhjTnI6lp+M//3RUIk8qELWOFe9QkWZTOAg3+y+rkSZE0Q==
X-Received: by 2002:a05:620a:10a8:: with SMTP id h8mr5209486qkk.315.1611329862135;
        Fri, 22 Jan 2021 07:37:42 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y13sm7129219qkb.17.2021.01.22.07.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:37:41 -0800 (PST)
Subject: Re: [PATCH v13 41/42] btrfs: serialize log transaction on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <dd4d4c4d8678b11c7b7b7529fb9a10c66a92c6f5.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e52edb8a-4baa-d219-1b19-cc51cdd593ea@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:37:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dd4d4c4d8678b11c7b7b7529fb9a10c66a92c6f5.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> This is the 2/3 patch to enable tree-log on ZONED mode.
> 
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at the
> time of log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same mixed allocation problem.
> 
> This patch serializes log transactions by waiting for a committing
> transaction when someone tries to start a new transaction, to avoid the
> mixed allocation problem. We must also wait for running log transactions
> from another subvolume, but there is no easy way to detect which subvolume
> root is running a log transaction. So, this patch forbids starting a new
> log transaction when other subvolumes already allocated the global log root
> tree.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
