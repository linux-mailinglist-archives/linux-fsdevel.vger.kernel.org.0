Return-Path: <linux-fsdevel+bounces-33561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7A9B9FE0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23BD1C2170B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF85188907;
	Sat,  2 Nov 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="ocJMli1t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBD6AB8;
	Sat,  2 Nov 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548900; cv=none; b=rw5Dx/N6FHo+qQ58VBZ2We2SH8MfNt3On56F1J2TfrEkV7ihlWBXuQ45xfEs9YlKAyteUzMnFZWiqOkAtYay7njLg2Kub+fASh63W70gggKwtHqZgpi4WeDna48/OfutOZgjRzLzuCMSReXXn2m7XwTv41peWWaQjNaUs8RuKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548900; c=relaxed/simple;
	bh=SejvjcKDxw3BthMfHi6eAtNdZaOvse5g9PgP+P44VkM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NGfXTMY5RTzXL8eZ0ROB3raB5GXHIrdjYbKU2i4X0NBMi3d4QA/+6H4kHyFW7jzRKMVPwvU9lGH8i36KXkLXEKnblFsw6VMgQgo7h5xO5MbCiBt1IO8x4vTvfZZ0Iejs/j1BF51BWQH5y0UBSDPH5GaTN2RBAJrXdCcsnXBZSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=ocJMli1t; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: from nirs-laptop. (unknown [85.130.135.138])
	by lichtman.org (Postfix) with ESMTPSA id 60B851770C6;
	Sat,  2 Nov 2024 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730548897; bh=SejvjcKDxw3BthMfHi6eAtNdZaOvse5g9PgP+P44VkM=;
	h=Date:From:To:Subject:From;
	b=ocJMli1teNm9L03WHiBKgGRViUZAzwIoHtSl47gK3ti12ZphgpwIthUhcZFmQHkV2
	 N815jvatvwAUhUN6MK9xIAI74LlVpCOnwp0xKuOgHTEcsqny1jVC93U8FyFYVyRrGH
	 RrnVfj4KMxqUHaLrYjJrfZwHo9+WkIRp5/54LS4LMirxA/s+xXugkS3/4kwLwsfIQx
	 Bc2DRF+FU7qmAR+ZWBhXqRuXfP1I/b+2uYuXoDAfLkUCAhkxnMqBRlqwmqcEFKyaN8
	 fNFFkBXtDWzeg362XHvhzGWSkhbuqr2xCzZlmh4PMqGuVAwLyesxe8+oPoIYRiL0PK
	 JtlFyCXZtcXow==
Date: Sat, 2 Nov 2024 14:01:22 +0200
From: nir@lichtman.org
To: ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exec: move warning of null argv to be next to the relevant
 code
Message-ID: <ZyYUgiPc8A8i_3FH@nirs-laptop.>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: The warning is currently printed where it is detected that the
arg count is zero but the action is only taken place later in the flow
even though the warning is written as if the action is taken place in
the time of print

This could be problematic since there could be a failure between the
print and the code that takes action which would deem this warning
misleading

Solution: Move the warning print after the action of adding an empty
string as the first argument is successful

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

Side note: I have noticed that currently the warn once variant is used
for reporting this problem, which I guess is to reduce clutter that
could go to dmesg, but wouldn't it be better to have this call the
regular warn instead to better aid catching this type of bug?

 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..4057b8c3e233 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1907,9 +1907,6 @@ static int do_execveat_common(int fd, struct filename *filename,
 	}
 
 	retval = count(argv, MAX_ARG_STRINGS);
-	if (retval == 0)
-		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
-			     current->comm, bprm->filename);
 	if (retval < 0)
 		goto out_free;
 	bprm->argc = retval;
@@ -1947,6 +1944,9 @@ static int do_execveat_common(int fd, struct filename *filename,
 		if (retval < 0)
 			goto out_free;
 		bprm->argc = 1;
+
+		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
+			     current->comm, bprm->filename);
 	}
 
 	retval = bprm_execve(bprm);
-- 
2.39.2


