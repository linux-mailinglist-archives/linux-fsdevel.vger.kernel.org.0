Return-Path: <linux-fsdevel+bounces-78901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGEHCwaSpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:35:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ED41D9DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61843303AD9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577EE383C6B;
	Mon,  2 Mar 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UnWkuTJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7C2E9EB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458231; cv=pass; b=E/0krbKGNdpck3dAzy7Twu465YTf4Teo5BmbkvBSKLSiwZK2Fr1Bee/RgHIRyQ17fFoBj4kt8KY0ezsk+nlY1e80e282uhRnzLD9tBv73DZdCwd9VNjA+YWQehEyit2MtkGIVCsuyLrv6Ym9ul6oAlKMbugvVOxNcSl/LV6mXUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458231; c=relaxed/simple;
	bh=0JcPUrObuZN4VWhMv6nLmBZ9VNb1wpq9tjHe1Sa//qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2PAqtILKJRfzkhggmH8pcDlEAZdPBGfYxfd/BPFlWmwr+L8PhyZV/vd5k3jlSMhqVPZscJ22a+rPyzWvwzEtNxTvy0E9UGxJViEB1nocTVD0R5x3jP68Tc7jlJV2ONBxGiRo81z4ZZ3d6tbuVAwCGVlUEWh+y0UIYO73ef3JkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UnWkuTJd; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506362ac5f7so41178731cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 05:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772458230; cv=none;
        d=google.com; s=arc-20240605;
        b=TVGP4AAqj0D6cjurDwDWgV4ZemG7xBbruJwCzNmUEnI/Rsp6tmfgGNDazNUUtI2KT8
         Hz3eIR0kf7i3FCV44qAryCRHVpZXCmcGfyFK6uHycTMYpF+ji0/uf8nZXvpRk3JyZhyP
         d6WdVUemFSxfd0FZqRyzkU1q/hQeJs1ZNPJLjp/Z13+V5jWCUrdMzljRXrblV1bmUx65
         VnTDA85W90EcxtUCPPwCjbNhPywUH46nWpeO6FgNOwdkr7Zf9ZHCS43avIDVNe15msjy
         raD1V0uPzQUdlnc5lclhrxmICf6AEip+Q/l6XKj7AaDpm2ZNtXg5FIPjcDLt7h8c/MF0
         06lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0JcPUrObuZN4VWhMv6nLmBZ9VNb1wpq9tjHe1Sa//qA=;
        fh=cyCqTrMvW5BVbxIUO/mDs8JgoyZaHSoDa8giBxMCIU4=;
        b=X/ZenGblBGN3j2UmXLceoosz+0AJrVEjvBZNCGhfFZdLHvcCZsg+NBfbOid1b4yn71
         XxE3CpzqsuL9sXxsTkCIUjkKDDwLtVcBj0JT2A3EiNBkN+frsLMqk6H83O7Nn2DlMPa0
         e49UTaVSg6vA02pc+wxCX4XMULw7R8WsrcedUZWHK7ZKUifPoPlYTrvji64Sn9gpNbPe
         KIY7abA9/LXaSg8yFO/WnlFkESy83vgWnZHkvlP3dn/Q6hT2g29FqtsZhyEn9cXPFpYB
         QL2RHCgPN8H6DAnHZNd9UJpMhNcbxAPHi6dPziWJzglFZnBMwv5J9QNVwlOyP6EhyBgJ
         ZhyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772458230; x=1773063030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0JcPUrObuZN4VWhMv6nLmBZ9VNb1wpq9tjHe1Sa//qA=;
        b=UnWkuTJdToMA4lYmJC6U8e1nmMcFVTZ0IquXawAS0N1+lMyRlFd50pwdBBlm+zvmLk
         aBBdH1x4Dldsp7kbZowIlDPP6DCEbsvC4k12pZbHHXYdRGlkHvN4fZAoJ42Bmcw/dxBT
         c+Ess+d8cw+slix+RikO61yMC6VY2R8zJr4CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458230; x=1773063030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JcPUrObuZN4VWhMv6nLmBZ9VNb1wpq9tjHe1Sa//qA=;
        b=jdXq4J47QHlXCaT6lO2nIodeR4dDu4rYDLRNqeAVElF7+60x9qdoFqIXLb9qLNdvbw
         41aL7m13LtGsYoql7GeKgheIspwF4+7PzgNq80k5fly4+g2pkVvywRDJuaOvgJX85XU0
         45Lh4eGOO90uJwwmKTzmg+zykH70Sj4WiTNKSqZBNn/eaBi2suUqcBvsQwRqoTlDC+Uw
         4Lr530zuGJkYRAHMFEi7VTDkgZ8E19yw3vIFJi+/xLiOTKlsC+EeRGbPhQJxEZBgmq8Q
         SmzDkb7UFcJITBe7UDsi2gTMlignBYGoCkKpZDFp26V18eCIiXXBsa4+aqHqhPxtLNbL
         BB7A==
X-Forwarded-Encrypted: i=1; AJvYcCUj268rRqz1p5FwuZj9wMlo0+Qy0W7qdzX11yIgstALfNRPIXMXW5CGaYqEa/5fTugXEK02lCbhyHlg1FDt@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvhV1+yccTRqBrgqEd0wN6R87elPjShl6OKTcSkxYPJPvJMWC
	rzrw79aYjYJGArlCFM9v2IIT4x3/5FT9LadUdCzECE6IR802IqfKPFByc//Jb9q0rHxlxzuy2nS
	ALQGXx+kbFpwnEgJyF3xbkvBo0GjIepthvztiupISjL8Zr6IzeO6e
X-Gm-Gg: ATEYQzySPZ6HzNE2PIWEN+/nxrEeWCb2ZZ8nkngVPxGtEC/hqZvCowHLgs/697YRLk2
	NPtpMuydY6fXLRgK9djDens62rJv7nauSxtU1C4/3771F3YE2FomLthyigYL2VRQS84lcsX1nyN
	oP9pgZ1YlswlLQvYd29A1MiCEAEGLNIDFpga761EeJLmRsh3ofI935QACYviOTMJeFBlGONNRHa
	BUnwyVIGLQPsp3MLrDQmb1K9o3rdfoR/WlwaJR4t5mAsQ64ZjvIna/6MDQhpt4ZHl5e16poq/bG
	rFh6vqddFw==
X-Received: by 2002:a05:622a:30e:b0:4ff:b231:eea8 with SMTP id
 d75a77b69052e-507527146b8mr150688621cf.14.1772458229634; Mon, 02 Mar 2026
 05:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
 <aaVcSK1x7qTr1dlc@fedora.fritz.box> <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>
 <aaWNGdV6XoZZXvJW@fedora.fritz.box>
In-Reply-To: <aaWNGdV6XoZZXvJW@fedora.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 14:30:18 +0100
X-Gm-Features: AaiRm505YcujvLHY17DjaAVHwPGceKyW0ixd2rrHUIPqhPpDkWTKUdYcbxKGQ4Y
Message-ID: <CAJfpeguPvEN++1P=dv-h0WRSf-VEVFqHRniH6DZo9ffN-U3B8g@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78901-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,birthelmer.de:email]
X-Rspamd-Queue-Id: 29ED41D9DF1
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 14:19, Horst Birthelmer <horst@birthelmer.de> wrote:

> OK, if I have to send flags, that are only present if the fuse request
> is inside a compound then I would suggest that we preface the fuse request
> with a small compound header, where we store that information.
>
> I would not want to change the fuse request, especially not define the same
> flags for every type of fuse requests.
>
> Would that be acceptable?

Yes, a separate header is the cleanest approach,

Thanks,
Miklos

