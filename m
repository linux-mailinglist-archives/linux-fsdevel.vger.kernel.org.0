Return-Path: <linux-fsdevel+bounces-34229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE6B9C3F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B7E286F64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3D19F11F;
	Mon, 11 Nov 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gMPFyx47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4019EEC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330080; cv=none; b=hQpmlLuDHgCXVSvI2B+tKEwfD/tkXdpMAaYJmpXMevzaJT9mRoqvcivBJJYdAzpWm36HQTbiJ5HFau4WQEZ7IwnSiKL08CGlMDXjD/yG9Vt6KEZ5T420Xcu1EStRafljiWu1tufBaLjjwFMFJhpqfAyBKCq28Qu3bmRMZFysFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330080; c=relaxed/simple;
	bh=qf2AGztpw+7BETXwf7nDVTsN++k46rWO2VTfDVlLK5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivCvFOthCyd8/dFQJAlcyaqF/wI1eSqo7U6/DXttAuh2Qqsgu/8JqIKLbbTGEC/xRS2UfsDawjA8vEF0+ca/gghUCXK7XaylQYJxnpRssgXAAf8Jluv0+lfAdpvFk8rnFg9GfgSVCcVX6K/IxBGEFrrr1s117HHTdIjhYc6EWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gMPFyx47; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-718066adb47so2647773a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731330078; x=1731934878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7besB3ixSfCVoUejLs6eREEKOfBEP/PTYOw4wky3o0=;
        b=gMPFyx47VFMbD9Vr3lhPd2g2AtYLsA8xcjEsgGcjHLn8J/0YLIb5O9tDeW8d7R+PJb
         THtY5L0a0PnGsR7krLgYxNJIsPo+Sd45EejlJMX/aVMaaUkG2g/RWUKz7INh7HuQGpmj
         hiLd1ZL1JuZbi05AXZYSkSSBM6MbRD024I6uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330078; x=1731934878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7besB3ixSfCVoUejLs6eREEKOfBEP/PTYOw4wky3o0=;
        b=AdQ8NbjD0dELEGeapBsXcs462pmj8P0jP3PE9CEI/RFRWLR/Cs4ckgqXKS1pkicyVE
         aVLe9tcGMbSluB5qv2oFVNwcAZacmxJW4hE5QxXaSw5uxROVqU1HpkyIRTKzoggmIaAu
         Q0xpToKJ4RaeHKBYJ2Y9LQ2yhwBDu9lCyeupsAkyr8m7LtnMxyr3wREuUevs2XCmKWlQ
         ZkEfnjJj3MVqJWB5yUB9JdoxvSmUwthY/+yEObb3WkfJZsYvS12juNDsc+LQBGKwFyGO
         Db1hBoEZydExBLylOAkpOFBTESU1ajvmF/CEHZEh9lmEc8QxauUqBA38zJlVJoz0gjCD
         Zqxg==
X-Forwarded-Encrypted: i=1; AJvYcCVcnmoloKVoyrvCRLp152mvzHJo0tfeO+p8rYjpDFxPcv9nQ0w0EouBRvcnfHIE3/1vVPLeq+HKRnobw4fj@vger.kernel.org
X-Gm-Message-State: AOJu0YziBYY+nCLv7GSG9zyKpKMSMiOTBBHa3gxYRhodWBjfvo8B5NAg
	XDiyphiBruJ9/wlJdoDJDX/wDsKD7kYXXxTf1aUcDmAy9g6Zabfyga8J7s9BjQ8vZxdDhBV+c9w
	Zx4R2WL59AtQ2tpj55HNeLPMFxfpMLlL6RP11pw==
X-Google-Smtp-Source: AGHT+IGTNR7cGBhWbfaR8/LY/XXbZYRnyStViZVZY5OqBZJ63cOBmilCgtJZBZNhHUm6JzzZgO5iJKLQ4tdLfRc1bTM=
X-Received: by 2002:a05:6830:6c10:b0:710:f3cb:5b9d with SMTP id
 46e09a7af769-71a1c298638mr10012904a34.24.1731330077736; Mon, 11 Nov 2024
 05:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241107-statmount-v3-1-da5b9744c121@kernel.org> <CAJfpegsdyZzqj52RS=T-tCyfKM9za2ViFkni5cwy1cVhNBO7JA@mail.gmail.com>
 <de09d7f38923ed3db6050153f9c5279ebae8a4e6.camel@kernel.org>
In-Reply-To: <de09d7f38923ed3db6050153f9c5279ebae8a4e6.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 14:01:07 +0100
Message-ID: <CAJfpegszxKkuXu-7LibcL+40jYa2nsh5VL1_E2NkGr1+eN3Maw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: add the ability for statmount() to report the fs_subtype
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:28, Jeff Layton <jlayton@kernel.org> wrote:

> As far as I can tell, the existing cases in statmount_string() either
> always emit a string or an error code. If a string isn't emitted, then
> the two EOVERFLOW cases and the EAGAIN case can't happen, so I don't
> think this will result in any change in behavior for the existing code.

Both mnt_point and mnt_opts can be empty.

> The idea for statmount() was to add a statx() like interface. This is
> exactly how statx() works, so I don't think it ought to be any sort of
> surprise to anyone.

Maybe, but silently changing the interface is not okay.  At least make
it a separate patch.

> That said, if we did want to add a way to detect what flags are
> actually supported, we could just add a new STATMOUNT_SUPPORTED_FLAGS
> flag and add a field that holds a returned mask with all of the bits
> set that the kernel supports.

Yeah, that makes sense.

Thanks,
Miklos

