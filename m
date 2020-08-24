Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B0E25091B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHXTSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHXTSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:18:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED620C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:18:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so8574319qkb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VuHHI9Tw9mAAiRDaK3VvshAHX4r1aOpIAAOE1WJC9R0=;
        b=BoEZVbmuQ1KP+/6OxSILaYsnSyNhPayw58okzTJm6290ubjt+zqCBwaCdRR5AXLv7k
         z2bbQ0jMXQHoUyaoJW492MH8QA0qIIBjBBXfjgRJG0P2eJhXVxWZkUmOPWcr31HMyVOG
         yw64emvtuzMx3SiZ8NHVAEUbQnqxCQSlCebyBOcEIMl/1hd6L2UxkFmbre9MnjwtFVaZ
         kj437sfzGwpwHu0aXp0BSScnEfvtAc/q+pJvYOwXhPCZJaFKHzCEjqhxuVomJLYHwZOa
         XBVGaQd5og3Yef8mEl1b+YqbyeQqn8grjQdOZwaOJglCbk1IcLXWkkQqRt38U0dlkYhS
         B9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VuHHI9Tw9mAAiRDaK3VvshAHX4r1aOpIAAOE1WJC9R0=;
        b=UbKTGhZ3ttCqwQtGPjsIRkP75yS/TEqgLYMLJjmgQjvz9SNbKkWhkqhBzygZfhHCzx
         69pcDPyKRxSXEBOVfzpa5cmr6nIrIOpt6DBYwNZI+sT+fF0svZlNm4YNqxCX51HJ3rbC
         O7TC2hQGnOKNQkUSWeAnpcdYW0O/bbe6sz3i494mPwbE3PgqiTBYq6WWVIkgg/RP2aaW
         u/EAkWYf99AlNy3VeZ93Fx3S1GOEyHz2ilMI9dc9jkZW9xdYODvDAMEMTAmcneZD0GD0
         Wl/dA3nu6Oy8C7x5vTa5EwZRmdSnCHF+FMVKVF5khq/fUiiveVBlGJz3v5lgwKenyPvZ
         uXTw==
X-Gm-Message-State: AOAM531CDjiSNhzepUHcnNnZ1Srt3XmVJJEjDo0ygm849pTLMVZidp2a
        XYK0b69Q+mwf2DQqhkzKvj8Z6A==
X-Google-Smtp-Source: ABdhPJxfcQx74hqirYVQGu4dEfaeQDZ6gbW5zz0F/291gA+4QeGouMX3mE2g4PKXOhtvvr2XxcoVhA==
X-Received: by 2002:a37:6557:: with SMTP id z84mr3834375qkb.12.1598296683084;
        Mon, 24 Aug 2020 12:18:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b37sm12174214qtk.85.2020.08.24.12.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:18:01 -0700 (PDT)
Subject: Re: [PATCH v5 4/9] btrfs: don't advance offset for compressed bios in
 btrfs_csum_one_bio()
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <27758a7a731919591194696ddc651623481b9691.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <28ce3756-8325-6216-4d0f-bde0df8d6ecf@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:17:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <27758a7a731919591194696ddc651623481b9691.1597993855.git.osandov@osandov.com>
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
> btrfs_csum_one_bio() loops over each filesystem block in the bio while
> keeping a cursor of its current logical position in the file in order to
> look up the ordered extent to add the checksums to. However, this
> doesn't make much sense for compressed extents, as a sector on disk does
> not correspond to a sector of decompressed file data. It happens to work
> because 1) the compressed bio always covers one ordered extent and 2)
> the size of the bio is always less than the size of the ordered extent.
> However, the second point will not always be true for encoded writes.
> 
> Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> it can assume that the bio only covers one ordered extent. Since we're
> already changing the signature, let's get rid of the contig parameter
> and make it implied by the offset parameter, similar to the change we
> recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> nr_sectors to blockcount to make it clear that it's the number of
> filesystem blocks, not the number of 512-byte sectors.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
