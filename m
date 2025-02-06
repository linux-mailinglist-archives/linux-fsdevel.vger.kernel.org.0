Return-Path: <linux-fsdevel+bounces-41121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A98A2B38F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC78188AA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726D1DB346;
	Thu,  6 Feb 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OCq06UAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77571239596
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874735; cv=none; b=E6S7i68B1dH5Rs+HhG2pg5xvrQVutKmGVllwttdbN8nIg0jUD67f3ZWv3INv5RPtp7V2OKdwnGrzFgSbyTZY55FBcDYSqad2NGJdRkqC11L7YBcD6ytrL0nkug2UjGxWg4HhKjLP1WHdUP2MWH7enIMOZxVAvvyGwrMVzYiMhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874735; c=relaxed/simple;
	bh=pfVdOI7zeX3QZjonU0bDcxUgEVXtWcwPpFzM+WZZo8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSUGwP3Uw4ho+ILEahqArxrZ/FJE42E7/Yrkyf/IyhCkFxHVyZ+gOrqt/FuD0ok3uLUiyqmALD2mjjsysdd85/bJz1vPhQKeR+uv2tDmBkJJSxLp93Qi9tqOcya+l2Aq9Q2OrQSSaUy9Ce0p9nLUFSqfu0kM06d5cyN7Tb6+Suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OCq06UAU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso325610866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738874731; x=1739479531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47JwpRHSzZnwFr+mlMdiSA0nMc8sUlKLRRzJ0WxNtMg=;
        b=OCq06UAUOlIa3ZUA2PsML9QhzWuGuNJSuywDmHnMcHYO1FLRqFn150d/eI1LGgIyLI
         7W1l4IJYNp23Im3JCK8Q4z0qaGqGSm+GzDMcXsV9EYAgJlw61wOIFfH2i7A7cBchscHt
         yBPuPAq8weR7y9IyzqcbhHy2/xmjWju0jNE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738874731; x=1739479531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47JwpRHSzZnwFr+mlMdiSA0nMc8sUlKLRRzJ0WxNtMg=;
        b=JIClxARQUvsJEUGky1Rnk5B4mbPGDBwrv9BBo826BG1LHMruM7SHhAWu2ks/Ksoytw
         Wj82Npc6v3eZWS9Kb2s33USj5wY/lowFWBbCw/TF7//T6a5DTN//hR2jy+Pr57C/zF6M
         EFuIHT6DrZT2RGerHcRBAf/DG88HHvI8OnDDxKT5oKSMk+yiOooEX9SmVfI2XVPFh9yI
         oEi80LtyxTJQ+ROb5mlU/rUy+4mfUnDZNnaDMfXvBisEf3c2EgLm6PITsrVx5l/v8vR3
         xErHP6CEWwGTu/DJ5hRUgwK6uJOKxtlOVPocb+Zd+y83wGVgZXXF8qkCKJYBB9sjVdoJ
         VitQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxfi96cVUPKBNr94jWHDCz7cssi47k3LA7OXHRnHxQJ/cj53fJTqdu7ZB8vkZKchLyZsQLozs8CvlkbcFQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PkD8qvwPFuSq4c2YR/zGOwrNhLrU6uUAVCYStL7bj3tRviAT
	EUyNEMrAvQty/P7tKo5vblSxGIcvt7TJaOB9KWQL6S4YjvbMRNimoe1QYH3WpQyKbpvAZS2zvmf
	wKA+tMA==
X-Gm-Gg: ASbGnctm65ihheofrmsWgJiLivDCf9MWx6haetAjgs+yBJ17/N+Jiis24+dO5cKYkZ8
	ncSTE5N2+uvgW99D+G0JGz65IK6cNG8sdj8lQRP6rnsOSG1v5YAj+AR/9jyyYxWmJHvgg6UCjs6
	RDAuehVOfffyDXxK4+WQwQWVJbIaIrykA9Bh/5CZA6fn/Zl9HEU71SIQa7CdzD/iCtlL9hgl3Ms
	KGvNhFz8nhRJvTO0tRYfBXYz2Yj3pRPDNZgKB7ZfeMEQnQgeGuZPVuRRu43AZXpWflEbp+lPIjj
	AfLDcELd4rgNwRoLzNQ51nVQI0vW0KJINFS38mTWVvxJJqscItSPtNAe/EElo/BeEQ==
X-Google-Smtp-Source: AGHT+IFsGcd8XdUur1oGRfWpVj33OKSSFauUIxYHi/VqjZYd1iNYKm03QVPiCAYiz5RBAHpABBOPLw==
X-Received: by 2002:a17:907:86a8:b0:ab6:edd6:a812 with SMTP id a640c23a62f3a-ab789b3b00amr39852766b.24.1738874731557;
        Thu, 06 Feb 2025 12:45:31 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773335252sm148730166b.131.2025.02.06.12.45.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 12:45:30 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so224588866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 12:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0AVviZVrD8xq8rjla0fVhzZANpJzjok2HJm7D4CSbkRfs76BihUMF/pL2h5tjp2ohgsnk+Xjh20onGhbb@vger.kernel.org
X-Received: by 2002:a17:907:c0c:b0:ab7:5c14:d13 with SMTP id
 a640c23a62f3a-ab789ca28c4mr31209366b.53.1738874730174; Thu, 06 Feb 2025
 12:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502051546.fca7cd-lkp@intel.com>
In-Reply-To: <202502051546.fca7cd-lkp@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Feb 2025 12:45:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSncSTE_Q0as-d989L_niJ6=ViwaDoOK6gTcWHNPkp7w@mail.gmail.com>
X-Gm-Features: AWEUYZniy5QwqYp4xcLufzK5aZ9Oiqagy7E0-rznZnU-hDviaSvFAI2cC75shLY
Message-ID: <CAHk-=whSncSTE_Q0as-d989L_niJ6=ViwaDoOK6gTcWHNPkp7w@mail.gmail.com>
Subject: Re: [linus:master] [fsnotify] a94204f4d4: stress-ng.timerfd.ops_per_sec
 7.0% improvement
To: kernel test robot <oliver.sang@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 00:09, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a 7.0% improvement of stress-ng.timerfd.ops_per_sec on:

I have no idea what the heck that benchmark does, but I am happy to
see that this whole patch series did actually end up improving on the
whole fsnotify cost that I was ranting about in the original
submission.

Obviously this load doesn't actually do the new pre-event hooks, so it
seems to be all just about how fsnotify_file_area_perm() (or some
other fsnotify hook in the normal read() path) now isn't the
unconditional pig that it used to be.

I don't see how that would be worth 7%, but I'll happily take it.

              Linus

