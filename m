Return-Path: <linux-fsdevel+bounces-53177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9FAEBA3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF0F18894C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FEC2F1FF5;
	Fri, 27 Jun 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vtmBW32g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C017A586
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035568; cv=none; b=LYLQSIVkGik4mrIcwMNTN91tY9lmiKXv0fxEllb9P4ydeW49Q/3+cmeWgGOy7i7JLXTwHFV7jXHqGssp7pHVugzPKF/EY6bKofMuaOal6wZGJ7t1VxDZxIwOfoZ0vNRxL8CkQcFaJqsD8C+RdA8fP5IdJN1/6hQAUdAihfh78Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035568; c=relaxed/simple;
	bh=E3Y6IzzH6pxPxtBDBUSfanZZ39PEqoGxRtLOhfbrYg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiSRfNTZjdnnKPoV1Z6qxPzqkgDZzWO2Cclxz2yg9NjBzNkVZ+goksDc3bajYcROmlXkI+Pixx9kVTdgzHIC6t8c+tvsZFPV8bi8h/uBKDUjRAxpXg0W7RhXGCbyPAgnTKEvY8FPZEdrj71GVNKDNYL8z8Jb5eYIFTflqKZGJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vtmBW32g; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so27474981cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1751035566; x=1751640366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZ2pYMMlB12bEyOWlLPzPkRWlImskMORgDF4tKP1qU=;
        b=vtmBW32gyxvDT3+DEMFKOabrGzfxEuOAEpEHM77wLWw++0FvVkCREW5rRuFv2FI3/r
         S1lnu1IR6RPRYVLh2mZlHptrHCRCzJZzEn71R/U1ydDs2q7h1UUbZUvQDbi1VUtZkcoH
         2s418vmzJ29PPnYZ+lzUzhuMo4GUJJ2TS6cOGSE3yMHHlwgtfGo7I4EbTBCkQuQd3WUD
         OwygcdD0xHENTo2oq++ppyFDVptBXNqah+FxO+lXWdOeWOb0QYhsPda09M/GaRgzhQOL
         aXAAK8L7J+kAQUfn7REOwMHXSGEQ/41VuSM5rJUMcyzN2/FeWYpIB28rf3CK0AlCj4q9
         BfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035566; x=1751640366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRZ2pYMMlB12bEyOWlLPzPkRWlImskMORgDF4tKP1qU=;
        b=sLu5Kv4oEOqHOVKLEcAwOxYHmGC6/OrGOUt8WqjynPsHOdNKo4YlP2hjJndHJTxMOX
         umbs35wNRfQlsaVUv0pe6lBzfdgh/amTmO4vn1NPH7yWwVLNZ2ef40HxJ99Rmm8wiAno
         qqNPGanxvGS+8qz4XSQ6rCkW8j5Kbk5BqBriWFiggwo7Z1vVx8aUYEwUWLepL1PodOe4
         UTRdv1H3dGWzh34I4R5oEzxOrFwXQV+7Wfggelb36qSeWGXySA4NrTrhRbXp8crZ+TFg
         I3WH8HqlvW5u7f00pDO4RX6LCqhRbBIpO2GhiuDxEwDPi6bqAJMCumCmpUrpkTg++FDj
         gnTw==
X-Forwarded-Encrypted: i=1; AJvYcCWoeatumRbnJUqm6uoOTyLfyNPh/zDPzCbakPit9QLnYwbtjxG1eMK+xQ++yz8GMtelxW7BJrGNSEre8MT1@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWb8t4Mn9gUto6saCR9nn17TWETSv1mdsF9E3GQP9zS3tdUtk
	yyDCGPKwlmxWHxOLCl8hko5mIkxAN5EmR2wSLDKOPAjXvdX9arI3fSoTq5/YDdTeffo=
X-Gm-Gg: ASbGncsMw2LDlBgy6fhzSsRMbPDPuvxym4B3sJ7l0FXiaUOeBmPHmAF2VJ3P00IZmDE
	S2ZoVLV2FIl9VSgt33V2JVS51KJtd3uRbb52AEH6y53hHYrGoYMV7UvAjdGVJJbuyhzBi86KlHy
	Go85bzmgAbk+ohCRFwNJQBKt4o5wzXyTAjPcJDoWiHwk50fnQ6bz/hpAB+TeEoqyBcCrpDuO5oA
	EQekXNsclaKV24uQe0R7/FcJUJWIsWcE8IFsfwGzx5js9M6GgH6gEWBfjwY6RTfksgb7167djA4
	A9TnHXlBb09PQONMp6ARcU41WAHimWxBLpYPvRNAr1iRP/UEKUw+06wfzNUxFA2dCTNtZJJVNKt
	PuvBxFVSHMXP9oOJwJL3N2rU=
X-Google-Smtp-Source: AGHT+IEl0a6FKcst6Ik6YqVg0aAynT4+CuhWSr+flkm8BIm7KHjl1Bb3vmzdqMA+uCtcxDKZ0P3SuA==
X-Received: by 2002:ac8:5ad4:0:b0:4a7:6ddf:f7de with SMTP id d75a77b69052e-4a7fc9d7dc6mr61049981cf.1.1751035565530;
        Fri, 27 Jun 2025 07:46:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc13a60bsm13628811cf.29.2025.06.27.07.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:46:04 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:46:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kerenl@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <20250627144441.GA349175@fedora>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>

On Thu, Jun 26, 2025 at 10:22:52PM -0400, Kent Overstreet wrote:
> per the maintainer thread discussion and precedent in xfs and btrfs
> for repair code in RCs, journal_rewind is again included
>

I'm replying to set the record straight. This is not the start of the
discussion. I am not going to let false statements stand by unchallenged
however.

Sterba has never sent large pull requests in RCs, certainly not with features in
them.  Even when Chris was the maintainer and we were a little faster and looser
and were pushing the envelope to see what Linus would accept we didn't ship
anything near this volume of patches past rc1.

And the numbers don't lie.

josef@fedora:~/linux$ git tag --contains 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a | grep -v rc > bcachefs-tags
josef@fedora:~/linux$ git tag --contains be0e5c097fc206b863ce9fe6b3cfd6974b0110f4 | grep -v rc > tags
josef@fedora:~/linux$ for i in $(cat tags); do git log --no-merges --oneline $i-rc2..$i fs/btrfs | wc -l; done > btrfs-counts.txt
josef@fedora:~/linux$ for i in $(cat bcachefs-tags); do git log --no-merges --oneline $i-rc2..$i fs/bcachefs | wc -l; done > bcachefs-counts.txt

josef@fedora:~/linux$ R -q -e "x <- read.csv('btrfs-counts.txt', header = F); summary(x); sd(x[ , 1 ])"
> x <- read.csv('btrfs-counts.txt', header = F); summary(x); sd(x[ , 1 ])
       V1       
 Min.   : 0.00  
 1st Qu.:10.25  
 Median :19.00  
 Mean   :20.48  
 3rd Qu.:27.50  
 Max.   :55.00  
[1] 11.77108
> 
josef@fedora:~/linux$ R -q -e "x <- read.csv('bcachefs-counts.txt', header = F); summary(x); sd(x[ , 1 ])"
> x <- read.csv('bcachefs-counts.txt', header = F); summary(x); sd(x[ , 1 ])
       V1        
 Min.   :  0.00  
 1st Qu.: 38.50  
 Median : 70.00  
 Mean   : 63.86  
 3rd Qu.: 81.50  
 Max.   :137.00  
[1] 45.28218
> 

So even including the wilder times of kernel development in general and btrfs's
specifically, our worst window was 55 patches, less than your mean.

These are not the same thing. Do not equivicate the two.  Sterba is a phenomenal
maintainer who does his job well, manages to work with Linus just fine. We are
not the same, we do not work the same, and we absolutely do follow the rules, as
do 99.99% of the kernel community.

If xfs has done this then good for them. Those developers have a track record of
doing the right thing over a long period of time. Btrfs for sure hasn't. Thanks,

Josef

