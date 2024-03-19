Return-Path: <linux-fsdevel+bounces-14814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7395880028
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914C028210B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF288651AB;
	Tue, 19 Mar 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqrqLXVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E55F84F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860396; cv=none; b=teBPdQned5MIJqvufnSgTdjwa51e9DGh/k+ssSkuqNmTtftvayrEX+xktg5dSflVQNN0FR3VSBfDWVGxn0pSJGnDRdUSH/WnrjnWuHMyBn6djnP1X5XIkRcY/vMm6se7Io06ynriQeDUsXScZFAvSUkHODW6uDHclpO0PJOIVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860396; c=relaxed/simple;
	bh=ajxpaMC3T8IunaZ5P+9lA5RJwsCq/EAHYOIJkPgl3hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGtw+shrA2UYBcDKO6jcEuqDVPlg7UjT+3VHylIkfQvZLS83c3+6iqezJyNyYpItCUMA2ZUT4Ldy+rsxh5XBYuEWcX+VKiU5ra58xWGP3gl0FwsK49wIAABS7SmTYmYOuxtQxoJlKHCxWEjKKanhWdpzCoWqlK8j5B4hl37MJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqrqLXVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710860393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ia2sWuwHy79VhH6nPO9UUd5RJV3cIBJb+5/X2TNMkJY=;
	b=KqrqLXVlS/xZX2Dsdqmu9GRb92XmVs5hl/qRE6zimXIQ9PA+ioWnule0JSkTQTPI5dznvP
	JVazrCKliMxiumyT9RIvZ/HlxCzL83uOyyJw1gfYm66Z92H2yolyTXaygX2HzcSnhzdCRW
	eISRlJhQ1WWupiWB76aowmvGyi8sVkI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-_f-7tYo3MNChZ31AHle5rA-1; Tue, 19 Mar 2024 10:59:52 -0400
X-MC-Unique: _f-7tYo3MNChZ31AHle5rA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46ba1a19fdso175614066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 07:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710860391; x=1711465191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia2sWuwHy79VhH6nPO9UUd5RJV3cIBJb+5/X2TNMkJY=;
        b=PU8QLLqUzbxzup1YFouf4cDRz8y7Kn5KzrthHzHB4d55BPIdnokFlPo45VXySgjkHh
         lhUyfbHeguF5rXxsswoJyPLErAbaHR6fKTyBjWzKMJRiuoQhvsKeb2Gcew3nVo8g4YN6
         bzwZEqQX3YmV8F99ZxQ4YIDg1i63ORAd2/dzRyAPAkMGq8Z7DsDEgZ1NjDF/ApCXWvEc
         Ks625eUeoBwHvU4QArv5FBHnDq3TFnVtbnzazUw8oJX0bTlu6mek1mhKAOpn3pMXHCW2
         +YO3SbZ1qKbkWuCKxVwJfrOijDchJUwW7KGKVtzYGxRBvL/UsCuiKZB5b/FO9PhMV+CS
         MDSA==
X-Forwarded-Encrypted: i=1; AJvYcCXWn/eNtCOXjtbvzycdBizIcbnGsK/bEFl9gKuWZ6UPCR7PizGvA6EUlO+Rz8l6y3LPbsmkjXw9jmUK3j1nuvm2nV1cpvra7+A/hsyHPw==
X-Gm-Message-State: AOJu0Ywjqkq/dep3MlNllIGLQwDjI3ftq7LU1B0whxjHdzCc4Oywm5wL
	I7mNmdvukEidwQTBpS6WwKJ11t0q1IL3i7JfBmZBICoTtRsqPG0QUOcd+iiv9evSklwWTJNcQLu
	+TfLLig5USfP9UteloVoweIijoIYxRt3OwqcHkCAxnYJ9A5nDudLYvGjWwoFffw==
X-Received: by 2002:a17:906:bc95:b0:a46:9b71:b852 with SMTP id lv21-20020a170906bc9500b00a469b71b852mr1799583ejb.26.1710860390643;
        Tue, 19 Mar 2024 07:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGkhUvQ74NDR8xixLTTUY2PjtMB1t6xn8SFEqwr9V0Tb0eFn1ewzSnxrxKXEH+0uqKR3BI3w==
X-Received: by 2002:a17:906:bc95:b0:a46:9b71:b852 with SMTP id lv21-20020a170906bc9500b00a469b71b852mr1799556ejb.26.1710860390115;
        Tue, 19 Mar 2024 07:59:50 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a46da83f7fdsm1040601ejc.145.2024.03.19.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:59:49 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:59:48 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, zlang@redhat.com, fsverity@lists.linux.dev, 
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, guan@eryu.me, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/{021,122}: adapt to fsverity xattrs
Message-ID: <qwe6bnzuqkmef5hpwf6hzv5ce447xij7ko67vvasjcnzxy4eho@xnvyvawp5mba>
References: <171069248832.2687004.7611830288449050659.stgit@frogsfrogsfrogs>
 <171069248865.2687004.1285202749756679401.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069248865.2687004.1285202749756679401.stgit@frogsfrogsfrogs>

On 2024-03-17 09:39:33, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Adjust these tests to accomdate the use of xattrs to store fsverity
> metadata.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Is it against one of pptrs branches? doesn't seem to apply on
for-next

> ---
>  tests/xfs/021     |    3 +++
>  tests/xfs/122.out |    1 +
>  2 files changed, 4 insertions(+)
> 
> 
> diff --git a/tests/xfs/021 b/tests/xfs/021
> index ef307fc064..dcecf41958 100755
> --- a/tests/xfs/021
> +++ b/tests/xfs/021
> @@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
>  	perl -ne '
>  /\.secure/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  	print unless /^\d+:\[.*/;'
>  
>  echo "*** dump attributes (2)"
> @@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
>  	| perl -ne '
>  s/,secure//;
>  s/,parent//;
> +s/,verity//;
>  s/info.hdr/info/;
>  /hdr.info.crc/ && next;
>  /hdr.info.bno/ && next;
> @@ -135,6 +137,7 @@ s/info.hdr/info/;
>  /hdr.info.lsn/ && next;
>  /hdr.info.owner/ && next;
>  /\.parent/ && next;
> +/\.verity/ && next;
>  s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
>  s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
>  s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 3a99ce77bb..ff886b4eec 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -141,6 +141,7 @@ sizeof(struct xfs_scrub_vec) = 16
>  sizeof(struct xfs_scrub_vec_head) = 32
>  sizeof(struct xfs_swap_extent) = 64
>  sizeof(struct xfs_unmount_log_format) = 8
> +sizeof(struct xfs_verity_merkle_key) = 8
>  sizeof(struct xfs_xmd_log_format) = 16
>  sizeof(struct xfs_xmi_log_format) = 80
>  sizeof(union xfs_rtword_raw) = 4
> 

-- 
- Andrey


