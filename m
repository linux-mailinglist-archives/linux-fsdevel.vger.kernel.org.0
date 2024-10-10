Return-Path: <linux-fsdevel+bounces-31534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35F99844F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07BD284FA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1061C2445;
	Thu, 10 Oct 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po7crnSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825AA1C245C;
	Thu, 10 Oct 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558033; cv=none; b=E7nHoTHSSoWhXPi2Z45hdFtvTRJBFaBN9IpCXDU6/D0nhexMDilNf8DyStCGtcNKviwjI1MGW8Xx0o01zfHCXTHBQcgFqhIXrwnBV11hatSOWB6TGJkyMqUHgk0HG14IIBW6FpGa32ANqRSthOnn9h5UFQtRrkrb+wFBK6YjTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558033; c=relaxed/simple;
	bh=f6kBOvXqEEvA0RSqMTbMkrWDSbziBuOzQ1mA4xkEcrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXuZemd0nRQ0hiDs4uIlioEvJjUqq7x7XXN4MP+pZGg2GhXKtCirqLPvrITaivWPAtySo0YRH8k1AUxi4V6ncHILBbDqhq7IzsWyIHG5/n2md7gDk3IFWuT9Kf8vEfaV1y66/qTEba5rLAjvzR9obv0PTW6qFWorDGBVuRxVVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po7crnSw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71df7632055so787574b3a.3;
        Thu, 10 Oct 2024 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728558031; x=1729162831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6kBOvXqEEvA0RSqMTbMkrWDSbziBuOzQ1mA4xkEcrI=;
        b=Po7crnSw5zzW9IwZLydqKmZrjCsqTN8+sPiH/RTU3OH3F9jX+VpAMJ9D2G/73EYOrC
         M6AAU6tOR1FurRsNnNGXEzua7XyjiP3w5tSgKG9/Dcqh8TcqrNLxA2a3RsZLtjA0/+5l
         IZrt8IbusQdxSTCk3pvbG2Lpm3czbVuHMzbLkUeHBtCSJss1Rr3Lo0d+fdE+1RRQWYjo
         12AuXI7UvpDtOClyWIhBzNtZeTuGxCmKbPK2fObZjJvIuw1kyKn9DB0OfGeB7fEIBSHn
         4yjhMySBsnh54fvnICK+lOJTql/fu2BIRI9aFAppLdJXsXzWpwFA9Qbgi6p6TyiHK8Iz
         cxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558031; x=1729162831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6kBOvXqEEvA0RSqMTbMkrWDSbziBuOzQ1mA4xkEcrI=;
        b=G59FnQjvkx4x0EONEB8Xwf4yIexE/kYzPmBwJpC6jq1OUlBz7bj0r8hNHJiUrW13od
         VGOe0hTNVPWiQqfAXfNYrByFyJpCfoOxftROWt/AB6f77S0HrpS1B8/YqOIQHZMoxrDg
         AGsDYDahxqy2ZkLRoZWz+/BExrK9z6GVJAxpswmVVnt/GdTH3B6PWsay8bcU7C5eaTSa
         gkb0vHSAbbALD+g7MyvhYitsO+LExvpE9M+dnQ1mvZl28p7b1DMiSKMNLHPhRqwbmOMG
         8+rSBCEGjXQXW64VWXsKIuYEBd527IPirSNfRRdcDg8iSndPW3pYhB9ccJZb4cJPuC58
         mNuA==
X-Forwarded-Encrypted: i=1; AJvYcCU3uhxGSbTv0G6OHmWU6loImuL6fhp4OiPvUtDVB4R/czrdz36QP8X2PlkDau6Y0DsE9ijYM5K+h4ccGC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqWmSzr9pBi3L2pkpMz/AKTVnvzOONfy1vRPQWMpvDZp1BtUw
	jT8qF5Kyy+p9eK3yOf65HJW3t8t+S85Y92kOI+yJtqA3iKIhkMP8WDQ8vkOAZ3Y=
X-Google-Smtp-Source: AGHT+IFlu5uf1Qiom8RsM+Bq8DEd5QG73nk7g1rcmg6YkaP8ggiuvYyIBezZvNEv3/eWA8PBix4Qug==
X-Received: by 2002:a05:6a00:2e8f:b0:71e:9a8:2b9d with SMTP id d2e1a72fcca58-71e1dbce0c4mr9978027b3a.23.1728558030276;
        Thu, 10 Oct 2024 04:00:30 -0700 (PDT)
Received: from localhost.localdomain ([47.76.200.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aafd100sm805625b3a.190.2024.10.10.04.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:00:29 -0700 (PDT)
From: lei lu <llfamsec@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev
Subject: Re: [PATCH 3/6] fs/ntfs3: Sequential field availability check in mi_enum_attr()
Date: Thu, 10 Oct 2024 19:00:05 +0800
Message-Id: <20241010110005.42792-1-llfamsec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001090104.15313-4-almaz.alexandrovich@paragon-software.com>
References: <20241001090104.15313-4-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Konstantin,

Refer to: https://lore.kernel.org/ntfs3/20240820105342.79788-1-llfamsec@gmail.com/T/#t.

In https://github.com/Paragon-Software-Group/linux-ntfs3/blob/master/fs/ntfs3/record.c#L267.
The code did not check the 'non_res' field. If asize is just 8 bytes, it still trigger OOB.
So I added "if (asize < SIZEOF_RESIDENT)" before accessing the 'non_res'. Because
SIZEOF_RESIDENT is smaller than SIZEOF_NONRESIDENT which seems to be the minimum size of
attr. Or maybe we can use "if (off + 9 > used)" directly.

Thanks,
LL

