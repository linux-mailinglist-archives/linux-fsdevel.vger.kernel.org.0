Return-Path: <linux-fsdevel+bounces-72406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6617CF56AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6117130B3738
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293372D7DDB;
	Mon,  5 Jan 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETksLqVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBE22D7B0
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642305; cv=none; b=szwVqV7W3F1HOOm4orlPsDd+wUpxOJCYlBkKxi7XAR3e412WWcFmW1lvOIgybo6psPZMyhHJWu0DjL1h8XO0aVhqEHm2R3qYzz4xP0aGeh8seB6lp+n6INMg6OUQZKxBmd0GO0yfr8+dv4+h4pdns0128c8IU1R1A6yWCGulYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642305; c=relaxed/simple;
	bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqhcxSCW97LqEoEKmcz6rTk37hQEC+uDaxbxSOx+a5Sl4DTD6WW3+Y6lA0qd+DFgOC7AMIDjEAX67QzLHzGtUPw+/DwF3y1XuVojpg/SP0qITq8x1H78nkVCXR9a+WFt6iwXcM34Ftl9RskGcGT5kSdC8etriV8Id7uBUvpH4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETksLqVT; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94121102a54so155535241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642303; x=1768247103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=ETksLqVTa/rWQVeVpFW3EcxtWOf4jSk2PQJFyV92uvF1+i/vZndoJAVxyVzUEJ1bEe
         NBXaL5NLbik7My4h0huqO2W9/20sKW6WzT7q/ypqqM7snAmKUoEDBtMmSvV1e9ntFN/q
         Fu9dq1dvD5xk2bpkTKMTWjfPSdgLTBJDJPS5/K8Dfd654nkUSrOeCsLt3Jm6PFwN3FRi
         x3m1kNoCVpXH6Z1oJt+GuuEaavoxa1gq3ROBhi6NqH35zJOu/6+J7/CLi8UVnRYTNCiB
         uyyKEA/Ldq488hHFUOTKpleAMZv4sCfpRwz/R9uLTCKeqTXRwTbwYjOsy/clsaLVMgmz
         zHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642303; x=1768247103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=DNBv/oFsg2V8O8/S/EqkSal4riJu1OaGy6BTPiEsKoNtBUz1aSMm/HTUZCrip9O8Ip
         RveBemxEYEIm83O0ckkguPNNRjthcbvm/ftHRKKuZRZ2RcCpgbAetwFwBjENG0jDsCCU
         fN34/8Bmy5a/+pMmxrEaNIr2l/Oo5br0R/qjJ2Wqe4i3nQO+v4EMe5wPGcgWs3CtbYg/
         dK8WkgP2hpL81FJYrrwsMsfUWtEysQTb+QFhdP3f2ND4+vXHGx3d0Ud7CxrbZByYNn6O
         fWI30h1J3AgdRFGzH7M/lrHd7kr8KFlTYgnBkcJGwcxhUA/LKWYOU4DBKTR6D1BekxK/
         BH7w==
X-Forwarded-Encrypted: i=1; AJvYcCUFsQTjWuPYIDgbb9hSK1rB2HJ0+daX3FEHqyAq6ofmJa3hy6sBfKKyfw9yLhXw/BLWFeSt0syZtkX4lUaK@vger.kernel.org
X-Gm-Message-State: AOJu0YyTY8EPB6Syef+y7LUzXZ+A/ZkfX4Lly50Fb8WejclgsyEiaubk
	j4c4fG2w/GIAkZamMRDfhESzAejy+Kumfb37z/oxIKfBTntNWlN+8vQbPEKa7bcqPR1kFFWQ7so
	wyD09AmuDIlT3z0HyqyYKDx2s4pYKz11Z+QXdmxU=
X-Gm-Gg: AY/fxX5ImMeJR+nT8A9p2ZDiW/V07B/hRylp1lCWj5eMmMmMxbVWyEoXx+hNsjh8l+h
	dlyy97Z5IbeKFoduoheTsvln4x9IjIzGjiiHCu+95Dhgy7bizKaN0pOIGz99HN8s5J2bfw3T/KW
	nKtFiZUTqa1UQaOUdvBwTgcQwC5bIdjM7vmnfU3qThi5hvFIVRZslEiDSI8FztJ3wFehGHCpDtv
	A6VCy77742GmJVZ4CCj1mcxGkwDhlDMDyuL45tVlsxOaa/Su6aZ0dyQTF1rS2fSr+WjFNv8NdKn
	yODXUVGMEGPbdVqRGTblCexwVRb4
X-Google-Smtp-Source: AGHT+IGhC8WZ2khF0B1ZzYJv6toAwZVLBn6s50DlREZq57HJmP/rBfKKkp/EHegrMC2uWHxcxNwyVNHyTQnt+yA/hC8=
X-Received: by 2002:a05:6102:374b:b0:5db:deb6:b261 with SMTP id
 ada2fe7eead31-5ec743c206emr191171137.13.1767642303017; Mon, 05 Jan 2026
 11:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 22:44:52 +0300
X-Gm-Features: AQt7F2qOyhucU5ykqhHlHKS-jroXL1WRPJ3u1HtyHqgDS9V3cppHeXbKF7tCIwA
Message-ID: <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We don't support NABO != 0

Also, what do you mean by that? I look here and I see that the
boundary is checked by the NVMe driver:
https://github.com/torvalds/linux/blob/3609fa95fb0f2c1b099e69e56634edb8fc03f87c/drivers/nvme/host/core.c#L974
- doesn't that mean boundaries are actually supported?

