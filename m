Return-Path: <linux-fsdevel+bounces-25761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E341794FF39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A146283DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF4136354;
	Tue, 13 Aug 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA7+A4S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AB4F218
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536012; cv=none; b=aolVIVue8F8eidp6eMrm6FK8xt1M8nt3/+6DxkjUeL8HwXZK2jVwiF+keXHykEfr3vHryXvT4z7bQJgRzrALG/RsVCmW2+beU2xOXoS/zD24yoT9nld/+C22yAbfT70Rn+CLvT87sRKpQbYXmw0jZLEjwTpaBtFs0Pv2X9r1QD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536012; c=relaxed/simple;
	bh=ZZNMazY+wB0Qt5QH+bRB/+v1cqkYb6cJ6wHaTsf9QZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HDUkqndFcoVUAzloOuiq5Oatyuux+ZQre2cg13i5Hj+7K3O/muoCIxqr8apa60GBkXFkVYmpf7kFet4Odh/nOtjFmhMwzP1Zu6cT/XWZfAfzZhqFeQj1VPH6KXxrU4II7onjFvazgMAgl9FZHuQWi3hD7H249cPRDY8d/ZY7gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VA7+A4S3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4699254a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723536009; x=1724140809; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8B4aF2RhoJ87Q6+bPsf2aPZNzfoieuHNYR9HqWY5+FU=;
        b=VA7+A4S31HduIWceyddTMOm9Ye6SANMy3EkLvNzwCqL0Uwk1RmIw1rz3KGRgBkgPTN
         g6+CSRHComGtmo0JwWi2Zm0jUg3Azzx4MCHvRtpZQytKDjyI+5QlzikrUKpWQfkVWTui
         saRcalq+sfPiU0kk+D6DOkCe4MC1Hh2JUnuSR4y5UnrupxMy/Nq1sWpJRpqNWkLYwkfN
         /gHXphppCCOuIbLJtniYy+Ebq85G44vtJGfGbVADE5zk3oY7uedaOg4bc2YK/i2cXfvf
         aBK6+tQwXSbd8RnT3AJbOMMi2VuYLx1moXmI0Hxe0j1oQljm+UOtNQJy1ZWXB/nscgMg
         rUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723536009; x=1724140809;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8B4aF2RhoJ87Q6+bPsf2aPZNzfoieuHNYR9HqWY5+FU=;
        b=NmS4ydjRYP/8CkFe7xGiZAUu3YT42dWMRFN1mInKEFwKLXarbvNrEY4N586RH0UKKy
         EZ7CLR9shw8+8L+sKovKWsUhnp+oUehS+T2hG8uIM0f1NCPArjmBeDc4/+TO8rCMUUwA
         rUD3TcSlsBuyiWK+MAAvSQb0+fbDlOlxw8RnIHF2K7o7G7+IZ2XG2GsdSOYTuHgHDazh
         f5cg3FIGhHrfgIggl29yLa9reXXp36Gnk2Hkqhrhorqyvm3B8BmBjVHoBB4GpMAZrrYY
         RI8NkWafcu8NBpIYvqSNbP5nXZ484nAgstvHC0dN0g/RP9aTjIox8PG7ENGaZifT/Qce
         8UcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7TOy6OGWt1Kg0L+YmPgdIrx1Bo7ng4y3pTQ88DuSPvHgCK081jasZhjccJ1zABXffA1/70UEQNaZ/NZQ7EERnGA8ohTAOVByXgqiQ1Q==
X-Gm-Message-State: AOJu0Yz4Ib+gcE6v9tAK3SlKOP635gW8cNrs0O/gF47VvkljpYSzahjL
	KYLmaDC/swAf2r11H5IZ81HP8SxbrRquv4QmVSx0SMvsyalWH/VadGFXo2Pq1+7a76F8Vn81Mul
	2
X-Google-Smtp-Source: AGHT+IGIsBAmGDvIqzFfs21L+bkNCMbqJN/sGhkWBbxSO2GOwb7z5+wSnD75VLe0Bjg2n+z2W30cIA==
X-Received: by 2002:a05:6402:3587:b0:5bb:9ae0:4a46 with SMTP id 4fb4d7f45d1cf-5bd44c0cff8mr2369154a12.5.1723536009102;
        Tue, 13 Aug 2024 01:00:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f29d0sm2733183a12.2.2024.08.13.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:00:08 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:00:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd() warn:
 passing a valid pointer to 'PTR_ERR'
Message-ID: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fdtable
head:   3f4b0acefd818ec43b68455994ac2bd5166c06ae
commit: 3f4b0acefd818ec43b68455994ac2bd5166c06ae [13/13] dup_fd(): change calling conventions
config: x86_64-randconfig-161-20240813 (https://download.01.org/0day-ci/archive/20240813/202408130945.I8wIAYBm-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408130945.I8wIAYBm-lkp@intel.com/

smatch warnings:
kernel/fork.c:3242 unshare_fd() warn: passing a valid pointer to 'PTR_ERR'

vim +/PTR_ERR +3242 kernel/fork.c

60997c3d45d9a6 Christian Brauner 2020-06-03  3232  int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
60997c3d45d9a6 Christian Brauner 2020-06-03  3233  	       struct files_struct **new_fdp)
cf2e340f4249b7 JANAK DESAI       2006-02-07  3234  {
cf2e340f4249b7 JANAK DESAI       2006-02-07  3235  	struct files_struct *fd = current->files;
cf2e340f4249b7 JANAK DESAI       2006-02-07  3236  
cf2e340f4249b7 JANAK DESAI       2006-02-07  3237  	if ((unshare_flags & CLONE_FILES) &&
a016f3389c0660 JANAK DESAI       2006-02-07  3238  	    (fd && atomic_read(&fd->count) > 1)) {
3f4b0acefd818e Al Viro           2024-08-06  3239  		*new_fdp = dup_fd(fd, max_fds);
3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
                                                                               ^^^^^^^^^^^^^^^^
	err = PTR_ERR(*new_fdp);
	*new_fdp = NULL;
	return err;

3f4b0acefd818e Al Viro           2024-08-06  3243  		}
a016f3389c0660 JANAK DESAI       2006-02-07  3244  	}
cf2e340f4249b7 JANAK DESAI       2006-02-07  3245  
cf2e340f4249b7 JANAK DESAI       2006-02-07  3246  	return 0;
cf2e340f4249b7 JANAK DESAI       2006-02-07  3247  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


