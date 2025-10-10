Return-Path: <linux-fsdevel+bounces-63711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF4BCB5BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A14EE2CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7E2264D4;
	Fri, 10 Oct 2025 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nLMUr3wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437D4414;
	Fri, 10 Oct 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059910; cv=none; b=GobHxc81mLeNwztXbC/bZua3P6QnP8EWnP4pSkPO15LiP7PQrqUXZxe/GBU5Jrx/Mrqb8FZGuzQKZPGkUAO+lpiDWjhVG91mMpbEVj8s75gSQF/CWuXrpHa7ZiigpGJN/6XIkEiVPVCVIY3yzaUaoC5wjt8cjM8gMIeR1kmXZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059910; c=relaxed/simple;
	bh=+XWd4FA5IxyJuy6HfD5Hzs9uYPDiwPXhP8vldhK/Lm0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=apYWEi/m5VvHIxIRnmnWc2jZEPWMFszFqYwaqIpuRRI7shbxDI7al2wgPFAqDpSHs3MNyAA8o9OVzIKUpgIJfK51LDYOeEdV3VZt1nOuAeRxGliWd8H1CmBctWgE21YxAV2CJSLgOVNvZIHh+9wZ/ob8zfbidn4j4a4fQFDNDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nLMUr3wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1812C4CEE7;
	Fri, 10 Oct 2025 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760059906;
	bh=+XWd4FA5IxyJuy6HfD5Hzs9uYPDiwPXhP8vldhK/Lm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLMUr3wkvRpNOtigBtfd9AJDhK6ODHmyiAhqRnF2Aw8GT6tKS7vf/UTH3+wErqc/5
	 IZ2gitJ/bCB71BPQSFZ90M6KC4VGbXQOw+5nDAa3uGChJj41p6E/GquCw90OnO7Aw1
	 Kt7nqHI7M3EM8MUOaexWUU+Vevw5xG8GTNElbYeA=
Date: Thu, 9 Oct 2025 18:31:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org,
 rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
 jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
Message-Id: <20251009183145.3ed17cb0819f8b7e7fb4ec43@linux-foundation.org>
In-Reply-To: <20251010011951.2136980-2-surenb@google.com>
References: <20251010011951.2136980-1-surenb@google.com>
	<20251010011951.2136980-2-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Oct 2025 18:19:44 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Subject: [PATCH 1/8] mm: implement cleancache

Well that's confusing.  We removed cleancache 3+ years ago in 0a4ee518185e.

