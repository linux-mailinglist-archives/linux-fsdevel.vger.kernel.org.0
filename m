Return-Path: <linux-fsdevel+bounces-26433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5F959496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E881C20BD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC54116EB5D;
	Wed, 21 Aug 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1XF74HM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B516D9BE;
	Wed, 21 Aug 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221880; cv=none; b=b/4CzFJaeoTXFxlqgURbVYk6/uBLj4PoILyi1KNFkHwMR4ahP6J5RGQIluaQ+sQeY8krcf/meL2wPYOrGalDifPGxJxWKk+I7hYOO93yjMRqAtcsUzuE+clajcAd9M9br8TrAwCQn5PbUWBZsGFs9cZZGX/GpD0c+1iZkuHVI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221880; c=relaxed/simple;
	bh=rOo2NxP2pTdwjbOUifV5uf6WjDmc6V9X7z35uyGqPdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJkk5tldyMJ+mmjjO9J3gdRBHOSebUN5Db6xWKV4iYTvWD8KE8Y0d2SWQ0QKBq6T+ooZOfPzSPe/XMntz3vLqWw4OAWBMvkjdUCVP2frsd2GpFy/dBDJQJ495uZsO9KPkgvlP8Ei+1snBZ/ACzARJK9+2v2tbhNLsAOejKi6jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1XF74HM+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zMuI4AlzPiw69VELJGR7bipT5idXuxdPfDreEdpi1d8=; b=1XF74HM+A8VrBaZR3sNbqB5jwF
	/wGlZtbg3/A5/r5sS9lKYsouUXMisTKH71xwE74/54YHD+UR3MvJM70cO9j/fzGiadnw6VKneLEXk
	hAy9CtuRZ8HGBtU+amaksdW6aXM6SnoBYrD68BWWzD7KsKXAwzUxWANbHGFKJiSryY0SGfRCq1+1P
	MxIOjbOAVWgxSfz7E74MhNgBNESiAzn6VEhXbiL+cVDrYoYCkDg8ddjp2A9D7oYcw2zFdATt1V0d9
	twWEmWJN65uZbnbkzEB7WkCTITUaoTQ78+oNe27HNfKnHH8OEeaPtszEZPthqivPAG5SGlQXKXT+m
	N/iJ9TbA==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesG-00000007iRo-0oM6;
	Wed, 21 Aug 2024 06:31:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/6] ext4: remove tracing for FALLOC_FL_NO_HIDE_STALE
Date: Wed, 21 Aug 2024 08:30:28 +0200
Message-ID: <20240821063108.650126-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

FALLOC_FL_NO_HIDE_STALE can't make it past vfs_fallocate (and if the
flag does what the name implies that's a good thing as it would be
highly dangerous).  Remove the dead tracing code for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/ext4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc5e9b7b2b44e7..156908641e68f1 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -91,7 +91,6 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 #define show_falloc_mode(mode) __print_flags(mode, "|",		\
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
 	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
-	{ FALLOC_FL_NO_HIDE_STALE,	"NO_HIDE_STALE"},	\
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
-- 
2.43.0


