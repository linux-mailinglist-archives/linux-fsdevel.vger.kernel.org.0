Return-Path: <linux-fsdevel+bounces-39113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE3A0FF9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 04:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741F01614E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CC230D05;
	Tue, 14 Jan 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjUxXzr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123824024E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825933; cv=none; b=sZGxJc7vRlBZNlvapdsnaK/TYbxMlONL0nYSSEkTCoJqPKLm/tfoIh5i/VpB+Kkq45la0kk+0qQlyofANeC9eROmaDYWwplIqDEdnldn/tlENBxgsrmE5n232HlcH8um6+tK8WVa7LKnR8pb8zaIpGdufIg3qSMvlSvUgjrGzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825933; c=relaxed/simple;
	bh=riF/sc1yDKemhsW5nx6/OVT+PE2+y6O11wzg/XZ5by0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JXibwVW+TWukqOiGXS0Hv05vFKyIxlTh9yZWHLLziKCJUc52PNPbW9l59o1f8CVsSB4mk4M9rDVuuGC3tyyxdTgmvKQANFDMZT6dVIZS6Djp1UAtxquMw4Crw+Czh2Ys9ZzVqINiA7prU216N0MafPPdg+jxwbmMSKTT9Q3dbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjUxXzr9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso7083050a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736825930; x=1737430730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lj6/sApTY/jclvY2FM4RFLaJJCjQ4BwNOQGN06z90O0=;
        b=AjUxXzr9B+9JA9CEoUztJ28OVJNjw7Pd1AXN07TjdWXVHxTefsI3oyQMsXfvWtFuIE
         AJux1ULaEnUoCyQGHoSVXOlOLmUY04WK8U0iSmFbRtnGxsx2//t+ORohfZIMwPw2jZO7
         Ev9s5QtxiFJ4BrP+Kct4gVhXWsGqulcfPW78/WLTbxkjMhLEPv86N38iqJD2OM4FttAf
         Hi1gP4W/UVGg+4y/WJYRyJC+ffKheo8gHGnb5nWAabwaU+6VVEqVHGYUs3JAn0SR/8j3
         1KfxWXYaLIWAaeXd6EP2UOvzz1RJA2AVBlY5Y/Bf5gs1relJSPbkQeTyQ1xBTveTSH3P
         L1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736825930; x=1737430730;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lj6/sApTY/jclvY2FM4RFLaJJCjQ4BwNOQGN06z90O0=;
        b=W9W86KBCXFZL7q9t2JjeXw0tweA8hcrXA5Sjvs+Ubbd6UznRlZ15u+0Orm4oj73YjA
         95fmn+eI0ZXxDfKDM8ShJ5N2vpUs+WwViTELniQ5xRnTo8O3B9d+LiREYNGbqllFc2Qc
         jxafLUUxdpu4ucVVQoYa3AcIFduxDyWUAWDvg02Kc+zpeQLxnXFHQfQvOegvzLw5bseY
         CqqDI6yiEbc+s9BzdRQoKFXY6gW8NiSphWchaHrQVb0Z6yNrljz7+to9iK2W9o9a+Z4L
         D8b66PbpfphGWAszPDxHNHcabljDfofXTcMs0b84Tglg1rJqAV9dbn5kbdkRSaVQjZth
         uvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5zob9DTU6iGfhQezCjORyQ9HjKKNPEL9xcfBrNVakKZkn3nbc5sL/hloO/4R2s6gikqR82Cb2T5BwqTx@vger.kernel.org
X-Gm-Message-State: AOJu0YzBl494yAmuEbZQ8aU0vZ6eY4vjPaW0vTW4xMwpYhzoEulMbCL0
	5hbTX89Zpaox6La/InOXRSCqtH+9/fcSm8wl0kfAebeeGycAGMRv/o7duwHerxn01Bfyr/7QNnw
	jhLAJik4j+jDkYmEWmduzcppm5UQ=
X-Gm-Gg: ASbGncuushLyDyPq9F210C5cGVlWIzC/8G9dWLkCxUSxm18Hh87DrI7M2vuMYdaGbXl
	QZluw5/Ek9QHQ/xkGGMT2g/3BVr5l0cZkYUsg0w==
X-Google-Smtp-Source: AGHT+IGwhlxltsK3k4mQ5v0NzJn4zQS/1ltP+H7maDpZm7YlWye2Fd2UAsK7/NvNG+nsaOn3r/RMbcnhb1wDkFF7xoM=
X-Received: by 2002:a05:6402:34c2:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d972e1c568mr57738673a12.16.1736825930129; Mon, 13 Jan 2025
 19:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 14 Jan 2025 09:08:38 +0530
X-Gm-Features: AbW1kvbmNbycCq3IpxtuJB4ygP5JxCdoxJZwG4cXc_gbKFkw8Ygxe1HloKSuiTY
Message-ID: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

The Linux kernel does buffered reads and writes using the page cache
layer, where the filesystem reads and writes are offloaded to the
VM/MM layer. The VM layer does a predictive readahead of data by
optionally asking the filesystem to read more data asynchronously than
what was requested.

The VFS layer maintains a dentry cache which gets populated during
access of dentries (either during readdir/getdents or during lookup).
This dentries within a directory actually forms the address space for
the directory, which is read sequentially during getdents. For network
filesystems, the dentries are also looked up during revalidate.

During sequential getdents, it makes sense to perform a readahead
similar to file reads. Even for revalidations and dentry lookups,
there can be some heuristics that can be maintained to know if the
lookups within the directory are sequential in nature. With this, the
dentry cache can be pre-populated for a directory, even before the
dentries are accessed, thereby boosting the performance. This could
give even more benefits for network filesystems by avoiding costly
round trips to the server.

NFS client already does a simplistic form of this readahead by
maintaining an address space for the directory inode and storing the
dentry records returned by the server in this space. However, this
dentry access mechanism is so generic that I feel that this can be a
part of the VFS/VM layer, similar to buffered reads of a file. Also,
VFS layer is better equipped to store heuristics about dentry access
patterns.

-- 
Regards,
Shyam

