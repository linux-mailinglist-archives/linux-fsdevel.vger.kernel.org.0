Return-Path: <linux-fsdevel+bounces-17421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B68AD408
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0B1F21BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B1154451;
	Mon, 22 Apr 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhClP7HY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1929153818;
	Mon, 22 Apr 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810776; cv=none; b=ut1iVfGmnjjXJYbFSuHpTiKIoX4V4sxkSZbALRSZ9YfIYE7zSl5ZvQKHGfjB3N3L3bUtMfnVl3spPOZ9CFtVptgANdZvN1hcQuHgA5AMUMCIKb4qi8ubJWBPgHjLuU4LzyMiZ5PRJ2ewQ1kyRg7Ho0mNdB7jhAthF7KuY1WwBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810776; c=relaxed/simple;
	bh=x8qZahFXVV50wSs7pRlcRV5dla9F3Ylkqh5keSJBLvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUaWDRRaB0yCGZ1pNsyD9hW6pZnDRJZupuIXWuJwme1FVjwdJSRO7U8TqEr2WvjYHcjHPnf8z2k8M/SiICjGJLUXeyXEt42e95Fqcid/O5LXRq+VFV/zbhAUffpgdJkhqdxaH3X9DyyeDD5KVs8ErnlMyD7IN+lhr9dt5DeoDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhClP7HY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c3aa8938so32800015ad.1;
        Mon, 22 Apr 2024 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713810774; x=1714415574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9wkXtqSmXOROEmMxxUVzLdmeR2obfJv0SfTnDCIoiY=;
        b=HhClP7HYfx03hQTpsne6LQ79Sc4V+0mciTauBi+mje8HsYRyok8WchHOHbdh5aJpcb
         8401pQTogzCJfQnZp4V0o9UhA84O+JRdUpcg0aNVVPByBcXTmhD6jQN8UvCfcVOdJaM6
         Tr6A3VVqQcWdgqm0OiGTpvxqujxHlINJwzUIQ05cy93RYTd01jJ8YK3URQj4WJNlW8O/
         k3Mb4Go9nB/d3mHcivpTUKShSNqvkvE3v39ivjD5MVmzyjeFPV74bhl05wbor0dtGW+h
         gN7p8jiDr2v04orQ2KYuG/bKJgnWDSJQOP6fBNhfPNkx4X1w9JzajtIy6P+cACb+3h5C
         wOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810774; x=1714415574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9wkXtqSmXOROEmMxxUVzLdmeR2obfJv0SfTnDCIoiY=;
        b=I1r+YnQNgceIfpxFPdw8gnwFWRw6qgM9reTvbEctIJrMrWfkMjSlhYHtgCyaa8dEJj
         p9R8Kicfwoj5GJNzc7zU55xKUEldQdKxshFP1k8FQ6GuDpQbBfJbMusMQ+vJQqUwmqMB
         EYFiSE1bgNLG7L+exgThpwij9ucdw7HGV3WGFkJy6fkJhnHQ07De7RiWSMDQRZdw3ac2
         q1CbVYo8RZu76pG10/ZHJRY5Yn3nwOv3SFXS8u+j7E+itCcivljcq6AParJNjM755PKf
         YXHnCnmXbjLI3sLn/BwRNQ22uiWukAAY1i8dwYlA7XdWDus6QK8Ix88kimMBFRDafr1s
         4aPA==
X-Forwarded-Encrypted: i=1; AJvYcCWakHXSO8A0GvpxeKjeiKAr5G+Xrh3ktRwF3Exqdl7GsX2jQ7caU7TBx779MPnZpIEW7g2GVPkrG4PE3xq3o7egh6wklwu79ukz1mmOG9zDbgd7KOIHlkKCcP2vrSS3hv4rxW0pxQurtBVLWA==
X-Gm-Message-State: AOJu0YzOEp+A86GOdSgtB6xrBhVUnS1LWF28AY6GqHf8JH/J5DrsDcgZ
	baFiR++IlvyLvjJrU8b54JqXQNveGVGib15lkYPhg2KopTqMKUiE
X-Google-Smtp-Source: AGHT+IGFmZK/ctSCbr570OD/bhCHRTFsuL7DOETxUiolJPNHam3RngTcoDxY3CAaGTvDzfWy0usKBw==
X-Received: by 2002:a17:902:f54b:b0:1e2:6198:9e53 with SMTP id h11-20020a170902f54b00b001e261989e53mr14843408plf.0.1713810773966;
        Mon, 22 Apr 2024 11:32:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id d21-20020a170903209500b001e2086fddecsm8469637plc.139.2024.04.22.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:32:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 08:32:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] writeback: add wb_monitor.py script to monitor
 writeback info on bdi
Message-ID: <ZiatVDpNb59kmT9V@slm.duckdns.org>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
 <20240422164808.13627-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164808.13627-4-shikemeng@huaweicloud.com>

On Tue, Apr 23, 2024 at 12:48:07AM +0800, Kemeng Shi wrote:
> Add wb_monitor.py script to monitor writeback information on backing dev
> which makes it easier and more convenient to observe writeback behaviors
> of running system.
> 
> The wb_monitor.py script is written based on wq_monitor.py.
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> The wb_monitor.py script output is as following:
> ./wb_monitor.py 252:16 -c
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> 
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> ...
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Suggested-by: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

