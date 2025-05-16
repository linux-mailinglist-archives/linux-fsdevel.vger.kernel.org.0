Return-Path: <linux-fsdevel+bounces-49221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA1AB9854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3F1BA2D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F622CBEF;
	Fri, 16 May 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FGvc5UK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BF22B595
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386451; cv=none; b=NHEDErYx7Mu1+SaIflkK8D+T6jq30bYyUgUvT3RDacI0H/n/hIFPAkM0URodmZWC/hbKIo04QxZzimmhyibK9BFQEZCGBkofB/htBzaNiwIjsKN7YPhwSSX67EiyE3LB9yVyG1F5DUvFVmg6vArEa0sD05qkROD7zLi/ykqx2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386451; c=relaxed/simple;
	bh=wrM53/+1YEkSEjOM43PJT82vXpJgf8qaLiTvj/aJoNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn2dQcSbSPlnpu+ywocKTvOwNa0Mz/ovHJCEyPV8Lf1iw2wocSQPCNHMHG8wWYi4lBlCRAYl5QeAHBpHeK1/cTeYV9XOkHaz/Ez0DVIOnjzQEvDn6rjMaMQBhQeIsKS8UgNv5yYoO983+2Pf3Nj4mD0OPOcl+YaTomR8b97o5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FGvc5UK9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47664364628so23027241cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747386448; x=1747991248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrM53/+1YEkSEjOM43PJT82vXpJgf8qaLiTvj/aJoNI=;
        b=FGvc5UK9JqLZ2h4CHeKdP5k7n5N4N34k0t2H+ozo3nfxU8O0YRTleMA8AjRz9B0DcY
         aTL8BkispS3XxKQgtFETAGZicWvwdm+DhClvtJS0u7JCFvBH2x/+wUtlxJcLEOtnAw8N
         dn+T/Omsn768NPHdDoVRbMsqGz55xqlIMWwtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747386448; x=1747991248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrM53/+1YEkSEjOM43PJT82vXpJgf8qaLiTvj/aJoNI=;
        b=Ft3GASxbNWiudmksmK3DXmUeGLhZMwO3ZGszNcyG0uCHbsfqlpol7+FwI6LjhP4cCr
         QKybwCmgY/ga/5n14XRmC0dnN1WWAHsJKFKOb15aSFwskbVXUXGym1Sl/0g+7W7fdXyC
         /uPpkH5G2kuHjY+QxHDjYpE2XOrFo8KFDtSeC9n0fFLlU8/eGzs8VoM70ao4a3RsPKan
         RiaKlz/BCXK4WMklQofpdupfTBWx02itd4+NCy/seVVCCMCjHnTjHdJAAeV+v0f0OppA
         HUJMLEU20r1DFJG1WXITIJcoHNsgoBFnx7CtALAdoIS9QD1Fb/Cr0nv2C3Gl8W3Jg/Rv
         wm+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtvXkWYzQess7jKkkY0vq25L4/ylbO5XSAzEKlmcxRB7S4EqVAOxN0Xnr2xe1TWoPo13Y8kU+PDS13P+qQ@vger.kernel.org
X-Gm-Message-State: AOJu0YynIGW2a9q4H2ZM0MqVAarLEPwb8y3qI9PJTK6k2cz6b3MhU8qg
	0YY19lNXelbMkFg86nGWc/igU4WvmidZ+xIl3ohNxGJUSsRh7E+DYFIfekkXa+wSleeSTe9RY6k
	FYZmIfwukDvmenWvn7iNQ7hpPyHhvNSkOGw0900bIeQlA6tVwVD6y
X-Gm-Gg: ASbGncuO4ZKMu4UpWPV54vYfep6ZIACFei+Kbj0mdZkoubYMPtz64WdVUbArXla+bwJ
	e3J5oxKqqu5rX7mEL0J6vDCqzT0Ydvi6MglUlsiZ9D6JgSSzVaQHNffS6dkM2kwcZxOMHxaqpCF
	b/W0Zr1vIyk40F2vhTmfYvy4OptWoi7LM=
X-Google-Smtp-Source: AGHT+IH05n37JoE6mT085e1qzvTQpe0dX8N/5srUncr7elKTQC70YScbooWXBkSfsjMDGRsOpetjxc+hc0Bdf+E+sqc=
X-Received: by 2002:a05:622a:250c:b0:494:ac12:5cb8 with SMTP id
 d75a77b69052e-494ae5871d6mr40884591cf.25.1747386448325; Fri, 16 May 2025
 02:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com> <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
 <20250515-dunkel-rochen-ad18a3423840@brauner>
In-Reply-To: <20250515-dunkel-rochen-ad18a3423840@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 11:07:17 +0200
X-Gm-Features: AX0GCFvyUhM7kLscr_Imx1oH4dDYOsUSTkLANXONyIH0keaEyzlAMQmJ-GnN7Pk
Message-ID: <CAJfpegutBsgbrGN740f0eP1yMtKGn4s786cwuLULJyNRiL_yRg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <allison.karlitskaya@redhat.com>, linux-fsdevel@vger.kernel.org, 
	lis@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 12:10, Christian Brauner <brauner@kernel.org> wrote:

> Before making this a kernel wide sysctl attribute we should have actual
> users that need more than two right now. IIUC, then making this an
> attribute in FUSE will happen at some point anyway. For example, if
> userspace wants to have a FUSE specific stacking limit that's different
> from the global limit.

Okay, let's add it to fuse_init_in as uint8_t.

Thanks,
Miklos

