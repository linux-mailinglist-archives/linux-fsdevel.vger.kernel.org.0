Return-Path: <linux-fsdevel+bounces-35456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843709D4EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F78283B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913211D9591;
	Thu, 21 Nov 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy5f/07N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF51CD1EF;
	Thu, 21 Nov 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199995; cv=none; b=S09Fr6TnKC+LdNNJKepM1Va71ykMDb6Q/amia1lzG1rr4jWvjuJLlZz11ioSh1X+7AQmSwjNadnr4oTa2LbyTEIhylPCixQHyZnZp+3PK+mUjk3eq4x9F8xLgZzAdiE/gFKaxiTypXSovEhsBr+wcgs9ba7CyQQerKLYYCQLQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199995; c=relaxed/simple;
	bh=tHtKSYrNJa2e2haOjJsCV9fKOUuQcCDr8J4Fl/iaFNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jXiwQ0s2qB9jDEb2bfg+STeA6BpqN/TiTKwqQFfK8mhc+d+5T0smV0wJkPCGoLhj6oXRtC1bCQVH3/V3+UYRHoy46rZ+ExY7o0DQ4BI3m/rIRiLx3OtZ547kOHyzb7Ri9BEguvQUuKnU/DyviIX08YIXsIdh4cHpwbk7ezZGTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy5f/07N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01996C4CECC;
	Thu, 21 Nov 2024 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732199994;
	bh=tHtKSYrNJa2e2haOjJsCV9fKOUuQcCDr8J4Fl/iaFNI=;
	h=From:Date:Subject:To:Cc:From;
	b=gy5f/07NEZ2c+fJfVsyRaKs/haoHeGivW+KTntwBxcw3P9HY4plSbsXQfcM/ejTTU
	 htrtguAgZTzHxpPnF/akaVXcEo+qZdIfdtDPAFhyx+MdazUrWcf3vHyff54vAwawF3
	 xzxw1Aeqbu7zJuuZnZ7LB/xgWdvNzi/2TTkWqXnkOqc6BdJbv8m47BSprlQP2chxOJ
	 H8207ShL8ok72qZVPa+zYfRx2fSyV2zXvrKmXZcHEkp/2a7SsUXxtAXoF5YOWNbMP/
	 S9+XXERU8bHl8aLwdlwisuHoDsUejMoXIJDsCv7r14/M/LIxQ3lmaBt5SwcsqkJEMG
	 kiTdABjiDJSUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 Nov 2024 09:39:44 -0500
Subject: [PATCH] samples: fix missing nodiratime option and handle
 propagate_from correctly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-statmount-v1-1-09c85a7d5d50@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC9GP2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyND3eKSxJLc/NK8El1LI5PEJBMjY+MUs1QloPqCotS0zAqwWdGxtbU
 AGF45JVsAAAA=
X-Change-ID: 20241121-statmount-924ab4233d6e
To: Christian Brauner <brauner@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tHtKSYrNJa2e2haOjJsCV9fKOUuQcCDr8J4Fl/iaFNI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnP0Y1sZm1jFDwPmy1CGJgmyoSwSEG8Pjkjg8aZ
 SEGku1Ux+2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZz9GNQAKCRAADmhBGVaC
 FVNfD/47viuxHXpfGFqIVNb7PtprZZqykeq/1MWa6ej2avNdOt/+06XocURAsZrulwcW7cQRjLg
 awt8mFgEebxADPqxWn619VTdgDLPNQrVYErHBRtvUs8qeBMXNaeQMGTEbi9Kk6tkB5P/udFEuYJ
 2KPOV+KwFm6rhEpIgye+sxxIbSqsGPV3sKSr0dXDpwnh+WkbSF+53OaW82jYCLKacS27feTdX5F
 zIPGkhJ+H6G4ActhdbvOhenGZS1rwM12n/n/tV6k02VJZBdAZK6tmYnPgwLvt54zcN8On7zqDsp
 3IHldHxvNqoDegfDBOfLTrV2SLRv9OnqghnauDdcbjOPKepM1IavJ7dtT8MwEQi//6Yp070vwiM
 wT0XbqpMRRJwWS31+1cJ9kYAVAyqwTfRpqZvD4I2aSGkMITUBo0z85AePot8U/J511ZlwpLF2Zr
 mZ4yR1C1DT53hwyuvRPkoYZCwGT6qGM8cnjc9ITewKwYdpm4CmFnpFoX5M7R5lFaY/hy2DC2IT9
 7GpxLFBFhD7qsxLjhi+NWfPkqD7ClV589pamAnbjqQxuAOWSg0cPi/5Jx7x3jc6z2fqR+yE+axI
 fwoNtoUNJoM/rG0JMfN2HSrsbo6uGKViaGfKqhAiGuF3sd+6JD/HkjMX45pG9d8JNEbVeTWJWwN
 M52BLIGhlLnZE5g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The nodiratime option is not currently shown. Also, the test for when
to display propagate_from: is incorrect. Make it work like it does in
show_mountinfo().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
It might be best to just squash this patch into the one that adds the
new sample program. Also, looks like your vfs-6.14.misc branch hasn't
been updated yet?
---
 samples/vfs/mountinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/vfs/mountinfo.c b/samples/vfs/mountinfo.c
index d9f21113a93b7aa7606de2edfce5ad0d5bcf2056..349aaade4de53912b96eadb35bf1b7457b4b04fa 100644
--- a/samples/vfs/mountinfo.c
+++ b/samples/vfs/mountinfo.c
@@ -90,6 +90,8 @@ static void show_mnt_attrs(uint64_t flags)
 		break;
 	}
 
+	if (flags & MOUNT_ATTR_NODIRATIME)
+		printf(",nodiratime");
 	if (flags & MOUNT_ATTR_NOSYMFOLLOW)
 		printf(",nosymfollow");
 	if (flags & MOUNT_ATTR_IDMAP)
@@ -102,7 +104,7 @@ static void show_propagation(struct statmount *sm)
 		printf(" shared:%llu", sm->mnt_peer_group);
 	if (sm->mnt_propagation & MS_SLAVE) {
 		printf(" master:%llu", sm->mnt_master);
-		if (sm->mnt_master)
+		if (sm->propagate_from && sm->propagate_from != sm->mnt_master)
 			printf(" propagate_from:%llu", sm->propagate_from);
 	}
 	if (sm->mnt_propagation & MS_UNBINDABLE)

---
base-commit: ee05701bd2a2e4559f35742d59922ebb9b006d3c
change-id: 20241121-statmount-924ab4233d6e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


