Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4639BE02C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbfJVLVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 07:21:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34911 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfJVLVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:21:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id k2so1879924edx.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hkPjYtxu0G68TNOL7v3J1p13GtJ9bbjz9PgUJHvGUO4=;
        b=NY/Vg+KYkfRz80jxUYpA7t8Pxm2pGBYJ+h3r9wYIIS9WTnYFDXAjUzhM7N78ek5F9C
         r+L+12vJiHo+PxQ82cmaBgOJ/yw90xHGpO3E/d1R8cdSmLS6Yahs+PXzpAuGzRBVsxK0
         vVyBefcjZfG2X6pLWNK7Nwn0zpyX2pIy/kqKQ30ad7Q13i7lmWZysLFyuUJr8CYGtBZZ
         pD6hzp4Zj64Usi8SQFo0A0wCk2GQMYBUBurH4YTO2khbUC78TgpcrMLnyeIturUEx/bF
         pMEbQwbm9AJOtx6+JoIjFQCQYvqOi5Xft8n5yxfj7F7VjRbYykLjhXNarDhLy1Zj//i/
         MQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hkPjYtxu0G68TNOL7v3J1p13GtJ9bbjz9PgUJHvGUO4=;
        b=PDlFJqHEMtoii5Uh6Np6sq1zdfj/qPzjsqK8ky9inOHxhOOyQBwBGdFDMFiaqsoyaN
         vjeIxitrgng4BNWpBkD2GetK+RT3H8UepQPvGmJ4ZqoJoGaNwGGOSLrqhCC7kF5ZmV5H
         W0xWiiNRZ+LshokTvebJI4VehvGsDJc5hpzyYS2aOYlTzKxk8U116GN2fsz72fg/bHFx
         u1fSI2zLit9ffSDMZTTI3BxRwZsMTd8eg/SJmHcxBV492DQ6Xoia964CSgep49eJkHe6
         IkBoiw8UiMwg616JdNG6ef0knLC/Zf0lbRbV4GNfUfl/IWCGDO+W4jTiAmijtWpA/adR
         4x4g==
X-Gm-Message-State: APjAAAW5CosVGPCImZYB/p3dz+c9k0DWHr6qrm4wy4HS9Voq0CnFIUTe
        xonp+n6OH1G4UZq15U3A5Lj6VjB88wE=
X-Google-Smtp-Source: APXvYqySKn4thuU3f7K7aDJqekurENi/VR+yBa2dMuzwxWcadqexy5iRGP32nwx1Eh17ArpcLJiB9w==
X-Received: by 2002:a17:906:bfcb:: with SMTP id us11mr26657460ejb.299.1571743279644;
        Tue, 22 Oct 2019 04:21:19 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id gl4sm114537ejb.6.2019.10.22.04.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 04:21:18 -0700 (PDT)
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
Date:   Tue, 22 Oct 2019 14:21:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191020155935.12297-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/10/2019 18:59, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> At LSF/MM'19 [1] [2] we discussed applications that overestimate memory
> consumption due to their inability to detect whether the kernel will
> instantiate page cache for a file, and cases where a global dax enable via a
> mount option is too coarse.
> 
> The following patch series enables selecting the use of DAX on individual files
> and/or directories on xfs, and lays some groundwork to do so in ext4.  In this
> scheme the dax mount option can be omitted to allow the per-file property to
> take effect.
> 
> The insight at LSF/MM was to separate the per-mount or per-file "physical"
> capability switch from an "effective" attribute for the file.
> 
> At LSF/MM we discussed the difficulties of switching the mode of a file with
> active mappings / page cache. Rather than solve those races the decision was to
> just limit mode flips to 0-length files.
> 

What I understand above is that only "writers" before writing any bytes may
turn the flag on, which then persists. But as a very long time user of DAX, usually
it is the writers that are least interesting. With lots of DAX technologies and
emulations the write is slower and needs slow "flushing".

The more interesting and performance gains comes from DAX READs actually.
specially cross the VM guest. (IE. All VMs share host memory or pmem)

This fixture as I understand it, that I need to know before I write if I will
want DAX or not and then the write is DAX as well as reads after that, looks
not very interesting for me as a user.

Just my $0.17
Boaz

> Finally, the physical DAX flag inheritance is maintained from previous work on 
> XFS but should be added for other file systems for consistence.
> 
> 
> [1] https://lwn.net/Articles/787973/
> [2] https://lwn.net/Articles/787233/
> 
> To: linux-kernel@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> Ira Weiny (5):
>   fs/stat: Define DAX statx attribute
>   fs/xfs: Isolate the physical DAX flag from effective
>   fs/xfs: Separate functionality of xfs_inode_supports_dax()
>   fs/xfs: Clean up DAX support check
>   fs/xfs: Allow toggle of physical DAX flag
> 
>  fs/stat.c                 |  3 +++
>  fs/xfs/xfs_ioctl.c        | 32 ++++++++++++++------------------
>  fs/xfs/xfs_iops.c         | 36 ++++++++++++++++++++++++++++++------
>  fs/xfs/xfs_iops.h         |  2 ++
>  include/uapi/linux/stat.h |  1 +
>  5 files changed, 50 insertions(+), 24 deletions(-)
> 

