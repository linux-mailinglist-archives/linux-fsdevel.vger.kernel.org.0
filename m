Return-Path: <linux-fsdevel+bounces-35481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1969D549C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8B210D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582F4502F;
	Thu, 21 Nov 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGDEzZWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B041C79
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223899; cv=none; b=M/AA9VyOSLdeBfnngkSJsKZUgyNGKz9Y+N0sNrRJS4t1evDCKqJf/a4Kmn5/7G2r7OluxDQ4b7oyfUgtP0zx9N2jCw/07huqio/dVm45ybEeU4UCCR7OuaSNn1RWD45jp12pbmPI+DI43bAQUO0d5ydsG/r+MDosu2YlpW84F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223899; c=relaxed/simple;
	bh=W85eqoig0N5xXFsA4zJzJxB3cbCQC2wO3Db7Qrszu5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hmcyaYgvMqPlm3d+QI6c9E/qTEo6TtP1ZzAaoWROaBXZLS86hkRFhSb8pUOG8TF2hhFecwOZRTxXT8zgYaCU/FUehqlNuu6Efxv53boZXGzkZhTh6sRBKDinIhjdJTs7P9llYVGxqfKCGw8ldXojKR7+XVdv+X79cnml9ph89Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGDEzZWt; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a76156af6bso4845565ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 13:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732223897; x=1732828697; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/mfZKTQyhXYaUJseYy1hv2VeyJ2+oQyIuspaPbvuUY=;
        b=dGDEzZWtwVd5ePSJZdLufK52ZyRtlp46ZZtj0p5V5pybVwzWsqVbOJrcBGQvnNE9XS
         LyLnHndot4+V69IJLSPAKFN8LKkQ0AqcDk8TS9trllcBcnLS3JcO/AOLuhQ3eDLdZkwb
         8Z7XKRpGNBCNaN+QTN82Q4/LMYGUQXbOrf3WV1knKjdmtqb9wi5akXympIwjBzqsORtN
         jnjtYDjOrOyfaH4BGjZV3Y4xrYpZk+2uc25UpEdSPCdt5pErH8ck/SWSuj0FOer34Mti
         oE975uz3aIt0VV+CgH3KroprP/PM9yVW0bb4WdgYaG8GOEYIxYpqbWH4y2BoJjnG4z4M
         1mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732223897; x=1732828697;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/mfZKTQyhXYaUJseYy1hv2VeyJ2+oQyIuspaPbvuUY=;
        b=DKHGhq1t0SatFPKI2PBv3fX8Gvm83UoG26pquUTaNJ+XUMCk6maJZLIwYGBYPqzjH6
         h+ee8o4yjbLprbw2Txw/Wu6veIUULWNXZtKBYlS9Yzyzk/6r+2iy9dJR7o5vnsPXOljC
         l2CK/GNvNCAKd4TXf0KcRhnq+eLEZgQxrV1wIxkUp5A9M9il8UNgcq79pDBpMxvetz65
         Xz9v1kiHPTIw0fBYEN35N/wd6zZkFChODzGrE6LSmYM8i93y0mB+PBasUsUxnShdDLhg
         6Jm0T23yGnIlH3irlwRricYspQq8u39JoRj0WtPLY1jsmnHj4ZCOgHx2vx2C82fsXrct
         3szw==
X-Forwarded-Encrypted: i=1; AJvYcCVLDXCpvoyqchfuSoqu9xLrzCaVUTLmHq4/NlgRYgcPTCSPYq2zKT7ntH3nZPnaJKqENai4KLmXLlxb+IZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DTyie5XU5JOXkrhmjU4BKTBuTGd4yQp+YmObBadsRTMJmvKa
	pC0MCA4Zme0FImKIMd/CNwNiNlNufnOT7xrOUOjbPQUI3s1ZKvT/s/FVbZqMkQ==
X-Gm-Gg: ASbGncskv6TczqmG4nDBKxRoOuAiHYxY9ffN9+y4YPTtYlQU7LRcqMxeBKTEzodurjN
	idRWAJ1yD8DpRTDseg9mEWQR6TQ+NaaaC72acHH1Fk9HqkuIS4WQuGU5g/L3WyvoL+i2AoRejN+
	0YFQhN5XOvmNtjVt2TJWstgD2FjHO1blIcL5F2beLtaD9CfUJ/yOuBSCGrQH2Np5NP6HD3Kj2Ry
	KCIA8Xxk/yt5estaRlmPBXcYfPp9z4Swjy88CS0Lzv1GMZCIr663RLA/dVr7shRQc2w3kmlxfpD
	YH2seIandS6prLB7Dz2t4d4gTAwmJh0aZw==
X-Google-Smtp-Source: AGHT+IFQbPCB0rHPhnpYbQiUEs7w+N6lvukYSgOaD6CKsx8IKXq0wMfQEeUnhxgXV8pSGffrHgVZTw==
X-Received: by 2002:a05:6e02:198a:b0:3a7:1b96:220f with SMTP id e9e14a558f8ab-3a79ad03f38mr7548595ab.9.1732223897144;
        Thu, 21 Nov 2024 13:18:17 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3fb2a7sm179889a12.77.2024.11.21.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:18:15 -0800 (PST)
Date: Thu, 21 Nov 2024 13:18:05 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Chuck Lever III <chuck.lever@oracle.com>
cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
    Chuck Lever <cel@kernel.org>, linux-mm <linux-mm@kvack.org>, 
    Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
    Hugh Dickins <hughd@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
    "yukuai (C)" <yukuai3@huawei.com>, 
    "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
In-Reply-To: <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
Message-ID: <63377879-1b25-605e-43c6-1d1512f81526@google.com>
References: <20241117213206.1636438-1-cel@kernel.org> <20241117213206.1636438-3-cel@kernel.org> <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org> <ZzuqYeENJJrLMxwM@tissot.1015granger.net> <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net> <20241121-lesebrille-giert-ea85d2eb7637@brauner> <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 21 Nov 2024, Chuck Lever III wrote:
> 
> I will note that tmpfs hangs during generic/449 for me 100%
> of the time; the failure appears unrelated to renames. Do you
> know if there is regular CI being done for tmpfs? I'm planning
> to add it to my nightly test rig once I'm done here.

For me generic/449 did not hang, just took a long time to discover
something uninteresting and eventually declare "not run".  Took
14 minutes six years ago, when I gave up on it and short-circuited
the "not run" with the patch below.

(I carry about twenty patches for my own tmpfs fstests testing; but
many of those are just for ancient 32-bit environment, or to suit the
"huge=always" option. I never have enough time/priority to review and
post them, but can send you a tarball if they might of use to you.)

generic/449 is one of those tests which expects metadata to occupy
space inside the "disk", in a way which it does not on tmpfs (and a
quick glance at its history suggests btrfs also had issues with it).

[PATCH] generic/449: not run on tmpfs earlier

Do not waste 14 minutes to discover that tmpfs succeeds in
setting acls despite running out of space for user attrs.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 tests/generic/449 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/449 b/tests/generic/449
index 9cf814ad..a52a992b 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -22,6 +22,11 @@ _require_test
 _require_acls
 _require_attrs trusted
 
+if [ "$FSTYP" = "tmpfs" ]; then
+	# Do not waste 14 minutes to discover this:
+	_notrun "$FSTYP succeeds in setting acls despite running out of space for user attrs"
+fi
+
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"
 
-- 
2.35.3

