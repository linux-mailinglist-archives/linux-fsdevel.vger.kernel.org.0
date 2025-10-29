Return-Path: <linux-fsdevel+bounces-66136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F910C17D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3943B329F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592A2D94A3;
	Wed, 29 Oct 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tahh/ybf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604132C21FC;
	Wed, 29 Oct 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700795; cv=none; b=WvCEgZzgWVJcdRT4k6vaEv0HS42o94+Q4oG1w3HP13gac2v7OWWr7m/ouY+DB0hB/bMGx1jGiJrnh6mL1ZBZ+flKAx8IVJile2IaHJdhzW9b0EEpIM19g5TIdtPgNfD2eSWvCrTaEfimrVWTXZm1dYfYGcjcwe5cMMhiymvQH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700795; c=relaxed/simple;
	bh=tIqE3niI6rEeqcYd1n8f1OsGAoK2Mf/iXvQ3oaSYXfc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUeMiNqJR63wdj88NnmRc1HGX75UJKh74fNRMhP8YT6OO8k36hwX0ElBFDnRJapO6O9FCsUWA3sZLrtyEZgOHu/m8RW2m8r7tL8b8xq0y6uiLpri1S8K/SKkTows0yIQLvbvF+kGpexeEchYh2kbd20mIlHMDFNbzBbpcflFZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tahh/ybf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CAEC4CEE7;
	Wed, 29 Oct 2025 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700795;
	bh=tIqE3niI6rEeqcYd1n8f1OsGAoK2Mf/iXvQ3oaSYXfc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tahh/ybfJsoTxwySS1perxE+OD9bAeK0n0Rgo2OX5uNAA00LNpShUhNznVmd6Qkw0
	 Eycrx4CUCK3uIOs0JwAbz6LQy3FGT+xgqyQ7KyC/hs4lTJU6O5DnJGQJ6MV3hzhHK0
	 ZKKp+0qFYpJzs9PdBpmYPVGH5mwQGEGAbcVJez8EiK7mM0Qr9qaJmVSVPdnbYmBcwn
	 cOho/3lZUBp75OukfZZVR6Ditf0axYaZxnkjLAfk0j6F0pyBM0qhCJoDequp57huej
	 Fdu3Z8NwjlLyEVnYXqvWbsUfH1AF1mIYexYiZ04EkEMs56PBE9XpPU2E1hsXB6x0iS
	 33wwFHN1fUp1A==
Date: Tue, 28 Oct 2025 18:19:54 -0700
Subject: [PATCH 5/7] fuse4fs: ask for loop devices when opening via
 fuservicemount
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819124.1431292.11049103365311149504.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
References: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When requesting a file, ask the fuservicemount program to transform an
open regular file into a loop device for us, so that we can use iomap
even when the filesystem is actually an image file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index fb8a897aa1706e..7edebf6776208a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1523,7 +1523,8 @@ static int fuse4fs_service_get_config(struct fuse4fs *ff)
 
 	do {
 		ret = fuse_service_request_file(ff->service, ff->device,
-						open_flags, 0, 0);
+						open_flags, 0,
+						FUSE_SERVICE_REQUEST_FILE_TRYLOOP);
 		if (ret)
 			return ret;
 


