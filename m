Return-Path: <linux-fsdevel+bounces-44928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45CA6E6E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB733A4909
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1231F0E31;
	Mon, 24 Mar 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="R5ZQXgFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749B1EFFBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856707; cv=none; b=YztDdzMUwOLjmZB+kySiRiDE3Pu+enF3jF+i2QVaLRXg/b8Cnq1fvDK6U7jrzg3w628DDJxJ2zjuTDmbPjaC276tJiRkcnY+WtRkM7oj2MHDYE046h5NhGFVpfZE5Witu09EY67z1KVhsBTSHqDx1XmzC7gBR5WJDmKxiw6J2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856707; c=relaxed/simple;
	bh=sINURG8TPjWTJ6BG4UIC+MEa4u8qbkJLpUIbNvmW9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoxGtKqiJSic9QGj+HEbUNh5Pfp6VFq75wioNugM2SLr3tFF7iBDqBW1IC82uoF7dYAfqk8HVDeylJG+bI+j4AI2fl4oIFSXNikx7+ThJZwodYk85Rxx5zU5h5gf0CqW2PE0IW/Pwuw68xKaN2TJNLBrdZwyIcHkfNe3LnlFHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=R5ZQXgFH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227cf12df27so20597915ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742856706; x=1743461506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNZIAuzYTTeAort3nrknmAePklLNuzFFtDGjptmIzOM=;
        b=R5ZQXgFH/IDyjy3UBj0w19mK5ZDC+DjlVjMwDSIHJyS6F4GLejnOuNfJ1SZn0Iwe5T
         GaAOHiiP2uu/0y7hhQOqecYdko/krtPlGRXY/xCuhiZ1JYdgLq7GH40kJtJql6Tqt1Lx
         96wdRclw007Mg07QOD4qOZk0jmp59eIa6DpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856706; x=1743461506;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNZIAuzYTTeAort3nrknmAePklLNuzFFtDGjptmIzOM=;
        b=HW1qhG+7+OR1bvpKyek6t3x3zgkEuo8muncSiYqFMubujqOIwftNTMp9a3jAoIzTbu
         J+fgnR1ELq+R4sV+37KAmovArZvYLrMbDqltmuysM0v+dtrCho116NbXOPDMCoddlKvL
         j0B5ydAsiOt2JZO2um/UQghxWejLBQoqXPqANJqVNQtpRd1NH6Ak3LYKzfwMc7Ib7G/T
         OsyCeTRu5ks85jmQdH4yT9dEmvKSfVBI0ZIGF8tnf1bXPUHZwlMQRXaUTsIKj06gFgVg
         Mp7LvIwpH+2e+KFoJd7Ps2Ye6acKQQv8T0NlbWrvVKDUnc/dkD7RQUUHjdpbr6t7dG5W
         MKHQ==
X-Gm-Message-State: AOJu0YwueYMKRcZhSyccLaooX+RAQITq67+X36/WsBlOa2HlZ4qG+ubf
	Z+LuANs+fX/trHnEuD0jimO5Fqy4dXcuoYeXrr2cy5gwo/r+yRgxCGXdh5+At7A=
X-Gm-Gg: ASbGncv1RQOOF8saHRLBct2bblhe4WKrz9laxOhCBJaTgAdWTobeG8O74DcWSpp4eat
	qFxPBaJ68Z64vPd9OdUsk4mW0h3DcTn3+CLEM6l0kVhTNSkqP33WOhdpht+L8Xuft6AZzGdl9o1
	obgbkIYlBA5IltIV/mypex2j9cozIxD2V0bg6yXDQVp+j7jowiJUGM4FkKtt3g9RVVPW/9QU2Kl
	AGRUjY+QeT2D5Z7MdpZGWiczj3yzusU+hAykmXX8GWFug+anuKUTlcMMTQyAopRoBV6AcZJQ+WY
	AS0FAgpPlUvh2Xz/UcHxmZ9kMP9ptqtdebhXtlcjwTvmT13SEEG9QdJ3AtwU8BvWp9aFj+cc+Ab
	LOxkL5oYQiYUOxGZk
X-Google-Smtp-Source: AGHT+IGqXWgEabyAByCjIRB2NF7rK0U6Sarr7ZTc0iSTwNsAGyxmm1uJ7rzIH0GnCtZReoLi/YLCHg==
X-Received: by 2002:a17:903:41d2:b0:223:607c:1d99 with SMTP id d9443c01a7336-227805b73d3mr264042385ad.0.1742856705650;
        Mon, 24 Mar 2025 15:51:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4597csm77237325ad.75.2025.03.24.15.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:51:45 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:51:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
Message-ID: <Z-Hh_rUT1LgBbzZ8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
	hch@infradead.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
	open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>

On Mon, Mar 24, 2025 at 04:14:06PM -0600, Jens Axboe wrote:
> On 3/22/25 2:35 PM, Joe Damato wrote:
> > Greetings:
> > 
> > While reading through the splice and socket code I noticed that some
> > splice helpers (like sock_splice_read and sock_splice_eof) live in
> > net/socket.c, but splice_to_socket does not.
> > 
> > I am not sure if there is a reason for this, but it seems like moving
> > this code provides some advantages:
> >   - Eliminates the #ifdef CONFIG_NET from fs/splice.c
> >   - Keeps the socket related splice helpers together in net/socket.c
> >     where it seems (IMHO) more logical for them to live
> 
> Not sure I think this is a good idea. Always nice to get rid of some
> ifdefs, but the code really should be where it's mostly related to, and
> the socket splice helpers have very little to do with the networking
> code, it's mostly just pure splice code.

OK, if you prefer not to merge this I totally understand.

I am not aware of the history behind it all and I can definitely see
the argument for leaving it as is because the code might be more
"splice-related" than networking.

In which case: sorry for the noise.

