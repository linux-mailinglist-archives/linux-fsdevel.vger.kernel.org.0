Return-Path: <linux-fsdevel+bounces-18281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940B8B68FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91082810B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D61118C;
	Tue, 30 Apr 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRWnkdBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD310A01;
	Tue, 30 Apr 2024 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448245; cv=none; b=l+aQM/loShKesnNpQHbIzbYxsC+B5xbAKdqJfIptLHcj63H1VANPAYZKBKdeAW3tZUvsfJT45nNGX/U8EPYtu1ap/EhKogOzgkxHQBPmpf7VhkSiQ7cu3p/p6VWuBQqG+KBesmugGYyEy9JZAlIqE2RLpaPNpO/bdkvrOGbh0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448245; c=relaxed/simple;
	bh=nKFUd5MnqdN7gs5sweoBkBE86SpI2ISuPXSjE49K9GA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2YqljvFXRFF0HIBNpjxqPPZg/n6FSmMWdcEzMN2Zt94gTshNJ/jZJn70ttqgw9K2iSvA9WaFdcDAc32Kz0eH/J2uUu2+lxOcqRfhEKR+K3bArIlkDaEvQCypzygSzaz3iGncWnU9XX7B9dr7rdvY1FVlR/ytMb0wCHdtoCVgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRWnkdBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE74C4AF18;
	Tue, 30 Apr 2024 03:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448244;
	bh=nKFUd5MnqdN7gs5sweoBkBE86SpI2ISuPXSjE49K9GA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FRWnkdBQ66jcJrcEKqn5zbcxMyR5ZOHQqFX4o76eyp5SgZ2Kynd8V1ioz+rSvNjUW
	 OLQ2KAVWAYY8TIPNPqR+C/jRPQzcQPEBpjxU+cAm+DOsIidAr/M0Zb3SFFfb0/LWRp
	 Cf5m2X5CVCFUVHKeWrT90vpsAMUoWpVCYVIr0lM2cdElrLRsVxqyWrrcc4hqsNwO9f
	 DktsFs9f47RWvZsBGupot3mpqBmBC5j/Y7UCidjlEigcvVBLsps2crl5JOVUJVVTlj
	 extRINj++rokr4SOu07NY/5c7vQI95rwAT0BBfKt/9523eSICMIVgHGd359S4n7BHs
	 w8hdk/obCyWlA==
Date: Mon, 29 Apr 2024 20:37:24 -0700
Subject: [PATCH 25/38] xfs_db: don't obfuscate verity xattrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683495.960383.3327817770931540712.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't obfuscate fsverity metadata when performing a metadump.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/metadump.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/db/metadump.c b/db/metadump.c
index 23defaee929f..112d762a8c31 100644
--- a/db/metadump.c
+++ b/db/metadump.c
@@ -1448,6 +1448,8 @@ process_sf_attr(
 		if (asfep->flags & XFS_ATTR_PARENT) {
 			maybe_obfuscate_pptr(asfep->flags, name, namelen,
 					value, asfep->valuelen, is_meta);
+		} else if (asfep->flags & XFS_ATTR_VERITY) {
+			; /* never obfuscate verity metadata */
 		} else if (want_obfuscate_attr(asfep->flags, name, namelen,
 					value, asfep->valuelen, is_meta)) {
 			generate_obfuscated_name(0, asfep->namelen, name);
@@ -1843,6 +1845,8 @@ process_attr_block(
 				maybe_obfuscate_pptr(entry->flags, name,
 						local->namelen, value,
 						valuelen, is_meta);
+			} else if (entry->flags & XFS_ATTR_VERITY) {
+				; /* never obfuscate verity metadata */
 			} else if (want_obfuscate_attr(entry->flags, name,
 						local->namelen, value,
 						valuelen, is_meta)) {
@@ -1871,6 +1875,10 @@ process_attr_block(
 				/* do not obfuscate obviously busted pptr */
 				add_remote_vals(be32_to_cpu(remote->valueblk),
 						be32_to_cpu(remote->valuelen));
+			} else if (entry->flags & XFS_ATTR_VERITY) {
+				/* never obfuscate verity metadata */
+				add_remote_vals(be32_to_cpu(remote->valueblk),
+						be32_to_cpu(remote->valuelen));
 			} else if (want_obfuscate_dirents(is_meta)) {
 				generate_obfuscated_name(0, remote->namelen,
 							 &remote->name[0]);


