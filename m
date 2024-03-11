Return-Path: <linux-fsdevel+bounces-14115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A65877CA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B02B20CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D4182C5;
	Mon, 11 Mar 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FonZ3Ej9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FE17BB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149135; cv=none; b=Ho9kUSjNgyiwbqL0FtfgSnh3WABEKl+x/iViZ8DuRaaRmL1ICNeEUZ2DVAZiw5OLDb7mdA4027w1jJFPc3FCqpyPXSrr8AoIPjeQQeBX5rDtNzS4oJ/2JdiZh6MPDaQFv0VIwT7kEnMcWa0C3+ehC93R7u6psuuge7DKQdG4D3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149135; c=relaxed/simple;
	bh=vxgDEDHmPVdKOo18wugfaNuuyfadd5F4i/1ADxrjot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+zo7JOZJkhSgyoT5NZzE4k3pTKaVPXYkN+SutynRZaUeba7uGH2yZPYZO7X5tx/126MqYZXjhK5S8mINc5ar3KzP7eLGCKsI19Y5MarU5MO961FvMWJhCtuTwZ/fbobRp2G/iFmdizx68ZVTcbwobd+4nMB1WYtpI9geN0Ngvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FonZ3Ej9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so3454395a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710149132; x=1710753932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xweGuz2EcliYTpJB5JmcOmCcUiI4LLTlw3hou6Xw2WI=;
        b=FonZ3Ej9s8aGIt9tKqwLOMWP60H2zZvc6NqcdjCwfbZIsT1jc4+WNqTrfYuLbz8aZM
         C6AeOb5Xz2NCJEBfWVOyPjpKkTTL3L4W/Grvg1aEVtbQ2T8OZm7Xviq8fQ3Dm1vjVq/2
         SYnFeG65SEG2+DCRbYm8HZ9JOLhfQK7TS46Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149132; x=1710753932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xweGuz2EcliYTpJB5JmcOmCcUiI4LLTlw3hou6Xw2WI=;
        b=iL3F3vKcuv8Fujdbz8eorn+NhZLW8yRpOmzt9AyyGyWi+YTrsS8S8G+/8FHZ1SGwap
         g5B0GreZBAUP6Rzxxb5r0vPy6vQJzfFX+OeBJV3rJuC0gyFL5xpdjv/p6uGimrc5u4Fi
         vF5BJIeM1UPWXz1GMp2epHPENE8nV5+ISn5wPKIsC8DcWHYWlGf+a8Q5xzucYtQ7qY5/
         akm9urFBKALaOBg6hKrBOq+G8kuduQ0+J/ChIqkcpA0yUeNBLDWL2fKy9yK3WvzyOtdw
         ZIavCkUU1uwH84djNWaqijRJ32g+TFK3nYd8+tJ6gZoiq3q7WmZhToyQuHbJ2/pSlEeI
         bxMA==
X-Forwarded-Encrypted: i=1; AJvYcCXI+e2ijkHs4b5Jo7vzx59EfsjS9X63cuHFMi9E7tEShX6ZMwDEM4ULIzJWNy1fdrXqmdFfNORTZSCooF/PC+avC4eq1wCHWYoqyRC4xg==
X-Gm-Message-State: AOJu0Yy4hoT+cLlvUjuftVUtkGwHKmZRklzlE45Ie8mx16wFMskQaJh/
	D69X2x82trmhd1URlomhgdBoKI3X5kkvSTsHobk41GVTZmdh12j0UU9k18YZkUyeEKYlxat6633
	/PRwCPp6CwHLqn1GAlhWzKh+31tFxKBstNdWeHQ==
X-Google-Smtp-Source: AGHT+IF6gOthfnOOrsU1+KqBXRgXtuLD8ub1hx+m+9V+CldiXPDbe759oa1uJ0qJZanpOhfos8wXec/7mMMHKefYY3Q=
X-Received: by 2002:a17:906:f215:b0:a45:b1cf:42f6 with SMTP id
 gt21-20020a170906f21500b00a45b1cf42f6mr3725666ejb.9.1710149131774; Mon, 11
 Mar 2024 02:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
In-Reply-To: <20240307160225.23841-4-lhenriques@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 10:25:20 +0100
Message-ID: <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Luis Henriques <lhenriques@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
>
> This patch fixes the usage of mount parameters that are defined as strings
> but which can be empty.  Currently, only 'lowerdir' parameter is in this
> situation for overlayfs.  But since userspace can pass it in as 'flag'
> type (when it doesn't have a value), the parsing will fail because a
> 'string' type is assumed.

I don't really get why allowing a flag value instead of an empty
string value is fixing anything.

It just makes the API more liberal, but for what gain?

Thanks,
Miklos

