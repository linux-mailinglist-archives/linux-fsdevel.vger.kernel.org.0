Return-Path: <linux-fsdevel+bounces-72409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3ACF5A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 22:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6E930D2EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42B2DCC01;
	Mon,  5 Jan 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXXPMzF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287072DBF75
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647940; cv=none; b=byXhX0PdtIfJSQdaYvXmmPfv3pIMajaAWuFIMw1MptoxQZZKZ25a8uxXO8rp6pUe5nDd7TdHYzNOdTNBXykFOo8LAtCbkJ4wB8TGm+3KwHhZPcmE3l79h9OgBME+s451VKyNhG5O5FButyR6oiLiC8NK2GkfomyxuBLkHOjBcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647940; c=relaxed/simple;
	bh=DVCupxP+x6/SB5NirDNkQjozPe2gCHPoUnDdopYyWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFu0BO1w0ASuoCsBDUbQDAks7ZbutvM/Fk3mYagHXlTpgcHd4HBurmQGloPaBWzvUzNeC6Sya7fdEvhshRr8K6CuZkGQ8OOfNhUQ6j+5KH4VLNv7OpGlGBe2/M++6I/wb0iz2yaRlj+9cnzELJt/IiFw/Ilnbb0yO2hjgUMAdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXXPMzF8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so411105b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647938; x=1768252738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7z9UoHroCTxVDF2qFY1VGhcuFpUDlTlobm9HJWwlN0=;
        b=PXXPMzF8GgLBATJzakjRRBd6GZ6cPBvd6xaEeqy0ef5rKOIPctBBURW7HX+l4v5F/S
         3C2qZGEuRWvkkd3eHu+Un5lnAjdQV3ZzE/xjy01eS2p9sDsMD0hlYfKAD+rTj1Ut2mUd
         gnLntOnLj/d2ZjqvGPBqHspaksPsMOAY3xHo2f0E7HVHX41zA44qA92Cv+fPVrsNYOJr
         P7g9J7FVVPDdQVnU43QbDdNmMm7/wBzMBraIcnQckupLiQ9o9E8oTuKzkU8YWrQR28nv
         02pQc0CHPMiQ25i0jVDFiaG5qU5dWPZaYm4Xtzcus7niCVYUzkopy97hOQHPnMwkrfML
         UzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647938; x=1768252738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7z9UoHroCTxVDF2qFY1VGhcuFpUDlTlobm9HJWwlN0=;
        b=hGn1nlvCBGMfYSvnuOfOhBgONGgwqruFKwIedTq3Vt5Xyi4qd0xpidiOv/8SaclFGH
         ZD28F7QlQ0Aert5GhRSvnIorlYru6DbyboX53ZaaaYSfo38NGXVN9oUkCLxqa/Rqn/N2
         io7c+XBsX4OWAoVZtiQj1U2rqAjmsVSG8HO+uwBygGvOy8DbLLO0JGp9tLjleo1Rwj0k
         /cPNcl2IGyhy2LFk7lqluqbc9HP7P4aOblEU08ZSZYH/2S2qPOKSsXXURBksIUQ6BWDJ
         ImMYI60mFOofBgLvQLybD3WmLe/GytxQBtJJgihZo95lmWkfFtOgviw4PKGIKl0LxFy5
         m6iA==
X-Forwarded-Encrypted: i=1; AJvYcCXZVrOAwq/7FVf84PMZVputRSTvmMsVrLafgQPZeTG6EoVHO3hh8I4HJtvW8q+GNAdeJCdJa735vgGw4Fft@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+QvlY1lNFiCHzLI25nb8cvJN08zAYZSlfdco14rluFC4NvSh
	2g4seud49ldgfpSZ26PsDGLYRS+2vB5iFLAXdjzl0ENpLCtdX4KHhQkK
X-Gm-Gg: AY/fxX7DAFLODmeV4Kb3wMFpNyvuxuzCKruiF2aBOEJRFd9oi0MK0d1Sb9s0OGF0TAd
	D88K078dljh6Y4fLfWWctAuos2KPR5WpnZgySSqqvHtETXgi6ACSDgoFrxeq+3DfUePSTH7tC8T
	8DOdX9i0rnelql6/C8E48sQZBhTfubn4sMWLJj/g3P4yrGihdQ2RWiymqCH6ybkiw9U7UXmehsI
	E6mZGF+VQG4SQd96ywyaKvNbsd4P+e7N0oueZB2Ihm35KRyk6qmjbOocHfjF2d92JC+2+oweXUC
	StqD1ImIy+pTILzoiFp88nV03uiJtLJO+f0cCMy1wwalw7E3kInJFGdqhC+CCM7ex46XZcahVNi
	7BxfZMOtGEl58Xc/fNh7/EUuC3NMnB25Naq/PjdF9HWk2Q25kO3Et8T+m4g1VPtpIZmuDWmwIrG
	gHZwp0mMN2aiqMz9c76Q==
X-Google-Smtp-Source: AGHT+IFlZ2+kUV5KG/60Xe5C7ejVmwoBKqyiJE5D5k+mdOkyc6xWlkvWTjlN7kZFePbx4PtnaXnIZg==
X-Received: by 2002:a05:6a00:340d:b0:7e8:450c:61d0 with SMTP id d2e1a72fcca58-81882ed4e7amr858139b3a.64.1767647938441;
        Mon, 05 Jan 2026 13:18:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa19236sm87839b3a.2.2026.01.05.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:18:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Mon,  5 Jan 2026 13:17:26 -0800
Message-ID: <20260105211737.4105620-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new mapping flag AS_NO_DATA_INTEGRITY which signifies that a
mapping does not have data integrity guarantees, and skips waiting on writeout
for these mappings in wait_sb_inodes(), as these mappings cannot guarantee
that data is persistently stored. This patch sets this flag on fuse mappings.

This fixes the userspace regression reported by Athul and J. upstream in
[1][2] where if there is a bug in a fuse server that causes the server to
never complete writeback, it will make wait_sb_inodes() wait forever.

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/CAJnrk1ZjQ8W8NzojsvJPRXiv9TuYPNdj8Ye7=Cgkj=iV_i8EaA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/aT7JRqhUvZvfUQlV@eldamar.lan/

Changelog:
v2: https://lore.kernel.org/linux-fsdevel/20251215030043.1431306-1-joannelkoong@gmail.com/
* Add comments to commit message (David) and to wait_sb_inodes() (Andrew)
* Add Bernd's Reviewed-by and J's Tested-by

v1: https://lore.kernel.org/linux-mm/20251120184211.2379439-1-joannelkoong@gmail.com/
* Change AS_WRITEBACK_MAY_HANG to AS_NO_DATA_INTEGRITY and keep
  AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM as is.

Joanne Koong (1):
  fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()

 fs/fs-writeback.c       |  7 ++++++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.47.3


