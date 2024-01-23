Return-Path: <linux-fsdevel+bounces-8623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DF839A84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 21:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0861F1C2831C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A361524B;
	Tue, 23 Jan 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV4LwnHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA32109;
	Tue, 23 Jan 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042796; cv=none; b=fVBExAszXfTD8UcYyPvhFk97APE9XMqNhTwDbKKSUeYUcQ7K+GX/GLd2PwU4I6hLhXTLuJVFOKECexEKq/CqQ+BwjxSsp/DNziCq6Ju389Le9jrZMf6yBj1CzzDP3oQ7Rg69WvhJmnVrNOr5GWHGg0Oqd4OsQuN5VQtcUpWjHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042796; c=relaxed/simple;
	bh=USYoeYJUQKAUokSUeFb0sbYN2Qpzt9xeoPo2sEUmPjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgJX1px45KKJy0PiNMt0Of97+GIZo14MS/5gdQiMkfmEWWfw7ZxyTaJXLdqg8Y+0fY4wjKPX0pyNW8ozOWKoCTHgW8bb2WC1vIgm2D+0pRdFP5fBj+AmstY3k9RmIT2ISkutY7mu8pBA5vfkeXWTC8c4iv6BOWMBEDZSIvjxQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV4LwnHa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d24c9b3c8eso863208a12.1;
        Tue, 23 Jan 2024 12:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706042794; x=1706647594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1193ZUcARbQXW2VvJBKE7RwBOAanI7LZN4mhx6j3UEg=;
        b=JV4LwnHaR6M0IcSPBhdcmvlPLM5b8oetwvQSOuJXZ28CnvWfPvQi423zMxKF4Y9CGc
         7XyfOUl058PLxyjjhr4XMBehstLBBSe3ymYXuSKeKlw6MOIhuKLQN/Rv0+WvXIJ/MU7t
         k6wWJZvMUxpWBF1LpH4syQcGjyI3TJxXWAsQ5QpezOVs2sgVQSeMNSUhZN9n0pK072fP
         gEmyM9lcZmfpmFIqpQZLvzDNWQ6/L5q/wgItLJoSZLPNQQe18WBgnwhwf9a8ZjVvLKZj
         LAkT12fxuYXQLHL+vaes3BjENPaYoZeHcVxAt/rIk929tqmwwLZVLrWY5rDg147+9m8q
         Zx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042794; x=1706647594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1193ZUcARbQXW2VvJBKE7RwBOAanI7LZN4mhx6j3UEg=;
        b=wJul461xzVIJbBs+UsVHOJSQPE5WdBB8Vf/bg++nFhhrRITM3XKSnhavVWbOA7c47P
         VzjrX06yRQ5gAHOGHG3NG/k3VpF3umTC2b1lv762MUE8bYqtcAVqKqy1wmwnwk2blbBC
         bLLmDJuaixK3k0jJM6j9VBdmAKBqrKlQoJ1o+2+2trflmAY3VdRoqfXzLvTq/L1g8hN5
         CdBWzGAwcNLjtw40DTdL5jq/oWd14ExVdE5Eq3cv2Q2p2gXTQc/4pNB2T2Iy9cex8VaS
         mB6krgEFyKourzMvN223QQtv9rBor6GWnDVGq+OdfPdgIB5h2Axc/z9EFHaktzyXzt3U
         8P/Q==
X-Gm-Message-State: AOJu0Yy++1WFG66EgbD/6Wt6ZJFgj1Cw4fF5lZvP+oBpn8BmQ0Rivwv1
	1aD4mJZ06NsGoDaJtOH7eiqnyxKb799Bpksz54JX2gEXF9QHtpJt
X-Google-Smtp-Source: AGHT+IHRlB0tSZZINjSUHO0zHKwAMgzJQcJzD96eqvVlSKplexha/BylAQa/rUNq18wO1981hAOVmg==
X-Received: by 2002:a05:6a20:9f9b:b0:19b:238a:85f5 with SMTP id mm27-20020a056a209f9b00b0019b238a85f5mr3922586pzb.11.1706042794455;
        Tue, 23 Jan 2024 12:46:34 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm10569872pgc.29.2024.01.23.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:46:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 10:46:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix and cleanups to page-writeback
Message-ID: <ZbAlqdwNv_uxnKT1@slm.duckdns.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123183332.876854-1-shikemeng@huaweicloud.com>

On Wed, Jan 24, 2024 at 02:33:27AM +0800, Kemeng Shi wrote:
> This series contains some random cleanups and a fix to correct
> calculation of cgroup wb's bg_thresh. More details can be found
> respective patches. Thanks!
> 
> Kemeng Shi (5):
>   mm: enable __wb_calc_thresh to calculate dirty background threshold
>   mm: correct calculation of cgroup wb's bg_thresh in wb_over_bg_thresh
>   mm: call __wb_calc_thresh instead of wb_calc_thresh in
>     wb_over_bg_thresh
>   mm: remove redundant check in wb_min_max_ratio
>   mm: remove stale comment __folio_mark_dirty

I don't have the fifth patch in my inbox and I find the patchset difficult
to review because it's changing subtle behaviors without sufficient
justifications or concrete cases which motivated the changes. For now, I
think it'd be prudent to not apply this patchset.

Thanks.

-- 
tejun

