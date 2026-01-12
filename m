Return-Path: <linux-fsdevel+bounces-73253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB4D135B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF0A30E614F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAA2BE62B;
	Mon, 12 Jan 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3V8fSM+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijykuOZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BB2D5C6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229487; cv=none; b=CQrNRONt7sYYst8yP0a2fI8AVFmObPrwzbSqmJWwGYyEJBi0wZbAevh+FHVmLyilI7rNXJKWVzpTpIoD+W9BgWiOlrIuvBIleqZRygt1VUx9UO4Rj+iaatwKlHg2U4PsVHGN8VLDyJVkw0jBq5Q3YwsB0ZYxSdrCJDgSBCN4pYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229487; c=relaxed/simple;
	bh=MxgptwcHFi+z4ifrlUMeCFEAHWtj2SNcmezFtEHqDpM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TekG3I8DN8W2hrWXAVLqG1VQOiamwuxAMshKGchJVhFLMfiQeYyrDRLKpBGdmqIeP9pW728ROADWbEfIB2zSk2fzUCaRVjXhyn/JpekuagtMSQUZYEz/l9mq4hWwkgKi8ETO+yoQgZVFsylWLtV+GffC0HaWtemdod7K9HO/cRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3V8fSM+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijykuOZE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL9J1kXYNGpo3omk75dIbnVKK7rJ+xh/+WBR5nbHReI=;
	b=K3V8fSM+L6Vevo6Gxf74MxOQNSU+TM0Loo+E7rX8Vp4OFChttcUKYp6tDVdXBgJk+JXeia
	ZpOoAm7kMnnYGWSIbjKUcda3O9AYEu98jL6xq5++5Vjt96wrD/z/PKcBDah5hqSnR2zKwB
	YCiwxZpmpza2OMhpNvEfFQIbUQhiXao=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-IfBRCDzzP_esAvHR6-kXzQ-1; Mon, 12 Jan 2026 09:51:22 -0500
X-MC-Unique: IfBRCDzzP_esAvHR6-kXzQ-1
X-Mimecast-MFC-AGG-ID: IfBRCDzzP_esAvHR6-kXzQ_1768229481
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b807c651eefso935884866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229481; x=1768834281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wL9J1kXYNGpo3omk75dIbnVKK7rJ+xh/+WBR5nbHReI=;
        b=ijykuOZEHrc4IJ9SxNOKtnblMmzn+NRbtnxf5B+HVJiVhgAP9JefXe3Dgm3TPRLn57
         1hPdUgVvFhHbCnxwyNjrQ70M9Lb6ZqEzN+eYHbp8Er/f4e8RteInKM0s06Bj0VcRwz3s
         xlaETzvX1bJVIXWD9Ym4MbCdlAjyq+gbBLWT2E81rr01u7SJP9ZSgCRaPB7JaOWvT5ho
         HVuvO9+WVReFiBghApWiaGwgDPkS4KTsXFn9rsnqED3/+IMj8120LoqEAGHOMewdt8O2
         2MR++MnYPK2xpiGCWM8Tkm/J9pwRT8965tHx3dJhZF/otGGfJdEHfW81/aeK30YEI0JM
         hpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229481; x=1768834281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL9J1kXYNGpo3omk75dIbnVKK7rJ+xh/+WBR5nbHReI=;
        b=bS7tOV1NulNTdcuF7Z/7LxBKbFJG5uXIWPSh5x6953O/0ZmNKPrKsyUJ1THjlUHECm
         Q/k6zFPjWwoq4sQdqUqTXTjxE3PNSNf97+x9I06Lqmgu4TyZcgr25264d8loMn9boj8/
         HuL4L5vI26W4PpAhGlCHbFj9EsMHTHNYCUYToFEOYmrpCdc7ao2nZDgI5Zt96ECAwhFI
         vLSgQcb9QxxvGZw0rbRAMWn4jrHChJkk/gH7VXwU6L0WiVl4N0vVv5+zBoHXk8BB4H/Z
         NG9+RAOcBCXiV7ipo+4pWuiR3GqmVWL6jeJsy+rgYwIM2VOEBcACeeO4FU323cKMCvQf
         rNiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0PkRFwL7OijXVKm9D15cDsc96uQ5n2a+lex/GehtsrX3bR+hRaCiodYy9lINMTLuu63Q+s4FVv8SxmBqC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dFSBot84vWXO+Zha2ls67llrqeY/2ceHfsq98yFKkTE+CSQG
	UFB9y0i4vKJFtH0FuLzDj4N6mss0sYoDTpKps6/pSza5yq38ulwJBORruaESHXd0sbN0fSGIPAW
	8KXw3ognNr9AxTtu6EIqNcSw41b06LX6zQwoJ4ZPh3fAF55+I4UwC7cMW0joIH+WQlQ==
X-Gm-Gg: AY/fxX5o2J+1caj65V/HhNRD9JQ0HIfdWsheJh8Vv4GYweXk9Tv2zUw2a17NbTpmEWu
	XToUGa2tOfq8g27qGyCLE1vOnkk+mGs5aw0cjxU/Njfqr/ryN2E6WNuGwujnfHoUsAhI+BOlN1u
	jcTSlbbIN1QBFpOtwl8JKn88CGc9fTYTYLysRJuMb5D/jZP1hCysDnZ2hQbQGFTMao+JaL3ZmyW
	VcP0FT/t5h+cHQvsU+ftHDsW+yLZlKBoT/uFxGr2vKgRO2sVlIDXyfNkVXXxfzPp6yznDtekc++
	wpd0+BpdZvXBFDjmxZaKMPzRh81LAd5QGk1/s/mwxi4pTNkWjQjhw+UIGNZ+qwAc/eBEJrMLBPw
	=
X-Received: by 2002:a17:907:7f90:b0:b87:33f3:605b with SMTP id a640c23a62f3a-b8733f37289mr5217166b.27.1768229481033;
        Mon, 12 Jan 2026 06:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMB0JxHgMWzT9jlMyCtL8Tarhm33xjovmcnmuqowqS/Fr0c7wyM0JTrOTtbi8ZoddZMgmNgg==
X-Received: by 2002:a17:907:7f90:b0:b87:33f3:605b with SMTP id a640c23a62f3a-b8733f37289mr5215566b.27.1768229480682;
        Mon, 12 Jan 2026 06:51:20 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2338cbsm1914558166b.14.2026.01.12.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:20 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:16 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 12/22] xfs: introduce XFS_FSVERITY_CONSTRUCTION inode flag
Message-ID: <bfcg5hug75qtvc2psw5yymfoudnz2uda3gg5dfzgnze46hwt6n@u67n3rdzzuo4>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Add new flag meaning that merkle tree is being build on the inode.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_inode.h | 6 ++++++
 1 file changed, 6 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index f149cb1eb5..9373bf146a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -420,6 +420,12 @@
  */
 #define XFS_IREMAPPING		(1U << 15)
 
+/*
+ * fs-verity's Merkle tree is under construction. The file is read-only, the
+ * only writes happening is the ones with Merkle tree blocks.
+ */
+#define XFS_VERITY_CONSTRUCTION	(1U << 16)
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \

-- 
- Andrey


