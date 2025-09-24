Return-Path: <linux-fsdevel+bounces-62659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A97B9B77E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A04C75E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219C3191D7;
	Wed, 24 Sep 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Zw2ZP6mR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA954204E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738014; cv=none; b=idR1cMQLtv1stfsDMsW/gE4Mw3q+QN3WRmO1ZfIPj58uDbYV4iMnksZt3W+dP1G98dj7yYRZhmsUXxoisJk1J0ToULQJ+BscBhMseogSWGbODeenpU0OHKD7uG8tz1QREnUEfx67cXUUzCnV5V9+8tYIqLeK+J0ZAMcFfg0DTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738014; c=relaxed/simple;
	bh=in4E9Zy7xpVBsAfOLZXbK6+byp20GDDNd5NfcfkBLaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prTr4nI2FBm9Pc6U64L3dw4DGSYmnt0x3S/1twyvMpmA4yDk9QtO+oH7hnLo67n1KyLE35cm+sd75IlwlL/b/J22E2/z6XV3hz00TbqH65ZtHXQDpXsfiV7W+4YjJkzGC+KC3uW3jX+uGLGjos2d1B+AYlW5DUqjTXdxKfwFQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Zw2ZP6mR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d5600e1601so1487411cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758738011; x=1759342811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmTAftI+F8KaR7MC4oKydNJ8CmVuQGfS7o64XcGJhKU=;
        b=Zw2ZP6mRtyeiWNnn4dY66S9bOcA41HxPOzeT0b0CgbNxtltr3SJTpq/t+Iw5xn843p
         lXgSexqtGjbkpGQn+OS9Vm4yDaXQjbP/D9UkqcgprXiCen6a0CeGlEQi7AlkpWrbHsuW
         PvH1MoAUOUfT1yrfG2ja9WmbMfE/7Y7YALntk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738011; x=1759342811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmTAftI+F8KaR7MC4oKydNJ8CmVuQGfS7o64XcGJhKU=;
        b=Kbsh69e+oANg3aqf9uUCMWvaIA6xmFJ7echLd5pOxQoT2XVlGTaWrh69w7iPKeQ4lP
         p2YDTLFWOXbLt4AU7Tent5JTKDT/80snDLmNSb4WuUsyg8+7ymL6cszIhLPA3dcBclFq
         D2adFTysX+tjrGz2lW5wSu14c1/G3Rz7jQNDjK5WFxQZcUu6MMKxtpLPgnTJjfnEZrQ6
         1rtXSHxSQI50L9x0XvSoCl6f7SqenebdyIhsB3T2WROAvA9zXA5eamUiaq5fV4GbUvWN
         IJEyIT60JNFR6LcUVWsApyxo/sVpEuQSyJOMM/lbor2NezdjFUHwTUkdrNR1+YGEMzG8
         UCxg==
X-Forwarded-Encrypted: i=1; AJvYcCWYU+IAFUhquOIkDD6Lp6Do/yLuoOXIwCb9R3gB5QFLZqb65X1dGFdvFyLdPn4/kMdkV+E3BLIfSDMoe7nF@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqveQ7ppa0vAGOADks+h4kbTy5Va14696t69MMSkiRd53d7g+
	uprbPSwmdoneHOPOQ1EckXLRXepxec7v3kYsCJTEL+6L4E2mKiODqaqwePoI0gveWMYuNb3TLga
	K0B7/FKe87os06ATObZOVU5ujwaXp28yuvM9+u/avkktlLkBPga0B
X-Gm-Gg: ASbGncu3ytzAV7V5sotwS3124b0Sf3y7aaQzhnQ3HPKgw8gwG3WVviwFJigl4bJjSTz
	AUFaqascMOc5mB3TFLMwwYN+BQuxx8sKBnd9khVwlEu8T9Q376P19Nm0xfYzVsggp/jHuK1ctdb
	Wah13DAq4nBmawB8hpZsG2cpGcZsvfZ8ZaRDsrAO6iHgkURxQjtOYTWd/UnuAKvx0q4CbNIZvXz
	IUFHEUKwsM7vkOcuudNmWekKEN2otzmcGIzGww=
X-Google-Smtp-Source: AGHT+IFCS3aRGOSPFq/ffzM3/aUmf9cNgMpAiKVROWLsGxrredHR+u7VOu4bDwcet3MUoIXA9txucy+lTipv1Ouq8dQ=
X-Received: by 2002:a05:622a:1910:b0:4b6:3457:89c7 with SMTP id
 d75a77b69052e-4da4c965644mr10314021cf.65.1758738011012; Wed, 24 Sep 2025
 11:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs> <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
 <20250923205936.GI1587915@frogsfrogsfrogs> <20250923223447.GJ1587915@frogsfrogsfrogs>
 <CAJfpegthiP32O=O5O8eAEjYbY2sAJ1SFA0nS8NGjM85YvWBNuA@mail.gmail.com> <20250924175056.GO8117@frogsfrogsfrogs>
In-Reply-To: <20250924175056.GO8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Sep 2025 20:19:59 +0200
X-Gm-Features: AS18NWA-kQ3V8sAm81Y8PKVDIY-0we2Ockkdd9JTU5D665LNDwEU9YZHQNvE_Ag
Message-ID: <CAJfpegsCBnwXY8BcnJkSj0oVjd-gHUAoJFssNjrd3RL_3Dr3Xw@mail.gmail.com>
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 19:50, Darrick J. Wong <djwong@kernel.org> wrote:

> The wait_event_timeout() loop causes the process to schedule at least
> once per second, which avoids the "blocked for more than..." warning.
> Since the process actually does go to sleep, it's not necessary to touch
> the softlockup watchdog because we're not preventing another process
> from being scheduled on a CPU.

To be clear, this triggers because no RELEASE reply is received for
more than 20 seconds?  That sounds weird.  What is the server doing
all that time?

If a reply *is* received, then the task doing the umount should have
woken up (to check fc->num_waiting), which would have prevented the
hung task warning.

What am I missing?

Thanks,
Miklos

