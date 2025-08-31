Return-Path: <linux-fsdevel+bounces-59726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F267B3D4DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC23BD055
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9A2765D7;
	Sun, 31 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="e8ME6l0F";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="jlCqZXOW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48E221275
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667890; cv=none; b=UoUY1fpslHOQCVP20x0QxOvhpzORK5YlVtYyfJ6LCT/emLQ7VYNCXKDfGzI7tMFNkrScablTkjx9RIzv596ZWnbgLIw0AKMU69swhZOhp/G0NjD+P1Mea6ENcxPY+UMC54n96gLVqM8ixN/BRT4lahGYBlxzWNt8izL0K3fGFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667890; c=relaxed/simple;
	bh=7D3KwNWJoC6p1VF2zcIsFrvHRGbh4rZ3AUloKNQr7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dys6MPhMNkJQyNB8bxNj5FwITtFfItjOyHk7R3YvkmFaeMC1UL/yEyvYT7J7C5hKqiirsOCQ+qg7wFT/lwYrNVanAIG/erJW2ooqRpO1BjSxvO3HZ7n2sKRc1WktdpR6O+1ZCpH1aKqdo8euF3Jrkd8v7dw+nsF08K9QsH+vsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=e8ME6l0F reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=jlCqZXOW; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668789; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=; b=e8ME6l0Fng9DKJFhyXt/vfrXWm
	TU45GMWiVe2ILUsZSVxhlkWlhG11m/uyKns6HCIkjA93CzEkGz6q6x+B5Ao6o3J/7zuN3rWVtPIpE
	rmAouC/0qXMAdhHRJi4de7Sqm3iEoqrq4ryXbRv75+v9KSak/JIWB1GrTuyqkHRZ6FOAFeoEdMUHI
	FI6LVJi/Sh7e/lAuMPvZwLD5db0tgxBc+czOTRGBh1LI+3KljJUFQxU0FTV5ReF6XoFcNBIUPeWMG
	ITq2kpIVpm1v+aJG+A2Mpj5FS/4VUI9Cei0Swd7bsJcnc0NloMsw4vNR1YWX7dJwFu7pXPAtYlVOx
	pRq5bDTg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667888; h=from : subject
 : to : message-id : date;
 bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=;
 b=jlCqZXOWsxsIEIkxpMSTVOmnJhGZ5EEx+uvGO0EMcqznfrNW9DBvJYLAFB/vjw+3p4dSD
 TNKI9/DPMD3MbDq99EKtuAU7GCWUwNZvp2dgG1aHMaBSZnrmW/CxSCDCClihouDxJ6NtJcR
 pgEAu+O0xhA1Nwqpb9mKjV/TRGEspyv4ktBCLE2aHMVy02SxSVXEdtpdCdIzSHcF3UQR8L3
 M0RXLRvlh9TwTfpgSs+x+OL9nMUMup96bEPpHWD9sa02cP5CTzkpaIdJNhXwc90Kq3NN9y/
 oPRotPF0I7WVeVCCCy/yKqBRMOnP/d1J+SS2LjJLkLupnFkLXtKceT4XxhPg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4XF-Tb; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrhYfw-mjHk; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 5/5] 9p: Track 9P RPC waiting time as IO
Date: Sun, 31 Aug 2025 21:03:43 +0200
Message-ID: <cd1a0278bc06117a870fa7068228e77327a25127.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: Uptdb26HhzEv.tdiVS7KSf9LG.UzPWlgFkJKD
Feedback-ID: 510616m:510616apGKSTK:510616svxP-T_CuV
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..3f0f4d6efc00 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -713,8 +713,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
-- 
2.50.1


