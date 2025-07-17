Return-Path: <linux-fsdevel+bounces-55319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903EAB097E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA13F1885E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401D245019;
	Thu, 17 Jul 2025 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCnP4caN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B292641E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794875; cv=none; b=RKh1Y6JKv3wrif8/JxCg2lK7ZncbTanINZnwAQ/Ty/jMb0ZvjDHTyBi2hHkipqBl0U7YEk93MFGuYPB3AXmFt7MvSOPFmmH5p+2ownvGSXpZ7JPNcj1D+bDjw+GY/+Gxu8gDE46wnNbshLEryAqwqcgBPd1+6b1ft3R8lD+jDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794875; c=relaxed/simple;
	bh=6q6GpnqnP3UQWRPRLuh4OJJosITMKP1u1WzXjs+UijU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCB1u0OdcpzbciWV+yFXaPQGd8XP2kOtLdZWbnQ7PX2XukOOWJUtWVP5iFAOZ/TMVN2o11nzen5+bBRpeRhNCjphq6kdnMpr83zqBL19CjtbNKsl+ff97GkWNUUTM2vwukCSv3ugiOhlqHN7po1cefwYk45suHu0ay0keQSd9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCnP4caN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EBCC4CEE3;
	Thu, 17 Jul 2025 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794874;
	bh=6q6GpnqnP3UQWRPRLuh4OJJosITMKP1u1WzXjs+UijU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cCnP4caNt18HDbP18cUVQEtv0bo4dq6noorrzs/PKMOYze5ys6MJb5HDVRaisuiYA
	 zV9KFEF1aJdHyf8mzKeGpgQaZg21P6M5aMWeDPzgJ6//Ed7Mn8X38sB0lL9irsFr/5
	 1G4pnZdfXpv7zP03Of4PMxKWu9zTVTt35IaUAtzBV5I0Ue/7EkjYFy5VK8tXr9xqEi
	 8LSVEZI7LY28I5hpwJuUxdnjccOXXsfRU+E7MuYRFoIdIXTnxVfEoPSTZk2Jfr5Da6
	 CjxmsYAhypDqT4ciP6PdOfA50f8/LU6Uo+9swT/P+CzbVLbeVrirbvG/PqwppCbUzS
	 XOFK7LwGzEc7A==
Date: Thu, 17 Jul 2025 16:27:53 -0700
Subject: [PATCH 6/7] iomap: trace iomap_zero_iter zeroing activities
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449583.710975.17509678275524700377.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Trace which bytes actually get zeroed.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/trace.h       |    1 +
 fs/iomap/buffered-io.c |    3 +++
 2 files changed, 4 insertions(+)


diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 455cc6f90be031..c71e432d96bcdb 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -84,6 +84,7 @@ DEFINE_RANGE_EVENT(iomap_release_folio);
 DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
+DEFINE_RANGE_EVENT(iomap_zero_iter);
 
 #define IOMAP_TYPE_STRINGS \
 	{ IOMAP_HOLE,		"HOLE" }, \
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f526d634bfeda5..53324b0222de6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1400,6 +1400,9 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
+		trace_iomap_zero_iter(iter->inode, folio_pos(folio) + offset,
+				bytes);
+
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 


