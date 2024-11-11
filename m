Return-Path: <linux-fsdevel+bounces-34231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60C9C3F59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA87282A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7B19CC0F;
	Mon, 11 Nov 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZDw7BRB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC636158558
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330750; cv=none; b=VJk/aoI03ocITfrxaS/mQP7lZjVUfWr49VY/yEmKopC/LU2mePYfRGDdliX9Lxxk34u1tZIIMneFQQrApZLmrnWoYscVV+y9bN2JbgzTvqU8FtT5F14DEGo0A7YnqMDlakWY/Eu53Xb94ltOGdA6FcMfq/n/RDHiipNZS92KS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330750; c=relaxed/simple;
	bh=D2sNexp7slJwYSd6hDXRtlFmvoZNaCK79b0+8tZJkbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJB7R4+czUEgnGfAaqIiAvCYw72wpGSIZ65oTh4JoZHWlnm6hnELccZCoKSc/CvycdLxgdzAGAksc8kXQaRYIy1x/G/RX8y8kTAl/KIo3e0FfMAm4U1Mt1crjT3D8UsjEeBGodVjTxYMIw43HRj4L5CrFPj4l/miMX5LmvTp0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZDw7BRB6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b04e4b1cso34133231cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 05:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731330747; x=1731935547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4u19Y7FF85sW/U7lX/PlUeuX1S1ok91rVbZj+THWSOA=;
        b=ZDw7BRB6RnQeBxje8MxJssTfs9Bk9H1u+jWOniwa2nF/JJPeQw1dICUVDIqp2HJfa+
         n5nkGB1eku1uQNgIigJaPvF+q8RCP2uvPdQOPjYy2s8WBlZoJk9z4EqxbYuzHb+1jSU7
         kMBtbICntQdVPfZza552eemJPGQSQWpKR88oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731330747; x=1731935547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u19Y7FF85sW/U7lX/PlUeuX1S1ok91rVbZj+THWSOA=;
        b=D7cgI+/Jy3HuI/EXQAEBz+5654jvOt04cigsPSGt9Z7K1avm/EJkJVX92Tp2/vcUfQ
         +4WblXhTISsPTfUrJbnLKwY6ziCJ0lM8P1GjV0SM5gdYvtNxwOUIBuM0WAT+Qyvu9I8r
         VePSI98neVHuntlnNIWhCGIpCKtYWAewke7al9c2mfg6uVJUBA5LtyNEYCarKfb1npF7
         ey+A1CrOu8a048NHnu2A/HF25m/6U7rvkJPBlj+8gwUgO8EZmZGwW6+wHL5U3NfcQT6z
         5QDwf08nepEXB3xo0N6nZBJK8RshFmT590V9Q0ihmF271y2K+I003D6YS4g5KOa7z/yY
         MLlA==
X-Forwarded-Encrypted: i=1; AJvYcCUKvlbJ3j1C3WBCTSs6KBVuETWA0ffXSgFQbdIX7ERsNbI+mf5cuyfp53xMRzOdLyiqSoeRpOAvYxRmWQbv@vger.kernel.org
X-Gm-Message-State: AOJu0YxzccReTLthmqIMjPA5/HsWwM7TD2qpSPSPtf2ExS+yo6PIo0K/
	SFzC1K9pv0pMu5mj1gctEK8kjafnw6XXysdAFlmHOxbrO6vAOVbke2HKwlJRBllnHvCGfeepMO8
	dDXEKa8NnRvRwb+V0xkWOZVxZDSd4izWbuDr4bpcJErZHcwKO
X-Google-Smtp-Source: AGHT+IGUNHvaV62QwimnEqMMwaunpgSfzZUB3avRycGBdXI3ehOhvyXfdT82AypKy2UdNEI7ts6+ruPk1RBV1lcWYgs=
X-Received: by 2002:a05:622a:2b47:b0:461:646c:b8fc with SMTP id
 d75a77b69052e-463093837f0mr212626131cf.23.1731330747370; Mon, 11 Nov 2024
 05:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719257716.git.josef@toxicpanda.com> <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting> <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner> <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting> <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
In-Reply-To: <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 14:12:16 +0100
Message-ID: <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
To: Josef Bacik <josef@toxicpanda.com>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 14:23, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 25 Jun 2024 at 16:18, Josef Bacik <josef@toxicpanda.com> wrote:
>
> > But that means getting the buffer, and going back through it and replacing every
> > ',' with a '\0', because I'm sure as hell not going and changing all of our
> > ->show_options() callbacks to not put in a ','.
> >
> > Is this the direction we want to go?
>
> IMO yes.  Having a clean interface is much more important than doing
> slightly less processing on the kernel side (which would likely be
> done anyway on the user side).

So I went for an extended leave, and this interface was merged in the
meantime with much to be desired.

The options are presented just the same as in /proc/self/mountinfo
(just the standard options left out).  And that has all the same
problems:

 - options can't contain commas (this causes much headache for
overlayfs which has filenames in its options)

 - to allow the result to be consumed by fsconfig() for example
options need to be unescaped

 - mnt_opts is confusing, since these are *not* mount options, these
are super block options.

This patchset was apparently hurried through without much thought and
review, and what review I did provide was ignored.  So I'm
frustrated, but not sure what if anything can be done at this point,
since the interface went live in the last release and changing it
would probably break things...

Thanks,
Miklos

