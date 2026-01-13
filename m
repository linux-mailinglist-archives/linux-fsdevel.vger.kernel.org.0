Return-Path: <linux-fsdevel+bounces-73440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E23D1977E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790A83071542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6A202F9C;
	Tue, 13 Jan 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bnn0Is"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D622F16E
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314360; cv=none; b=tcARn5jPsxNSMKWDrjSA8iii4+lg7Be616HH+gX92IN21/nWyxgQVGvjz3QKWG6IhUb/l/b579pUij4upxI8w7AOGPM2Wt73O+G6gi8Ni2ddmuqwQUfE7ohiwWhdK7BI9HPsiryvj1yONXkfkntGEHB/Qi20R1fuqblseK5pPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314360; c=relaxed/simple;
	bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8k7CqbcGrqXmmluIEujBOSmhUgBJ45Y4H/8wAno0AlCWE0z8FrPJ+I5oZICi8FEMU4apiidnBXDCgcLiC8Yx2t/YezXy91Ynccff4Dml0rROT6y7pFO30B7EjvpsejlvxliMhu6v5Gt4QmI6vZAsCFKWpdmPOT1ZsRXiwCf4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bnn0Is; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so3531685fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768314358; x=1768919158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=Z5bnn0Ispxo4KKrrdNp9mDthhQM94tO+LPuOh2EqfwLkZuDmY7hOgXPq16kiXLF4W+
         q7Vv7S9WZ0CTgeTHO7u/MKXkBYrysY/tSlHi5uzJy11Ta/iK5w7m1YGthMQPpPIYEcnJ
         axvtYmBCkROQ8G+cdZ0uqS3R/zvppAkEFfNQExyiaIpq0+JRzoj0opStewx0o8C8X0M8
         6tCZSSMxO/wuRZxHuwTi56JSbapBaSq2Yz0wpFn5lEbWUR5+teu/aspl6R6YtpFjG30f
         o5gICuO9XpNkz1NWoGyib96CH8FBcC2TW3fbp8f+gHRRy7ZlaRBpU9ttJ/nd+ZQ6giMh
         q6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314358; x=1768919158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=KlkrSSJ2MLg0QkcicAKIA1lWW1FlHLO1yfoj2x87tswJdQTRqK1502jRbwFF1efQW1
         U4UyvHeBCBsaJQUTomF/kHSB9uUhyRBHpTKtLjJVwSTdcPME2/LIQq0fRGOW6BVPyKcH
         xD68A6/WnOF5qWZnzt1HAxB8YNkYS4pFkkCVEHEfwb0ivndiEN7+bBgNk0EMLtv2nQPQ
         sbNst+csrEo8nnmsvOrZN33mr7IBI6QDQtvknuXnEjraPikCQnr/G0Cb3j61KILHf3fl
         GHdODvq8xDuEZg4o5zf3aglN3wwlsyd2oZprx1A4kE2+u4abp4QfHyT7+FT3dnKJF+sk
         cYWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQQzRpPR1nsoDfe8gU3LGSq23t7jM4/vNUEg3oXdZN63TOUWeVJPIyRlnvgoob5KTFZJcBm9lCvddPiQn@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAV3v8+PDjSeMP+IHHRBNOqeqYJztsvJnWJqi3MJ2epVpA2VN
	yoESd4nQjPwDS9WH0ptYPUh0pvibraScb8pqIJItTkFLcCgf4Wcl0kjYm9MnIrVJViG8LfjTlRG
	LWcnb53dLc2bhbANgfGA9MekiQXv/uc4=
X-Gm-Gg: AY/fxX7WZlLWgYynTt0z/C6f4tjv/4ZcdFyVBUGsDOh+LPnbk4kensO4d/kdoQ3MZ6I
	GzJ73T1b8w41WCxqVaKPXtzZePocw9w2Z9RIDRjzZUymOyr4xFO7ZDMkERXXpWB4FOl+XH6xqxW
	YcaRUqS/R0KdagrnCa21XbUJaoGkdTSC3dk7BiUbN7xif/m1xa7nqHkG/7/GSLDX6jbed8RYx9o
	RmLy0CA3OPr36SrSHV7iyRB9ROx6v6qPDfX4elAQvKSPfbjCr+14dNcLEQKe0glaA50IkO4Jcet
	zUDF7Zswak0wKoN5uHGFeWxMWuJxx/exURqtQ3v+WsRWeLeeXo1uwdTQLkw=
X-Google-Smtp-Source: AGHT+IGXEVyxh1r5DpDmVWhueY0N+0Jp3e8jPwWMKfuSFBTgriyw1P/K6APHWhYtB6ZeNT6dhK47KGYvJrt1woGnjOU=
X-Received: by 2002:a05:6870:32d5:b0:3fa:966:a847 with SMTP id
 586e51a60fabf-3ffc0bf65acmr10505770fac.47.1768314357848; Tue, 13 Jan 2026
 06:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 13 Jan 2026 17:25:46 +0300
X-Gm-Features: AZwV_QgGmVCLvOrE1mbQJXUeZhWwA5eYHysOC7ryKk27-LWtIhw5TW2eG5CG-5k
Message-ID: <CAPqjcqrx=9HOS7+ywoxqsiTQWTtb5G5wE3ydNLzfN4Lq9W-3AA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again, so what do you think? Can the restriction be removed for raw devices?

Maybe we could consult with someone else about my question?

