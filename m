Return-Path: <linux-fsdevel+bounces-76934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMCtM8RgjGmWlwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:58:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06007123ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2742300721E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F236B06C;
	Wed, 11 Feb 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOOy8Cgw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AE36BCC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807468; cv=none; b=CDFH7/IGwnRaWOc0Q8VoU0jBJKqo0agBCJ/d8fVLDaoUQtab7JRK54MCsy6he6uivMzUfpBAjYZsd5plmqtCbGUF3p0ymq6dXIWg0WIltHab6UrXN2GA17aefQxBpvW2cc4fk40lSYIB0PSBRCamvLI6iXs+KuBfZwav+ETWcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807468; c=relaxed/simple;
	bh=YkNcQ3NtAJBYnY/PDYgBtDin1rYL1T6RPzvptBiXatI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qco5begnP+QzCFcB2ZowCnaCbxL5C0xHN0wW73LM8Xenq3PIucOAZM3MKOZeuuImF1qtUMb3wiWCbmwocGLeRwpGmYQwUcRtFatbzjMYLwDWb2b/oJf/eus8965741IwpP3uQ+b1kEDI26/UUyGWEmnUOay12cT+MAW3JRROufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOOy8Cgw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so54700985e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 02:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770807464; x=1771412264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1f6efIeKsPBmBdsMP945v7o1I22Mg2iVh32MUI/KTBg=;
        b=WOOy8CgwGsomPEx6PD8pZCYoK2xEk9UoLCr4uJFRIpLIKV40RHOpRnZEeuw+SLJHv4
         E2/DVdcr8c0LkOOaAxWM1se12eZgrKQd8X9+uBeMyv/Pe1pOHWeuqlZHZVkiOnCie0eJ
         tQY/lEX5Bmk+UdiT8UZASPflLEUnncG/V0EGhc+y7OcfjiL+VV7qkQDIZMEl8Dtj6fzX
         LVUdj6UsH+EpXhQXp+U7OrIxuNVSBhlUgtnDAzziHmyQIiXVr2cEsYDPPFCTCQl9HCyk
         Bhkxv2hKwpO6uq40BTInyrTXL76gRmexnmNfGQ1zwyXQc/fz2KQeglEwGrW+Acn0veOU
         Poqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807464; x=1771412264;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f6efIeKsPBmBdsMP945v7o1I22Mg2iVh32MUI/KTBg=;
        b=gN/UAqHtZkb7YsOqYLx6Y3chWpQltBNIxQ8bTBPdhaLN9lPhgHnaoKZjOHWdNdhBmn
         fE0SO3b3SIHKJZYQ7aQg4TbHZQEcU7p08CzLGErrrMLM7+BaHkhe9OpTSObtnI03uU1N
         /0blMCJP7WswHU8DBITf5jUrETRiYSCA6laKlTTDI99t9L6iQGSrEC/J18u/Rmo9V2ML
         AXnfy4jnYEmG2CZaDpoMPaADVIMlLks3adAYZwqN0Awp5jIQnXykFE/LnZ3MTJwCx+Qw
         Ns58k/6DqkjzlPYS/eX4Ww7mvf6VQmh3lOPDluuKbBLhhAlF72Yd64wkSixCJjkxVP57
         vlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAVoNifNTRThUry3+2PWAQsgJTwOuV0TYyu0hBvU8eS9PBwVWj16IoxOWtFnD2eq8YmkVQT3NaRsxYaFSq@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+6Z4sxREarXc/YY32Q+N+zkWY4p57+Mb9oGWwMsv8ATBUR3J
	bgh5thBzjpsCNyL4Jzf+TZ8G17OsQkMVrdeNNUt5dsN93XfLB27+HILZVyerY+WBzokQ6MelQvK
	/HUKC
X-Gm-Gg: AZuq6aLkYC7+ooyFuLz6PRWM7Vo5GsAm+cNBl69A6XiBdwJacoIYQBydkgrtfBWlYR4
	g4ATevo7p+t2DCxZwRWqPUVJ7N1bQ0ZpIGR89Sa5/nKzx49jDBUkNvxv2jnNC4CXMt6oyHxQgv/
	+iZf9rOu381tnzeDyt6gfj+7sLNoMlVUi+Hi5UX+kCNHnFH4JbIW51+Y46Dbn7JRHMnmcGKqJFw
	XDjGh/dllCAEvYihN9LvgwTv+xCS/g6cuih/A7lLnhfFFs+lhI0ePO1Hm3KRoJTMQtA+zKQt0Go
	meadmak9YcSX484Nk1CGfzGjuPw2009339cJOczsYG629lBrNxIrAWayCw2gnAFFhYQ7urKXQdZ
	wi3TlfWjOPZqIL8YnVQKM/lMULT0tIFu4fWtaRDgULoTLyfk3KgEDoGBop/iVbUNv3wKhdbg2YT
	q1Jb7pWHC7Lq9os3gGC2YNJRHjSXMUqcnqV/izlx4=
X-Received: by 2002:a05:600d:17:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-4835dd89039mr20323065e9.8.1770807463537;
        Wed, 11 Feb 2026 02:57:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836131d4d9sm5222705e9.25.2026.02.11.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 02:57:43 -0800 (PST)
Date: Wed, 11 Feb 2026 13:57:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ethan Ferguson <ethan.ferguson@zetier.com>,
	hirofumi@mail.parknet.co.jp
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH 1/2] fat: Add FS_IOC_GETFSLABEL ioctl
Message-ID: <202602111747.QIBXIwpw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210222310.357755-2-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76934-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,intel.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06007123ADB
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260211-062606
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260210222310.357755-2-ethan.ferguson%40zetier.com
patch subject: [PATCH 1/2] fat: Add FS_IOC_GETFSLABEL ioctl
config: riscv-randconfig-r071-20260211 (https://download.01.org/0day-ci/archive/20260211/202602111747.QIBXIwpw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 9.5.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602111747.QIBXIwpw-lkp@intel.com/

smatch warnings:
fs/fat/file.c:160 fat_ioctl_get_volume_label() warn: maybe return -EFAULT instead of the bytes remaining?

vim +160 fs/fat/file.c

5fc1746d68b8fb Ethan Ferguson 2026-02-10  156  static int fat_ioctl_get_volume_label(struct inode *inode, char __user *arg)
5fc1746d68b8fb Ethan Ferguson 2026-02-10  157  {
5fc1746d68b8fb Ethan Ferguson 2026-02-10  158  	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
5fc1746d68b8fb Ethan Ferguson 2026-02-10  159  
5fc1746d68b8fb Ethan Ferguson 2026-02-10 @160  	return copy_to_user(arg, sbi->vol_label, MSDOS_NAME);

This should be:

	if (copy_to_user(arg, sbi->vol_label, MSDOS_NAME))
		return -EFAULT;

	return 0;

5fc1746d68b8fb Ethan Ferguson 2026-02-10  161  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


