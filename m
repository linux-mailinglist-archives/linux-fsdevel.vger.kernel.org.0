Return-Path: <linux-fsdevel+bounces-64648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658ABEFA1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07D43A920F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4602D8DA8;
	Mon, 20 Oct 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2eUKA/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3302BEC31
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944566; cv=none; b=Mh8j6YSzFvQ2bJod4Wb98HwVuQXItZAmkYtOP711aRbAdWwZVOcSL4lieIPmeD5Po+TzBXWa9vyoE+nGe3x+6ooENBl0rFLU6i8RuvrSErhjZ2fyDvlERNJGhyIHhcILJuK87dW+uNpEOtq24j6Omesbx6njAXXwB3ZGDJar914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944566; c=relaxed/simple;
	bh=yxof3URmX9rLtpmiczmpq9jXxEYmxv/5pWBYF7OQFKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e/it2XEKwH2/ScwK6Yjij5K24VP9PGzfqW8mevocvKjpQzRQwiXR1OQX/bnWLIWOhW4WytAt00LOSdP7ldMFqnzKgP0VzpEqiQLFLmV4UgJ+TABtiqv78NWcVng753o94TMfZ+H730K2zpIj4OIXCfkfkhMN2yFL71GzZVwTXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2eUKA/T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so15675385e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760944563; x=1761549363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1ej+8gtsvFOBhqZuaO9KMzSX5cvqPOefoo5CYnjI/Q=;
        b=c2eUKA/T7W6HSJN1Vh3RyzZ4jINBIwYfW5M9Ngz4a3RdSh7w8+ONf3q9SzLc87zSlY
         lyy4rAAm77TixJdJeospQDuRsYZRHlmT0eUCIzWvraNW+jo8+c795ynZezLQsjVYoEKi
         J9dZs+6ZZ43SqMGWyk5o5GqGHzUapVcNdxS3+qw90AiMDSMvdK61VHeIsQiQYPpgPN7h
         cnJKfSr7r9zcYIoVrxLaL2kWrc1p4EylBNezVcCIBek5DrAVjk+vKuvolKX8WFXZysji
         4NAWLonmDypNtYyZ322/BCi6hFEZdXMj2+fw4YnFjKkQU84R4mWrPBmyeUCc6r3roeIH
         nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944563; x=1761549363;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1ej+8gtsvFOBhqZuaO9KMzSX5cvqPOefoo5CYnjI/Q=;
        b=kKXyh/pT41mNLunIetWgk9/8k1kfLUHN8CwqQwRsiANXQ5jFfaoLyXVBwxPAwy7jhM
         521JVYfH5UvdpsrWAxTLyKXfywkjVVj8/uFwvGh+PG77jAU4pzXg7LDGH8loJ6Cs7VOT
         LVtHWGHo+QpcmhOArRN5+U/bmMMUow5Pr3eYnfqT0fnNq/6+qlHPxfCRy4jqTLaSafwl
         z6JIy4kzavB/cigrO+s9nUZnAO9gd+hnlQtv9SyrgKCGX48XDUfnGErOUnSYYqorndZM
         iihsS8+ZrcOcR+Wm5D74153AL5lMJ/mtznBT/rBOXQTpuhglU3fRza2cvJ4m1dUY6HGX
         ug8w==
X-Forwarded-Encrypted: i=1; AJvYcCWV+dsZ89SGi9lvI0LgIiddu0QQyLVWxQ4Axj3zQ/xAgh/0iAUwFk/JBGY8Fp0H5pSSo9uZ8zpYi11OEt6V@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWoPPL6dft8CH734Q9EUUSDZDglYyfwNkzb0LqkoR918mjzuX
	hOaaCLR3Rlx3c6p0zjuR4NndrovA8BxME6Aw2X6cLAvH2m/grO+9394a28ZbZcIrWQw=
X-Gm-Gg: ASbGncvUgt+W4MQBYLiovGCPebgd938Kx+0OPHrxuwDLToh+auSM9sK4SVIpmaC110j
	mQaVbQs8NdZ39wCGKpaIhyesIGE1hMJY/XWW5b19MCc14/KyBJXqOQGVOqX/UYwsb7wDKgV2Pui
	XLb/ldq+4CvFCyD0LFq+LvlUsDHqI59VbqcT5zyMnEl/ExRZTKcnNn2DcZ1EJE2NS9thdPhUIfV
	VxH5dnw9C185MugEbQJvGJkx2z5aXN22QkwV1837ESDCsJDwvigAsq0z9+KYVyfrZkCn5DAbhnB
	REDX4DoAyKf49kYzF+d7U3vAGsg2O+iFoyzeWcp65Yjbf42PloxT6TZ+mouSiWhYNxstX+vjqE5
	nRIYVFVteQIlqelcNtoYg7t/LdhzWOW8b3v3ylCPOoTflGQoh/YPI+YliNjkd52N974saROzUbb
	fZj4Ca9w==
X-Google-Smtp-Source: AGHT+IGQTm5EXLM1N/aEKkpBtHNfkR7A7sUK0vTw/Crg1lHtzbbVskltQEePc3eMuv4zrbEPcEQ0lQ==
X-Received: by 2002:a05:600c:3e07:b0:468:7a5a:1494 with SMTP id 5b1f17b1804b1-4711787350dmr69398345e9.1.1760944562808;
        Mon, 20 Oct 2025 00:16:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144c82c9sm216041635e9.14.2025.10.20.00.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:16:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:15:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, Luis Henriques <luis@igalia.com>,
	Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a
 different core
Message-ID: <202510201259.MevZAfl5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae@ddn.com>

Hi Bernd,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Bernd-Schubert/fuse-io-uring-Add-queue-length-counters/20251014-024703
base:   ec714e371f22f716a04e6ecb2a24988c92b26911
patch link:    https://lore.kernel.org/r/20251013-reduced-nr-ring-queues_3-v3-6-6d87c8aa31ae%40ddn.com
patch subject: [PATCH v3 6/6] fuse: {io-uring} Queue background requests on a different core
config: loongarch-randconfig-r072-20251019 (https://download.01.org/0day-ci/archive/20251020/202510201259.MevZAfl5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510201259.MevZAfl5-lkp@intel.com/

smatch warnings:
fs/fuse/dev_uring.c:1389 fuse_uring_get_queue() error: uninitialized symbol 'best_numa'.

vim +/best_numa +1389 fs/fuse/dev_uring.c

2482ae85881b957 Bernd Schubert 2025-10-13  1306  static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring,
2482ae85881b957 Bernd Schubert 2025-10-13  1307  						    bool background)
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1308  {
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1309  	unsigned int qid;
aca09b212467554 Bernd Schubert 2025-10-13  1310  	struct fuse_ring_queue *local_queue, *best_numa, *best_global;
aca09b212467554 Bernd Schubert 2025-10-13  1311  	int local_node;
aca09b212467554 Bernd Schubert 2025-10-13  1312  	const struct cpumask *numa_mask, *global_mask;
2482ae85881b957 Bernd Schubert 2025-10-13  1313  	int retries = 0;
2482ae85881b957 Bernd Schubert 2025-10-13  1314  	int weight = -1;
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1315  
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1316  	qid = task_cpu(current);
868e7728394dbc8 Bernd Schubert 2025-10-13  1317  	if (WARN_ONCE(qid >= ring->max_nr_queues,
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1318  		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
868e7728394dbc8 Bernd Schubert 2025-10-13  1319  		      ring->max_nr_queues))
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1320  		qid = 0;
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1321  
aca09b212467554 Bernd Schubert 2025-10-13  1322  	local_node = cpu_to_node(qid);
aca09b212467554 Bernd Schubert 2025-10-13  1323  	if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
aca09b212467554 Bernd Schubert 2025-10-13  1324  		local_node = 0;
c2c9af9a0b13261 Bernd Schubert 2025-01-20  1325  
2482ae85881b957 Bernd Schubert 2025-10-13  1326  	local_queue = READ_ONCE(ring->queues[qid]);
2482ae85881b957 Bernd Schubert 2025-10-13  1327  
2482ae85881b957 Bernd Schubert 2025-10-13  1328  retry:
2482ae85881b957 Bernd Schubert 2025-10-13  1329  	/*
2482ae85881b957 Bernd Schubert 2025-10-13  1330  	 * For background requests, try next CPU in same NUMA domain.
2482ae85881b957 Bernd Schubert 2025-10-13  1331  	 * I.e. cpu-0 creates async requests, cpu-1 io processes.
2482ae85881b957 Bernd Schubert 2025-10-13  1332  	 * Similar for foreground requests, when the local queue does not
2482ae85881b957 Bernd Schubert 2025-10-13  1333  	 * exist - still better to always wake the same cpu id.
2482ae85881b957 Bernd Schubert 2025-10-13  1334  	 */
2482ae85881b957 Bernd Schubert 2025-10-13  1335  	if (background || !local_queue) {
2482ae85881b957 Bernd Schubert 2025-10-13  1336  		numa_mask = ring->numa_registered_q_mask[local_node];
2482ae85881b957 Bernd Schubert 2025-10-13  1337  
2482ae85881b957 Bernd Schubert 2025-10-13  1338  		if (weight == -1)
2482ae85881b957 Bernd Schubert 2025-10-13  1339  			weight = cpumask_weight(numa_mask);
2482ae85881b957 Bernd Schubert 2025-10-13  1340  
2482ae85881b957 Bernd Schubert 2025-10-13  1341  		if (weight == 0)
2482ae85881b957 Bernd Schubert 2025-10-13  1342  			goto global;

best_numa not set on this path.

2482ae85881b957 Bernd Schubert 2025-10-13  1343  
2482ae85881b957 Bernd Schubert 2025-10-13  1344  		if (weight > 1) {
2482ae85881b957 Bernd Schubert 2025-10-13  1345  			int idx = (qid + 1) % weight;
2482ae85881b957 Bernd Schubert 2025-10-13  1346  
2482ae85881b957 Bernd Schubert 2025-10-13  1347  			qid = cpumask_nth(idx, numa_mask);
2482ae85881b957 Bernd Schubert 2025-10-13  1348  		} else {
2482ae85881b957 Bernd Schubert 2025-10-13  1349  			qid = cpumask_first(numa_mask);
2482ae85881b957 Bernd Schubert 2025-10-13  1350  		}
2482ae85881b957 Bernd Schubert 2025-10-13  1351  
2482ae85881b957 Bernd Schubert 2025-10-13  1352  		local_queue = READ_ONCE(ring->queues[qid]);
2482ae85881b957 Bernd Schubert 2025-10-13  1353  		if (WARN_ON_ONCE(!local_queue))
2482ae85881b957 Bernd Schubert 2025-10-13  1354  			return NULL;
2482ae85881b957 Bernd Schubert 2025-10-13  1355  	}
2482ae85881b957 Bernd Schubert 2025-10-13  1356  
2482ae85881b957 Bernd Schubert 2025-10-13  1357  	if (READ_ONCE(local_queue->nr_reqs) <= FURING_Q_NUMA_THRESHOLD)
aca09b212467554 Bernd Schubert 2025-10-13  1358  		return local_queue;
aca09b212467554 Bernd Schubert 2025-10-13  1359  
2482ae85881b957 Bernd Schubert 2025-10-13  1360  	if (retries < FURING_NEXT_QUEUE_RETRIES && weight > retries + 1) {
2482ae85881b957 Bernd Schubert 2025-10-13  1361  		retries++;
2482ae85881b957 Bernd Schubert 2025-10-13  1362  		local_queue = NULL;
2482ae85881b957 Bernd Schubert 2025-10-13  1363  		goto retry;
2482ae85881b957 Bernd Schubert 2025-10-13  1364  	}
2482ae85881b957 Bernd Schubert 2025-10-13  1365  
aca09b212467554 Bernd Schubert 2025-10-13  1366  	/* Find best NUMA-local queue */
aca09b212467554 Bernd Schubert 2025-10-13  1367  	numa_mask = ring->numa_registered_q_mask[local_node];
aca09b212467554 Bernd Schubert 2025-10-13  1368  	best_numa = fuse_uring_best_queue(numa_mask, ring);
aca09b212467554 Bernd Schubert 2025-10-13  1369  
aca09b212467554 Bernd Schubert 2025-10-13  1370  	/* If NUMA queue is under threshold, use it */
aca09b212467554 Bernd Schubert 2025-10-13  1371  	if (best_numa &&
aca09b212467554 Bernd Schubert 2025-10-13  1372  	    READ_ONCE(best_numa->nr_reqs) <= FURING_Q_NUMA_THRESHOLD)
aca09b212467554 Bernd Schubert 2025-10-13  1373  		return best_numa;
aca09b212467554 Bernd Schubert 2025-10-13  1374  
2482ae85881b957 Bernd Schubert 2025-10-13  1375  global:
aca09b212467554 Bernd Schubert 2025-10-13  1376  	/* NUMA queues above threshold, try global queues */
aca09b212467554 Bernd Schubert 2025-10-13  1377  	global_mask = ring->registered_q_mask;
aca09b212467554 Bernd Schubert 2025-10-13  1378  	best_global = fuse_uring_best_queue(global_mask, ring);
aca09b212467554 Bernd Schubert 2025-10-13  1379  
aca09b212467554 Bernd Schubert 2025-10-13  1380  	/* Might happen during tear down */
aca09b212467554 Bernd Schubert 2025-10-13  1381  	if (!best_global)
aca09b212467554 Bernd Schubert 2025-10-13  1382  		return NULL;
aca09b212467554 Bernd Schubert 2025-10-13  1383  
aca09b212467554 Bernd Schubert 2025-10-13  1384  	/* If global queue is under double threshold, use it */
aca09b212467554 Bernd Schubert 2025-10-13  1385  	if (READ_ONCE(best_global->nr_reqs) <= FURING_Q_GLOBAL_THRESHOLD)
aca09b212467554 Bernd Schubert 2025-10-13  1386  		return best_global;
aca09b212467554 Bernd Schubert 2025-10-13  1387  
aca09b212467554 Bernd Schubert 2025-10-13  1388  	/* There is no ideal queue, stay numa_local if possible */
aca09b212467554 Bernd Schubert 2025-10-13 @1389  	return best_numa ? best_numa : best_global;
                                                               ^^^^^^^^^
Uninitialized

c2c9af9a0b13261 Bernd Schubert 2025-01-20  1390  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


