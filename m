Return-Path: <linux-fsdevel+bounces-35479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57439D53DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1101F22F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F491DA63F;
	Thu, 21 Nov 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lXmURCcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D81D90BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220287; cv=none; b=LAC7H+/O6XI6jq+FnZUUMR1yXR+rrrKvXwMjUZHhSrE4tGC45hvsvrWUEIOpLSKSPzDuBjGMs+M50XGAgv9uEpMtJ+PqjU1GLIWaB55I6IAxGSeqoUT3l8dOi6QftK4EeOXDlXpSh60oYy3/PdmsUVFSUIznW4FZwSEOglfatDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220287; c=relaxed/simple;
	bh=PoQ6xe9gEBhTT4I8U11K3X6ngcSjvsKe9RH1AZSUE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAH3A78BdbHRaIr+A7MXhdaG1RlaoAxeF53rdDPnmCzlXCGFOnXh4Uagqm/gFS8fARa2iGsEgSjtuKJLpReTtxGAipuvhW60frRMo1MnAke3kR5OTJenTIIjyf7LQhRXbpKabf2Kld0j0aWZiS/8Ysip05u3NB7GQS10sTAubn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lXmURCcR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382442b7d9aso1142637f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1732220283; x=1732825083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2mZwNr3eW1Z9Vp+PcgzzHwsSK7NqM3DGZ9Ok0Kn/lA=;
        b=lXmURCcR2y2JM11ebEG56j0PKzDY/qy+47ocVFpemLSlClkU1wTpZwLL/QhhLPyW3s
         iF9Jsy6KQ+oxhvR8qRApsLH9BZhYuBrwPyfpf3YbRgcHt4ris8boO3EV5a3OzwR0hHu6
         GaATFgXOi3cHSpHOnsafal4zQvELNEmOZHVFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220283; x=1732825083;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2mZwNr3eW1Z9Vp+PcgzzHwsSK7NqM3DGZ9Ok0Kn/lA=;
        b=q8JTuN48m1HeS32z8yMyo+OLk27G9MMUaF5AfEhEgpj4CQ77n3IqJA8u5IHxdeemQ4
         n2Tyk2AVGenzoirrXOzqxWVy9uO/+QTc7TuuHH3+XXl4BHlpt107BTxLlWSMPNJvQGZM
         22jkS+eDOjGFFaeq36XL8vG90gHKnxfmxPA6Wm9MaEiVbeSBUbyBbXykU/aRNZ0iGunx
         Wq8ZskkOPZIqDZzdSzBHc8mforylqy0+1FbwgrdxzPsrJf7Bq59N6SEE7aHn7rlA55Sp
         XXQ2Y/7lmLhe0nMiogRHFBtQU4Zr3/mr8IEBXyJG7WjgtzxhlODI7qohYxMOftATT+1R
         v80Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAku+VY5zrNKFVL/OGaCK1a7+jRA05VuBPvriQ9JIDc9c5PydbOJFx1ESEgC+geeFlnXuwCEnCD80uUOqW@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6l5QpdoAXZGKpaEdOg4CXyZRxfjGaL3356tIL/cvksjX9Rmh
	FZQ2oOMgszoD2vptC1xP98B+9aKAqQYJdVoYXJ6gsNCi/L1vRdRtQOZ2mPTRw+c=
X-Gm-Gg: ASbGnctg9M2gsM6TGzALkwniMr3hnjnaU563EjHGQTyJmLc8NI4wFt9/uUeI9zxtwR0
	7rgVj3hunF2yyC/Q/1V6cU5tBwr9OygKt3WmMQAUmEXnxn+paz0z6NmyLaAswp/s/4FgzCGFzW4
	+W7ZFMkf0fazylOZbiwf9dzLEnijH0ZQVIyHCsGAQDJhnvRfuqgXHhXRmGleGVMJMaAWCN/iOiK
	G+01/qOQSA/PZQcwI2GpzvmxspdAdRFsfD3RmYQ73DGmRRNp/KDtaDi8bqJcg==
X-Google-Smtp-Source: AGHT+IFIAEZgwOdLKe2aLVeTOHcS+P2fVWqmTMpDKu9ZFOYWSBuKw3u5Or2kbjFemduSGbeJqRdGPA==
X-Received: by 2002:adf:e18c:0:b0:382:5aae:87ac with SMTP id ffacd0b85a97d-38260b8966dmr360789f8f.32.1732220282992;
        Thu, 21 Nov 2024 12:18:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb271ffsm455908f8f.53.2024.11.21.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:18:02 -0800 (PST)
Date: Thu, 21 Nov 2024 21:17:59 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zz-VdwLPBUV9d_Sj@phenom.ffwll.local>
Mail-Followup-To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
References: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Wed, Nov 20, 2024 at 05:39:09PM -0500, Kent Overstreet wrote:
> There were concerns raised in the recent CoC enforcement thread, by
> someone with experience in such matters, that your aproach seemed
> extremeely heavy handed and I find myself in 100% agreement.

Ehrm ...

Yes, I did quite strongly criticize the new coc enforcement process.

No, you would not appreciate what I'd do instead, not at all.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

