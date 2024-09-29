Return-Path: <linux-fsdevel+bounces-30313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE7989498
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 11:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F13C1C21785
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A414AD20;
	Sun, 29 Sep 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgsuDCWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33D18641;
	Sun, 29 Sep 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602672; cv=none; b=A1l9bJE56LP5+s4cpzc/cynKEBd5AVUv0sA4l9vyT+Erv+tZ+FoE5sYFY9b1jqT2L8hw22sifNTWN+hfYyLI4SMl+3pvkyVhn88sjjIrANyWg5sXrirBfkGT2vGNOjXFKyxvkEFbLc9whJ1nOpCbbX0G9xPFCVFdjfGiK8b3FXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602672; c=relaxed/simple;
	bh=JhnlrgiwaYgmf+C4P4rH3Grzmw0UD30oyedNJem4K74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cItpCZg5EOJ57iJXgpjLs3yjfsNU3IK6P+b/DXWQYXK+KAEcgphVCzvyF0Gbh102ekbQtl4AR4wkdrso/VMIyhLBxDUe9Z+LuT/vpFBiTKqPSg1/iQrYP17KudXkNdA4HPthf569YR1ItqYQ4DH2/m7euVeaIK+Ydyl7p20rRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgsuDCWR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so2634578a12.3;
        Sun, 29 Sep 2024 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727602670; x=1728207470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=MgsuDCWR8KS9gbixT/tLGdkM3TJRDqVlvShmApWlOfS4jUpXn+PB50Y3/+bLj6eZ12
         ek4n3Mb7Eeh73IL3xFlR+bqsvIcz+9jeZqNhZNOpjd+sFt9jWrTMqwxmRmP6gYugmsmz
         vmmQIcfWEXgIF1MIqNJMtAHDbPQWrvmNI5dLEXfNhe0Q8uLoCNVTLjD4X1Q7EE5qtmEO
         T007P/YbEsRt1QQPd/HI5gEIynQGYyMUD2rGj78lFVUoohFUAUdkHs3XAiVb0xey8df+
         lO9pNYmaQx294pMY6c4vgMz4d9tzxCMkp/5t+IE293lL9ExnSbwWHGacUUU2ru1TWrCc
         FQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727602670; x=1728207470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UI3JnvNxoordn6WEYDEb5d80WQsWt5pSs8xiHh3j060=;
        b=tX13EjWJgTdP3jwYazUPJMZczzyEliquuenuNFTXeZOx7ZVdcpqc9MzGmaVTRDSFH/
         m3i1hwG9qt6AmLS+g+IUvZYvsonT5hGBk8Rh0UkzmPc28b0xyQUiUolkr0NxAGyGleXZ
         FdpnuuAvUT66F/pKgjheO/M8982to0wU+dPjSlETlZo4beYM40iSii6q+yAqsZImxFpP
         g9c6ktu+AByTINYQDpE6yJ19C9xmy0MHm6BnE/l7m/+Dj8+Y0lMw6wgxac9Tf8ttrejz
         IeKAlky5p/glxeGWN0hLcgEzMllen6pOd2XT/ytwIkBhoUHcbIjO9HqINvAf/4hjUirV
         JjdA==
X-Forwarded-Encrypted: i=1; AJvYcCU8NYMf0I+qiXcUhfDXnYJ6IlbiJ1P+YeTEKg6OiPh3WX+5rKb2JNDVcjgxZk2jamrI7iv5Vix1CixfIu2qVA==@vger.kernel.org, AJvYcCUhh6Jl2n4s0pSEn0qI/tunOhdffgMf+8L0/auhvevJ03bBX7MrUnY7i86/9mluRx47NNSIjJKa@vger.kernel.org, AJvYcCUo6qRcaCU2NUUenC6riT57fZuWi7OMt8v3sBFwuhwR1hCm5wRHFPp27I2h+OiLTDuuEABToyYbas+StA3G@vger.kernel.org, AJvYcCVRK9RKPYvWIhMuhvfOMLZMIElioCvWjVTSnCq+6FppQgbXkZowEJB2YpoVbAUOJM1CwOzWdysGQtz2@vger.kernel.org, AJvYcCVhUr4tL85Efse0OOckcguoa/Iq6b45PQ6mCthJXQseGuqY1gnhREcYwwLIxACXByBA2gdisXozA0F6TA==@vger.kernel.org, AJvYcCWdedSoRDcrjNPlq+YvVwqBuwoq0HddTec/00Elyjb3C7/tvAgXFUore5dg4AGVMEg0s4nQ1SJ8eR+t@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEkW7ejp3yU19eteePTK+9l+mYTSdY1uRCsRTehmozZR6EP3k
	kfLV5W7dErl40USelOVZk6nRVG/+a1fwi1oSNnjuVy2mg7YUrXNP
X-Google-Smtp-Source: AGHT+IGlIri+CO3nO7SHxYS35QDjVZ1ed/TCsk0eNd1dMV/4gMLjT42I+WIsw+2rLAY8Xe2G636KQA==
X-Received: by 2002:a05:6a20:cf8b:b0:1d2:e81c:adc0 with SMTP id adf61e73a8af0-1d4fa7b53bemr13375412637.46.1727602670436;
        Sun, 29 Sep 2024 02:37:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bebedsm4292766b3a.85.2024.09.29.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 02:37:49 -0700 (PDT)
Message-ID: <c688c115af578e6b6ae18d0eabe4aded9db2aad9.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Manu Bretelle
 <chantr4@gmail.com>,  asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Sun, 29 Sep 2024 02:37:44 -0700
In-Reply-To: <2808175.1727601153@warthog.procyon.org.uk>
References: <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2808175.1727601153@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 10:12 +0100, David Howells wrote:
> Can you try the attached?  I've also put it on my branch here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

Used your branch:
fc22830c5a07 ("9p: Don't revert the I/O iterator after reading")

dmesg is here:
https://gist.github.com/eddyz87/4cd50c2cf01323641999dc386e2d41eb

Still see null-ptr-deref.

[...]


