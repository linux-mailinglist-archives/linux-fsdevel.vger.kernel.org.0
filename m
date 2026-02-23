Return-Path: <linux-fsdevel+bounces-77990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJh6MX6anGmKJgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:20:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F917B707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF33D3047951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0A33BBAA;
	Mon, 23 Feb 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZ4YcwBb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0X83UgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37DA33B967
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870340; cv=none; b=INWvbtp5+jdu73ih2WHFfuISvpoT8s+jQnwg7qlCS+RED3ll/Tb4W68fNPNTpzG9IQd6LdzJdub5olIrHMyzbWG8JwkLR6g+K/+rBowa0/xtXlI9ORH72hthDC3OsosIsUEsNzYoBTj2oTwXyVBuo4f1uKzGnAd6dXgGDYNMgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870340; c=relaxed/simple;
	bh=GpcFfjFqktZkq1PJJFTb0XK2gYmrC40W4g+B7g8ZrDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPI/rKCZcdNNHKzA0S+lrqrEb+duKS/BmwF1iLMJUEL3KAsCcWsiMfe0fsQfrmuiD3bNsTCXCllH7f/fnfAzdA0OdWhY3XMLeVcz+DzYq0xlgZtwNKTJtdZ4dECxupmDu/9x89MhtryXqUnOyWR2xUSlQGu5TGrZD9YiyhK6qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZ4YcwBb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0X83UgK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771870339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67lPNWHfQZaorsIQ9wDyrI/yXPhj5APVQRxZORYETQg=;
	b=GZ4YcwBbzdepbQ8hmmFDiL4+Adr9q89TB4wQsRkyjFLlSgnrtETKofUcw5ed/jWZv5Vtsy
	eDzvoiy3AYuaQpmKAxMLKzz1RxFgV2k9RfJpERHFg8ZQGpD/rx7T1Euv+xp/5nt/tv68qX
	bD6q/dNgA+GAGTMbFF6qgQZ9oAl/toY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-KWNTNF9zPz62Fb6QqWDGvg-1; Mon, 23 Feb 2026 13:12:17 -0500
X-MC-Unique: KWNTNF9zPz62Fb6QqWDGvg-1
X-Mimecast-MFC-AGG-ID: KWNTNF9zPz62Fb6QqWDGvg_1771870336
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836c819456so39157215e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 10:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771870336; x=1772475136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67lPNWHfQZaorsIQ9wDyrI/yXPhj5APVQRxZORYETQg=;
        b=g0X83UgKJyPy/wdsB894s8EoXzQNWxf5nhlhLIIekjBzegklMcLD6ZGrPp4PT9UWGk
         uFgEE/xR/MJf4iK4iMJd6LRdoSSIzF88WpsVk1dk1Uo1BHVWTvQdCqJNGQOJ/snQS3We
         gdz1emkyjL5PlSoFJr5I1Aj0lNtDPJVJJnYl1RSxidNDqX4HFteajPUov5PaEguQld8B
         MuqFKhgjodA3EJDKsMoXu8f4BkolNGeT9U9VHZyD03IkTJ7V9rc2n3y8Pplf3LIGsiaG
         Ct/BaFC9VdlH0lad8Jnr0A5X0tIhvrvPGDHY6wK6bxitAG45NzjWZ2wx/o7RiDn0CF5Y
         f8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870336; x=1772475136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67lPNWHfQZaorsIQ9wDyrI/yXPhj5APVQRxZORYETQg=;
        b=sqGeLjh/xd0x09D2xgVhS3RIkCDuD/AjBzINWJjg0WG2rqYh7rz5R96YohHpHj/ZqB
         M8OQ6Eqf1ZnOLlemPtc2o0f0XGSJGaAhzeEmVrHEmr/ldQgve1z1LfIor5BdA/AufxOC
         G3CIBulLPeqYWenaLW/rTtw+IsP3fG56qzv3fXeBlWRaiLgSVzqFAILQlQMCYgo8SJdr
         EHXMBDAA+/VEjbF0FvOymZHfhZg2MhjL4lgIl7tZCGtx23+pmK09rND+XjoIN/mmwPQ/
         GjlyxeMYxOZ7srGWjrxw3hfnxqbT8vCZXy0exAhZH3XuV0naOQlm5+xIQjSVYdoSZfgT
         K9aw==
X-Forwarded-Encrypted: i=1; AJvYcCXpCf8CbwuSaL+bGyk5n16bk71Kp9JTsXRULFZC9aykKhdM4H9x1lToQ02su1bDcpsSOXlELwKtyGgaxHXt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+/LrB0jiVqBT1n9Z7nOpE/n1mQZx/3KRiggAlefHQSpqWaJP
	nLmpZjGfkmoh92gJcpuUHVdFUZWHN+x+1nR5KkA6ljz3VxVryOpgwgFd764uJKFGjGqdpygSuut
	CVxGel4p+Udb7EjcpV55pE1jP1lLs2mb9WXCsl/+jtQr272MRcSpZyu+Jv6yqN1k7hQ==
X-Gm-Gg: AZuq6aL7BWvS73JG2Yx7GeOV/ZSPantihb2ADspsZSqAphkXIA/GQXG6BUfDd5o45Hu
	jaDGh66D3E2n9brbm4fFWPYkACKbN3RETgjGV5EJW/rbU7tJ7eNrWJs9oIxOzcRDVvb5E1BzaWL
	cPW6aTX+r60P5/TnCInk+fVFMuLbwoIuHhc0oDZYJTUden/f2luR6a+QXmEMItKVkc5qj0521iB
	LzVHnzCq0lbvPoUTOHWVBT5uBIS0PXm222WEHqwYYADK6NXJ//vuOV+mOU+Ptery/3/npPFkH+l
	0p6XLVlGB7UanztuH9hMSxi1tfSD3ukA83FsyUoKtguH2nOz6V+M1kHc1jGYYUtbveq+ZX7WgvJ
	lCDkLL2V8WgM=
X-Received: by 2002:a05:600d:6445:20b0:483:abeb:7a5c with SMTP id 5b1f17b1804b1-483abeb7b61mr97766885e9.12.1771870335610;
        Mon, 23 Feb 2026 10:12:15 -0800 (PST)
X-Received: by 2002:a05:600d:6445:20b0:483:abeb:7a5c with SMTP id 5b1f17b1804b1-483abeb7b61mr97766435e9.12.1771870335063;
        Mon, 23 Feb 2026 10:12:15 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a430a33esm113087605e9.32.2026.02.23.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:12:14 -0800 (PST)
Date: Mon, 23 Feb 2026 19:12:13 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 34/35] xfs: add fsverity traces
Message-ID: <ttfypsjh7cjab5o6wjvfjd4oj36wruigwqdttt35kdvnfptmex@2owry54j747a>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-35-aalbersh@kernel.org>
 <20260219173610.GM6490@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219173610.GM6490@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77990-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E82F917B707
X-Rspamd-Action: no action

On 2026-02-19 09:36:10, Darrick J. Wong wrote:
> > +TRACE_EVENT(xfs_fsverity_get_descriptor,
> > +	TP_PROTO(struct xfs_inode *ip),
> > +	TP_ARGS(ip),
> > +	TP_STRUCT__entry(
> > +		__field(dev_t, dev)
> > +		__field(xfs_ino_t, ino)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->dev = VFS_I(ip)->i_sb->s_dev;
> > +		__entry->ino = ip->i_ino;
> > +	),
> > +	TP_printk("dev %d:%d ino 0x%llx",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  __entry->ino)
> > +);
> > +
> > +DECLARE_EVENT_CLASS(xfs_fsverity_class,
> > +	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length),
> 
> I wonder if @length ought to be size_t instead of unsigned int?
> Probably doesn't matter at this point, fsverity isn't going to send huge
> multigigabyte IOs.

I will update it

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

-- 
- Andrey


