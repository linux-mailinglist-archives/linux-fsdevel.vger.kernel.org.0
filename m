Return-Path: <linux-fsdevel+bounces-58257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5AB2B92D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751DC1963015
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4B26B75B;
	Tue, 19 Aug 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FocrOx69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D9266580;
	Tue, 19 Aug 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583992; cv=none; b=ZkSzy85F/X7l1qlgoL+QKb14RVC3k2siT2IItXzDJ6zuviy5YzdhKFkUKZ7B+ZAKi3E0QCkx5AuQ8fhFD8gH4k0snZnd4FHpxVu/RW9/M6ZrcLECj1eOOeK+W30t8Ro0g7N8Wfuy0g6UbBikqLTy99qYipPwLSSK9D9SS7l2Eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583992; c=relaxed/simple;
	bh=v6vYcXTcBoSBqK9ngA2WTm1fqKDKwId1MYeyfxcSqo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icms0fA0JwzIkFnWyf3fdpC+EGFVeGeaPPkKQ0mLcrnavtTwrSf+3X1JBvgjKZjrO4nj+TlkeHFPVGGlKXm18y9V0EAmVA2X3qlQ33O31Yt3XoQ611fUsBDvY9gjllNPkJEJdTJpEeuBGo2Thd6KEZjaM/5sTydrncGHu0JqFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FocrOx69; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e09f58so5401105a91.2;
        Mon, 18 Aug 2025 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583990; x=1756188790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi/ShUkxBtk6aRjZ08qLf5FzFDYEi5q8iyCQUeWbe4o=;
        b=FocrOx69zo7aeg+EiENXKfdTGP1ln/7JBtY2wiX3KZeoMRyH3r6bx3vNGIwDjl6nBf
         35l6lZoxYfkDvXdw1NyDmVOa5mjvhRmmpgekKHvNaM2+S0Gm83f0NvxiWTm/XOa3RsOX
         09TDm7rpEJnIp0ZfwDoGyc8D/pyi6USXdK8+1ZIPmIGcaE3WQOtduD08FnCoiEZOf3S3
         ieBFlRZeKXsCYheNn/j6CxMkE5Xn7kCPrB2r5Bj7vKZReiKolQNDWF4i1+da082FNaCF
         Rwsv4eYiNSJte5dRwyyoWBRFb6j4NdRJXYSyXCP2yC2z0fHzbTtW5Bg6wrhFYEbsvLbl
         qrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583990; x=1756188790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi/ShUkxBtk6aRjZ08qLf5FzFDYEi5q8iyCQUeWbe4o=;
        b=VW8qfBeDqkXBt4nvWgK5FUnJKnE1pIb1TEsgWoe1ZQodo/QAOTLdeb0tzdZJ/DuDmU
         UyQTms1m15gf06zyxP679pMDTnbm2D2g7hcUb14sofj+ejrx53hUE0D3XJTueEcDp4/P
         Ij686XkW6emxqYuxwLTbhlDQWOVYnlk9VkQ4yYgdTg5eBKPbcOEaZs1m4IOEKh7xgEJv
         oci+k08Q6NxwD6W6I23W5RaqWtwQ8nncbyt2QxGYkZqudtiC5RrJ2MrPNHwNtewaXbjB
         IQP5/HMrlDLSR78CY/8EFFOFsWaJvWTdU61e5XhWZrfRsl1ytc5XrkdJ8ujVW4bh4UQq
         xBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUIsICFNUs/6PBf4vOleZfbgeOq0Ou15hvIxpDexPRuoTZ6umIaviBtsjRE5gRidXnytW6vaM4lY6j1IiSCww==@vger.kernel.org, AJvYcCWP4ozsswbFKKrriyaipL20aYtHVVK0pmwI2nFcZzEMJnaYq7DrGoQlxKRDx34RRyG+bx2Bm6Ieb40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlhaIRB4aXwbE+v77OxxQ/nNTzg2fz+huBLw32eIj08HykLM9
	O/LSJG1CjzjrjE4E8YajiSNEsDHouES8uyIGVV6526y8iCOC4KkWvDxk
X-Gm-Gg: ASbGncskhCJj+jv4MA5uJbOzKIHQiNPFJ6wJH/4scDOt4mQuiw8HBr5aAWRm4ZtPQn/
	5nGLsUtjw/fNDxENM5zKs3zfvHqwVS1zQICNl+6VRFycG+S7oS/D2B78PgG3HONgYOz8BlDVoQb
	DwRiVPaZKsavZvKTTvDG9tgqL23Yhbdw9xsbvawl6xPcPo9OYDbUS+9UkpS1i+swYxLUBm6zy4N
	zA9wLYXXJSBdlGbqb5Hi4Sd8Lc8/9zSpLZHfTH8JqcrDw95hTbd8STmtJVWfjD5FjLptJC5KBW8
	ZksbjoB6wrrRmZwfZuY5/K/UTpwB5PEmGamlCRWzgp563w4vBXXd6X4UIAuNVr4A208MiSRJ4ja
	5fu77kMTfe3v2+DSvbG0G0jJuFogjMOaJ
X-Google-Smtp-Source: AGHT+IHxrlyPE1vvqO8g21oUJ1Ho0ML4MJuZ8/bVU+uw43C5It2CxEZZu8wIW6xynIH5F5K8ENGT2A==
X-Received: by 2002:a17:903:3845:b0:240:ce24:20a0 with SMTP id d9443c01a7336-245e02d77b2mr19456625ad.11.1755583990333;
        Mon, 18 Aug 2025 23:13:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0101esm97442055ad.46.2025.08.18.23.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 66E8541A38C4; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/5] Documentation: sharedsubtree: Format remaining of shell snippets as literal code blcoks
Date: Tue, 19 Aug 2025 13:12:49 +0700
Message-ID: <20250819061254.31220-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4402; i=bagasdotme@gmail.com; h=from:subject; bh=v6vYcXTcBoSBqK9ngA2WTm1fqKDKwId1MYeyfxcSqo0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRF58XMCwzL9FP3+m5fWZi/0Y3s3g8JV4a3rkl4kl7 +S7LInrO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRb4EM/xNbvNTOHLw1lXtZ 5Scm3ocMXxVaw7QnbG169Hx23GPrwCOMDNcTdxsYP41YbHOvfF5YOHNYjGii/r6vxxg7nKd2XVb pYQQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Fix formatting inconsistency of shell snippets by wrapping the remaining
of them in literal code blocks.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/sharedsubtree.rst | 68 +++++++++++----------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 1cf56489ed484d..06497c4455b41d 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -90,37 +90,42 @@ replicas continue to be exactly same.
 
 	Here is an example:
 
-	Let's say /mnt has a mount which is shared.
-	# mount --make-shared /mnt
+	Let's say /mnt has a mount which is shared::
 
-	Let's bind mount /mnt to /tmp
-	# mount --bind /mnt /tmp
+	  # mount --make-shared /mnt
+
+	Let's bind mount /mnt to /tmp::
+
+	  # mount --bind /mnt /tmp
 
 	the new mount at /tmp becomes a shared mount and it is a replica of
 	the mount at /mnt.
 
-	Now let's make the mount at /tmp; a slave of /mnt
-	# mount --make-slave /tmp
+	Now let's make the mount at /tmp; a slave of /mnt::
 
-	let's mount /dev/sd0 on /mnt/a
-	# mount /dev/sd0 /mnt/a
+	  # mount --make-slave /tmp
 
-	#ls /mnt/a
-	t1 t2 t3
+	let's mount /dev/sd0 on /mnt/a::
 
-	#ls /tmp/a
-	t1 t2 t3
+	  # mount /dev/sd0 /mnt/a
+
+	  # ls /mnt/a
+	  t1 t2 t3
+
+	  # ls /tmp/a
+	  t1 t2 t3
 
 	Note the mount event has propagated to the mount at /tmp
 
-	However let's see what happens if we mount something on the mount at /tmp
+	However let's see what happens if we mount something on the mount at
+        /tmp::
 
-	# mount /dev/sd1 /tmp/b
+	  # mount /dev/sd1 /tmp/b
 
-	#ls /tmp/b
-	s1 s2 s3
+	  # ls /tmp/b
+	  s1 s2 s3
 
-	#ls /mnt/b
+	  # ls /mnt/b
 
 	Note how the mount event has not propagated to the mount at
 	/mnt
@@ -137,7 +142,7 @@ replicas continue to be exactly same.
 
 	    # mount --make-unbindable /mnt
 
-	 Let's try to bind mount this mount somewhere else::
+	Let's try to bind mount this mount somewhere else::
 
 	    # mount --bind /mnt /tmp
 	    mount: wrong fs type, bad option, bad superblock on /mnt,
@@ -471,9 +476,9 @@ replicas continue to be exactly same.
 
 5d) Move semantics
 
-	Consider the following command
+	Consider the following command::
 
-	mount --move A  B/b
+	  mount --move A  B/b
 
 	where 'A' is the source mount, 'B' is the destination mount and 'b' is
 	the dentry in the destination mount.
@@ -663,9 +668,9 @@ replicas continue to be exactly same.
 		'B' is the slave of 'A' and 'C' is a slave of 'B'
 		A -> B -> C
 
-		at this point if we execute the following command
+		at this point if we execute the following command::
 
-		mount --bind /bin /tmp/test
+		  mount --bind /bin /tmp/test
 
 		The mount is attempted on 'A'
 
@@ -706,8 +711,8 @@ replicas continue to be exactly same.
 				   /    \
 				  tmp    usr
 
-		    And we want to replicate the tree at multiple
-		    mountpoints under /root/tmp
+		   And we want to replicate the tree at multiple
+		   mountpoints under /root/tmp
 
 		step 2:
 		      ::
@@ -731,7 +736,7 @@ replicas continue to be exactly same.
 			     /
 			    m1
 
-			  it has two vfsmounts
+		      it has two vfsmounts
 
 		step 3:
 		    ::
@@ -739,7 +744,7 @@ replicas continue to be exactly same.
 			    mkdir -p /tmp/m2
 			    mount --rbind /root /tmp/m2
 
-			the new tree now looks like this::
+		    the new tree now looks like this::
 
 				      root
 				     /    \
@@ -759,14 +764,15 @@ replicas continue to be exactly same.
 			  /  \
 			 m1   m2
 
-		       it has 6 vfsmounts
+		    it has 6 vfsmounts
 
 		step 4:
-		      ::
+                    ::
+
 			  mkdir -p /tmp/m3
 			  mount --rbind /root /tmp/m3
 
-			  I won't draw the tree..but it has 24 vfsmounts
+		I won't draw the tree..but it has 24 vfsmounts
 
 
 		at step i the number of vfsmounts is V[i] = i*V[i-1].
@@ -785,8 +791,8 @@ replicas continue to be exactly same.
 				   /    \
 				  tmp    usr
 
-		    How do we set up the same tree at multiple locations under
-		    /root/tmp
+		   How do we set up the same tree at multiple locations under
+		   /root/tmp
 
 		step 2:
 		      ::
-- 
An old man doll... just what I always wanted! - Clara


