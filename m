Return-Path: <linux-fsdevel+bounces-9396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E2840A53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BDB1F239AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AE15531C;
	Mon, 29 Jan 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MUe+POmJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723B156972
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542968; cv=none; b=ILTYKAxF072bymuk1HOsjgjsY3VzYK/gbYA8KHkjMohEjrjsTdlFmAjviVil+rTiZ9Pm2Tzc2slXtujLlkVaLlQQE0p0pN8YnwCsZ6WiKZUPAwhdp2sf9E/iASQtOGAhLiXfYG/G40vZGd8VC1YoOnvRYUWk3aaiPP876VBFpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542968; c=relaxed/simple;
	bh=E2pz83SaHUUBSu+k2FmR9GyqPifnumB7xkbI8/ZNP6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IWFaXWHFRBCBbWbDo/0DDxIif28YEQMW3UIxoo+CQicxWTZ04VCWZlZsmOuWb+SSxEESv2foaU03G+qjA73MY9WYAHf8v09z0AObssPPWZpl83SB/7PBBH1OX2Vb+wgZ/VdaOceP1LelX1f0wlgQgsN6gx4KqY4a4/Yn2NR+05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MUe+POmJ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C87413FDA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706542962;
	bh=FmVwiL7ssmvBS/Rk3AP7EZwNHMhnVZ9IcleUiv9ucoo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=MUe+POmJwanreQNkMuyXUEq1Gmq9m0Zpn4dwmRWFZQ5BzDHtJDEdYSbd9rki/VMhn
	 dfeKT+ZUKscxbYDeyC3KelkrTJw1HbA7L9P7QTOlOe6BfmIElvg+wjzi/K0Jk+y0xF
	 y65fe92JueevglKGclECrr2iB95ErVFt+4SCp2UZLlAY8GQysEiPd2itKVm//iUhZr
	 KP7Xg0A+mkx/gS8biAlzu8ZQklRHklnZknAQTOd5MdTbkG/Gkcsst1k+IkrN4SLULj
	 t69SIeJzDyouJzA+9nLCib2mpNC1TJbwZvsDwPTm9iVjqMNyeIwfjs2IswUrau5pcn
	 9cKF1KwKjHLuw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2f1d0c3389so143035666b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706542961; x=1707147761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmVwiL7ssmvBS/Rk3AP7EZwNHMhnVZ9IcleUiv9ucoo=;
        b=ZiS8f+CRc25pkhwGKQTcs+HV+PR6kHsju+m1zHshMyeantNsufipxjKNFPb8HKQ+ll
         Yf4JQRlf7AZ32QPXj4E8YpyRXzBt+WtJgZK7s55ZMIo3ZHZxy3axB7s/qubWL1fDq2LN
         xBQU2JjPPIoJspdQI4lk8yi0+9vjs7Ukirfi8b3mSCiIVSEOoptVRuWgI0loGSPSKvxp
         +E2gYibaxwtu70cnw1D6UyGCPbuUWS2ueIXDwqOT+/CI3ncZRm1QsSZnmQaoIU4d5XQQ
         KUfhmJXaAcI4jPZVDpKDYcuRru0ddXVh3dhyHTvQofG7CXN3xAJ0/m2Ycv9UamFGs1o+
         cnWQ==
X-Gm-Message-State: AOJu0YwY+7Vj08UMZdNISgqFf3yHj2Br23QYo189kVeAigi2yiKpAp+F
	lr0cgG9nsHup5WYLBHSwqM0dPZoVYJdilOww3Kv4tCTSdyb1ZZaywj4wp2iPieEDlQ60JGqqU8b
	9lSN+GXeMfFYBC4e66Hda/GPjHBDFkzXeBoJU53H67OPhu6qg/UfL9IYjyHxXMc+/3uVkb3gKfH
	Ol7udtb36IdcA=
X-Received: by 2002:a17:906:7f90:b0:a2c:3596:b0c1 with SMTP id f16-20020a1709067f9000b00a2c3596b0c1mr4985251ejr.75.1706542961638;
        Mon, 29 Jan 2024 07:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4WvBpWmKQPkCgy9/7v4IVO3JZ0fzYsBag+YDG8GPdLA0TxgRJEg58UOGotA/ZgDC9TpA24w==
X-Received: by 2002:a17:906:7f90:b0:a2c:3596:b0c1 with SMTP id f16-20020a1709067f9000b00a2c3596b0c1mr4985242ejr.75.1706542961322;
        Mon, 29 Jan 2024 07:42:41 -0800 (PST)
Received: from amikhalitsyn ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fj18-20020a1709069c9200b00a3496fa1f7fsm4069969ejc.91.2024.01.29.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:42:40 -0800 (PST)
Date: Mon, 29 Jan 2024 16:42:40 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org,
 linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Bernd
 Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/9] fs/fuse: support idmapped getattr inode op
Message-Id: <20240129164240.9e35bcf01695efcb1f966517@canonical.com>
In-Reply-To: <20240120-heult-applaudieren-d6449392b497@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
	<20240108120824.122178-5-aleksandr.mikhalitsyn@canonical.com>
	<20240120-heult-applaudieren-d6449392b497@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 16:21:08 +0100
Christian Brauner <brauner@kernel.org> wrote:

> >  int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
> >  {
> > -	return fuse_update_get_attr(inode, file, NULL, mask, 0);
> > +	return fuse_update_get_attr(&nop_mnt_idmap, inode, file, NULL, mask, 0);
> >  }
> >  
> >  int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
> > @@ -1506,7 +1510,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
> >  		return -ECHILD;
> >  
> >  	forget_all_cached_acls(inode);
> > -	return fuse_do_getattr(inode, NULL, NULL);
> > +	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
> >  }
> >  
> >  /*
> > @@ -2062,7 +2066,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
> >  			 * ia_mode calculation may have used stale i_mode.
> >  			 * Refresh and recalculate.
> >  			 */
> > -			ret = fuse_do_getattr(inode, NULL, file);
> > +			ret = fuse_do_getattr(&nop_mnt_idmap, inode, NULL, file);
> >  			if (ret)
> >  				return ret;
> 

Hi, Christian!

> These are internal getattr requests that don't originate from a specific mount?

These requests do originate from a specific mount, but we don't need an idmapping in there
because 3rd argument of fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode, struct kstat *stat, struct file *file) is NULL,
which means that this request will not fill an stat structure => we don't need to take an idmapping into account.

> Can you please add a comment about this in the commit message so it's
> clear why it's ok to not pass the idmapping?

Sure, that's my bad that I haven't added this explanation! It's not obvious at all.

Will be fixed in -v2.

Thanks,
Alex


