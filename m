Return-Path: <linux-fsdevel+bounces-28000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F8965CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6E52811EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419617ADFE;
	Fri, 30 Aug 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Kw60yl9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1579171644
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009995; cv=none; b=BFbZy+u9xANcADnnQPodcMMLS45sKA4ylpM+VBiId7Mv3Kn/Yqf5WgLshpgUerTt2ZWRvVuYhV3lId2WJzN4QvAzOZV4HHWTRM9tOHg5Yx8LWC2W5tUxF+iWxZ3S5kYWxfFMJkZYEKle5vqu5z0PrNmfARUgEW4kmIZ1iG8fz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009995; c=relaxed/simple;
	bh=IqtAOAxar/Uz1QxSMGHzzEkOMyqTYXYbC477xbxRvTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5thI4iZGge2Jp0T7+bIPUFRzZ0aH/dReIvYwBoQo9D1d1zDDEkirAa4WWoMlwSD430Uv4F5/P1zyW940EVrPVGypfsjDMzkxGd2DzJFrs70TQHoAEjIXsYHOYF/p8wpZ0haVF6A0RBPhHOMK35Au0J+BhaaYMwoskyHdF16X58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Kw60yl9E; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a819488e3so265526276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725009992; x=1725614792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqtAOAxar/Uz1QxSMGHzzEkOMyqTYXYbC477xbxRvTc=;
        b=Kw60yl9EfDvmrRRIWrJ+dUH+3Ns+GHHGMfTdhftueNYxE6cbJNH5PUxQtM3mrWrerN
         S+qs6vqRSuI+TggnawK8cahrW8nYAKUDSjA6ux/CgH7zdDKNY1H+0t3ptQtrhupXOEol
         Uz4GmU4zx3aBFKItpLldnPOIVhXL+8KgW6KLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009992; x=1725614792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqtAOAxar/Uz1QxSMGHzzEkOMyqTYXYbC477xbxRvTc=;
        b=otH17GQqd+w1OWeFw9ipfEv886fDW2GFMowR7LeeXZJlPLup9VkGwjkwQfEesNHZ40
         nDaqzCSuEGte9ZZAMX6SMJAdDvcPxKhtxpJVOhk0XMDOg4I8Mp2HWbt8APkTG0ScftlO
         XqbiUhOoeveANFsSdt1GImT/PQc7tWgzkrjI91D4ECn+E+lDNWAMOOy9+LmpDj3ZeH6T
         FZ8O3SFa1UMK21pH0pgjAzkYyQ2MvBnSHKRbzaFAaoX9se8eZ232AWAGmn8S/C73YZgI
         XjmoCyoqAio1NYVTXvHVI6TAVoTwNG2ieb9d+kzJhPvHiN8ac5XrSzKy1+6imEusOSby
         4ZEQ==
X-Gm-Message-State: AOJu0Ywvajhs+ymv+8EY2LSasjrdPvbexjlU1BsSu548u15NRbA0Ebnr
	iqxuwpNC9tTo7HKf5sRcO9rC/yqCxAe5pFyENrcAXhc6pdv3iKdHlwo+v4q6jCfhH4rHUL9luRZ
	utv/2dtK35oNflWQ4F5nFcw0OehwRUhyZ0F59EVjbqRzrxt7h
X-Google-Smtp-Source: AGHT+IG0XAF3a8paDaW6oeqW4CbSjBcuECMgbkHOkyQ3KoQlimafQd3IixmPoW5ocMFZMLCuGje3/ewYXHKGm02TXwU=
X-Received: by 2002:a05:6902:1b87:b0:e13:cef0:2b7e with SMTP id
 3f1490d57ef6-e1a7a1c8b2emr1753343276.54.1725009992455; Fri, 30 Aug 2024
 02:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826211908.75190-1-joannelkoong@gmail.com>
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 11:26:20 +0200
Message-ID: <CAJfpegtNg=03zepeL0dtvUi0rwK9FYWZSBZmhoJSA0C=yKRz7w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] fuse: writeback clean up / refactoring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 23:20, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patchset contains some minor clean up / refactoring for the fuse
> writeback code.
>
> As a sanity check, I ran fio to check against crashes -
> ./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o
> source=~/fstests ~/tmp_mount
> fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0
> --size=2G --numjobs=2 --directory=/home/user/tmp_mount
>
> and (suggested by Miklos) fsx test -
> sudo HOST_OPTIONS=fuse.config ./check -fuse generic/616
> generic/616 (soak buffered fsx test) without the -U (io_uring) flag
> (verified this uses the fuse_writepages_fill path)

Applied, thanks.

Miklos

