Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF33EB721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhHMOzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhHMOzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:55:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B03C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 07:55:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z24so8444959qtn.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ord6dLO+z3tSqMluPoWbEXl83RV8BHZzW5vBO+d0n/Q=;
        b=hgkSPbVdYXzvqli8P66Phz0CPr9SOyrnkiDQZlIalXmD+R4Tv6F4Q0mdTZ8ba/5gfw
         oW1EGDpsyyxofq3osqzZ0JTzPhDrpqZlP+vn8bYROr23Q+UBOPDDdnyWVVohWCxzq1hx
         bRkxlkTqNb8//cOL3t3dD52d/bzIZ0z4eWv3bMCJkpCRPRwOvahUZJeBavJL9uzVAzMq
         15aM0SGYrjQ3iAfBA0zor5ytYemmWvJcLG8bvIENG1Nn7zn+fQLal6SGG4TMtX6/fCSd
         vkemQr4G5bYEe8mP8fIrGiXexmOMyZ2/KfQt8ph/u2OLc36usfiyMeRhtQupbr3eGVKV
         SJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ord6dLO+z3tSqMluPoWbEXl83RV8BHZzW5vBO+d0n/Q=;
        b=ld2Ic1EilrQ/kh2hcjJob3OInPimdQD8mXPZ5FBjbjLfPL9aE1t+cfHpuw8dK2uAJg
         kUqPKPmIPbMiXu9fCulqDumJ3Iflkj0VFv4TTlrntzXbe9rCHDP44eIn9LxQHa4nQecF
         MJxdUEMLPNnVlsN4tpWEr26133xDrIz6uoMQZj2db1vdOwVfnq6P+1w85ILlJKK6k3OS
         VpI0ZmJMtRS30NGZesUHKN7A/x5ND/grAwHQ3/pybIUIP2GENXB7u6FYpGCIp7/c4wYD
         CIQsYJs0JTJtKfxpIRRiG/CI0ePzVXI+O3391dMgfhyFevEFda8F78bbzBC4rfmhGRMw
         8b3g==
X-Gm-Message-State: AOAM531G6+R/hW2gYJd5s6nkY4OLX3bwKxIzM1GQVzvjFQaQPsAT3zTT
        fxRR47EBakMs/DgRNCgkBAgxSA==
X-Google-Smtp-Source: ABdhPJzAQXuY0uNisq+xRrRLyGeEvUigyuZkaRswLSO2w1GpIjgHghfO6ezxij4RdEixPivFf9pV8Q==
X-Received: by 2002:ac8:682:: with SMTP id f2mr2289567qth.55.1628866526046;
        Fri, 13 Aug 2021 07:55:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o63sm1090299qkf.4.2021.08.13.07.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:55:25 -0700 (PDT)
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ebffa324-0d42-4227-b162-0dad19144943@toxicpanda.com>
Date:   Fri, 13 Aug 2021 10:55:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162881913686.1695.12479588032010502384@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/21 9:45 PM, NeilBrown wrote:
> 
> [[This patch is a minimal patch which addresses the current problems
>    with nfsd and btrfs, in a way which I think is most supportable, least
>    surprising, and least likely to impact any future attempts to more
>    completely fix the btrfs file-identify problem]]
> 
> BTRFS does not provide unique inode numbers across a filesystem.
> It *does* provide unique inode numbers with a subvolume and
> uses synthetic device numbers for different subvolumes to ensure
> uniqueness for device+inode.
> 
> nfsd cannot use these varying device numbers.  If nfsd were to
> synthesise different stable filesystem ids to give to the client, that
> would cause subvolumes to appear in the mount table on the client, even
> though they don't appear in the mount table on the server.  Also, NFSv3
> doesn't support changing the filesystem id without a new explicit
> mount on the client (this is partially supported in practice, but
> violates the protocol specification).
> 
> So currently, the roots of all subvolumes report the same inode number
> in the same filesystem to NFS clients and tools like 'find' notice that
> a directory has the same identity as an ancestor, and so refuse to
> enter that directory.
> 
> This patch allows btrfs (or any filesystem) to provide a 64bit number
> that can be xored with the inode number to make the number more unique.
> Rather than the client being certain to see duplicates, with this patch
> it is possible but extremely rare.
> 
> The number than btrfs provides is a swab64() version of the subvolume
> identifier.  This has most entropy in the high bits (the low bits of the
> subvolume identifer), while the inoe has most entropy in the low bits.
> The result will always be unique within a subvolume, and will almost
> always be unique across the filesystem.
> 

This is a reasonable approach to me, solves the problem without being overly 
complicated and side-steps the thornier issues around how we deal with 
subvolumes.  I'll leave it up to the other maintainers of the other fs'es to 
weigh in, but for me you can add

Acked-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
