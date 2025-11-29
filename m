Return-Path: <linux-fsdevel+bounces-70242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8CC9447C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965FC3A2A6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FF286D5E;
	Sat, 29 Nov 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geawaqyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3231C701F
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435108; cv=none; b=jmoGl4T5g77hFR63Rf+Nq/gDZKl+kKmUHwFryXglH4NVtCWg6cpso2Q1lLdpWfK/1p5m69QxgeD879RCNnU5bQMh+PLhji3dDTPzu/MpATFIY+ExsB0Oda5SixHE5bzyBlkDFcyRf4u7XIxxN6XXsABss6r5zZ/vjShOBB2oTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435108; c=relaxed/simple;
	bh=/iNK4Qtd+hA3I1KKNTPu2IlUU49kyEFn0I93BpZeAb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GXWTwJcI7nfulo1jRBU1aeA5NF6v0/nMsEnmNR8vH6ic/BEmS8IFhHsklx0PCDszzju0m0mVGKkYoeczsa4ADzqhWSI7BlF1h3iBXhXxxxYB3aWzyjusSQ4NEfsH8ksoyUpR3kkrYAkVXHr58erF1ukWthi/Lnif+5IucRd0p50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=geawaqyK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso14586605e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764435105; x=1765039905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNQQ2TrZ6lIHhcgB8NrgQiNlLOxGJsp2u9drC4JaiaE=;
        b=geawaqyKyy63s3ZT5CcBdbAfzJAvrrro0374EgQ31wTkmL560Bf5rmMaZMJxhKh+7l
         gw49mymWwBOy7OK876N+IFcnsiUbbUjH+jXB0ltiaaHqhkGG1Dt3HkdNpAO/Rlgv47+q
         YdHvKLJZbyghnTA38VSDoM4cw8e0zfTxGDnShcFyJhTXxD6F8yNG2wlELDhxiDihE7u2
         5an6ipXFOeuuAusxr/uSRb1klfOFS+2D1ivB/wvg4RUSldinIxk3egdqOF0rjxyPfuYn
         WeaaFN5WwVaCbyd8V6gk7YwODSQSC7moNeEItzdth+IDuFNp8c57Ndx31SpVXychry8l
         ABuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435105; x=1765039905;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNQQ2TrZ6lIHhcgB8NrgQiNlLOxGJsp2u9drC4JaiaE=;
        b=JcNrH2onuS42NQ8uKe142ryOdpGiP42I8JH61THKU7yMN385R4Li9jVv9EkpuwjDFa
         Q3kevFGJKgq3jU+LoPCijmJb7eWpJu4L0PcyyV80zuTW1Rqq+eUBrkYGJSUWvzSdZsYO
         hFgXSmFe2qBkMVeQ4923barppa1JDv/66uvu077Q4K4+0cn+IMM2Gq4pxnEqx0rz6Bw2
         DxAXKEfbNDrRgCqKWSsm/ZMMDE22YgvLSr4HhjhtUXU876sydk2bGLDqrG1p0YYL3EjD
         q2cATBiW5aFsYxd4a1LBrRjUhnVVAfIyhiAEaf43yFSbm1+WqhKqeo4JeBr92wGc0pWN
         v27g==
X-Forwarded-Encrypted: i=1; AJvYcCWo13+pspLBrkL9A3WZEmZBrtZv1zVGbvCEu49qCqFpqIEP59UORdpSVMq4JEeQEtODUlbO1CTgK4TtRGaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgRRX6KO2mNUsTV9dxfvXJ1QGLeQUUdipxdrNXUA2x+IIl958
	WbuSlZzu29RMLUKkuEfJ8UP78vXvQN5cQsGtCwGLF4AZmqntr0+s5uVpCiIeak5ZBCgXKrqFbD6
	82oCh
X-Gm-Gg: ASbGncvM0jCb/X9DlHS6gVspEn+eIDu3p3Kv5kuog8vLqAd1RDSaut6FWfWBZ7qGvKq
	E4QgfTYwZ1UpI5xZCLty4sXqzPvtE2DjDTr0WMJu1MzQvKn/qHFY7wOyWj23tJlU607zkoWZ33c
	f5ZhkMkOP9+sCvT4qand4F4W48qRkPAJrWO7F8HifY6DHW8Mgy4nBY2k6SPTS3kXcpIpDyEUn13
	FlqAB7KMukalDb6PsabyUpcnWgzXOoGoLBrhu9irVU0kJkDiOFoh3+pSuNb5QlBUed/UTZKErHE
	SqOT8zYTIfgUVuaghHKEZ8gglQOII319YBWWc/vs1XreXs+gqf/OroPQ+lxc4iJvhp4SJMHF2Na
	N4WzKbFkDu72o/jSKT7g1ezOFyngsAoI3gz9X9wWy74exksAchIw+exetkxCuGs+h8mWSb/w4MA
	7MugZFve/AzihuSsyz4a/wwHMbbVk=
X-Google-Smtp-Source: AGHT+IFQybZ8AC4gkevKQ/6HpN9EXVOyox2BHm3ICg6x870LOSGMofLFGRpseW1XP7cGo/FDwctfxQ==
X-Received: by 2002:a05:600c:198e:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-477c1133927mr322314755e9.32.1764435104802;
        Sat, 29 Nov 2025 08:51:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4790b0c3a28sm217505665e9.9.2025.11.29.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:51:44 -0800 (PST)
Date: Sat, 29 Nov 2025 19:51:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: Re: [PATCH 3/3] ceph: add subvolume metrics collection and reporting
Message-ID: <202511290541.wFDJlRdO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127134620.2035796-4-amarkuze@redhat.com>

Hi Alex,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Markuze/ceph-handle-InodeStat-v8-versioned-field-in-reply-parsing/20251127-214928
base:   https://github.com/ceph/ceph-client.git for-linus
patch link:    https://lore.kernel.org/r/20251127134620.2035796-4-amarkuze%40redhat.com
patch subject: [PATCH 3/3] ceph: add subvolume metrics collection and reporting
config: x86_64-randconfig-r071-20251128 (https://download.01.org/0day-ci/archive/20251129/202511290541.wFDJlRdO-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511290541.wFDJlRdO-lkp@intel.com/

smatch warnings:
fs/ceph/debugfs.c:436 subvolume_metrics_show() error: we previously assumed 'mdsc' could be null (see line 399)

vim +/mdsc +436 fs/ceph/debugfs.c

d469e1da62544e7 Alex Markuze 2025-11-27  390  static int subvolume_metrics_show(struct seq_file *s, void *p)
d469e1da62544e7 Alex Markuze 2025-11-27  391  {
d469e1da62544e7 Alex Markuze 2025-11-27  392  	struct ceph_fs_client *fsc = s->private;
d469e1da62544e7 Alex Markuze 2025-11-27  393  	struct ceph_mds_client *mdsc = fsc->mdsc;
d469e1da62544e7 Alex Markuze 2025-11-27  394  	struct ceph_subvol_metric_snapshot *snapshot = NULL;
d469e1da62544e7 Alex Markuze 2025-11-27  395  	u32 nr = 0;
d469e1da62544e7 Alex Markuze 2025-11-27  396  	u64 total_sent = 0;
d469e1da62544e7 Alex Markuze 2025-11-27  397  	u32 i;
d469e1da62544e7 Alex Markuze 2025-11-27  398  
d469e1da62544e7 Alex Markuze 2025-11-27 @399  	if (mdsc) {

This assumes mdsc can be NULL

d469e1da62544e7 Alex Markuze 2025-11-27  400  		mutex_lock(&mdsc->subvol_metrics_last_mutex);
d469e1da62544e7 Alex Markuze 2025-11-27  401  		if (mdsc->subvol_metrics_last &&
d469e1da62544e7 Alex Markuze 2025-11-27  402  		    mdsc->subvol_metrics_last_nr) {
d469e1da62544e7 Alex Markuze 2025-11-27  403  			nr = mdsc->subvol_metrics_last_nr;
d469e1da62544e7 Alex Markuze 2025-11-27  404  			snapshot = kmemdup(mdsc->subvol_metrics_last,
d469e1da62544e7 Alex Markuze 2025-11-27  405  					   nr * sizeof(*snapshot),
d469e1da62544e7 Alex Markuze 2025-11-27  406  					   GFP_KERNEL);
d469e1da62544e7 Alex Markuze 2025-11-27  407  			if (!snapshot)
d469e1da62544e7 Alex Markuze 2025-11-27  408  				nr = 0;
d469e1da62544e7 Alex Markuze 2025-11-27  409  		}
d469e1da62544e7 Alex Markuze 2025-11-27  410  		total_sent = mdsc->subvol_metrics_sent;
d469e1da62544e7 Alex Markuze 2025-11-27  411  		mutex_unlock(&mdsc->subvol_metrics_last_mutex);
d469e1da62544e7 Alex Markuze 2025-11-27  412  	}
d469e1da62544e7 Alex Markuze 2025-11-27  413  
d469e1da62544e7 Alex Markuze 2025-11-27  414  	seq_puts(s, "Last sent subvolume metrics:\n");
d469e1da62544e7 Alex Markuze 2025-11-27  415  	if (!nr) {
d469e1da62544e7 Alex Markuze 2025-11-27  416  		seq_puts(s, "  (none)\n");
d469e1da62544e7 Alex Markuze 2025-11-27  417  	} else {
d469e1da62544e7 Alex Markuze 2025-11-27  418  		seq_puts(s, "  subvol_id          rd_ops    wr_ops    rd_bytes       wr_bytes       rd_lat_us      wr_lat_us\n");
d469e1da62544e7 Alex Markuze 2025-11-27  419  		for (i = 0; i < nr; i++) {
d469e1da62544e7 Alex Markuze 2025-11-27  420  			const struct ceph_subvol_metric_snapshot *e = &snapshot[i];
d469e1da62544e7 Alex Markuze 2025-11-27  421  
d469e1da62544e7 Alex Markuze 2025-11-27  422  			seq_printf(s, "  %-18llu %-9llu %-9llu %-14llu %-14llu %-14llu %-14llu\n",
d469e1da62544e7 Alex Markuze 2025-11-27  423  				   e->subvolume_id,
d469e1da62544e7 Alex Markuze 2025-11-27  424  				   e->read_ops, e->write_ops,
d469e1da62544e7 Alex Markuze 2025-11-27  425  				   e->read_bytes, e->write_bytes,
d469e1da62544e7 Alex Markuze 2025-11-27  426  				   e->read_latency_us, e->write_latency_us);
d469e1da62544e7 Alex Markuze 2025-11-27  427  		}
d469e1da62544e7 Alex Markuze 2025-11-27  428  	}
d469e1da62544e7 Alex Markuze 2025-11-27  429  	kfree(snapshot);
d469e1da62544e7 Alex Markuze 2025-11-27  430  
d469e1da62544e7 Alex Markuze 2025-11-27  431  	seq_puts(s, "\nStatistics:\n");
d469e1da62544e7 Alex Markuze 2025-11-27  432  	seq_printf(s, "  entries_sent:      %llu\n", total_sent);
d469e1da62544e7 Alex Markuze 2025-11-27  433  
d469e1da62544e7 Alex Markuze 2025-11-27  434  	mutex_lock(&mdsc->subvol_metrics_last_mutex);
                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference

d469e1da62544e7 Alex Markuze 2025-11-27  435  	seq_printf(s, "  non_zero_sends:    %llu\n",
d469e1da62544e7 Alex Markuze 2025-11-27 @436  		   mdsc->subvol_metrics_nonzero_sends);
d469e1da62544e7 Alex Markuze 2025-11-27  437  	mutex_unlock(&mdsc->subvol_metrics_last_mutex);
d469e1da62544e7 Alex Markuze 2025-11-27  438  
d469e1da62544e7 Alex Markuze 2025-11-27  439  	seq_puts(s, "\nPending (unsent) subvolume metrics:\n");
d469e1da62544e7 Alex Markuze 2025-11-27  440  	ceph_subvolume_metrics_dump(&fsc->mdsc->subvol_metrics, s);
d469e1da62544e7 Alex Markuze 2025-11-27  441  	return 0;
d469e1da62544e7 Alex Markuze 2025-11-27  442  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


