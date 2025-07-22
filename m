Return-Path: <linux-fsdevel+bounces-55642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A619B0D1EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E61176A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F52BE7AF;
	Tue, 22 Jul 2025 06:34:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47028B3EF;
	Tue, 22 Jul 2025 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166058; cv=none; b=mBi+AULmC3UuPvhJE+Dlch0ny3kRiQ9vmgSiRKMSfV3iJFsWnW1EhhQLHijo+6rtSqYCIo7GRSy3yW5VXwldayP/AIXFzzPWqrl96Asu/gAEuJ3Z5R9dWvnqQmvuDV7rg0y1yhROZX80QBqoGFKwTvKx1fqFF2s8Di+GAzvq4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166058; c=relaxed/simple;
	bh=N/v7R+Fl7+iv6YaY5wCby2oN8ISmfSeARKg5HuG62Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOXpp1B6KM8whVmFOxdLfjCQ8rH3lB3S1UcfOUG52mBWSxah0dGtDgbqglnXL/JSgO7l8QKPH72O18X58qKfCOSzcWb2d88SCCYoC+l36h1nzXB0WUM7nTB+yk8rfc5hR7aKTwt2Ss1Qd6aRO7hQyfbyn0KlYw3HXRoPs1lCAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F5FA68C4E; Tue, 22 Jul 2025 08:34:13 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:34:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Message-ID: <20250722063411.GC15403@lst.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de> <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 11:04:42AM +0200, Thomas Weißschuh wrote:
> The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),

Overly long commit message here.

> remove it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


