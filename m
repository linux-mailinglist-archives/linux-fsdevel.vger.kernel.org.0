Return-Path: <linux-fsdevel+bounces-63810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE0ABCEA0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DAC42696B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D3303A3C;
	Fri, 10 Oct 2025 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJe+kdqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5A303A21
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132550; cv=none; b=uHPHISD5Tt3crSotzRjwdcVkBq+1AW0hGMKFu9o7m5bZLApDMuPpclTFr9qL88B9+Fr1Wr6W8O24xpjIhjknucZjBN8BeY1DLfDmaQ6/IVRTYQlw4/wqXjdVg5QQjE6rlNDi4RPUHmKeuZuye2c+G/MGHEU+sDASQYhh9I6nqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132550; c=relaxed/simple;
	bh=MYeYUOWONOAmTQBQ93bnEG0aCfx6bBELfUwwtyo7k8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siy/siplGzsPe9wxGoT7XSqcc00QgVH8qNV2OMppgfAmnH5TXBzzp9VoQ2eMkl/dnYT7ISiEB48OlsREE+3Q3Fyjw8JaBhwh4kX4OBztQwyIVa+q4aeizP1xqBwW3OFhPPrJb8l6PuP1V+VPKEBW/b35ZFlceEUIYscPG6KXoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJe+kdqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7eg/CINfrFrBJA39F50UqdpcgBBZOmozNU38K2khzkQ=;
	b=hJe+kdqEkftNNLqX8XHPoQ1zoBQUyyIXXt6LUFm7pKBzLJfKAQktorJUr3lwvAkWwSBY4H
	eaBNechXVVpoJN8tv1hs4pAb+JAT4nP2Mfb3o3nRldu69Y4F1GCS+WNHAvkpbCdGqFLzJf
	Mer0TIIap2XxESv6qCa4k07VxlKAC/A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-BEwHwbIVNRqYO2d6r8bO6A-1; Fri, 10 Oct 2025 17:42:26 -0400
X-MC-Unique: BEwHwbIVNRqYO2d6r8bO6A-1
X-Mimecast-MFC-AGG-ID: BEwHwbIVNRqYO2d6r8bO6A_1760132545
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so85834535ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132545; x=1760737345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eg/CINfrFrBJA39F50UqdpcgBBZOmozNU38K2khzkQ=;
        b=LdlUNQfO7xBJmdlhO/9g9tr/Nn2MiSmJN65YtgNB0Mx9480rOsZ0/Pspe/7LDtP3ta
         MTEjUx2aSxbxS5nZenRYKnwQp3txIL7wAbXM8eNK8MFRSz0nXA69RJ5RrZgWNqC8tsfR
         vEpUpeJNP2DdLb4V3XgBEfV0n4MD2wXggYUPcN/Tht1JyfLGRdzMDCO+Z+eHPZji5dAo
         vDsPYqfto9sZvKb3BJH4QENKQ2CH6Qh7qTW6rbI3m4yt/kL3y8X6v4i0gh9/+lYGKk9y
         lCQoROBwN3bU8jvnk3bcT+06Ad0dYvlmcv539hdkRmm7gPkwn1KdETAodzudPJ8Oj4D4
         vNDg==
X-Gm-Message-State: AOJu0YxWxpUBy32K1HTZydXwgNELDUdDMPge/LgXjtFCk9W6AuiG99oZ
	iN30gyvb58Cd6Bnjij/2oMt0ogJbpwpMRwy0o7mm9KOsGTf3c2MWOZaaSzWJ01zn7dQP8jCRH9c
	xYAtAk1MlFUhDPUDl0l+5HRl3FZ70VR2W951+LofsUZOsfeZ9NGK7WVPipelzkzXO4V8=
X-Gm-Gg: ASbGnctjkabv5CTD/ZRBc79wTUSvryXU+/huZAZNYneGRt2UsPTFs/jq7BmtoETsauq
	OivFra14JUfEPf/agARo2n2AfUU2AT8R/G3TDWMCDkImnSKhB21010wRB3yeEGeGFCZRbDfaC2Z
	SaDhHvTSyRgYZmE1Cjnc8ekLVdJ/H2PWGNkpN9SrLysO7n1NFTo19+fNl6LUm6kCamcKDCl376u
	GfIagBZO54nzR3J9Sxd0vkLPHZ2hUskl53Xu+cnBfI8tfbnIDYTfLo5NbY/QXokZFdr7y3jn6IA
	pDngfus2wuJOiBkvV4+rTIFAR1ZRf+gyJ4qeFtAm3cN95nBX39wllzs=
X-Received: by 2002:a05:6e02:1a8e:b0:42f:9e92:a448 with SMTP id e9e14a558f8ab-42f9e92bb89mr43920095ab.7.1760132545176;
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPevkN5ffI8mFRitJH+Wd+8sxBtluY9Wioh6i1ktRbeYTuurfFKYwJgHA2GryCcd6b5lP85A==
X-Received: by 2002:a05:6e02:1a8e:b0:42f:9e92:a448 with SMTP id e9e14a558f8ab-42f9e92bb89mr43919715ab.7.1760132544750;
        Fri, 10 Oct 2025 14:42:24 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:24 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: [PATCH V3 0/4] 9p: Convert to the new mount API
Date: Fri, 10 Oct 2025 16:36:15 -0500
Message-ID: <20251010214222.1347785-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is another updated attempt to convert 9p to the new mount API. 9p
is one of the last conversions needed, possibly because it is one of the
trickier ones!

This has had only light testing. I confirmed that with the diod server,
both of these mount successfully:

# mount -t 9p -o aname=/tmp/9,version=9p2000.L,uname=fsgqa,access=user,trans=tcp 127.0.0.1 /mnt

and

# mount.diod localhost:/tmp/9 /mnt

(The latter passes trans=fd under the covers)

I have not been able to test other transports, or exhaustively test
functionality of all mount options.

Changes from V1 to V2:
        Address "make W=1" warnings from kernel test robot, comments from
        dhowells, and some kernel-doc comments for changed arguments.

Changes from V2 to V3:

Patch 1:
        None
Patch 2:
        None
Patch 3:
        Change to not re-use v9fs_session_info and p9_client in the
        v9fs_context structure. Instead, new structures p9_client_opts and
        p9_session_opts are introduced. This avoids confusion about what is
        used only for option parsing, and what is used for the actual
        mounted instance.
Patch 4:
        Allows unknown mount options as prior code did. I noticed that
        mount.diod passes a "rwdepth" option by default, which was ignored
        previously but breaks mount with strict unknown option rejection.

        Adjust variable names in v9fs_parse_param, v9fs_apply_options,
        and v9fs_init_fs_context to reflect new context structure and
        to clarify difference.

        Limit the msize option to INT_MAX as the old code did.

        Remove redundant v9fs_set_super function, set_anon_super is enough.

        Properly extract v9fs_seesion_info from sb->s_fs_info, not
        the fc context, in v9fs_fill_super. (thanks eadavis@qq.com)

        Remove unneeded fc arg from v9fs_fill_super.



