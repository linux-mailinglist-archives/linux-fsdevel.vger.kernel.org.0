Return-Path: <linux-fsdevel+bounces-11916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E28591E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3045B20E6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462B7E10F;
	Sat, 17 Feb 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pF7J25j5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B941A91
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708196028; cv=none; b=JqRmSpom8OF/bYHCeIE5pCuvGZpYeAZtHdtl1BNaiI9t5b5sDC6SRhCKbcKYhr2Jeg3e887Ma8K/h/MdeFhjStO6wJAqjDyDbC3LsnzAzavW9KRR/GpMpD826BG4zF13vIAEYfT+7qPgR7YMkS6Gg8LBb9ENoohUnoIefD/yksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708196028; c=relaxed/simple;
	bh=RLmjiXp2wP5Fgl51rejnhgYeAKhrNJ0ZWPXEJjwQgAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MP6nRv2t8FcHk+dYlz6CqzRNGI8FnT1OP08XMDYSxtOTzOyKbYrZ797B9KnX9QVK4M1rei0JSZgVRKPsdSc09vUVO4qqGwe5JtbI/VrsGAtZMvGTTi5DFfDVbo8vFFqkA4hJZQd0LHscou76OXLJm9WXNAdtCQOUdU+udXrGDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pF7J25j5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so180911cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 10:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708196025; x=1708800825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLmjiXp2wP5Fgl51rejnhgYeAKhrNJ0ZWPXEJjwQgAA=;
        b=pF7J25j56jyF2nrCbJsCK+W/LPsT8j1Q4oUbnSLRpyjVErfNVjAtOF75o//DAzWSLk
         C0gcuSfFHn6zqvT07FG/v0fI31+u4p9T4ALRbR49I39VbRUo3F+f3nQ0BH7zQn9rsUub
         AUWuQbtMlGynSShu6Ym9KNzr9ce/oDhcsc5RR7qvRLd1LiqZudnBVUXP+CtpmrDoFVd0
         o8rMHVTGXVlck1YVrpDQfW9lWNb2O2Tba7m0Q9t5GON7atH6NfBA5AhBDrxbfJonpttY
         ZmaNyvUfmP4hf8iLZB18Csrtan8AGG/RU5GOlzuZidl3eosIQ2DGYBxbLOUZ77Jk4InX
         b3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708196025; x=1708800825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLmjiXp2wP5Fgl51rejnhgYeAKhrNJ0ZWPXEJjwQgAA=;
        b=LGrEnOdou84z3JLj5NTEgopIRBssyCC8uTGThHE8rpod+XfaEJwEqOmq2MpUANmUab
         jZ0UExaYZ8h9RhIHVMZZcagAXgro/dppN9mEOq2T7SAozUwMK1MGrXYSX8axpY+P64DC
         /9cSCJcKqt0Vee/HWsefH2DLkBM8hMU1liO8YDhOu4ChJcU9KlIJUnFNphMzqXzFZk6Y
         eyuyW15B+28XM+YQYwv3J3d3ev6EDSAT1BdElXNL2zTRUGmRwI0sHEQujjEybWDncix3
         06hdNE8+MRFho2+7od0lVHJL90rFYZrMLqNucsjC0MybVyGImavJ7WKsoxcD2aZTf+6C
         yvew==
X-Forwarded-Encrypted: i=1; AJvYcCU/kyFt4/il80LDLeJrrKVSvwI2cqEBPALRo22CDzBGdSVxn564mjkAhEWEX2E1c6lfC2SRm+V9G+R+pNLvmvFVLGwt330aDq1hjkvGZQ==
X-Gm-Message-State: AOJu0Yzx5JHYDibTUKKK8nvxiUOJGvQzYiJpDqXAaus8N86XwkSc+lQx
	0iV+W2hFZwguTiuZOL6z065PiGyKpcmYt9hnL2nUmfHoPFH00b//r7TFTED1hLAkOl3H78jpjRp
	8OtdtudkvP0Hl2pmZY5zP/wNdUafaIxkSe51Z
X-Google-Smtp-Source: AGHT+IFHlceaD0ZYNIU/ypBkqFO0AnLH/lFolMFd6+7BxMro5cqhBqaV99T9vpkKfUIG1Z9tcrQ9JE3R6/QCPqNNHII=
X-Received: by 2002:a05:622a:249:b0:42e:2b9:4f8f with SMTP id
 c9-20020a05622a024900b0042e02b94f8fmr9195qtx.4.1708196025553; Sat, 17 Feb
 2024 10:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL=UVf5hZNVUPv4WdLsyMw5X8kP-3=gwU9mymWS_3APTVuSacQ@mail.gmail.com>
 <CAOQ4uxgR1Z9LXAiRwgQ6h9avBphYttLeQS2JFWtzQr6ck6AiKw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgR1Z9LXAiRwgQ6h9avBphYttLeQS2JFWtzQr6ck6AiKw@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Sat, 17 Feb 2024 10:53:31 -0800
Message-ID: <CAL=UVf5FKEqTrHKnKv5c5iQmZ6WOfSw2YwTmnOU-Uv8WWiCyYw@mail.gmail.com>
Subject: Re: Regression: File truncate inotify behavior change
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

OK, that makes sense. I checked that I still get a modify even if I
don't write to the file. It's hard to imagine an actual application
(not a test app) depending on this exact ordering. I will change our
CTS test to be more tolerant.

Thanks for the quick response,
Paul

