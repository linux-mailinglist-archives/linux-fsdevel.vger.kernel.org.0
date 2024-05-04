Return-Path: <linux-fsdevel+bounces-18737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304298BBDBE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 20:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A301F2167C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D13839F5;
	Sat,  4 May 2024 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFtDqD/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7351E53F;
	Sat,  4 May 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847863; cv=none; b=qFCtEp3zraiUaBeB5TYZwYKooalxn3inFtV+KUiyIL3Iqym7/IamofpkISiMtnGT8xIKIPwCVd/WKUaymiNANtTPum+6NwJiWpvAE4h2zfxTNcaRsY7HowL/QhsF7mmYQKvNkEgfK8gJmcqpUMuFiu42dLR9j008GCwbt58Qd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847863; c=relaxed/simple;
	bh=CCKPc9uxQaLz8317eQ5FcrpKEIr9rcvRcGDYaxcazq8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cH2cCDgLW9Iemeb4xlGeoxtWLBxn0EzoULjNh5n4Cyy4DZgyH4n0r3sSG9kIxM0mluVShDtEZWm8RfZ3Dj0rV28eiLBnqO7OM/pL+hRxvWuDQoUSSaN/8H+Wg92RZB3s1dcH+FL1XshM/NFM2IG+yyXf3T5xz+ikRZxdB6yfagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFtDqD/c; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so97880066b.0;
        Sat, 04 May 2024 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714847860; x=1715452660; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRgv3alXdQPk4Y/isgc0ckvHHERPOtS3HnFhIlYUMXw=;
        b=kFtDqD/c0o99PhP3tttefPqX05dUAhGfdxI7RqnuGDr9ozCClTg/FoCHVbfe/iHY57
         Wue3YG76WgBui3W2H1dU7Ee/TNeUUVjll6nuplaU/cPhO6dxiXttc9Q2VMFXRyMXUkwV
         XGvAbmiRGYcGPAlTXeaMx998bP8r7SoAcnb3QGZ1gvptLW9ucEtUDLB127vjXdc2RDjl
         Wp80IBQDJAfxnD7YtXdTyCFlmI5kc4PUTFm92XGAQKxYNIJuhXST3kF+4qKOKNxev4S2
         HKwhxrgeDDBo80Y6dZdBCFGZN7l7aXgIVRMkt6DgFsdS9ebgG+H+xjVo4dKpVtlxQGxX
         ddQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714847860; x=1715452660;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRgv3alXdQPk4Y/isgc0ckvHHERPOtS3HnFhIlYUMXw=;
        b=Fg2aMva3TGIijiicJdPgj4eaecBdFVJZOCw7qWzW1WACxcsRVydt0YP0ap4cS0y6ye
         WbKCtxEne8cOWGSn/3L/TkGDqaESm9s87l3MRZwqfSzZ+3gWEY9LtVihyVQwduSsmoZ3
         0ncJ3r/ixE7sToirhhPReRhrSNETEmxGVf02l1RyyLBMTJ790mn5HaW3afzDbnVhSDvj
         bf69pQPmROgnyb9qT8bW9GwrZkauySb+Pa1UjTNIhsMFKT+9Lh8wpsET4ak89PTXriDB
         aJ///HQs7WzPpXHCsiqKjLIGm6z6LN6rNajIAa5Xmx2cFt3ndWRijFPzjYa03kRg2T9+
         xeKw==
X-Forwarded-Encrypted: i=1; AJvYcCW/rmM9vZPdj262yV+zwNOyTVaYH96965o7UQbbDNwvIiMvJhxog6VIi8fz9h8je/rRS+JIpq/WtNHJ+AbxPGrtYN0Z/+jU9Eu5NtSOwqn5eyo7eM4HxcQH3JlYElXrvzsy/QfZz/WDu0fO+w==
X-Gm-Message-State: AOJu0Ywkhk5J6mm2ZEW1EKFu3CzI3oXf/8FzlgH3vEJUVlvkdhgst1Y7
	Wa/ni9q6G2cPNq8WsZSL/bnrM2ECURzo3V09OUf83XZvWXlj9dWxax3t
X-Google-Smtp-Source: AGHT+IFVt4utreMchI4vjMgvSAuJ4oZf3YuASM18q1rs/OBWCIYVhorbuEfmjcgVDriF0QLMEEl5Uw==
X-Received: by 2002:a17:906:68d9:b0:a51:dcda:dcde with SMTP id y25-20020a17090668d900b00a51dcdadcdemr4477014ejr.70.1714847860074;
        Sat, 04 May 2024 11:37:40 -0700 (PDT)
Received: from p183 ([46.53.248.240])
        by smtp.gmail.com with ESMTPSA id x19-20020a170906135300b00a599e418208sm1566800ejb.9.2024.05.04.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 11:37:38 -0700 (PDT)
Date: Sat, 4 May 2024 21:37:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <d5380af6-2e0b-4429-9336-192105259b57@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Greg.

We've discussed this earlier.

Breaking news: /proc is slow, /sys too. Always have been.

Each /sys file is kind of fast, but there are so many files that
lookups eat all the runtime.

/proc files are bigger and thus slower. There is no way to filter
information.

If someone would post /proc today and said "it is 20-50-100" times
slower (which is true) than existing interfraces, linux-kernel would
not even laugh at him/her.

> slow in what way?

open/read/close is slow compared to equivalent not involving file
descriptors and textual processing.

> Text apis are good as everyone can handle them,

Text APIs provoke inefficient software:

Any noob can write

	for name in name_list:
	    with open(f'/sys/kernel/slab/{name}/order') as f:
	        slab_order = int(f.read().split()[0])

See the problem? It's inefficient.
No open("/sys", O_DIRECTORY|O_PATH);
No openat(sys_fd, "kernel/slab", O_DIRECTORY|O_PATH);
No openat(sys_kernel_slab, buf, O_RDONLY);

buf is allocated dynamically many times probably, it's Python after all.
buf is longer than necessary. pathname buf won't be reused for result.

.split() conses a list, only to discard everything but first element.

Internally, sysfs allocates 1 page, instead of putting 1 byte somewhere
in userspace memory. /proc too.

Lookup is done every time (I don't think sysfs caches dentries in dcache
but I may be mistaken, so lookup is even slower).

Multiply by many times monitoring daemons run this (potentially disturbing
other tasks).

> ioctls are harder for obvious reasons.

What? ioctl are hard now?

Text APIs are garbage. If it's some crap in debugfs then noone cares.
But /proc/*/maps is not in debugfs.

Specifically on /proc/*/maps:

* _very_ well written software know that unescaping needs to be done on pathname

* (deleted) and (unreachable) junk. readlink and /proc/*/maps don't have
  space for flags for unambigious deleted/unreachable status which
  doesn't eat into pathname -- whoops


> I don't understand, is this a bug in the current files?  If so, why not
> just fix that up?

open/read DO NOT accept file-specific flags, they are dumb like that.

In theory /proc/*/maps _could_ accept

	pread(fd, buf, sizeof(buf), addr);

and return data for VMA containing "addr", but it can't because "addr"
is offset in textual file. Such offset is not interesting at all.

> And again "efficient" need to be quantified.

	* roll eyes *

> Some people find text easier to handle for programmatic use :)

Some people should be barred from writing software by Programming Supreme Court
or something like that.

