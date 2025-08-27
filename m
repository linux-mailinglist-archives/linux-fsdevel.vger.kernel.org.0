Return-Path: <linux-fsdevel+bounces-59363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9DB38325
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400A21BA507F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81149350D6E;
	Wed, 27 Aug 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BltaOS9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF41C8630;
	Wed, 27 Aug 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299550; cv=none; b=t8lfuFt8BuDwoAKXUKlw30taFvLBlDephWJMMt7ONM/h7gW2IhtWsNnK+PHaceFlR6lqYegcGEZb9mXhekhObQ+dbq21815ZF7n59aXp5mMjZGjErKThHeADosezl+KjaRK4LJgR/oiOfMsXYDUJFKhybyabSLxj3WzUFaE0/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299550; c=relaxed/simple;
	bh=k5b6V1BPHmXeEFWxbNEHIso8tp9rJVsuQrImKyzdEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBpUK9chviB60i09Ml+InLI64KXyy27hNf9ofc+elN4pPedmlBA5IMAjzBvNxwxHOcBAbTrDa+diRcXveeIjEL7NyHR8OBU4isEw5Jy0H1BfyFdirD4QYFANTA2lgYZDrDq5N6zzZEZvrBzIQtMUodBhIiIMjs4xibziFj3gMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BltaOS9D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so41892695e9.3;
        Wed, 27 Aug 2025 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299547; x=1756904347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+d4XmKGdzACc03x2MkMG9S1v87UXpY82hMtgHKV5SzQ=;
        b=BltaOS9D+d9Pg9C5P8ZdoL7RrGoRiaXkKfRnnOab3kdMVggXmKZVlRTERzQzVFz7PD
         A+c9i0Ui0N1OPiDI//kpv/EGdaZIn6sjhgA2pHDhm5R5bSNwzwLe+vIjq4tx528Gz9j6
         nn5tidp8ZjdG6CblXQuDmVBm3MG+TvKTYLBzoXQDim65x6PSEYLm/aivvs8tx9jHUX9b
         pjYuvAIssTbuKZfaschH9H4NmrXncA9T6xKe9Er74/kaitaZZFLV9x0kbPZAgUzXKlzF
         oFFY5CqXGPxaYy8EyBmBPawpLEf4UkzLp7t1V+r/lluNs7u2lMBKRHKg4j7WrkuJahDW
         twaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299547; x=1756904347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d4XmKGdzACc03x2MkMG9S1v87UXpY82hMtgHKV5SzQ=;
        b=GWk2Z2o7YtiMFNwI4qc9YG/TtoTgVHqXI0AohXp/fcPHKrXZHO0vv52wFNjslnbBoL
         UxtRa++05ij/OAzR8fmWgQ3LMbo20d3U98zYrJFejB3em4clo25SGmj2CrEjV66wjBZ1
         BGGKYMA+1AYU7qDb+3cyWTmSP75RjGc04P2LN+Lih1iz+vd8/p0vMVQPS1pOIn/EdmgG
         FDfVR2RSB/NgJbHSp9zTVaYJ7v5B+Is2jM0XMTsKLaWal5gPyHi/M5kS0fl2Gsr0jTX+
         VplnVUvHPcoiHSRJHqgxKJenD05fi0jJ1l81P/SlTwTtz3JSQ+yJhVdQfzLdlUTH0JDr
         n0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUThOABygJKbnMsC5JOfu3gtghFoYZLnVKS+oVPUUzK/8FaZykmFTETKOPhdNKp6U+ab4xhBL6gT8Pb8A==@vger.kernel.org, AJvYcCVvb5ddJaesr2NamTDknR84W0JOWVeUoSqSrmOtvY+/YiBaqDJAKTF2nUDpzQKOmAMjtU4RPGwl/SZdIg==@vger.kernel.org, AJvYcCXoJE2ipu+E6Gd32HmR3EqSxmR6XixWtyxtUgIOhOF9jfWptTR/ZeOIf5Abep0SqY9gt5OgiqYyaW7v@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnFjjpbmGMp6QHL1OGG7OlFrgzY3gAu2v2rvfPL9aiL/Z7G08
	VeG6FdTOI7/6L4hd11ZL0Y0kbD7Hy2FwTCKsJSJ5Kj2rOjo9Q0cqOtV0
X-Gm-Gg: ASbGncs1aAcUPohEYm3vjkUjGBj5c/qJeiMY5QOSCj4hUmj/L+TZa2F7UIG9rqc95cO
	Yd5iRwV69B7SyQdmRgm6aKRM48IBPlRsCA3/Fr69lZW5aui1yHw9V884vwH8yhfm1CzQ2P28G3u
	ARNQYcL/4m8EFU4bZGBUmSubkOOr+FLWb8strk/uPaTMcBFVWBOrXHZPrRG3Md7nXGNEwQNfKlM
	ML+U5yrsygW9xovvDczkQNa/MvHcRsnCmz63MLRQeqX/jpfjZK+tVTUxMy/G97wu6MznWkp2YUK
	mdSJC/H4ZmWVTzYJRFsZ3RcFOSJHynVMWSjSVi7dxgjccQweCrUKa6+xDweGalwthIu6w636au6
	qOAR2ZSh2Joctnf9fPbstf7os2V6MsgOgRlR7ps2HFEZfrA==
X-Google-Smtp-Source: AGHT+IEZc1bl4fzlTsX7fA5rUjaJL1ElOfoivCagPCZ4PWKyiF0ZCrPucztQdOZywJa3UqFe2dMIpQ==
X-Received: by 2002:a5d:64cf:0:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3c5daa27b91mr11545441f8f.9.1756299547007;
        Wed, 27 Aug 2025 05:59:07 -0700 (PDT)
Received: from f (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73c52735sm10522755e9.22.2025.08.27.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:59:06 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:58:51 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 03/54] fs: rework iput logic
Message-ID: <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:03AM -0400, Josef Bacik wrote:
> Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> set, we will grab a reference on the inode again and then mark it dirty
> and then redo the put.  This is to make sure we delay the time update
> for as long as possible.
> 
> We can rework this logic to simply dec i_count if it is not 1, and if it
> is do the time update while still holding the i_count reference.
> 
> Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a3673e1ed157..13e80b434323 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
>  	if (!inode)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
> -retry:
> -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> -			atomic_inc(&inode->i_count);
> -			spin_unlock(&inode->i_lock);
> -			trace_writeback_lazytime_iput(inode);
> -			mark_inode_dirty_sync(inode);
> -			goto retry;
> -		}
> +
> +	if (atomic_add_unless(&inode->i_count, -1, 1))
> +		return;
> +
> +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> +		trace_writeback_lazytime_iput(inode);
> +		mark_inode_dirty_sync(inode);
> +	}
> +
> +	spin_lock(&inode->i_lock);
> +	if (atomic_dec_and_test(&inode->i_count)) {
> +		/* iput_final() drops i_lock */
>  		iput_final(inode);
> +	} else {
> +		spin_unlock(&inode->i_lock);
>  	}
>  }
>  EXPORT_SYMBOL(iput);
> -- 
> 2.49.0
> 

This changes semantics though.

In the stock kernel the I_DIRTY_TIME business is guaranteed to be sorted
out before the call to iput_final().

In principle the flag may reappear after mark_inode_dirty_sync() returns
and before the retried atomic_dec_and_lock succeeds, in which case it
will get cleared again.

With your change the flag is only handled once and should it reappear
before you take the ->i_lock, it will stay there.

I agree the stock handling is pretty crap though.

Your change should test the flag again after taking the spin lock but
before messing with the refcount and if need be unlock + retry.

I would not hurt to assert in iput_final that the spin lock held and
that this flag is not set.

Here is my diff to your diff to illustrate + a cosmetic change, not even
compile-tested:

diff --git a/fs/inode.c b/fs/inode.c
index 421e248b690f..a9ae0c790b5d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1911,7 +1911,7 @@ void iput(struct inode *inode)
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-
+retry:
 	if (atomic_add_unless(&inode->i_count, -1, 1))
 		return;
 
@@ -1921,12 +1921,19 @@ void iput(struct inode *inode)
 	}
 
 	spin_lock(&inode->i_lock);
+
+	if (inode->i_count == 1 && inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+		spin_unlock(&inode->i_lock);
+		goto retry;
+	}
+
 	if (atomic_dec_and_test(&inode->i_count)) {
-		/* iput_final() drops i_lock */
-		iput_final(inode);
-	} else {
 		spin_unlock(&inode->i_lock);
+		return;
 	}
+
+	/* iput_final() drops i_lock */
+	iput_final(inode);
 }
 EXPORT_SYMBOL(iput);
 

