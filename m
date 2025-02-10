Return-Path: <linux-fsdevel+bounces-41483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A579A2FC00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 22:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FE9165C09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84B1C5D53;
	Mon, 10 Feb 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="m80CgoDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE11C2DB0
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222864; cv=none; b=mnK5RtxA8nvREKuZILYYCgxISwkkjz7ScowVJavoXWdL537tCcnHbwy3D4V5/IAWXFdsz2asitYlSTaokCdaTiLpbnSp8dgOZETCovBUmQo5NQbfUL5a1SyT/en0X6g7SnLHXVO98fHtjGi5ZsOmKSrH5P69FcoM6vBqUmAFAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222864; c=relaxed/simple;
	bh=TCGFMO0Kzsl38vGs8KnFrQdwRbWq3ZsAVQzKAWEcFSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc/GjEulRykm9H2UZ5JrNgVO0jedoLhvrn6I9DPKsiOM5fAHspP9GVdqbbK7K3gAFA383I0lIgrxJH9qeWRGeSDKmanHiYEHn7Jcc4HqXveACVcqDBXSyrrpOx4hPiDOEYPwjT7VM4gpTv9QcefrIwy7/xO9lbLjYW8ijVhMNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=m80CgoDy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f6a47d617so40143865ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 13:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739222862; x=1739827662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtOKP/bSIZMX5MzdlHWBebrHFz0TkipWTyjAUPt1uMI=;
        b=m80CgoDymXqcSb71WKtyRjnyOj5/lgIaJ3+8d5w8sJBZYdc36ts2rv49t91qtaaQ6T
         JiD8qtsAxtPh6+kmvd4LMspe5wScvFp67mQVk/Wt26JgL7qziUdXXYO/tM8QekFPaXZv
         9Y9dYgghH+K73QvYgItkmswB/sLLrqXkleWZ5IeQbc8Kx6DdVMBG9ZrTm9b2sjPBhrQx
         yTtBctdeObi0yIwEvFEW4fv6O5j+uMTT78TKkFtVU7gcER+6liKBEoSgdaB7boiIgooY
         EXhSAGas4RHP7+fIs4BZW/rLCsC/8NKtFZWGMX1gpmtBWLJQOpx/mZkxDIKAly3/Ckh6
         dquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739222862; x=1739827662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtOKP/bSIZMX5MzdlHWBebrHFz0TkipWTyjAUPt1uMI=;
        b=CfU3sgcGjRVdARXfmPHGErBMi5REJm4cCv6nDSCnlCxKBUKW9MtMfPl6C4NfxbhWMl
         9PwpylhgVI9kMIr8thF/WgO756WWlGxcUxnSNAq4XjpVM2CF7VrC8Ud8Kmi9XzUHvcNg
         +gUPbJ9h4pz0Zn72/cRkY4hcP1YT2NNV3vURpzKQ6IIL6ThwgfSomIvUts7/Ce6pyWhZ
         RGddm00JKQNSQ24ZU6Hd3HAcvB30IoEdnw48azYHTUNEtfodr1wPgOwdeDb+CptWGZSr
         /Tq4bLwJB0B4dPpPzCcZ6HM3bdca/YgSTwjsi+M8VGDiIOYNvcUhJV7B/cZ2BPjlQsgR
         LHhg==
X-Forwarded-Encrypted: i=1; AJvYcCXJK43VJ6Z9aNv4HsGPAHbeo/nkoj+3Q2OqpHHFdWpnCo/FT/K9fgs462VZIeoncXAOo7ToJG6n/JAyZodc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13fqgEfh195/RHo8mY1S5LD9YGb9oIz2+MYhVK/j69eaCjmXO
	uphEtXzcqn5UY+AoJGLZyh98ZdlVDHpNxOLMfvYwpXzjr9fxhIYPVj6dBIgVeeI=
X-Gm-Gg: ASbGncubgknQThiRfk71vEipkhP8ip2oE/EhKIt0F1vj76p+J7nSqp6nxS1F0zjYXt/
	jL/1BXaxiiHokljrudAu4S/RsTVdi4UdoemEtN8s/UZLhEDCFoeXLFzcw4rlgFtFS5ACcaYe0OE
	E14GMPgZKyuNFtIxsb6buKGKgmpYdw3E4JnDt6+CFxkkGF51bKIkmIhOxwTQIW+XMnfRIgdlfUd
	FfyWbtqQ8d32+H3PbQ/LsyBbSi9XsvGy1AQGrGKrOxZkFPWq2OX4jhy0TwjfofxARsVylUnXOtt
	hJhKxxT6vBBZ2WxbxdmNpJU2JPfvtQlmHpDh5+SEmgqOSepAha5UBy5pmxk407BDZjs=
X-Google-Smtp-Source: AGHT+IFr35z0eAENl9HzqdOEk7n54mdmMk8QWjypibe6vwYaIzd14Ua8l2RBxoHpJi316a7c9TtdSA==
X-Received: by 2002:a17:902:e802:b0:21f:35fd:1b76 with SMTP id d9443c01a7336-21f4e777b52mr239809035ad.45.1739222862295;
        Mon, 10 Feb 2025 13:27:42 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e689sm83568755ad.48.2025.02.10.13.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:27:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thbJb-0000000HCZS-2H6i;
	Tue, 11 Feb 2025 08:27:39 +1100
Date: Tue, 11 Feb 2025 08:27:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hch@lst.de,
	Avi Kivity <avi@scylladb.com>
Subject: Re: Possible regression with buffered writes + NOWAIT behavior,
 under memory pressure
Message-ID: <Z6pvS6uL7AYLHi9U@dread.disaster.area>
References: <CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com>
 <Z6prC2fBbd6UE49r@dread.disaster.area>
 <Z6ptDG96_MrdN07R@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ptDG96_MrdN07R@casper.infradead.org>

On Mon, Feb 10, 2025 at 09:18:04PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 11, 2025 at 08:09:31AM +1100, Dave Chinner wrote:
> > Better to only do the FGP_NOWAIT check when a failure occurs; that
> > puts it in the slow path rather than having to evaluate it
> > unnecessarily every time through the function/loop. i.e.
> > 
> >  		folio = filemap_alloc_folio(gfp, order);
> > -		if (!folio)
> > -			return ERR_PTR(-ENOMEM);
> > +		if (!folio) {
> > +			if (fgp_flags & FGP_NOWAIT)
> > +				err = -EAGAIN;
> > +			else
> > +				err = -ENOMEM;
> > +			continue;
> > +		}
> 
> Or would we be better off handling ENOMEM the same way we handle EAGAIN?
> eg something like:
> 
> +++ b/io_uring/io_uring.c
> @@ -1842,7 +1842,7 @@ void io_wq_submit_work(struct io_wq_work *work)
> 
>         do {
>                 ret = io_issue_sqe(req, issue_flags);
> -               if (ret != -EAGAIN)
> +               if (ret != -EAGAIN || ret != -ENOMEM)
>                         break;

This still allows -ENOMEM to escape to userspace instead of -EAGAIN
via pwritev2(RWF_NOWAIT) and AIO write interfaces.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

