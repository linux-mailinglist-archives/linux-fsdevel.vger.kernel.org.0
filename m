Return-Path: <linux-fsdevel+bounces-30774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDF98E32E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0645C1C223AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D72216A7;
	Wed,  2 Oct 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6KA5467"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8C221684;
	Wed,  2 Oct 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895027; cv=none; b=uiPw/6MmB2iykWj/0hdv3F7164dIFogyO62ipVW6BLCzehWgaIJz8Z7Jy260UAKFizLwRzxFZhhmlOyfaSdQDxwRJ3Hfz//j4IppN4aL8YWrrMZmwvALFejudvwfBOAJUjcWIHrwmUVjHTn8uBRVc8HrcX5JMxyQrEHxZOAMZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895027; c=relaxed/simple;
	bh=XlC7YeycewlZi2a3r3W7IO7Qd7YSP47/MVJ/d8lrj20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jrq70AskMzB1JD6DO9XVEgImT3gbp4moyWOXDis+JgGjvjUPUfqZbVDItlZeTNcLy5pOU9BPMBPNFYcLxrXfytWzNUtjsDEbrj5veQAO7COGBDUmnz1btmN9+Y1jNrQckhl7Aa3Ex6KQE7yAXvOAzx0hVayy+Z6g69lL4rporZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6KA5467; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCDFC4CED6;
	Wed,  2 Oct 2024 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895025;
	bh=XlC7YeycewlZi2a3r3W7IO7Qd7YSP47/MVJ/d8lrj20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O6KA5467Sbp5TN0nr9okSkPDnFzH6zjeE7j6psU2LHS76B0vrpzt9XXInhnHpKxj6
	 IJs1st80UCkJwLsitlK7096E6X9jQZ7DAweZwN5sVJy+FC2ISbg1SbXK3VGPenYxEk
	 U1IAgYoMVkepjPYtM/hR3yd7lJxl9NKfOImCUoaQR4qRm/5o/Tv+wRjtMzSXJXvoRk
	 icvbBr7WDPMt13T6kpBcJ1IQsUsshFCn4l47xcRCfIkm/Pt+BUR0EEtuogKsRctilw
	 Z7ryrSB373dkJA5xHGzMG+5E8MF7Q282D9nx7DfVsDLyUd396fvwKC8xgFkLfmt5Pi
	 CNEBkjUV9IVeQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:40 -0400
Subject: [PATCH v9 12/12] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-12-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XlC7YeycewlZi2a3r3W7IO7Qd7YSP47/MVJ/d8lrj20=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXN6h1nh3Jd6jDRqtordF48NCXbHTMIIvKYt
 k0JvUmUUnGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzQAKCRAADmhBGVaC
 Feo8D/41p25TrFB0UfY7raME3RSw3V2+1l+VzsBd4T4VUALomAlvpx4rASZanyQ4quJ03pKkB6s
 rQ9nT3rVtZ+El2EmDy69MXcp8S4KT6MYsiE3NYuVD68oO/NzqNxYUJqM+iSlB7dOB9VONqcos/D
 uuLiZrD4b/K1jV8heLBwjcXK5mn0koIux75p1x/JCycT5gLRXS2ADRz0cntSbdRPheNG+QcWJtP
 kt1yBPc6JbSDnXd7F7W+ouC3SylDJfAntabc8Xi0Wns5/8XFWcLjMw0xCsW3dGwbIl8o0O8GEd1
 eSpRT0khfdmm2ovPwC9gPXrrQPRdD+ZeEB1o8iUUhQ4LZmc8DWRL5sQ8gDH30E0P748Z/x/QvL1
 dTNj80QaMOjeDyzEczN/3basPLVSn6FmAJMSHy04/Q48JvoMbBlLDfaNqlMSg8BT5WneKtii63O
 VYAAGC+sHZBu/sCKkSE49A4yZZ11DWlK5lD8zYO6BxmQMkhQ/X8weMwUFlZz5jwnFO6dZOtoFg1
 RwtHKlDJSUn37SiERYT+bS9JfPGzMDXPW4grx9yYoHTgw9K3MvbsLBlXqCNU5SkAH+HY8mkKr40
 MQom1aU4ONpgq+6oOFh1kuv+sb4AUhpUCpPaSDInyl1cNw2X4crJh9AJQR6ujOvMOCbLK9NjmRi
 F8V1mxt8ohQeGyw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..5f17eaaa32e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4804,7 +4804,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.46.2


