Return-Path: <linux-fsdevel+bounces-14824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97070880256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AEA1F22D88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D88BFC;
	Tue, 19 Mar 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUR8ahsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3626AC0;
	Tue, 19 Mar 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865931; cv=none; b=aHjmLLHMrfyzbAIoAKJ5SqTtk6NDYSI8BR+R15978KnbOLIS3dKQsteXRV+xTL4iz+lBTNizXa6thj2tNjI12WZuIHOFvEfvfjJeCGimKZIlH+/7Rm1mqHCpc/0qBABdCoHX3anfiKs1RF94O5sjJrsxYwmVNXN7KMV2i1U4QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865931; c=relaxed/simple;
	bh=NhTjsDbeF+jZwB6UdNaz4xCZqScOCQU5gs19tO01lLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dHSMbjlRmYDJ+9nv/sQiDdWVi59qzmVXLju4fKCfQCnkcJxZMSYLbnW5F5FjUhC5QW02ihR10Wo30LLg/Af8LcEDrkWx28YYpkX7/IU6mVALUUh/o1uYfMjkzkIjjMyj5SlAArOxSkBNgg3/VLDqxogvGiQ94MIcN6NlK94tWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUR8ahsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BAC433F1;
	Tue, 19 Mar 2024 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865930;
	bh=NhTjsDbeF+jZwB6UdNaz4xCZqScOCQU5gs19tO01lLs=;
	h=From:Date:Subject:To:Cc:From;
	b=aUR8ahszlCpeKTzonzhIEs24YaCWhLKvufoK18jGUBjVQHpFAZeDSx9OtOqNNq4Oa
	 0AHn5buoluaQ9q+Cto3nROALV9PW6XxNFl3l2nUyGKwY7NaG88vPw61fJ6frhYELHA
	 VZDVEAiYJxkiE2lUbVoJcBfUjjrRgdPxOHqYdymUHSQd3mU5ji2FVI2wVMhilf1hOA
	 t7srlgi8SmRsEUsHbABX8OXPEiius9h6KG8eUaoLMXa2lZhv51S+bqQt/DXUhtD7qq
	 vveB16IbvyxFRRCt+7/w0RGjTfLsuB/Hd118shnw9JX9B7OwufWGmxOOk9CKnt4bPs
	 XUZdvH8UrqOqA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 19 Mar 2024 12:32:04 -0400
Subject: [PATCH] vboxsf: explicitly deny setlease attempts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-setlease-v1-1-5997d67e04b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAO++WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NL3eLUkpzUxOJU3eRUY8O0JAtzc/MkAyWg8oKi1LTMCrBR0bG1tQA
 swUHSWgAAAA==
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NhTjsDbeF+jZwB6UdNaz4xCZqScOCQU5gs19tO01lLs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl+b4KKnWSIRHwTvzyrK//St8r9MZW6K7Eccg6f
 rA4HdHKfNyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfm+CgAKCRAADmhBGVaC
 FVLSEAC80hdMN2Gs3KkTk1zwh2mUSpiCWOT1my1yQ6CfsDj481qJaUZMksSyj9DbiuZUiV4UG4s
 /FMd97NnXYBOk2IK3pHn0BRkvNAeeqFvgRPg+IYof/DqFRSyYIIgI3lWIcBc58l0ZOUwf87MTXG
 V15wW0UwUcOIZLh7QVbIHIxkQ0Z2ir0OQvxyo/q9TKpxli/nq3tj1tau3ns43YISbNxj3K7GdJv
 gJwoAZ59BDeD8Dgk+LEhci4mMLqRCz2OjQD80y0UUOXe0PGrsNWYDhK0IkIS2H+7O4nMpHaTsnK
 8mDI8X+tlyHXPkTHIXJ4N7ZdgJxnKPupbKmtiUTvPsy6xRoB3EU3hTPBNpUck2cLItaSwWsAjDK
 9ZY0LqrfV5GPgwW537wNHezTBOJHxSVly1FY3vf527BCDdi18QSItzzHMSfOxnpPIy8h6bQTT02
 I09Dr1p0DAPt5CN8ikIqP1pWOE0C3TjsxI1XwNhbj6Zi3ITebPQzZitHQbtm4IpbUFt2c7FXN1h
 AhBsjMPMX4b0944FzljExhViZpziAdsWST6Fc7x8QNkDBrkIUvgdB057DDE2R5j1O1Yn4PK6GvO
 NVcaDlWv6XAZhVweXNQo5ZCdyfSvAYjEhH/ZfkDFqIxJ94/pnjGPswTC7zmT3TvdwgnEZ70qLXp
 JM6ftqSdgl51sdA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

vboxsf does not break leases on its own, so it can't properly handle the
case where the hypervisor changes the data. Don't allow file leases on
vboxsf.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Looking over the comments in the code around cache coherency, it seems
like it ought to deny file locks as well? We could add a stub ->lock
routine that just returns -ENOLCK or something.
---
 fs/vboxsf/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 2307f8037efc..118dedef8ebe 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -218,6 +218,7 @@ const struct file_operations vboxsf_reg_fops = {
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
 	.splice_read = filemap_splice_read,
+	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations vboxsf_reg_iops = {

---
base-commit: 0a7b0acecea273c8816f4f5b0e189989470404cf
change-id: 20240319-setlease-ce31fb8777b0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


