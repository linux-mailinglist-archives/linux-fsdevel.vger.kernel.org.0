Return-Path: <linux-fsdevel+bounces-41826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BAA37CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E032E16C5A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E74192D68;
	Mon, 17 Feb 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUXu35ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760D17B506
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779601; cv=none; b=FTC/8w3SMzJLsqMAE3V0OthteynvvrvOe6WNdDwim5JGCz6Osj7s++9ro7upOGwsK6B59WOh0L1E77NSAOeVOBc2lxWc0wKj3iVKrIFVXo7RdBlZx+GFpbgadt5VX1HaFRTKb52mBhsQMYbdO1isDggdDov2cUClHNwj/BvET6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779601; c=relaxed/simple;
	bh=jrVfYsmoxxxgXyXm1/1tTcpeKRnPQmuuSiRodj4K4lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AdEzhZ13drP7mSu6Q6+GE+pviejaarOxSUTFhkDz6ycAT4qRMxk2F/nsKTRcHgRTpQaMnmTjgY2dz3DUmEO4P5dSg/JBiCm6ZHmV/WqiX0TyRb1CxXaVjKDvwN79qthOc5w+kBhGYSeWDYRkZNLKPx2G4UDYzsYb/q4zfyS+nFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUXu35ES; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso798171566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739779598; x=1740384398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+wor3t93gx64vFLIuBj4bwezFq3RPX8liWEMPu2USk=;
        b=wUXu35ES/e32LP2CIbwgm6WOYDu9vTqfV1+4WK15c/fMueiKKDNX6DxPcBmS/MhXFG
         MEpiP2pgw5G/B7IWUQmDDc23wh3ZIfyVJKDrxOV81XwTkVDiHbclB2MKp+nzQnBGRE/V
         T0rkZhQu7mMN7FiFpRqIBcqoM9pIGIjm4V3FF0D5vwgG9ygK8wN8omzuL+hvUWVXwAhP
         2AcWfcZTnQc7+ZtJ9HNKx+lK6wwHSv2ybWMQP/Fd2+tDC9HxZ2Y74pEvTR4vkcEtzfCR
         KFY1I5YdPVqHP32bH/TKAY0GREdGA05F/mdtHz1T63HMSAVdcdGrB26h+JjJq/pPhdZ5
         SHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779598; x=1740384398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+wor3t93gx64vFLIuBj4bwezFq3RPX8liWEMPu2USk=;
        b=w/+Cr5I7D7oMsr9M+rfRmPJywf42zzJxbgZMcMh12YbcVufNsjcn+34V5rja4oRNeQ
         MDQUeMmSzgPiaifZETd4OvMjBlgdfcHU0FaKE5k3gxIy0vD7YD4KhiJifkf/DX6RbJvm
         H+tS6QDyvznoKG7CbO7Fr1LuPzDDJ5BZ+bbhDI+03K0dbxSAerqnziRLByo+UIxquItd
         SWa/L2RSlFLO7NnAc5bjYEnQy1C+n5q8HN0+icE5+mlc3FQq4Xow3Sm6jCkM5iF/tQSn
         /aTKfqDuAIYeblKiN34E4ZMFvIHVanq/J0MJyYqRa7WL49eDVrvzyvYdecsyvMyuI9kl
         L7yA==
X-Gm-Message-State: AOJu0YwkCulJxf3zTpJDAVGI3UNKhuiQxTpY60pDSEjqxqwkLlu1kmxr
	BvFl3nZp37s/aOzn5lekgkXHx8zc80TBFZMsieOqyRnkrk7F72LZiYanSS5OaQo=
X-Gm-Gg: ASbGnctzVuiuxgFnFmcfbE7GPFlzSQ56LeKfcqxWyM8S7ejKgyWrKOI9EtvESO17RMQ
	8iMa+GqKO7w+BjTrJ0iyNuaDD7coREytBez6YIjro7apTDP4J57hb0K/65sNHdiR2CqusmK8AAR
	wljn5QuBWpG8eSrQ3zZNc/P90cS/5XFfm8+bufcWqacZvFfeuj20WLR8OquReq9aOzSvOKBUFL0
	H2oQVD81AkLyWP5f6lZk9MIFG+9ne6D4cuzT10pliI36Xept4Ga0kRf1rSrM302yWhXo+GEa6qO
	O/LpVShn637FGZiaGP9w
X-Google-Smtp-Source: AGHT+IHAssGsRp9dn9tl4FZftITB1Knr9ENETCNcyaFpO/gq8+nZajZOcH6F6DK5be3SF9FCYdjG2A==
X-Received: by 2002:a17:906:f0c9:b0:abb:a88d:ddaf with SMTP id a640c23a62f3a-abba88dde9cmr80774066b.55.1739779597846;
        Mon, 17 Feb 2025 00:06:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba532322b9sm842642966b.37.2025.02.17.00.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:06:37 -0800 (PST)
Date: Mon, 17 Feb 2025 11:06:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] VFS: add common error checks to lookup_one_qstr_excl()
Message-ID: <2037958b-8b1a-4355-be22-294b782aac31@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello NeilBrown,

Commit 22d9d5e93d0e ("VFS: add common error checks to
lookup_one_qstr_excl()") from Feb 7, 2025 (linux-next), leads to the
following Smatch static checker warning:

	fs/namei.c:1696 lookup_one_qstr_excl()
	error: 'dentry' dereferencing possible ERR_PTR()

fs/namei.c
  1671  struct dentry *lookup_one_qstr_excl(const struct qstr *name,
  1672                                      struct dentry *base,
  1673                                      unsigned int flags)
  1674  {
  1675          struct dentry *dentry = lookup_dcache(name, base, flags);
  1676          struct dentry *old;
  1677          struct inode *dir = base->d_inode;
  1678  
  1679          if (dentry)
  1680                  goto found;

It looks like lookup_dcache() can return both error pointers and NULL.

  1681  
  1682          /* Don't create child dentry for a dead directory. */
  1683          if (unlikely(IS_DEADDIR(dir)))
  1684                  return ERR_PTR(-ENOENT);
  1685  
  1686          dentry = d_alloc(base, name);
  1687          if (unlikely(!dentry))
  1688                  return ERR_PTR(-ENOMEM);
  1689  
  1690          old = dir->i_op->lookup(dir, dentry, flags);
  1691          if (unlikely(old)) {
  1692                  dput(dentry);
  1693                  dentry = old;
  1694          }
  1695  found:
  1696          if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
                                  ^^^^^^
Unchecked dereference.

  1697                  dput(dentry);
  1698                  return ERR_PTR(-ENOENT);
  1699          }
  1700          if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
  1701                  dput(dentry);
  1702                  return ERR_PTR(-EEXIST);
  1703          }
  1704          return dentry;
  1705  }

regards,
dan carpenter

