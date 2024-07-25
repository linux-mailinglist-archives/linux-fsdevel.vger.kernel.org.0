Return-Path: <linux-fsdevel+bounces-24268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD193C83F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641611F21C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC491F959;
	Thu, 25 Jul 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lusWgJQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45120DC4
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931609; cv=none; b=ObA1qTCvgUxk2/Aaeye4fVCDz/4ss5qeox9S7GYjWA9a6sq+gslegt/FAC5Hw4dzDw5Q/INw13xze8R0pggI6o0ZwJTc9Jo5Q6xRmMh34IMjZ3t5eRNQpkrmrvk/DTeuUEVqu7zmjeAeBs3VVQ31GNG+EWDlp5jYhMBDUgNUr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931609; c=relaxed/simple;
	bh=pphRo5cAIY6sXyWotHh3OYUODOC3SG0MiMZJ8lGUQvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJuTo4c4iclyutEgDc874p6zyrCZOC6d6/RoDdwuXHVqbccEvDlbXKpJrBaZxAXM/dvFz8RZLoQtO1fWhiCfPlNDS5ReRmu4oGRbP6M9TQzRqy+gGoUDU5LXJ9dQM6q8C/xjQL/6Q+RUokQ0dPFRMcqBAio1TQM14p77tTprsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lusWgJQ8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef72bb8c8so53928985a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931606; x=1722536406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV/bmBiugHCOGdiwdB7fAnf5wKaKZzTHXbldMI40hCY=;
        b=lusWgJQ8G5EkyqV4Kpdqc3ZKtn9kh5xweWYW0lPNyRUVTb/VVtm99q2eb6MFJrL3ZY
         cDKzB+ysV8cncqvezsgdsHxj177sihvffGaGDD5JjfD/TRVjb+5zDVkeKfrytHYB/NEa
         +lLPM4Mu0rjy+x8+NF8mpi3a9EKk0UMCJ8U+RwMFGf5qOJxW8dGDh0iSSUdbVWqtNQPg
         Q2zwk4pulYjq8oTVvHo4W3X1S2QPMtUv5YOxrsD6ZAtqsxLCDzJLSULitUByjPgpXTuW
         UV9XXeu50yzN0JdNE57bOCKvWwvfYwPYKHO7QrIQqOPB6Ul4xHW0n4+ITN7Da0LPq4Hc
         e7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931606; x=1722536406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV/bmBiugHCOGdiwdB7fAnf5wKaKZzTHXbldMI40hCY=;
        b=ZaAgLDS9pYRmSAJqAxH9GHldbSLTadmXbcK0+tG8tDIaoxhO8BV+INXbhOfr6xPe2P
         zcHYRPKmUfI4Wcuhjz9TUCiUTZHE8maW+cs6gpXjavxRJAc7O2blzyPMZMNF4MXfjqZT
         BzhMUc062XEWRCByGFU9o7u+fBRzOHCwOw/RUE/ohXlOFm/ioq5d6UDsSNX4L6VUgTPV
         vYWupQZyUfrwPy+dFvuy9DSDIahBHbi5S9FZ0DfozLc0NKjl65Un8mRMkXRvryF88BdO
         42mlgx+4E4FVbQIcWeLU2uuF45DC3umCPv5PrirIvT/ca8LxMmnp2Dwkd55+GqsmknLE
         xcOg==
X-Forwarded-Encrypted: i=1; AJvYcCWm5/h9RNPC9PbiKxWLzuFU9VgjMZR5r2Fgs+ImxPNDi1MpKFZ3xPq4Lx9rlTJCP6ukRFrj27Armm3UbsWfGP2LUljpT71WAzf+6ksVuw==
X-Gm-Message-State: AOJu0Yyfq3Dn4NppU+r/65jQEyXfQ+FEVIssVNZ67kDv8i62WnBmJgEW
	RqMeUIRcmqxyNWMKHni6f4l4HF7qyYBZ+rlMCxwFt8KrqJuTx01QZ68AAVdxSgU=
X-Google-Smtp-Source: AGHT+IELXQ7B9+k1ZTU3Sizt0MYEBuUZnUCAaAMBn1YvGurbHD8m1hnaNkZOSGg5HBUpEJNFO8frnQ==
X-Received: by 2002:a05:620a:4041:b0:79c:9431:f71a with SMTP id af79cd13be357-7a1d7e1415fmr366916985a.11.1721931606257;
        Thu, 25 Jul 2024 11:20:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74354ebsm107200485a.95.2024.07.25.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 01/10] fanotify: don't skip extra event info if no info_mode is set
Date: Thu, 25 Jul 2024 14:19:38 -0400
Message-ID: <adfd31f369528c9958922d901fbe8eba48dfe496.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously we would only include optional information if you requested
it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
However this isn't necessary as the event length is encoded in the
metadata, and if the user doesn't want to consume the information they
don't have to.  With the PRE_ACCESS events we will always generate range
information, so drop this check in order to allow this extra
information to be exported without needing to have another flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ec313e9f6e1..2e2fba8a9d20 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->fd = fd;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0


