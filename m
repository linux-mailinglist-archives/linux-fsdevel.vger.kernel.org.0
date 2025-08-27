Return-Path: <linux-fsdevel+bounces-59381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B18B384C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87A364E3067
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9B356918;
	Wed, 27 Aug 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKQbhntY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965622820C6;
	Wed, 27 Aug 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304346; cv=none; b=cFfvYCpieXgmqZdAO5xHZvOngfuUOKNbsgeTnACFWm7vyDo++z9KJzeW6qteY+WWldUlPFbshUmjrTpHhHZKW/Bs72085opnX+I2sGaf5SGNiSQumxC4mUqWGpYH3n3Le03IKkDGp2f5t28OgsGF5GgPt4U/XlkA06AW3WIlXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304346; c=relaxed/simple;
	bh=PW1ZKXH0rYhUpslBdMf+J7nnkIKBzWdKO+KYXBhA7to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBvipZ1oXnfJAdANR8znlkzzfJYODSud/iixAg1ym9iWVyr26gsh4bpCqEHORFzS1FXHVDxbVLCxM/2C4dh3eqByNL5ssz6BiO53b9y+NPcgfLUj8HpDNMVDxo3Yoq/0wH/TY8n5UK/DknXld8Vg2QuSbJXo60SnO89FAntbL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKQbhntY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so52060035e9.2;
        Wed, 27 Aug 2025 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756304343; x=1756909143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq9YmfRM9uuzsM4UJKn72gQyBjMQ1eflfSGbvXdA420=;
        b=GKQbhntYOkzYpEfiNpJYQPv+RBH/YVJEq/ZE07hMstMQL9XBUDblV3Bo+O3+HpqYxz
         lON0bJHu/3phrqNwsIVgDpOlxEVaQjprgtI1zy4IfGXUWM7xQuwOVVdlwQA/T3DKS6gl
         UUbAiQMRzFbaL59oeAlutzV9rp0lrApP+3DLeV/7QQSB37wtopMXj7gExRjKRq6TcFYC
         Y4b3ktJwRpNrK4QbWjiS3JfXGwxr1uqbseiV01roMjwoFAz+JV3yKohh75vJCJBQQbql
         i13UCPdPlAQTTLzRcDwPsTWttDQYsX2VM6WjvMu9Iw8IXg0uqec9VxXearf/lBjoN/l2
         9RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304343; x=1756909143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq9YmfRM9uuzsM4UJKn72gQyBjMQ1eflfSGbvXdA420=;
        b=ZS4ywF/NtGffkA2BJOGzPle5pK7K9FGN6Vk4lHzc2/V1mUDOZVppkXG4oNTRFsDc+E
         eUk0FZRT+orlx704/TuUcNLdVrWKO3Lrb+CWPzd0XQ4aoikbCLuJnKB0lL4BBfi61JPN
         oGFrf8/d8HAQY/eGjenHh+gzlMzx3J57+EHlFaFcN7btkmabdq4kcyQTn+hbOSQHGCRK
         E6qKCMRSI+qdge1sc3QZkyMIcciIlcoP1/DlzJF8zd+Gby39bslXHD9sJJaAYUdo6Ols
         IYtEFDL1MJLm/d1L3Ue3r0RVnfSK7rKpcvU//RXOD5CILOMRSYVArWifpcGjDGAPWV9r
         j9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWulQNSWDayweMySfX68mVTgjQ9+MXEfSOrpPqqM+qUer0eNvipvwAqrfCs57GsRc5YggAa5CyhxQS9gA==@vger.kernel.org, AJvYcCXOTZo58XMEQ1+c1C+e6aBzxqAauYnrAUCBfBYQFFD0pTKy8weO3kaxp6Es0fQYGtAL3m2hBt039GI8aw==@vger.kernel.org, AJvYcCXi4waCixC824Xsr2ZhU4PdrulHo9cCyoW1u4uTX805sKZoxZTZl4YM3uU8ZuTXeOrHHTK+CdzGg6U3@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLWLkci7QjzJylp1LZPN8SeFSswB69HzJ+ohmPUmsO/86pr+8
	gHkc4ltVgPSlHYKqCJRrly2QPn3UsQ7NfUaJR3ozYx9a/+fSzgpr3DMs
X-Gm-Gg: ASbGncugNeu8swvxCgMrOLKOS1niBIy+oJ0lfMnfKPU0M1GxZH1PGdw++pNjQaZtkmk
	nS8lANauHpqjLZOTLsktzwztKpOfcrDgQW1csjHZEQDDUrFz1QBFpQqgOk3uCN/RKKTp13/8s6r
	gzoj5FevRUB1DbLfg8YpY7wLJrP/hXljWiep2E+hLgcq/ujOqB+4bDeAGheu3p8/aFTUVHblJTu
	GvKqTem2Dkc2ezyaGACKZU9IG6Q6RkcPnd1PUm8LIFm15PyVnu/HSpls5dV/i0mXVKNa/pMhRzK
	TjaEAtv3R69lHrtVvDSWNbL8j2+0K8SSc9ICeITU+3KLQjE+j69afwmgh0osK26P4B3eaeePLNK
	MvS2UqeibNccAl2dHjenVT20M56JtBnmLaLk=
X-Google-Smtp-Source: AGHT+IE0gR/fkJ/N4kuE1Yrp9oBmyGnJ0IW4DftNNxQs2eJrjJm/YsAo/Vm1wbR+G1zI5NRJoKdH3g==
X-Received: by 2002:a05:600c:4fcd:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b517db94dmr142000005e9.34.1756304342701;
        Wed, 27 Aug 2025 07:19:02 -0700 (PDT)
Received: from f (cst-prg-2-200.cust.vodafone.cz. [46.135.2.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f2eb7c5sm34801285e9.23.2025.08.27.07.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:19:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:18:55 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 03/54] fs: rework iput logic
Message-ID: <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
 <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>

On Wed, Aug 27, 2025 at 02:58:51PM +0200, Mateusz Guzik wrote:
> On Tue, Aug 26, 2025 at 11:39:03AM -0400, Josef Bacik wrote:
> > Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> > set, we will grab a reference on the inode again and then mark it dirty
> > and then redo the put.  This is to make sure we delay the time update
> > for as long as possible.
> > 
> > We can rework this logic to simply dec i_count if it is not 1, and if it
> > is do the time update while still holding the i_count reference.
> > 
> > Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> > and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/inode.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a3673e1ed157..13e80b434323 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
> >  	if (!inode)
> >  		return;
> >  	BUG_ON(inode->i_state & I_CLEAR);
> > -retry:
> > -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> > -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > -			atomic_inc(&inode->i_count);
> > -			spin_unlock(&inode->i_lock);
> > -			trace_writeback_lazytime_iput(inode);
> > -			mark_inode_dirty_sync(inode);
> > -			goto retry;
> > -		}
> > +
> > +	if (atomic_add_unless(&inode->i_count, -1, 1))
> > +		return;
> > +
> > +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > +		trace_writeback_lazytime_iput(inode);
> > +		mark_inode_dirty_sync(inode);
> > +	}
> > +
> > +	spin_lock(&inode->i_lock);
> > +	if (atomic_dec_and_test(&inode->i_count)) {
> > +		/* iput_final() drops i_lock */
> >  		iput_final(inode);
> > +	} else {
> > +		spin_unlock(&inode->i_lock);
> >  	}
> >  }
> >  EXPORT_SYMBOL(iput);
> > -- 
> > 2.49.0
> > 
> 
> This changes semantics though.
> 
> In the stock kernel the I_DIRTY_TIME business is guaranteed to be sorted
> out before the call to iput_final().
> 
> In principle the flag may reappear after mark_inode_dirty_sync() returns
> and before the retried atomic_dec_and_lock succeeds, in which case it
> will get cleared again.
> 
> With your change the flag is only handled once and should it reappear
> before you take the ->i_lock, it will stay there.
> 
> I agree the stock handling is pretty crap though.
> 
> Your change should test the flag again after taking the spin lock but
> before messing with the refcount and if need be unlock + retry.
> 
> I would not hurt to assert in iput_final that the spin lock held and
> that this flag is not set.
> 
> Here is my diff to your diff to illustrate + a cosmetic change, not even
> compile-tested:
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 421e248b690f..a9ae0c790b5d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1911,7 +1911,7 @@ void iput(struct inode *inode)
>  	if (!inode)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
> -
> +retry:
>  	if (atomic_add_unless(&inode->i_count, -1, 1))
>  		return;
>  
> @@ -1921,12 +1921,19 @@ void iput(struct inode *inode)
>  	}
>  
>  	spin_lock(&inode->i_lock);
> +
> +	if (inode->i_count == 1 && inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> +		spin_unlock(&inode->i_lock);
> +		goto retry;
> +	}
> +
>  	if (atomic_dec_and_test(&inode->i_count)) {
> -		/* iput_final() drops i_lock */
> -		iput_final(inode);
> -	} else {
>  		spin_unlock(&inode->i_lock);
> +		return;
>  	}
> +
> +	/* iput_final() drops i_lock */
> +	iput_final(inode);
>  }
>  EXPORT_SYMBOL(iput);
>  

Sorry for spam, but the more I look at this the more fucky the entire
ordeal appears to me.

Before I get to the crux, as a side note I did a quick check if atomics
for i_count make any sense to begin with and I think they do, here is a
sample output from a friend tracing the ref value on iput:

bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_count.counter] = count(); }'

@[5]: 66
@[4]: 4625
@[3]: 11086
@[2]: 30937
@[1]: 151785

... so plenty of non-last refs after all.

I completely agree the mandatory ref trip to handle I_DIRTY_TIME is lame
and needs to be addressed.

But I'm uneasy about maintaining the invariant that iput_final() does
not see the flag if i_nlink != 0 and my proposal as pasted is dodgy af
on this front.

While here some nits:
1. it makes sense to try mere atomics just in case someone else messed
with the count between handling of the dirty flag and taking the spin lock
2. according to my quick test with bpftrace the I_DIRTY_TIME flag is
seen way less frequently than i_nlink != 0, so it makes sense to swap
the order in which they are checked. Interested parties can try it out
with:
bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_nlink != 0, ((struct inode *)arg0)->i_state & (1 << 11)] = count(); }'
3. touch up the iput_final() unlock comment

All that said, how about something like the thing below as the final
routine building off of your change. I can't submit a proper patch and
can't even compile-test. I don't need any credit should this get
grabbed.

void iput(struct inode *inode)
{
        if (!inode)
                return;
        BUG_ON(inode->i_state & I_CLEAR);
retry:
        if (atomic_add_unless(&inode->i_count, -1, 1))
                return;

        if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
                trace_writeback_lazytime_iput(inode);
                mark_inode_dirty_sync(inode);
                goto retry;
        }

        spin_lock(&inode->i_lock);
        if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
                spin_unlock(&inode->i_lock);
                goto retry;
        }

        if (!atomic_dec_and_test(&inode->i_count)) {
                spin_unlock(&inode->i_lock);
                return;
        }

        /*
         * iput_final() drops ->i_lock, we can't assert on it as the inode may
         * be deallocated by the time it returns
         */
        iput_final(inode);
}

