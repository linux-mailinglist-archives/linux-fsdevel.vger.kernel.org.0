Return-Path: <linux-fsdevel+bounces-77133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OiTDCoIj2ltHQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:16:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73274135A22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A95E3079BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF79B35295F;
	Fri, 13 Feb 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epa5bPLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C543346AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981028; cv=none; b=XF0nxrh3MySunpcSZBeamGoukR3M8D33PjbCxXTrcHb9R52AYeMqvzmtuRl3O+afCTddz9JmqW8k7UFM7HSbktb/pJwX/Wl+K4kRR5gXuL68upLmBneDhBZ6kT/vg8bQHf6kVU/AvzXhv09d+byF7Wh0iLJisVORB0rX7ZPp1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981028; c=relaxed/simple;
	bh=0DDA0V33GHT+gg6ofRckPcj0FyO749qYLHX9HZbHrsI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cFuivbRXv+1hddiUEbH3ht4WPQq5V38mCglp9+gGAdRgkWIc08/7qnlsPsMUZ7ds+LYEmgbSi4t/AVFzIYug72LQi/H5GWjRVRNxmfdLsN7672Xyz6FbRIG8ZYVBE01G3uTUtpQkawKWdnvH2gYdkNA4Y8/F1Xz2p/YQPN9bWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epa5bPLI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354c16d83b2so408834a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770981027; x=1771585827; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w74rlsrGWmZvKYDg3c0K+Nm4AVBNsTz1ccTbV4Qizs8=;
        b=epa5bPLIb/JiMwoSRYJbDXPcnPbDWp7ltg/N3Oq1ZFyouuY4/j2kFoNv+l1CeVSDUW
         DGWqLSFJaxbft3VHm9TmZ0yzgXGt5HRGWamjvuzhLNb5SP5pTdRr4QKprWQ+sIlpMoV6
         WDdcR7wMWiYAHUBKMOxoMRl75o4tGX89N2sTkRr6LZrgIkavdgEGYtY/OnB/TgESYpkT
         A9HzfRlTn7/7aEbB0McOgDbSwaTKbkztwZn7no0uRwJp/b4kfLCiWG6yTWp/wT++k1fl
         lfAeez2cgEeXmjioOyQWQjj2LfQYV2jC/MytCZ4LHHDiuz079K48TuhFk6n8oz5lOQxx
         nnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770981027; x=1771585827;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w74rlsrGWmZvKYDg3c0K+Nm4AVBNsTz1ccTbV4Qizs8=;
        b=FnuwgRuOJpuI003/Fy2OkImzcgdlAm2KGBhI72s/uanXNr3J6m2EsunPd7D2VhQ6Kh
         MNL6Kj6+lntzcmVfLAvzcWuWgC2b/qb3c9UyiFxSA48ow96ji9P8SMYNX6yKlGIZsTW4
         kRsPM8iRyk2jxQziZdaObuLfRJsEkAmxURMHoPzuHObO0mwBwQOId3niDABn6LxpOOtQ
         BwiQQNUF43u9ZFQQMUhuCoHcNAmxTUJPzpyJBF6+2ZtGfhh/0a64nlxb8e/Vy2Up6xvI
         q/FdK1zej151uzOg/XM36/2xS42QlkFJ58es7vaZgRy1LPWJEMbP3/ghEwfseqpefRgB
         aRVQ==
X-Gm-Message-State: AOJu0YxT/Z/mWgOI9AaXvZXy7a4q4dsc0RUBTTlyaQImKfQ5ZqhIlOeq
	7ZbCVVw7kscl7Plfr4HxoZsVl2S3wWGcBT91w39ZsmZfbaydQJnBNsjH
X-Gm-Gg: AZuq6aL8PsUrUDVGHMzCwDAJbM8Wr1DB6TEhybMaKtwgf3sxJ+n2o87kdmR59/kXafC
	ihRirFODcEGYP8tF8IV0wjnmTDR237gADTtvNKLDqVLtuxaoiygXIA5CAYN+ecR5WykXZZr9rpw
	gOmTbAgu1FedEw3WiWvw31uERDNPRPWyJqIIHx7YPyvzlEETz/hOCQim94pFEOdgs8xbStx2K7h
	CiTGZxSFLtFm3i/ttWuCJs7194Db/ojl1tB5ex0gtBHWVvx2bzCfb6YhSv9wBXGvyFEKASDysQY
	epYLuE8Oiqhdx/8NJSr4KcqSlQl8vj04jpnbkr2Tq9EpIj09GeBkjPvR1m3lGnWjqt5q/itHOrZ
	Uvc2OOCySm/pak6elpbT4c6jThNC0dY14vlgDB6mne5dEMsEgH3NHrGK+y3dcrE0RfdaoKQUtGA
	3NKLg5FibBN6v8rRNuMyMBXHowrgcz41jZLhKxO2TPCf6FtFB3T9QTAZCNf6QkG6Wu4IXjTg==
X-Received: by 2002:a17:90b:5810:b0:353:356c:6821 with SMTP id 98e67ed59e1d1-356aaa76375mr1617239a91.8.1770981026696;
        Fri, 13 Feb 2026 03:10:26 -0800 (PST)
Received: from localhost ([2405:201:3017:184:52f5:ed80:f874:1efc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a62c48sm2202195b3a.29.2026.02.13.03.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 03:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 16:40:19 +0530
Message-Id: <DGDSDKZ6Z5JQ.3QVG4MCX1V7UK@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] statmount: Fix the null-ptr-deref in do_statmount()
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Qing Wang" <wangqing7171@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Bhavik Sachdev" <b.sachdev1904@gmail.com>, "Andrei Vagin"
 <avagin@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260213103006.2472569-1-wangqing7171@gmail.com>
In-Reply-To: <20260213103006.2472569-1-wangqing7171@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77133-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bsachdev1904@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 73274135A22
X-Rspamd-Action: no action

On Fri Feb 13, 2026 at 4:00 PM IST, Qing Wang wrote:
> If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
> defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
> of mount by IS_ERR() and return.
>
> Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
> Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@goo=
gle.com/
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  fs/namespace.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a67cbe42746d..90700df65f0d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5678,6 +5678,8 @@ static int do_statmount(struct kstatmount *s, u64 m=
nt_id, u64 mnt_ns_id,
> =20
>  		s->mnt =3D mnt_file->f_path.mnt;
>  		ns =3D real_mount(s->mnt)->mnt_ns;
> +		if (IS_ERR(ns))
> +			return PTR_ERR(ns);
>  		if (!ns)
>  			/*
>  			 * We can't set mount point and mnt_ns_id since we don't have a

Looks good to me.

Reviewed-by: Bhavik Sachdev <b.sachdev1904@gmail.com>

