Return-Path: <linux-fsdevel+bounces-74316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18AD398C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 19:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F16E30076B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BF2FC891;
	Sun, 18 Jan 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2sWgg2C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q1f6rTjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672023ABBD
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759531; cv=none; b=dcb4+AJnTVyn/lLs7xZaXaxMX0DWJ1CFrTrkWMqj9DTH85aaNR0gGB2nQjGGvlKYW15cLEbN7LRskXvZBrSo8sZhHzi/E4ZK56uMt7Lc3jgWa+C8sdYhi3ncEzlmZKLipZILwF1GBGkOp6JqnjH4uRO3CkaXQnrtlOF2+sXbeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759531; c=relaxed/simple;
	bh=EBopMWp3Nu+B1DwCwjkUZBZPU5R58050Bh9WTkE2Jvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZrk3gRAgWwhhyYUFXpdiJY0Go0rKseXQyVatxQZvTO89vWg6VeKc5HdmvXp8prPekDm69ZMYabvpkbRDU0zsxd1ggGwVl0U48i28Ptmcj1o9E7bQdLUvGzzjaJ6ToXUorCj92Z+VES61sFqs/8lyqAw7tUuGoXQ970xooVlpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2sWgg2C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q1f6rTjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768759528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
	b=V2sWgg2CB7VefyVC34j25hl/3jwWZQutAyqW+cFygZlD4dFDpyInGkKxDHCW7XZuWJKp4r
	G+xEdPeduxyZwCDjDNfAhNDsGTkTdc91CKdqeA/2ro3Qpt8AJMr6ooOXrZ8WqvKf+aLq5R
	QyuX1/VymfHFYREE2gQWJZ9ywGN8D48=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-wgF9q96MM82yHkm9JTg3yA-1; Sun, 18 Jan 2026 13:05:27 -0500
X-MC-Unique: wgF9q96MM82yHkm9JTg3yA-1
X-Mimecast-MFC-AGG-ID: wgF9q96MM82yHkm9JTg3yA_1768759526
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso6599424a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768759525; x=1769364325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
        b=q1f6rTjsFDgqgifOi9+xYaacb6XBGgqXkQ3n55HgfyPKULlheeIsBrqYHZ2txHymvY
         yvA/VPxqYt2aeqdFZjwdmAp58mAwwUNIANUyF4gCAVMSXvjLh9Tz1NdbS+5dHGPzexA5
         bESxX4GxXoHbl5dazodi5H2IKnnTaHQFNR1PwA9biB3xSXGwhkWgNs06SwTKpvGVDZvQ
         nWYXs35CmzVysvkV1XSdaZ/r3palFXQcXkhNovhhLjEUtefTxan0ADPPdmyrlizNGP83
         5yvLr17+nif7wSg0baUp58eB0IJbLdqTV9nGoa8WzpDXYbzv5yxl+LTM3UhbD5hUknSm
         8fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759525; x=1769364325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
        b=NAiV3V2D1d53XsNFgc4H1uvj6kqxkSK0IAIwVfrW+zsTwpFsc4PSlT3Y61wbuNFm/R
         q1rwxXObuYK8nZFvmlhWRgP0xCWkjbwXUHlE1ebN1cERCasH8HY8kDsTtLLJypGqViVw
         kf+iZEvy8+WeXLLypME8D4hYYn2VJ0XBuQmqA/jMClMN2TtNT3aNj4HPYe9xc4Z0yW9O
         W/t+U3c7NWR/+3F8mA3IhQkUeQ0pTIULPj/HDFw62VcI1d2i32LM0DBBy74Plo/YBbo2
         i2CfzA8Ygu+MuGZLKs6vHBqD62R7cgb4CARZMGEJ6luWpQyiBGYotFPhLLxY7TWACtQa
         CUbA==
X-Forwarded-Encrypted: i=1; AJvYcCUcJToLfr/7EFKWBkI55/bLnkq9BpIPMuaiHVwzxZP1gzIj0eUIknbI4T4Px4fnLhHC7pMdSe2Y3hjJn7xt@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmLOQPCuUsvnnqL/diVZAgAUSHZ10wIwVVYDlrezekhznbVsi
	4M2qF6cYgXo+HBopfKn1RguVnEbzKqdJyXkyHmDSLD7iI7XCTNZeG/cnbQg33auzqo1TeQdJ/p3
	iFQA4qSVFmjoNva3iKaAWwckgz7pnVWOe/tetsmUSekLjlwzmUXvquMgwFGOmcA80BRb2sbrWYH
	U=
X-Gm-Gg: AY/fxX6O/gLcduav8aTzMgdBUQ3EVs3YP3e9MDuhgzfj20XJhIweijVGOtPNGUtcPTi
	AJutLmXks3u8s26S9f5zwIcreJBlfpIpXAsvJknfsooDFCx6+zI9iTrENTg+3Mn7ilNiftoqCbq
	Ke3TJ1g7u6x5YV6XKHjSCQ9mVz0YRmIJlJr+l/bKCRdFNMnDFnjCJn6WcGrOBSIzFmspRGJtVo6
	dFwnyln3poDs5LUOtWXg6DImDTxyB8b2+idNNpeiE3juVtZ/gtgrDr4S+DghNN+MmLnXs2Gvb5D
	8HzCjzIipYvOem8Rolsi1xwVCYSWCc2NtMF2WveWQYLdmRvI601jmMKb+mp5qX3p9Y5eJmI9M3B
	q02dmzlLIrkZ6afLyum9Q87v00ZuUZBfc2TDljYfw836YVb+3Dg==
X-Received: by 2002:a05:6a21:328c:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-38e00d5d087mr8300944637.47.1768759525535;
        Sun, 18 Jan 2026 10:05:25 -0800 (PST)
X-Received: by 2002:a05:6a21:328c:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-38e00d5d087mr8300922637.47.1768759525007;
        Sun, 18 Jan 2026 10:05:25 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b16sm7027939a12.30.2026.01.18.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:05:24 -0800 (PST)
Date: Mon, 19 Jan 2026 02:05:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com, fstests@vger.kernel.org, zlang@kernel.org,
	Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] xfstests: hfs/hfsplus don't support metadata journaling
Message-ID: <20260118180519.xdddwoke2tey6ogt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260106233555.2345163-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106233555.2345163-1-slava@dubeyko.com>

On Tue, Jan 06, 2026 at 03:35:56PM -0800, Viacheslav Dubeyko wrote:
> HFS file system doesn't support metadata journaling.
> This patch marks HFS file system as not supporting
> metadata journaling in _has_metadata_journaling()
> of common/rc.
> 
> Technically speaking, HFS+ is journaling file system.
> However, current Linux kernel implementation doesn't
> support even journal replay. This patch marks HFS+ file
> system as not supporting metadata journaling in
> _has_metadata_journaling() of common/rc. If journaling
> support functionality in HFS+ will be implemented,
> then HFS+ could be deleted from _has_metadata_journaling()
> in the future.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---

Good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index c3cdc220..82491935 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4267,7 +4267,7 @@ _has_metadata_journaling()
>  	fi
>  
>  	case "$FSTYP" in
> -	ext2|vfat|msdos|udf|exfat|tmpfs)
> +	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
>  		echo "$FSTYP does not support metadata journaling"
>  		return 1
>  		;;
> -- 
> 2.43.0
> 
> 


