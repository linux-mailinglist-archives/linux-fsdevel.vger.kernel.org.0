Return-Path: <linux-fsdevel+bounces-57194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29633B1F858
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5FD1789E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D31D61B7;
	Sun, 10 Aug 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbsOeKm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB1B660;
	Sun, 10 Aug 2025 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801293; cv=none; b=huwgzn0Vg2JVvn+ggZw44SXdRP8i0iFd4vbOKyduZxRjCEi3jfL0+b1gwGgfxMzRJTF98knGtls9xD4EWF+5SSJr08Fp6Mwwv+ATszm1Nq38QHS2hr8KYmZnxPHob3duKq3GASQnmj6yPZS0MX7VFD2DK4OGKgGlUQ6UA6IKirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801293; c=relaxed/simple;
	bh=wfpf9ZbirFcXH8c+qYrEACdr88BC5e2ObwRAJAJki8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZa6jkJe5q2efW96VXliRLrHls6F7lmLAXbPd0uKguCz0G/Ym4/Kb8hpShGXBDwWHYFUogE1HPFIC5WNsn8KNT4raNl/lopME8p1HNgw+skVXLXfyXZ584cn1xMOQo3FCYDSJvcPA0VfaOyeDat+JgAphxlCi8fD2dV7Sku1u7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbsOeKm1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2403ca0313aso26986995ad.0;
        Sat, 09 Aug 2025 21:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754801291; x=1755406091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkKfdo5HSjaHQ96VOApl89ja6x95mC251RmFMbCQL/w=;
        b=hbsOeKm1cJ3eczBqHMarmmco2gsOz+8vh7lbo41lu34VQYFFWTxfUxMk4hN3vf6cn5
         sr3uqY+A4yzUoQRowOzdNsRFVcRjpHb1omuAXxXnSvtn2M5aftHS1a3lfuc2I4QMOdiL
         UoAHlpW88IioflK3RLzgxiThW9QGTgyPaQv7mHZ+mIpGqNIFTv+4Uve4NGi7UMnH3auB
         YaDPI2KdH7vo1Q68BdAb19zh+Og7P8FZiG5cWs/C5SawYJUhI9EfFNR/b5a4EMf/nrbG
         6p3kjsiHoNJn23CHdoE6RgaQUpVmQLIBjIrqM6MSo8CTyxaVa33z1XpILQEuJERr1lFq
         kjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801291; x=1755406091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkKfdo5HSjaHQ96VOApl89ja6x95mC251RmFMbCQL/w=;
        b=Q/zfBRIisOw/OBkylm3plxPjm9cugq3baCRYwiou3aQUWAOUa5Y7ni6RK1qi/vl//3
         sDDmllcU5048kTEhwlYXZViRfbqOBuHxRqUtt10dxVtp4R4QVk/JHAn6VyVlHKzxXda6
         /bBANxOtqx98ZfEhKFNOf4UPGpRFe+e3R90KCbwQG5hIeddZw0JUTuF/q2Y3FILC+pXs
         PaKbXTqEjbIVmqLGuskkqEjbKxbzvRyyq4j1XMzGevGLjp9T0ZWx500rc51u+GQUkpDx
         Fm2sGUedD1QxPvQ3jI0QUmLKFyFhFJ+wzkJ9F+YqPO3/lYoQbknJzSTm0A2FNNlNqqal
         KdvA==
X-Forwarded-Encrypted: i=1; AJvYcCWbFJdF7tCOAY53vVm1bUwzqwB+q43/s9VpHn5ihAmMlbON9jZN0SgAH4oKTP57o8IOqKexVI3BK/2qjisu@vger.kernel.org, AJvYcCWxbmUFgoXtv/auY9v9WQjsqbnjY5bNgnhEup8nWy1NBlO1PxrTzksfGiNnWRXOQGkb8qRGvoB5FEBNCxrK@vger.kernel.org
X-Gm-Message-State: AOJu0YzatgUQD7H32INYEoMnAT/e6+m8POcd/jcAEf0WKiLq0dMVwVO1
	oxfHE5X9eweIL9RKxI7Z/xGvE2UzXwJdKSn8xtyewyIrqbycAqCKzrctufSOAWEJ
X-Gm-Gg: ASbGncuk05o81oPgknikhuiBe+/Kb4sSfRq00lmt5x2sTLAnaGS/Q/IaWysz0sLHU6C
	T7zeTwMatzrhSIX6mlM+++qruUB2i1+iggK+U4hGg7zFVLWt0oUSROLrlkOo+sVD15Qyp1yo8UT
	lBlyuv8AtRjp1eHBsfVNFEhW/+wb8PyJs86upwRLyEMcWq7s/W5OhcnshtNimWycQaDO+24FblL
	Dklp0ZBuMkgfCcK0HOtIPTYc7YyX9BktIdYQPJ3MNrJgqH7MMrtxWrK8E1nWyJJWRoeUym9m4Oh
	YK73a97RjFjTmAowbF+IA9WovY+PyGx6VcmD6j5qliC6kw/uaOvoSMWFERPRuuP8xGi8LxxyXZH
	eTmNZOUh+1ZidvaPdhKfultFsc4tPM05dT9o=
X-Google-Smtp-Source: AGHT+IFOH2/dsnWPM1u6i/BJU9lEL2p9pj3eHZ2JBbhjIGI2JU/wY1OF9bocjBt0OMpa0ZKygbLe+Q==
X-Received: by 2002:a17:902:d4ca:b0:240:2e99:906c with SMTP id d9443c01a7336-242c209fa2bmr133509025ad.15.1754801290784;
        Sat, 09 Aug 2025 21:48:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm244113645ad.113.2025.08.09.21.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 21:48:10 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 0/4] iomap: allow partial folio write with iomap_folio_state
Date: Sun, 10 Aug 2025 12:48:02 +0800
Message-ID: <20250810044806.3433783-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

This patchset has been tested by xfstests' generic and xfs group, and
there's no new failed cases compared to the lastest upstream version kernel.

Jinliang Zheng (4):
  iomap: make sure iomap_adjust_read_range() are aligned with block_size
  iomap: move iter revert case out of the unwritten branch
  iomap: make iomap_write_end() return the number of written length again
  iomap: don't abandon the whole thing with iomap_folio_state

 fs/iomap/buffered-io.c | 68 +++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 21 deletions(-)

-- 
2.49.0


