Return-Path: <linux-fsdevel+bounces-71051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B51CB2C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704413007699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB04321F5E;
	Wed, 10 Dec 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ9F0geI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C062205E25
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364435; cv=none; b=WExCRwX2WzdbZlpTV7eR5W1kb2eQK0PgiiqOTmqtIG2JWETYPOUIb2O2xSJYspo4YxFmOkjzyNE4EZZrcQO7vrgGeCBLo2/jgbxkfUBjzhCRGj6dQRynyljtEniawyXNkrhmVn2p10JymMRoFZjyMTQXabBJenPq5gCH8BUs7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364435; c=relaxed/simple;
	bh=TW7ptG2VGLM7MIIXlysIjpDJ1rDlw3b4192SxiYAEhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvUKFwmo0JnVnTu3dxi8g8O+BclpTfLNngx7qjcITamDHVY4EhMu/cruvdu16OqhnrAb1lZAFf4Ou+fF5wz2+a8s54tnzF289/wrpw7CXv9xZyL/izsqQcqoHtSn9pMse4kBMHKS0pp/7Tzjoy6p/HYtYyamIENTt8AywsLj4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ9F0geI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1059806366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 03:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765364432; x=1765969232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUCBAY4qDvjp9wL/tZAVGj7JAq7lGC8EJkzT657t1tQ=;
        b=RJ9F0geIff1Anpml7ltMu/ETl240qYVTIDWN2VoAgAxqXRI/lX0IOGdyNC+8SZoUm8
         qd5U6ItxXZEjYYXKNuafZ1SoO4lzsG/fga+8trbiPiMfHMQ92yvclsW42cwagg+iGOZO
         RSDu7HWOoL5mqfs7CGYtEhY7akRKiIY+xkh0GkjIFMJRl5vcXW+byuNNYoTSei6aNTPk
         Rcg9CB8EXq1F8vzdl73PWXf4VytOVahvpn7If3PtKfvRqbD76G6Mv6VLUmGBij44wYCZ
         VuMuQudxTq0C4Sq2KGCkE9pb62pTYO44GMuDG2AakJwWzPgWGcZIaPGRRaC5zu2sjjor
         1H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364432; x=1765969232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUCBAY4qDvjp9wL/tZAVGj7JAq7lGC8EJkzT657t1tQ=;
        b=Q0tAg2y/03khzKeenr73C4EQHECOhbakFsGEXR6+amBId+LlBqVVSpUbEAxGL0SCIX
         rhwLSOZDunaGZWz4/nLlMXN6XrC9Z5Ve53yvdtLrU/cOhx++GBDBbMA1ndeqBaaUgJpp
         2sNx7dHeofgDHjJnCw3PQISRMaivRjWUEdRTrJc5k118E8e8Kxt4lHw0KET+gwPkKjVm
         4sVIloPFYFuw6GgN/EDy8V4lyY5hnTlfYFIOwDe/mXdh7z1uqu25rzJiapR+cmcSRlJG
         RidPcOT1/sJAdJ3gbpJQHkLnDGgjoNjXpQW29zBMK0h9D9nuHFcjC7GDqUA4AuQZobZS
         ex8g==
X-Forwarded-Encrypted: i=1; AJvYcCWbZoeCiZqG+/eMu8eKzPSGLf0KLEnXprWOsBNe6EiuodZcff//aFqd+TSEmldpaEck9REmvJx+UKWD6oEH@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKm9TC/3FPf1HEZAi8s2ZzJGBuKrOkDNI5FCaM06gsR6RvUj7
	Z/LdcntfSgu7SBq+QN4PQcbfRxTR/8hBrblc7OdZxaCoZlsozrPLXA/h
X-Gm-Gg: ASbGncsZ26cwbG7ypUizSKPAlFcV4EA2Dggzm+96TgflnvH3I1zaWLpXDgMcfoQvhk+
	5je6PaQTGz5FitWrtP7WpOxKZLryZoADYjRZgE39z7k1Z7fQd7ySO4aY8QQHI/soVqqLGarIo0J
	7q6Em3areBKUTXFb18bG2dZGjkipxbGfBRsWgFuRy+J38Z2b2LnGy7ze5fq96jk9nXYgT42fex+
	cG4WVL2dDRGDlDTOtScPAv6LWeJSbdLXLLpfZPbf61jpwgkVcut6+lCFVFMVV6M5Rd/nSnExBia
	tMzNf7KJYvWjyFtkT2f61+yxCD9UPPCXXcQkIDmmYIKmGRuiP2QCuOMBYxQs7JNZLEWYVljuUFh
	Y3h8Jkl2ZW6ea9x9UTfXxpxPy3d17nFc7bpm7XifxEPGWrdsZViDvot+1x/MujfzAWM0Hc39lkw
	lAbMmWYM149AJR9ay/ksQfWpQXFqrJdF6WWq+0WDCMlhwArY84UpbVn2deWQU=
X-Google-Smtp-Source: AGHT+IHJKxYRtQRPvqRYTO6j4tJczi4RErxXKDoLUW8PEh7iqa/+cVG+9TyjyUNKbTJN95ADiumHBQ==
X-Received: by 2002:a17:906:f587:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b7ce847786amr236110166b.32.1765364431914;
        Wed, 10 Dec 2025 03:00:31 -0800 (PST)
Received: from f (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49d24a6sm1633032666b.54.2025.12.10.03.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:00:31 -0800 (PST)
Date: Wed, 10 Dec 2025 12:00:22 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
Message-ID: <f2ui7rofuos4vcuj7t7pa5tcyq5m3agm44ouk7hcdl7opiwmwd@dyctf7rrsuqw>
References: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>

the spin lock is needed because there are *two* fields being checked.
I am not adding explicit memory barriers for smething like this.

#syz test

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 0ef9bcb744dd..8e9127d4dcc1 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -207,11 +207,17 @@ void make_bad_inode(struct inode *inode)
 {
 	remove_inode_hash(inode);
 
+	/*
+	 * Taking the spinlock is a temporary hack to let lookup assert on the state,
+	 * see lookup_inode_permission_may_exec().
+	 */
+	spin_lock(&inode->i_lock);
 	inode->i_mode = S_IFREG;
 	simple_inode_init_ts(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
+	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(make_bad_inode);
 
diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..f2a0f858b7d6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -626,9 +626,26 @@ EXPORT_SYMBOL(inode_permission);
 static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *idmap,
 	struct inode *inode, int mask)
 {
-	/* Lookup already checked this to return -ENOTDIR */
-	VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
 	VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) != 0);
+#ifdef CONFIG_DEBUG_VFS
+	/*
+	 * We skip the type check on the assumption this is a directory, which was
+	 * checked for by our caller.
+	 *
+	 * However, there are bogus consumers of make_bad_inode() which can mess this up,
+	 * to be fixed soon(tm).
+	 *
+	 * In the meantime make sure we are dealing with the expected state before tripping
+	 * over. If this *is* a "bad inode", the resulting state is bug-compatible with
+	 * historical behavior. See the previous remark about sorting this out.
+	 */
+	if (!S_ISDIR(inode->i_mode)) {
+		spin_lock(&inode->i_lock);
+		if (!is_bad_inode(inode))
+			VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
+		spin_unlock(&inode->i_lock);
+	}
+#endif
 
 	mask |= MAY_EXEC;
 

