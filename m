Return-Path: <linux-fsdevel+bounces-14653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA587DFA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 20:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2441C20A4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB301EB35;
	Sun, 17 Mar 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Aub+JpWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251F1EA6E
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703907; cv=none; b=iL9gS7Ak43D3IfBeEDTsC9U4iCxyoOrZUdm4V4rTQxZ/V3BZhQXLju7uSEXr7T+0yqcIne73xv+xrsnTXbEJCJrBQvdy8frd8XN4/IawzX6n6Uyed4t6GzGZlH0Glt0XcHUo9JaxL+EmRP7ycax1qachE6Zkw11fMoRrUx7mZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703907; c=relaxed/simple;
	bh=DJ0W0MfHIlhRxfIwUAgwQ8iGh1XfMzdA1SsJPafgRi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyItK1tJI3gLKUsLRhS65oOxqIisZvrx/StLO/c172vuiklpx//Q+9lDBonsXLonrZXtyrZF4MLBjZz0d6qr+/wx9jmJ6oSWd8EJo5BmweqkVCzaWTOTBkDaKFrS9MeRq2vKqmc//iIIeRVQIC0HjeysUFzRa/g4+ejz6UAmqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Aub+JpWv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d4a901e284so6914291fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710703902; x=1711308702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3y2hg4ZyRpv30cFMK//46FtjrgjHYwkZuj/6O1YdtmQ=;
        b=Aub+JpWvWAPr8hNDgMEWTXvoSYAYJqO72CghVVmDK4F4zI+SeKpx6vKJqU3iW/A+Rb
         6bMvtSvC4oM/k0oXDD667R0wkKthkJloFGJZIys3MySSH++i/QUw7TfpmlkofwI5Vkvq
         ZPVHZvSuuqz1FIW6WBAESQJorbVFFJtKirJ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703902; x=1711308702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y2hg4ZyRpv30cFMK//46FtjrgjHYwkZuj/6O1YdtmQ=;
        b=BMgStOz2UxpRa2hs/ZSTox5II3BMlB/yF/m6TqH8Bqfzk35hiwWw+aWVs6wQcbb4fo
         njdp5fHZo4qV0hUG0/DZzbf/bTCxjDl319bgcheBU7g92e3iKoa8scMfiOuY4GuRSFa2
         si5IbkvDu57uD25ZV6i8wxt6X8qLryaVrG7o2UMU5VMGmWGEtO2ZUjWkKaJT2KTwoY8N
         j1iDyuVm+gN3+UUKObgCa9GW5ww/myd3wxXriU6xLBh+owUiX1a9eeE4mTyzUGIYv0xl
         5N7RFCfR1IZsDtg1mLR3IvyCHYOXEFO7NxOcQAQ8zSdt+qJ9xSQjaawlLs6xLfbYb+4d
         GGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAQhDKoqtl/ao3syLjSOXsyBJkLcKXM6ceoznuini8BhcMX4w0d1zNARmJ4KbmEHE9npIWlbEqfwwafULyR6MePBNCdY/YOlvpslIbpw==
X-Gm-Message-State: AOJu0YyB8jlGs9dq8tMxtFq4AMxGRyaKIMUGcJbLxSdmk7usWyJIQheb
	xcFVWoGMYiDfcBYYCu50FtQabU5TH0jIaNyvRlypOX+DuZ3tRV6iRb8ZoKDQQjf9s1VThbS6n0e
	euiHHb/EHdRK/NMh6D3AYG3qLHNxOf7KOJF/xlA==
X-Google-Smtp-Source: AGHT+IHSpPkfD2nECCHhtHvDbIfIiHa174/13dCy6M+TXGiQCSFGzgEXON8HlqygRCxZWGkkuSyQhEdfsdwYRm7olm4=
X-Received: by 2002:a2e:7d0b:0:b0:2d4:3078:ef3d with SMTP id
 y11-20020a2e7d0b000000b002d43078ef3dmr3891095ljc.1.1710703901993; Sun, 17 Mar
 2024 12:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
 <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
 <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com> <CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 17 Mar 2024 20:31:30 +0100
Message-ID: <CAJfpegv9ze_Kk0ZE-EmppfaQWc_U7Sgqg7a0PH2szgRWFBpHig@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Mar 2024 at 14:54, Amir Goldstein <amir73il@gmail.com> wrote:>

> I see that you decided to drop the waiting for parallel dio logic
> in the final version. Decided to simply or found a problem?

I don't think I dropped this.  Which one are you thinking?

> Also, FUSE passthrough patch 9/9 ("fuse: auto-invalidate inode
> attributes in passthrough mode") was not included in the final version,
> so these fstests are failing on non uptodate size/mtime/ctime after
> mapped write:
>
> Failures: generic/080 generic/120 generic/207 generic/215
>
> Was it left out by mistake or for a reason?

Yes, this was deliberate.  For plain read/write it's simply
unnecessary, since it should get 100% hit rate on the c/mtime tests.

For mmap we do need something, and that something might be best done
by looking at backing inode times.  But even in that case I'd just
compare the times from a previous version of the backing inode to the
current version, instead of comparing with the cached values.

Thanks,
Miklos

