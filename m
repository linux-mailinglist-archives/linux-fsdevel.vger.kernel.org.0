Return-Path: <linux-fsdevel+bounces-41288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C21EA2D74B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1964C3A74AD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A411F30C5;
	Sat,  8 Feb 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHm5z3ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD151F30B7;
	Sat,  8 Feb 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031985; cv=none; b=tgJxtUPfWqrU7/2XSV6zobt1GdPkqZbcrnd1AKpEYmkNFGbV/y6bN7RdPsCJeMrTBoALihxNFQ4VE5KWlkx3+bVfAyqKZE1b0r2OxBlbMXdiMPk9OcgCUhXXLgOjF892ps6wf9773lYDgS8d0MJ0yw8R2JOmSA2hlVdSsLu0j6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031985; c=relaxed/simple;
	bh=Mcw7j0ie/urAfl5vPu7xyM+/xQK3oGqkPv6j3lYhs/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8IvCyvW4z39cF4NSChqnQZa5p5IYVWgE++3r+U3Yjyza2ZlemhRyMcJWZIsLMQIdt92g/enSuMoyJ4eLWOs5K9/IlG7A3owmlYbrEu6Gd5gnd8h+EPDHTiMyq+1OuFS6YjDXNCS67OP1q5WGbmNa+3pMonmmE4XjObfsd0pgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHm5z3ig; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3424319a12.1;
        Sat, 08 Feb 2025 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031982; x=1739636782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkCXXh48JMCbajqYZdugEa9dJX77WDTXFyIk1OBCEMQ=;
        b=JHm5z3ig1aonlB0irrYbO+ryNdEYcIb+o3AYzVOB4547M/xeUVUOipGlrPOZYnoiuP
         mLsprXEhqLOm9HACSbapvFal+DBSBkwAVM404corsv8yDVP5M3amqNske0h1fqK4oeXu
         80qviWunOgls44EM1d6MuG+VKoAM7tizehPiJ2ZLqr7Bt9tPlp6wD7N75KbwRCCKdgYc
         9l2agSe4lGn+L+ky4UZ67AMja3SxZbF7nvkOAD1dm5bPhB0tQ+b6uy6uedNm7G73aUPM
         /n0+f3nIwJrfELOWZAt6XxbydTw9+zFLqxfnH4qruzsCKe5PrmyihhFm+2Nz4rdlrHrT
         P5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031982; x=1739636782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkCXXh48JMCbajqYZdugEa9dJX77WDTXFyIk1OBCEMQ=;
        b=cPLdVuMCZUhw72cvrAedXgI/3TA9+DvNCN7cDnv/gCVDOb2H7KZX5pEgaFkuBRdx3l
         ISIhzyteX1py3rJmbHFksUHfNXnJlkW8VHxouumY0SmTB+8N5d7ONprMB1OGj3W0VPpg
         IwnKIZAR+mTxmYb5tS7VFpvMr84BB4JHML06WpJO+WomRw1storBB4wW5q+V9KsHjcHq
         Xe/nHuMzq9Le8ZjTtJtJzMEXKUsRA0Dmg6r27C+fppB1wdXV9qnzhdyTkavzBRFnYrEo
         ps7ZOL2KRzdYkDzqjLKRQZu4TLdW6v89HYHrmmwip1PjLLaioYKOdWvI/nkxCiKPb1bR
         1/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUJR0dkOijZ1ZBd3AJD1B52dw/+LlfFn+vX/FipQTzfjVSOw6ICG1Q24cWlk5y2WDUVWVYaYClk11XLMSGz@vger.kernel.org, AJvYcCViohrzzNna4JU3WZugMOW4zSXaaRVH26Te8Gnz/Bdxgy7X9N+zUJgLJvJMmXc1UhIuZOspg8kWr/RKLag9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1whQA9a2begCbH1QN2eoT/L2aOabwzL67arax05pyDy4Swwdh
	yTvQ+OCrCstF5lCQioU2nH+zckMYPNjX3kuaNw4CvDhtnln2+Y4PICbQXA==
X-Gm-Gg: ASbGncuGxcZZHmGgH+gMfcDUARMeXC9WLjWmcrTY6Ew5L7RlPpuz1JKZiaKhU309MIA
	9ik+mGcEJTZ0aCUNj/fExgI6Lp5ODnUNwJHLD1TCvOWa64JRZ6Cio7fcLt6Iav9e6KLQiRGdvYe
	zem1NmpL0lorr5Msqj+kpgGOLeIbThxvcMZFWy+/9/CmZZA6iPqd4nWxrxofGyaKu9VTi4LTYvu
	Cz9kyN4mK7KQGHTL5ZuhS/l6G/f0+aszrKsTUZlHd3oUcVpPAGG/rtm65b4OVk0/tVJ8GKoVooj
	u8+OpPnK0WK4SdWH7SNE0R01YHby8dSdLQ==
X-Google-Smtp-Source: AGHT+IFmsglSzYbPLk3UpNrclfflTnKL3d80AbtvI21c4XDleOJxjf2B88kBCdANVjxDOOn74gcA5g==
X-Received: by 2002:a05:6402:4416:b0:5dc:c9ce:b022 with SMTP id 4fb4d7f45d1cf-5de45005a55mr9018076a12.9.1739031981726;
        Sat, 08 Feb 2025 08:26:21 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de47d6461asm3193943a12.74.2025.02.08.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:26:21 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/3] CONFIG_VFS_DEBUG at last
Date: Sat,  8 Feb 2025 17:26:08 +0100
Message-ID: <20250208162611.628145-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a super basic version just to get the mechanism going, along
with sample usage.

The macro set is incomplete (e.g., lack of locking macros) and
dump_inode routine fails to dump any state yet, to be implemented(tm).

I think despite the primitive state this is complete enough to start
sprinkling asserts as necessary.

v3:
- move dump_inode to fs/inode.c
- s/failed/encountered/
- pr_warn instead of pr_crit, matches dump_mapping

v2:
- correct may_open
- fixed up condition reporting:
before:
VFS_WARN_ON_INODE(__builtin_choose_expr((sizeof(int) ==
sizeof(*(8 ? ((void *)((long)(__builtin_strlen(link)) * 0l)) : (int
*)8))), __builtin_strlen(link), __fortify_strlen(link)) != linklen)
failed for inode ff32f7c350c8aec8
after:
VFS_WARN_ON_INODE(strlen(link) != linklen) failed for inode ff2b81ddca13f338

Mateusz Guzik (3):
  vfs: add initial support for CONFIG_VFS_DEBUG
  vfs: catch invalid modes in may_open()
  vfs: use the new debug macros in inode_set_cached_link()

 fs/inode.c               | 12 +++++++++++
 fs/namei.c               |  2 ++
 include/linux/fs.h       | 16 +++-----------
 include/linux/vfsdebug.h | 45 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug        |  9 ++++++++
 5 files changed, 71 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

-- 
2.43.0


