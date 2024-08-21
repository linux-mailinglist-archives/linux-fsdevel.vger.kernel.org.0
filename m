Return-Path: <linux-fsdevel+bounces-26523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2295A4B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E521F23669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D751B5300;
	Wed, 21 Aug 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PVgL34Ff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E021B3B10;
	Wed, 21 Aug 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264993; cv=none; b=JET4Wlp3C6GOegRGBll5o/ANyuc5Rtc+TWmsEGiowtxp6fHdyU1mrcNRljVYRuQkIMTNGtkWLeSHPRqzKgKuR+VliEHJwyFoTT41edydvRMZ0TlrHhtiWuwQjNuCDtpP8cly3rixLOwYTYRXsKOtYigKMCwJdgF6bxTkCnz77Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264993; c=relaxed/simple;
	bh=ecdNA7tVdcRNTbeb/ybYzboagbdPQxtP26aK+hSgMa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvoxdIxGzLtLEzcz/6Gfs5e+pkiBRMDBd6zpv3yn+7/G6ry/p+EY6+Q0pzquw9vQulbQiOH2z6Sk6R7/JwdN62VjGfJhWGH61O17JxnbCuSZeAlSPLLxT0vOhRQEOCdJS1EkK5kOW9dkmB7s9eTIPj9Jyc2xMfdEnuktCkFGf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PVgL34Ff; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ecdNA7tVdcRNTbeb/ybYzboagbdPQxtP26aK+hSgMa4=; b=PVgL34Ffp0vUFVGdgQQpE1NMyU
	wBlGlxW2pri0m5yilgqxs0EoQFEuCIME9+yeXpqy/+/DmJ0NUQlbv6GfsD3BpEAA2FDXDo2G8D+ET
	1utAOcvOV/h6+1RJ3gokjjUSmPBfpt8Tc7wWZOf4JgB7w1iiYcJW34De6AUnc1i/63G9JXYgIGgDR
	QB/haozPLT8JiEbq4GvPOADD86u8b3yH2IR5IQzE/bwg+BDBBrnlpK+94ZbOtCxdnwAOEKsPhm3Ht
	TuJNX5LGrieUs53dIaJpalJTqVYFBWQzYhvzvL2yeci7UEnzeT2bgRCUe4fgq+CMK/SYpeCHnLidE
	x6hQvxyw==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgq5a-0038pr-Rr; Wed, 21 Aug 2024 20:29:46 +0200
Date: Wed, 21 Aug 2024 15:29:38 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
Message-ID: <ZsYyEvjTZWmEkUQ1@quatroqueijos.cascardo.eti.br>
References: <000000000000dfd6a105f71001d7@google.com>
 <000000000000a17b01061f380ade@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a17b01061f380ade@google.com>

#syz fix: ext4: fix kernel BUG in 'ext4_write_inline_data_end()'

