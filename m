Return-Path: <linux-fsdevel+bounces-34951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533EF9CF074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84A11F22429
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A31E32C4;
	Fri, 15 Nov 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCdsVACM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376D1E25F4;
	Fri, 15 Nov 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684967; cv=none; b=P71/uOb67X9+izQVNQRCM9i2TYoG1lfoH2Fi4wPGLFDZMAoUJeqk+g8JkEVIu75jrpzKIQENqzommsmyeDIDYndf0J3syCcuXhg7LGwLzPD6fYZrnDYeuO4QKjy5txvXwJy3wS6scgTN9zDQE/DH8kOLCJm1vphoAGMW58Kw2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684967; c=relaxed/simple;
	bh=oDpNykEdHsgFfr9bC5cHpPrw94tYPUkakhRHDzB3los=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rp6MXqDUchh/nAvT0kQkTElx/Fgd/TCgW3GspcKl8W56h/ivN4Gb1NbUZ4djpIoB8H3NNuIvZgSA/voZRG5HFqOpxWMoM2kSmYOLUqiEbN6GapMIc++62l7G3GJHvZhJbv3ZVbIN+r+xnSa86ooJGnj9Kw666V1vR4ZRdtNx5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCdsVACM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B8C4CED7;
	Fri, 15 Nov 2024 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731684966;
	bh=oDpNykEdHsgFfr9bC5cHpPrw94tYPUkakhRHDzB3los=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WCdsVACMe6DJrja1FEx57gPZ8PiwXkzO19dBgWpPP8K+KQyA3ZSgftTvqZzsdZrkQ
	 jr8mCyLdjPi95eBuL6IU36d96D9jcc8Dd8EIP0PEDKYjgFpVp4tQaXV0fSr6S3u7zi
	 Clt8N2vhjdK375iAsKpyvGR8XUWiHK8EBtBN6Ac0qS5SxK6wsai0kXjmuue9WD46ar
	 QbWeVf6d7Wcq/exp219waJtf9G+ezYqPftTnpqkeWXCNlNAjb0Ef6HOBDqiAdMpKy1
	 NnwC9fVLjz0ur2D+tgCdF9wXuJf9+SXIDlRAHqqgM6sqkrLVxGdHccdEtkOGnEQViI
	 SQCyyYWF1hETA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Nov 2024 10:35:53 -0500
Subject: [PATCH v2 2/2] fs: prepend statmount.mnt_opts string with
 security_sb_mnt_opts()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-statmount-v2-2-cd29aeff9cbb@kernel.org>
References: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
In-Reply-To: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
 Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
 Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oDpNykEdHsgFfr9bC5cHpPrw94tYPUkakhRHDzB3los=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnN2pikMDGYDnUPJ03jterlj4wqQpSN9W9dlAVS
 2rVHVLWKIyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzdqYgAKCRAADmhBGVaC
 FclqD/oDGK4LvXLz1x7dv30DbVcb+rcd4wGgnXOIZrOme1EbR3ildGYYsJ1DQiwQGn6UQSQSg0M
 KBRWSxe/rl3zUFWU+Lecc5jqMSTQAuqdkk6JbsT11NQZTrhWa83eBYCGhLxldzx5y8o9KWBk/ri
 StrHYBkM3163pEdY7ByXFWebcvctmdz0IkTZJBqi+yNR2w/4Af1XGUFRf0N0HlUxpFH3pEsnGOb
 uS2wIEXnOpwG6hPzVU166mqAs8doMoB+pkVKFCXMm4gqLiDukwHP9dSq+alGfgkDi+9v9yxZFRB
 QsU/9jg9s4hNoBk0ab6aE+gBsjQIlq5yLl/vr/I+fP85abLNCQcw8WIef7nNqbUToe+EBPVRo1k
 XEITxSPijyR5cVNQn+rhbEMf3kicHSuYZ9NF2x/0eWwGdUIYHlNz+IR8gHsTozLraLSUv0+Ilsx
 NqeUAItLfIWs5eYr3k1dA1V2NX+vokdMljzwXKPQ6kymwvXqhTS2Xggir3VzULvpHX7LlnBi5cY
 /AcrksAP8tYeI5PDR+lhYot9zNIYvglb7/3qnxtRxtcGAcQOcJYKqRstfhUTK4YnxrsNf2+6+/E
 GO3ifWtDUvAnPDzYNr1uffb+JuGyCPdAjS72ib+1kD/Dq/fOGzGROx/Gjg9UEeFhr30hPp7wX3Q
 cWznYW5VlhFIsRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently these mount options aren't accessible via statmount().

The read handler for /proc/#/mountinfo calls security_sb_show_options()
to emit the security options after emitting superblock flag options, but
before calling sb->s_op->show_options.

Have statmount_mnt_opts() call security_sb_show_options() before
calling ->show_options.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 206fc54feeba3e782f49778bcc99774d5a9d50a4..aae04aa10f984c69090bd1017112be17aa709d0c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5055,6 +5055,10 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	if (sb->s_op->show_options) {
 		size_t start = seq->count;
 
+		err = security_sb_show_options(seq, sb);
+		if (err)
+			return err;
+
 		err = sb->s_op->show_options(seq, mnt->mnt_root);
 		if (err)
 			return err;

-- 
2.47.0


