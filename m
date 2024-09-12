Return-Path: <linux-fsdevel+bounces-29140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19697651C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A99281BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2B19048D;
	Thu, 12 Sep 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0WH8nvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182D18EFED;
	Thu, 12 Sep 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131830; cv=none; b=QJcuvR9IJ10nHMhfzOkaNIb3jtNhQuX37U/UeLC0c4w0EWLeoksh0WMTqF+EXaYerfeD2AG7bPFnq8hGhIFo+8Rk/eQzDlhkVuNjWgF5ajEswJJgfqgQblThVEUWi2j25Iu3BvnnHwehoSmQS9TxVa7Db+K/hI7WcYTjB/vEaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131830; c=relaxed/simple;
	bh=HhpXaTt1FHv4GMgoC6Cc8mnPbpY0i4fq4rQkC7RWOZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onP3KWGiG9lcAGMqFgBJC2/275B9UJjbBBX7y6KVrLFgeOM5Y42YzwnW8K85hyhoCvmtzLlmKoxC77JAzeVeskv75r6WwtezPI6hk73HFwg7uQrT9O06gSbgFXE76WNyMMyXKh+C/LZXvuEkNAhWrONu7LSukt9IRmnq0SzORvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0WH8nvT; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so575984a91.3;
        Thu, 12 Sep 2024 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726131828; x=1726736628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhpXaTt1FHv4GMgoC6Cc8mnPbpY0i4fq4rQkC7RWOZ8=;
        b=l0WH8nvTym1QCXsh5qushSXhIO/5LhTcGrj0KU/m+NUUmGxbTuZtt9BAXSS+taGPml
         avNOt+jam7UPx3NV2azRHbVYpuI7HmgT8mcgqxAp2+GcKS3276knm8EKCL1/cnp37kqh
         f7IPDbWn2zUslas+REd0lKjOxqpOqE6rdSawU+33YevRyLLNsn29m92fufcXUs8YW2uc
         aWHbRbR+yB5FNuExQ+2C2qD2eqck/j1KPAjAViZoQuPV7YaWbX20D2hGqylve95xaKWM
         QD+aHSotsspac+9shkmnbPGgc7pcluRp9IeF4iwMvvgq2R9no41xKe0kcq6UZFQJ7R3P
         h4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131828; x=1726736628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhpXaTt1FHv4GMgoC6Cc8mnPbpY0i4fq4rQkC7RWOZ8=;
        b=bTdzmqdO8TS+GqvU65To92AJp5BQK8NXJvh756RZAgzKirxdZ2OM1QwTWKLeFrN0pl
         ch5/VRC1UK6Khajv43jURQSHRNU3n71bD+xokOjS8mYUenBE+F4sNJKt9Yh2GDrBmJZW
         T8GN/66Q6NWyGg0d6IwXIMSHehjRz3hXEqX36wXSG6HfHnb2IlWxUWpICBYdX17ikwAl
         8eymzJbsPnKUHBIS+VW9pbozwieNBKziSFqAStRRfg0fmsv/ArFNFbEYGJLYqm6hTUnp
         iimnMuS0dP25HRl+oGqkTkzoQPSJOBW8jFm7MInpou83XWMHGj1f1rkcwCnnXkeJcTXY
         7VLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXCSgr307xvm4HGMZXTWlyYq4PfX2CC2Im1T/gfuWq+963NTmyPjpNxUdxoA4EEdmL79kgMgUdC5+0efY8@vger.kernel.org, AJvYcCWyMDuO0TOUr6faFDB/j+1s6e5Pdy4dT7YNHXuxEqk5gfAKCLg8dlfGgea5Zg7o/PrtFQslS2WxxauY4AnY@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJ6FWofQ+afw+Z3zVOhekV4q2F23dUrslvZpuun4p3SuJtmh2
	wa1g/AYYCslDo41rbpL75N3EOzNvdKJOgqikXrc1Yu9WSd0/R3mcQDE49UNSOTnN9r6Yb1V9Bip
	7wPe91vtFNjj7kWWjYHtsctitIWM=
X-Google-Smtp-Source: AGHT+IEmUFvv5ATWibMOCTGFiMeUKzE4whzZv65lnQ7aMsvQ4FtzT+GYpYIzqECgbJdZkICGbzo1wO2QfWGkbeiwNUY=
X-Received: by 2002:a17:90b:3686:b0:2d8:82da:2627 with SMTP id
 98e67ed59e1d1-2dba0061bc6mr2512832a91.27.1726131828132; Thu, 12 Sep 2024
 02:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912031932.1161-1-ganjie182@gmail.com> <20240912065737.GA7455@lst.de>
In-Reply-To: <20240912065737.GA7455@lst.de>
From: =?UTF-8?B?5bmy5o23?= <ganjie182@gmail.com>
Date: Thu, 12 Sep 2024 17:03:36 +0800
Message-ID: <CAKG3ji1vioBmvpRDRke5Z6vLR6PKa6Y98up38=3hL50iRs27Yg@mail.gmail.com>
Subject: Re: [PATCH v2] unicode: change the reference of database file
To: Christoph Hellwig <hch@lst.de>
Cc: krisman@kernel.org, krisman@suse.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, guoxuenan@huawei.com, guoxuenan@huaweicloud.com, 
	=?UTF-8?B?5bmy5o23?= <ganjie182@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!


Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B49=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B 14:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

