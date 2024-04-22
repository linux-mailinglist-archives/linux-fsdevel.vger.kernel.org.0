Return-Path: <linux-fsdevel+bounces-17420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887908AD406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45533282AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F0154BF9;
	Mon, 22 Apr 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km+SfYP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5961847;
	Mon, 22 Apr 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810748; cv=none; b=WxVJaLl5XGEIRytXMAqzOSBVazWxAheYbOhfyrNdJ+DwxzPgwi1FWmcJeYqyIDZirtheSS2cEdCZru4/II2aBUxTpTifVE5cqKP7zaMVK2S8JGIEA5WSx+Q6kxFw921vlBr3qJaZF6nWbz1C408iJs9GvbUdQCSpJ9bWPDv35z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810748; c=relaxed/simple;
	bh=YITGFPHK2Vms5RG6+Op3tHlOPRJK2z6nckFO/UmqtSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAv1KLQkENTZuzKJdGPWfPUskBP5qRBkmAWm1MhpNujiPGosG3oWy8CTkM3ZXS8510BsXY+I8RWyMt9a3fbaBXlMwxNejKdS7QLOwXt3y3b1lqeIZVskQAzksxIqwRRTi0GITj8BSbWdh1jD4xmWWXfrVbBmnxTBYPdttFg62DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km+SfYP1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed5109d924so4047579b3a.0;
        Mon, 22 Apr 2024 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713810746; x=1714415546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jp4tWIIZBYM3ces7VZbO7/tmznrBRVcZ3K4GAB8wt2Y=;
        b=Km+SfYP1gHzfimunvnfsh294GzmFhkxMCIhGr8N1oS3uOFxH4bvOG21PhcBQ+VHRly
         mIGIMsFs1eYr/z+ybGKHl8o3FuGXTOu63zQ5rcsRPgkt8lwUHmoWbJuW43o6v7jbYOMj
         iLEB1zi0fz4OddgJJG+fp5TOVZ5dmr7/E3Gewece2DWFz8bI5IzCOJXYf5rNt+VgdcJy
         Qw29Obe25IxuB2rSVB6nae3gmZLfCkkXxkkdHzgmVKZiPuy2Pqp07k0gcTdpEGhdPWDF
         j2QyQAlU1JLWT36I1ARRYW6Q0gdltGSCddrCqg7oLS8sIInSc4IlrnWd0TQJ86cJ9JSl
         rijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810746; x=1714415546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp4tWIIZBYM3ces7VZbO7/tmznrBRVcZ3K4GAB8wt2Y=;
        b=YSGaW2Bw+ZojiovQgx/FtLOe2eLFzg5k+2ilWysDlBcESXCmfq+CoOjRswLU8Bltlg
         gGywrXcPFt+0nRO36Pqw6n0/EowCI6dWSA2Wxv3ZOF7ASwcXxbum9QSQ/CCENqZ+N2AG
         04e2AAIacHJt7Zb0x3q5uRg44xPGr85RtVtYkEpRqptMNvVh0qWoFof9qFKp6ghqdUC1
         cwq+obZiAYEyOptNYI3VAMdd7Mtc4Yab4kBRb/Fk8ljsdCF+yIDK9pgqlC/740BwbWDj
         2TjoK2DpUbxPSpQcxj6NnC1yjPOwv1CcatVE/xRexUbYIzQx1otvf50y2y9ogkF8Dcpt
         dlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkfUMRnuV2Usf8LWwFL/FBBXMtOTvRIZHdjDcqE5JAi+AfybmcEEe+vlFt0NfMSRi++PvlfJW6VT7diAGLr+qKjbGKjeNQpJCnX3JwexJnjX87i4ZqmT+MugMtTMWJkE7GrkOYzKrMdWL0fg==
X-Gm-Message-State: AOJu0Yzd5tqiOk8l0ust3nCb+v1mD80avCAyuF+/Frh0QP2Ojy8JCc7P
	Pda3CbUucQbHk1ecQ1yHAN+TviIoy1HmmKw0jnrbGYC+CTrWcGxu
X-Google-Smtp-Source: AGHT+IGEOt+a28hbekcZo6XIaIMNWx1fqusnWq11yMO2/OJwWMObs33GeyJM/AjzIPbNeo5nFfhR7Q==
X-Received: by 2002:a05:6a00:188e:b0:6ec:ff28:df5 with SMTP id x14-20020a056a00188e00b006ecff280df5mr14077978pfh.27.1713810746140;
        Mon, 22 Apr 2024 11:32:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id gs9-20020a056a004d8900b006e694719fa0sm8419722pfb.147.2024.04.22.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:32:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 08:32:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] writeback: support retrieving per group debug
 writeback stats of bdi
Message-ID: <ZiatOJDzICT9e6pi@slm.duckdns.org>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
 <20240422164808.13627-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164808.13627-3-shikemeng@huaweicloud.com>

Hello,

On Tue, Apr 23, 2024 at 12:48:06AM +0800, Kemeng Shi wrote:
> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
> of bdi.
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* per wb writeback info of bdi is collected */
> cat /sys/kernel/debug/bdi/252:16/wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1
> WbCgIno:                 4094
> WbWriteback:            54432 kB
> WbReclaimable:         766080 kB
> WbDirtyThresh:        3094760 kB
> WbDirtied:            1656480 kB
> WbWritten:             837088 kB
> WbWriteBandwidth:      132772 kBps
> b_dirty:                    1
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> WbCgIno:                 4135
> WbWriteback:            15232 kB
> WbReclaimable:         786688 kB
> WbDirtyThresh:        2909984 kB
> WbDirtied:            1482656 kB
> WbWritten:             681408 kB
> WbWriteBandwidth:      124848 kBps
> b_dirty:                    0
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Maybe it'd be useful to delineate each wb better in the output? It's a bit
difficult to parse visually. Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

