Return-Path: <linux-fsdevel+bounces-21659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B490790F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FD3286F9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783FE149C4B;
	Thu, 13 Jun 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1yXkfwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91E4C6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298042; cv=none; b=iRjnwkoxoGqI/9EP7NK+3faNIFB4vsgam6u2jskAoIoCYzf4nUZptuqFF4Ck9lSGQV0Ud0HHOMJnwOHR6hGYRDio4Zbw0fFS+kotkKTEMp4gMgGVDMq3fnycs3ynQBfUZtcdT4GhMFVDEJitZXNdSkND75NKiWgkxFi3IPYaDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298042; c=relaxed/simple;
	bh=Ly4tuRHzyObqMrdCQcVHBM/dbQM2HfWbfZxG9ysL5rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxBgsOetC6KHs070J21LHFG8VOnVckZbXZFvbfFPXjwanbVPG0WkVF7LyqtGuzJzRXI0CVdf76Eas6BbxGNRsDlCMcY27yfazwZJq7UsFtltr+f23xT52CaFvlpUeHkMkpNmbJB3ov3FmmpSfEW+8rHCBnn9ijBDAjHbxevvN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1yXkfwx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso1817915e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718298038; x=1718902838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYzQevevyPFe2MJKTCzM3k91AB1OA/O0y28PpzZxNT0=;
        b=I1yXkfwxdcXoEsuf8a/7GV7027ElOzXhYb0se+uTVelxHOYaeOf++OxVmF5eoh2Bpx
         roYLqZWa6BHDSRvu0Y4cf3KBCCtUfQE0Exrn0NpXmhoK90cKhM+rPLoMv0iMbqbX6SNW
         mQnz88BYitVVR+heZtD4lCPrfAcs+lpWoJzws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298038; x=1718902838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYzQevevyPFe2MJKTCzM3k91AB1OA/O0y28PpzZxNT0=;
        b=GzLani4zmfEVZeg91GNnHzlegcJy6lTYH9u7hDK2V3/Fyt5jRdUmgU3wfGA0QfVoVN
         pstyr2myP2c0wj249uM3lxV2wp530FplxnCegbF+QZ7dE1bCv9rPwH2rJUuVgpJMbch4
         8sijxfEKcAjmaRRpkVkcmCZ1HSO2FsEIiA3jV+3YuZgswfxbOfnHu7yYvVwOm5l2YnIU
         U9XI3y4a+HImglj3cMfCvSzt89y8mmwLT+R9e8/rPpEhLM6WKNVZbTSdYQvibUSDILrN
         s2uT7rGfKjcF5zR6OPTxB2oAKAvogvyjMQDuf5CwAsz7oono6i6oI99GIQo4cLjx5/Rw
         3fxw==
X-Forwarded-Encrypted: i=1; AJvYcCWC+s/bbhGZuE3Fl5d+BXpE859JA0KJ1OFUuSEpA8pzMfn6UvvnGRMwzrsZXvjxn7tfeIHTY1yzc/aTw7fR+hAKn9TwV120NFvP+u3z3w==
X-Gm-Message-State: AOJu0Yxju21ZXqINqd3SSWJFuLm5w1wD6iQ0phc3FbyA+56M3IN6vbun
	3k/V/se1K24BBexBj36q34lK2j3Pr7XsmSLJEJXIG1lKqSl4Z7ymurKO2uhvzClYtCQaFdcjP8Y
	//AD5Hg==
X-Google-Smtp-Source: AGHT+IHRPzOXlWUkLDupNJBvE4mtc2TyYxSzy37dUUrQmaYeZb33AwUsdjQJO6f+xCb0NYnkd6B57Q==
X-Received: by 2002:a05:6512:39d1:b0:52c:8449:8f01 with SMTP id 2adb3069b0e04-52ca6e56eedmr383039e87.12.1718298038253;
        Thu, 13 Jun 2024 10:00:38 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42d25sm91881666b.174.2024.06.13.10.00.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:00:37 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f51660223so79651766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 10:00:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMyWa++IPOSg6By0Gt5wgT4yh5BERDPAe9tIdqsfpctp1aQsJnl6fiNGjZx7XXTVQ/mTlHAfStTJ1aihXkmoWM6hLqP0/8jky7mFWkbA==
X-Received: by 2002:a50:d797:0:b0:57c:60fe:96dc with SMTP id
 4fb4d7f45d1cf-57cbd68e58emr414547a12.19.1718298037280; Thu, 13 Jun 2024
 10:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p> <20240613-pumpen-durst-fdc20c301a08@brauner>
In-Reply-To: <20240613-pumpen-durst-fdc20c301a08@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 10:00:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
Message-ID: <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 06:46, Christian Brauner <brauner@kernel.org> wrote:
>
> I've picked Linus patch and your for testing into the vfs.inode.rcu branch.

Btw, if you added [patch 2/2] too, I think the exact byte counts in
the comments are a bit misleading.

The actual cacheline details will very much depend on 32-bit vs 64-bit
builds, but also on things like the slab allocator debug settings.

I think the important part is to keep the d_lockref - that is often
dirty and exclusive in the cache - away from the mostly RO parts of
the dentry that can be shared across CPU's in the cache.

So rather than talk about exact byte offsets, maybe just state that
overall rule?

              Linus

