Return-Path: <linux-fsdevel+bounces-18883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549E8BDD93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9624D1C21BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AF14D708;
	Tue,  7 May 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajblN9RE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483E10E3;
	Tue,  7 May 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072161; cv=none; b=m/ypKVGdJ3HqDjf1Hyj/AHPdDWiNwPGwcBqOdYnyRRdfh3u9TfycTawYSIbl2ONLjSamX9Nm5wn5icMzkZGGEtC9iYXgExrmGL8L+yWikWFbvw9uMe5wziN5IaKlTx8WPfFzKI9JbcZbd61aQ6LHI7xMSuoz63okZVNwlwUvtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072161; c=relaxed/simple;
	bh=Ksf5YxchQflehA0zyL6WfDAHnmrPPcCIXGwNL3c3F50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBz26rCKIBR3XabjXVXwO4f2KV40CTonoW1APbUNFVA7A/EMtB35kIn1DT5WhHd4C8MY7ow2PO9nEobwRgZUEShN2v8qDZMsOjtqx1/KM2a31cra1Hh8IL94FDkRVCBVapq0eYkoA0t2Yo/9eyuN4IgXwqRyDT401QqclKYD2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajblN9RE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso13466255ad.1;
        Tue, 07 May 2024 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715072159; x=1715676959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfYxPjYaJ13DzArLzMdBC+xi7YxOzq4F6d2fPzmkmH0=;
        b=ajblN9RE+4RajUUY0vPep+eM2pJsjtCa69UhcmEQ8Th4tKLG99QYdqC5DIkfWlX0rm
         i+j2nq4K2O8ZGQRBjvdvQwhLtOTP3RhtwgllA4n2wgZMbmr35/LB9H5opU2ngRblEJy0
         nExjw3G9YEQZ9A4rYsGTe0fT09CaEMo7n9yomWcITUInSQbxtmy7suoKNyyzJIXGo2VX
         6/DSpTjPFF0WkjCEoUfY3gAd1Rd15P/yMV+M/pBlQvyiERLKfswRbsyHTbCpzKB3FDh4
         av5SElzNzGMAJpf9215iRcEcaOoo7vccz6cKU0hJUcqeNBR08mxTnqaw5EPEE0balmkx
         p9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072159; x=1715676959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfYxPjYaJ13DzArLzMdBC+xi7YxOzq4F6d2fPzmkmH0=;
        b=b+0863A7CS9NbazyG7I2xoUqyU63eSl6bEyFWM1JVoc7sWqRXST2x/fs4e5kFJ+KXx
         2ZeDBZZ+bvbQEDM0fQwLE7Wfz8PS0WlgPv4qAjGb1RQTo6fOx535cDnODFNWKdOHq0GV
         K/J8UZZMhjWWeGTkZ4xuBaXxEHBDnzvLvomO2vgM25E7Nl+4mkkHDUDnv7+CfvkzQAqg
         /B387DIqBwMhuPpOXInTFKgYVzmBQ5LUJcBQLh50/m3YaVasIRHCszO204wm+iz/ApRj
         1PJicxT8PfCVvPzEcGlpqyh4fH2GGeXi0E4a2cT5gqZE4tpb/SnRZEgs2s6rX33goBut
         Y6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP6YTvCYcjq0F6FFLIgUAfmJZq1Sv+SJZdHvRShoo2IYPWG4exeY7kxSoHz1xbLdVqSfeHpSvIhQ3mfV9+yT1u9fE+IOOVZu1UKLZsAg==
X-Gm-Message-State: AOJu0YyeDrnd1SEVpXXygcmJvIh59S+2H7l4WefYoA6iz1F1KHmCJir9
	1VosKldrjRvEVEQoFAaMMFBCt8V7UMTgptAD3xGMKhDm0lkPT7nfIZepJGqV
X-Google-Smtp-Source: AGHT+IHaTWBvDoyo/xtxNDfUQqoqzNQbOg2X8VVX3v282s4ra57O97EBh+hzkO2JqQ0kdDYvOFzf9A==
X-Received: by 2002:a17:902:db0e:b0:1ec:3227:94ea with SMTP id m14-20020a170902db0e00b001ec322794eamr15716088plx.67.1715072159023;
        Tue, 07 May 2024 01:55:59 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id kg3-20020a170903060300b001ed53267795sm7262030plb.152.2024.05.07.01.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:55:58 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCHv2 2/2] iomap: Optimize iomap_read_folio
Date: Tue,  7 May 2024 14:25:43 +0530
Message-ID: <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715067055.git.ritesh.list@gmail.com>
References: <cover.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
within a folio separately. This makes iomap_read_folio() to call into
->iomap_begin() to request for extent mapping even though it might already
have an extent which is not fully processed.
This happens when we either have a large folio or with bs < ps. In these
cases we can have sub blocks which can be uptodate (say for e.g. due to
previous writes). With iomap_read_folio_iter(), this is handled more
efficiently by not calling ->iomap_begin() call until all the sub blocks
with the current folio are processed.

iomap_read_folio_iter() handles multiple sub blocks within a given
folio but it's implementation logic is similar to how
iomap_readahead_iter() handles multiple folios within a single mapped
extent. Both of them iterate over a given range of folio/mapped extent
and call iomap_readpage_iter() for reading.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f79c82d1f73..a9bd74ee7870 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -444,6 +444,24 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }

+static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	struct folio *folio = ctx->cur_folio;
+	size_t offset = offset_in_folio(folio, iter->pos);
+	loff_t length = min_t(loff_t, folio_size(folio) - offset,
+			      iomap_length(iter));
+	loff_t done, ret;
+
+	for (done = 0; done < length; done += ret) {
+		ret = iomap_readpage_iter(iter, ctx, done);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return done;
+}
+
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
@@ -459,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);

 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
+		iter.processed = iomap_read_folio_iter(&iter, &ctx);

 	if (ret < 0)
 		folio_set_error(folio);
--
2.44.0


