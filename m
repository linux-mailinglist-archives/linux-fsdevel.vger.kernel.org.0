Return-Path: <linux-fsdevel+bounces-23509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20692D84B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A924A282052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BAC196434;
	Wed, 10 Jul 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LoEo1pit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC3257D;
	Wed, 10 Jul 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636356; cv=none; b=PqHzs2Dxnkpy64+wQ1fvWycxvFR3nlMIOAN7eL6W9jnyrDZpzIsjDLGCI7Xui3GHWW2h+2ZempOW0pxD9sNZzWoCChx5QSB70e0mZP4tvBvS2uXP2C0DNbxSMA1wgQKKqNTKhcDWftlQUTcXeI77yuh7jKghiZSP4PjROrXaOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636356; c=relaxed/simple;
	bh=FzjMFZltJ9TUPwCHk3O23WEmpRnSANcdGKOVYmC8wO0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GdD1s97VZ1upk38zd+WDBnndXDRrW9FpkAt6z7LUH2Vp7CELpMYDgQMXBDjensoYbo8hzeTIV4LX/1EPZjYv1Mt28vWfGaKlCiIm6NshDTsHtn3sX8ySouTh2M36h0YjQ3nGsLn5L0C0L9A8V9WzrLKchzq1f1tQi/jETZeO7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LoEo1pit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799F8C32781;
	Wed, 10 Jul 2024 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720636355;
	bh=FzjMFZltJ9TUPwCHk3O23WEmpRnSANcdGKOVYmC8wO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoEo1pitqXCNIaZ4dSlrw9peqkO5Bp/3lMH9ifnl0U0cf5k+1Vce7LiplAOU2DlO2
	 L02175PUjK/w395R+vnq0K9//HfusrOsDpBZ/sW4V4UBcqID9Wl6ubZQZwHx579NMR
	 meBN5385bsk+UkCdd9EvhngURp4wGPyPmxpYKmwE=
Date: Wed, 10 Jul 2024 11:32:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com,
 surenb@google.com, rppt@kernel.org, adobriyan@gmail.com, Andi Kleen
 <ak@linux.intel.com>
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-Id: <20240710113234.7d8fe0c61b5bebb275e1e2a6@linux-foundation.org>
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
References: <20240627170900.1672542-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 10:08:52 -0700 Andrii Nakryiko <andrii@kernel.org> wrote:

> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> applications to query VMA information more efficiently than reading *all* VMAs
> nonselectively through text-based interface of /proc/<pid>/maps file.

I haven't seen any acks or reviewed-by's for this series.  lgtm, so I
plan to move it into mm-stable later this week.

