Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D953D250931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHXTXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXTXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:23:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5CC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:23:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so2475892qkb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VY8icQ/PEHeeVHFUx8sscyHaZUX7ephlQwZof8ngJKI=;
        b=rI9ZjW/b7AGEc5bqkJ9ZmPOdmUnyxtTG9TJ9EJDL0aoE8MU3nnygkHNkIzRqgncbEV
         LzjcHCAHh9KPLTfpk1YPKtdnE2gYK/iSw5qAtcUBNtn+NrQ3RJ8GjJRxtrrgN4zcVXeJ
         2gz3sw3xTxlMbDmu57JSRkLAukLRXhT9+sGyTvNRZK9+oAldM5ThLMZ8RZXNltIZytdh
         bNW0guDDEqrpMVCr0j1xie78aXH7QkKqSg78M0I+bRx5zy3B6IcaBkVLZVHre87DC6bR
         WW9TKtpY1kxR87wxV8XnUo7iVmaswEmdVf+ItBzzLXt3lBcbnzRgHJvnY+6gwYR0EL2j
         frRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VY8icQ/PEHeeVHFUx8sscyHaZUX7ephlQwZof8ngJKI=;
        b=KN2X6UON0p+SDGWRXQ9skyJuSYnH+R6LX/5XXgg80nI20Y0xUp4BMHVwciZIC8yZOX
         KG7g7EyzgI+8I2PyXIIR6Fda9DQ168NDEKrXhRTQ6Ks/RUAJeYdWt1Sb2ZaTEr7FO2NH
         RBxmICVoU0ONUUdd1Dnq+5iFDRmQnnglP10Hcz8XlEGcUEYeef6XPWx6POgIF98dQsW8
         8dPwCinU9w2xEexMgvPjf8YTV7JTRGgNGUvAAaQQAJbwaRe5MP5VpxGHnJUdbz09bB0p
         2OMZh49xbtdgYFY0xXf9PllQlI0oqZWNmh/o6PA6tlCWJEviosl7jYJqjuwjZesqGHIu
         75bg==
X-Gm-Message-State: AOAM5306A8ESFys+hCRjvIdPG3w2D8V3g5khWCeow6hOCFPIg0Cknda8
        Bw78pY22m1za1eBoIMXWZQUJcQ==
X-Google-Smtp-Source: ABdhPJw2tcITtQVNYTlOFW+NJfGITi55RnDhTWDgOriQTyXSpBz+Gg+QSmQaYNgBvlS7heoQz9wzcQ==
X-Received: by 2002:a37:4e4d:: with SMTP id c74mr6012905qkb.311.1598297011691;
        Mon, 24 Aug 2020 12:23:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w17sm7206175qki.65.2020.08.24.12.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:23:31 -0700 (PDT)
Subject: Re: [PATCH v5 5/9] btrfs: add ram_bytes and offset to
 btrfs_ordered_extent
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <0a38de964b7f623b3cf25c334373cb10cab95b2d.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1b757e84-f700-e112-bb8c-d6e61bae1f6e@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:23:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0a38de964b7f623b3cf25c334373cb10cab95b2d.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, we only create ordered extents when ram_bytes == num_bytes
> and offset == 0. However, RWF_ENCODED writes may create extents which
> only refer to a subset of the full unencoded extent, so we need to plumb
> these fields through the ordered extent infrastructure and pass them
> down to insert_reserved_file_extent().
> 
> Since we're changing the btrfs_add_ordered_extent* signature, let's get
> rid of the trivial wrappers and add a kernel-doc.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
