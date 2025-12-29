Return-Path: <linux-fsdevel+bounces-72196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE82CE73F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7946B3016989
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1A327BFB;
	Mon, 29 Dec 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3DzKXKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF52459DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023358; cv=none; b=MTTKmmm4k88Clx4lmZlH8ckiOzGCNGNIu0YhVg+xVsF58tgk1Akni0G7X+Fc0WaKuLBJ+/cl+P3WUFLSg/cjAO+XOJXkNzTjJ40BQnZd0AWVLE1i7GhFzNhuZIeAYQiRwppmRubrfQX9SS+B+10NwwBuTWuadqO0GzTAxPTTw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023358; c=relaxed/simple;
	bh=yJFiYgQfRDc4GlY64AoxaWPXfSffAIRLTpJ9qRR7xyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5XUUNGxsROl+2/WyM9UDnUdJ9D1FMRcAAt/ffOjNRBEXXEb0gu0+b6UXPek4szcPyIJTrCL0K00lNsYhtdng/31cuMZ/Omb1s62Ya+gd9DIE/Th1vRA9S+Lph3R/x3lxxySt12WvqtIERtRRjxlkOqzCD7Oa5TeimGgfeMpS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3DzKXKo; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so9403905a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 07:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767023355; x=1767628155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKOOoNHl/I8rgjIJVxK+NHEcQpFZLo6aCGKvdzw+IAc=;
        b=a3DzKXKopqPsgKLhCTG2rdsNTI8vKce0QSXcgm9KBNyKyXAxsHJvXEkg+RY7UjAXdp
         VGAHcfDFF0Kn0gox5pSmW1Gu1C0jeF2WSfm9PHBC5eKJoBF9QVxHaGgHefvX2G0ipQEf
         4RS3MbS4ovAKXRDZccaJkMqRfrKdt8xB5Qy7b8wiz3cAW8uPqQz1V83ItyH0yrUjhvle
         0T4LE/q2yuL6DSnrxMWESTSZRs1hK84YSPq68+YmCVHsGPD2OSv1IMhzsLNA1/DW+ND2
         PRNz+MhdLQQRPOIqx63JSPXIJrHLqlgvHpyueYMIN5Nxb5sZeQ4vWkYOSHXF5Y4dVcLN
         92yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767023355; x=1767628155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKOOoNHl/I8rgjIJVxK+NHEcQpFZLo6aCGKvdzw+IAc=;
        b=E7+aVWg+0AoD5UgevL6+jLAfdzGfXdpPDpVLHfFJUtgkGu21j4V48U77e7HduPXNkO
         ceq55b6mOqRbQqEziAZwAOR95hVlXgvUQwmfX5+NfxXXOAuAic2uFENMsHuvqO2jfcY5
         x3ltgwPf9ReXXjcdt/8uFUy6NCu2zA0ORh5UgxnoLlcJ5JtTIGM/7w8VTmMhxF0+gleD
         FW2NZnkoyFuEgIxGX90gUYldOwv4MmWgcinECU+43Mw8I9XOApRU0RiTnethBGQdXEtN
         x4T7mpWvWr/+ak/UQ46moWEOjipAVnD3P68BOvorTE/rYh7IvLU4rXaaSWA2EB2+bB8T
         ebnA==
X-Forwarded-Encrypted: i=1; AJvYcCUUH5wwNuhw2U+wXVtXhYircSrAvFsi254fkQrtnPq2RFJjCFydXUV9poBztehT8TVia2soxS08ZE6ouVIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBbHmP7EiIJ5MF0aE6OBnh4qvPdQldgxd02eGV6mfaWsMlVuJ
	qQUL82i161jIpXswePXwdjiwMqR41VPKefNoxrgskmRQ8oYefBSssSQQ
X-Gm-Gg: AY/fxX7c21K5ccfmM7wbCtQNlGM2gkD40YzKJKwKb7glMgUt+eLhxm5IU7UugNxWaYW
	1sPp19F7n+jGGqjFMmfWAKj38QgMT5vZr+fb2+L3a7U2ITj546bB0/U7p1Fg2M/UV4GvrcPek4B
	0Y65UC0cYXkO9MQMGfqTUxh+cTFl+RsboGfmKidbZFMZ98TlEm12MW2ezRUIP+KEOyQVUPsJjsy
	jH/0GOAZdbjwoU5RcYL61hrZfHY9OejCcpzHMWKAioShPzHbJVpeycs+GQJePODPBqf3vZVY+x2
	FQjPGET9C2npMG4g1dme/4Io/zD9uwUiw9NyfMUGCtWkHJ/I2UPNeqQ8l/f1XL7vlny8VyBJZiY
	+6/WHujMbbT5ysDG7UegaUG5eMujJOoubYvrQA09nXoQIavOL9tB+pAmKanMEmoVKaqZxMFQtMu
	k37WxiJZxFUXzYkmafi8BvkLJAncy9kSbXTIBkVI5GHYkp8C3ZXaH2qNWnrc4wqFb6X5vuN/7tk
	8wbxI0v9ul3mqzj
X-Google-Smtp-Source: AGHT+IEj1jgq2u6/j5yoYlenL4adeZnxG+vLPgxPQxIFSeaMsDxl8mpB2Zz349lUtPKPJeGAW/r7WA==
X-Received: by 2002:a05:6402:2712:b0:64d:accf:aae2 with SMTP id 4fb4d7f45d1cf-64daccfadebmr18813519a12.27.1767023354925;
        Mon, 29 Dec 2025 07:49:14 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-c26a-1433-8180-c786.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c26a:1433:8180:c786])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a4eesm31531887a12.24.2025.12.29.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 07:49:14 -0800 (PST)
Date: Mon, 29 Dec 2025 17:49:13 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v3 RESEND 01/14] Revert "fs: Remove NTFS classic"
Message-ID: <aVKi-ZiyIRj9IF1h@amir-ThinkPad-T480>
References: <20251229112446.12164-1-linkinjeon@kernel.org>
 <20251229112446.12164-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229112446.12164-2-linkinjeon@kernel.org>

On Mon, Dec 29, 2025 at 08:24:33PM +0900, Namjae Jeon wrote:
> This reverts commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89.
> ---
>  fs/ntfs/aops.c     | 1744 ++++++++++++++++++++++++
>  fs/ntfs/aops.h     |   88 ++
>  fs/ntfs/attrib.c   | 2624 ++++++++++++++++++++++++++++++++++++
>  fs/ntfs/attrib.h   |  102 ++
>  fs/ntfs/bitmap.c   |  179 +++
>  fs/ntfs/bitmap.h   |  104 ++
>  fs/ntfs/collate.c  |  110 ++
>  fs/ntfs/collate.h  |   36 +
>  fs/ntfs/compress.c |  950 +++++++++++++
>  fs/ntfs/debug.c    |  159 +++
>  fs/ntfs/debug.h    |   57 +
>  fs/ntfs/dir.c      | 1540 +++++++++++++++++++++
>  fs/ntfs/dir.h      |   34 +
>  fs/ntfs/endian.h   |   79 ++
>  fs/ntfs/file.c     | 1997 +++++++++++++++++++++++++++
>  fs/ntfs/index.c    |  440 ++++++
>  fs/ntfs/index.h    |  134 ++
>  fs/ntfs/inode.c    | 3102 ++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/inode.h    |  310 +++++
>  fs/ntfs/layout.h   | 2421 +++++++++++++++++++++++++++++++++
>  fs/ntfs/lcnalloc.c | 1000 ++++++++++++++
>  fs/ntfs/lcnalloc.h |  131 ++
>  fs/ntfs/logfile.c  |  849 ++++++++++++
>  fs/ntfs/logfile.h  |  295 ++++
>  fs/ntfs/malloc.h   |   77 ++
>  fs/ntfs/mft.c      | 2907 ++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/mft.h      |  110 ++
>  fs/ntfs/mst.c      |  189 +++
>  fs/ntfs/namei.c    |  392 ++++++
>  fs/ntfs/ntfs.h     |  150 +++
>  fs/ntfs/quota.c    |  103 ++
>  fs/ntfs/quota.h    |   21 +
>  fs/ntfs/runlist.c  | 1893 ++++++++++++++++++++++++++
>  fs/ntfs/runlist.h  |   88 ++
>  fs/ntfs/super.c    | 3202 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/sysctl.c   |   58 +
>  fs/ntfs/sysctl.h   |   27 +
>  fs/ntfs/time.h     |   89 ++
>  fs/ntfs/types.h    |   55 +
>  fs/ntfs/unistr.c   |  384 ++++++
>  fs/ntfs/upcase.c   |   73 +
>  fs/ntfs/volume.h   |  164 +++
>  42 files changed, 28467 insertions(+)
>  create mode 100644 fs/ntfs/aops.c
>  create mode 100644 fs/ntfs/aops.h
>  create mode 100644 fs/ntfs/attrib.c
>  create mode 100644 fs/ntfs/attrib.h
>  create mode 100644 fs/ntfs/bitmap.c
>  create mode 100644 fs/ntfs/bitmap.h
>  create mode 100644 fs/ntfs/collate.c
>  create mode 100644 fs/ntfs/collate.h
>  create mode 100644 fs/ntfs/compress.c
>  create mode 100644 fs/ntfs/debug.c
>  create mode 100644 fs/ntfs/debug.h
>  create mode 100644 fs/ntfs/dir.c
>  create mode 100644 fs/ntfs/dir.h
>  create mode 100644 fs/ntfs/endian.h
>  create mode 100644 fs/ntfs/file.c
>  create mode 100644 fs/ntfs/index.c
>  create mode 100644 fs/ntfs/index.h
>  create mode 100644 fs/ntfs/inode.c
>  create mode 100644 fs/ntfs/inode.h
>  create mode 100644 fs/ntfs/layout.h
>  create mode 100644 fs/ntfs/lcnalloc.c
>  create mode 100644 fs/ntfs/lcnalloc.h
>  create mode 100644 fs/ntfs/logfile.c
>  create mode 100644 fs/ntfs/logfile.h
>  create mode 100644 fs/ntfs/malloc.h
>  create mode 100644 fs/ntfs/mft.c
>  create mode 100644 fs/ntfs/mft.h
>  create mode 100644 fs/ntfs/mst.c
>  create mode 100644 fs/ntfs/namei.c
>  create mode 100644 fs/ntfs/ntfs.h
>  create mode 100644 fs/ntfs/quota.c
>  create mode 100644 fs/ntfs/quota.h
>  create mode 100644 fs/ntfs/runlist.c
>  create mode 100644 fs/ntfs/runlist.h
>  create mode 100644 fs/ntfs/super.c
>  create mode 100644 fs/ntfs/sysctl.c
>  create mode 100644 fs/ntfs/sysctl.h
>  create mode 100644 fs/ntfs/time.h
>  create mode 100644 fs/ntfs/types.h
>  create mode 100644 fs/ntfs/unistr.c
>  create mode 100644 fs/ntfs/upcase.c
>  create mode 100644 fs/ntfs/volume.h
> 

Namje,

This is a partial revert, something that should be mention in commit
message.

But also, I think you should include more of the original revert, like
the docs and MAINTAINERS entry, which you added later, sometimes inside
unrelated patches.

The only think that you need to omit from the revert in the Makefile and
Kconfig changes, so that ntfs code remains dormant until the end of the
series.

Thanks,
Amir.

