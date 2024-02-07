Return-Path: <linux-fsdevel+bounces-10660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218BF84D226
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5457E1C20E49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CC85C6D;
	Wed,  7 Feb 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UxaFWWXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2318562D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333372; cv=none; b=L/9nEcCBc/WHaAUzyIL3R1wgWbro/+Jpi7sk4XKXnWUEiLVcmiaKvUtkxzhhbk2vH5bPFVnIkay2ELUBqzFuvBzKmIQxFFVCjVJaWqu6TPBBPKEYsFh0oohOWrAtbTsXV7qhwR+ho3rDIpY/ef78qZB5o+AeK3xmIPREwACuaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333372; c=relaxed/simple;
	bh=ne+aULSUpaPEi4743IN+wg1mH2cuE/ImHAUIXCyQB6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPZ0/RMFdzgq9bUOwRoSBB4XpthUSh7vGT2tP/mOJCcBzvfAR4Xcq/41vxR1BF5S7BQoPdJhTKARrHVpCztEtIGm9S0f7RmUGZpxB+cVpRa7LQOSHHBEAVETY2axP0utcUXG5K3h/SkG7n/56ZD5/lKJa2Re6ty3YZqslUGu6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UxaFWWXY; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bfedaaeeacso488260b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707333367; x=1707938167; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm8na7VDZ32O2vJx51WDZHRCRu6AvXjFSjD2uvcbmz8=;
        b=UxaFWWXYibJqcRYARqOuCXyRSNfljUIgycHeolNfB01dxd4Dv24IgzZ8BBH9l2xF22
         UWNUXzMtNi31FqOBOlArbRTk3HoITeC1ohLFBPLgUUddwunOYpUHHxy3PVr99R3aNT5O
         GB/J0P+y/rY23QhmDH1l162q+eAzlvSdjmiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333367; x=1707938167;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm8na7VDZ32O2vJx51WDZHRCRu6AvXjFSjD2uvcbmz8=;
        b=G2jyC+lhPwogexgVEMPsNfYS0ziZnIYbzRh1CcwfQWgTYDjjj4ZysticBNo8pS/KZN
         eT2CDrryOYw6qMyZHgPhWZxPdLJrRZrtEnRax/B3MPXOUSczYlzVMbnmhUFapsrMk8a0
         vqo2HWMme6sa3t33h473EGFLCT7M8jmIaN8JTER9bmBKbuQ8cYTialIkndNb8keJKutL
         yFUd+tzDpUq3F9VJp9gUOy2Uvwz0bjKnEtKk8BpX/NhW1VuP6rCm48g2vMgvH/0JGPFp
         cfzFPPvRP1l9reXvVWJkJnzfcm1E+qRnhypmWn251wsDGS3OPx4BoBdsGW0bewoKW3zb
         1qxw==
X-Gm-Message-State: AOJu0YwRDpeb5g8VBaWo77xMeDojC+shshX3e+74Oa/bASyPblx6Se19
	67mw1N33S2VOz7Ef/eHJ/W2S4yy7i3KpjpGzR8mBKMTS9wCo7qN2CqHhdFfh94o=
X-Google-Smtp-Source: AGHT+IEpdhrPd4EP4V5LmrtuWQvsldZmM0L6GGd8Xxw1V8t7XXLe4+6ucXdG+OY3lX/V7ukb/tUVOA==
X-Received: by 2002:a05:6359:1010:b0:178:9b37:79f0 with SMTP id ib16-20020a056359101000b001789b3779f0mr3806311rwb.32.1707333367454;
        Wed, 07 Feb 2024 11:16:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6KBZY+Rr7BE/6ADjZAkApu/xJQ5/nhz85kwrS26hIlM6jUnEf+5iQmNHQE9Lyjzj4LDpocM+V729LF3BSXS076ZvwLfpXj87M91D1fA/J8zb8UEcXgHrtdkTFDRfrKwhr/utbGVVYTFm9zgX7ptEC8q0fWPfvAlpLRrEU5ypY43MGSebLdUbxu1GSc94smNhwJHVN+V3ZN/hGVr1+8z5Ud9lpjajhV7xfZqbRTJjjptMG8Iabq4fora7t0UsP7z6TaO0ArjoH+eZtIfFoJMc3Rd1OmKu9qEAPzDbb4rtEU6SASddc0wR9Z+qO6ik17h9b+UF7WKZYl1nFmI9rUB13QENxajXPp6I2ZsZQck2XFnU+7+7yR0yCUcixh26AR+O/NQYfvrsfneRy+Pn4Gl0DAn2Rgw1AQLOzFrALAQMi2U8rlv0hRLMM+90PxytYCsKX9488hsaXPve72+cet3hS8+5dIVvwXYHSwibYc/yyGq8jMIpf/YooBY0gziUk+sy4Ya1bwRv0X9muMz+rzT+lfs+qa7AkmauFlBCODhE3Avngb1oNtQbFpyM5ShBYhfGl8WgCN7TnomYKk0NunQlu+wLVu1IZHUdviUB21R0TyVzl5tkj/7XQv5FJQVvmBAv4iFKWltjzjJ9dWSHP1icqA7OfuR9jC+iZNs/ySOICnhlQ9wenwaSoDFcYansTuQamIBqBulBggIenIwDPy9iXyV0Fn2h2OxaAqAQmt5HGoz88ddECBQIiqIIWGwGneVW4hy31dMkg8rCYa8J2E+wkkS3AhbNv9wg4JWenL5Y2x35W3THgEBXbYV6FyiAg6LbfTH2zWwheBq0XMzs3C1a8IMSmCY4ZgXg/4Rf53QC1JwF0VMFioMCYzSus0KRwQY/bdPJ7Lr28j4+b1OnYyEkNKufOb76kwWQS+b1pPKU8F5PR62++syTf+5Iag/KYWLyBQC
 9rEjkKq0fGBm446COafVJyVns/KhE=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 126-20020a630084000000b005d8e30897e4sm1955912pga.69.2024.02.07.11.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:16:07 -0800 (PST)
Date: Wed, 7 Feb 2024 11:16:03 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	weiwan@google.com, David.Laight@ACULAB.COM, arnd@arndb.de,
	sdf@google.com, amritha.nambiar@intel.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240207191603.GB1313@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-5-jdamato@fastly.com>
 <ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
 <20240207185014.GA1221@fastly.com>
 <20240207110726.68c07188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110726.68c07188@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 11:07:26AM -0800, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 10:50:15 -0800 Joe Damato wrote:
> > > This !! is unnecessary. Nonzero values shall be "converted" to true.
> > > 
> > > But FWIW, the above is nothing which should be blocking, so:
> > "> 
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>  
> > 
> > netdev maintainers: Jiri marked this with Reviewed-by, but was this review
> > what caused "Changes Requested" to be the status set for this patch set in
> > patchwork?
> > 
> > If needed, I'll send a v7 with the changes Jiri suggested and add the
> > "Reviewed-by" since the changes are cosmetic, but I wanted to make sure
> > this was the reason.
> 
> Yes, I think that's it.

OK, thanks for letting me know. I wasn't sure if it was because of the
netdev/source_inline which marked 1/4 as "fail" because of the inlines
added.

Does that need to be changed, as well?

