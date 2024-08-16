Return-Path: <linux-fsdevel+bounces-26138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A343A954E4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64D11C24842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A971BE222;
	Fri, 16 Aug 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y7wznZWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFD179A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823861; cv=none; b=kwNTZHebVpVs5ScELUgoA7w3S8O0m27cqBNNVFxHpZY+oW4M/nafbl7u+qiDqnN3RjSM1LXLLpoYe+S5wdJSJQQUYwZMpY2nBMrItTBaQMNK3afwCT2+jtMNtkfXgyxaxL4PK6VzbGJd//jFClseGa4MURq7iPQMFdFp4h08mAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823861; c=relaxed/simple;
	bh=aoBdC4vV5tSt9N2+4rYRTVPetApHSBaAhfaMjtZc080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXqYy9UGjLAH5mRP7fmt57nlUtxAhMDFB1Z+8FlBJaUmahG2sRz7C7q76yjapE3MXs0kBBKi0CxK9KAxgX10jPvOwCjUtNyW+OysgBj6KSy59q2+CdyxAn+tMRPW7/cZFQ1wvULEUzxN/yRwdW8sv0WVFOLmyglp7NaCxH7bLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y7wznZWf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so16902535e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723823856; x=1724428656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2d/JzAZ+TBVSkaOBKJL9Nj+hpNWksU9K8nO0cClXug=;
        b=Y7wznZWfRQW0K9BZdKeqNctiGZbz0tqB8gnvSnATM2DCnkZH14Xpa7UMz4M4a3APai
         uROntaGGDbMSMyQr+V5IfYmZ8yb1Iz5QVewms0MNtLl2w50cTiu0Enp8JRTmt9TcAwgv
         yALpaYTOqFl479HTnz/li0Lfcwo/BS0EJu8nI9e64o9F07bdH1EpSB8/TluZsdKl/R0X
         AXsMdodB/IxS6IFtwIyrRGCTVpZsgYAoSWrl58TrD4QrXNtAMUrCHF8vQHjR4rwKaLqx
         QNqp0oxYNGmZpgX/E0m0ZlvMZUDBl7XBDnwC20aBeKkysbzuEIYdQ6Wj5idsRPxhAPWi
         IkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823856; x=1724428656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2d/JzAZ+TBVSkaOBKJL9Nj+hpNWksU9K8nO0cClXug=;
        b=iKqeEqTCzIKaI5mPefn04mIJnorIarc6rbTMID4lBOxnpLWwcuH66v4eeo3bnsmbUi
         Kh6tmLvpQ2vwye20sgT16UZ7cP0c2yM4+Hx1IIgdha5QlEbtTjXaNnfov+JeelwHrOMu
         2jltdAScH9JllP80hjrk4B4NKCAuiqGR7OWHk9ZrAsmOqabdvcHwC8fOxoMx6IjFuOjz
         e1dwi+WZbFuipL3cnbW9ozM69HukxXtFD1iA7waEIUtt065oJ8tzpZIaS5ooYMxJnVjF
         nlrNI0pGTTlzKqKuTQDIusTj8To4Iu+vbWtueh+3RC7+RVPanoRHFUFt1BsdKJfRw3aK
         Omdg==
X-Forwarded-Encrypted: i=1; AJvYcCULZjR5bkIUGc5+qIoaplqJsmSmMfmvi/fHPIgWWeRili4axaJM1j9fXY3uCZ0l6saxZ2kax35Y9pqBpI/0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Ov1ffSj2ejjEvIBm8VI1gfpa7PIHM1l4HJpy84R8yIY/HOoL
	byFe/x6LLWLeqiYGKcsFvawMTbpNvy+TPwKQf2ITNHvOuXMOMxpAwb5at+Wqp5o=
X-Google-Smtp-Source: AGHT+IEzvB3fudXG1WMYfkh1oaQjohODCiL233Ph9eMatQT0D6vyrnRryxAz3hn+F2mmEluIgEmP+w==
X-Received: by 2002:a05:600c:1c8f:b0:428:23c8:1e54 with SMTP id 5b1f17b1804b1-429ed7b8360mr25715495e9.18.1723823855796;
        Fri, 16 Aug 2024 08:57:35 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabdesm3893021f8f.99.2024.08.16.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:57:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:57:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <Zr927sG0UpRRzjfm@tiehlicka>
References: <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
 <Zr9hfsZDfLohgj0m@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr9hfsZDfLohgj0m@infradead.org>

On Fri 16-08-24 07:26:06, Christoph Hellwig wrote:
> On Fri, Aug 16, 2024 at 10:54:37AM +0200, Michal Hocko wrote:
> > Yes, I think we should kill it before it spreads even more but I would
> > not like to make the existing user just broken. I have zero visibility
> > and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> > it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> > directly. It would require inode_init_always_gfp variant as well (to not
> > touch all existing callers that do not have any locking requirements but
> > I do not see any other nested allocations.
> 
> I'll probably have to go down into security_inode_alloc as well.

yes, I have done that as well. I was not sure about
inode_alloc_security. It has alloc in the name but none of the caller
actually allocate from there. lsm_inode_alloc was trivial to update.

> That being said there is no explanation for the behavior here in the
> commit logs or the code itself, so who knows.

-- 
Michal Hocko
SUSE Labs

