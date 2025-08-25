Return-Path: <linux-fsdevel+bounces-58957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851BB3369A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB8816370E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80D6283FF5;
	Mon, 25 Aug 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avXwxJgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BE1991CA;
	Mon, 25 Aug 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104067; cv=none; b=tuD8MK2bkO8Vf+Gwwa7F1/ZDdPHB01YeMvxbgJdgkzYYFQBSJpZQj/IdbHGsxb/V4Y7A+z9hrhpc690Nu6EqX/uSQ4S+pH/0QFdkG6rodIHw6vDewiUhBTi10tYiaqONqKQcIPLkK+Y1SRzoCAzHDNIFYCz8INmsNU7afXNjC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104067; c=relaxed/simple;
	bh=f4+we2HTNhFFijjPWHsHlUjC05tFGguR5UUIbT1FAuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTNH9153oA3SJN+GdfU2EjuDtthWwre3UlLT3KHe0SM88neoHQwHcpEmTUYwKs7pb6361R4cfoZfBErC60R7Uii5yw2dVIS59riuvAE/Wsnsc2GixsZpLOVq0R6OJtC96lkA5wAmMBk1WingNJxqZVN+yTNRLJLhJEyGXBkckkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avXwxJgI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445827be70so38070525ad.3;
        Sun, 24 Aug 2025 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104065; x=1756708865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4m65ejtCDovPoHidIgWHyNXPlswLso6n72FHLjtbnE=;
        b=avXwxJgIesp4+HwSFX/eod8Dz1ygPGzwQ5ju0EHfdQpCXqs4IKkS18MdxjGyJRRpqN
         6S/iykIGJNm3ddyB8utXvInFzcUNyzeos2282fCsWQusUysTrBUpW+2iTJMi5bn15GKM
         YzVIvuY59pxYCrOBmWjhmrZGGmYZ0GpZVLwy6t6GwdwkIBeMZilxqJJIys0Ixi0hBawE
         aGVlMwYHbyMMvQr/vTD11Z+HHHPOPuPz0Q7nFY/R1D/A1xIvD4LGlIPsUy4GQ0hELpIS
         VCxGrn3eC3Jtx83TfMPx0mZOE0h66OQVkKeKHc6VuXfMTNqDy/cTI4Fl36JcfaJ+SOk3
         jU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104065; x=1756708865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4m65ejtCDovPoHidIgWHyNXPlswLso6n72FHLjtbnE=;
        b=vup7Vg9VOwN/i7aN5ebmS8rv4mZA1M3AA9hRFaHOiR5QFH0N37hOT3RFqT2zJngQBR
         HAVOFepJXUGODN75AU89qjx3D1FGrMEQ6MMaRby7mR+47M7l3fZtmIt8cCc/wwOrYAYK
         6FP/4KRfKFHOqatAV6OPQHt6kTOeYdCs6vUbM2kCJgTZFXtEcpKKfwxS9/uBAWD3XyMT
         OAylZEQtc8ulOnnpTrvLzfelz7UKaFIFqbtOuj/6F7IdluffrBshAL+/JgQdS+yxi+C6
         bELUnOn9+f3vqlwx/srTf6sZqzMINwLVgQVYKUa2QQBwclGsa0peq1wJiZp2MQ5uF7tU
         loGA==
X-Forwarded-Encrypted: i=1; AJvYcCU+FgKhJYajzKA4RCTSFosgJP7XZRywEAxu7vJpXHICn7VKNKa/hEoGV4/4sD5tdTFPjwzHrQpm0V19@vger.kernel.org, AJvYcCUKtAcxyxxz7eNoqH3ekCSXhYzuu5C41BxafTY2w40wQo8zIeb874bce3DDWzt4VgVI4hgOrFdQOo4qPRDG@vger.kernel.org, AJvYcCVK4KFOSLY+IroMtyZgYv1ej/NtkNRgO7T5wxH2csAcjZgGZQlcAC06BkPp2aqoPyRAXGavVub9cHpe2eZq@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+zraUhKbFp83O56NTbKZpNH72tVohRZba/h4Wokjp0EaNXy+
	pzA4IoMwM1R7VLMNYMUSy+oO/QL1AVIEEQoj0poJwCmHMkmWkgCW0BfH
X-Gm-Gg: ASbGnctVp96P/tHNI6sLsPVKbbbOn9qJl8Tym8KjmLWTQUwIAIr2VaX15iGcfF0rgT1
	9VxALfmcsaBpV1GAxCbNPhUNVa2q+tILPUcTyWKRIy4M8+CTorSV2sR9BQpgq0H08A5QNBc0sUY
	Z8WpmivP8M7vHjXTWRtlUKDwV3X5dlmfmDvQeMLBQ+Ql78umwcd/aTLk1b9P6GkcFqTvbqF66G2
	Gdo5N3cZvT6Y3WQMraRNNa9obQD8evFBf9Od4WznpPDRDzZxO1UGMV2BU+QTKLUtC9k1LSVUr3i
	dUuQRYsvpbOOT+gnKEe4f+3gTT6C3jS8BMPAa4RO6n2OYWjE+Em3wkbhvx0ml0ZdebDOQXOF9CO
	E54IYwU6+dK/j3gMuemfhWbwFkxEA7d4RcnQ=
X-Google-Smtp-Source: AGHT+IG1ceuvN7wur9FsFeOfamUuDJB3YryOpBkyURPVy+g5OzKZbgY8S3iwpcr9uOIFgcngcwSvvA==
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id d9443c01a7336-246464d13f7mr165867755ad.2.1756104064665;
        Sun, 24 Aug 2025 23:41:04 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688c1440sm58675635ad.167.2025.08.24.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:41:04 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com,
	hch@infradead.org
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Date: Mon, 25 Aug 2025 14:41:02 +0800
Message-ID: <20250825064102.2786548-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 17:15:34 +0800, Jinliang Zheng wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> With iomap_folio_state, we can identify uptodate states at the block
> level, and a read_folio reading can correctly handle partially
> uptodate folios.
> 
> Therefore, when a partial write occurs, accept the block-aligned
> partial write instead of rejecting the entire write.
> 
> For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
> bytes are 2MB-3kB.
> 
> Without this patchset, we'd need to recopy from the beginning of the
> folio in the next iteration, which means 2MB-3kB of bytes is copy
> duplicately.
> 
>  |<-------------------- 2MB -------------------->|
>  +-------+-------+-------+-------+-------+-------+
>  | block |  ...  | block | block |  ...  | block | folio
>  +-------+-------+-------+-------+-------+-------+
>  |<-4kB->|
> 
>  |<--------------- copied 2MB-3kB --------->|       first time copied
>  |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
>                          |<-------- 1MB -------->|  next next time we need copy.
> 
>  |<------ 2MB-3kB bytes duplicate copy ---->|
> 
> With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
> This means we only need to process the remaining 4kB in the next iteration,
> which means there's only 1kB we need to copy duplicately.
> 
>  |<-------------------- 2MB -------------------->|
>  +-------+-------+-------+-------+-------+-------+
>  | block |  ...  | block | block |  ...  | block | folio
>  +-------+-------+-------+-------+-------+-------+
>  |<-4kB->|
> 
>  |<--------------- copied 2MB-3kB --------->|       first time copied
>                                          |<-4kB->|  next time we need copy
> 
>                                          |<>|
>                               only 1kB bytes duplicate copy
> 
> Although partial writes are inherently a relatively unusual situation and do
> not account for a large proportion of performance testing, the optimization
> here still makes sense in large-scale data centers.
> 
> This patchset has been tested by xfstests' generic and xfs group, and
> there's no new failed cases compared to the lastest upstream version kernel.

Sorry forgot to cc Christoph Hellwig :)

thanks,
Jinliang Zheng

> 
> Changelog:
> 
> V3: patch[1]: use WARN_ON() instead of BUG_ON()
>     patch[2]: make commit message clear
>     patch[3]: -
>     patch[4]: make commit message clear
> 
> V2: https://lore.kernel.org/linux-fsdevel/20250810101554.257060-1-alexjlzheng@tencent.com/ 
>     use & instead of % for 64 bit variable on m68k/xtensa, try to make them happy:
>        m68k-linux-ld: fs/iomap/buffered-io.o: in function `iomap_adjust_read_range':
>     >> buffered-io.c:(.text+0xa8a): undefined reference to `__moddi3'
>     >> m68k-linux-ld: buffered-io.c:(.text+0xaa8): undefined reference to `__moddi3'
> 
> V1: https://lore.kernel.org/linux-fsdevel/20250810044806.3433783-1-alexjlzheng@tencent.com/
> 
> Jinliang Zheng (4):
>   iomap: make sure iomap_adjust_read_range() are aligned with block_size
>   iomap: move iter revert case out of the unwritten branch
>   iomap: make iomap_write_end() return the number of written length
>     again
>   iomap: don't abandon the whole copy when we have iomap_folio_state
> 
>  fs/iomap/buffered-io.c | 68 +++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 21 deletions(-)
> 
> -- 
> 2.49.0

