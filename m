Return-Path: <linux-fsdevel+bounces-62727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F058B9F624
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D4884E36ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183C1E0E1F;
	Thu, 25 Sep 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LS/RvK34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C9192D68
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805071; cv=none; b=A0TmKm9tiMq9ZpYwXXn44AQewXjIke+qYAliZtR1cyf8utUm9FwaY68HIg0+bHdXrsfQywJGuIvvUpIdZprFBajB30CppSEkkU7qO9HOemDL8eoWuQL2vvIg3wHMjwsUO/dzFnU7TQWol4J+YerIEorKuNGNGpWPi+4+xXsg4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805071; c=relaxed/simple;
	bh=yqRVdubH37h8hWmC7kqYLwErx12ZOWePM6yRLZYw1sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=We4u112j5L8Mp4ForcRf/+5YI+/tkOv4BXkNCffUiakwLMA5eIfVO7/vcRO0WT5tH3ftWTmT+MBLdJl5av+LSbAcMiqa+Eg/mCI4//nJZgOaG2P3RfVO3Q5Q33G5Fs7M3dUf7N+nSMJPVDb09WRHhakHWg6ev56PjtdxHrZ79zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LS/RvK34; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so728708f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758805068; x=1759409868; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSOrOcZjsEYiB4r5hevw0TxvZrEhXxLgVltP1VR++9Y=;
        b=LS/RvK34Hz9YjIOOmH5/QBvTCEJ/KO0bLXAJ4vow1NkUnsjDd4xRGw32XTodmRtwGI
         ocUBvCxyFMOeLVWE1/nY7A0soEVOLNzce6EmVTIuccA6/UA+0wNWVqyNUQvez9xjXVs4
         bXAVgZWXxZGw1PIEYCGcH+C0PvdldB2FXUbEs3nAWTD8vVxc/knwK7E4kdNVW9mBaeyx
         tCatCopOaTnMHt8VRN7R/XlaHE++IfNNU0inxYG0IrEPo0cjtJgYflsyEgt8U0eiiVq/
         LoNj0OO880m/cyQBqSblsvLYtmMvs/Fw4Wiv+4JZ8nz/fpW7dB+1ZWU2Npt7j3Awli7v
         ahgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805068; x=1759409868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSOrOcZjsEYiB4r5hevw0TxvZrEhXxLgVltP1VR++9Y=;
        b=wyEs55AMmt597jR9HJbPFOvLsZj68GDiHLOhZ2FKpPz3jPQxQGQI/A8p64rU3ZheRt
         DJCw8PFCds8JG4n6gMIc3BKoR8YmMrOLLO3JK8L42uwe7I5HjU91cDFCFIa+ZmFYMqAO
         SvxOhpFItd+tKc3yVComcTfF5hWQB8+AA4BXlVg/yuGggISGy1cnZ1ntI6aYebD4rX9W
         N6LjBqLQ2gEoK+ewQGw/wjJU+SfuVWPg9AacxLjad1BbSOEB5OldTmCrL6ijOhLVpedV
         761tiecNxv3NDVaPUETZUaje8cI8tcbtzfZ/t6QSJHmgIzwmVybFIjfyKkRyIrxZSYdg
         U6Pg==
X-Gm-Message-State: AOJu0YxXVopKr7r+nuNR/yDXefQZv5TdkG9uCeQFE4ed+BfNZH3LOXBz
	4x9fnE2a4x6NcEIbvV7AgEyRUEdahgFCWPKMDx+Xxf58/ckxyhQZfCwSCBMKDtUKgAM+P5owUyX
	wfUaG
X-Gm-Gg: ASbGncsq+uDyLsr23ccgRc6TkDeyICCQviLnxiLU7b6rSTXQr8BxP8lXQAjWDXAXuIH
	Lp5riXrvlMSYooYnGxiEh17iKOz22t+PbVI9xLnUbvy8J5EtQdsuzH5B2rwZ1+qrT3Y6k/RNUfG
	X4l1xFmfEKUCk7SuA1GK7wzznmker3EaCjyTc5AfQ0xOu+wr3TbILdTdfqt+1eo+QXLzySULyLG
	RAImeeetVVvPWdoew0TJJF8NDT7oqS2r7P6cwA/rtOUGNdkCpD75TJxLyAG//zVWIvFov9V6vh8
	g8OB2F6mBRAvhVHOS4DM+FAdvazTTZTLj+u/MkFv4qNCItSYb0IbSECN940CI1iniDETwlcCtpc
	fSU7Wp99cQdipnegu9CseN20f9ajp
X-Google-Smtp-Source: AGHT+IHzVw4NPTyhZtlFOKXrQu2awTySUCXXXyRcZbxHeI3fKorx1BAUAl2P1APyjqwiZ0r8Hm2lJQ==
X-Received: by 2002:a05:6000:610:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-40e4ece5726mr2825349f8f.29.1758805067900;
        Thu, 25 Sep 2025 05:57:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb89fb19fsm3006452f8f.21.2025.09.25.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:57:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 15:57:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] listmount: don't call path_put() under namespace
 semaphore
Message-ID: <aNU8RzeIADNri07A@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit 59bfb6681680 ("listmount: don't call path_put() under
namespace semaphore") from Sep 19, 2025 (linux-next), leads to the
following Smatch static checker warning:

	fs/namespace.c:5939 __do_sys_listmount()
	warn: pointer dereferenced without being set 'kls.ns'

fs/namespace.c
  5903  static void __free_klistmount_free(const struct klistmount *kls)
  5904  {
  5905          path_put(&kls->root);
  5906          kvfree(kls->kmnt_ids);
  5907          mnt_ns_release(kls->ns);
  5908  }

[ snip ]

    5936 SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
    5937                 u64 __user *, mnt_ids, size_t, nr_mnt_ids, unsigned int, flags)
    5938 {
--> 5939         struct klistmount kls __free(klistmount_free) = {};
    5940         const size_t maxcount = 1000000;
    5941         struct mnt_id_req kreq;
    5942         ssize_t ret;
    5943 
    5944         if (flags & ~LISTMOUNT_REVERSE)
    5945                 return -EINVAL;

The __free_klistmount_free() function will dereference kls->ns when it
calls mnt_ns_release() but it's NULL on this path.

    5946 
    5947         /*
    5948          * If the mount namespace really has more than 1 million mounts the
    5949          * caller must iterate over the mount namespace (and reconsider their

regards,
dan carpenter

