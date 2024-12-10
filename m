Return-Path: <linux-fsdevel+bounces-36898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708D9EAAEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65E62820ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F72309BF;
	Tue, 10 Dec 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf4YECzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81A22616F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820351; cv=none; b=Ikzo00pmxuSk1SgNBNnraHsvjxD2HvLcoVk08J/tMPfAnffEXo+jufk6QKKDtSXuKLBFZVeXWMUnpt4vPwbddQsDByVNc0DX+/OMcJofOTwbDA/g1mbuUAnZjUSVrIgFGch0++wowd8JNfFt5yxFMVZpuagenF9ls2UB2e+4AfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820351; c=relaxed/simple;
	bh=WIWAsIkTD/ygTaEqJZlgomNhVL+0e/j6V2MWkNKDLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fG4k24TwkYYsU1DfQlY4lXKduOjY2OtmhS4oITuU1ZAY7NFJtVZ+eUZrpLdJzpWaVp/Lv7HgXXUFXAn21Hxt0MIsk2aEoMUd7a/jddgz6oRN1xruOVKMApRbPPrTrgkcj2xA8Jq7XE5+WEHAa5X151DUlzU6WHeWc+x0HDRToJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bf4YECzl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e398d28cso21209515e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733820347; x=1734425147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jblJqgnONYB3Ttb04kcM1REB0r64XNYjHV8iVLuGuGg=;
        b=bf4YECzlvCJBBvcz4bkEyZ4gxTe01o6uC3yBlu2RnA3G8huebiT4V6qTP3t0OIPQ+S
         voTQCa9l8oj5y6pHJLC7MVBza0hxCafznlB12ZLUEs9ZVPPrKyubYuRzS3K5gAU46M2t
         fDhjnfH9m2acYtGKgPqXV6SIfYU600lMxXTJ8UYwu47RQbd439sHfzn2kZS+w3K4iaeZ
         t1ePVBOD2utvFaUTPB5OtPgkJr8lMCAAWJe5afrflzUKJ9TQWPAhtBQRStoDCc8Kf76R
         e5tdNHM0Sy39JJ52IVXp5oyFKuuL9n8Yn6kryOzZctvyHT4xZMYeiBigeH2ZTJSjWWQa
         BHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820347; x=1734425147;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jblJqgnONYB3Ttb04kcM1REB0r64XNYjHV8iVLuGuGg=;
        b=C2mJI1HK0h4yQ++/CL9dseZL5p0OAXCrDQah81Jr4iRnYUQVpr4cq1uZr75uRX9W9f
         iZaeDox8H3As3dwK815hcqFI1zYUqUYWYmyPthhjCPotqEznQXzHzUyoYhGS7BhUdUkg
         PJr+cjBCQ7b5a0DjVoszIPFQe3jL9aWqeDXGgicnkSJmA0P4oOYermCDPRQh0dlrZVSm
         lW4Vi5H26hzEvU4ohou2NceUX+ZUrmLtG7FjMl22i3QlGkzUHZrjYDkT8HDrG6xRY0/Z
         /mLGNZhV5C0BAQ4qWNapJptEWuJOziCwwLIzliLSn9M1FW4XIsxSjBOcwRT4U25yn+8L
         cNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtjnJPnUU4VitcbWSwkdi455871bgKFgukSCcOy+GhfsoseJKhHarphQdirTRX47Y6JjFnPeggZXSfFDOG@vger.kernel.org
X-Gm-Message-State: AOJu0YyusLKskQ4XEmVTkcn29UWOAWEZcl3gKQITvXeXOPgi03HLIPFx
	Ry9bsAJ315esynDN1Y22caU4IDxTkBlKhZDUCYLauyS/HA+66RkL9f7cii4aQIg=
X-Gm-Gg: ASbGncsH1OgQ3xfLtGpGEWQGCr5xuYuApfPNQgGHCrl9EanMDc2NwKZVsvsnCSMz5BG
	ZTX79QZsYJ2XQUH5QDiSOeuA5fb5Z47lOZ0fjgeXEDKsThramKpuAaAi6NorthWKRFJmhx1oA8P
	Z6vOPGVlyO+L3L9mYX86lEKuKyhLfBlgL+5ZPHagCxuLjRjPse+WXRiKn7g1Su1nBAuwFm6ntBK
	yAXgpNvi5bqZHLpeTBhsQa3HYQxOcGmAI+azsi23tTxWZA4+Zrl3RsUimY=
X-Google-Smtp-Source: AGHT+IHBg7FH0RfI63+Vg3g5RF/j5aX39c5DAnNY2YHqX7RE5+k+C41N38XjDYzZeGnDTOmqptoH7w==
X-Received: by 2002:a05:600c:4e8a:b0:434:ffd7:6fca with SMTP id 5b1f17b1804b1-434fff36e7cmr31129635e9.2.1733820346746;
        Tue, 10 Dec 2024 00:45:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm224504225e9.3.2024.12.10.00.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:45:46 -0800 (PST)
Date: Tue, 10 Dec 2024 11:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, sagi@grimberg.me,
	asml.silence@gmail.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <8d69680a-a958-4e9d-a1ba-097489fe98d1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-12-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/fs-add-write-stream-information-to-statx/20241207-063826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241206221801.790690-12-kbusch%40meta.com
patch subject: [PATCHv12 11/12] nvme: register fdp parameters with the block layer
config: csky-randconfig-r072-20241209 (https://download.01.org/0day-ci/archive/20241210/202412100319.Y5vv98P8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412100319.Y5vv98P8-lkp@intel.com/

New smatch warnings:
drivers/nvme/host/core.c:2187 nvme_check_fdp() error: uninitialized symbol 'i'.
drivers/nvme/host/core.c:2232 nvme_query_fdp_info() warn: missing error code 'ret'

vim +/i +2187 drivers/nvme/host/core.c

04ca0849938146 Keith Busch   2024-12-06  2154  static int nvme_check_fdp(struct nvme_ns *ns, struct nvme_ns_info *info,
04ca0849938146 Keith Busch   2024-12-06  2155  			  u8 fdp_idx)
04ca0849938146 Keith Busch   2024-12-06  2156  {
04ca0849938146 Keith Busch   2024-12-06  2157  	struct nvme_fdp_config_log hdr, *h;
04ca0849938146 Keith Busch   2024-12-06  2158  	struct nvme_fdp_config_desc *desc;
04ca0849938146 Keith Busch   2024-12-06  2159  	size_t size = sizeof(hdr);
04ca0849938146 Keith Busch   2024-12-06  2160  	int i, n, ret;
04ca0849938146 Keith Busch   2024-12-06  2161  	void *log;
04ca0849938146 Keith Busch   2024-12-06  2162  
04ca0849938146 Keith Busch   2024-12-06  2163  	info->runs = 0;
04ca0849938146 Keith Busch   2024-12-06  2164  	ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
04ca0849938146 Keith Busch   2024-12-06  2165  			   (void *)&hdr, size, 0, info->endgid);
04ca0849938146 Keith Busch   2024-12-06  2166  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2167  		return ret;
04ca0849938146 Keith Busch   2024-12-06  2168  
04ca0849938146 Keith Busch   2024-12-06  2169  	size = le32_to_cpu(hdr.sze);
04ca0849938146 Keith Busch   2024-12-06  2170  	h = kzalloc(size, GFP_KERNEL);
04ca0849938146 Keith Busch   2024-12-06  2171  	if (!h)
04ca0849938146 Keith Busch   2024-12-06  2172  		return 0;
04ca0849938146 Keith Busch   2024-12-06  2173  
04ca0849938146 Keith Busch   2024-12-06  2174  	ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
04ca0849938146 Keith Busch   2024-12-06  2175  			   h, size, 0, info->endgid);
04ca0849938146 Keith Busch   2024-12-06  2176  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2177  		goto out;
04ca0849938146 Keith Busch   2024-12-06  2178  
04ca0849938146 Keith Busch   2024-12-06  2179  	n = le16_to_cpu(h->numfdpc) + 1;
04ca0849938146 Keith Busch   2024-12-06  2180  	if (fdp_idx > n)
04ca0849938146 Keith Busch   2024-12-06  2181  		goto out;
04ca0849938146 Keith Busch   2024-12-06  2182  
04ca0849938146 Keith Busch   2024-12-06  2183  	log = h + 1;
04ca0849938146 Keith Busch   2024-12-06  2184  	do {
04ca0849938146 Keith Busch   2024-12-06  2185  		desc = log;
04ca0849938146 Keith Busch   2024-12-06  2186  		log += le16_to_cpu(desc->dsze);
04ca0849938146 Keith Busch   2024-12-06 @2187  	} while (i++ < fdp_idx);
                                                         ^
i needs to be initialized to zero at the start.

04ca0849938146 Keith Busch   2024-12-06  2188  
04ca0849938146 Keith Busch   2024-12-06  2189  	info->runs = le64_to_cpu(desc->runs);
04ca0849938146 Keith Busch   2024-12-06  2190  out:
04ca0849938146 Keith Busch   2024-12-06  2191  	kfree(h);
04ca0849938146 Keith Busch   2024-12-06  2192  	return ret;
04ca0849938146 Keith Busch   2024-12-06  2193  }
04ca0849938146 Keith Busch   2024-12-06  2194  
04ca0849938146 Keith Busch   2024-12-06  2195  static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
04ca0849938146 Keith Busch   2024-12-06  2196  {
04ca0849938146 Keith Busch   2024-12-06  2197  	struct nvme_ns_head *head = ns->head;
04ca0849938146 Keith Busch   2024-12-06  2198  	struct nvme_fdp_ruh_status *ruhs;
04ca0849938146 Keith Busch   2024-12-06  2199  	struct nvme_fdp_config fdp;
04ca0849938146 Keith Busch   2024-12-06  2200  	struct nvme_command c = {};
04ca0849938146 Keith Busch   2024-12-06  2201  	int size, ret;
04ca0849938146 Keith Busch   2024-12-06  2202  
04ca0849938146 Keith Busch   2024-12-06  2203  	ret = nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
04ca0849938146 Keith Busch   2024-12-06  2204  				&fdp);
04ca0849938146 Keith Busch   2024-12-06  2205  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2206  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2207  
04ca0849938146 Keith Busch   2024-12-06  2208  	if (!(fdp.flags & FDPCFG_FDPE))
04ca0849938146 Keith Busch   2024-12-06  2209  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2210  
04ca0849938146 Keith Busch   2024-12-06  2211  	ret = nvme_check_fdp(ns, info, fdp.fdpcidx);
04ca0849938146 Keith Busch   2024-12-06  2212  	if (ret || !info->runs)
04ca0849938146 Keith Busch   2024-12-06  2213  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2214  
04ca0849938146 Keith Busch   2024-12-06  2215  	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
04ca0849938146 Keith Busch   2024-12-06  2216  	ruhs = kzalloc(size, GFP_KERNEL);
04ca0849938146 Keith Busch   2024-12-06  2217  	if (!ruhs) {
04ca0849938146 Keith Busch   2024-12-06  2218  		ret = -ENOMEM;
04ca0849938146 Keith Busch   2024-12-06  2219  		goto err;
04ca0849938146 Keith Busch   2024-12-06  2220  	}
04ca0849938146 Keith Busch   2024-12-06  2221  
04ca0849938146 Keith Busch   2024-12-06  2222  	c.imr.opcode = nvme_cmd_io_mgmt_recv;
04ca0849938146 Keith Busch   2024-12-06  2223  	c.imr.nsid = cpu_to_le32(head->ns_id);
04ca0849938146 Keith Busch   2024-12-06  2224  	c.imr.mo = NVME_IO_MGMT_RECV_MO_RUHS;
04ca0849938146 Keith Busch   2024-12-06  2225  	c.imr.numd = cpu_to_le32(nvme_bytes_to_numd(size));
04ca0849938146 Keith Busch   2024-12-06  2226  	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
04ca0849938146 Keith Busch   2024-12-06  2227  	if (ret)
04ca0849938146 Keith Busch   2024-12-06  2228  		goto free;
04ca0849938146 Keith Busch   2024-12-06  2229  
04ca0849938146 Keith Busch   2024-12-06  2230  	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
04ca0849938146 Keith Busch   2024-12-06  2231  	if (!head->nr_plids)
04ca0849938146 Keith Busch   2024-12-06 @2232  		goto free;

ret = -EINVAL?

04ca0849938146 Keith Busch   2024-12-06  2233  
04ca0849938146 Keith Busch   2024-12-06  2234  	kfree(ruhs);
04ca0849938146 Keith Busch   2024-12-06  2235  	return 0;
04ca0849938146 Keith Busch   2024-12-06  2236  
04ca0849938146 Keith Busch   2024-12-06  2237  free:
04ca0849938146 Keith Busch   2024-12-06  2238  	kfree(ruhs);
04ca0849938146 Keith Busch   2024-12-06  2239  err:
04ca0849938146 Keith Busch   2024-12-06  2240  	head->nr_plids = 0;
04ca0849938146 Keith Busch   2024-12-06  2241  	info->runs = 0;
04ca0849938146 Keith Busch   2024-12-06  2242  	return ret;
04ca0849938146 Keith Busch   2024-12-06  2243  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


