Return-Path: <linux-fsdevel+bounces-40665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D9A2656A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC454163C46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4C1DACB1;
	Mon,  3 Feb 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hKEDeL1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9C1876
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617403; cv=none; b=gaYK5rRXkCiRtLyaKcszrjc5aqgsEJ+nA5u5WoZb9SK7cmV8MfWLidsqHqnhDl1M1gP7jbyIr2/VFJJC5xSKdBQ9wkk46suEE9YN8uuJDWBtRTvZmA+PEeKkkGsZlR4Ys2aZ0S2AKiXLxrCsdxIXJVod2PA3t69/sWGmWMyGPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617403; c=relaxed/simple;
	bh=Cct67FEEeTT2vZ/9enl2pyCorckANcWG7qGvg6aCMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sIp9Ur9mg30YDlYtu7C2a4Ah7CvIRLalwCLUPyt0nek50JLFthArJA8kvAQzuDUn5pNohvjRy0Zn+56RF77cYZwNi2OZj87CF4LffCN5US4d/6y2Hb3LyY1vYXgvzSnTuPWQY38nQ+pN2F+aqK/IfQR/OYunaorzZEdcFt59AZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hKEDeL1p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xGs0C/ea026laqmGMao0pTI6NFs8DvzatXzkm7OZ0U0=; b=hKEDeL1p4ijJLA+0Bne3ROBfaX
	0zTw5UQFTZuor7BjoASBcGIZKf/jLCpTcYs2gxKHk2RulAo9umPCJ7+e2vcm8NCPtNINRhzb8lRve
	ngqmYfds6VAz9oHJk9zyLzI/cjnRLqsICD3ZSQCA/rI0/JNCUmmj+8dU2/MsQQoAaImsQpOSab2ML
	fjJmpvtoXf1SBSELaleLpyTGaylUCm7lQd6njBK5JOOTbIZw0QJdFrnPyFNkrzgHzOBsytJLXSivK
	5JLUrCDO5pggM7QPU4qVXhZwwpV+cFvYIwoFcBQVXkFeorhkqSckAe4BHfXj883uN+nAPtphxC7bq
	0EvjZPgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tf3o6-00000002Hbv-02Dh;
	Mon, 03 Feb 2025 21:16:38 +0000
Date: Mon, 3 Feb 2025 21:16:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] fix for regression in d_revalidate() series
Message-ID: <20250203211637.GA1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 30d61efe118cad1a73ad2ad66a3298e4abdf9f41:

  9p: fix ->rename_sem exclusion (2025-01-27 19:25:24 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fix

for you to fetch changes up to 902e09c8acde117b00369521f54df817a983d4ab:

  fix braino in "9p: fix ->rename_sem exclusion" (2025-02-03 16:16:09 -0500)

----------------------------------------------------------------
Fix a braino in d_revalidate series

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix braino in "9p: fix ->rename_sem exclusion"

 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

