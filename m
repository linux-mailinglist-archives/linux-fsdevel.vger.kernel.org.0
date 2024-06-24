Return-Path: <linux-fsdevel+bounces-22228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C3914570
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9EF2855F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0E12F5A0;
	Mon, 24 Jun 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDL3VUqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4873501;
	Mon, 24 Jun 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219257; cv=none; b=Yo2enwfHjvRVf8B6fxtYYrZEdNaJLrycOkYkHqjs2zUmA5WQzkjJxogP4WJF1Sp9y4Buyi1FQrCdyYnG6wwOFG93V8koTer6Zdktm8zrieYWw5/9QGWFkNCAYRuTV0+Z56yxPsjynwyjoV0YxtvNOMhRXcm2PgIDCl4deT0FAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219257; c=relaxed/simple;
	bh=ohmEM9m42/wd/TxWYLsoFe7rjW2WX7rRc5MNewvWJ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPAixLgkZkEm9UsmI25YlvA7krNEIgsIwGMU166kS8wNzhAplxmSCjrv9uuKMbSWaVd2LVHkPQn9qw6Iph2U5ijCFNct9dXdERnDlUJdfkVur0uOrTC4055ZF4IQLFjwPaQatOlyZQtKzzKx/9C1K4glZz6VdGZLQMTWilre2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDL3VUqo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a725a918edaso64269866b.3;
        Mon, 24 Jun 2024 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719219254; x=1719824054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv+RV8N0QpN1Ud2s2pIRCR72Ahfy/aJs1kgG36gGrLk=;
        b=UDL3VUqoA0o0CECf0Y3473ua8ma8sNNOMM3PhMfWQcYF331ZjXIdk4aWTUqKvhkk7q
         FGkPWQ7U6yEDDPN+OZVkyxtXNJ3wBY2JrHi236PeriKTC2L9Ww8M0VmjFoRsYAQADKSH
         H/zJ79OBohLbBbuDFwZPaXInuNdMf291YacG7SIiD+Pe6TAURO00skz5NNVdbC6jmlQM
         1v2hKpjuT3mWcTIER5nf4jRVqbVALUg+yHxs6O1QYnZ62Rn6l4hMhI4aXnm0zrbLVlRQ
         PgoQb1y1J3r5IdGxhA5OOxGXJuMHX9LDkBb5HYut84YN4/VuVgXDVbxATt119VUMfENm
         JPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219254; x=1719824054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv+RV8N0QpN1Ud2s2pIRCR72Ahfy/aJs1kgG36gGrLk=;
        b=fIN3Vsh92j1jyjhG71Yck87/G3oYvPHQO8IywQLem9EtKyMP4bEJVJxroBM9zj5NX1
         k3S/aKvAQvlavjLmWOq3hBGmYDMxoJxNNc17MVF94EQGqqAKImlKIyXflqK5YpGSD3lr
         ilIQWnLHPKEQe3n80yujZEzq/ckv23mrFWy2bfEywvOFNTOkn1XfGlmALez0oO68H3CH
         O4Ioad+XppV1j2bHx50YkLwJLDYZPOxw/Vc0JkwWPfdf4xwizNnWOQ1+LZ9AGWrItroN
         FeiKowFPdvycpogeCSWIQDtb5xG/nKGCHWnGbqyz/5oPSb+D3EIeX4Ct2u/4nt4nw41h
         PI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkqyP78VBcZ+NdAFiVgolqIyzkWmTU1oFWUJ7j3VS2UYhVNqAtxuDO+NLWtbM61AK0G0IxEp0pxZlMxX0zDhleO5SYbQm4+H4akg4EJ9067VIKiBWFIRJ6Rw4gZXAELhwNYi8IrlHf6tUHTw==
X-Gm-Message-State: AOJu0Yyvaa8tfp1UNYtnyiIY3mssxgaEEbimOxcjnxaEyIO5OoMdeTiF
	aRVCxAkVrGKpWx0uctVt3/kzK7rcBiu7E+Ct1WDp/3bEUsRZhEGideV43qpW
X-Google-Smtp-Source: AGHT+IHxO+wFiekwRcIhzp1CPJgHEZF3oE57OtnkPZG236M1H3FMttHEXj+qYiiFlVl8qiHX6USccw==
X-Received: by 2002:a17:906:80c2:b0:a6f:d867:4259 with SMTP id a640c23a62f3a-a7245ba3cb5mr260877866b.26.1719219253603;
        Mon, 24 Jun 2024 01:54:13 -0700 (PDT)
Received: from f.. (cst-prg-81-171.cust.vodafone.cz. [46.135.81.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724fe52345sm126046666b.53.2024.06.24.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:54:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] vfs: remove redundant smp_mb for thp handling in do_dentry_open
Date: Mon, 24 Jun 2024 10:54:02 +0200
Message-ID: <20240624085402.493630-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opening for write performs:

if (f->f_mode & FMODE_WRITE) {
[snip]
        smp_mb();
        if (filemap_nr_thps(inode->i_mapping)) {
[snip]
        }
}

filemap_nr_thps on kernels built without CONFIG_READ_ONLY_THP_FOR
expands to 0, allowing the compiler to eliminate the entire thing, with
exception of the fence (and the branch leading there).

So happens required synchronisation between i_writecount and nr_thps
changes is already provided by the full fence coming from
get_write_access -> atomic_inc_unless_negative, thus the smp_mb instance
above can be removed regardless of CONFIG_READ_ONLY_THP_FOR.

While I updated commentary in places claiming to match the now-removed
fence, I did not try to patch them to act on the compile option.

I did not bother benchmarking it, not issuing a spurious full fence in
the fast path does not warrant justification from perf standpoint.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- just whack the fence instead of ifdefing
- change To recipient, the person who committed the original change is
  no longer active

 fs/open.c       |  9 ++++-----
 mm/khugepaged.c | 10 +++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 28f2fcbebb1b..64976b6dc75f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -986,12 +986,11 @@ static int do_dentry_open(struct file *f,
 	 */
 	if (f->f_mode & FMODE_WRITE) {
 		/*
-		 * Paired with smp_mb() in collapse_file() to ensure nr_thps
-		 * is up to date and the update to i_writecount by
-		 * get_write_access() is visible. Ensures subsequent insertion
-		 * of THPs into the page cache will fail.
+		 * Depends on full fence from get_write_access() to synchronize
+		 * against collapse_file() regarding i_writecount and nr_thps
+		 * updates. Ensures subsequent insertion of THPs into the page
+		 * cache will fail.
 		 */
-		smp_mb();
 		if (filemap_nr_thps(inode->i_mapping)) {
 			struct address_space *mapping = inode->i_mapping;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 409f67a817f1..2e017585f813 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1997,9 +1997,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (!is_shmem) {
 		filemap_nr_thps_inc(mapping);
 		/*
-		 * Paired with smp_mb() in do_dentry_open() to ensure
-		 * i_writecount is up to date and the update to nr_thps is
-		 * visible. Ensures the page cache will be truncated if the
+		 * Paired with the fence in do_dentry_open() -> get_write_access()
+		 * to ensure i_writecount is up to date and the update to nr_thps
+		 * is visible. Ensures the page cache will be truncated if the
 		 * file is opened writable.
 		 */
 		smp_mb();
@@ -2187,8 +2187,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (!is_shmem && result == SCAN_COPY_MC) {
 		filemap_nr_thps_dec(mapping);
 		/*
-		 * Paired with smp_mb() in do_dentry_open() to
-		 * ensure the update to nr_thps is visible.
+		 * Paired with the fence in do_dentry_open() -> get_write_access()
+		 * to ensure the update to nr_thps is visible.
 		 */
 		smp_mb();
 	}
-- 
2.43.0


