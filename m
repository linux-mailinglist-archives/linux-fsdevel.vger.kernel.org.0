Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4BE6889EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjBBWhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 17:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjBBWhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:37:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CE719B2
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 14:36:58 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s13so771065pgc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 14:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJIjI8aVILzxy49H/1WVETofEOZKWrwoil8C6yJU34M=;
        b=TS7z12waCgHNK8scuaeZcY9iXVXxztSCKLyhAdlsafxo65SclPE0GAEYUILo87Rrcm
         WSHueqBx6sskpFUv/nY1MxwBAv11gHtMgFRuVPcVCKV2HqtoToBBAZRa3hHkD8L3erBi
         CCHZlpEWnFbimb1YZP3ZW5VdQn3sTQwWC1FsqlSBvGaQh/4NIOK3Fi+30uaa4CbgLQE2
         83DTJv6xjwzKmCPaGWC5/QysOAew7mdqLnkbNkEiUVOphxLOv13nVKabMz+rk2Aw879k
         1Pr2DvDgLMx6PEbduKvi0phzSdrSeI/q8FZBWc6F4zN/oVMllamtFpqhKuwaomDWhu/4
         +mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJIjI8aVILzxy49H/1WVETofEOZKWrwoil8C6yJU34M=;
        b=iBacv8wvTMVkV8Mm0PBkUgSbuQWFiKDhTnAu/hSgSRjPo1iR6Iw6GlIbiqYHOplIlE
         SikQC0q7znReWBgmHpybdJ1wfkoPcViiU2D28Cf5RAtIpRjL/gU/RY4A9mWnQOS0T18/
         W1jSIhP+wCNRqnuxzbH7rXAN1udI2T4KSmeihWKkaCSM2i5ztdcBjN3rRr12UQkN4udL
         c5qunt+HGsjJyNBNECl9n3Vgnh8EoxDoRDl7pMZJS4oOLAThKMfltRagurkeTbNPX8BM
         Gg0OEM1QE+SOzLxd/jRAjQQT7nnDQ/7tNaijQ4jSPMnMgumvRh+DRPuDZHBMscnRCIJl
         O3rA==
X-Gm-Message-State: AO0yUKVLznoeMDkOjoVpJ3M6L2lKbd0NNK44eqH8MrCat12eDfiVS00t
        1tAd5IOwa1lpIYzcM7Yr9dcHzQ==
X-Google-Smtp-Source: AK7set99ECqA8iYUBaSdqVtiLp1DjFqCHwr0KwQWbR1FqE1Yj74VVC0a/r86LrInW3OMA//Mtn/UNA==
X-Received: by 2002:aa7:8a10:0:b0:593:a226:38ee with SMTP id m16-20020aa78a10000000b00593a22638eemr6277197pfa.25.1675377418393;
        Thu, 02 Feb 2023 14:36:58 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79ed0000000b005938bd2bfd3sm191750pfq.120.2023.02.02.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:36:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pNiCL-00Adiw-Qg; Fri, 03 Feb 2023 09:36:53 +1100
Date:   Fri, 3 Feb 2023 09:36:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <20230202223653.GF937597@dread.disaster.area>
References: <Y9qM68F+nDSYfrJ1@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qM68F+nDSYfrJ1@tpad>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:01:47PM -0300, Marcelo Tosatti wrote:
> 
> umount calls invalidate_bh_lrus which IPIs each

via invalidate_bdev(). So this is only triggered on unmount of
filesystems that use the block device mapping directly, right?

Or is the problem that userspace is polling the block device (e.g.
udisks, blkid, etc) whilst the filesystem is mounted and populating
the block device mapping with cached pages so invalidate_bdev()
always does work even when the filesystem doesn't actually use the
bdev mapping?

> CPU that has non empty per-CPU buffer_head cache:
> 
>        	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> 
> This interrupts CPUs which might be executing code sensitive
> to interferences.
> 
> To avoid the IPI, free the per-CPU caches remotely via RCU.
> Two bh_lrus structures for each CPU are allocated: one is being
> used (assigned to per-CPU bh_lru pointer), and the other is
> being freed (or idle).

Rather than adding more complexity to the legacy bufferhead code,
wouldn't it be better to switch the block device mapping to use
iomap+folios and get rid of the use of bufferheads altogether?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
