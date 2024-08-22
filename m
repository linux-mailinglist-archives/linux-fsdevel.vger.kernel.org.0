Return-Path: <linux-fsdevel+bounces-26595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1795A8F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3EE1C2264F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67526749C;
	Thu, 22 Aug 2024 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Lg4zY2nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE43FC2;
	Thu, 22 Aug 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286887; cv=none; b=LwK8gqMuLAVNNG8g0yvTiKir5PzlY9MyKNkeuE5VQKsTpyjUbuDxS5BOwiPuAUxsA/fpsH/n/K37XVQpkyn09BcbFSWiCUz0G19WeygpnCJZK4lycdMFWkLHo8c6k1NVTiyuujlcoE29FZ4H+5zjM54bJL5LYwPDOb4aDriF03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286887; c=relaxed/simple;
	bh=CkfH3mMr7WKw3kE9Yl9nOQXI+R+hZM4vuHsdJOEk9fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE94N7t8C+hNUCgVA/tkA790PWUSEcorOY+YO+WYZK2No1nvoSG02LBwdjrxWvwHg3JMZTvtHhHfMlQikF2d9LPnH5eDHGT1dQxypilA773bzkSX8k4wvJOnt6oD+eAdkvgv9qQ8WBxmWqR76bSIlszqQs263Bo/uYlVeI6Rkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Lg4zY2nA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=epbEGdz2+v16By0wdEY0UHnHdXCBC03c1RByg0cE2oU=; b=Lg4zY2nAuWviL3nLfTW7ZpzI0p
	wcPWARqKP9vKKEYpzYJDgsvZ6z+YDjWGxnuY7TgkUIjSGDMpHzJSLgc48cnKhgG+bZ0Ua4QJdiDOd
	8cxxmJteBGm8PjhQgc524kUo+shtz8/Di5hx8MYc7X9QTwi2z1otTgRt6+YfXp/Qgz4G+RIlfSdzo
	7x8bB50os7kbMFSCkD9i8HfCWdmjXFQ9oR0sVnM8rCtvYh03i3hjq+8jV/CXf5Pbb4/6bh2u2GUsq
	stHVUA9VfnRS7zvG8/eeKhXcdwOEfu93p+G1NE4+YkqcqPlxUkXiXhc/BRllTi8eTW5sZNivARDHO
	FXYE/scg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvmm-00000003wL9-3Q5n;
	Thu, 22 Aug 2024 00:34:44 +0000
Date: Thu, 22 Aug 2024 01:34:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] don't duplicate vfs_open() in kernel_file_open()
Message-ID: <20240822003444.GP504335@ZenIV>
References: <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822003359.GO504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..2bda3aadfa24 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1182,14 +1182,11 @@ struct file *kernel_file_open(const struct path *path, int flags,
 	if (IS_ERR(f))
 		return f;
 
-	f->f_path = *path;
-	error = do_dentry_open(f, NULL);
+	error = vfs_open(path, f);
 	if (error) {
 		fput(f);
 		return ERR_PTR(error);
 	}
-
-	fsnotify_open(f);
 	return f;
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
-- 
2.39.2


