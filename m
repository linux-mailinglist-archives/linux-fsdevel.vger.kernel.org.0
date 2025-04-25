Return-Path: <linux-fsdevel+bounces-47367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD72A9CB9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A452F3ADCE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE51E519;
	Fri, 25 Apr 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpgQ81+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2A248879
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591025; cv=none; b=bdfJXZALaOMv2r9uD9h9bZuWbz7LesaWS/v5GOyy6nsQGpOwSMudeHev0NwMcWYBx/KVbFSbealTDKTYLC0B7s6sN94mBLxe4OWgIX8T01IpWMy4wgV8f9kEfPf/ZkFC4d+FAZjoqxlPkNVTGEVJP1SMbnpvBRAU6UvM5mPF9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591025; c=relaxed/simple;
	bh=6Pqd0uUCHDJ+D1I1XV1sfNnBZqb2Er+OCthJCTm+bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qN2+41+uSq2kCxHx2iHFnMBkBSsGKsBO7uUMIqY1urACtCvxsHeucIajOkMqB9fbJPLz+diXdMV3k4bC2pZHFrts93d7cBaD9OBRt/+wxMkKkHdC9HBHPvr1NtWr1gpjh60Dx//ZDD7L9+j2o//SQsZyYfoGyxAz8XP1bQVuJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpgQ81+P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39149bccb69so2059973f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745591022; x=1746195822; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gu6PPrX9V5cU+SxQNWsO86MP8IOnCgpwplOOKRt11Yg=;
        b=JpgQ81+PnwWMi0nbhDaKLjj0TPNFFFGhAZga119v9OmuYAp6BfUk3cTeZgBfO/eygi
         xAaJTd5eRPc28tvCD7ii704V1mXtsIbyw7+RLfpnm+mDlycOzphcaDG3kXhRBEVTh7Mz
         SOTX5jC0EWr3gwDW2a/yNJylg7CCNhhYPWpPi2Vn62zPixrY7pBNcbOLRexVoRcevsMQ
         mcmIamF9/G5ehmSE6S0/1H+DgOgfC9emLC5elaZWPDw1x72Wny/7Es8KD1lxAOpnB32Q
         cVKXuwulF8UWKlwyYUKVcC/7eL4xmmjRZddhRGxOmLmILSsvnDxV5/uOCxzFD7ztA/D8
         Gn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745591022; x=1746195822;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu6PPrX9V5cU+SxQNWsO86MP8IOnCgpwplOOKRt11Yg=;
        b=ftuthDPCM1IJ/OIs0SyWydM7FT5xRuN8ohmFdeliDxcdyhXihD0tQuXFEsqdtF0+6n
         zzbieI8nY9ltTsavC3KzTtWBChwMrb5uI9kwwi3CyDH3H7bpLLpImOhZ3nuKMLSx29wk
         +J+Ti55y3ygzW0+t9grKHp7xSSlabMmKTotrCdnKCvHViwybT5hgFQRAvN8nOZrlPTR1
         DAQSHDzguRjLThTlGNc66+QO1jucZI35bVSmLqU1D5fSL0FTn6mrpiSysgQaRbFnMn2O
         uMVTTmiCGaZRZYWPJMSEkbqQAIj1dLYkWsC8UFymxKJbPorti2hebaAS0MdGyhNKJAve
         zHkA==
X-Gm-Message-State: AOJu0YznP4KhiS5Al6NmU0RnekjKk1UnGX/Na8UvIEFn9k6Pgj08ZSCI
	LB3CHDAG+kBl2HxTNN+q3J40X5DFxrJiw5xrBEUTz+D7I5DvQHiEmEPUnsBoUQUxu8arzZ8PvE8
	F
X-Gm-Gg: ASbGnctqRhRydoNMdZhgJHOWU+icH+8YE1eiSNNVUkmk4pWRYqGzCT32TpcdY7njF1i
	raVLgJq7MF/+et401SMcObjIKR3CqAWrTjYT7vJdD0JKH75wgiqmZo6dHekrOLH2cnKZIbCTq7V
	NHeB8UY1f97xPqsw9BWOoiTdIWz7V7g/DtpAzwiGkVJ4P1uRMVITK7KFUqT7zaImjH+2pTsCXe8
	PGtBDqlk/qANuPQmmqsdg2AAHEQxcRFRi+u63dx4Uws4MyADblBy6g16wiBX+YMgOlNshifgwe5
	dcC0Wgc8SgcJkPt6sqUwGXNQsbyHghFW71T33dIL+X96Cw==
X-Google-Smtp-Source: AGHT+IFQqwjq1cgrx/3l/UpLxOWaFtMK+BCCSqzdUvr6oaqplZaT0JosWJyo4neAIi/VOm1DiFK1Og==
X-Received: by 2002:a5d:5986:0:b0:39e:e588:672f with SMTP id ffacd0b85a97d-3a074f854aamr2320949f8f.55.1745591022017;
        Fri, 25 Apr 2025 07:23:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cbf030sm2510402f8f.46.2025.04.25.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:23:41 -0700 (PDT)
Date: Fri, 25 Apr 2025 17:23:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] coredump: hand a pidfd to the usermode coredump helper
Message-ID: <aAua6ufHsy6qhMcs@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit 4268b86fe0c7 ("coredump: hand a pidfd to the usermode coredump
helper") from Apr 14, 2025 (linux-next), leads to the following
Smatch static checker warning:

	fs/coredump.c:556 umh_coredump_setup()
	warn: re-assigning __cleanup__ ptr 'pidfs_file'

fs/coredump.c
    536 static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
    537 {
    538         struct file *files[2];
    539         struct coredump_params *cp = (struct coredump_params *)info->data;
    540         int err;
    541 
    542         if (cp->pid) {
    543                 struct file *pidfs_file __free(fput) = NULL;
    544 
    545                 pidfs_file = pidfs_alloc_file(cp->pid, 0);

We allocate pidfs_file.

    546                 if (IS_ERR(pidfs_file))
    547                         return PTR_ERR(pidfs_file);
    548 
    549                 /*
    550                  * Usermode helpers are childen of either
    551                  * system_unbound_wq or of kthreadd. So we know that
    552                  * we're starting off with a clean file descriptor
    553                  * table. So we should always be able to use
    554                  * COREDUMP_PIDFD_NUMBER as our file descriptor value.
    555                  */
--> 556                 VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);

Then we set it to NULL without calling fput() on it.

    557 
    558                 err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);

pidfs_file is NULL so then we basically do:

	err = close_fd(COREDUMP_PIDFD_NUMBER);

I'm so confused...  Should the WARN_ON be for == NULL?

    559                 if (err < 0)
    560                         return err;
    561         }
    562 
    563         err = create_pipe_files(files, 0);
    564         if (err)
    565                 return err;
    566 
    567         cp->file = files[1];
    568 
    569         err = replace_fd(0, files[0], 0);
    570         fput(files[0]);
    571         if (err < 0)
    572                 return err;
    573 
    574         /* and disallow core files too */
    575         current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
    576 
    577         return 0;
    578 }

regards,
dan carpenter

