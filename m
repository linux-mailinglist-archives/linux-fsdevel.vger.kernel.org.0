Return-Path: <linux-fsdevel+bounces-37067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209019ED06E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA98028CE81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76B1D61BB;
	Wed, 11 Dec 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKrcEMgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7B24634E;
	Wed, 11 Dec 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932319; cv=none; b=pnooF1JQu54Nkd+G8adB0co5TLVURqks+8/2liI7w6V8LyOfaO/dfUusRrLoxLzGba7V9sQsXglR916A6yURza2GLgZov/V1yVXBeXwhf1Ca+6tnW6opcFtCq6uAIWtbjVL0TptwntTHQjny/Z/Sj0rrVM9N5BF4qvLAAlDDmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932319; c=relaxed/simple;
	bh=1D7DaKEJszb/HmNtwBuLYd72kq1f8/fMy8u62C4XfBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYq6fFQqccPy98ypvbfTFnizDYLzYRuEWPSGAxzc7aC1CcJkOIFUOveygaHC7r+ByIYPtgyAjXV6r8Ezbh+laUvPaiitukcZ+/jT5zleZhGx9YWvGKAYuQFhnzyxet4GsVOu2XjtN6lg4aMkgi3Wi4T53nDmXbhn8U3XpQk1O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKrcEMgo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38634c35129so3358070f8f.3;
        Wed, 11 Dec 2024 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932316; x=1734537116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D7DaKEJszb/HmNtwBuLYd72kq1f8/fMy8u62C4XfBU=;
        b=SKrcEMgoZqOU2bvkKV9oyurHyqSbi/7rNE6gvl//NVhPD2/8mYTIDbaGYKIxaGq2Jr
         j/w1/tnrmI67n7E+ul4FVM9DJXac1HMUl1hGumJAx9JO7ohjeY4fiPVMFuEBxCjK454I
         9r8tDX85C4+cClKg3z2Etu39xCEWVtz+FtBgjFSwpa6OvogbFqPBlkoYcI9wAyWkrFd1
         ro7HCEvsxaWoH8GRt5Ac8TKVCFHSuPYrhPfilzLoATYqCJLT7AIV4KXzIJd6wWNdPL0j
         WzndXMMq1U3V20kF0EEUm9YasCKLpGjZ4JaAuxcuziHrnpmWk1TcVNaqh4MBs8anyxZ3
         8AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932316; x=1734537116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D7DaKEJszb/HmNtwBuLYd72kq1f8/fMy8u62C4XfBU=;
        b=B1qZZRPxiMoYjDNEmjnIVVO/R91m+iUssluIlen2K1Ynippx3XEinZRMH1I4cd7JLx
         dS8S4AVPnfyhN/EilVur8uRzdwmhKpD7enQZm3YAVBCLDWIuVdrhENP/hcqhj/hW1BWb
         GIHcGs6oCx/7FOdnhYYE461SW/Xze8i2YJwfQJJr5eNQcp/4FZn5jkwH5E78MSSLSxMq
         Bpa6CdzQKvQIPEtPZg2FfnfuXIpBNs+abUWZTq3JJetqZ1d83Zwf9QkFzL1Q9ybXg/r+
         cEpP3+PYi65kkF/UvTg1FUMvA8Xn4H2Qe/qvM2tZoYb1KcKrLSA8YRjkhbjL6g8xEpAD
         5rxw==
X-Gm-Message-State: AOJu0YxVsfN/zarAIrt3+hF/UskKZJa5DFh/F+JR3HfoxgTllGMRDo9+
	lVzu8HXbHP2bgD9j3cOV6dGMCpb547w+Wt6aOn3IqhDbPsI8HowrYrPRjw==
X-Gm-Gg: ASbGnctK/Nfdn+DDXDVOBIrF0H371FhBH8pHP/MwG9n16yFhdM7nyFt3hEQcRqnCRGi
	JPsuK4Tz/BCgCleI/JG48ga/arSkQ/BXJuW13yPyYETKOnf94FcKUvBF8+hyr3/L7Jr47rkTE9y
	+I10dMqRAgNQoYc5hh3jpfy7mw8i1EBIjg1UhEz5Lz4rUL27AFvFdG7YHS7VBSbtp/J34z5Cf0M
	aq7MkPbgkTFgMe1vYZ09l1TVos/QuyWoPdYlkU6NltIwYYpYM7JlcRYgyqxOp7LAl9PTnt4Boa2
	1NO+HmUiLTOolrGgBXWvkbzAR51m
X-Google-Smtp-Source: AGHT+IEZBg6RIrjJbiHOcXzAQDqpWcXMURWhuYRz7Mv7ruc8ad8/SIGV9TsiTB9/lJOv+TXBGz3lYg==
X-Received: by 2002:a05:6000:1847:b0:385:f5c4:b318 with SMTP id ffacd0b85a97d-3864ce9fb3fmr2723075f8f.31.1733932315389;
        Wed, 11 Dec 2024 07:51:55 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435ff2f46d3sm50882745e9.19.2024.12.11.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:51:54 -0800 (PST)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: linux-fsdevel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Add a prctl to disable ".." traversal in path resolution
Date: Wed, 11 Dec 2024 16:51:53 +0100
Message-ID: <2034358.szW3sdo6f8@archbook>
In-Reply-To: <20241211142929.247692-1-mjg59@srcf.ucam.org>
References: <20241211142929.247692-1-mjg59@srcf.ucam.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 11. Dezember 2024 15:29:29 Mitteleurop=C3=A4ische Normalzeit M=
atthew Garrett wrote:
> Path traversal attacks remain a common security vulnerability
> (https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=3D%22path+traversal%22)
> and many are due to either failing to filter out ".." when validating a
> path or incorrectly collapsing other sequences of "."s into ".." .
> Evidence suggests that improving education isn't fixing the problem.

Hi Matthew,

I get the motivation here, but I think you've just turned "educate about
handling .. properly" into "educate about this specific mitigation".

Linux already offers a multitude of ways in which people who deploy
potentially buggy applications can restrict which files these applications
have access to, from old fashioned UNIX permissions over SELinux and other
LSMs to namespaces. (Some software, like postfix, even thinks chroots are
appropriate for this, but I think modern understanding of security would
disagree with that.)

People who fall victim to path traversal vulnerabilities in actual
deployments will not have deployed any of those mitigations, and therefore
I don't see why they would deploy this one.

As sad as it is to see that supposed enterprise security network appliances
still fall victim to the same mistakes people's CGI perl scripts did in
the 90s, I don't think the ones who would opt into this mechanism are the
ones getting got through path traversal.

> The majority of internet-facing applications are unlikely to require the
> ability to handle ".." in a path after startup, and many are unlikely to
> require it at all.

I would like to see some evidence of that. Do webservers already realname
the path when a client asks for example.com/foo/../css/bar.css? If so,
there's no path traversal vulnerability, if not, then they do require it.

Cheers,
Nicolas Frattaroli



