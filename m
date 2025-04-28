Return-Path: <linux-fsdevel+bounces-47487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBBEA9E7C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 07:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8181E7A9799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 05:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D551A3159;
	Mon, 28 Apr 2025 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMB6yiKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E51482F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745818378; cv=none; b=e1L9JGtVMvzKt1ex2soRGwvQk/+kRr4AEPrZHf7iG/1k7TrsiwUIs52dRgQXZX7/ZcntndnJPoa21+oRHJl7+V61HE8kadKcnEb7k0iS2gwldwtQ3WJUs+hugS2Fp6EzH9gAlZBRo2du/GXbkTIecR1edAnVwfVulaONtiw8Cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745818378; c=relaxed/simple;
	bh=GPz29Fzv8rPNvSmKBotSWad2I4rHWPgwSLB+LoykofE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R2QIrR2/VeDlEVNKp9Bt/Shz/GVtCb/RZ6/49TYM3S6jg3TJG0WO1spMD5FLqAK6oxTYcoQ2j8KnzkL314IHrkFmb5a8r/G6F44HQDNGhoHh7kcAwBtpGzA5cGNVjIJMTjwAyExGRc5iQNjKoQ7OuQojcAuXVCxMY0a+78Sgyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMB6yiKj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2958626f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745818373; x=1746423173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKKZvIRtkFvH+AwNCv0XKOvqxhk53kMv+OMKK40w/r8=;
        b=CMB6yiKjQPW/4sf6F2y0i7bavBDH6E9qKXqnFjUj3Zf6LNFqgIsJGtMKlUn6c/nkqI
         Qpk9Np6D5VP1LGwY9jsbk9T///DKdWeg4CjB0VhK91WbichfJYRFAwWSw8CI80fjlEQL
         yPc8RXtGV1XrAetM2/bfdOorjDv3MfXzibbB73vyQuGLV8iQXCagRe9+hBazoQ8F1ZlO
         4PiVZ0DkCtFAr348N1COrh5M/PWoWx+zxxo5Qh9cltGXT7aUHI675wlj2FyktvzM9eYq
         T4fEOgy60ZiJwhCxVX3NSDPQ7WaJKXXJuWzU0UrLaT2LljG8hcc501tLQ1t95eYCkayd
         AYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745818373; x=1746423173;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKKZvIRtkFvH+AwNCv0XKOvqxhk53kMv+OMKK40w/r8=;
        b=NPWEYdrupfcb58FjhaspAwCYRgtGUuG/AKvvGFx6P0Z2fwytk1oWXrnJKwlO7jr4hG
         5mo3xk5fOvQOFrYuWOk2yMsUBoQbYqhGsan/4lWREUERccGnK3uMVtD144eHQc4+x8b2
         7Iky9JI8oZXJVqzWRIQ6YgrSjsK6BNB0g4YBNHJNpAzSUWWJSQAQlhDPzDH3K6NGN1O+
         J9EJybmU2UCL5MkqTnJOoTlWee82dpNmSt/RgYu8sWNRGDF70oFrXF/SJ7sWoDR5GxcN
         3F+X7l232VcmiCTtiMen9CLgteXnw0tRvillqKJ6HkAo7OA5fgnATqfN3Z8JJsQzowRQ
         Ritg==
X-Forwarded-Encrypted: i=1; AJvYcCUbwFUkXkg9jl5u/ZS1QX0Q1ZE8KU9SPtyygVGzcfsni7QiiAgxPmhyswDuj5kwf7C7Tv6er6VhsIVNOlgS@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbO/L91kfM+EVJWU6OPsH63XsgyzPX1uIIExqXhgZGRYsyxEG
	GvDxrZwgpiHVozwyzXREOuiaG1pHgkoMjg44e73adklMul1+hueFhM8RI58CkfY=
X-Gm-Gg: ASbGncvx5HvO+XAwM47JT6xTEQDDbPCnjshFP761RoDdj/XPWOIUiQdPM4M1P9oFDLI
	BlWOpeu5hC42LTcjYmjw3/JxeunncrZUNtRBmc/IUWTFHMmqsZNTMs5eHX/TIyazy54HBpW15ux
	Jb328iSb4GwcYWvlt6F5nUKZ6TYS7EXe+Uovu6jgmV9FayvPjZO/VxcbIdl/YgT85MRSUIVngpP
	qUMfyFt0EqvMv4WaEN6qeqQVtr8THMFqT3rHKaYXVTpBHacvEkWMNeu6iTID7v2zk3yaXadmTWz
	pjLJcsaOEUqkGoiuoBwejDz4rrQEsvXmxp79EoJycAw+Ornqw07nk2iG
X-Google-Smtp-Source: AGHT+IEKWem/HNlzRPhqg9OGR30RsvkJD62VYqwfxOcZbJLk/MwF51qrC6FSBdAJSPFVOLgrZDavgg==
X-Received: by 2002:adf:f947:0:b0:39d:724f:a8ae with SMTP id ffacd0b85a97d-3a074e430b5mr7141999f8f.33.1745818373040;
        Sun, 27 Apr 2025 22:32:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073e461bfsm10107849f8f.79.2025.04.27.22.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:32:52 -0700 (PDT)
Date: Mon, 28 Apr 2025 08:32:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Joanne Koong <joannelkoong@gmail.com>,
	miklos@szeredi.hu
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
	jefflexu@linux.alibaba.com, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, willy@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
Message-ID: <202504270319.GmkEM1Xg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426000828.3216220-4-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-support-copying-large-folios/20250426-081219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250426000828.3216220-4-joannelkoong%40gmail.com
patch subject: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
config: i386-randconfig-141-20250426 (https://download.01.org/0day-ci/archive/20250427/202504270319.GmkEM1Xg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202504270319.GmkEM1Xg-lkp@intel.com/

smatch warnings:
fs/fuse/file.c:1207 fuse_fill_write_pages() error: uninitialized symbol 'err'.

vim +/err +1207 fs/fuse/file.c

4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1127  static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1128  				     struct address_space *mapping,
338f2e3f3341a9 Miklos Szeredi     2019-09-10  1129  				     struct iov_iter *ii, loff_t pos,
338f2e3f3341a9 Miklos Szeredi     2019-09-10  1130  				     unsigned int max_pages)
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1131  {
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1132  	struct fuse_args_pages *ap = &ia->ap;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1133  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1134  	unsigned offset = pos & (PAGE_SIZE - 1);
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1135  	size_t count = 0;
dfda790dfda452 Joanne Koong       2025-04-25  1136  	unsigned int num;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1137  	int err;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1138  
dfda790dfda452 Joanne Koong       2025-04-25  1139  	num = min(iov_iter_count(ii), fc->max_write);

Can iov_iter_count() return zero here?

dfda790dfda452 Joanne Koong       2025-04-25  1140  	num = min(num, max_pages << PAGE_SHIFT);
dfda790dfda452 Joanne Koong       2025-04-25  1141  
338f2e3f3341a9 Miklos Szeredi     2019-09-10  1142  	ap->args.in_pages = true;
68bfb7eb7f7de3 Joanne Koong       2024-10-24  1143  	ap->descs[0].offset = offset;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1144  
dfda790dfda452 Joanne Koong       2025-04-25  1145  	while (num) {
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1146  		size_t tmp;
9bafbe7ae01321 Josef Bacik        2024-09-30  1147  		struct folio *folio;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1148  		pgoff_t index = pos >> PAGE_SHIFT;
dfda790dfda452 Joanne Koong       2025-04-25  1149  		unsigned bytes = min(PAGE_SIZE - offset, num);
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1150  
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1151   again:
9bafbe7ae01321 Josef Bacik        2024-09-30  1152  		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
9bafbe7ae01321 Josef Bacik        2024-09-30  1153  					    mapping_gfp_mask(mapping));
9bafbe7ae01321 Josef Bacik        2024-09-30  1154  		if (IS_ERR(folio)) {
9bafbe7ae01321 Josef Bacik        2024-09-30  1155  			err = PTR_ERR(folio);
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1156  			break;
9bafbe7ae01321 Josef Bacik        2024-09-30  1157  		}
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1158  
931e80e4b3263d anfei zhou         2010-02-02  1159  		if (mapping_writably_mapped(mapping))
9bafbe7ae01321 Josef Bacik        2024-09-30  1160  			flush_dcache_folio(folio);
931e80e4b3263d anfei zhou         2010-02-02  1161  
9bafbe7ae01321 Josef Bacik        2024-09-30  1162  		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
9bafbe7ae01321 Josef Bacik        2024-09-30  1163  		flush_dcache_folio(folio);
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1164  
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1165  		if (!tmp) {
9bafbe7ae01321 Josef Bacik        2024-09-30  1166  			folio_unlock(folio);
9bafbe7ae01321 Josef Bacik        2024-09-30  1167  			folio_put(folio);
faa794dd2e17e7 Dave Hansen        2025-01-29  1168  
faa794dd2e17e7 Dave Hansen        2025-01-29  1169  			/*
faa794dd2e17e7 Dave Hansen        2025-01-29  1170  			 * Ensure forward progress by faulting in
faa794dd2e17e7 Dave Hansen        2025-01-29  1171  			 * while not holding the folio lock:
faa794dd2e17e7 Dave Hansen        2025-01-29  1172  			 */
faa794dd2e17e7 Dave Hansen        2025-01-29  1173  			if (fault_in_iov_iter_readable(ii, bytes)) {
faa794dd2e17e7 Dave Hansen        2025-01-29  1174  				err = -EFAULT;
faa794dd2e17e7 Dave Hansen        2025-01-29  1175  				break;
faa794dd2e17e7 Dave Hansen        2025-01-29  1176  			}
faa794dd2e17e7 Dave Hansen        2025-01-29  1177  
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1178  			goto again;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1179  		}
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1180  
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1181  		err = 0;
f2ef459bab7326 Joanne Koong       2024-10-24  1182  		ap->folios[ap->num_folios] = folio;
68bfb7eb7f7de3 Joanne Koong       2024-10-24  1183  		ap->descs[ap->num_folios].length = tmp;
f2ef459bab7326 Joanne Koong       2024-10-24  1184  		ap->num_folios++;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1185  
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1186  		count += tmp;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1187  		pos += tmp;
dfda790dfda452 Joanne Koong       2025-04-25  1188  		num -= tmp;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1189  		offset += tmp;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  1190  		if (offset == PAGE_SIZE)
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1191  			offset = 0;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1192  
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1193  		/* If we copied full page, mark it uptodate */
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1194  		if (tmp == PAGE_SIZE)
9bafbe7ae01321 Josef Bacik        2024-09-30  1195  			folio_mark_uptodate(folio);
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1196  
9bafbe7ae01321 Josef Bacik        2024-09-30  1197  		if (folio_test_uptodate(folio)) {
9bafbe7ae01321 Josef Bacik        2024-09-30  1198  			folio_unlock(folio);
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1199  		} else {
f2ef459bab7326 Joanne Koong       2024-10-24  1200  			ia->write.folio_locked = true;
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1201  			break;
4f06dd92b5d0a6 Vivek Goyal        2020-10-21  1202  		}
dfda790dfda452 Joanne Koong       2025-04-25  1203  		if (!fc->big_writes || offset != 0)
78bb6cb9a890d3 Miklos Szeredi     2008-05-12  1204  			break;
dfda790dfda452 Joanne Koong       2025-04-25  1205  	}
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1206  
ea9b9907b82a09 Nicholas Piggin    2008-04-30 @1207  	return count > 0 ? count : err;
ea9b9907b82a09 Nicholas Piggin    2008-04-30  1208  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


