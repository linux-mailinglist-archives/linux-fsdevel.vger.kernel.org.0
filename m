Return-Path: <linux-fsdevel+bounces-20127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55748CE934
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4391C20AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021029401;
	Fri, 24 May 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nziDWrxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAA1BF3F;
	Fri, 24 May 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571934; cv=none; b=Tovn0+jSCIpwgtYGSK2rq6fjaMudt4hlISyWkuDNh9SQKs0vYfJok7CNQeBL/icm/TjyCjCALzwcy7fwe2DH/1u//EEc18qhHJlLhI7LUe2G8H00F3AqAbyMk/ofDiPzJjDr/lAqxRWTRwo2Fm0Vduaq2Ln4X6Zc1kVo6zCgn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571934; c=relaxed/simple;
	bh=JEWTCSM3XBFavVDN9bUg0nS7Wtc0uHZpCIzdXnEp5Lg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CBUYLuUGALGzG8NAu0gZKJq3L9FnWUppuy3adt6V53Oq/m3oJqknYJ1xcn5QPBjXw1iCa1RP9uYjb/G/YCDpJw7RGbZNSEUXKouYiM4mDL+w/YQdWGQXXT0JyaLZejEkcZF1kJQVUS62iF2PUQN+Laob8ayu5Cd5zeIAYyr6qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nziDWrxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F125AC2BBFC;
	Fri, 24 May 2024 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716571933;
	bh=JEWTCSM3XBFavVDN9bUg0nS7Wtc0uHZpCIzdXnEp5Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nziDWrxfNfD1eMXTOJu+nT1tjve0RD4XhiJSvWDxO/3X2n4X1z/5AzsGZopm6RMNn
	 Bb+k6UgtxiO8OmA25GcIvKyo+WVZttIyGmD9BB95X6FaGlZvuuG6SMgRFTVqvAUwcD
	 FV1WRKTTt6SWYQ+s9E/lXuhNBkGZ8r40m3NZrtVY=
Date: Fri, 24 May 2024 10:32:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com,
 surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 0/9] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-Id: <20240524103212.382d10aed85f2e843e86febb@linux-foundation.org>
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 21:10:22 -0700 Andrii Nakryiko <andrii@kernel.org> wrote:

> Implement binary ioctl()-based interface to /proc/<pid>/maps file

Why an ioctl rather than a read() of (say) a sysfs file?

