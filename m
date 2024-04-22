Return-Path: <linux-fsdevel+bounces-17419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5198AD3D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1B1F21941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E81C154BF8;
	Mon, 22 Apr 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGaLkm9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808315443D;
	Mon, 22 Apr 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810203; cv=none; b=MTt3s2kMDfkBikh2TL2cQ9Qc3U4VuJO1EeT6y4Ekmza1deVr12mZv1VaHVuNzK3M4dR3v15crArXQEWixCJWEQbRZ7yUEwHMsrxaSe3ifPaFVr9b0gMdx1FSl4t5gsakeLrlBSLGz/Vwm0swGdLCr+wmvQ20T1rv7AkOzHPsYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810203; c=relaxed/simple;
	bh=5hx0hqmTvtMnwuIiUwzkB2NqB8TtTkY1m/tzpLOBOa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTv+ocprymdW8D+3IJ1pEAvQ8s5WN/eHTNUBWKA/AxTIcHefVHJfQL0ewfOywJASekO0HGC/SBgcA5RtQCIk1RPQxIs/o2cUbfUS/pfY0vbV1wm5PfnqfToGLf/srRvhl5lzR/TLk12libP0DzfKb+NSqLZ3sP6GO6QYaQtM/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGaLkm9Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4266673bbso42815735ad.2;
        Mon, 22 Apr 2024 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713810202; x=1714415002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUsfrPuknVn2eEWdEAnXH6GuTxJPhPcdp068aUQPL6g=;
        b=UGaLkm9Z2re0epmt6klamknfMFFWzuVc7mqXBipyePZsDXdE2wORmYOtcX3rX1k4nN
         XIckwVBis5zTyroZ0q4Ui4Utdj/7qDFqZhGbFJZQ1ThBVAxBdIWNjE9ajSSr981DyK6o
         RIUlOIZ2KdAGnnVgwUnSj2L6F8ssiA4MycVEnex2kKdVOpv/VDxR5KyQAUx+YfXc3Gag
         v7MkEZ4QnE5/fHk1uzlqWPe3rEeNF63rjA0SAhUXPIaALqh5cLB+1M46AWN+g/F5pk6E
         YW2/TQ6XGoSAXBpkrZJO4k3FHNvRxHkliSLLdOxJdRVyQ3n9nhegrZ1/Ro8EPhBPsZd5
         5CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810202; x=1714415002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUsfrPuknVn2eEWdEAnXH6GuTxJPhPcdp068aUQPL6g=;
        b=SoeCQLRmVFwHBB35/JcvDxGxXfb7bNAQ7GlhjIC7FCZ3cEqo1AyU9ctvHGPw/g95/k
         OtX1mTFHFil9n2I+kR7o3N1twTEqrDc4d1tmesiGv37SlcwgY5vgPEUZTD6Yr2uLH+fe
         bVMKamrloeYRNWaHhhgvr7ij2sq/RwETcNJJnBYN3OigM7VMgh6oyRNq8c5mNyzCF27e
         sJ9QdIEKUVpxx7Kt7UeNgOFctRovO3mfPMDP++1TleJ8ZpcV+VwJzqkeLEjRycQBX9PU
         Hy+FiWbEqklYVtXzzwSw0IrEesZv9ornw6lmvK29C30/769XcG+JPr6Zahw9+KEp7vYP
         /91g==
X-Forwarded-Encrypted: i=1; AJvYcCWcBXaAgnVYTL3k89E+ISbB3qiv+nHc/xVBa5xPyfSvB7K9CU4CEjGidrY4g8zZwf95SFhcDSjwCfR6zSHgPVw+FpS2TfHIb649j8WIgquXsrdyPPJ9Z9guOT5UJ+UifURuPK7/zi8+597sFQ==
X-Gm-Message-State: AOJu0YwJr8LfNyIkmC8MEovALT2VbEB2YQ6ET7+VZraKZfcALrPlqIhb
	rHot1495hwF0LARSWhgVMuRuH1ow/QlgKxwB7S2M/eoGVO1geQjvGXm8n98q
X-Google-Smtp-Source: AGHT+IGl2na+Kyu0mq52tGR00SH6ZD7tOAk3YfMFtBzHcVw5HMV3aXGaOENqOKZ/Wql9wnBHRG0HKQ==
X-Received: by 2002:a17:902:7489:b0:1e7:ad7a:6a81 with SMTP id h9-20020a170902748900b001e7ad7a6a81mr10287853pll.49.1713810201435;
        Mon, 22 Apr 2024 11:23:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902ed8d00b001e4464902bcsm8432872plj.60.2024.04.22.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:23:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 08:23:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <ZiarF2wxWecJ1vTE@slm.duckdns.org>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
 <20240422164808.13627-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164808.13627-2-shikemeng@huaweicloud.com>

On Tue, Apr 23, 2024 at 12:48:05AM +0800, Kemeng Shi wrote:
> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
> of whole bdi, but only writeback information of bdi in root cgroup is
> collected. So writeback information in non-root cgroup are missing now.
> To be more specific, considering following case:
> 
> /* create writeback cgroup */
> cd /sys/fs/cgroup
> echo "+memory +io" > cgroup.subtree_control
> mkdir group1
> cd group1
> echo $$ > cgroup.procs
> /* do writeback in cgroup */
> fio -name test -filename=/dev/vdb ...
> /* get writeback info of bdi */
> cat /sys/kernel/debug/bdi/xxx/stats
> The cat result unexpectedly implies that there is no writeback on target
> bdi.
> 
> Fix this by collecting stats of all wb in bdi instead of only wb in
> root cgroup.
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* all writeback info of bdi is successfully collected */
> cat stats
> BdiWriteback:             2912 kB
> BdiReclaimable:        1598464 kB
> BdiDirtyThresh:      167479028 kB
> DirtyThresh:         195038532 kB
> BackgroundThresh:     32466728 kB
> BdiDirtied:           19141696 kB
> BdiWritten:           17543456 kB
> BdiWriteBandwidth:     1136172 kBps
> b_dirty:                     2
> b_io:                        0
> b_more_io:                   1
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

