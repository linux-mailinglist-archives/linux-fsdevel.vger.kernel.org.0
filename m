Return-Path: <linux-fsdevel+bounces-69644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B7C7F9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 909414E86F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC22F547D;
	Mon, 24 Nov 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWqAS7Pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453F2F5321
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976080; cv=none; b=LNGKgYqHMEPHShkLOWlxMAUdrJJU2zYI6b6z/jgbKRY3tfYUN/XBGpsxEp2MgGVhC64F1qKjtTfX9uIx4HND5V6lZwHuKLP5s53A5Jsc32alvhhE/3W+gq+LCDk+KdzuLxXXhGY9YixqJkA2LsAW/HBtlHkjv4A76lq3EMBlc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976080; c=relaxed/simple;
	bh=WCQWxOUqUGAUbYn/1lWx01t1IwMR1YQjdMHluI9xz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGUunQ6mH5719+0ZkjVgSi2DFoTL70jvdeLrok9e1J3aVeJdGV3X6v9TS6jIza7YEpYHDgWw3mLBYyUxdMBA0RPZpkeEFWaD/Pdc/ZW4USKt5RZ0b+ifYk6BgQhpTftFHjUxOSIjw1o8YxInMdJQHzC5GKQTKF78TJzlyOrS15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWqAS7Pt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso7168710a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763976077; x=1764580877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py5UyMFrH5g95YFUXPVBx4QadWCxP51woz9z/OSNb28=;
        b=IWqAS7PtNvFpK7V5En4/y9Uv4RQTnyeV+CgGicKcGH6fC/Wl3zXu4sL1P/g3TATPfc
         A5StVF6d8Uh+3cFi0wkCclPwhkKGL443gxggUUo8KcrrUwDffjmsmRfN+xXzTSzffWBb
         tptnB0xbZaUiL/QscIf3nO6ScLFYSP0t2sc9Jp4PWA/yGv3EYcPWRxx/5uJXv/1yWSg7
         8YPRKCUjm78fGVbJHRm7ASw46CX0rjJU66K3ccM80c433nMBHVBBnZos4rre9ew12ggE
         TRaekatlCmEHvKU1rcCRU3B4LgbZXXIPMuKeWlEdkRp3hHOSelud42nIic6RQ35jO0Po
         BABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976077; x=1764580877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py5UyMFrH5g95YFUXPVBx4QadWCxP51woz9z/OSNb28=;
        b=YY12k4XfmAfxx6yYmaZmR/46yvqafgdZsvd+ZmmeQYUK6cL+jTNG6HqH0gxYlmLGn6
         PrQzxV5bwvzwPW/YhGqVr6vE3ytfFJ5I5t7+F6wRJLt2R3XeTI/TgkgiOchKmftSOqzn
         9sldbUejCoJvhRAswrh6smnztiTCMWmMj025EPDLqQT47wGVLkYdQ9XUY2vKtF+KY60L
         VcBVBeWMjD4LlAsnVy0P4+8nP48kJhvNH0lkZAn7RiNKNdBN85+W78QwzDLGrS8mSpgZ
         URHOQA44+gsDkIqYVNIG8qvu22pN8n0FGMyW3wdd8GIaVL80kdQk9Ux8VvQTSwcdr7x4
         IcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx3H42OHqdX+VIMRCUzCYxWjqn7wEarzC7LoIULO6wyyX2gfM4vlLATb/eisp6Aa13p4OoNoIR64OUYB6L@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVSMoiuFWrz8l1VZpPgR+UGuIvOr1eddWh2xeKdnnhusM80I5
	8ELJ36zN3VbopPtMxTciC85jHZHNWOOtCHbACYastaLJ5ei+d4rHT58W
X-Gm-Gg: ASbGncuT0wtNy+m7qkAyGtMK0WDjOnPSm/NtLq/XhB64jhVK+g3dB+6OrFGGCDMdDJF
	AoWc7Lz3RhGBBizcjR06q5RoEG7zobq6oB8AjvC5lLtAJZ+JsbJb7HYToxdvgxyp7qJN5V4nkZB
	/anT73hDThGx84ruObvW0hYSX0A0c/QZ5Apla/T8WYhAa5fj/Ha4IfK3SUVLGhmPS6B+PZ4nHRa
	84iOgstREGGmQGNVgXVAzbB0vjM8zTSw1D5o1WWZyk3YTpLcTrCOpbtm1R2npSuSyeV+xtP6uHW
	Ex1sjaj2xRYz6iiEJE1YbOG8N3jLhJTv++dkPS2TlnWpaBgxTK8eNDc0gHpYhHvf54x0kr3qAAH
	8aJhlPbCPOz9TDqdjclGg/UwK2usblWz7G40m+Ls7bEp3zCXo2Mqse4KeV+HbvfntTxgv0+LbR+
	pygyFbaTSTQ6fnBZ22Poi73WbjPi/irbynMqOq2Km/qmpJVIdVg/shAKU3
X-Google-Smtp-Source: AGHT+IEq6wk6IF4PKQSBwW24QSZ4NyUido17WV24VCrnxRb9lAJx3PtZq9pP6MUoSZR1PE+9azUxIA==
X-Received: by 2002:a05:6402:3246:20b0:640:c640:98c5 with SMTP id 4fb4d7f45d1cf-6455469d112mr8161208a12.34.1763976076961;
        Mon, 24 Nov 2025 01:21:16 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b6012sm11432201a12.12.2025.11.24.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:21:16 -0800 (PST)
Date: Mon, 24 Nov 2025 10:21:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org, neil@brown.name
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <c2kpawomkbvtahjm7y5mposbhckb7wxthi3iqy5yr22ggpucrm@ufvxwy233qxo>
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com>
 <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
 <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>

On Mon, Nov 24, 2025 at 10:01:53AM +0100, Mateusz Guzik wrote:
> sigh, so it *is* my patch, based on syzbot testing specifically on
> directory locking vs inode branches, but I don't see why.
> 
> I take it the open() codepath took the rwsem, hence the rename is
> sleeping. Given that all reproducers find it *on* cpu, it may be this
> is busy looping for some reason.
> 
> I don't have time to dig more into it right now, so I think it would
> be best to *drop* my patch for the time being. Once I figure it out
> I'll send a v2.
> 

good news, now that I gave up I found it.

insert_inode_locked() is looping indefinitely an inode which is no
longer I_NEW or I_CREATING.

In stock kernel:
                if (unlikely(!inode_unhashed(old))) {
                        iput(old);
                        return -EBUSY;
                }
                iput(old);

it returns an error

with my patch:
               if (isnew) {
                        wait_on_new_inode(old);
                        if (unlikely(!inode_unhashed(old))) {
                                iput(old);
                                return -EBUSY;
                        }
                }
                iput(old);

unhashed status is only ever check if I_NEW was spotted,

which can be false. Afterwards the routine is stuck in endless cycle of
finding the inode and iputting it.

Christian, I think the easiest way out is to add the fix I initially
posted, inlined below. It *was* successfuly tested by syzbot. It retains
inode_unhashed checks even when they are not necessary to avoid any more
surprises.

There were some other changes in the area and turns out sending a v2 for
the patch would result in some merge conflicts, on the other hand the
patch below should be trivial to fold into the existing commit.

Sorry for the spam everyone. :-)

diff --git a/fs/inode.c b/fs/inode.c
index 0f3a56ea8f48..80298f048117 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1311,12 +1311,11 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		spin_unlock(&inode_hash_lock);
 		if (IS_ERR(old))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(old);
-			if (unlikely(inode_unhashed(old))) {
-				iput(old);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(old))) {
+			iput(old);
+			goto again;
 		}
 		return old;
 	}
@@ -1413,12 +1412,11 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 		return inode;
 	}
@@ -1459,12 +1457,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 		return inode;
 	}
@@ -1501,12 +1498,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (IS_ERR(old))
 			return NULL;
 		inode = old;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1648,12 +1644,11 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 again:
 	inode = ilookup5_nowait(sb, hashval, test, data, &isnew);
 	if (inode) {
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1682,12 +1677,11 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1863,12 +1857,11 @@ int insert_inode_locked(struct inode *inode)
 		isnew = !!(inode_state_read(old) & I_NEW);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
-		if (isnew) {
+		if (isnew)
 			wait_on_new_inode(old);
-			if (unlikely(!inode_unhashed(old))) {
-				iput(old);
-				return -EBUSY;
-			}
+		if (unlikely(!inode_unhashed(old))) {
+			iput(old);
+			return -EBUSY;
 		}
 		iput(old);
 	}

