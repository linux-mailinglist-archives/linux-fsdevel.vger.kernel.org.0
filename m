Return-Path: <linux-fsdevel+bounces-57971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA925B27336
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F61C88B10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E06288510;
	Thu, 14 Aug 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnnwPPH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB61F582E;
	Thu, 14 Aug 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215537; cv=none; b=rig3th2PfXZucpiDSfcpz21fqTExGCj3sEYKwafTpO589kbfPXrKVvWQs27B4TZjCFCXRTGRbtvmD8dxJOFDoPnP6M5nXbpf54FBnyRDr+EL4DgMfOIn41GPTB0eP0FJjdQqmWBuBh6O1+y0ezHPr40JoJwq2h/LSfDpi/8+dmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215537; c=relaxed/simple;
	bh=FIwBp8wJXikAg8T0jVOLfvQmcs/O9AstztJ/HuCCqRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pESoY7egbKxRN6qHiVfgx4zx1vNQ/Ngyi22RM5z83OWqvrLQaTpRQby1Tj3dU8TWKaFoS5TjUzFguveFlM5zA54p1000KVmvQentcX/R7XwXlkf3MtMBeUsWIGZuTWLKaEtaRht7JUhhXZ5PYJimoEs35Qbt6hl4lN0uPo/rk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnnwPPH6; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bd4eaa7adso164378eaf.3;
        Thu, 14 Aug 2025 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755215535; x=1755820335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Cp39JSJVQFqGca1UhwI175ws5wjvkkGsiO7+sL61aw=;
        b=AnnwPPH6xRsC5d70u6Qs3+gE8DG0xAN7+kyVCIHz0/EZ+uYNxj9YmuJE0IDXZ9B+fp
         BfdPDZkqzpDYm9jihH8GNnlg9i9tE6u6iGSpGY7aUPR931VhfX8bRzZ49rauBAxS0ybO
         H1tuJKTrMVHiNS/9WYtbDiilkrZC9RnHg2dP4QSobzmEvVilVRrXJP3+LL+UOtL2ivRk
         BIGEyL0JOM44MPRNaNw7ZGtL7xWBYQF06EshiW4QwAsj1zBePswXZ7vkdoZ/TXdrtSEL
         5OtG7P7xtrXg3fJf/EYHf0IakH6r/M75KMB8aYIux3a/cLMSMmlckWyjXmt2GtEf07un
         CaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755215535; x=1755820335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cp39JSJVQFqGca1UhwI175ws5wjvkkGsiO7+sL61aw=;
        b=xQ0imKb5UF4XPvMhQttfus6cAG1zuxhnaYdk0kPCC0OoFMIcAfMHqmdjGUajna5miF
         hk6IhsFD9EzaefRyU953G/fRv3DYM6P2TgbqApq2gxvcMD8Q+WZdK3/dN5qd777+EBB2
         YhLqmphJqy/KJrZrsBXsF1Ztxuz53mzD6mpdn+qisBiXD/F8ZvwRqc1ZMMzBCit/dkQX
         ehxkb7MBgNWTN394rsG4epzPqBNVgS/C765I7+vxQQg+tp1aUzbnBgPsQGHsKJxIyz/h
         3UlfodQDbdHfnyRPU4OJ1lLuavcCxlzMwyzc6TN10tfb/wrljfT9aZExzspuCy3e/Tvo
         3rkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3PGaAeAGp3XWR6RzAzfP+IhlAuzjrM8AqZo1iIN8L9/eQM0aKXf8q+WWsLEwKzmBhy3qnSktIFyY=@vger.kernel.org, AJvYcCWJmZsn880EXsZBW5X7N9UEFlfFnB2ZarFOi+SOgJCJa57PxHmfV8cN2czsPXYnA2Z4xvgC75ZxLicqEjwIPQ==@vger.kernel.org, AJvYcCWO7slPeR0OCaRqNgAPSFTII8rCaDOkUC+E1jvWJkeJJHx4U8g46qHyeEnfC3Eq+CriCkLs8a6nT1X+@vger.kernel.org, AJvYcCWxSWz8WE3K1btp5orXGoiiVfEp0rzrG51KbzmDAAWX6NI2RccI74q2aBGq76/gvkkcYyFwjPJy2HmyfKZN@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLeIkK456AlAj7qoygOwPrV99SKqrTruGUzYnvUF2+g9V14lz
	wNq+sRS00pCwze2a+IQa4CG5OmhkCidS4ceJzeI56gU+57/wi187xV5l
X-Gm-Gg: ASbGncvHpYwaB8/2TFm5B198zlsmZDuSrSoJPfvUrNyHh7DBrfx5rckQd4knCPgEZTQ
	zCo+hPatohqtXn+O+ryYtiJJRGqEVGTcMF9yZiq7sBIR91QuIemHyQYXowokXW0TkHiepwDDJZQ
	n2Uk2MfI7UlgVhvoVdSK9+evYDDeFoxh/uuBueIuB02LJJgbnUoZe1bKLkBxNr5WEL43V2x7TEj
	O+KrRmlQYALwyoy2s1haLaYFnmXTKhyM7DiLRoAC73j8iQoHo91YCpfCp3FjFxkBp2UIWYSxuaT
	3PLwcl2fcHxbWzooaXkrF16CT2WDGB1e4uctgsmmoegY7EsIeDKN4EpdQx1q7T4QrjEaJHoH20p
	XwM86lpmGsT+EgNwlAsN80H2CKUmdB0gLYKBusVbNyYedqQA=
X-Google-Smtp-Source: AGHT+IGaHBl9xPsB9OO1cSHxNM9bAShZhkcOLGtZLcFtgk6aKTkPevpMjng+tcrzZPheSVo/c93Euw==
X-Received: by 2002:a05:6820:1b88:b0:61b:d55e:6d19 with SMTP id 006d021491bc7-61beabc936emr162698eaf.6.1755215534772;
        Thu, 14 Aug 2025 16:52:14 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c95b:3a76:bbcf:777c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b7caa0a42sm1980047eaf.24.2025.08.14.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 16:52:14 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 14 Aug 2025 18:52:12 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Message-ID: <kuarf6hiwmit3jwwe4r27dj46v64k7x52eitsaw27zfw7c62cc@nrzyjrs5kztk>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs>
 <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs>
 <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
 <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
 <CAJfpegsQxSv+x5=u1-ikR_Pk7L+h_AqNBW1XxM-b1G2TLPP4LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsQxSv+x5=u1-ikR_Pk7L+h_AqNBW1XxM-b1G2TLPP4LA@mail.gmail.com>

On 25/08/14 05:19PM, Miklos Szeredi wrote:
> On Thu, 14 Aug 2025 at 16:39, John Groves <John@groves.net> wrote:
> 
> > Having a generic approach rather than a '-o' option would be fine with me.
> > Also happy to entertain other ideas...
> 
> We could just allow arbitrary options to be set by the server.  It
> might break cases where the server just passes unknown options down
> into the kernel, which currently are rejected.  I don't think this is
> common practice, but still it sounds a bit risky.
> 
> Alternatively allow INIT_REPLY to set up misc options, which can only
> be done explicitly, so no risk there.
> 
> Thanks,
> Miklos

I'll take a look at INIT_REPLY; if I can make sense of it, I'll try something
based on that in V3. Or I may have questions...

Thanks,
John


