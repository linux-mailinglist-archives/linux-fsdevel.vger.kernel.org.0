Return-Path: <linux-fsdevel+bounces-47727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0EFAA4E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D053BA38F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B025DCF6;
	Wed, 30 Apr 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="VXciOxw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31821EB5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023297; cv=none; b=eIGVhK416cMkf3DjEHE8jw18eLpvF0B4ApKqQmEX+YDrlOhuMIGCSbziKbQB8eKPjZxlsV11KakKNc5DnGGdRKXnnMAiVmnDW7G/wOgnQImZetziWD58WTDSUsI+Y5QpRUhWza+VZxOjhX/hS8/tNk4WU5BBh8VfLoUTSgL3QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023297; c=relaxed/simple;
	bh=cMjp9EwfF8FKtzoDA3M+vdK98csj97Ua8WVg0Z9vB+0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rsfGqEYa1Iw2Pe2y57/LyP80nlehYHANfNYlU69KB/5HP5ZDuILmfw0BvdWgm18/cj7gtU+go5FgU07erQCEJPMy8EYpk0MzBoJU1LF+7l0VZnGl7mpkYYLfkZRPjr6VUMXei+kD9LqlozNW07VN6MSjhxS8oEPYBqBW5UYgW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=VXciOxw7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736b0c68092so6466903b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1746023295; x=1746628095; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckRJwiE80GpbTdhGR6RTJVcs5AWFo4YBOMv1QiZ+lTM=;
        b=VXciOxw7TiSNfwcIQI+v94eQa8Hkwp69mBDPbeZZJM7K/HFBwIHoAkgC0qeXToy4qB
         CW7heMHkSC5uvS0Y3BtbuGQFWs777F7V2BZYLqP36CYypT0G/kzmAKEtvMPzu6jnWhkq
         YlIGQ5JZsDcej1d1C/vS106GNrScsXvRV9SGKs2o0YJljF8QQF9UPzfjvQ8nsWII5pR2
         q2UE+F2PodoyiyV8Lj71rgwkxl17mwxKy/skF2TgsfH0YlXX27yX+ByWFVI6pTn9xYa+
         O3rlqcC8xEaSOcEDfkoLbfn7ufjdLElGVTUU6pzVEd/xrzkQZv0YAUchah4H0W2hBvPL
         OW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023295; x=1746628095;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckRJwiE80GpbTdhGR6RTJVcs5AWFo4YBOMv1QiZ+lTM=;
        b=XLnqSaNludMO1VMAL/+KfmF6aDyA5tuZSKNHyXWD1D5C7rihuSp4ruhyE6H6bn2KGE
         dzvV+4+KEdjjMkdVeRbrX0mukNDmJgxtcO+zLUeQPCaE1ufHh21qfofW5Ay0OO4d0jZk
         vaVT724Bb/yrIVQcQt0d4s6/9WsErCuBYYJFvQ9MWcgC34ZHYJXM1TjDjjGPoJdB4ds7
         1snby2K6+GHREqG/7SbicddOyvQzlzNrxybmVIut6oc8/HPS97B13wxLY1b8KmjPcd25
         ifgHfvM7Y8B5wcPsuzdWCclA+JnLqtAGbB/yqv9t9CcdaQUJ0KmtDf2CM+tX0/fuYX7d
         Ys4A==
X-Gm-Message-State: AOJu0YwdjZQSUaI06TO4XFpQEkZ6CHw+wttGBeMv/8Ax7fEKGmdJwMWz
	uozPGzUKPiv3yWbzIrJ5b/k7Ra3pJRhM8yNwenYe1TouRLIupNkq3KqeIBImPv9jbj7cB69ESZS
	VXt7ndYvZuzfMsqJ0meapkpfOElJJDGImzcy4NrHqwFOWz43pMg==
X-Gm-Gg: ASbGncssISHbcPfPagHPD1kmT2oxVhFksC0mRx6IfRunlQL1XpaeUCyG2cneGglouup
	wR3wk0P/2/aUdb10KisKwoslIHnkWrxbVKrgNhu77dRw6AxZDb4dc+1rtB6bQPiepYpyGy3e7iw
	XD7I40uUZYuy4bhbsd3/0nvvBU1Ww5I4Tfpg==
X-Google-Smtp-Source: AGHT+IE1Ru6Xp1j6J/tB8ZIZ0AzmlRLYV49addDTXEYR8ZgeOn5WLgURfwnipEqHcRcoSfKNyOH/5U/mXG/RMmZQywc=
X-Received: by 2002:a05:6a21:900c:b0:1f5:7eb5:72c7 with SMTP id
 adf61e73a8af0-20a89424e83mr4926408637.29.1746023294950; Wed, 30 Apr 2025
 07:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 30 Apr 2025 10:28:02 -0400
X-Gm-Features: ATxdqUHF2uNoljUQWjMxtgBgwe-X3BcMGzjtHjMQ975ormX6QTwWR-Qw6Rb_lNA
Message-ID: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>
Subject: [REGRESSION] orangefs: page writeback problem in 6.14 (bisected to 665575cf)
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

I ran through xfstests at 6.14-rc7, and then not again until 6.15-rc4.

Starting with 6.14 xfstests generic/010 hits "WARN_ON(wr->pos >= len);" in
orangefs_writepage_locked. I bisected:

665575cff098b696995ddaddf4646a4099941f5e is the first bad commit
commit 665575cff098b696995ddaddf4646a4099941f5e
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri Feb 28 12:37:22 2025 -0800

-Mike

