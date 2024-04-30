Return-Path: <linux-fsdevel+bounces-18305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D626B8B6B5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7291F22A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8239FEF;
	Tue, 30 Apr 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fURv/6Zr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B02C184
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461873; cv=none; b=orRDHB3/fsanEDvucdpZrSzvY3Zd7xDy0koLVDtGp1YTVLY4UYN3CSkffprvUGE72BmfVgnNQN7BDr5i6judeqhn1Gkq7C33gyImStox8QCwHp4+h+CqSHMsfo3t+wQc9oKNNaQG/T3kV7gDNkcW3jgAKZbmOeTMnIqOd025wko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461873; c=relaxed/simple;
	bh=yyZjb6uJBHtfQDi9vcRqAluwv7g2WUi3qhsCuCrRV1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eUnnTsCzWaDQoJsVpRj2noo9K0wbjFYJnzhFTIEtK6j95b9JYci8n6P4wSyHCs0zH/Cq5nvgmCsNWz60qH0IAIJtL9maRQGPGAtd6vIMfHMa9sfwSjhgVgyou2I/PR8+ipRGQSKYwz7wfYIh356njrMXhzn8HOdB2xdKfZsq8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fURv/6Zr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57255e89facso4579083a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714461870; x=1715066670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7s89Ib+yw/GmKuXOIYBvUFt2qfG5QHiPGhNhFrnzGQ=;
        b=fURv/6ZruI1ZKi8M8i0IZen5i6WOQQT5uGO/idIBENJ5vNjkbcIsT5Warv0Ym5qzgG
         Dth0/ZuQxvrmCrrtpxnX58iYhuDPbYUSmEWgnZYkg8KG4WNNbSNVGh+Rwo3HF3/z7B/i
         r55OMpEiTIl1GH0DJi8kZEKE4gLV5iCmHCvPiyy8aspAk05LgzkHHzOhGQnyfLXU6tEe
         7kWsFzgAfF0c1BvtD3ODsj6R8gWQdR6r7iWa2BI0ihw7rDgzv+z6o6a+5rcudnozwpE6
         EM8iGO6kI09513x2dIP8+L2Rixxc7oLT6gGjdMNfqbl9Zu/dQHMvLZ6qynbbvCacOHH5
         WsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461870; x=1715066670;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7s89Ib+yw/GmKuXOIYBvUFt2qfG5QHiPGhNhFrnzGQ=;
        b=ghE2Lv/l8aa2avxfLyJJhWjxFGI37/Ue7Kk6AurEeSwRDHPdXKNLmZybiitOECOw9W
         4HNwwfNjoDej1ZJy021OfQ7Tb+M4u20TNk4Nai62MAc0Bxfq2iJdXyYNh4zcIsVYdOk9
         rCFNYxUK58uHAlkuaioe7J4zIam3BAeTQ/SMIqXk8S7mB+Gk604lqtbJLg5DouOBqbhW
         VcRpke9bzbhZR/q3L9vuwv6qh2HXFCTgNKNJkXRIqZO8O8gJQmpdzsz5v4iLflYawN5E
         UiaaJnCbMPKJfwKD05SCuvv4pvNvh8hpmYqfrMCFAgzwI/GaUq7ieRxIYfWmp3C9GggO
         0LRg==
X-Forwarded-Encrypted: i=1; AJvYcCXrs8zyJwv4gomW9GOhVvd2AniqrmtfZjnQss35SH6IoXWKef0Bu5IsxQf9tnB7PBnf92P8w/TSb3vHf+LpQARv5PpIkr1jqEUJH7bQOw==
X-Gm-Message-State: AOJu0YxWHj6sHu5WXEyi83cCqF+SiQrSmOTiGtkk9FmkQBmLdVOJ7oBj
	mb9XP00AZC+4OOiD+KKlZ1RIbpDDe/Du6ptNSU3/0PCbn6tvfP+Cma/KD4F707s=
X-Google-Smtp-Source: AGHT+IEnyAcN6JEupMPAax6ZOgByVwP2oJqMT6SUvW+cb6CrU28YZX/Ub7ZnrT1/7sFjFCoZOg1jwA==
X-Received: by 2002:a05:6402:1a4d:b0:572:8aab:4420 with SMTP id bf13-20020a0564021a4d00b005728aab4420mr2380881edb.39.1714461869687;
        Tue, 30 Apr 2024 00:24:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402104c00b00571c12b388dsm13389893edu.35.2024.04.30.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:24:29 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:24:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
	willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	tj@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove
 repeated code
Message-ID: <6d3471cd-f491-4949-ba75-9fae63198b59@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-10-shikemeng@huaweicloud.com>

Hi Kemeng,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kemeng-Shi/writeback-factor-out-wb_bg_dirty_limits-to-remove-repeated-code/20240429-114903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240429034738.138609-10-shikemeng%40huaweicloud.com
patch subject: [PATCH 09/10] writeback: factor out wb_dirty_exceeded to remove repeated code
config: i386-randconfig-141-20240429 (https://download.01.org/0day-ci/archive/20240430/202404300231.bnb28iB8-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404300231.bnb28iB8-lkp@intel.com/

New smatch warnings:
mm/page-writeback.c:1903 balance_dirty_pages() error: we previously assumed 'mdtc' could be null (see line 1886)

vim +/mdtc +1903 mm/page-writeback.c

fe6c9c6e3e3e33 Jan Kara        2022-06-23  1800  static int balance_dirty_pages(struct bdi_writeback *wb,
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1801  			       unsigned long pages_dirtied, unsigned int flags)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1802  {
2bc00aef030f4f Tejun Heo       2015-05-22  1803  	struct dirty_throttle_control gdtc_stor = { GDTC_INIT(wb) };
c2aa723a609363 Tejun Heo       2015-05-22  1804  	struct dirty_throttle_control mdtc_stor = { MDTC_INIT(wb, &gdtc_stor) };
2bc00aef030f4f Tejun Heo       2015-05-22  1805  	struct dirty_throttle_control * const gdtc = &gdtc_stor;
c2aa723a609363 Tejun Heo       2015-05-22  1806  	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
c2aa723a609363 Tejun Heo       2015-05-22  1807  						     &mdtc_stor : NULL;
c2aa723a609363 Tejun Heo       2015-05-22  1808  	struct dirty_throttle_control *sdtc;
c8a7ee1b73042a Kemeng Shi      2024-04-23  1809  	unsigned long nr_dirty;
83712358ba0a14 Wu Fengguang    2011-06-11  1810  	long period;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1811  	long pause;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1812  	long max_pause;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1813  	long min_pause;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1814  	int nr_dirtied_pause;
143dfe8611a630 Wu Fengguang    2010-08-27  1815  	unsigned long task_ratelimit;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1816  	unsigned long dirty_ratelimit;
dfb8ae56783542 Tejun Heo       2015-05-22  1817  	struct backing_dev_info *bdi = wb->bdi;
5a53748568f796 Maxim Patlasov  2013-09-11  1818  	bool strictlimit = bdi->capabilities & BDI_CAP_STRICTLIMIT;
e98be2d599207c Wu Fengguang    2010-08-29  1819  	unsigned long start_time = jiffies;
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1820  	int ret = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1821  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1822  	for (;;) {
83712358ba0a14 Wu Fengguang    2011-06-11  1823  		unsigned long now = jiffies;
83712358ba0a14 Wu Fengguang    2011-06-11  1824  
c8a7ee1b73042a Kemeng Shi      2024-04-23  1825  		nr_dirty = global_node_page_state(NR_FILE_DIRTY);
5fce25a9df4865 Peter Zijlstra  2007-11-14  1826  
204c26b42a22b8 Kemeng Shi      2024-04-29  1827  		balance_domain_limits(gdtc, strictlimit);
204c26b42a22b8 Kemeng Shi      2024-04-29  1828  		if (mdtc)
c2aa723a609363 Tejun Heo       2015-05-22  1829  			/*
c2aa723a609363 Tejun Heo       2015-05-22  1830  			 * If @wb belongs to !root memcg, repeat the same
c2aa723a609363 Tejun Heo       2015-05-22  1831  			 * basic calculations for the memcg domain.
c2aa723a609363 Tejun Heo       2015-05-22  1832  			 */
204c26b42a22b8 Kemeng Shi      2024-04-29  1833  			balance_domain_limits(mdtc, strictlimit);
5a53748568f796 Maxim Patlasov  2013-09-11  1834  
ea6813be07dcdc Jan Kara        2022-06-23  1835  		/*
ea6813be07dcdc Jan Kara        2022-06-23  1836  		 * In laptop mode, we wait until hitting the higher threshold
ea6813be07dcdc Jan Kara        2022-06-23  1837  		 * before starting background writeout, and then write out all
ea6813be07dcdc Jan Kara        2022-06-23  1838  		 * the way down to the lower threshold.  So slow writers cause
ea6813be07dcdc Jan Kara        2022-06-23  1839  		 * minimal disk activity.
ea6813be07dcdc Jan Kara        2022-06-23  1840  		 *
ea6813be07dcdc Jan Kara        2022-06-23  1841  		 * In normal mode, we start background writeout at the lower
ea6813be07dcdc Jan Kara        2022-06-23  1842  		 * background_thresh, to keep the amount of dirty memory low.
ea6813be07dcdc Jan Kara        2022-06-23  1843  		 */
c8a7ee1b73042a Kemeng Shi      2024-04-23  1844  		if (!laptop_mode && nr_dirty > gdtc->bg_thresh &&
ea6813be07dcdc Jan Kara        2022-06-23  1845  		    !writeback_in_progress(wb))
ea6813be07dcdc Jan Kara        2022-06-23  1846  			wb_start_background_writeback(wb);
ea6813be07dcdc Jan Kara        2022-06-23  1847  
16c4042f08919f Wu Fengguang    2010-08-11  1848  		/*
c2aa723a609363 Tejun Heo       2015-05-22  1849  		 * If memcg domain is in effect, @dirty should be under
c2aa723a609363 Tejun Heo       2015-05-22  1850  		 * both global and memcg freerun ceilings.
16c4042f08919f Wu Fengguang    2010-08-11  1851  		 */
c474a90dc076a7 Kemeng Shi      2024-04-29  1852  		if (gdtc->freerun && (!mdtc || mdtc->freerun)) {
a37b0715ddf300 NeilBrown       2020-06-01  1853  			unsigned long intv;
a37b0715ddf300 NeilBrown       2020-06-01  1854  			unsigned long m_intv;
a37b0715ddf300 NeilBrown       2020-06-01  1855  
a37b0715ddf300 NeilBrown       2020-06-01  1856  free_running:
c474a90dc076a7 Kemeng Shi      2024-04-29  1857  			intv = domain_poll_intv(gdtc, strictlimit);
a37b0715ddf300 NeilBrown       2020-06-01  1858  			m_intv = ULONG_MAX;
c2aa723a609363 Tejun Heo       2015-05-22  1859  
83712358ba0a14 Wu Fengguang    2011-06-11  1860  			current->dirty_paused_when = now;
83712358ba0a14 Wu Fengguang    2011-06-11  1861  			current->nr_dirtied = 0;
c2aa723a609363 Tejun Heo       2015-05-22  1862  			if (mdtc)
c474a90dc076a7 Kemeng Shi      2024-04-29  1863  				m_intv = domain_poll_intv(mdtc, strictlimit);
c2aa723a609363 Tejun Heo       2015-05-22  1864  			current->nr_dirtied_pause = min(intv, m_intv);
16c4042f08919f Wu Fengguang    2010-08-11  1865  			break;
83712358ba0a14 Wu Fengguang    2011-06-11  1866  		}
16c4042f08919f Wu Fengguang    2010-08-11  1867  
ea6813be07dcdc Jan Kara        2022-06-23  1868  		/* Start writeback even when in laptop mode */
bc05873dccd27d Tejun Heo       2015-05-22  1869  		if (unlikely(!writeback_in_progress(wb)))
9ecf4866c018ae Tejun Heo       2015-05-22  1870  			wb_start_background_writeback(wb);
143dfe8611a630 Wu Fengguang    2010-08-27  1871  
97b27821b4854c Tejun Heo       2019-08-26  1872  		mem_cgroup_flush_foreign(wb);
97b27821b4854c Tejun Heo       2019-08-26  1873  
c2aa723a609363 Tejun Heo       2015-05-22  1874  		/*
c2aa723a609363 Tejun Heo       2015-05-22  1875  		 * Calculate global domain's pos_ratio and select the
c2aa723a609363 Tejun Heo       2015-05-22  1876  		 * global dtc by default.
c2aa723a609363 Tejun Heo       2015-05-22  1877  		 */
aab09fbaa2dd34 Kemeng Shi      2024-04-29  1878  		wb_dirty_freerun(gdtc, strictlimit);
aab09fbaa2dd34 Kemeng Shi      2024-04-29  1879  		if (gdtc->freerun)
a37b0715ddf300 NeilBrown       2020-06-01  1880  			goto free_running;
a37b0715ddf300 NeilBrown       2020-06-01  1881  
8b8bf84233eccf Kemeng Shi      2024-04-29  1882  		wb_dirty_exceeded(gdtc, strictlimit);
daddfa3cb30ebf Tejun Heo       2015-05-22  1883  		wb_position_ratio(gdtc);
c2aa723a609363 Tejun Heo       2015-05-22  1884  		sdtc = gdtc;
e98be2d599207c Wu Fengguang    2010-08-29  1885  
c2aa723a609363 Tejun Heo       2015-05-22 @1886  		if (mdtc) {
                                                                ^^^^^^^^^^^
This code assumes mdtc can be NULL

c2aa723a609363 Tejun Heo       2015-05-22  1887  			/*
c2aa723a609363 Tejun Heo       2015-05-22  1888  			 * If memcg domain is in effect, calculate its
c2aa723a609363 Tejun Heo       2015-05-22  1889  			 * pos_ratio.  @wb should satisfy constraints from
c2aa723a609363 Tejun Heo       2015-05-22  1890  			 * both global and memcg domains.  Choose the one
c2aa723a609363 Tejun Heo       2015-05-22  1891  			 * w/ lower pos_ratio.
c2aa723a609363 Tejun Heo       2015-05-22  1892  			 */
aab09fbaa2dd34 Kemeng Shi      2024-04-29  1893  			wb_dirty_freerun(mdtc, strictlimit);
aab09fbaa2dd34 Kemeng Shi      2024-04-29  1894  			if (mdtc->freerun)
a37b0715ddf300 NeilBrown       2020-06-01  1895  				goto free_running;
aab09fbaa2dd34 Kemeng Shi      2024-04-29  1896  
8b8bf84233eccf Kemeng Shi      2024-04-29  1897  			wb_dirty_exceeded(mdtc, strictlimit);
c2aa723a609363 Tejun Heo       2015-05-22  1898  			wb_position_ratio(mdtc);
c2aa723a609363 Tejun Heo       2015-05-22  1899  			if (mdtc->pos_ratio < gdtc->pos_ratio)
c2aa723a609363 Tejun Heo       2015-05-22  1900  				sdtc = mdtc;
c2aa723a609363 Tejun Heo       2015-05-22  1901  		}
daddfa3cb30ebf Tejun Heo       2015-05-22  1902  
8b8bf84233eccf Kemeng Shi      2024-04-29 @1903  		wb->dirty_exceeded = gdtc->dirty_exceeded || mdtc->dirty_exceeded;
                                                                                                             ^^^^^^
Unchecked dereference

20792ebf3eeb82 Jan Kara        2021-09-02  1904  		if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
45a2966fd64147 Jan Kara        2021-09-02  1905  					   BANDWIDTH_INTERVAL))
fee468fdf41cdf Jan Kara        2021-09-02  1906  			__wb_update_bandwidth(gdtc, mdtc, true);
e98be2d599207c Wu Fengguang    2010-08-29  1907  
c2aa723a609363 Tejun Heo       2015-05-22  1908  		/* throttle according to the chosen dtc */
20792ebf3eeb82 Jan Kara        2021-09-02  1909  		dirty_ratelimit = READ_ONCE(wb->dirty_ratelimit);
c2aa723a609363 Tejun Heo       2015-05-22  1910  		task_ratelimit = ((u64)dirty_ratelimit * sdtc->pos_ratio) >>
3a73dbbc9bb3fc Wu Fengguang    2011-11-07  1911  							RATELIMIT_CALC_SHIFT;
c2aa723a609363 Tejun Heo       2015-05-22  1912  		max_pause = wb_max_pause(wb, sdtc->wb_dirty);
a88a341a73be4e Tejun Heo       2015-05-22  1913  		min_pause = wb_min_pause(wb, max_pause,
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1914  					 task_ratelimit, dirty_ratelimit,
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1915  					 &nr_dirtied_pause);
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1916  
3a73dbbc9bb3fc Wu Fengguang    2011-11-07  1917  		if (unlikely(task_ratelimit == 0)) {
83712358ba0a14 Wu Fengguang    2011-06-11  1918  			period = max_pause;
c8462cc9de9e92 Wu Fengguang    2011-06-11  1919  			pause = max_pause;
143dfe8611a630 Wu Fengguang    2010-08-27  1920  			goto pause;
e50e37201ae2e7 Wu Fengguang    2010-08-11  1921  		}
83712358ba0a14 Wu Fengguang    2011-06-11  1922  		period = HZ * pages_dirtied / task_ratelimit;
83712358ba0a14 Wu Fengguang    2011-06-11  1923  		pause = period;
83712358ba0a14 Wu Fengguang    2011-06-11  1924  		if (current->dirty_paused_when)
83712358ba0a14 Wu Fengguang    2011-06-11  1925  			pause -= now - current->dirty_paused_when;
83712358ba0a14 Wu Fengguang    2011-06-11  1926  		/*
83712358ba0a14 Wu Fengguang    2011-06-11  1927  		 * For less than 1s think time (ext3/4 may block the dirtier
83712358ba0a14 Wu Fengguang    2011-06-11  1928  		 * for up to 800ms from time to time on 1-HDD; so does xfs,
83712358ba0a14 Wu Fengguang    2011-06-11  1929  		 * however at much less frequency), try to compensate it in
83712358ba0a14 Wu Fengguang    2011-06-11  1930  		 * future periods by updating the virtual time; otherwise just
83712358ba0a14 Wu Fengguang    2011-06-11  1931  		 * do a reset, as it may be a light dirtier.
83712358ba0a14 Wu Fengguang    2011-06-11  1932  		 */
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1933  		if (pause < min_pause) {
5634cc2aa9aebc Tejun Heo       2015-08-18  1934  			trace_balance_dirty_pages(wb,
c2aa723a609363 Tejun Heo       2015-05-22  1935  						  sdtc->thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1936  						  sdtc->bg_thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1937  						  sdtc->dirty,
c2aa723a609363 Tejun Heo       2015-05-22  1938  						  sdtc->wb_thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1939  						  sdtc->wb_dirty,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1940  						  dirty_ratelimit,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1941  						  task_ratelimit,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1942  						  pages_dirtied,
83712358ba0a14 Wu Fengguang    2011-06-11  1943  						  period,
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1944  						  min(pause, 0L),
ece13ac31bbe49 Wu Fengguang    2010-08-29  1945  						  start_time);
83712358ba0a14 Wu Fengguang    2011-06-11  1946  			if (pause < -HZ) {
83712358ba0a14 Wu Fengguang    2011-06-11  1947  				current->dirty_paused_when = now;
83712358ba0a14 Wu Fengguang    2011-06-11  1948  				current->nr_dirtied = 0;
83712358ba0a14 Wu Fengguang    2011-06-11  1949  			} else if (period) {
83712358ba0a14 Wu Fengguang    2011-06-11  1950  				current->dirty_paused_when += period;
83712358ba0a14 Wu Fengguang    2011-06-11  1951  				current->nr_dirtied = 0;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1952  			} else if (current->nr_dirtied_pause <= pages_dirtied)
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1953  				current->nr_dirtied_pause += pages_dirtied;
57fc978cfb61ed Wu Fengguang    2011-06-11  1954  			break;
e50e37201ae2e7 Wu Fengguang    2010-08-11  1955  		}
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1956  		if (unlikely(pause > max_pause)) {
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1957  			/* for occasional dropped task_ratelimit */
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1958  			now += min(pause - max_pause, max_pause);
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1959  			pause = max_pause;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1960  		}
143dfe8611a630 Wu Fengguang    2010-08-27  1961  
143dfe8611a630 Wu Fengguang    2010-08-27  1962  pause:
5634cc2aa9aebc Tejun Heo       2015-08-18  1963  		trace_balance_dirty_pages(wb,
c2aa723a609363 Tejun Heo       2015-05-22  1964  					  sdtc->thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1965  					  sdtc->bg_thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1966  					  sdtc->dirty,
c2aa723a609363 Tejun Heo       2015-05-22  1967  					  sdtc->wb_thresh,
c2aa723a609363 Tejun Heo       2015-05-22  1968  					  sdtc->wb_dirty,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1969  					  dirty_ratelimit,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1970  					  task_ratelimit,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1971  					  pages_dirtied,
83712358ba0a14 Wu Fengguang    2011-06-11  1972  					  period,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1973  					  pause,
ece13ac31bbe49 Wu Fengguang    2010-08-29  1974  					  start_time);
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1975  		if (flags & BDP_ASYNC) {
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1976  			ret = -EAGAIN;
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1977  			break;
fe6c9c6e3e3e33 Jan Kara        2022-06-23  1978  		}
499d05ecf990a7 Jan Kara        2011-11-16  1979  		__set_current_state(TASK_KILLABLE);
f814bdda774c18 Jan Kara        2024-01-23  1980  		bdi->last_bdp_sleep = jiffies;
d25105e8911bff Wu Fengguang    2009-10-09  1981  		io_schedule_timeout(pause);
87c6a9b253520b Jens Axboe      2009-09-17  1982  
83712358ba0a14 Wu Fengguang    2011-06-11  1983  		current->dirty_paused_when = now + pause;
83712358ba0a14 Wu Fengguang    2011-06-11  1984  		current->nr_dirtied = 0;
7ccb9ad5364d6a Wu Fengguang    2011-11-30  1985  		current->nr_dirtied_pause = nr_dirtied_pause;
83712358ba0a14 Wu Fengguang    2011-06-11  1986  
ffd1f609ab1053 Wu Fengguang    2011-06-19  1987  		/*
2bc00aef030f4f Tejun Heo       2015-05-22  1988  		 * This is typically equal to (dirty < thresh) and can also
2bc00aef030f4f Tejun Heo       2015-05-22  1989  		 * keep "1000+ dd on a slow USB stick" under control.
ffd1f609ab1053 Wu Fengguang    2011-06-19  1990  		 */
1df647197c5b8a Wu Fengguang    2011-11-13  1991  		if (task_ratelimit)
ffd1f609ab1053 Wu Fengguang    2011-06-19  1992  			break;
499d05ecf990a7 Jan Kara        2011-11-16  1993  
c5c6343c4d75f9 Wu Fengguang    2011-12-02  1994  		/*
f0953a1bbaca71 Ingo Molnar     2021-05-06  1995  		 * In the case of an unresponsive NFS server and the NFS dirty
de1fff37b2781f Tejun Heo       2015-05-22  1996  		 * pages exceeds dirty_thresh, give the other good wb's a pipe
c5c6343c4d75f9 Wu Fengguang    2011-12-02  1997  		 * to go through, so that tasks on them still remain responsive.
c5c6343c4d75f9 Wu Fengguang    2011-12-02  1998  		 *
3f8b6fb7f279c7 Masahiro Yamada 2017-02-27  1999  		 * In theory 1 page is enough to keep the consumer-producer
c5c6343c4d75f9 Wu Fengguang    2011-12-02  2000  		 * pipe going: the flusher cleans 1 page => the task dirties 1
de1fff37b2781f Tejun Heo       2015-05-22  2001  		 * more page. However wb_dirty has accounting errors.  So use
93f78d882865cb Tejun Heo       2015-05-22  2002  		 * the larger and more IO friendly wb_stat_error.
c5c6343c4d75f9 Wu Fengguang    2011-12-02  2003  		 */
2bce774e8245e9 Wang Long       2017-11-15  2004  		if (sdtc->wb_dirty <= wb_stat_error())
c5c6343c4d75f9 Wu Fengguang    2011-12-02  2005  			break;
c5c6343c4d75f9 Wu Fengguang    2011-12-02  2006  
499d05ecf990a7 Jan Kara        2011-11-16  2007  		if (fatal_signal_pending(current))
499d05ecf990a7 Jan Kara        2011-11-16  2008  			break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2009  	}
fe6c9c6e3e3e33 Jan Kara        2022-06-23  2010  	return ret;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2011  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


