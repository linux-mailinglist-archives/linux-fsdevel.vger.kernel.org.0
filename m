Return-Path: <linux-fsdevel+bounces-72048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E3CDC2DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8BA301F8FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A72333426;
	Wed, 24 Dec 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/s3Vy5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1561391
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766578257; cv=none; b=nLPZsI9QU+gLDRHfdX8vLAEBu6UNJDd9cNZNW95bhNOjUxFTDKnzJxScs6XcJj7q7KsToXKx5E7EVKjOF8uZgVxw2ag7ZqYTsg1Ir1skLBoodXNxRXSugRXePwgmv5Lndza8MuiHp72T4poz/grfrfa/E8OFsJ1e6LFhNEnIkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766578257; c=relaxed/simple;
	bh=gaEk/FozvI7csbLOEOALR18mmERKfPTC/DiJmFjnlqY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJf385AgO/dEfpyuXAx0p3BJ3xQslqcgpqvmla77Jg1tsL1D0FTZg1iXdbZxAh3dP4wzTeX8b/A1wFrA/Qxy8xw/YS2vqQKQUM1UTcco31pSoof8Ypqe08FFtp2vDc2surOoLA20mdagQG2uO8XHGRDdHwOmQjqrx5uWF9EkIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/s3Vy5V; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5545987b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 04:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766578255; x=1767183055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amDWvZilcUNQCRnb9FMww/04o+Z50BC4wdV0XDGsTVQ=;
        b=c/s3Vy5Vd+7qObHpx4EwOMQOPh/GAUz7tORee1wbImWh7g4HNz48nvElgUfbTNJbU8
         XXAdn2tvkqaGiNtVulQHzfUxYf983hP+NcFdKTOYrxncmpp3OuJwjg0ahxStug0HqkSl
         q1OUVUqLVgfXi45NtDYiItVeQe14oG4TqSE7sf2ckbOE40t09R7daDduJwzy8tgboyLz
         S9lC7UPZnwHvlSKEaoEQk9Z5DCgtshiQUo403PY0sqZNcFDYOFaW6yLctZyxYu9NCCkp
         P8N/uO6938K3rAAmiFbencE7K6A6HE9f1LtV5zMYhk5KQ/zeEP+Fol+rx5gDKhtkBJvG
         IEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766578255; x=1767183055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=amDWvZilcUNQCRnb9FMww/04o+Z50BC4wdV0XDGsTVQ=;
        b=MP4d/M/wZEmGpg/kcoVgxNgzs6Fr/GiKtLUea3M6VMT4NSI2ADgkdpXlraokN57sIi
         +hd5VO9aEQan04bXtZWrAqoXepr0mthfSLbdT7tAuEG3+oKl/QeqTleA4lX6YrQbXDur
         cPkxIA6cAYFP6ogoF+qdWA32hoV3/sAEZ2PCwq7ayoaVybXBshpKFr9WQTtrfHTPcvKs
         jO3OpvYFOXcFKRy410vlEzS38Labsp7vl4TpFw58Kppn3t7wgKKYsTGzWiFhxLYtmt61
         l/cjQ07pZnURb6PlQtbBmmS9BRaCkRy4jOKyZyvCArWZEPJJXRtf6D+ieRdgUCgMPFlQ
         9PgA==
X-Forwarded-Encrypted: i=1; AJvYcCWXGti13nV3olBxlWBlSiVfFdVzgDCA7uEpCpZAf5NNqItu7v+jV6DTS40L3I7pABzV6TLlIj72qVxRDvjF@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHX6eLEjqyPCFu/Tq1q+m4sX5Uu6qzAPpTLhHyZAE43wpMJG7
	fYfqu1/lg+qew3YIq8EO0GKcWCglVpAJmz+yUWI5vEGJlXv25GMXa2qS
X-Gm-Gg: AY/fxX6uN1CZth9xlbunr67VUCBe+bWRIsL7jYWwLzkqxbCA9XRxIzcV53tIFQ/w8NY
	8WQaV7fwCgLOnBp4Qb0lEISFT6rMYFhKyA5oYvixVx/X9k1Z8Fc081QYu21sEQXL1t4WFKtRZ0v
	GEd3VVKftl1Sz9JI0GmizYOuScOzo6GYQ8Z0Z4PUJkAMGrSDBJubAzMJxZunIZ6kecLWMzMVShK
	AEe6g7UiClZolon+36+WBhm3I5uwDophtuOmdxFVg8Bbf2/oJKWLO5BlgfiKutyoCiVh30tg3eE
	RjOHDE8FRb8J+EVOUPy+RUNW3HNTXbvNzVtfOdqaP416H9O9EN7ot1qqNvWIWyLdPqnL0qdLbC2
	8VOO2yUoPE+x3fqCzLk7ONpqZcGIwig00JIAb1QILBhvYxecBwMyqmUg7ENvNpHCBRtdnd4cRd0
	x3A0E=
X-Google-Smtp-Source: AGHT+IGMW8f9KARCRCORQsU4PNhY2Xois2Gs10c6eZiOv5H3XYoy7LVCzNTRaQVZrN60Cq6oSWPrPw==
X-Received: by 2002:a05:6a00:a90e:b0:7e8:4471:ae79 with SMTP id d2e1a72fcca58-7ff68245f80mr14622236b3a.69.1766578255361;
        Wed, 24 Dec 2025 04:10:55 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a1a2asm16666372b3a.41.2025.12.24.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:10:54 -0800 (PST)
Date: Wed, 24 Dec 2025 20:10:49 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: mathieu.desnoyers@efficios.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: do not call sched_mm_cid_after_execve() on exec
 fail
Message-ID: <aUvYMRmkWXUuuWXW@ndev>
References: <20251218032327.199721-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218032327.199721-1-wangjinchao600@gmail.com>

On Thu, Dec 18, 2025 at 11:23:23AM +0800, Jinchao Wang wrote:

Hi, mathieu

Please review this patch for mm_cid.

The syzbot test failure occurs because the syz-repro breaks the system
state, causing all user commands to fail. Actually the syz-rero can only
trigger a panic or error.

The broken system can be recovered by resetting binfmt_misc with:

echo 0 > /proc/sys/fs/binfmt_misc/status


Thanks.

Cc: mathieu.desnoyers@efficios.com
> sched_mm_cid_after_execve() is called from the failure path
> of bprm_execve(). At that point exec has not completed successfully,
> so updating the mm CID state is incorrect and can trigger a panic,
> as reported by syzbot.
> 
> Remove the call from the exec failure path.
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  fs/exec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9d5ebc9d15b0..9044a75d26ab 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1773,7 +1773,6 @@ static int bprm_execve(struct linux_binprm *bprm)
>  	if (bprm->point_of_no_return && !fatal_signal_pending(current))
>  		force_fatal_sig(SIGSEGV);
>  
> -	sched_mm_cid_after_execve(current);
>  	rseq_force_update();
>  	current->in_execve = 0;
>  
> -- 
> 2.43.0
> 

