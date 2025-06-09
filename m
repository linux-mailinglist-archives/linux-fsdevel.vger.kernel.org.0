Return-Path: <linux-fsdevel+bounces-51057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D0AD24B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF2116D46A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9121B9D6;
	Mon,  9 Jun 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLNzjMer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7A21B8EC;
	Mon,  9 Jun 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488799; cv=none; b=GqwCKqeQiKDkRFUA6eA441JzXOwXKZ8ePoVOrBuOi/PLxWpQBbifEZeH1GuEVCgwWEfgB29EoCLCw6jiTFeCV4Ub9nHbDBHL/WTTqB/LZix3sEHpQqWka/77FNQWkkn7X1ewz/zm6gbdQa/5NFzcElyEpGYF8BQDw61xrJOf6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488799; c=relaxed/simple;
	bh=xj2K0Hn1KyDlFCEgp/1ceXvAVXo0W7st5XQzYhwKR9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CnxxmDJxSwdxJVO982rTo1Ue8+XmFMovcIpQzWt+/PTdDM5DXADKosCDomChdsCXPWC2xRTsECPLQeeVboA/SFU7nMxbu9qATo/kLAeiZEw2B5cpdGJh7SOrYCupxIEnEBXARBt2nJWAk1JBPNMyAotUWm/JsuMfzNZuIXuxlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLNzjMer; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32a72cb7e4dso41897251fa.0;
        Mon, 09 Jun 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749488795; x=1750093595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1B9jz9bzgcDaYUJYbUm/nwrrVlRYLDHkUIDUm7vm5gA=;
        b=hLNzjMermV94bnjLDJWzFAkJeDRFiEbkvtoBWR9ReOLFuccxI3nJIJabYAWY7xYHKg
         iDsw5JoY2BtQpzobdMOycFhhBvcYaLcAahWcc1rEvAJ3LfhvEOlsNFDN+O8hj0bL3lhr
         HE920a38VZqO0TAvzHrql2lWA3OybBPAlYVBP34ir5iLJz+UFz/nl1Al4xFlOVlc6IEZ
         STUChNJM/mSAUZaVw0QJ+cvmx9NWAwoPVyLi60RNp1QRsfsTBrmZbgxxUgljbc77KCKN
         VF/7VrTR1uufdf9NTwTneGWdgIsipNy+O1ScD024x1tnoO9Dr1gW021BgkHZ7bZewhoy
         K3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749488795; x=1750093595;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B9jz9bzgcDaYUJYbUm/nwrrVlRYLDHkUIDUm7vm5gA=;
        b=b3Xax8+PLimCKAjH1hlgexxHDONMaL5iLZG3k06bGg5gVWSD8UM7X2HVwgqZA8BFEa
         z/s7G02bjiKzHaAlk/158AWe5mb0c09vBvx8LsE4UwubIweVh0Yd8mPmMjbR3nxfiqhw
         oEeR5GfEbCPW0mBjXLoMyiAZCMXJykbv5C6AbJUM0VwlPSjYdZ4z2CrHM+zeLyZFqTyU
         UOOgVesgeAnNYg7mtHSNdUMCIDetxC1OqsdUNfCoGnoBuwG7BmvtIU/22Z8OAfrdiUuZ
         QgK4m0KjnP7Vb0JrCdwL4c7UiW8fIdW7hUSVVvxQmY+aIerSV2qfCGwAnoAJ2CcLnr34
         gKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV90mtvXjiGzsaBNLcs/fjI751r1g+q8zRlbXHUPpOCYzughP68jBPduKSrFRspLbpGX2M3OWlruascxMJXsQ==@vger.kernel.org, AJvYcCVHPmDerc4bCUmd8ffcpDJ4lhwuPjj3CZ/acwLmUgDmmhUqkTJ4c1h/ryBluEhNMnCjFydNJF/CsOmm@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgHUA4BoSDj3u4M5EDBfTzwnAh6BVfsFin9SRlDDwUE5Q77R7
	EasSz/LFHsnNWobXFhJfY7Fzzq/Vd3Qh5ppUYp+3PWxdE/wCHNQOdxqd7BFtu0MOq+Ku0+ZyhVR
	FZ5dKYpyFqyk4nuLkp06xKDQJzQanf90=
X-Gm-Gg: ASbGnct0t5XWrT/HB/ByrKWVwwx1AKXNi1MVk/4BBWX9y2bpJ9XlrG9BlkAgl0BOQsk
	tPs29DRpaQKvQXdIHm+f3SfcA64h8NcRCCVSpJ+jCbORfysrIeQrXYSN0WuNrYVGbzCjjTg7nCH
	8kg1xJJjDeshtphoXUnr/DqhjMqnUKeNGj2DxXqx0PJh0NcVRbY0SW7WXOjqXirJUnkQ8=
X-Google-Smtp-Source: AGHT+IHs3x7MiIxf+cWKc7abiJCC9IsvRO7Ev/Vbmo9eLh43sdlNK0JojZJXE291FuxIFOvUsBhv2t2laasYz3xT+VM=
X-Received: by 2002:a05:651c:b12:b0:30b:f469:47ef with SMTP id
 38308e7fff4ca-32adfd207bbmr39463521fa.23.1749488795292; Mon, 09 Jun 2025
 10:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 9 Jun 2025 12:06:23 -0500
X-Gm-Features: AX0GCFsrRONFJpE2z-GNlrMZuis3d387b0I5W2Mqd7Xzluc394ppvLGirmBiFtE
Message-ID: <CAH2r5mu5SfBrdc2CFHwzft8=n9koPMk+Jzwpy-oUMx-wCRCesQ@mail.gmail.com>
Subject: Perf regression in 6.16-rc1 in generic/676 (readdir related)
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	NeilBrown <neil@brown.name>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Instead of the usual 10 to 12 minutes to run generic/676 (on all
kernels up to 6.15), we are now seeing 23-30 minutes to run
generic/676, much more than twice as slow.   It looks like this is due
to unnecessary revalidates now being sent to the fs (starting with
6.16-rc1 kernels) on every file in a directory, and is caused by
readdir.   Bharath was trying to isolate the commit that caused this,
but this recently merged series could be related:

06c567403ae5 Use try_lookup_noperm() instead of d_hash_and_lookup()
outside of VFS
fa6fe07d1536 VFS: rename lookup_one_len family to lookup_noperm and
remove permission check

Has anyone else noticed this perf regression?

For the case of cifs.ko mounts, it is easy to repro with generic/676.
And also could be reproduced with simple "ls" of large directories.

-- 
Thanks,

Steve

