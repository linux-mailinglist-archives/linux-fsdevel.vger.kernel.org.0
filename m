Return-Path: <linux-fsdevel+bounces-55626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F437B0CD5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 00:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBC6C1A32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A439242D78;
	Mon, 21 Jul 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlJ/xd1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AF1A29A;
	Mon, 21 Jul 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137777; cv=none; b=svdNEde2RrrNGhE6D2pST+Jbj1b3kyDYL6fm2KfTL9HWe3I9Edl+5Ba4yra6E1JC9RRjB7XfF8hzMKgesYzzMSfnQ02etq3fVoIHVSsk88b5G6u+msuZx6+Dw2AA1iLsYs3xLcrc+HtBPFFyE775PZXgy/sYFthFkt0VTh43sSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137777; c=relaxed/simple;
	bh=2wejYBimpTDlaBdxNiYjUZaXo5+6xL2dqLH8Nnb9TMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyWAUlfxYV0HmdVWzIMZv7eF/Ll+JoNbS3j5gOIZCIAOqszdxrUJbvTh6+fT5+zlRxjjvokVIYZV9F0WN16NDkNhHlGL9cET/MNoLZn9/b7CkGdJJua5AFAmPpKiRxGZiljELkhjmZhQbel+KkO5WzLHlMoGWv019lPQWXSfIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlJ/xd1I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so2367228f8f.0;
        Mon, 21 Jul 2025 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753137774; x=1753742574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSRRlwY5JEnlUl63++2+dkJU6k1aCDj5YRyr36FiVAU=;
        b=DlJ/xd1IY8M69ogeYlk/OMo0ygQ1nI0i5AZ0jeN9ZBCh72ULPl8CjUiWA8PkLm1zH8
         eC8UBTEzpO8adEettlFLH1N67elghy2kdpnbW2VHq+F1hQOtwM7LGsB/bgx/gypjMPdG
         PfegUlTJh7ZcnVkvvw/xMrJe+DtwvsXX/F4x52yCXRx1fJlqTX3s/xMTWIiFjopcHYz0
         pFHcmQ05IMmRm+jq75RFSwKfYKOBD5Z+SsJz5lvNu9gMXN2M2PSzbb8IJMDfTVLPbyWI
         A0coZomck4WyChhzuCdatajtEkUld5WRBDK77VTMxbP+TTQ9i89xG1oXXmAUz8zgWxuB
         Q4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753137774; x=1753742574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSRRlwY5JEnlUl63++2+dkJU6k1aCDj5YRyr36FiVAU=;
        b=jwPQGdB6LWz/L3pdSYJh6b3khYuG30k81rJ2DJJMd/1ziENcYpwlu6K1uf6k96n7EO
         keMbyH+WsVcKItjRu/YJK5NCf09ikerqoJQX1j8rfp/vBxHvbD/yEhrz6L9lCDubfEqu
         WtOkURCc0rwkpxiVfPtkautj0FHi1FDFEPGtn98ry5VxOtgUaRZQxzIRh7pWJM3IQcwi
         FL7jaoGjCO/a7S1nyUngipVpwoORUBgknlH6ckG8brGIAP+4ceNtVXoiPpuKMCcXXVQs
         FVhz7digoQ4k0WxptwtE+cvubstrnFhf97xeCSVWV5WH//y7Q1biRoS2bJqJgmnJyX6D
         9yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFWTB0EuKk+sP/GDGinGLjF+IeC5ekb8loRW33b1saQ1aHQvgXolcNQXJWLjIe0Gqewa682t73c9qhelM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1C4wuffUDHnZabW9e3DcSGxAd/8oXPGNsdTPHYP3eaccdskM
	u+HXf6+kStnHDxeF2gteLlkkvfPReeFeyqgTVLoYc1oZj5qv30u+GVG+
X-Gm-Gg: ASbGnct8dl9AjgJHo4+oqOIIha9qSoBGeQ+p/vcqQEm888OjF92VmXxFp6JO/PY0Nnh
	v1Nax5txdX8qjI0qtv8K8Vv1INEoVdYnDQJjPcuNY7GSEhOBR8dGS1pp2caRMD55fmv8i4LAyRf
	0cOr7W7WUJ97398cmS28blbn0+kJf3FaKBtiHgVabyUU3vydYUTEoXtLfaTs9BfvDLzfSiUVpGD
	Psw/GcDurEHtXdQ7UNqob2OGHWkqyUAQUax40q7oAwK9YJ2StoErPchh66VWp2Jmx49CuupB2Cl
	tXIfp1ZVxfP38C2a2pi4r/nGhA16sgtr4oUg/558b/bD89+6OOtqOrny6nsMhhxVva6PH2yiAnG
	T27NzcdAE2W8L+NQMFgFddz1sR61XzICRNQWvkQehE7kwpiUiJWVQ6Wbble2P2gOZ
X-Google-Smtp-Source: AGHT+IFZbPQ/XrSfO0fzKP+fHbJt9WSoYRViWFOQc8U4eBQryUHTs8SX+BSMG4KmRKRPLPMFbYUafQ==
X-Received: by 2002:a05:6000:290d:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3b60e4c4ae8mr17860548f8f.10.1753137773867;
        Mon, 21 Jul 2025 15:42:53 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.211.68.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487c1sm11668875f8f.41.2025.07.21.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:42:52 -0700 (PDT)
Date: Tue, 22 Jul 2025 00:42:28 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: Re: [PATCH] hpfs: add checks for ea addresses
Message-ID: <20250721224228.nzt7l7knum5hupgl@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250720142218.145320-1-apokusinski01@gmail.com>
 <784a100e-c848-3a9c-74ef-439fa12df53c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784a100e-c848-3a9c-74ef-439fa12df53c@redhat.com>

Hello,
Thanks for the feedback.

On Mon, Jul 21, 2025 at 09:51:22PM +0200, Mikulas Patocka wrote:
> Hi
> 
> I've got an email that shows these syslog lines:
> 
> hpfs: filesystem error: warning: spare dnodes used, try chkdsk
> hpfs: You really don't want any checks? You are crazy...
> hpfs: hpfs_map_sector(): read error
> hpfs: code page support is disabled
> ==================================================================
> BUG: KASAN: use-after-free in strcmp+0x6f/0xc0 lib/string.c:283
> Read of size 1 at addr ffff8880116728a6 by task syz-executor411/6741
> 
> 
> It seems that you deliberately turned off checking by using the parameter 
> check=none.
> 
> The HPFS driver will not check metadata for corruption if "check=none" is 
> used, you should use the default "check=normal" or enable extra 
> time-consuming checks using "check=strict".
> 

Yes, that's right. If we had "check!=none", then the issue would not come
up in syzkaller due to the checks performed on the extended attribues in the fnode.

I've just tried to confim that by using the "check=normal" and I did not get
the KASAN warning, as expected.

> The code that checks extended attributes in the fnode is in the function 
> hpfs_map_fnode, the branch "if ((fnode = hpfs_map_sector(s, ino, bhp, 
> FNODE_RD_AHEAD))) { if (hpfs_sb(s)->sb_chk) {" - fixes for checking 
> extended attributes should go there.
> 
> If you get a KASAN warning when using "check=normal" or "check=strict", 
> report it and I will fix it; with "check=none" it is not supposed to work.
> 
> Mikulas
> 

I'm just wondering what should be the expected kernel behaviour in the situation where
"check=none" and the "ea_offs", "acl_size_s", "ea_size_s" fields of fnode are corrupt?
If we assume that in such case running into some undefined behavior (which is accessing
an unknown memory area) is alright, then the code does not need any changes.
But if we'd like to prevent it, then I think we should always check the extended
attribute address regardless of the "check" parameter, as demonstrated
in the patch.

Kind regards,
Antoni


