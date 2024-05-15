Return-Path: <linux-fsdevel+bounces-19538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1C8C6A2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D91F234D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289415624D;
	Wed, 15 May 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IiIT5gZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C115531A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789145; cv=none; b=EMgw2N3jWGPPaC6oT/wlrSjf4p1Iv1FObVtdYcrQemERYTxWan1/flxTPabOy7hu2pKSuuf+wrdJhII7a/ywi/FYLS/E9EKp/xRq7Cy1SMv5l4yUw+SdfzwhRjm507OvEKMQ1IpfqnhLzlb5aMRKlJJEjdarBx7ZODmjodlBL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789145; c=relaxed/simple;
	bh=hJHrdHj0cikWqaVWvyi6gHT8PuTbJVo4o4T87OWEoW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub2PkuMTthvON8iIioFjmVqCx3k2xqfqqt3NbF1YoSYk3IZZT4MZPK8zC78DmcovCaLWPtLZ8K38PNfjuK4J6fsVtjs/WWH8N201FePfwLlr6+1O/Lxj9i/bh0bvFPZuJK6NRI9gpj597c/4j3VezwID7MAq7uRqeIJCIUFxqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IiIT5gZQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a609dd3fso256980566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715789142; x=1716393942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ehF00UkFVYae8eoKheTBkPEUp/ENYAZ+/DySjcSWU=;
        b=IiIT5gZQcqzKMHpc/5W2YcOOu4OfnKolvmspj74yxAWqNITkfbkalSasme1ro4Y04/
         XpW7WdYlyE51aHYUmCcNtloejCVXx/NJLDaWYO0Ja/fGofbf0QzrZlCp1xvk52trxioP
         sDmCwmUj60J2pm5tTtb6kow47ES9pMVF005Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789142; x=1716393942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2ehF00UkFVYae8eoKheTBkPEUp/ENYAZ+/DySjcSWU=;
        b=iJcM5k8JojgdC4KSeoDPHdCdu38/oUqXzFWdHFIhr0FQ9WQ5Z/5ySibCVZdziVr4Rn
         3+eAUwUc0yfLoWKXrygT5PRHrDH2CLFWH/P/5xfF+isZNvpsGZsPfHNZQHyFtYgEa+0i
         KXokRnNeFzw8mMCtfJHC7RWFbfROW7IaNCf0HyUcck4cuko8nwZVoiKdZGVpxNTumjCa
         Xut+not2C1YPrI/UrMWhdVTL3Ezi+Yt73K/xKrJwPoOyb9tTXZz7A1uTyAF9WbVLZzVd
         n8U4IdB1eQ0c8YEQwwnGLeKMIahMSigpruR5QxJ45fl9mlwBijJunIY2bifE6tlQdMud
         fl0w==
X-Forwarded-Encrypted: i=1; AJvYcCVUdGnQKl4I5agwlNF8/RAO1MfK920wCeNAQUQyuhA1n/0obg/XEL8h9wOPnXG4kOCvdWGNqMoWO7sDyjRjYuRZ5WFGiIEJuN96OGTOhw==
X-Gm-Message-State: AOJu0YzKjspuo/D7owGjX1+CBPme8pfH+RAbxYqxwRwW+hPvVi6N0o7B
	5j19F/k0G2lCnaPcC0ZYuQn9Eka2sXuRIpJUsIcrZEVG7/ULqeYqJ15VOWdFtd/jIf/L56g0K9m
	9PtWFng==
X-Google-Smtp-Source: AGHT+IF5XQEc2EelFtzKhAj0P3XDMncnwJkrTMeco1l26rJilVrxlsNfn94G+0oM0zELYUGFA2EOYw==
X-Received: by 2002:a17:907:720f:b0:a59:9ed5:eefc with SMTP id a640c23a62f3a-a5a2d30ba12mr1870953666b.32.1715789142241;
        Wed, 15 May 2024 09:05:42 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01797sm888460266b.176.2024.05.15.09.05.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:05:41 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59cdd185b9so270432366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 09:05:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkmUoBiGAAO9Jjb9lb9iRU/BoPOdR5e7x3Xb5j3GGKXug2ctZJhrazUeLXllfQq42yHs/Cp7qdZBHJf4E/ozAWpeMkDq6gmV8GQXn5fg==
X-Received: by 2002:a17:907:25c1:b0:a59:9eee:b1cb with SMTP id
 a640c23a62f3a-a5a2d30be86mr1715412166b.35.1715789140754; Wed, 15 May 2024
 09:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHsCLoBsCdv2TiaQB+2TUR+wm2EPkaPHxF=g9Ofki7AQ@mail.gmail.com>
 <20240515091727.22034-1-laoar.shao@gmail.com>
In-Reply-To: <20240515091727.22034-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 09:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Message-ID: <CAHk-=wgcnsjRvJ3d_Pm6HZ+0Pf_er4Zt2T04E1TSCDywECSJJQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: Yafang Shao <laoar.shao@gmail.com>, kernel test robot <oliver.sang@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	longman@redhat.com, viro@zeniv.linux.org.uk, walters@verbum.org, 
	wangkai86@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Oliver,
 is there any chance you could run this through the test robot
performance suite? The original full patch at

    https://lore.kernel.org/all/20240515091727.22034-1-laoar.shao@gmail.com/

and it would be interesting if the test robot could see if the patch
makes any difference on any other loads?

Thanks,
                     Linus

On Wed, 15 May 2024 at 02:17, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Our applications, built on Elasticsearch[0], frequently create and delete
> files. These applications operate within containers, some with a memory
> limit exceeding 100GB. Over prolonged periods, the accumulation of negative
> dentries within these containers can amount to tens of gigabytes.
>
> Upon container exit, directories are deleted. However, due to the numerous
> associated dentries, this process can be time-consuming. Our users have
> expressed frustration with this prolonged exit duration, which constitutes
> our first issue.

