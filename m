Return-Path: <linux-fsdevel+bounces-20965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17A8FB80B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7571F21B15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21771465BD;
	Tue,  4 Jun 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdIqqpH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC9946C;
	Tue,  4 Jun 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516394; cv=none; b=rz1rwWvY9vA6RBF7sR+XqwHmPrs7YVuKY7hzr3RPgxSCqWmyQ2TMBHF064hdis1z7PdbuGVidQ+wJQ1vpKuK8i7tG6qKf5EO25A4X3oB6DrhR3EWSMVN1RxxWOu99s3f2116VE7Vwyi+6RvG2hyO03nRU0kAeu0sguP2Uc3rS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516394; c=relaxed/simple;
	bh=aSzmxffLT7xQZWhpjpSVznQm9u7RY3I60GUWBZuzKb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSFgrPckardychhDLI4Jg+sJ7FgjIKt5lOXMtdLnQ5YbtDpTMoTO+E4z+HN03zo/UL8q/pu0z8YamIY+6+QhTQzu6uZ9YW3B86iRFYv8Qk1suod4GFMM28oxrB7A7QEUETSEENvJM0qF2y7u1eveNpeCQGr6y/hqOI+GRYuGzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdIqqpH7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so3767144a12.1;
        Tue, 04 Jun 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717516391; x=1718121191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLWnc7JHma6VN/R7uX8zeGLyZqDO4slq0l0l53iTXbI=;
        b=HdIqqpH7HV3Kkc/62R7E36BZz39krUl3EcMsn2qSbc+HTTWLE4IGx8YvgG+LhV8y/f
         yawCwGK+ebJbQbDvEsttrux8neTxp2BRsq1OmA5hMxi6z6+48anc9xtq0DaMTk2xSCKa
         wUGSW/uHAc2gW+MdJ2uMWgZhMiW4kxkIGZilhpvoM88i3UY3lSjw3nJGF/cnJ9LHrbeK
         LbRYSNu/UFvfos2KifXp1sVPpsHdSlAVhT06GM5It1k6ur67Dfsd0ySTHpxVl9U0ntlj
         lceymvz9ebzG92NdrNsRG00FoHK88oZeOEai6A0GaIZUBIM0FuJYPOllgK8/C7oYHNKf
         /RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516391; x=1718121191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLWnc7JHma6VN/R7uX8zeGLyZqDO4slq0l0l53iTXbI=;
        b=TUzgdFwgUJM1NYWiXbWU4A9TUUGEg0fVZxytqzasO/7B9t27PMkBaBpspXhFZkcsDu
         NIfpfe/50RZ8A5MK25lBrtrQmNRSPBoZR+pb5I4iEUTlTQFylQ/Nwvl9k5KINcI1sWDA
         mG2ih8IFVpZFdCciwU8/2k/dM1j8qfbmXxbuDt9LqWfj0wOY7fAE8NSa/Tz9GRGmJ3eW
         U7UQDEZgxcBzamBsLjLoFDuBzYkCfvLlVEnUQ0R9Ntsjma46OSU1SH+rAovRwWyUvyaO
         97s+dNMW1Qo9LTSXZDjy6VlHYVFEAU6MNbudx24JvWsYHgMK0dqvWsjPuvdegiDFSZlk
         Dknw==
X-Forwarded-Encrypted: i=1; AJvYcCVu9ntlWrNpVtsmfPnAAsZFeLz0rlpSxQAdS5DWS04gbroaRy0sPv2FjB73Uf7czW6ghKJkxXkc4APGFF14j8bUvan5GGm4IRaisMyOWOSauLPR6XiQkT6SNFtsP/EzCjJ+6sVLhRHq23m4Ag==
X-Gm-Message-State: AOJu0Yyg31h/O2/PUMfjlwG+twM/DuYJ3+EC10NlSiU+wWONtUHaG7Ab
	CT8TxRioWvka6G4VGE/3wTxIPADyJF0tiODpFXqxOj04XeHosbAn
X-Google-Smtp-Source: AGHT+IGFZ0l1gtDovbb086G8tFW/Ft2wcKlYGv5ipkwKsDOEVzD4v7NbKDh7A4tzdZgBoLn90tYWhg==
X-Received: by 2002:a17:907:8f0a:b0:a68:f43c:57dd with SMTP id a640c23a62f3a-a699d63f681mr2013266b.23.1717516390844;
        Tue, 04 Jun 2024 08:53:10 -0700 (PDT)
Received: from f.. (cst-prg-5-143.cust.vodafone.cz. [46.135.5.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e624db7esm423380066b.66.2024.06.04.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:53:09 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/3] whack user_path_at_empty, cleanup getname_flags
Date: Tue,  4 Jun 2024 17:52:54 +0200
Message-ID: <20240604155257.109500-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tried to take a stab at the atomic filename refcount thing [1], found
some easy cleanup to do as a soft prerequisite.

user_path_at_empty saddles getname_flags with an int * argument nobody
else uses, so it only results in everyone else having to pass NULL
there. This is trivially avoidable.

Should a need for user_path_at_empty it can probably be implemented in a
nicer manner than it was.

1: https://lore.kernel.org/linux-fsdevel/20240604132448.101183-1-mjguzik@gmail.com/T/#u

Mateusz Guzik (3):
  vfs: stop using user_path_at_empty in do_readlinkat
  vfs: retire user_path_at_empty and drop empty arg from getname_flags
  vfs: shave a branch in getname_flags

 fs/fsopen.c           |  2 +-
 fs/namei.c            | 41 +++++++++++++++++++------------------
 fs/stat.c             | 47 ++++++++++++++++++++++++-------------------
 include/linux/fs.h    |  2 +-
 include/linux/namei.h |  8 +-------
 io_uring/statx.c      |  3 +--
 io_uring/xattr.c      |  4 ++--
 7 files changed, 53 insertions(+), 54 deletions(-)

-- 
2.39.2


